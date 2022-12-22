Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D571D65428E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiLVONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiLVONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:13:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9312B632
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:11:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso5707271pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKhZ0e0M8HYKuSmRQjhv72TX3T/LlT9blCNctysBuGQ=;
        b=nD5egqnYURqthIGOtQB37shl0bPI1H4qqNQn2FwkH4/tQJcvyS0FkDFLD4P9rsE157
         04OuUVzrj890GbhpoMxhOAO7rBtss0L25pwB0062QhLxhWZuJrAYIzdNTWHg08QTslSt
         VlmQ22KCMIFdjETvuBnOz/m+1HE/TxZedKcUB8VM45EdhcRdmzv30GjTtcqnppJhVLFW
         jr6jEQ4te51NYzN908Cm9KP55tyyK+7udd5+N52kTYF6aKvpeILxL61T4DNFJRvEhTjY
         oIuCU6TUNeMP/0gIi+pqII+n1PVWPgTN3SgN3nATNUIcF/w8t/xEE2wUNu0sWIOAIu1N
         cEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKhZ0e0M8HYKuSmRQjhv72TX3T/LlT9blCNctysBuGQ=;
        b=UM5bdz/BbSFLiMEeArItgqYk/VMe7lBqlkXVMqmpjRaFeisVc233Bp3/tNNYpSUs9o
         lyQ7ensm5YX/4lU6D5rrMj2w4AJ8ndxNEzjFV4Lmb8C+Dws1LTqrMCTesrjBzaVntx6o
         w2GimEuEwFJDCoBN+a9OSdddD0a203wdyU/ObQv3GurbigAHXvvg2KlZXyw8p43SBWfH
         DYM/2+lmNS76hs+YM4mDpZWy1XZuhovm74/HMG5P2t3IbdbfK06OOHOLOYK1tXLrxViJ
         9umGThOItlMVlveSlNkiXOUYN2fAYs7MQuYr1ZEWZ6UZoqcElwS+pfdQLl3K2J12+R5w
         emUQ==
X-Gm-Message-State: AFqh2kpZ/jqU2a2xZhe+7cLzPMFEU5HksMBlhJsWnWQKu3OA+AbHOadN
        ZiUkWoq1nRV327HEqPDUR9KH
X-Google-Smtp-Source: AMrXdXsFVYG7ivgtchhbVXCprc4JnySWwh9p5ST+pTCanLIJsvhT0b0/4NdZ08dVB+p1cmuKb/NpZQ==
X-Received: by 2002:a05:6a21:3988:b0:ad:a09c:5734 with SMTP id ad8-20020a056a21398800b000ada09c5734mr7998451pzc.44.1671718314110;
        Thu, 22 Dec 2022 06:11:54 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:11:53 -0800 (PST)
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
Subject: [PATCH v5 14/23] scsi: ufs: ufs-qcom: Remove un-necessary WARN_ON()
Date:   Thu, 22 Dec 2022 19:39:52 +0530
Message-Id: <20221222141001.54849-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
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
Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
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

