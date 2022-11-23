Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE70635170
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiKWHvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiKWHuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:50:09 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71293FA72B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g10so15909394plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff060FMlh2MHBX3ga6yMFYN0UyVEYS40VqwmLXF4PCQ=;
        b=DJBZrYbtm9X/QLJ/W0BggBinY/2j9h/csY7y1RXj4ibeLojZMPOM79qLxjtvmX+0ef
         qHTZgJHFtB32vZURoOJwLrNnSQaX+2bXlf8zHuE6hiZvRxi7W+LWnTCMbLdSEjKKDFtr
         rKUTqK0DqmheaA9m8c6D41qw7p4fLNAiNy+PHR04AEaVDVbk5EpB+rRgUXGybW134Dfa
         o4VjElLklHUuz5FiE57L+c8177u3W7udeCaUt7iGmyf7sLEWBSAQ7XWXEHHDp0xcZmxV
         BS/SqxE5y3XMtTkm4XOZMcntYbiHkMT+O69Uqzk1+oWlwsjgpd+I94tXWMAjZ+a6pFNg
         B6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ff060FMlh2MHBX3ga6yMFYN0UyVEYS40VqwmLXF4PCQ=;
        b=VjL24WGhiNEJCaNeHTi7Gl9gthK5uboJgm3OuK9SsviRwnwTo9Ch2psH9VeUE51i2Y
         jhiy1RioNIOLzFddE8X0peSkm8R23P6OrAAsgF/T3Nv4bFT+2vRVv6I4WRo6LaN5VV2f
         7K4Tn0ak3Qv2HHrYTQrMECgGFU/kvyR8sA08Qsg7cPYb46+zAXxmxTy5uIr8Wli1f00S
         OEm0MTca+GptIspOs/l5saQL6lXvHlx4SjNJQo52D6msnnPk3MtSClfwoIgIxjwrbCBe
         8GWhI4w9ebcUN17kpytK2/u77R5xVvuB7QMIux29GmPU7AiVujas7s8jauZnFLCsWmW2
         gnqg==
X-Gm-Message-State: ANoB5pn8Y6oNUesIWzh/BmiJCJJdUXJc26X7rqE/pmiAkAG5S6wMHTLa
        ZQcWyMLmrIeaIPLYX0smn013
X-Google-Smtp-Source: AA0mqf7JrTjVi6IhOYnAnZ7BbIJkXhoSI7J/05AMbqHKIqgMfOzWmGZ4ebVDRyq5ynhxhMb8SwK5Cg==
X-Received: by 2002:a17:90a:73c2:b0:200:a7b4:6511 with SMTP id n2-20020a17090a73c200b00200a7b46511mr28487090pjk.101.1669189792943;
        Tue, 22 Nov 2022 23:49:52 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:49:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 13/20] scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
Date:   Wed, 23 Nov 2022 13:18:19 +0530
Message-Id: <20221123074826.95369-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of dev_err_probe() for printing the probe error.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8bb0f4415f1a..38e2ed749d75 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1441,9 +1441,9 @@ static int ufs_qcom_probe(struct platform_device *pdev)
 	/* Perform generic probe */
 	err = ufshcd_pltfrm_init(pdev, &ufs_hba_qcom_vops);
 	if (err)
-		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
+		return dev_err_probe(dev, err, "ufshcd_pltfrm_init() failed\n");
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.25.1

