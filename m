Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F66E8FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjDTKSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjDTKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:17:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9359D6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so833040a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985787; x=1684577787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh0gzMHKjXIEM7BMaBHJPBXLjPSxY0yCOjmfp2sB3bs=;
        b=ZY7V2Fz3NbWwq9aEj2mVn5PnKntw3UCQb4JlfiHhYV0ddMHpN+M8YLIYbeYsE+Ffsj
         HAguHowzIfVychuICmyTnPXqrCiMPohkRBiwJ5gFErVFL2Xe0YgYfZ2mlihhIgNvguNc
         WJSMsNFB4dEITw8ED4WVadG5Cg82WotrYQZV/esEjZnrq6uR8DvqTnNdmacy7mSZlxCQ
         dRkhmaqjCEYdd+QWFyqkEGUu1o9bCaNIUC0WDAMjx/nnqTAN2Q4k+sRXaFL1FpwbKdMl
         TEgTNFQY/B73e3xmmRB2a+UxETkMTtLGmrlFCrgs70IhUoPQd7MKs9vDEzegWoAtzQjv
         ynxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985787; x=1684577787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh0gzMHKjXIEM7BMaBHJPBXLjPSxY0yCOjmfp2sB3bs=;
        b=Q3w0js2lKTlG1KS9ccYLG7GheirTVOuy1GPK2RuuLk85pEIWeqIPTKMJLF43G0WmR4
         cZPKRCLyJyytZ/t23I5iNVQlHBl9dkFWEkmPKPQbjjcTSRJYh2Cw3wT9OmcfuFlRh5r0
         G30fkNoc5Y+CXhXH3Kn/pcvYvIgoYEdS5rBoGoVOvWavdeOHTZhH5Al/3x3AMvIBTIjA
         K7sNbcCYt7B6N4ejnILKiQ+WEYMkhv/E7donZl71P6iADIxv2cR5b3593M72QsMhhT/l
         L4A6+9lSriW/SHsCRhhjhHQCPKnRZK/RglyYUTZ2wkuNl5j5hy8zhMIusuQQj2tRcU83
         jpFg==
X-Gm-Message-State: AAQBX9cBLMzXPqdBIHqRgsM6Oc6e3ROkSCPkReZtYDQPglC4KOfLRttA
        ngqLnBd4g7V2bJaD+nE6lsPydw==
X-Google-Smtp-Source: AKy350arZDGHMInHp8GuNY+Ano5ThS/SGyaLKa8v0e+z5Ka6cwm3FR2IPMhl6ymmgxoP66sw2zHKgg==
X-Received: by 2002:aa7:d547:0:b0:506:98e8:7e58 with SMTP id u7-20020aa7d547000000b0050698e87e58mr999102edr.34.1681985786794;
        Thu, 20 Apr 2023 03:16:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7c3d6000000b00506be898998sm588954edr.29.2023.04.20.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:16:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH 3/6] ASoC: codecs: wcd938x: Check for enumeration before using TX device
Date:   Thu, 20 Apr 2023 12:16:14 +0200
Message-Id: <20230420101617.142225-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD938x Soundwire codecs come as two Soundwire devices - TX
and RX - on two Soundwire buses.  In DTS they are represented as three
device nodes: Soundwire TX, Soundwire RX and the platform codec node
(binding to this driver).

Probing (and Soundwire enumeration) of all devices can happen in any
order, but only the Soundwire TX WCD938x device is used for accessing
actual WCD938x registers.  It is possible that component bind() in the
platform driver will be called too early, before the Soundwire TX device
is fully enumerated.  This might work or might not, but we cannot handle
it correctly from the codec driver.  It's job for Soundwire master to
bring up devices in correct order.  At least add some simple warning, so
such condition will not be undetected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Patrick Lai <quic_plai@quicinc.com>
---
 sound/soc/codecs/wcd938x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 212667a7249c..e8e07e120fa1 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -77,6 +77,8 @@
 #define WCD938X_MBHC_MOISTURE_RREF      R_24_KOHM
 #define WCD_MBHC_HS_V_MAX           1600
 
+#define WCD938X_ENUM_TIMEOUT_MS		500
+
 #define WCD938X_EAR_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -4425,6 +4427,15 @@ static int wcd938x_bind(struct device *dev)
 	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
 	wcd938x->sdw_priv[AIF1_CAP]->slave_irq = wcd938x->virq;
 
+	/*
+	 * Before any TX slave regmap usage, be sure the TX slave is actually
+	 * enumerated.
+	 */
+	ret = wait_for_completion_timeout(&wcd938x->tx_sdw_dev->enumeration_complete,
+					  msecs_to_jiffies(WCD938X_ENUM_TIMEOUT_MS));
+	if (!ret)
+		dev_warn(dev, "Enumeration timeout in bind, possible failures in accessing registers\n");
+
 	ret = wcd938x_set_micbias_data(wcd938x);
 	if (ret < 0) {
 		dev_err(dev, "%s: bad micbias pdata\n", __func__);
-- 
2.34.1

