Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3462ED64
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiKRGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiKRGAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:00:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFAE786DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:00:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d20so3675360plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4Wk+KzFpp8McF2mDNBn6lyFAwa5ExYeoo2v/dCLoXE=;
        b=F6o5IA2rQckRHAgrVgFVJsNGoM3dOXI/T05L8otWp8O0NUh4J5fPSDaGJp7VPnkp/2
         OTEXlejbStDWGw5Vw3VHFjA91SPh974r6KgoVy5BP7pIkGnMhcYn/Hcm8XXyLChcklDX
         Yuslm1FkyrYoG/q1m/IES0FpKMEh2aQoap3ZUskMIQ0MUZXvCtPBdKMFLa3t1upZ4i5G
         iaGoJit0pUb/g9OX5fjyVx+k3yQFbgEXmew9glBZeLVJBh4ryqUyhOS+/PtHW62Ejzl8
         kieaLjS/C1/R7a/NVlpNLlhQXM3PfNaBo/kVr1GLa57CgplAeDpIUKxaT1M6cmRxwStU
         4pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4Wk+KzFpp8McF2mDNBn6lyFAwa5ExYeoo2v/dCLoXE=;
        b=q0htru2Gqt68lSmc80TP8U5w/lFJclhX1tjATGd+8BZXu5nEBfj6wSh6L3ZsG0gD81
         7CrlVr41fPg5uifgiEPkgj5KOFIDCerzCONSaXnpKIr0INa+IsdC4RVlPihFrRcbZNEm
         HlneS/kmsPvDKjwfVWeto3tzhOg+6jfTR35PGhpTR0zrqKHuvT2HJTyDMLgPwEhkDKS7
         aJwnBV5KUfiZgzPl8o4SdjT3vvearm0tyeSl/r5xPSnTJHTgwOnEExYv+Zvwnu9GaGUJ
         t/+J6ImYiKct+O9j4I8tDj7qPQ1B6KTTlEv8gAOCRfP1LBCncamBU1740Isrr7AyTl3u
         HKOA==
X-Gm-Message-State: ANoB5pnWHIYF5yHlGrQRUySeCRMOBti2h+37vQgGV1NHe0G/urZ4fgD6
        DRhE26WmaCdehpM3jgnzN+/bgKtS+fgRWFxJ5Zg+tQXJtON3cbC+ekJwYWM/aUh3HN0wWDKziG5
        c1wqNrwEGUP68YQsSTcdYsqAsmkDKDLtAWdaFsMz5BemJesp6OmHioK3EEASbxJ03SOB1/6ilHn
        tvT0CVs4JMA6gYhOSOui46wQoKQfw=
X-Google-Smtp-Source: AA0mqf7JGkj+dhtm+n3CMsmmaicX6T43PbeSs87rwh9x5tEbgbshfwL2GcJwh/+hs46IiO5iW+Axqw==
X-Received: by 2002:a17:90a:6904:b0:208:4bfa:51e1 with SMTP id r4-20020a17090a690400b002084bfa51e1mr11873419pjj.228.1668751210234;
        Thu, 17 Nov 2022 22:00:10 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3803-1a96-3716-7fae-2678-9ea1.dynamic-ip6.hinet.net. [2001:b011:3803:1a96:3716:7fae:2678:9ea1])
        by smtp.gmail.com with ESMTPSA id h9-20020aa796c9000000b0056d98e359a5sm2169627pfq.165.2022.11.17.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:00:09 -0800 (PST)
From:   Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Subject: [PATCH v2] KVM: arm64: Update comment of create_hyp_mappings
Date:   Fri, 18 Nov 2022 13:59:37 +0800
Message-Id: <20221118055937.14605-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
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
Changes in v2:
 - Take Marc's advice

 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8f26c6569..6dda4f4bd 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -479,7 +479,7 @@ void kvm_unshare_hyp(void *from, void *to)
  * @prot:	The protection to be applied to this range
  *
  * The same virtual address as the kernel virtual address is also used
- * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
+ * in Hyp-mode mapping (modulo a random offset) to the same underlying
  * physical pages.
  */
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
-- 
2.34.1

