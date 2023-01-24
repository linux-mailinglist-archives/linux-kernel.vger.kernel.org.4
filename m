Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F0679325
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjAXIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAXIb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:31:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4B82688
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:31:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r9so13081416wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9Z9xi4UTxKaj+2qIiteZ1vsHGIiq2RmA3CHBGm/Ijc=;
        b=cXk9zSCJehPS/3cLtcWSeyGTZPpC4fQPdptDYqWVuC0YeJRVKpmH/1Hplwr4KlYLh2
         8ptX7fsA935CbY7CoQvFwI5Wu6ZJRCZzqkV5YG3aLStRFASzQLAR7+WlwcaM6Zc9c68U
         eFvXpfVvIxFVNXGNI/p9Ceadqi0Vyl/pJvd5pzFhLJljoBOkt0S0o6r8UngOaKcg07G4
         PAHbuvQUnBaX0zJUXTdRSw1hkmFb26Us0qNARCiebVeku8qeGjjd7rirkNxq2Q81q7aK
         QWLjwCD4INLpjWKGG4KH1Qt00MpDOq+hNUyIu5hXRpxMN6gW7g7XrVposCLSh8amd47N
         Mw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9Z9xi4UTxKaj+2qIiteZ1vsHGIiq2RmA3CHBGm/Ijc=;
        b=HIspXGi4Lerco+KIcSHjcHIQVGVdWY7dz+ODH1bhTQtME8fcvcj6hOjS05bChKoe1z
         zG8XexaP+zNCtJnmYjbp3MqbTSLqnj7GGUcFpopNa/weHZg56dfIfI4Bp0ryRxEHJI3B
         os+GOrjNcU2Tj5POQWoGDjCKiBaxh5rpV/ZfIxeRfPXvF1CC9tVne8zdMWSn1k75PtUc
         tDcxEnqYF4efAhbycjzSp7+Fw6nKgNXM5trgLZM6+h5551JMsGfRN7/DWLtktCYncmXK
         bwU0Zqe4obDuVxJ3yjT+Yn0phIwLLJwkRw5Ikt5WvW3GI//R2VUaG2m39DT31Tmg68VD
         WhDw==
X-Gm-Message-State: AFqh2kpnhF7oqKcfIx2AZ9W6wo39I01vwdQMqmrnxf7hdxmTCUePetRA
        1ZCC2CsW6ctS7Xwx9YQrXUMC1w==
X-Google-Smtp-Source: AMrXdXtQieMXAkBWAxi42JWZB4VtxtqkgdhtpdjC/SK4cZnolNIVwb2oQwvJEuXZAFXbNUrwJt7VjQ==
X-Received: by 2002:a5d:6b07:0:b0:236:695b:82d4 with SMTP id v7-20020a5d6b07000000b00236695b82d4mr21887459wrw.30.1674549086005;
        Tue, 24 Jan 2023 00:31:26 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d6842000000b002be5401ef5fsm1312291wrw.39.2023.01.24.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:31:25 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 09:31:21 +0100
Subject: [PATCH v2] usb: dwc3: qcom: enable vbus override when in OTG
 dr-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v2-1-2d400e598463@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFiXz2MC/5WOQQ6CMBBFr2K6dgwtEKor72FYDGWAJtDitKCGc
 HcrN3D53uK/v4lAbCmI22kTTKsN1rsE6nwSZkDXE9g2sVCZyjOpcoh+tgbCpMsyg2UOkQknaF8
 mh6fxE/jYg5bVtSSUhW4bkZYaDAQNozND2nLLOCY5M3X2faQfdeLBhuj5czxZ5c/+F10lSCClK
 yykRiy7+2gdsr947kW97/sXSWw8WewAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With vbus override enabled when in OTG dr_mode, Host<->Peripheral
switch now works on SM8550, otherwise the DWC3 seems to be stuck
in Host mode only.

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Added Bryan's reviewed-by
- Added Fixes tag
- Link to v1: https://lore.kernel.org/r/20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org
---
 drivers/usb/dwc3/dwc3-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b0a0351d2d8b..959fc925ca7c 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -901,7 +901,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
 
 	/* enable vbus override for device mode */
-	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
+	if (qcom->mode != USB_DR_MODE_HOST)
 		dwc3_qcom_vbus_override_enable(qcom, true);
 
 	/* register extcon to override sw_vbus on Vbus change later */

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230123-topic-sm8550-upstream-dwc3-qcom-otg-81795ea148db

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

