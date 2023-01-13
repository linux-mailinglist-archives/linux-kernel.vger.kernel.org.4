Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3CC669469
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjAMKjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjAMKix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:38:53 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F2777D0;
        Fri, 13 Jan 2023 02:38:21 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 2FDE1FF80B;
        Fri, 13 Jan 2023 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673606300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0nZ3w9CqerSXAQbiCUvKKTb+HHkCbI3OfzoSex6DYA=;
        b=k8iMp5ITpNaaYjkn0ArN3waHtog2m2s4fg8ogSRiClFowHzS9QYZGBGbohy6a6AFjjlRsv
        BnnOpA30G5ntc+FmlvuF1VH7GMmfv2UIE/lX8qM7uceDFFjykSFog+An2Iw+ajtLrF+Ixp
        SbsBu5pPdrhk4POs+F3jF8M1C9fpd5agNRFC+nvgH0rocywPhMx3ebng9/jw3Az/nV3RpE
        VdI+Q0PlUXJOwa3+2uOJewxH92TsGdK4IFwZrFCVOJzjvxkZRv+43hV88aLGakDL3wozY1
        oUmCAUF1DWC5iV3q3+ObsImsZtQ6o6uyyHjxrP632wquRRjJ/9IqKKOm+cxTTA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 04/10] powerpc/8xx: Use a larger CPM1 command check mask
Date:   Fri, 13 Jan 2023 11:37:53 +0100
Message-Id: <20230113103759.327698-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113103759.327698-1-herve.codina@bootlin.com>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPM1 command mask is defined for use with the standard
CPM1 command register as described in the user's manual:
  0  |1        3|4    7|8   11|12      14| 15|
  RST|    -     |OPCODE|CH_NUM|     -    |FLG|

In the QMC extension the CPM1 command register is redefined
(QMC supplement user's manuel) with the following mapping:
  0  |1        3|4    7|8           13|14| 15|
  RST|QMC OPCODE|  1110|CHANNEL_NUMBER| -|FLG|

Extend the check command mask in order to support both the
standard CH_NUM field and the QMC extension CHANNEL_NUMBER
field.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/8xx/cpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index 8ef1f4392086..6b828b9f90d9 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -100,7 +100,7 @@ int cpm_command(u32 command, u8 opcode)
 	int i, ret;
 	unsigned long flags;
 
-	if (command & 0xffffff0f)
+	if (command & 0xffffff03)
 		return -EINVAL;
 
 	spin_lock_irqsave(&cmd_lock, flags);
-- 
2.38.1

