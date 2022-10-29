Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF86123BB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJ2OSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJ2ORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:17:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DED60493
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:17:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so12314230pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s4pb9x6UWl8wDrCXVlNY9pvnbipHUCj9wO5Sx7YnCg=;
        b=Q6O1hF4S7juySY6AmZ8zq//HmIEox9z1xxzOUF6YDpC70zwiXukT55J0k9aaH8It7Q
         pGmFfNKqllIDMoAfwQFxJz7zDsju19WK1q6KU/+0gQAGZlt1w+8rBEm++XUSLTpMHdHE
         sa5CdEqaXiFDgkbIvDE6d8x8o1T9HkG7Pcp0RXlTQYGWWpPn9qgbPMi1SnbCtfdLx7gw
         R0Dtd2nKG7kst/GazoN5J4+ahms67kLaEQxUGJM/GVZDdOu464Z+QhKL0OaGJml24BlH
         mYi7q9UBfqkpbwd1PgZkdtYE+tP1R1A+WqVbEW2unLleiaqJVqM87KhbUgURnPTkI4gX
         3k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s4pb9x6UWl8wDrCXVlNY9pvnbipHUCj9wO5Sx7YnCg=;
        b=tGOMuGAvsD+Zed4zCTTDl4UrmigDcE5hBzLltO/DVVRnFSGUTgZFs4rj8YbKVpfiz2
         IHJ2WjY2NFLsj1mRN2k6IiCGioljMJpdL6j68Yg/nzVVKXFd1YWmhvFg+CbHeZksvjpX
         1k/0HQoOgtkWQuUlTKutk1lLCTW4D+WR6fwQbtr8lsmaorH7QmyaIbdKWG84PARxGPuZ
         noSoOKTuj/bMbjSm6MvdFZal1pfMdUh6vjn3XmSxeVGQmCOw1nfep2+HWLdh8Nm6nWfk
         G1+nkPNoKPnI9P1dU+dAf66lJwGnBHtG9NzQzzn+nTv6PlLZev5mkX3PCNDifbBG4u4F
         3nug==
X-Gm-Message-State: ACrzQf0cbogTTrtMsm7QKg+WK9LAIeKIkolXwhLP5kpvp6g+J980PK0q
        2Hvv6ObHpP4wGpyzENr+3dkk
X-Google-Smtp-Source: AMsMyM5kZh+0/sPqHoObvpi8OIIjuAZhuV8pWD2z/fTnaZ0gdUHdJP8lOulgEuhNtg4suUFwuMLnEg==
X-Received: by 2002:a17:903:1209:b0:179:d027:66e6 with SMTP id l9-20020a170903120900b00179d02766e6mr4653018plh.67.1667053051344;
        Sat, 29 Oct 2022 07:17:31 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001866049ddb1sm1370157plf.161.2022.10.29.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:17:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/15] scsi: ufs: ufs-qcom: Remove un-necessary WARN_ON()
Date:   Sat, 29 Oct 2022 19:46:27 +0530
Message-Id: <20221029141633.295650-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
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

