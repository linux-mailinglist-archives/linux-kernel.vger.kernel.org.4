Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874BA63F6A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiLARrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiLARql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:46:41 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB68B8459
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:45:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z17so2574881pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff060FMlh2MHBX3ga6yMFYN0UyVEYS40VqwmLXF4PCQ=;
        b=ChLzP/jCsMP/7siDVnOirGouhwX7bHn8Xmjbes6aYzsley+JEB5YH+txK3cEAocgCO
         tWMUW7/XxtsTbxniN7+xNm4fhW98Cp3Olci2b+gVhIVPetAPa4iGquaU18A1UeLIk/rk
         qw1YFOlOUvEIdMFX4jfhaqeRikGbEsguk7uaxFycoJg9dhWF6dvyKdbANzsBlipDvWV3
         KXH/GfEG+DFeDnnu/dfw+sCyiMnsXdy/ujc3gNVWZ+hjo5+K/qEUA4Gi1s/WdJ/8fXxP
         YTJxbSJ8FbKZitaBUZXVjIvZZ65rWiinyCnJ/OeMStjTwWLNW+cQk2iQdE/foG8GJnZ8
         DomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ff060FMlh2MHBX3ga6yMFYN0UyVEYS40VqwmLXF4PCQ=;
        b=mCMIsFyQq81n/WiqBuCt9RnK2nFZmGu+lruGMIWWE6AJHf+rGhYyTroPBY+fWc1KY7
         K40ECBNgT2uPS1xhoiAynYnjYD2ED/Vy/9rgb1BvAnwSlPCtwpJjJs9jtLsD7L7fu9Xv
         XBu/ZrnBi/IUxyADjnN8H1piKQhs2yXHUwXiHtuQz5bcS3tkK+g+jOgOUbOiNB0b8MI+
         3cJzH4ty+dn+5Y0wTxxe8WCmekS9l93MVI6BbexbKW+720tyF0sVJIn2YiOIQrO7IHq3
         dLI6eHT2ntKZZeGyW7uQGGQ+By+cdkOcmaGEjE8bAJB74VXNIfZLH1BD0sUrIQceRsen
         7BCA==
X-Gm-Message-State: ANoB5pkPOFLm1wmkvT0V5UfYbj0lm+rKbpxPojQEXI7vu8T03Lj91Udg
        LoLZmEVD15NbGRgQFHWYFGkg
X-Google-Smtp-Source: AA0mqf4Cuxf3UyHQpczq+r1vzyH2b1ABJK/TrKQIBMWfdC192LUpUe035VBHnShh7DVbLhUTF/ngLw==
X-Received: by 2002:a62:f94c:0:b0:56e:174e:efdf with SMTP id g12-20020a62f94c000000b0056e174eefdfmr68316959pfm.29.1669916731346;
        Thu, 01 Dec 2022 09:45:31 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:45:30 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 16/23] scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
Date:   Thu,  1 Dec 2022 23:13:21 +0530
Message-Id: <20221201174328.870152-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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

