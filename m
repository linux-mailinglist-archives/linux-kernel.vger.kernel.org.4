Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FDF6D0C06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjC3Q6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3Q6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:58:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B345B8E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lH22MfJIcQmsTzdoJbOcWiocllL7iIB6Gn2R5IPwbtA=; b=chSMsIYmRHyrgsJenrc6k7iulK
        vkLxxOqgENYMoMgVQdjMvd3+YmI/wtTuZwoWhojz7C/5UWFv+1oitVkJjl9TXV8SLPAu1F6Jap+1h
        NtUsnCtOHxmZPgUYdGuDSHsoKjwHcrQQ1j56AooEiKQppTvIeFoJW1ku7IZYwNVszKVqNcKPRX9aj
        FxMwGPvAffQ6rA4TLkTnuYkxW7gwhwcfHeC77OTg78cbdPtN0FbG9wLTASwJJf2428tPWaQmFCOuN
        s/xowZsTepl0+4ghPdAPaf6DGOOPZtQj27G1yXhVLsZrvGqV6w3b+novy4/82dO3dhXcKD5H1wARe
        nt4FBkmQ==;
Received: from [71.59.149.187] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phvbO-004YvS-2H;
        Thu, 30 Mar 2023 16:58:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Conor Dooley <conor@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] iommu: make IPMMU_VMSA dependencies more strict
Date:   Thu, 30 Mar 2023 09:58:17 -0700
Message-Id: <20230330165817.21920-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On riscv64, linux-next-20233030 (and for several days earlier),
there is a kconfig warning:

WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
  Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
  Selected by [y]:
  - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]

and build errors:

riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'

Add ARM || ARM64 || COMPILE_TEST dependencies to IPMMU_VMSA to prevent
these issues, i.e., so that ARCH_RENESAS on RISC-V is not allowed.

This makes the ARCH dependencies become:
	depends on (ARCH_RENESAS && (ARM || ARM64)) || COMPILE_TEST
but that can be a bit hard to read.

Fixes: 8292493c22c8 ("riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: Conor Dooley <conor@kernel.org>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iommu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -287,6 +287,7 @@ config EXYNOS_IOMMU_DEBUG
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
