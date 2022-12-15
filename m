Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617A64D90F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLOJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiLOJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:51:29 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04905E03B;
        Thu, 15 Dec 2022 01:51:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b2so50951387eja.7;
        Thu, 15 Dec 2022 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j84zMuJuK3HAp9zOgMIVL+Uq6tjz2z4EhGNGd4W418M=;
        b=PKjKRu6qWEO5muTqlD2CVwbLvq2hdoDup0XgCi6Fncx3S9fWoO5WwlCMwVNLyTBEZL
         M7EqDOFqiVKbf4vNolZfe2mBrpG6PPBvHkBcxmYCv3ePLgBjrkZZ9h308B1znZY/VGSo
         q6bf/E1PCcJEzeSOf3kbfW/Gxj+7pY0JfjydStRpX7KeMMRayi0sAwLaN4XbcUpGdMel
         +BISnAzi1N7MeHRPR7GwN3ccBy6CkcCNAPw7ydbAfa0jeQcCOdVizdKS4sBra4KymZRI
         LPKVx8X7pcaNiS9z/s+yWA8RohNOL014IAMGVsEAF5EB5feqYiJHuFGj7cuAFwyfT9bW
         FLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j84zMuJuK3HAp9zOgMIVL+Uq6tjz2z4EhGNGd4W418M=;
        b=mlZeZlp44Rf70NQm0Oit5C2wk+fndI9g1agu0Rf/YzKYwTmeCgDO2ezNG4f3mvf77/
         4KKM3Bt8jJ3E2IbNpOPhc11oVz2OyshJaw4CFm/UVj4TSRRY0o1TWIk1vovr6maaxRRq
         D1ZUwGID3DDm/jh5hoZ+BnnLlmkufREShC8MKE5PmGg3cG4iwwhdXsALaUfWWWNqwhu7
         m7PeIHv0Okrfd0/PE3X6Afk4QVhsIj/KM+QhKkdEtlnnRXv1X5hP7j1DNtsbdez6dcxx
         EDHiN0y85Q/9loYo72MgVbQHuLZgeLvr2VjYp4oJHZhH+G+8wuw+tI3Dv2Y2wvm2e2aX
         qVHQ==
X-Gm-Message-State: ANoB5pkuRS+uV1zCY/iAIvuAUpl8G+mgujFIq4IOKzSKjt4Hujik/pek
        0sGNcVwmWYLO2t0/WZArWIc=
X-Google-Smtp-Source: AA0mqf6hdAWRiJ4Wp0UpbkZFyGdwENTU38QDaYDDmMcYPZA7OTVT2XhKysyK3tJnvku7Mh5FXOeNaA==
X-Received: by 2002:a17:906:168a:b0:7c1:10b4:4742 with SMTP id s10-20020a170906168a00b007c110b44742mr21853116ejd.55.1671097886550;
        Thu, 15 Dec 2022 01:51:26 -0800 (PST)
Received: from felia.fritz.box (ipbcc1d920.dynamic.kabel-deutschland.de. [188.193.217.32])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906080900b007bfacaea851sm6787739ejd.88.2022.12.15.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:51:25 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm64: errata: refer to config ARM64_ERRATUM_2645198 to make workaround work
Date:   Thu, 15 Dec 2022 10:48:11 +0100
Message-Id: <20221215094811.23188-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 44ecda71fd8a ("arm64: errata: Workaround possible Cortex-A715
[ESR|FAR]_ELx corruption") implements a workaround for arm64 erratum
2645198. The arm64 cpucaps is called WORKAROUND_2645198; the kernel build
configuration is called ARM64_ERRATUM_2645198.

In the functions huge_ptep_modify_prot_start() and
ptep_modify_prot_start(), the code accidently refers to the non-existing
config CONFIG_ARM64_WORKAROUND_2645198. Note that the config name uses
ERRATUM, not WORKAROUND. By this accidental misreference, this condition is
always false, the branch of the workaround is not reachable and the
workaround is effectively not implemented at all.

Refer to the intended config ARM64_ERRATUM_2645198 and make the intended
workaround effectively work.

Fixes: 44ecda71fd8a ("arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 arch/arm64/mm/mmu.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index cd8d96e1fa1a..95364e8bdc19 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -562,7 +562,7 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 
 pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
 	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
 		/*
 		 * Break-before-make (BBM) is required for all user space mappings
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 12915f379c22..d77c9f56b7b4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1633,7 +1633,7 @@ early_initcall(prevent_bootmem_remove_init);
 
 pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
 	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
 		/*
 		 * Break-before-make (BBM) is required for all user space mappings
-- 
2.17.1

