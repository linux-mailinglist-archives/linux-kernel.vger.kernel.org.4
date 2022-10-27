Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A860FC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiJ0PtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiJ0Psz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:48:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3F19044A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:48:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id mi9so1662088qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Byy2S0Vto7TB5IsxBuIKJ14pDHCiNvo8WZA3Mj2Xhc=;
        b=v7hEC5o/NyI/xN8b6hJXPuDfORKXlxAODAk724H9n9hhsxnL1LjKLBupNhkjdCBBCf
         ll4ZKk+YMAOmkoOKDT/+8AKRzCZnnqO+4iWnC8HpSjwp5avFvZPp4wd+xmHnL1pfIhSn
         Bkw1UcA0ZfxwelkFkBxOj4ghwMVZ0vU4wX1EF9d4egOmshIILYxzhB9cdOqg5MHz3iZ1
         2KCwFQs4jMchfjJu5XFwWPpmOUQoa6C+UOxQk/wmVWVWkTL36oCqrG+aDif4bihYEHDE
         fR010UDuUFHwoZ/oPAGPprY8n4gKI6VNvqaatZ3yv2ejnQ/sKtpBmc0jGCL4zaqZ2Jux
         dRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Byy2S0Vto7TB5IsxBuIKJ14pDHCiNvo8WZA3Mj2Xhc=;
        b=FE+mKE8Zspna3aPh6NpEuXL17QqZUnpPlyHYKNo3URawFyi6H6Nh6FMLQpA90fNS+T
         CjD+vda+WwKrKxlRHeXNW5tSaZztPKXLsK2GS/b2Zj5V/sqobWQZUGrTR2XtiXwu5aXg
         lMmP5jJqILRkqlhk3fzDojEuhOfjv/wZ9S/7bF8aV6jmwKAQ0t576RVjcpiGxqxJaVER
         Q/h00rbjBwA5uYXh19sTxOl3BugWEHKENRN/4W0YeDjlqNunwRvj9XANNNA9n8z+47z2
         WM7vslKMfPl5jkgBcyI7peFcuEIrBPKNi1tuL4KdT0QZaO9liWkDX4dz3rpHlyxPPmyP
         HO2A==
X-Gm-Message-State: ACrzQf3YPkTKwDwV0L7K6+FEnVd3IYQam1YZusAldbMGSVforbpiNfX/
        1cDObRJopeEQbx4q+nfrNyj6yg==
X-Google-Smtp-Source: AMsMyM4k0KeFHQQ99jgXuSXN6lbmApy3sgfzhZZaNHfWVwiOr55ko6ieN88QStCeYfK11/0skgWi8w==
X-Received: by 2002:a05:6214:2302:b0:470:2d10:b6e4 with SMTP id gc2-20020a056214230200b004702d10b6e4mr42769688qvb.72.1666885734041;
        Thu, 27 Oct 2022 08:48:54 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a095d00b006eecc4a0de9sm1168531qkw.62.2022.10.27.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:48:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] interconnect: qcom: sc7180: drop double space
Date:   Thu, 27 Oct 2022 11:48:47 -0400
Message-Id: <20221027154848.293523-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
References: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
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

Drop double white-space.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 82d5e8a8c19e..ef4e13fb4983 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -443,7 +443,7 @@ static struct qcom_icc_node * const qup_virt_nodes[] = {
 	[SLAVE_QUP_CORE_1] = &qup_core_slave_2,
 };
 
-static const  struct qcom_icc_desc sc7180_qup_virt = {
+static const struct qcom_icc_desc sc7180_qup_virt = {
 	.nodes = qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qup_virt_nodes),
 	.bcms = qup_virt_bcms,
-- 
2.34.1

