Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A8734CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFSH64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjFSH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B04E51
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9b258f3d8so2997965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161519; x=1689753519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLNlz/8+ewTofYujo4xBdn+VfsPe1NjsAkjdE+/T2lI=;
        b=pB0+pPw6GNaxVT7QFpbj4FT2FZKJRsTvIP5KyL0jMYICJifcchN+QYyAZav5sAi60r
         xa28o7lVTZxlYYKHCtSvMlERV/GxFWRJErtdiUR8WUbjKvJteYyqfQdsmtYH9JeEjG/D
         4L82wG7JCVEP/6wXVlC6sV/iD2iPyzuxBmbCGKoYAjVVWpX2ZGgGXPHrEdUptkX8tqpm
         j/F1BQFhcNisce7e2GBLyFIj2nvqutcOh/Ts8uOWxofEq3NQ3aXvYZ6PM2n5xGiJ0UPc
         lzAl39bwNNwk/R0o/sQRjDNt6DnLwQ1eLLfjiymqubo9PFCXMoApQIyM0lO2/EFr0RCr
         snag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161519; x=1689753519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLNlz/8+ewTofYujo4xBdn+VfsPe1NjsAkjdE+/T2lI=;
        b=HVhTK/4qL4AV4dv2Abu0lNRKtqnNYu6nmiliRx6yG5mxf1/9iyGoH7TCg8uhGodEvI
         lQoPoalzynSeDrU+9q+0ukQQCfxvoUmR+P5Z6wslvZ32ZkxtuG1CpRNnrKlkpw4hFLTB
         qY6euhZTNfrv9++pJuHHEPiTW1K81q/nV6TsWQrYK0EcOK5WJFmwJCgF5TMm3nb5OPbs
         yqcqEUbnyFkOPowWE1hEck/67ABd6zM95ssq+/DQ5mx22n/jg8DJ5PxYdTNVl1m+YZtk
         tFgMZJm3ezhZzt9SPCp7o399/zXI9L+DszwZnn4C7Ul1kDcG6Pj3EVfZkRRaurBbsOA/
         BVGQ==
X-Gm-Message-State: AC+VfDzQpbOmJr3N1eXoDU8V4OCOhPM+FUqU4V3+EVJZG3qEWO3yfTsD
        +QBXV6mH4sZENzpEZgzh67y28g==
X-Google-Smtp-Source: ACHHUZ5CIUXx8i3EvKxAlDZjqaknempYyjVv4Qn4kHi7PPXyOf8lxdn1zXygT2YvjcOqZFDcSeOYkg==
X-Received: by 2002:a1c:cc07:0:b0:3f7:c92:57a0 with SMTP id h7-20020a1ccc07000000b003f70c9257a0mr7364730wmb.14.1687161519603;
        Mon, 19 Jun 2023 00:58:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm7091491wml.19.2023.06.19.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:58:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 09:58:16 +0200
Subject: [PATCH v4 1/6] soc: qcom: pmic_glink_altmode: handle safe mode
 when disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v4-1-eb2ae960b8dc@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAqr6TLw9aFwcZW7H6nEuKXj9Qj+nwt5tNVwrZbq
 nJiIIViJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAKqwAKCRB33NvayMhJ0WJVEA
 Chixi1u6NwTLKntyT0Q8vOdko8yj8f0r74AlAAGN1kGsUZRozzrLJztrLpqm7PjbB5E/1/6yEd3bvT
 K5uCI4N8Dv0MClu1HPxNTUWA/XOghgWEe2u2fbNfvfS+Wxe+4pkXDLCUTxUkwJjSLvds5ujIOvaIJ4
 2nYka6OAPnCEj3tpxVARd8L4OMxvkIj4pMhmgE2EGLd1hmWyMu/Wh7e2RWRs7LxWLwsc8YHlMH1F7X
 D0PetsuUSdsRD20aEK9itjiqbgbd3I8VxScjRsSZlJfAoyChISnvuuFtAMmBN9kpuccUwegBQ2dLs1
 QfFwVKjNHjCOFAusmma+lYthc0hQOZYRSFtIiVmmxGv5BKXr9wVim9gFIFmjlYwRJZKaa6jfLj7JIw
 VIfcqJZJ5xTIVEy7z9zFSA+iLEqiSNq3AweHS2bQz5ChE2nfqHKO7D0AONXOVKJ0qWHdOmr91v3yLa
 F9nTi3JaCYUHhQRgqEeahMQlSuRSdJK66tk2WejEH6qAIjVOnCbKtxA6tQDvsdRWeBmf9iMHF/4Gmb
 Zp68ZhpjoFajguaNKcZZmgAxHI2H3F6McM6ZAEWM3+ts7k4X1ijA1T4DajJDNgA5aS4V5loyQUgCAl
 xqiwgu10Gfn4iCABk/oQBkzJrb/FFLO+Ff6I6FKpR+UkTBQQ42FoAUrJK57A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

