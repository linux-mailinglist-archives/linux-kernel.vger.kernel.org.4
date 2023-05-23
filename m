Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917B70D820
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjEWI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjEWI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:59:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A94313E;
        Tue, 23 May 2023 01:59:11 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B3B311C000C;
        Tue, 23 May 2023 08:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684832350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfY/8yJ+Azw862bqGkzmouL5hoaQtAS7JukLHLhERIU=;
        b=XwdERH7EssnlbUs+m58TkAsn2oRyXQOf7VZcLrzW4lZWaJAvcIxV7ZfLvk84g7W/zOyWHt
        Y00z3DmLYmckKS8j+9aGAhxHRhgc8Rwvvj+34kaih0d+eTClL+Q4PalqvA2fLM58/hKNL7
        Beta149CMiYDuaen0Hd76jS1cTjYF2JS4/NKuNoOXsLdR1UVyRl/LrFHyRsO2+L0Il/48g
        tLr5Vp7J3AUZWv9q0vwVFwqkivivIOHmMT1p9S1UXQA4uFC7E1zxMdo74i6PW/nnETe4sq
        KVPOP3JYPXFJH2xwpOjMb4BZEpVvxo3vAh8oHVvGmG647F8emBr3mW3qJB8ALg==
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
Subject: [PATCH v2 1/2] soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
Date:   Tue, 23 May 2023 10:59:01 +0200
Message-Id: <20230523085902.75837-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523085902.75837-1-herve.codina@bootlin.com>
References: <20230523085902.75837-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

