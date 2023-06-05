Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A25722FE1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFEThl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjFEThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F65ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685993812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZdsOmjyrs4jhLmzcDuk5dNVYdME54p2VYx1Wgg2u6KQ=;
        b=chuO3czuD5nv18GJqDYfGIzPKOcVrMSvHyydmU5JxNR++kjYaXc9N7nuYe23k9mykgoeiy
        JZUF6fA9nh049tMiT68dKwXEstbDaPADmhpeZsMFOepCXnl/mefG9pZYdLjxX74HBeu2W2
        l4Z/08dyPqlrFYRtaKxBCd8k0eCcTnk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160--EGLuiAxMtuTYcas8vPKpw-1; Mon, 05 Jun 2023 15:36:51 -0400
X-MC-Unique: -EGLuiAxMtuTYcas8vPKpw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-395fd55e523so2723593b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993810; x=1688585810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdsOmjyrs4jhLmzcDuk5dNVYdME54p2VYx1Wgg2u6KQ=;
        b=Qpxr955N4DN199Vvjkzxy3s9H3STEzHGT5w4gEVzQIXX47TX5nZcMUohac7YPKjQ4J
         JIpaZzJAGa95Y9iFf/KKyhA6TWnT7ZZWPN5JuHNaPHzWgFflNCDz4VqiE8awL0INADrS
         XWK4C2/5SxirwudvjM0W3byXtkDJQymgy0s4BC0s2vfFqx/uimGmhY3mNI++uuhIhuj8
         x446XT68yeNgbEj8rc9vwPLqgUQtmYQHUgFzAmqVMxMPKOVwGU8DoEJg1dFmhdaK4VBd
         AypT2HhsQPr+Q1lnEcxsyFz+o0kvIWw9b1YZJLEp4TTmInUioj/1pOaPyPsk5L1aJBSU
         psCw==
X-Gm-Message-State: AC+VfDyfiDi7TxyChvlTCc/yZDEWCkCjVkyCK54nf2Lv6w0W9fKKHFxz
        +WOyQGmfX97NFZH3M6IQeZeNtMBz9NONa+rBeZ2ZONTa7g9F10no8yZlb497qsr4FwMxGuOuYoO
        47cYOSKHTT6S0KCfMPI+lxEJeOvXTeji9l/XjRn4Uloxn2rpoc2MNU2gLywzp05ujaUWLziGtCS
        DwfxuccnCe
X-Received: by 2002:a05:6808:8d6:b0:397:f1b3:f940 with SMTP id k22-20020a05680808d600b00397f1b3f940mr4970759oij.27.1685993810662;
        Mon, 05 Jun 2023 12:36:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ueGspllETv0SMUfDs8YpvS0EZ7IsQ8bkSRSjyjFbUOUQArdfQ8luljWDBTynlY93U2iggSQ==
X-Received: by 2002:a05:6808:8d6:b0:397:f1b3:f940 with SMTP id k22-20020a05680808d600b00397f1b3f940mr4970736oij.27.1685993810364;
        Mon, 05 Jun 2023 12:36:50 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id x62-20020acae041000000b00397f453aae6sm3836667oig.38.2023.06.05.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:36:49 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, konrad.dybcio@linaro.org,
        andersson@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] usb: dwc3: qcom: use dev_err_probe() where appropriate
Date:   Mon,  5 Jun 2023 14:36:25 -0500
Message-Id: <20230605193625.63187-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to using dev_err_probe() throughout to reduce spam and log useful
information in devices_deferred.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 822735814050..a1f3d95c0832 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -167,7 +167,8 @@ static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
 
 	qcom->edev = extcon_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(qcom->edev))
-		return PTR_ERR(qcom->edev);
+		return dev_err_probe(dev, PTR_ERR(qcom->edev),
+				     "Failed to get extcon\n");
 
 	qcom->vbus_nb.notifier_call = dwc3_qcom_vbus_notifier;
 
@@ -252,16 +253,14 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 
 	qcom->icc_path_ddr = of_icc_get(dev, "usb-ddr");
 	if (IS_ERR(qcom->icc_path_ddr)) {
-		dev_err(dev, "failed to get usb-ddr path: %ld\n",
-				PTR_ERR(qcom->icc_path_ddr));
-		return PTR_ERR(qcom->icc_path_ddr);
+		return dev_err_probe(dev, PTR_ERR(qcom->icc_path_ddr),
+				     "failed to get usb-ddr path\n");
 	}
 
 	qcom->icc_path_apps = of_icc_get(dev, "apps-usb");
 	if (IS_ERR(qcom->icc_path_apps)) {
-		dev_err(dev, "failed to get apps-usb path: %ld\n",
-				PTR_ERR(qcom->icc_path_apps));
-		ret = PTR_ERR(qcom->icc_path_apps);
+		ret = dev_err_probe(dev, PTR_ERR(qcom->icc_path_apps),
+				    "failed to get apps-usb path\n");
 		goto put_path_ddr;
 	}
 
@@ -813,9 +812,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
 	if (IS_ERR(qcom->resets)) {
-		ret = PTR_ERR(qcom->resets);
-		dev_err(&pdev->dev, "failed to get resets, err=%d\n", ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, PTR_ERR(qcom->resets),
+				     "failed to get resets\n");
 	}
 
 	ret = reset_control_assert(qcom->resets);
@@ -834,7 +832,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
-		dev_err(dev, "failed to get clocks\n");
+		dev_err_probe(dev, ret, "failed to get clocks\n");
 		goto reset_assert;
 	}
 
-- 
2.40.1

