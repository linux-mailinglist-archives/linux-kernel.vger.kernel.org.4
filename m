Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F27369B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFTKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFTKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:44:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013191A7;
        Tue, 20 Jun 2023 03:44:13 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KA5E4a025191;
        Tue, 20 Jun 2023 12:43:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=6ckVMdQBLD6uf0OTmHIXjelJ5Xb/M+DmDKyAJyiEvvg=;
 b=rUe8vw5eg/sL+NEruac1H8ZSt1Sd5fgSR70gQfBvw07ry3+uwonaJcOfcjhUsSYZaxTN
 GeIKRRpwCed9vSLL4XnFruISjAmmuUUQqk0C5BRMPtRkQdBJHNLADQA9E9X/09yVxsBb
 T69V/zqqyBbo+7HXhIgYeq+YShNnk+6SWg93J8cJ53utABXOZCZy9lHw7aSw1Rckjox8
 qEyrgHyDMBBlQ006iOXinpXcKBDGyupYOaT96Ln3pBHaOV+GrUKJbSrc+y3U7JkfII7B
 zgmutRl0ta+AhFmj0WD4atEscD2t6+oQIay6Pzm1T7ikRRfHzRE7fgbZuuTNewT1AxHN xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rb8k8s9wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 12:43:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3711310002A;
        Tue, 20 Jun 2023 12:43:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1985E226FDE;
        Tue, 20 Jun 2023 12:43:57 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 20 Jun
 2023 12:43:56 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH] pinctrl: stm32: set default gpio line names using pin names
Date:   Tue, 20 Jun 2023 12:43:49 +0200
Message-ID: <20230620104349.834687-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_07,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stm32_pctrl_get_desc_pin_from_gpio function to find a stm32 pin
descriptor which is matching with a gpio.
Most of the time pin number is equal to pin index in array. So the first
part of the function is useful to speed up.

And during gpio bank register, we set default gpio names with pin names.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 4b97bd00191b..eedbb9b97a65 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1275,6 +1275,28 @@ static const struct pinconf_ops stm32_pconf_ops = {
 	.pin_config_dbg_show	= stm32_pconf_dbg_show,
 };
 
+static struct stm32_desc_pin *stm32_pctrl_get_desc_pin_from_gpio(struct stm32_pinctrl *pctl,
+								 struct stm32_gpio_bank *bank,
+								 unsigned int offset)
+{
+	unsigned int stm32_pin_nb = bank->bank_nr * STM32_GPIO_PINS_PER_BANK + offset;
+	struct stm32_desc_pin *pin_desc;
+	int i;
+
+	/* With few exceptions (e.g. bank 'Z'), pin number matches with pin index in array */
+	pin_desc = pctl->pins + stm32_pin_nb;
+	if (pin_desc->pin.number == stm32_pin_nb)
+		return pin_desc;
+
+	/* Otherwise, loop all array to find the pin with the right number */
+	for (i = 0; i < pctl->npins; i++) {
+		pin_desc = pctl->pins + i;
+		if (pin_desc->pin.number == stm32_pin_nb)
+			return pin_desc;
+	}
+	return NULL;
+}
+
 static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode_handle *fwnode)
 {
 	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
@@ -1285,6 +1307,8 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	struct resource res;
 	int npins = STM32_GPIO_PINS_PER_BANK;
 	int bank_nr, err, i = 0;
+	struct stm32_desc_pin *stm32_pin;
+	char **names;
 
 	if (!IS_ERR(bank->rstc))
 		reset_control_deassert(bank->rstc);
@@ -1354,6 +1378,17 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 		}
 	}
 
+	names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
+	for (i = 0; i < npins; i++) {
+		stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
+		if (stm32_pin && stm32_pin->pin.name)
+			names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s", stm32_pin->pin.name);
+		else
+			names[i] = NULL;
+	}
+
+	bank->gpio_chip.names = (const char * const *)names;
+
 	err = gpiochip_add_data(&bank->gpio_chip, bank);
 	if (err) {
 		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
-- 
2.25.1

