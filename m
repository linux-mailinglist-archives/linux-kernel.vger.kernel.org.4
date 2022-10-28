Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4361148F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJ1O2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1O1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:27:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1225132D95;
        Fri, 28 Oct 2022 07:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0FD2B82971;
        Fri, 28 Oct 2022 14:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B904BC433D6;
        Fri, 28 Oct 2022 14:27:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PFepB4YP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666967245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gD+ZFnxbIhSu4CHS6E4Tlv4ldzK84O8SYLBYJTRnbkA=;
        b=PFepB4YPb+usJ8MA6K3aAyzI+Hyn824xAIQIehgc8or1tF8P4KqYQKHWiUzzdW4CXE0wFV
        rLaYP2XnSuEx7En0n5Ii0TFjHRMhRGcoUji8nXMF1/qOS/U1mt+1QUVI0qrwYXk1A1LJh3
        dhvskCyJRA5TOArw3j1fkgSH6tVxxmM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 62688d8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 28 Oct 2022 14:27:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] sparc: sbus: treat CPU index as integer
Date:   Fri, 28 Oct 2022 16:27:15 +0200
Message-Id: <20221028142715.2021166-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a `char` to fit a CPU index is too small, and assigning -1 to it
isn't correct either, since `char` is sometimes signed and sometimes
not. In this case, it's been fine since this driver only works on sparc,
but that will soon be changing when chars become unsigned everywhere. So
instead, use a normal `int` type, which matches the `int cpu` function
argument that this is being compared against.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
DaveM - this is part of the -funsigned-char work I've been accumulating
in my unsigned-char branch. If you want to take this as a fix for 6.1,
go ahead. Otherwise, Linus asked me to keep the 6.2 unsigned-char
patches together in my branch, so I'll take this, pending your Ack.
-Jason

 drivers/sbus/char/envctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 843e830b5f87..ea914a7eaa7f 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -363,8 +363,8 @@ static int envctrl_read_cpu_info(int cpu, struct i2c_child_t *pchild,
 				 char mon_type, unsigned char *bufdata)
 {
 	unsigned char data;
-	int i;
-	char *tbl, j = -1;
+	int i, j = -1;
+	char *tbl;
 
 	/* Find the right monitor type and channel. */
 	for (i = 0; i < PCF8584_MAX_CHANNELS; i++) {
-- 
2.38.1

