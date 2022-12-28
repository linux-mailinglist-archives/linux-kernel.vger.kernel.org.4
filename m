Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06F65740E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiL1Ila (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiL1IlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:41:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38B1A5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:40:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p4so15599762pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCj+eIEQcGnCqPz5ZSYr2aqyU+fsKL7bkSmfajhhbqw=;
        b=nh2vLpwyk3i88WoIGebvO24ZIfmBo4MbWEQ6zxuAbkNK1NrDjWdFI86Gl3KuTu8FhX
         Xjn+T0h/F2Lfn0tplbrQ8HWX7xQNWNVdLvpwiWiaXj35ObByDxpDboqqrsFziQ48gT3J
         3U6eDfFSVG+YnqoW9rsNzkHJC+y4Qh2RAqzahA0tyxzuwsfLYL4Zp4O9ClzJ/11yeHyi
         QT2rao1/GsGNKxrhUlOZ5VBOwR3ZWL5o45/HllyRKOxd9UIwJMjC8opDVo1A9IX/7ZZI
         q+CIbj5C6ZgC+mYFKIS8t/3vHMGItPKkjknzYzAQhY7oD7LKpoBXCODrqDQshw64AoR1
         QU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCj+eIEQcGnCqPz5ZSYr2aqyU+fsKL7bkSmfajhhbqw=;
        b=RkybgXyi+OBcklSzUHKBnSE+tyJRr/SzTNgUKZHyBFrskYBtn195cemLAjHQfm6Uwr
         /owoiL2pZvgCAEzMlF+twso7yUCR5/EFwDBq+y/dGHv40N6pOXnJYM4os5YK4D1kHSgg
         nTbNyvmG75DDyWUFZMA7v3LmrlA3c/apAs1ePnFEeJLt+FaU1QG4JvpIMpYPkyIL5q9u
         HiG0ILvLsnzvZdbN+sSI3pEdTb2dC+TFKVO5Ac089RqyG6GAQPTv5krDwchNPBPmJSkz
         YqiPAG246asrrg2R1EjiISsiml0VJHGBi4w3yeo0WhpP/l+homXEIUwC3ktYLgUSaB5J
         OZiQ==
X-Gm-Message-State: AFqh2kozUR4VLDFgpgvVXeNd3ifvil2dw6JMhID+mRPdns4X/l9G2TA/
        YK6o6eOHOuXQhL0UwiHvWSLj
X-Google-Smtp-Source: AMrXdXsnwu5WJi7+TnEJGtUOAUs6sawZwL2+5ZpDVe0Me44zOkwKOHWhKRKZnSS4aAi1PXOTzEhT4Q==
X-Received: by 2002:a05:6a20:1455:b0:ae:661c:5553 with SMTP id a21-20020a056a20145500b000ae661c5553mr36999595pzi.4.1672216858060;
        Wed, 28 Dec 2022 00:40:58 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:40:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 02/17] EDAC/qcom: Add platform_device_id table for module autoloading
Date:   Wed, 28 Dec 2022 14:10:13 +0530
Message-Id: <20221228084028.46528-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_device_id table needs to be added so that the driver can be
autoloaded when the associated platform device gets registered.

Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Reported-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 97a27e42dd61..9e77fa84e84f 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -397,12 +397,19 @@ static int qcom_llcc_edac_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id qcom_llcc_edac_id_table[] = {
+	{ .name = "qcom_llcc_edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, qcom_llcc_edac_id_table);
+
 static struct platform_driver qcom_llcc_edac_driver = {
 	.probe = qcom_llcc_edac_probe,
 	.remove = qcom_llcc_edac_remove,
 	.driver = {
 		.name = "qcom_llcc_edac",
 	},
+	.id_table = qcom_llcc_edac_id_table,
 };
 module_platform_driver(qcom_llcc_edac_driver);
 
-- 
2.25.1

