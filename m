Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA26E6E96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjDRVsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjDRVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:48:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20959EFB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:47:58 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id otAtpDm3iuZFDotB6p5a64; Tue, 18 Apr 2023 23:47:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681854476;
        bh=5nFJR0h70GQR0Ko+nO0rkf5eZC65EX0faGidYQRY60g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SGJD6kpdcFG3siGXwXatSPSLgp8ejiM/DpsU0DRCShAFXF9p75I4D6Aaz2ihl6++H
         E6lzkMtgp0OsHmvBfHFDxDGsb9mZaKAYhQ+CnA7R+FHXsOSQrZoVLpabWLWqOgra31
         fSKjYs7qP7X1P8ulYsxPOdohKYUAr6CEei+GuDPN1+Jk87Yhp5ox7fGRGhW48aESB2
         UnCkTxU9mT9eiAN9Vb9HftEWxgU51GMkuYxnCME4YJveOcX1bOcaHKHrtlbR0ft7wt
         D7sQPGwr0/6w0a0knZazPO3JTDTjVLj8Bbvb7dwabaHPxa1LuGY+EMyrHfOj/YWGvU
         Sg/Yrjj49e+8Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Apr 2023 23:47:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH 2/2] KVM: arm64: Use the bitmap API to allocate bitmaps
Date:   Tue, 18 Apr 2023 23:47:38 +0200
Message-Id: <3c5043731db4d3635383e9326bc7e98e25de3288.1681854412.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <97bf2743f3a302b3066aced02218b9da60690dd3.1681854412.git.christophe.jaillet@wanadoo.fr>
References: <97bf2743f3a302b3066aced02218b9da60690dd3.1681854412.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm64/kvm/vmid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index bbf0677cfefa..7fe8ba1a2851 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -182,8 +182,7 @@ int __init kvm_arm_vmid_alloc_init(void)
 	 */
 	WARN_ON(NUM_USER_VMIDS - 1 <= num_possible_cpus());
 	atomic64_set(&vmid_generation, VMID_FIRST_VERSION);
-	vmid_map = kcalloc(BITS_TO_LONGS(NUM_USER_VMIDS),
-			   sizeof(*vmid_map), GFP_KERNEL);
+	vmid_map = bitmap_zalloc(NUM_USER_VMIDS, GFP_KERNEL);
 	if (!vmid_map)
 		return -ENOMEM;
 
@@ -192,5 +191,5 @@ int __init kvm_arm_vmid_alloc_init(void)
 
 void __init kvm_arm_vmid_alloc_free(void)
 {
-	kfree(vmid_map);
+	bitmap_free(vmid_map);
 }
-- 
2.34.1

