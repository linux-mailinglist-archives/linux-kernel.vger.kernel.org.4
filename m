Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8530E64D748
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLOHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLOHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:32:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B02A435
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1EE78CE1B44
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD64C43396;
        Thu, 15 Dec 2022 07:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671089541;
        bh=IuVFclXBC2xjRNMPRTtq1KAZ9dbUziFQCUjGxBXpNv0=;
        h=From:To:Cc:Subject:Date:From;
        b=up1c8ix9evWyaIMVotw+FBoA3JiiMPOQLHfXEwVt3x77Nriis+Zm6svfODeRCKBN9
         7c2P5ndXAZ1jbzSJIo/s3/e6KywByC4vonLI08eGglyWEY3umhcUUsBBLXqZnyoGk5
         wGd+B+au8iNgkco3LADOjNSIkEqFGs5z0QF9M6NfQ4mokYfA4KvrSqfJz/ZipEx2WU
         ku7C83aDCGn0GmT/OQPVVNFUYC9wem9jHynrYBGH9JQ94ULEoLvWxC+svkB8+kY/Nj
         KqSkQahr89gkKfeLUq/L2qFN2LA/Kijh+jlGJ4ErSLDlgzVGYsHUMTrESTNpmsM+Dt
         t0qQZAzNpYGtQ==
From:   guoren@kernel.org
To:     palmer@dabbelt.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        iommu@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH] iommu/renesas: Support riscv compile
Date:   Thu, 15 Dec 2022 02:32:12 -0500
Message-Id: <20221215073212.1966823-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

After riscv selects ARCH_RENESAS, we need to add ARM64 || ARM
dependency here.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..746b95b9f345 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -283,6 +283,7 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
+	depends on ARM64 || ARM
 	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-- 
2.36.1

