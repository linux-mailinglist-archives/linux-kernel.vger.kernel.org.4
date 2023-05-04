Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836786F6FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEDQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:23:20 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E92736;
        Thu,  4 May 2023 09:23:16 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B2BF5C0007;
        Thu,  4 May 2023 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683217395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiCrz2ZRJmlknjS2A3op5qUSsF1/r0N1+dDlTFVnvnE=;
        b=ehp8Vtl2YknxMApsjQ51QluNSkt0kStbvIacHCS6HpgBi30SX0QmHASf05KUC2vQq0SQaS
        nOo0WJESWYwe/ZhBt66skVyMrslAHsB5sPpWQukCeB7HNjaejeN/EZM1Zg7ClZtGAIJVSX
        T1D055JNe3iJy108yRmGnEfkqmQ2cHV+61PxOeDtgHPpabPX1cumhMKJ0+XOs/dw26Yn1t
        aGwjc9Vke5F9P+/ka8h8DO4BoW/Gmhdpl2+1KRb5hRXmGsWdvuyEogWO7cB3P9Mhyi5p+O
        H7ofWPxyGkCguu1+hUeUb3XpXca5sh8sP9dhr9+2zpFLxr3qZjtWBAbGVqJZJw==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     philippe.schenker@toradex.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        gregkh@linuxfoundation.org, jun.li@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Date:   Thu,  4 May 2023 18:23:12 +0200
Message-Id: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philippe,

I found this thread after several hours spent in debugging why USB host is
not detecting new devices on a custom board using the iMX6ULL Colibri
SoM.

My best workaround at the moment is:

  --- a/drivers/usb/chipidea/ci_hdrc_imx.c
  +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
  @@ -56,7 +58,7 @@ static const struct ci_hdrc_imx_platform_flag imx6sx_usb_data = {
   };
 
   static const struct ci_hdrc_imx_platform_flag imx6ul_usb_data = {
  -       .flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
  +       .flags = //CI_HDRC_SUPPORTS_RUNTIME_PM |
                  CI_HDRC_TURN_VBUS_EARLY_ON |
                  CI_HDRC_DISABLE_DEVICE_STREAMING,
   };

so it's equivalent to yours, but hard-coded.

I haven't found any follow-up patches from you, so I'm wondering whether
you have made any progress on this issue.

As I see it, a quirk in the driver would make sense. What needs to be
sorted out is how to enable it from device tree.

I think a DT boolean as you propose would do, but with a name describing
the hardware aspects of it ("chipidea,vbus-detection-is-broken"?) and not
the driver behaviour.

Otherwise looking for the "toradex,colibri-imx6ul" prefix in the top-level
/compatible strings seems doable. I don't know how acceptable this is from
a driver maintainer's point of view though.

Best regards,
Luca
