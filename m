Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40966123C7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJ2OTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJ2OSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:18:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A965FC26
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:17:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so6861957pji.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6Cn6AAM+ruCSUx7hOhryryIVpbAjdLGLzoffp2NaNY=;
        b=WT8C9Z4ISqHLbq0ws3aGDgQn4ZnrIZqfE5JVaofV5V8Q/4jxd/1yyHqv+szIEQSkn/
         riTWtO4o/TvPc6R8oZY/v+TEMjhwsi/S+LT97zFoYU9jwW+CJ7MOP9ZvNnz8MfbhHCyL
         piUS20GmVWf83DmJTqvaoYZTSazuQFQMAC5CQkfSe818aWluRP0HEls7yLgLiIRNeLL9
         /Go8f5VbiyicQH0qeVEfZJ+DXXaf5Hkx2G1PrhLJVIFfhxhM4heT3hANhJlELhjj0s1w
         5rp+srjuc3fYOW+HOQkxT22kfud+zAn4bo8AVgkIBLU0D8EixcMx/N6GA83haFqO4MNN
         LIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6Cn6AAM+ruCSUx7hOhryryIVpbAjdLGLzoffp2NaNY=;
        b=KpW+T9OaCF5kbeZm5SRuVPkNp7E6Ge34uG8e/lbQkMAZajKhEEBViN3fK4R0hR8D67
         0jEgGK84f7tuzNn+cyXw8L+rS2sE97T0AWReT5xBHTa27aLMV9CMtdSHU/rF+Y0WxnXm
         mYUiY4nIjs9TiUZHuU9wHBzZNqLB6sXYIx+MniIhkDPZj0TOObmc+pnvY96d+xJDUt6x
         nnTGSDnp6LJjDwP6VcKnkGIq8puT0RuCF2JlBDPzwzXorDc2o6jv0b+rTrt5DfseC+F1
         a/1k6OTne6SKs4NcMleazEOHTXdZcTSBys6+Qqr6N+6L0NWRre9pGt6y64bIm4fGhbfi
         jtfQ==
X-Gm-Message-State: ACrzQf179umgxd4bhYGqfaorOicg9qG9TMEnNtDQHlJitR6KToYayHYR
        +8v1A2pLkWU36/w+qri9hXKO
X-Google-Smtp-Source: AMsMyM6BzVwQ2YhU3TiOk54m9WMzzOVEFEMcHpJCXT2JKGyLHJFwwW9gtknZ00dp5yk2PL8C5QiBJQ==
X-Received: by 2002:a17:90a:5509:b0:213:98ab:da74 with SMTP id b9-20020a17090a550900b0021398abda74mr5056156pji.208.1667053067496;
        Sat, 29 Oct 2022 07:17:47 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001866049ddb1sm1370157plf.161.2022.10.29.07.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:17:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/15] scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
Date:   Sat, 29 Oct 2022 19:46:30 +0530
Message-Id: <20221029141633.295650-13-manivannan.sadhasivam@linaro.org>
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

Fix the register name used for offset 0xD0. The correct name is
REG_UFS_PARAM0.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 6cb0776456b3..214ea50acab9 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -33,7 +33,7 @@ enum {
 	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
 	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
 	REG_UFS_PA_ERR_CODE                 = 0xCC,
-	REG_UFS_RETRY_TIMER_REG             = 0xD0,
+	REG_UFS_PARAM0                      = 0xD0,
 	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
 	REG_UFS_CFG1                        = 0xDC,
 	REG_UFS_CFG2                        = 0xE0,
-- 
2.25.1

