Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F06CAD60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjC0SnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjC0SnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:15 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CFE3595;
        Mon, 27 Mar 2023 11:42:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PlhWL51N0z9sct;
        Mon, 27 Mar 2023 20:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GidGOfq73nj2BYK3me6cLaWQ10bmNeyEcvaFpNUnfVY=;
        b=UJkb1NvsK1/tEpxZ9+dPL2znb0s+gW8BicFnNQ/QzomG+im63DInjH3IBd74moSfQetcHU
        uo5nsn0WrObzlKCvLyB+EZbG2Lvo0eVqwsxsg0824biV0Cdr+rHzXfsU3/w3frvlu13v/1
        Fq6lnGg1U2iCbSk7tjWh11EWJGzz9ttrS1UoBSj97wXjKhdJO19lEHp15jughQG0YND/Zm
        hfPtUFXy1M5lVAjyhuY/LZRc4v8kFYuc74mbNMo+u8mFagDDDzW/xSbZdqB+/MojomEkM0
        gKWHAfXzObxAMMNh9FviVkOS3Mm7Dc2yasY0x+6bBZiDr62CUZHFJcA9ywoI+w==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 2/2] misc: fastrpc: use coherent pool for untranslated Compute Banks
Date:   Mon, 27 Mar 2023 20:42:04 +0200
Message-Id: <20230327184204.498032-3-me@dylanvanassche.be>
In-Reply-To: <20230327184204.498032-1-me@dylanvanassche.be>
References: <20230327184204.498032-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PlhWL51N0z9sct
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fastrpc_remote_heap_alloc to allocate from the FastRPC device
instead of the Compute Bank when the session ID is 0. This ensures
that the allocation is inside the coherent DMA pool which is already
accessible to the DSP. This is necessary to support FastRPC devices
which do not have dedicated Compute Banks such as the SLPI on the SDM845.
The latter uses an allocated CMA region instead of FastRPC Compute Banks.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index caf2ae556956..b7ddf6b90022 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -939,7 +939,10 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 	ctx->msg_sz = pkt_size;
 
-	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	if (ctx->fl->sctx->sid)
+		err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	else
+		err = fastrpc_remote_heap_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
 	if (err)
 		return err;
 
-- 
2.39.2

