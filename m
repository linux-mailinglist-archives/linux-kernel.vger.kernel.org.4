Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D716DBE22
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 02:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDIAJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDIAJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 20:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D3283E0
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 17:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC897616A7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6098C433D2;
        Sun,  9 Apr 2023 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680998961;
        bh=uPss87mCCwB35tkOQ3t+NOXUCwBMcXsp1Fbuq83NneU=;
        h=From:To:Cc:Subject:Date:From;
        b=gRc3btHeaYrh7+RF6rTXHzPPszUasLm0AXTLSiSdEdGJ0mBo7SkEFzMv3mC70pkjY
         IqPxUoaK8t3MQy3r/9hLJ4iuVgBihQNtMg4W6QLl1dPmY8vGWhRHxlr9mzCPzqyDmj
         Z9c4ft3zNTr8GGUiCtYkNj9RktJ5EPIV5mxA83b1pnkuGlG+KNRAnvo+2OXm5Oe+6Z
         iAbPq5vfwqmcDullquNv7nuwyjNC3TYwkG91tO3oc+fr44KrciTiBYmghtx30vgruq
         4xz5KWtsxPjgMrOtRD9SjghFzJHfeo9VhTSUQfcWnKhsVm5q5bk1Ngc12hYdHUJxQq
         kBvKThuGh7Xtg==
Received: by pali.im (Postfix)
        id D4D42C31; Sun,  9 Apr 2023 02:09:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] powerpc/fsl_uli1575: Cleanups
Date:   Sun,  9 Apr 2023 02:08:04 +0200
Message-Id: <20230409000812.18904-1-pali@kernel.org>
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

This patch series is prerequisite for another patch series:
"powerpc/85xx: p2020: Create one unified machine description"
https://lore.kernel.org/linuxppc-dev/20230408140122.25293-1-pali@kernel.org/t/#u

Changes in v3:
* Fixed compile error in the sixth patch when driver was explicitly
  enabled on unsupported platform

Changes in v2:
* Fixed compile error in the first patch when PCI is disabled

Christophe Leroy (1):
  powerpc/fsl_uli1575: Misc cleanup

Pali Rohár (7):
  powerpc/85xx: mpc85xx_ds: Simplify mpc85xx_exclude_device() function
  powerpc/fsl_uli1575: Simplify uli_exclude_device() usage
  powerpc/85xx: mpc85xx_ds: Move uli_init() code into its own driver
    file
  powerpc/85xx: mpc85xx_rdb: Do not automatically select FSL_ULI1575
  powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
  powerpc/86xx: mpc86xx_hpcn: Call uli_init() instead of explicit
    ppc_md assignment
  powerpc/fsl_uli1575: Mark uli_exclude_device() as static

 arch/powerpc/include/asm/ppc-pci.h         |  8 +++++
 arch/powerpc/platforms/85xx/Kconfig        |  1 -
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   | 39 ++--------------------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 20 ++---------
 arch/powerpc/platforms/Kconfig             |  4 ++-
 arch/powerpc/platforms/fsl_uli1575.c       | 29 +++++++++++++---
 6 files changed, 40 insertions(+), 61 deletions(-)

-- 
2.20.1

