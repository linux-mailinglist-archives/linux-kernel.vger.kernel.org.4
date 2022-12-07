Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C838B645B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLGNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLGNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:53:00 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2352C49080
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:53:00 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f3so16457419pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpEkJ0bh3MR0TIhv8bE6Mwy54ZQMu08Ne2UQTX2N/hE=;
        b=qkLtkNKJSxRLsFaCPQk5tbt2LCpsEHv8DA49lLjBJPERSpVlxi9SjUWxAm5l0X1/I+
         aQs0HaVIXlvF/MP8c4vrVIc1eMYbuxvo92n0YPBAbhCClcNYipG/DrIDugfM3GQ4/FqH
         LNRo/HdQDY0bZjEfzsDTEd266ZC4TTfqLxk0SFbP0JFkuDG95BImAMDFeh1exGIR8ylx
         0Gdzyj1ISigiGBPPnzkU6XAO4aKLzhQxzkYv2MimTUPvJAw4PDkj+Wy+5u3GusZJzvPf
         O+kCtRdGAv2fsCOB0otbUWCmqhS2d3eRB7XiCRmsQDBr6ZzHrL4BsHcSPzRnT9sAnCgD
         OGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpEkJ0bh3MR0TIhv8bE6Mwy54ZQMu08Ne2UQTX2N/hE=;
        b=7aKsDnkyYqwUKsYUCKB9h7XbPJPrgeXHNX3gEIDxXfGATO/xVdcb1ps2sAlzHcK5/i
         HgZstcsSsHI24L0oXd797b78w6Fn2poHxCptmFnUSVEy60KbfNSyy3DXBwR487uX/hyT
         XRNe3x74OsVZCoyIz/FIw6+esIwqmiUk1HZQg4uCieVvDhvTY2/5l0EPdTg3YCF22khc
         ar6mHIBVzsbReF7lEfI2kyVN1LcU60lqEphmgrBZfLh0Zx4lFWDv6CtEvnCJ95wYYcWc
         EqYKMr1QOGZ2EhC/K23pvF35kklb9nJhSlZqJxCIQUTQ1ucwcxrynSkTnbLMeaMDbCus
         bFMA==
X-Gm-Message-State: ANoB5pk9DcM0fqv0MN9V59aLZWG3C2dxPbZIdNXhUIbaU2LCQa1se013
        FZTQT5pPs+S8FZbeRu6WFUo=
X-Google-Smtp-Source: AA0mqf5EDLWZWClG9xuFRrRNYXw+uvSVrQ6M5TsTAXwmkvNjNj/3EZOjvlTw6dHOCd9TyVxZjv68Mg==
X-Received: by 2002:a62:b402:0:b0:56e:8f96:6b2e with SMTP id h2-20020a62b402000000b0056e8f966b2emr95180003pfn.18.1670421179549;
        Wed, 07 Dec 2022 05:52:59 -0800 (PST)
Received: from junjun.localdomain ([113.140.250.138])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b00189d979022fsm5793747plo.191.2022.12.07.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:52:59 -0800 (PST)
From:   Harry Song <jundongsong1@gmail.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, jundongsong1@gmail.com
Subject: [PATCH] irqchip/gic-v3-its: remove the shareability of ITS
Date:   Wed,  7 Dec 2022 21:52:23 +0800
Message-Id: <20221207135223.3938-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know this is a very wrong patch, but my platform
has an abnormal ITS problem caused by data consistency:
My chip does not support Cache Coherent Interconnect (CCI).
By default, ITS driver is the inner memory attribute.
gits_write_cbaser() is used to write the inner memory
attribute. But hw doesn't return the hardware's non-shareable
property,so I don't think reading GITS_CBASER and GICR_PROPBASER
here will get the real property of the current hardware: inner
or outer shareable is not supported, so I would like to know
whether ITS driver cannot be used on chips without CCI, or
what method can be used to use ITS driver on chips without CCI?

The current patch is designed to make ITS think that the current
chip has no inner or outer memory properties, and then use
its by flushing dcache.

This is the log for bug reports without patches:

[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000003460000
[    0.000000] ITS [mem 0x03440000-0x0345ffff]
[    0.000000] ITS@0x0000000003440000: allocated 8192 Devices @41850000 (indirect, esz 8, psz 64K, shr 0)
[    0.000000] ITS@0x0000000003440000: allocated 32768 Interrupt Collections @41860000 (flat, esz 2, psz 64K, shr 0)
[    0.000000] GICv3: using LPI property table @0x0000000041870000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000041880000
[    0.000000] ITS queue timeout (64 1)
[    0.000000] ITS cmd its_build_mapc_cmd failed
[    0.000000] ITS queue timeout (128 1)
[    0.000000] ITS cmd its_build_invall_cmd failed

Signed-off-by: Harry Song <jundongsong1@gmail.com>
---

I am very sorry to bother you. This problem has been bothering me for several weeks.
I am looking forward to your reply.

Thanks,
Harry

 drivers/irqchip/irq-gic-v3-its.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 973ede019..780099ce2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2359,6 +2359,11 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	its_write_baser(its, baser, val);
 	tmp = baser->val;
 
+	if (tmp & GITS_BASER_SHAREABILITY_MASK)
+		tmp &= ~GITS_BASER_SHAREABILITY_MASK;
+	else
+		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -3096,6 +3101,8 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 
+	tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
 			/*
@@ -5095,6 +5102,8 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
+	tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
-- 
2.25.1

