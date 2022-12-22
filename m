Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465B6541C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiLVNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiLVNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:19:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8192B259
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:19:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5661570pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mWLM+xjtkcHtTlHLK0FQlJaaC6ncfnZviWhmaPi0lM=;
        b=TOarD5uKYzdGzBgkCMjwru8cWoEMQy/+vSrMtukdY8EyEsh+D35kd+S7H09cmg6j/Z
         DULe/DTL/oabOivkhr0/PVxddgKe+CvaCfRUv51KVMkEO6qSZ2RIQfMckDB40BJ6vV0B
         Ht/puy0DpzttOPl6aeL42ts38AjAOjpblgt8ubv8vSNOc7PTw3CcfEXIkesR1nzJpnny
         vsPVbWDC+0gKgkSu+UkM+PTw5QswbD718pxnahHcR/Na/mw2cTS6K+WYZyhQZPz87Klt
         2iAXonIw9nblXUEpjN5t0nuHlMDysNnt/BtGaZxPOXXc1jhqjuw1LjF+5WdRMt5MpDJM
         P0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mWLM+xjtkcHtTlHLK0FQlJaaC6ncfnZviWhmaPi0lM=;
        b=nw9ifqtd4c2Sz46YS/OSyzFQ27mmNdmwxBIt+K1bcdlOPPoCm7H0kRb9mX3b76AF1T
         VHwsseuwp4Gm9sfPzKjepAyBzm9zqIwH7J0uEYo92Jf0kpmXe/WE7QJ7xhPsibkDfal2
         51TxkV0s1iSzMk3s4SLmmJe2vldPic1sWjcIhbKd+DpsS+GDUQy2BpI5QYqxUHymsIah
         x+xvPQQ8aj4k6edV+oRE7RfL6mOIqFnmTeLBUKvN9qSX5yBVDVaVa1qcIknALgeOAK/y
         sUOeW6N/T9sCSZDPSl8ZaSOTac8DIqZEl4WVIZN+qcwbAi02If4wpCkGno8dkUL5DdB3
         pKNw==
X-Gm-Message-State: AFqh2kpaB0h+nE78u7/rzDTgHf5Ifd7UkCgDZTFoL9ad4cXs/Bt+4s4q
        KgWleWbfqw6br4xDDUrm7vhWP39sYd3VBMQ=
X-Google-Smtp-Source: AMrXdXudkSeoeZwsmTfGklt2Kh/SAQNWHjc6/RvV92AIBr1XEprSb9dEjdUIK+mW5midVbFz3uGWww==
X-Received: by 2002:a17:902:8bc6:b0:187:16c2:d52c with SMTP id r6-20020a1709028bc600b0018716c2d52cmr6442361plo.50.1671715144171;
        Thu, 22 Dec 2022 05:19:04 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:19:03 -0800 (PST)
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
Subject: [PATCH v4 13/16] EDAC/qcom: Add platform_device_id table for module autoloading
Date:   Thu, 22 Dec 2022 18:46:53 +0530
Message-Id: <20221222131656.49584-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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

