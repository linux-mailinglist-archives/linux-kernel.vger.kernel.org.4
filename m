Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168B613D01
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJaSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJaSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:04:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB6410FD2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:03:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 130so11345692pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvt/ooOFeIQi2DBt2IsAxWGkItH8ZOWcpqthZcxorNk=;
        b=MRr8I4HdQhqgTo0yNOhsFOhZV/I9beGFFMFSzQ5/qewYPlKyDMnTu1cb8X2l7NnkBC
         D/vh5oh44rVIq5XLoY3RWT0n8Gi6fqUYZT5lW0Njj1f9XpMLyDdrdPuqwwQ2R+tVXHuH
         rxtTzBVxF+smBqHDdP89u/1etqmRaIfsrmFs52mjVHwSMlzKZxKs2FD05lRsJI5kHaAB
         RNr++j1JU/y9a5A17NMz9hWSquiIaUzWCAlVD5m9he4b57+Qk7pxB4o/e2HXwHEpWxZo
         M8PpwHV9IJ2M9SVifRB3jUkzQNQsmWty46csc0KPf1s7FR2ayyHnP2sF/ewS4uKr1gBG
         wY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvt/ooOFeIQi2DBt2IsAxWGkItH8ZOWcpqthZcxorNk=;
        b=T6q7KYhg2uibhRhCywJERBX5hk8iEEwqf41g/2UsHU0a+jKfg0GwM+7Zhv7QPxGIAb
         V3/UcWM/7njbojHEg397JPoip0uuRreVjr66MrNW9fwmKNQzqeuFpmIl2r+JQIQdiTfS
         2UaMO0LUFt6cnmkCdoWo6uDzuqcPDOgbYAyKDtZK5LGWmV0+HT2ppr2uISj2iLxjk66z
         TOdmOijPpk/H0f+nS7zQwN3mnQMGQgq6mwHMpCpSEgH8RiDS12aZfYD5Qt1CbT/ijDnI
         IOSSbid8cWFqZOpInM/BFDQnlwg3ZMi2suMWzDT8c/gHgEAxS9XjpD1JeREW3ocmcAva
         prbg==
X-Gm-Message-State: ACrzQf0x2CwMzFMEEXGBlSvVMY9ETLjZgpDEv9JAt/N3Q51xv8qsuBSi
        e20KyR26swnPGDshb+Je0702
X-Google-Smtp-Source: AMsMyM7U31sdCQlnOqIi2pBNFs391BLTLFCHqOQ/hBImrmMpgUG5LDMLLefA9kc2/40q7k5hU0royQ==
X-Received: by 2002:a63:f153:0:b0:46e:b0e3:547e with SMTP id o19-20020a63f153000000b0046eb0e3547emr14247127pgk.51.1667239438233;
        Mon, 31 Oct 2022 11:03:58 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:03:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 11/15] scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
Date:   Mon, 31 Oct 2022 23:32:13 +0530
Message-Id: <20221031180217.32512-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
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

