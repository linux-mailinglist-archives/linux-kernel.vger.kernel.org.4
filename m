Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6070B1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjEUWvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjEUWvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:51:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD59BA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 15:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9Xg26FQraBSMG0MMhYiyu1iEgUv/WTNcURfydXNCXls=; b=er+YPaELPWlGuad6wTFYsecX8Z
        QBJz2NjluoMfBU6qJYrXY8RJyc9xdFKuxRIXnxHAUlLDHPuJfG27PKrxlFc7pG7YIooFKefhbq6oY
        HYrdn+FSmb9aaCU2EvDhvSTH1EN3ZsfXpGcAKQ296tFWdRNDPzShzzfRPPszFBqQmPjc3xFCO/XUt
        e3obSLcE28vJSAzamSjLrBPoXBkHedq1HxsKfdNJ9jnd1yWyLHAeUu81bk+YQrPzpiXXHGTVZJcMF
        iAD2M6ZFCVnKgAkCh19H8jtNHl2eUFDnSELAF+PxjIxcy4wtkm4nLjguELFlQG5u0+/+HzoY7XjhA
        eKCG3ISA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0rtI-004nEw-1c;
        Sun, 21 May 2023 22:51:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 RESEND] powerpc/embedded6xx: select MPC10X_BRIDGE only if PCI is set
Date:   Sun, 21 May 2023 15:51:03 -0700
Message-Id: <20230521225103.19197-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SMP is not set, CONFIG_BROKEN_ON_SMP is set, and
CONFIG_PCI is not set, there can be a kconfig warning:

WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - MPC10X_BRIDGE [=y]

To fix that, make the selects of MPC10X_BRIDGE be conditional
on PCI and use "imply" instead of "select".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Michael Ellerman <mpe@ellerman.id.au> # use "imply"
---
v2: use imply instead of select (mpe)

 arch/powerpc/platforms/embedded6xx/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -10,7 +10,7 @@ config LINKSTATION
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
 	select DEFAULT_UIMAGE
-	select MPC10X_BRIDGE
+	imply MPC10X_BRIDGE if PCI
 	help
 	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
 	  based NAS systems from Buffalo Technology. So far only
@@ -24,7 +24,7 @@ config STORCENTER
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
-	select MPC10X_BRIDGE
+	imply MPC10X_BRIDGE if PCI
 	help
 	  Select STORCENTER if configuring for the iomega StorCenter
 	  with an 8241 CPU in it.
