Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA815613D06
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJaSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJaSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:04:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4810FC7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:04:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h193so2661293pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE5rC5/HZ6deD3gc3XT/0TjMi23c/Z+tQRwUel8pEh4=;
        b=ngJIar4cRFhRJ87WFHp+luxDgZu2MaxOeVJXEy03uFeynHfCGlgzi4+nVEms9Rrk/Q
         ROcU3ieIa5E29iAolL6Yz77bfEMHKLh2mFIhoEnOubAUebbX3Dzmrq3EfuEWPqxXcGAn
         +rBiHDSlorwin1D7vz7k0tIR9TXt2rDcpAzH0KgK7R9bo7hJdfwl2kDscvhpG21gRei3
         12EO1W5NsPVUZGAi3n6ARvNOrJOdZDWH0wgCmOWRsDnRciNmsfVWUCRg64m1ovtl4KFd
         WqilTAX+Qx8nkQbWp1fEc6ofx7HjegeZT9bzcabe1M2IwGmiYj98lf7yZUYxJEjmd7aJ
         EkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE5rC5/HZ6deD3gc3XT/0TjMi23c/Z+tQRwUel8pEh4=;
        b=z8ScCIUQN1y5Tv1OKcg6JOv+fPigw3ubLbG7BR3WWlI5Sgvayi5/VaiaHsVQ7PdpFF
         dQzKy+kEiXti7TyQq21iRi79zxZw+xrk1tvNPek9gbPtMA/dDnJZzQOlCOgzmBUiLThT
         QctBlD7HetR+Gelema+Zg9cZNb2boehtvSy9b+G3tPCRq1z4iBNu22855LdD9XprEk+H
         ixx0TcsRJgITWD9b+0Dtr51UNMNzbLkcoTrFYH+eUIjs6IodBxJ2BcumRWo2SdaReRa9
         W8ok0UQLCucNy04eO1ubLRBRIVxtb1r8j1/rRcdnckFuMMwfYKEkjCG+wtY99AhScG9m
         SEEg==
X-Gm-Message-State: ACrzQf2wb+nrJTHWz2LcbSP5zIxwyEA7P4PAIOrWnA63D80H3Ufgsij5
        z14JwuJLKXtu2bANUSyjpDpg
X-Google-Smtp-Source: AMsMyM6yyBG+NNnymIFV2d9Fi+RqjhDyAZ0khdcfg9ZdsJeRcnR/xBL9MobSoFweIhYMbnTUnxEfBA==
X-Received: by 2002:a65:68cb:0:b0:460:b552:fbf4 with SMTP id k11-20020a6568cb000000b00460b552fbf4mr13750019pgt.457.1667239445056;
        Mon, 31 Oct 2022 11:04:05 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:04:03 -0700 (PDT)
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
Subject: [PATCH v2 12/15] scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
Date:   Mon, 31 Oct 2022 23:32:14 +0530
Message-Id: <20221031180217.32512-13-manivannan.sadhasivam@linaro.org>
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

On newer UFS revisions, the register at offset 0xD0 is called,
REG_UFS_PARAM0. Since the existing register, RETRY_TIMER_REG is not used
anywhere, it is safe to use the new name.

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

