Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1652364F8D9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLQLc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 06:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 06:32:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEEDE0DF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 03:32:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B189B80766
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 11:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C86DC433D2;
        Sat, 17 Dec 2022 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671276740;
        bh=9iUWA/A+CuMRxm8uZErWe0BHusJgQWZZR2TZ5LDdx04=;
        h=From:To:Cc:Subject:Date:From;
        b=lE9XIniQ56dPK0FEgkTrUsIgYpVQtOsdvvMxDHtvl/PkQKiD/m7U+fi8oZGMQVCkY
         D2osl1J9KFZ8JBd8xmAgJKvC2tmSOghVnbnbJRlvSUPcoafekfm/i/MU86XF9oFskJ
         ig6+d3+3wYHRRkTBLR3gK+blESghwh9ur1qTX+KQsGMdjU8PqX3J6JQgod/LE90S0W
         TGXg4bz5HJFie8i/nM7v0SFP561Tg5Gr2rZFDewBtCYv1OBKae4chgSgRDyPMoG903
         Ci6hqWqHMi6N/SaKnIVQ+VhP1/6c5hX0FV3Fe7X6u4ZSZABJWvugE28m9+hpBQxY8f
         K+lte4dgXVYTA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p6VQP-00DGq1-OT;
        Sat, 17 Dec 2022 11:32:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MSI fixes for 6.2-rc1
Date:   Sat, 17 Dec 2022 11:32:14 +0000
Message-Id: <20221217113214.1836857-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: torvalds@linux-foundation.org, linux@roeck-us.net, mjrosato@linux.ibm.com, schnelle@linux.ibm.com, tglx@linutronix.de, peterz@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thomas tasked me with sending out a few urgent fixes after the giant
MSI rework that landed in 6.2, as both s390 and powerpc ended-up
suffering from it (they do not use the full core code infrastructure,
leading to these previously undetected issues). Details in the tag
below.

Many thanks to Guenter, Matthew and Niklas for reporting the issues.

Please pull,

	M.

The following changes since commit 84e57d292203a45c96dbcb2e6be9dd80961d981a:

  Merge tag 'exfat-for-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat (2022-12-15 18:14:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/msi-fixes-6.2-1

for you to fetch changes up to 4545c6a3d6ba71747eaa984c338ddd745e56e23f:

  powerpc/msi: Fix deassociation of MSI descriptors (2022-12-17 10:58:48 +0000)

----------------------------------------------------------------
MSI fixes for 6.2:

- Return MSI_XA_DOMAIN_SIZE as the maximum MSI index when the architecture
  does not make use of irq domains instead of returning 0, which is pretty
  limiting.

- Check for the presence of an irq domain when validating the MSI iterator,
  as s390/powerpc won't have one.

- Fix powerpc's MSI backends which fail to clear the descriptor's IRQ field
  on teardown, leading to a splat and leaked descriptors.

----------------------------------------------------------------
Marc Zyngier (2):
      genirq/msi: Check for the presence of an irq domain when validating msi_ctrl
      powerpc/msi: Fix deassociation of MSI descriptors

Thomas Gleixner (1):
      genirq/msi: Return MSI_XA_DOMAIN_SIZE as the maximum MSI index when no domain is present

 arch/powerpc/platforms/4xx/hsta_msi.c  | 1 +
 arch/powerpc/platforms/cell/axon_msi.c | 1 +
 arch/powerpc/platforms/pasemi/msi.c    | 1 +
 arch/powerpc/sysdev/fsl_msi.c          | 1 +
 arch/powerpc/sysdev/mpic_u3msi.c       | 1 +
 kernel/irq/msi.c                       | 7 ++++---
 6 files changed, 9 insertions(+), 3 deletions(-)
