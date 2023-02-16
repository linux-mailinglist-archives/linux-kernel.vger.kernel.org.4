Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5786699607
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBPNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBPNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:42:53 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852DE564B0;
        Thu, 16 Feb 2023 05:42:39 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D8E9B20008;
        Thu, 16 Feb 2023 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676554958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Re6dExHLTuII9oT9hr8NYXFH5m9BbCVYzgBc6Vl4QRA=;
        b=W5Ea2Homj/n68S95eCTkqLI8o9MB23A9hRPSJnOTfis4TCTt7l0AoPk85sCxtY3P05hTnc
        9Gm647vimy6O1M+TWJEmBYCy7Cd8nwy+Wcd6tfKdC2kIkZd4X7nXrXH6Eg8OXTho7q0n5+
        VLDzxJROsz7GU+VKcrH7wlyGJKGdD6PPufThxKxiXlcTCMYtYoIe45cV1Lc1/Va2PuQL59
        i2TSIwhZcj5m3kGocyOFqzhx1Ck6XXdfkgfJiq7MGtdFAuxNWRA41X6rBb1foKMj0Kx3LD
        XpL8/WSRVa8kK8Hi1dryMEPWS6+YNvO/072q5WyrVMZr72Unsen4CmOWwUp3gA==
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
Subject: [PATCH v5 00/10] Add the PowerQUICC audio support using the QMC
Date:   Thu, 16 Feb 2023 14:42:16 +0100
Message-Id: <20230216134226.1692107-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
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

This series adds support for audio using the QMC controller available in
some Freescale PowerQUICC SoCs.

This series contains three parts in order to show the different blocks
hierarchy and their usage in this support.

The first one is related to TSA (Time Slot Assigner).
The TSA handles the data present at the pin level (TDM with up to 64
time slots) and dispatchs them to one or more serial controller (SCC).

The second is related to QMC (QUICC Multichannel Controller).
The QMC handles the data at the serial controller (SCC) level and splits
again the data to creates some virtual channels.

The last one is related to the audio component (QMC audio).
It is the glue between the QMC controller and the ASoC component. It
handles one or more QMC virtual channels and creates one DAI per QMC
virtual channels handled.

Compared to the previous iteration
  https://lore.kernel.org/linux-kernel/20230126083222.374243-1-herve.codina@bootlin.com/
this v5 series mainly:
  - fixes bindings,
  - removes one left out_8() specific ppc call (missed in v3),
  - changes 'depends-on' in case of COMPILE_TEST.

Best regards,
Herve Codina

Changes v4 -> v5
  - patch 1
    Rename fsl,tsa.yaml to fsl,cpm1-tsa.yaml
    Rename #serial-cells to #fsl,serial-cells and add a description
    Fix typos
    Remove examples present in description
    Use a pattern property for fsl,[rt]x-ts-routes

  - patch 2
    Remove one left out_8() ppc specific function call
    Remove the no more needed PPC dependency in case of COMPILE_TEST

  - patch 4
    Add 'Acked-by: Michael Ellerman <mpe@ellerman.id.au>'

  - patch 5
    Rename fsl,qmc.yaml to fsl,cpm1-scc-qmc.yaml
    Rename #chan-cells to #fsl,chan-cells and add a description

  - patch 6
    Add the SOC_FSL dependency in case of COMPILE_TEST (issue raised by
    the kernel test robot).
    Fix a typo in commit log
    Add 'Acked-by: Li Yang <leoyang.li@nxp.com>'

Changes v3 -> v4
  - patches 2, 6 and 9
    Update code comment format.

  - patch 1
    Fix some description formats.
    Add 'additionalProperties: false' in subnode.
    Move fsl,mode to fsl,diagnostic-mode.
    Change clocks and clock-names properties.
    Add '#serial-cells' property related to the newly introduced
    fsl,tsa-serial phandle.

  - patch 2
    Move fsl,mode to fsl,diagnostic-mode.
    Replace the	fsl,tsa phandle and the	fsl,tsa-cell-id	property by a
    fsl,tsa-serial phandle and update the related API.
    Add missing locks.

  - patch 5
    Fix some description format.
    Replace the fsl,tsa phandle and the fsl,tsa-cell-id property by a
    fsl,tsa-serial phandle.
    Rename fsl,mode to fsl,operational-mode and update its description.

  - patch 6
    Replace the	fsl,tsa phandle and the	fsl,tsa-cell-id	property by a
    fsl,tsa-serial phandle and use the TSA updated API.
    Rename fsl,mode to fsl,operational-mode.

  - patch 8
    Add 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'

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
  soc: fsl: cpm1: Add support for QMC
  MAINTAINERS: add the Freescale QMC controller entry
  dt-bindings: sound: Add support for QMC audio
  ASoC: fsl: Add support for QMC audio
  MAINTAINERS: add the Freescale QMC audio entry

 .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      |  172 ++
 .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml |  234 +++
 .../bindings/sound/fsl,qmc-audio.yaml         |  117 ++
 MAINTAINERS                                   |   25 +
 arch/powerpc/platforms/8xx/cpm1.c             |    2 +-
 drivers/soc/fsl/qe/Kconfig                    |   23 +
 drivers/soc/fsl/qe/Makefile                   |    2 +
 drivers/soc/fsl/qe/qmc.c                      | 1533 +++++++++++++++++
 drivers/soc/fsl/qe/tsa.c                      |  869 ++++++++++
 drivers/soc/fsl/qe/tsa.h                      |   42 +
 include/dt-bindings/soc/fsl,tsa.h             |   13 +
 include/soc/fsl/qe/qmc.h                      |   71 +
 sound/soc/fsl/Kconfig                         |    9 +
 sound/soc/fsl/Makefile                        |    2 +
 sound/soc/fsl/fsl_qmc_audio.c                 |  735 ++++++++
 15 files changed, 3848 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
 create mode 100644 drivers/soc/fsl/qe/qmc.c
 create mode 100644 drivers/soc/fsl/qe/tsa.c
 create mode 100644 drivers/soc/fsl/qe/tsa.h
 create mode 100644 include/dt-bindings/soc/fsl,tsa.h
 create mode 100644 include/soc/fsl/qe/qmc.h
 create mode 100644 sound/soc/fsl/fsl_qmc_audio.c

-- 
2.39.1

