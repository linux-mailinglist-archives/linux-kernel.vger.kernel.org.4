Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B476719F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjFAOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjFAOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927991B4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f611ccd06eso8915905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628429; x=1688220429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLNlz/8+ewTofYujo4xBdn+VfsPe1NjsAkjdE+/T2lI=;
        b=oYPuYY+ZnGHUb2gUzJcoqU/WPjmS9SF6H+45VfaRbK2bIEFlekPpn6jdYNW6qJoJNE
         oANuOaPHdOv+nk3u/L886PIHSphZqPFgbwZrCp1gtwwOKGSnqTf/kgGHDAiLXWmxOrUJ
         qx+PUuNU9uKTCx7HosXyK51hZJ5ILVSoSMGM9JYhlEG/rXRlwQxLGFRfBapCncKRd+Zy
         BiLJTFz+32cQHrFrP+dQGpihARRJUlugG4o6eYk7GIcChiGezXdfyVNGoDpJtNDk2U+8
         RgA2oYMll0nVs9W7utjz4Avh4MUzZzOplNSFcKbyaU6PymmVa5se/zGBfqipxprJoOi3
         AoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628429; x=1688220429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLNlz/8+ewTofYujo4xBdn+VfsPe1NjsAkjdE+/T2lI=;
        b=b8bByuJwbRGudV+z2rrfSRrPfBmm03jPD94dU+uPIf95X9TgTnj37madLAVbA8e2gf
         X2NYj+9A29vrlkwhnzEkQzwl4ONt1vSNOhDmiS7PyVZMyDgai0cIREYddE1R8AOxYUaX
         cmPYCvOwMzPF7s1crZDtjCCrfPrrLJncHphoYQMHRym2NMHAixjsotf1HUkXuwjSMhb1
         kT1RASNbQIp6R1mmKBJlY8D1tSM9kbw7POCLdfuUI/ioxE32+keMKJTPl6ceqdhCsBDk
         x1tVp3OT9djVnmpSiGcsWx9tviKaE2rw02q2IvQAxHevLRkzDetNMRY/jC/+HZFI9Val
         8oUA==
X-Gm-Message-State: AC+VfDw6zK9YhycKTJOV0LeXMafZcsoq4KawHD0LTFvRpHej5qs/Ugn+
        sYAbLISMhL2SJdexC7JhzdGyBQ==
X-Google-Smtp-Source: ACHHUZ53bB7fur2INmD7jFDFekH9sE6Ip63wOpxueHEdytfaVOlUl7/9lqGwHwjECiWr7sxyzIEdVQ==
X-Received: by 2002:a7b:cc8c:0:b0:3f6:6c0:7c9b with SMTP id p12-20020a7bcc8c000000b003f606c07c9bmr2256754wma.15.1685628428934;
        Thu, 01 Jun 2023 07:07:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 16:07:02 +0200
Subject: [PATCH RFC 2/7] soc: qcom: pmic_glink_altmode: handle safe mode
 when disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-2-d4d97b4d8bab@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gcoujHHWT0tH34VUiSmqNPPpiXV+hYxjsfgjgght78I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYHqwb2u6/0PRQUB2mxFXOdGo8Yol4BNZsHbFoJ
 GDH6Kt+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimBwAKCRB33NvayMhJ0aWxEA
 Cpk3xOJ9mvlf7QV+OPt4tMubv7GRx/KKlGwORuiPhTgCobutfQWEVHcpqXiuD4qiuXmuu2/F80SC84
 v5/72PxzisvYMoLvha8UOsEYqpEwa8GVuTs+jeYMxSB3GYK8s7pMfzBLsmzuHf0m7HtbzNrAVNwJda
 RDoVS2VpJaF5wc6gWvssTiFEAKS92OGlwlOxlOAk7s8qB10zsEgLFwSO5eLl/w6/xD3Kc4bIxJL0jN
 0vTLYdsgxpvBd1HJrlA/eo9vZqS7T0Lnsg3zh+WKE4scmI/w70JZifT03t6qtZmVCRE+JwiF00I5px
 xS5uxfrcqO6LzFnhvU9eHYhSkkLiXzaMIJdR4hEZkClfCCjppZ8LRRj8Ied0TEj4G+wOwDx729LKLI
 g5sqgPOFw/WnsLGcgFfdpxbyXT+ZTiB2ORCwaI74xZskabIrlmRKFWTgXdI9IRgLlX8cfo+UVkA0GE
 nuWJRcvGGRgJL3FqFC4tzPnMuif36+SoOmCwDpcw7K7zs8lVkE8ifpCpsU9E7EE5pblXwafWPYfGEK
 wrEF0XAqj6C26EGwwBf4OyjWUC32FgYm3EKhHUWJqUV6umP8b+Ms5VQd+zB8yKb6GuobNWs9mTiAVd
 BpeEHtnzO+GBZSR8up3QfQEvAeeCrDhtKqbCjVvLXK2i8nTgpmxhg41p1Epg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qcom SoCs, the Altmode event mode is set to 0xff when
the Type-C port is disconnected.

Handle this specific mode and translate it as the SAFE mode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index df48fbea4b68..007d308e2f15 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -173,6 +173,20 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 		dev_err(altmode->dev, "failed to switch mux to USB\n");
 }
 
+static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
+				    struct pmic_glink_altmode_port *port)
+{
+	int ret;
+
+	port->state.alt = NULL;
+	port->state.data = NULL;
+	port->state.mode = TYPEC_STATE_SAFE;
+
+	ret = typec_mux_set(port->typec_mux, &port->state);
+	if (ret)
+		dev_err(altmode->dev, "failed to switch mux to safe mode\n");
+}
+
 static void pmic_glink_altmode_worker(struct work_struct *work)
 {
 	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
@@ -180,7 +194,9 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 
 	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
 
-	if (alt_port->svid == USB_TYPEC_DP_SID)
+	if (alt_port->svid == USB_TYPEC_DP_SID && alt_port->mode == 0xff)
+		pmic_glink_altmode_safe(altmode, alt_port);
+	else if (alt_port->svid == USB_TYPEC_DP_SID)
 		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
 					     alt_port->hpd_state, alt_port->hpd_irq);
 	else

-- 
2.34.1

