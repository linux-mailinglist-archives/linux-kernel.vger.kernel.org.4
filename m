Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E163516D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiKWHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiKWHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:49:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB7FBAB7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:41 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b11so15255899pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgfrCdEhXykVwBp3nVTN7WEjo711kZc0QKngTjXB/aU=;
        b=AtlYAIpauMotfnGl9jZIW/bs4OXPXsjqMu/t5z9waPiXFr+ZLGRbncdtrZ+xccgL4+
         ZmWoyRIerO0JwGuCWf/VI+7gQqE+MUj6zBip/uqsxxDyg1qsczhyP3aMIAMszq6wr1uT
         bvFGr/B3cXBhK3TwmA+4nva6/xx/GXYIuAotU4KTZD+L1N7ZnEmkpTwSY5Jn06EOxKzb
         P4q0Zq5/Poxrkm9YwDjFn6nmkNumTkGb4plFjP2kDx/4Yfk2B7wD59uFzzwxettvuGnU
         SYP7ZrQWuuFm/kC+Wpxd02pJmDrp07ZWFVYLe5Qo3gZUy2xUNnZcqj4WWJFO6OSX5TJZ
         M8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgfrCdEhXykVwBp3nVTN7WEjo711kZc0QKngTjXB/aU=;
        b=P8PfQGCUd8ZoXgz6U7hrTbT5OOdCJdDvoc3VR0PK55pnGWeSZKeSqGOGz2CLfdgcKL
         mRSmXPW/RA4MilmR6VlbZNcUpPBrS0ob64fHA7QazKl5HhkZn/Wh27uJ0quxqIqmdSvK
         OBUD1Bw9er6d4wGKBq1gBK/tb1bH3VYhQcUBV/qrCriwvWcH9q5uOqiq3eJZTlXTd0B7
         Mwv7ZU010XZ94ac/Sx5bM8hHCsuSwDK94Y1ZCnIT35ShUrvrO/K72Yx1RzzAnI64qsSs
         cjxUGNAk7DPuE8ElhKNtMo6zEz7wzT6U6b7IT6sjGnueZvh2cwbulx3Soype9ZD7IHgE
         jJvw==
X-Gm-Message-State: ANoB5pm2TFpscrfFi/CqGDYf0OGeVNpcb9LNyUD53XovAfSVcYfL6fga
        ltpk+HUFo5BVz7FJtSasbsmz
X-Google-Smtp-Source: AA0mqf7MKZeCvXf5M5XLWkX+Fqjhqr3Su01CfEQgrc8qo0XLX61I+9/B/AjkA+tkBnMTRD/m+311Tg==
X-Received: by 2002:a17:90a:e2c2:b0:218:825e:17f8 with SMTP id fr2-20020a17090ae2c200b00218825e17f8mr25546559pjb.129.1669189780946;
        Tue, 22 Nov 2022 23:49:40 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:49:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 11/20] scsi: ufs: ufs-qcom: Remove un-necessary WARN_ON()
Date:   Wed, 23 Nov 2022 13:18:17 +0530
Message-Id: <20221123074826.95369-12-manivannan.sadhasivam@linaro.org>
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

In the reset assert and deassert callbacks, the supplied "id" is not used
at all and only the hba reset is performed all the time. So there is no
reason to use a WARN_ON on the "id".

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 7cd996ac180b..8bb0f4415f1a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -895,8 +895,6 @@ ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
 
-	/* Currently this code only knows about a single reset. */
-	WARN_ON(id);
 	ufs_qcom_assert_reset(host->hba);
 	/* provide 1ms delay to let the reset pulse propagate. */
 	usleep_range(1000, 1100);
@@ -908,8 +906,6 @@ ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
 
-	/* Currently this code only knows about a single reset. */
-	WARN_ON(id);
 	ufs_qcom_deassert_reset(host->hba);
 
 	/*
-- 
2.25.1

