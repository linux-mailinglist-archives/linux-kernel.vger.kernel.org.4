Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320566F22E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbjD2EfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjD2EfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:35:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4982D7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 21:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bKr3wYG2niHqpoV2pFVL8uxWHOO4mQ21NZMP7Olit1I=; b=iNPC4REhngjEc0OQslhySER/Sk
        j1v6o1c91VKnIMMCtkFJCCd94DPHi9hSmIOY6szKGFNOnQOTCx2szcLjqUhz6gwuPbLKnKSAm5FS8
        xOxTG8O1B3DLc0CLJyNjsj+Dri9RMPmuTi7faLuxSYgptoNEQ31THz5VNXqV2Newe0f7HQm0OO7sO
        ZUU+KNEeMWmna1Rvw8ETROQgpInYlDncu4lqfRRwIxyJB5QXgCFoa6RPC7QpAor3r4vNpFsVzH+ei
        nCijojfl6zIELTEwx17ch94qYNyaWAj6n9BIbu+1q+b94d69F+YrUabMhPEV7D9ttVlhffgVmMcMI
        ldeXAPKA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pscIp-00CE8G-2X;
        Sat, 29 Apr 2023 04:35:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -next?] powerpc/fsl_uli1575: fix kconfig warnings and build errors
Date:   Fri, 28 Apr 2023 21:35:19 -0700
Message-Id: <20230429043519.19807-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither FSL_SOC_BOOKE nor PPC_86xx enables CONFIG_PCI by
default, so it may be unset in some randconfigs.
When that happens, FSL_ULI1575 may be set when it should not be
since it is a PCI driver. When it is set, there are 3 kconfig
warnings and a slew of build errors

WARNING: unmet direct dependencies detected for PCI_QUIRKS
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - FSL_PCI [=y]

WARNING: unmet direct dependencies detected for GENERIC_ISA_DMA
  Depends on [n]: ISA_DMA_API [=n]
  Selected by [y]:
  - FSL_ULI1575 [=y] && (FSL_SOC_BOOKE [=n] || PPC_86xx [=y])

WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - FSL_PCI [=y]

and 30+ build errors.

Fixes: 22fdf79171e8 ("powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -265,6 +265,7 @@ config CPM2
 config FSL_ULI1575
 	bool "ULI1575 PCIe south bridge support"
 	depends on FSL_SOC_BOOKE || PPC_86xx
+	depends on PCI
 	select FSL_PCI
 	select GENERIC_ISA_DMA
 	help
