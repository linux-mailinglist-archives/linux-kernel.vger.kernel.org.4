Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A66643E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiLFITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiLFIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:18:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B86443;
        Tue,  6 Dec 2022 00:17:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so14060061pjo.3;
        Tue, 06 Dec 2022 00:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMi0rpjvwNLHZrVufPOOndRr3cEZbnUmp8cEObDhWWM=;
        b=MqWQgLPrE9rbL8ey5VZ4aE4++1sgvurlqmmF4xQLG6eYhB/uZTPwDOiuYSOQN2Qz8I
         GpzgWcCkKEOxGvQwwXUsxy1ebcN7ZtyVDqTzsf5pJKtP5VuetW96n50Pipc5nL9BS8zp
         wjc4SQAq2KBrheN5H0ZBovOIG+nrNE6nn/hWmYC5GLJ6FDDhLumnrtMoWTOQ81S88xml
         vKWkJI8MoLrd5Z+H8caKhnG3JpgU/fJFXteKW7xMiRtUIacva9fX2Wy1GOn3VO8b1J+4
         N1sqdnsIvouu3P/EMzBTQh82sP8zTpzNURD0zQA2vjqBTIAwPY4RAHnDLMKIVdgPjkzc
         SBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMi0rpjvwNLHZrVufPOOndRr3cEZbnUmp8cEObDhWWM=;
        b=fF+PhenH6c3zNpX0oyXY44zdcBhMUjUbPrwoig5eIdILd0r0rq+Xnc6tOMGUVwJdpv
         lFfQQ1ovQOFIusWs2NIqk1t7844aStdozr6Whn4ZpBmTahVq6PCfY/JNo460f6ZBy087
         kjEkx3klCxkh0vjk8UYDi4ABaL0yKKGJKFZROBM8VgnmFLCPD8ZJld5pg311NlDKcnej
         xuaJfl3sTFg/X94pH0hZxaQK/j7oXAH2EkR1t9NHZXK3CHtqVynWKMcfyUpZvf2A1I4q
         kyWFDIrVDVZ1Ja/r2TEGv9mVa3mpVGcd2mFjKXD2WY45R9kmrYyxn+EyvNCH40R2eDyX
         fOJg==
X-Gm-Message-State: ANoB5pkSnKLd59dEpP51oR6lUMKLrzZSP199feoCsXAaOdhGJgI9XOlJ
        AL2trLm9jMU+4WcYk7HgP0o=
X-Google-Smtp-Source: AA0mqf749+eKmifSaRR6NN+0JwoDc11UaKEkGe0DMLCW2D5howSp8NmUFOvlVF2PMtptntBUFKU/+g==
X-Received: by 2002:a17:902:ce90:b0:186:b46d:da5e with SMTP id f16-20020a170902ce9000b00186b46dda5emr69865167plg.92.1670314662580;
        Tue, 06 Dec 2022 00:17:42 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id h15-20020a056a00000f00b00574d38f4d37sm11177289pfk.45.2022.12.06.00.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:17:41 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] usb: dwc3: qcom: Fix memory leak in dwc3_qcom_interconnect_init
Date:   Tue,  6 Dec 2022 12:17:31 +0400
Message-Id: <20221206081731.818107-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_icc_get() alloc resources for path handle, we should release it when not
need anymore. Like the release in dwc3_qcom_interconnect_exit() function.
Add icc_put() in error handling to fix this.

Fixes: bea46b981515 ("usb: dwc3: qcom: Add interconnect support in dwc3 driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7c40f3ffc054..b0a0351d2d8b 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -261,7 +261,8 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 	if (IS_ERR(qcom->icc_path_apps)) {
 		dev_err(dev, "failed to get apps-usb path: %ld\n",
 				PTR_ERR(qcom->icc_path_apps));
-		return PTR_ERR(qcom->icc_path_apps);
+		ret = PTR_ERR(qcom->icc_path_apps);
+		goto put_path_ddr;
 	}
 
 	max_speed = usb_get_maximum_speed(&qcom->dwc3->dev);
@@ -274,16 +275,22 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 	}
 	if (ret) {
 		dev_err(dev, "failed to set bandwidth for usb-ddr path: %d\n", ret);
-		return ret;
+		goto put_path_apps;
 	}
 
 	ret = icc_set_bw(qcom->icc_path_apps, APPS_USB_AVG_BW, APPS_USB_PEAK_BW);
 	if (ret) {
 		dev_err(dev, "failed to set bandwidth for apps-usb path: %d\n", ret);
-		return ret;
+		goto put_path_apps;
 	}
 
 	return 0;
+
+put_path_apps:
+	icc_put(qcom->icc_path_apps);
+put_path_ddr:
+	icc_put(qcom->icc_path_ddr);
+	return ret;
 }
 
 /**
-- 
2.25.1

