Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93AC669460
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjAMKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbjAMKia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:38:30 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ADC76AF7;
        Fri, 13 Jan 2023 02:38:07 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id DDFD6FF808;
        Fri, 13 Jan 2023 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673606286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZrDoPTVMtt/nPtGEUH/c16zuug+TjuwVzIICNji49Q=;
        b=XJXZKssKn38Y38w5k0cQ+2NB8kxVenn82zuQYsDnBMaugApThAvX4ZBttyXqHgKmE97kVM
        LTJDipEWXjkLpVqy51JIgbI0hhC6PE/xk0RCf1JdBk/1I4L6mO7Z8FiPdiaIhy7yX1s8yJ
        Eq2HEVuhfhjb99kTJfsuK7ZZfhv91mTBYC1ELi//OM8me7vazndBlNM13ejvYJINg/k7+X
        lYRZ53VYA7FQ0eAgFn+vQ/TuqHuAABBNWp15KaXV7LdquooG55Xj8CH4uqzQRrPBDhFZLq
        xNxIEsoXz/RkytUY28IMJQUVz0200qxVGbxgY24tYsxidcTxMlfJ/nZ2xCZimQ==
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
Subject: [PATCH v3 00/10] Add the PowerQUICC audio support using the QMC
Date:   Fri, 13 Jan 2023 11:37:49 +0100
Message-Id: <20230113103759.327698-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for audio using the QMC controller
available in some Freescale PowerQUICC SoCs.

This series contains three parts in order to show the different
blocks hierarchy and their usage in this support.

The first one is related to TSA (Time Slot Assigner).
The TSA handles the data present at the pin level (TDM with up
to 64 time slots) and dispatchs them to one or more serial
controller (SCC).

The second is related to QMC (QUICC Multichannel Controller).
The QMC handles the data at the serial controller (SCC) level
and splits again the data to creates some virtual channels.

The last one is related to the audio component (QMC audio).
It is the glue between the QMC controller and the ASoC
component. It handles one or more QMC virtual channels and
creates one DAI per QMC virtual channels handled.

Compared to the v2 series, this v3 series mainly:
  - adds modification in the DT bindings,
  - uses generic io{read,write}be{16,32} for registers
    accesses instead of the specific PowerPC ones.
  - updates some commit subjects and logs (CPM1 SoCs supports).

Best regards,
Herve Codina

Changes v2 -> v3
  - All bindings
    Rename fsl-tsa.h to fsl,tsa.h
    Add missing vendor prefix
    Various fixes (quotes, node names, upper/lower case)

  - patches 1 and 2 (TSA binding specific)
    Remove 'reserved' values in the routing tables
    Remove fsl,grant-mode
    Add a better description for 'fsl,common-rxtx-pins'
    Fix clocks/clocks-name handling against fsl,common-rxtx-pins
    Add information related to the delays unit
    Removed FSL_CPM_TSA_NBCELL
    Fix license in binding header file fsl,tsa.h

  - patches 5 and 6 (QMC binding specific)
    Remove fsl,cpm-command property
    Add interrupt property constraint

  - patches 8 and 9 (QMC audio binding specific)
    Remove 'items' in compatible property definition
    Add missing 'dai-common.yaml' reference
    Fix the qmc_chan phandle definition

  - patch 2 and 6
    Use io{read,write}be{32,16}
    Change commit subjects and logs

  - patch 4
    Add 'Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>'

Changes v1 -> v2:
  - patch 2 and 6
    Fix kernel test robot errors

  - other patches
    No changes

Herve Codina (10):
  dt-bindings: soc: fsl: cpm_qe: Add TSA controller
  soc: fsl: cpm1: Add support for TSA
  MAINTAINERS: add the Freescale TSA controller entry
  powerpc/8xx: Use a larger CPM1 command check mask
  dt-bindings: soc: fsl: cpm_qe: Add QMC controller
  soc: fsl: cmp1: Add support for QMC
  MAINTAINERS: add the Freescale QMC controller entry
  dt-bindings: sound: Add support for QMC audio
  ASoC: fsl: Add support for QMC audio
  MAINTAINERS: add the Freescale QMC audio entry

 .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      |  164 ++
 .../bindings/soc/fsl/cpm_qe/fsl,tsa.yaml      |  260 +++
 .../bindings/sound/fsl,qmc-audio.yaml         |  117 ++
 MAINTAINERS                                   |   25 +
 arch/powerpc/platforms/8xx/cpm1.c             |    2 +-
 drivers/soc/fsl/qe/Kconfig                    |   23 +
 drivers/soc/fsl/qe/Makefile                   |    2 +
 drivers/soc/fsl/qe/qmc.c                      | 1531 +++++++++++++++++
 drivers/soc/fsl/qe/tsa.c                      |  810 +++++++++
 drivers/soc/fsl/qe/tsa.h                      |   43 +
 include/dt-bindings/soc/fsl,tsa.h             |   13 +
 include/soc/fsl/qe/qmc.h                      |   71 +
 sound/soc/fsl/Kconfig                         |    9 +
 sound/soc/fsl/Makefile                        |    2 +
 sound/soc/fsl/fsl_qmc_audio.c                 |  732 ++++++++
 15 files changed, 3803 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,tsa.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
 create mode 100644 drivers/soc/fsl/qe/qmc.c
 create mode 100644 drivers/soc/fsl/qe/tsa.c
 create mode 100644 drivers/soc/fsl/qe/tsa.h
 create mode 100644 include/dt-bindings/soc/fsl,tsa.h
 create mode 100644 include/soc/fsl/qe/qmc.h
 create mode 100644 sound/soc/fsl/fsl_qmc_audio.c

-- 
2.38.1

