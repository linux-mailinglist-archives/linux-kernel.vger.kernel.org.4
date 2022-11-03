Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592E3617637
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKCFd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCFdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:33:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27118B37
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:33:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m6so726252pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0jwfzDPpiiIA6G13h9XyMG8TS+aWs3VsgaKFJG4r/Y=;
        b=mxroxZXUMUkz4XhlkDgs8s8+7XrSh7WWJTclkV3qQTHFYNn2rr7B1rVc7FQ1vwg5rd
         aeNnyDeufwx5om4LYQWB4eKUVZgU8A1BQSFYQ2aV9ergBjzRyamSGf7rr+4IudJT50tt
         FcdfRX2xMd8Iy1p5KKi88ezGSZmzUzHdxpfAIGWws5w0Yej4kOFaki8PnHwh1PtwhBsS
         Ob3p5kbpMuqjL5VdPdOtzazOwqx4gJSiup/Lj2Y+8DC+UvJMICJsmTnQtamiMSDhJa33
         Jjfl97tazJ5vGcIPXll1dcMTjCD/02gBAxRz+HTn7Rb6TO+K7zCEGdHiAufdXzkP+ENJ
         9AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0jwfzDPpiiIA6G13h9XyMG8TS+aWs3VsgaKFJG4r/Y=;
        b=E/5s5auBMuJh7EqdQ44EBeWz9MXdc5X81dfkw/wPr4oQGZKSJmmEPFI0cwwG6KZWNO
         wfRp2spvhdE7DD88ELiXa5ASnIkU8CmSEHufhWGbXkoRTrMa/1OGzwmvgWXhEHRkqYbt
         sBDmsiNZadUVoBzgbkTcaVcrVETSpF9nzExV9JT6uQfcIQQj65/Fn5KHEQpdNmHw09Wc
         7odQUv5Lj82OlAry/WQE7HON0cJsK7Tsx2DthQEOONIPuMvgiCtxBJ+JZsvIEM66ra9b
         EwxYX91uTQA/oZ/7CtB9lVB1W2Y9DgtGHtdHeDGzBadIGaV+ymzQpboMZniz1oN45y63
         lNNg==
X-Gm-Message-State: ACrzQf0pdjFH3dpZ/8/V4J2JsjOlMzhZlIcX0j/arxLTHV8kgk4srikR
        vuvbrfXYjCap8K7SO1bz852KV7XReKYfvlOzdXYezKV5AZ0hwVRwcQ131KLx76sOp3ZM9TJtwAr
        odgGK+spVLkRAAzbzMM/lTuJYp2FAZQ228XTWnu/Pil+p5dAijAYWnOnk5Dd+LeYL0EX1JS16ud
        PHZDucFpXXTJ0jPHl1r9+lKifXO3E=
X-Google-Smtp-Source: AMsMyM5YD3Kv+bRTItC2EnabSgqHnEdgAworw+tKJ/WaqkqybiIf2VNdq72dJjo7lmn9TaCyghDjcg==
X-Received: by 2002:a63:6909:0:b0:41c:9f4f:a63c with SMTP id e9-20020a636909000000b0041c9f4fa63cmr25661260pgc.76.1667453597997;
        Wed, 02 Nov 2022 22:33:17 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-3803-1d6f-4606-a53e-f8a5-75e1.dynamic-ip6.hinet.net. [2001:b011:3803:1d6f:4606:a53e:f8a5:75e1])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090ac69100b00212d4cbcbfdsm67368pjt.22.2022.11.02.22.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 22:33:16 -0700 (PDT)
From:   Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Subject: [PATCH] KVM: arm64: Update comment of create_hyp_mappings
Date:   Thu,  3 Nov 2022 13:32:28 +0800
Message-Id: <20221103053228.961591-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HYP_PAGE_OFFSET is removed since 4.8, and the method for generating Hyp
VAs has evolved. Update the functional description of
create_hyp_mappings accordingly.

Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---
 arch/arm64/kvm/mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c9a13e487..a9ae4a3f9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -424,9 +424,10 @@ void kvm_unshare_hyp(void *from, void *to)
  * @to:		The virtual kernel end address of the range (exclusive)
  * @prot:	The protection to be applied to this range
  *
- * The same virtual address as the kernel virtual address is also used
- * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
- * physical pages.
+ * The Hyp virtual address is generated by masking the kernel VA with
+ * va_mask then inserting tag_val for the higher bits starting from
+ * tag_lsb. See kvm_compute_layout() in va_layout.c for more info.
+ * Both Hyp VA and kernel VA ranges map to the same underlying physical pages.
  */
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 {
-- 
2.34.1

