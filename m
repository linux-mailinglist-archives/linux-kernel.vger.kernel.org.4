Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16571654297
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiLVOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiLVONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:13:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496C32CC9E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so2177274pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aSBJzo6HdQMf+Z0Vqc/apVYRTuOVSte3r0EnoXQi/4=;
        b=jTCrpY3DW1MbJPMO0SQIBXcCCkvCD0S+ACDX70kkaK0H0kZEZ6HnREw9vOQda3RT4H
         H7PGPlkzCC4/6qAAbsMsgFFDFG6kY/W6s2IPlUEflT3ISw3sEXSyLxVP8i8eZw+9M8kS
         LqI6NLrFaSBezR3F+5/YjXeeelNypntSJwT8yTS59VeDIjqMChORmW+lXY0RwB2pWjy6
         6wsmeVWrUlnrCRWVuNO/Qg4L2S8YdEugHJuS5B3YLxDEuF/8KYU6sqznBCUvrcm7KXrF
         D2xOw4cZO/jEUJiId5VSYHg1tx67U3hLRzF/jq7m7GCEB4D58fEmzKPC9XcLrPqepMzp
         PKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aSBJzo6HdQMf+Z0Vqc/apVYRTuOVSte3r0EnoXQi/4=;
        b=HKbxraXXVajOxgao3Oe27tbdkJTwKaNcxBAHht/rtF3NK2gKBzUfZzG5hb1wrgnf3/
         1OIdkvDPuor1Ij0Rf8AtBmwl79hJOKwZtXRooYylH+Nt7UM8ocDYhbFV65bYWBwmhRyH
         qWFomKu2iXbD6jjlleoNpcHDaotQmKsLmtPme/7GdRxqE2Z6KrRho4IDOTrPoM8rMGRY
         QBsyrXS0O5pvg4ExsvHPugZAXF+fq6lg4we0uUJotnrGr4unKptrmlvoWXrCi5CIODJz
         pIFkjRrNfKhZyA43T8R6g1+Rvk3ctXNxRK4DeH3Q9bm+e5d2PZMr/g9r1SKrL4FqBn8m
         5kGw==
X-Gm-Message-State: AFqh2kr5RuQ2WgFKCxTuGDu8bTxiILsIwO/556U165p9SY1tcbc0fN+B
        G8ycc9Wcbxhb04NLFhnZjJAC
X-Google-Smtp-Source: AMrXdXu0QaYyVMCq5rDRmy7qgCFCoYfXWUnAV4G8ELfQikPhojZ5rjvwLv+swmBQzX4x2gPFyXNH6A==
X-Received: by 2002:a05:6a20:1455:b0:ad:58d4:2a71 with SMTP id a21-20020a056a20145500b000ad58d42a71mr9202668pzi.4.1671718336761;
        Thu, 22 Dec 2022 06:12:16 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:12:15 -0800 (PST)
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
Subject: [PATCH v5 17/23] scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
Date:   Thu, 22 Dec 2022 19:39:55 +0530
Message-Id: <20221222141001.54849-18-manivannan.sadhasivam@linaro.org>
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

On newer UFS revisions, the register at offset 0xD0 is called,
REG_UFS_PARAM0. Since the existing register, RETRY_TIMER_REG is not used
anywhere, it is safe to use the new name.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9d96ac71b27f..7fe928b82753 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -33,7 +33,8 @@ enum {
 	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
 	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
 	REG_UFS_PA_ERR_CODE                 = 0xCC,
-	REG_UFS_RETRY_TIMER_REG             = 0xD0,
+	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
+	REG_UFS_PARAM0                      = 0xD0,
 	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
 	REG_UFS_CFG1                        = 0xDC,
 	REG_UFS_CFG2                        = 0xE0,
-- 
2.25.1

