Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF77C718558
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjEaOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjEaOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:51:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD91C5;
        Wed, 31 May 2023 07:51:43 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VCImYD001501;
        Wed, 31 May 2023 16:09:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=prF5Y1wurMLlqq34fQzZcB6OviCE9Oi8RI5OEOhQF2o=;
 b=H1CJ09HTw3sEPZlbQbJfuPTeyEJdZMM01HYE/XZTapsG+juAwIxOYfrU0N5D+y+9gWzI
 Zv/qiDGWzU7VKm73MYgncgMjLb2pPuJUUN1r6p8J+FE8CKBV/XQRc8cq8zrAAl0n2SfR
 0hAgBEKw1BTbjtKCCfQWnMkrNhMu/I/boRb1NoKOTQ5957LNe8MRUh79WVuhWq40UKsL
 yhDn4u4BncEbCjIff8EEyNHJdl7pxyAx+Xkx52o+K2F+ASr9BukeH1qNIgKWJk1ywGne
 ZiLUWAMum4OlAI1MHsdNB0b8LaGaAULO2r4NHopgGPByd9mK3ISFMsTkSqqbiFphNPY0 mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qweqe9170-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 16:09:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C14A10002A;
        Wed, 31 May 2023 16:09:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED2A524B8AE;
        Wed, 31 May 2023 16:09:48 +0200 (CEST)
Received: from localhost (10.252.16.99) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 31 May
 2023 16:09:48 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] ASoC: stm32: fix dtbs_check warnings
Date:   Wed, 31 May 2023 16:09:09 +0200
Message-ID: <20230531140912.819373-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.16.99]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtbs_check warnings in STM32MP15 DK boards Devices Trees for
STM32 I2S and Cirrus CS42L51 codec.

- Add OF graph port property in I2S and CS42L51 DT bindings.
  Fixes warnings:
  audio-controller@4000b000: Unevaluated properties are not allowed 
  ('port' was unexpected)
  cs42l51@4a: Unevaluated properties are not allowed
  ('port' was unexpected)
- Correct OF graph DAI audio format property for STM32MP15x Dkx I2S node

Olivier Moysan (3):
  ASoC: dt-bindings: stm32: document audio of graph port for i2s
  ASoC: dt-bindings: document audio of graph port for cs42l51
  ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml | 4 ++++
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml   | 4 ++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                      | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1

