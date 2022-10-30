Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5E61279C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 06:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ3F4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 01:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ3F4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 01:56:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF01BEE
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IdgBLCidrJrh45EYACucWTq5mCeQtdhp0+C2YN+BeY0=; b=abI5nb9mD6FQMxBTLwcGEDtYXf
        e3nMsih1b6Q360ge8nvSinJvhARbz+apAXjcyRXdilGNXGZOYBM9WNG3LHEhs5VoESpHifTo18lOO
        lmnt3NIauVMHus9+jBMVSNMCZK9ZrZMdJXsy6glbf0sj9q707Ca00RxOeCCx1EvUBEHRYlYe7yoSK
        kwkLDsEwTr32cGh+DZm1wOWfEqmxHmtH5WJVNEXL4O072kU9QkmwJpAszeWJlTotv6ldL4Q/nZ7FJ
        zehHVfnwhlr3KDICdemlcCqYZR4AmAY2800GByjOJtP0UPyD/azQ57xbATkDub9dvft9Ouxky9mmp
        xKlCKTlw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op1JO-002fp1-SG; Sun, 30 Oct 2022 05:56:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: ti-sci: honor TI_SCI_PROTOCOL setting when not COMPILE_TEST
Date:   Sat, 29 Oct 2022 22:56:36 -0700
Message-Id: <20221030055636.3139-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.0
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

There is a build error when COMPILE_TEST=y, TI_SCI_PROTOCOL=m,
and RESET_TI_SCI=y:

drivers/reset/reset-ti-sci.o: in function `ti_sci_reset_probe':
reset-ti-sci.c:(.text+0x22c): undefined reference to `devm_ti_sci_get_handle'

Fix this by making RESET_TI_SCI honor the Kconfig setting of
TI_SCI_PROTOCOL when COMPILE_TEST is not set. When COMPILE_TEST is set,
TI_SCI_PROTOCOL must be disabled (=n).

Fixes: a6af504184c9 ("reset: ti-sci: Allow building under COMPILE_TEST")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/reset/Kconfig b/drivers/reset/Kconfig
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -257,7 +257,7 @@ config RESET_SUNXI
 
 config RESET_TI_SCI
 	tristate "TI System Control Interface (TI-SCI) reset driver"
-	depends on TI_SCI_PROTOCOL || COMPILE_TEST
+	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
 	help
 	  This enables the reset driver support over TI System Control Interface
 	  available on some new TI's SoCs. If you wish to use reset resources
