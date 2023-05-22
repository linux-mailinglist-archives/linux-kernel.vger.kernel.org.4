Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6076370B780
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjEVIVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEVIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:21:10 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A955BA;
        Mon, 22 May 2023 01:21:08 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id EDB4E20014;
        Mon, 22 May 2023 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684743667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfY/8yJ+Azw862bqGkzmouL5hoaQtAS7JukLHLhERIU=;
        b=PKX9WkgOCtI/v41y5mz/oaICybLUofd8JsTID+WdCi80oUwt50SxLj1GxXIIjkcWuKzQg7
        OxFSVGCWD8G9bTKz3HpMdHfgFZoWAaH/P4peD+0KIIlrqP9mAtIlqI8oJC3zk2wxoAbo/7
        ORvwUHPYcVEBR2iT4ku4h3GcEasA8ffCJUg+hqr6f/wlPLUUhnHOcvrzl3oNURKB2yQWtZ
        O/fUAlMzDBfah0CMImToWfJH0Xwam5Ft71KLEiqhm9noF1gJst4fdx0Qjfq/Ndg25by60F
        PKwK3eF/wULEC+Kqfr2OfUhUhMfCkFexeBS73bo1332R+6TxU6Sw0d04jyjZkg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
Date:   Mon, 22 May 2023 10:20:47 +0200
Message-Id: <20230522082048.21216-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522082048.21216-1-herve.codina@bootlin.com>
References: <20230522082048.21216-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to compile tsa.c and qmc.c, CONFIG_CPM must be set.

Without this dependency, the linker fails with some missing
symbols for COMPILE_TEST configurations that need QMC without
enabling CPM.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/
---
 drivers/soc/fsl/qe/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index 7268c2fbcbc1..e0d096607fef 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -36,7 +36,7 @@ config UCC
 config CPM_TSA
 	tristate "CPM TSA support"
 	depends on OF && HAS_IOMEM
-	depends on CPM1 || COMPILE_TEST
+	depends on CPM1 || (CPM && COMPILE_TEST)
 	help
 	  Freescale CPM Time Slot Assigner (TSA)
 	  controller.
@@ -47,7 +47,7 @@ config CPM_TSA
 config CPM_QMC
 	tristate "CPM QMC support"
 	depends on OF && HAS_IOMEM
-	depends on CPM1 || (FSL_SOC && COMPILE_TEST)
+	depends on CPM1 || (FSL_SOC && CPM && COMPILE_TEST)
 	depends on CPM_TSA
 	help
 	  Freescale CPM QUICC Multichannel Controller
-- 
2.40.1

