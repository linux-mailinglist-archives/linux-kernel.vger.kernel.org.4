Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A2667D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjALSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjALR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:59:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE37DE1D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LNFZdqmxri5F07CGFwUu0kpG4HLKkrGeCVzSp+ij6mQ=; b=1kvyUBZ8JMIZJMC9LK+wnH4Lxb
        h6G9cn4H/Z/gEjQiqKr8ZU4zsW3xrJn0lAj2JkKJFVs9powR1npi/bv5YtY6pSUXZDZxHn50xHH1h
        jvHg2VCzDhfmesT2ksNcV/QB3fC9nNfvegVrfwEA4nDPdfCiMYgSGDNmMtZ/71UreHWEDQ9qCQ/3O
        /vcEBYVTo0drU+GhTUivRgRCaznM/RsdyRHNGbzpQ8CiHOjdn21x9rcN6ajMlWuf9EZVKiyR0U+eT
        Q6lYGvrz5GTQFwUwVtHaoSGvQFbPr8YdhqDRrGn4f4yCb7KBmztSVsUpXR7j8ca8nwUCL8GskUUbg
        /YCbZayQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG1Eg-00G06L-47; Thu, 12 Jan 2023 17:19:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Leo Li <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] soc/fsl/qe: fix usb.c build errors
Date:   Thu, 12 Jan 2023 09:19:28 -0800
Message-Id: <20230112171928.29653-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors in soc/fsl/qe/usb.c when QUICC_ENGINE is not set.
This happens when PPC_EP88XC is set, which selects CPM1 & CPM.
When CPM is set, USB_FSL_QE can be set without QUICC_ENGINE
being set. When USB_FSL_QE is set, QE_USB deafults to y, which
causes build errors when QUICC_ENGINE is not set. Making
QE_USB depend on QUICC_ENGINE prevents QE_USB from defaulting to y.

Fixes these build errors:

drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
usb.c:(.text+0x1e): undefined reference to `qe_immr'
powerpc-linux-ld: usb.c:(.text+0x2a): undefined reference to `qe_immr'
powerpc-linux-ld: usb.c:(.text+0xbc): undefined reference to `qe_setbrg'
powerpc-linux-ld: usb.c:(.text+0xca): undefined reference to `cmxgcr_lock'
powerpc-linux-ld: usb.c:(.text+0xce): undefined reference to `cmxgcr_lock'

Fixes: 5e41486c408e ("powerpc/QE: add support for QE USB clocks routing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202301101500.pillNv6R-lkp@intel.com/
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Leo Li <leoyang.li@nxp.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/soc/fsl/qe/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -39,6 +39,7 @@ config QE_TDM
 
 config QE_USB
 	bool
+	depends on QUICC_ENGINE
 	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
