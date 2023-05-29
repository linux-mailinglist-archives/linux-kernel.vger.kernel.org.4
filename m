Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33551715256
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjE2XhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjE2XhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:37:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C85FCD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:37:06 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2563aacedccso1730048a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685403425; x=1687995425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=baisBCQdwcOD2KU8usJRfw00yVWo58O46yXkHEfqwQg=;
        b=1BVWXqdbg08i2AeV32T0lUkxp9lWZoLHH552jTCAxFVfR090dQGBi06nQIZqG7OIsF
         ekfuHSg6eBbUk/Z79MX56/efZU0bn5Y8JzQgk3JSwnCI9rIlRDVL6WJ9KCTuwnUGfY/G
         jxujFykeXR+j3J2MfjWwhgTQLDFOTitx008oqaiKrmK+va9qptqb0c+UluiZvQA/4hGx
         OWm17bSgh7xbdkNCWwK7b/jiLqVVvFevk+uDsZRXGxAOtWJeWW6y7O9Q6jBLwiun7R5t
         LmRgqQOEjuJyv3atnjymLDor+BH/FbV9l12ujQFweAldjvshvCJQ1LQFBnUDKGjG0g1E
         1b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685403425; x=1687995425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baisBCQdwcOD2KU8usJRfw00yVWo58O46yXkHEfqwQg=;
        b=L0UIaj4Z5/gLu0yTHCfHUnYsztb4AE/EkLr3ksaXrZCw0U+W+kPInYml5v057Nae6I
         eNrpgJCKocfe34DiDDFveWQ4OviiD1a8sCB8femHf6WH96Kkiu8lJdAUXK5Z6F1poVla
         Rv+G4Z3m6SDOtTbVeilBFQp2IzXDkK1iGGlBs7Mos0ICLdRIxPo9yIlcyvcd1J95K9DE
         8xpKBmnIBBo+RXJZVAt+tjXaNOB1zqX8q5EQwbVLqwJgOX8+Ot0Q5n/1px6j2wAY5baA
         Bq7VD9sLB860N3v26y1DigzYjPQ+dSuRyNX5oK6YCSBQEJlQiwTv7ikUt/FJbmCEw8fr
         X/NA==
X-Gm-Message-State: AC+VfDzIj5IjeWuy7Vg40FvmU4PgqW/xf8jMOCCwAN3cJUbSerLrnePm
        Lc77IoJbOET/NyjkBzSiJPY1jImG37s=
X-Google-Smtp-Source: ACHHUZ6qgR6y0TBgIq0o+ccP+/I4CCQM3KqQKjDbaA1DzbB5xR/AWB8DyxAQBKZO5Pxn6cxVkq0koDh4VKM=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a17:90a:e601:b0:255:dd84:865d with SMTP id
 j1-20020a17090ae60100b00255dd84865dmr117435pjy.8.1685403425478; Mon, 29 May
 2023 16:37:05 -0700 (PDT)
Date:   Mon, 29 May 2023 23:36:59 +0000
In-Reply-To: <20230529233700.3706661-1-badhri@google.com>
Mime-Version: 1.0
References: <20230529233700.3706661-1-badhri@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230529233700.3706661-2-badhri@google.com>
Subject: [PATCH v3 2/3] Revert "Revert "usb: gadget: udc: core: Prevent
 redundant calls to pullup""
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5e1617210aede9f1b91bb9819c93097b6da481f9.

The regression reported in
https://lore.kernel.org/all/ZF4bMptC3Lf2Hnee@gerhold.net/ is being
fixed in
commit 7d7863db7cc0 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing").
Hence reverting the revert.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/gadget/udc/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 583c339876ab..4641153e9706 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -703,6 +703,9 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		goto out;
 	}
 
+	if (gadget->connected)
+		goto out;
+
 	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
-- 
2.41.0.rc0.172.g3f132b7071-goog

