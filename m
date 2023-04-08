Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC26DBBF7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjDHPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDHPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAD5CA15
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E5BA6159A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAC4C433A0;
        Sat,  8 Apr 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680968960;
        bh=mEemWPoO6YjRAd2cq8q5BNfFB0ZK/JR3s3zXfgPYvmc=;
        h=From:To:Cc:Subject:Date:From;
        b=bdOfYfYY9INn70SRx+vhmgRBHeo5fYmf9eOKJ5o3HCW+5e1XlDs984v5PVo9hMC0F
         htfdzfdsaHOM+TIJn10wlezs6deLA8L3C9S4K1yHQMBYDxAvAlyMVL3oE3Z2WkBCEg
         1mopiw/FZYtlN2U1eoYuSVyEGLz6/shDKT4bEoxkKbpxSknpdG/4QAwZNADaYLfk+S
         rvcsiUf4IN/8+JqsDfxYKuDkWajviG6/Ok0AvP/C/Rw60DuWKSg90H8NHyiflqb0ci
         HpBkDjvReHIte8WKRpx7kQrFZBVyh9EjERaG3z/dX31E6uISNRSHgNg1OSq+E+NvFF
         k6AK0TD225lqw==
Received: by pali.im (Postfix)
        id C07607B7; Sat,  8 Apr 2023 17:49:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] powerpc/fsl_uli1575: Cleanups
Date:   Sat,  8 Apr 2023 17:48:06 +0200
Message-Id: <20230408154814.10400-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains cleanups for fsl_uli1575 driver.

This patch series is prerequisity for another patch series:
"powerpc/85xx: p2020: Create one unified machine description"
https://lore.kernel.org/linuxppc-dev/20230408140122.25293-1-pali@kernel.org/t/#u

Changes in v2:
* Fixed compile error in the first patch when PCI is disabled

Christophe Leroy (1):
  powerpc/fsl_uli1575: Misc cleanup

Pali Rohár (7):
  powerpc/85xx: mpc85xx_ds: Simplify mpc85xx_exclude_device() function
  powerpc/fsl_uli1575: Simplify uli_exclude_device() usage
  powerpc/85xx: mpc85xx_ds: Move uli_init() code into its own driver
    file
  powerpc/mpc85xx: mpc85xx_rdb: Do not automatically select FSL_ULI1575
  powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
  powerpc/mpc86xx: mpc86xx_hpcn: Call uli_init() instead of explicit
    ppc_md assignment
  powerpc/fsl_uli1575: Mark uli_exclude_device() as static

 arch/powerpc/include/asm/ppc-pci.h         |  8 +++++
 arch/powerpc/platforms/85xx/Kconfig        |  1 -
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   | 39 ++--------------------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 20 ++---------
 arch/powerpc/platforms/Kconfig             |  2 +-
 arch/powerpc/platforms/fsl_uli1575.c       | 29 +++++++++++++---
 6 files changed, 38 insertions(+), 61 deletions(-)

-- 
2.20.1

