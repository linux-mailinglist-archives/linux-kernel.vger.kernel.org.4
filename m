Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22398734D29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjFSIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFSIH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC46CE63
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f90b8acefeso11564635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162039; x=1689754039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLNlz/8+ewTofYujo4xBdn+VfsPe1NjsAkjdE+/T2lI=;
        b=ypf1LEDMiMKQ3vtBsxUpM2Y8PxdybNAYinkxMuePJ99Ic9OGoLpwS9eipx+GRUqULV
         LOh9tUmRzT1pEyg6ggA0hSFLcoSKKZLOF9Zqgs1nCe9F4HSc7EFZqEnGvj/NKWirDsIy
         F/ShUyfrVQLTKJZTagzHf2AN5e57f6Sde6wf4Pez/WhAPH/tRkw+u3LE5GzTVIgQXSc+
         LC+RZaTMUJb8nuoKZBCoeK5Wn8xJ+rT0ZQtsCbETdGUimrz9tgmGOd78K8Ne/MIqFv+i
         UnSiNLccIpKmATLuAqU5iEjEKpJz2C60Pyv5ZeN/bbzmJ1/+UElsOY/B2JgyrOl7mjsp
         d8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162039; x=1689754039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLNlz/8+ewTofYujo4xBdn+VfsPe1NjsAkjdE+/T2lI=;
        b=RysHqf/8oRjaFUn06qmv40cIVRbBL+JuBu9BKxJmNn8JqMEPO1ae6S+wHCPae0D5Un
         wb3co/2ecG3R3mRaQdX6/CvIBtoxqdoACRPEa4rJahpJUN/gXfar2g7CkriFahH/biH8
         mLzoTnhaHOsNaGYOPnAFNyqTjhVfjUMGCYmjbJBP1O20E/uIBH9dYLw1w+nJ44i8OzLk
         HCznWttFgkW5NBVlffEL77J5sMvU+C8IiGBe3ECe78A/kjD76t5q74RZX5eZT6u12dvL
         AAYj6I30dnDFs4vq4VFfC+lAvYx6nhzWXdopZhNxkzXFbilXsG6ZKm2VM6dQCHuyTZKj
         Th0Q==
X-Gm-Message-State: AC+VfDwesF6QyWSYSIOFvViUk9eUfsXGkSrr/w/5Z32benqQYwBUKv42
        uA25txtehkiHpe4wmhsoq8VDSA==
X-Google-Smtp-Source: ACHHUZ5+rQ4Jr/7RSkSN7oUvn8ytUG0TXbfTA51QLD4m0Oxun7ifu3zNrDDpJx/zy12w5PTlib4tXg==
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b083:109 with SMTP id y12-20020a1c4b0c000000b003f9b0830109mr1473995wma.33.1687162039092;
        Mon, 19 Jun 2023 01:07:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:07:13 +0200
Subject: [PATCH v5 1/6] soc: qcom: pmic_glink_altmode: handle safe mode
 when disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-1-9221cd300903@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gcoujHHWT0tH34VUiSmqNPPpiXV+hYxjsfgjgght78I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAyyb/2pY+hBP4/6WlOIiryCfUYYJxXEwcSj2Ood
 bQl8XoSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMsgAKCRB33NvayMhJ0fEGD/
 9OQAeQAMm2DUf7Z8a30TliWhmlQDZD5SLcq3KlqNYAMISV5sGpK/V+bF6BndjStX5mWz9ZCuVCp1vF
 8h1gYHLvdjeq5jxnLFpbY/i5nmMD2Z3b8Key2MhdVX/WbMGtjiziBPeas54vkfWHiH5aTkVvn4L1pB
 TjueEZXrbiVXTFiG21jV4OjbNpvu2HAdnJZ3wyw1vRSKiTrkJC/33ywMdtUGB67qagGJVs3TnS7HHb
 L3H8SjTCVDyX+M2cZxHrPNdDitJLD0I3ElctrXcg1HiXdN96s61LrM+MrOSiA9vp7D9yjVC4UvMKOB
 ZNhCbmpGQJtB3+4qvjpgrPDZcNpXRUg2ATowzoZ89/IZes96zvJ8czr8tLhDziqx//a2PaIY9Gbvn3
 j5YF+Kb9Aj+msRsDvHhCilGMRAoLBfFcw6HYRS9YoWiCBqGUjctDERB/5eoDTz2NKnOIIuB6rAbEHj
 m/kkuup3NxrdFuoyCRS5KxRPRew3xap4d6txNe2xlV1AiQcB77UmXStCiakQR178uxgJA+ncNuPj44
 ma0qszwyzzJSgp8WdOOZ9DkOzDrMmxeGXq2ED9WbNI4OEIPfYQtSQkewQ7GcbvTwyaFa0eib3scWI7
 9cqGvxtgNcKGAgofPy4N+QK/bzgwkYfzXHAldOyIGi0ObWUZnar5b2GnufZA==
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

