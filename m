Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B06720BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjARPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjARPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:09:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351A23333
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:09:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s3so23880459pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g1r2YkbrCTL06JBn8TcdxJnLCnZpZqC+qdq6jkkxOk=;
        b=rmGHhTlj8O6W1yPAhd3uk2Ho8WDQV2ls8DgNFrQvHO8xa5RrlA6ALv/tHMw3UtegjW
         uqKI8SSb5ozUimyYj7w3LSV61Kuk7og8suQrm1s2/uBYGWx1E8e8+UTZWwXFYUkb9eEL
         lo4+CJxoKxTh9NmrYfhJ8cQFpyT9/yvaUSXXInOg50ZEnzW3wCzXGWjkf/N2pSJxrcnx
         O2lXZ3BPh1lMOkLCDCqNEQTA5yPe7iKk5Q2QO7A1+syXPfPEX9xHDqByGpjF2QPNeACx
         NJKYI778puEQkLpRby0cQlida5hNSZRwwTyoxlUd4xBBmwuL+76wvu9c/ou2wdGNsAkc
         q7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9g1r2YkbrCTL06JBn8TcdxJnLCnZpZqC+qdq6jkkxOk=;
        b=KVFdVkk+9JCi0wwdPQ8DW3Pkwn6O8D3lRndwuL0LKPF6Sk1LIzOJUoto2dhoOyYtlk
         BV0rBY6rgpQP9f8lId4EQvRdJEiqCooi4YkPs33efLwF+Ln797ngtOGPQjAZM/VXLkJK
         Gwjs0B+Vyjm7e+KqitS4/emSDwkVzDynfaY26BU3UT/H2fLDzGqtNVUFo5iDNTeVLFQm
         erOM3df1+H4lZV0u6g/gPmTSplrImMVJzHc6VRIt52g2Z/dvuN0vo64YfaJ43eMKloph
         b1J0exe76BH0jUc8chC7b8azC97UDW77R7kvXskjlUl9hqZoGlHPNpBjAEu4LFotmIMU
         nkuA==
X-Gm-Message-State: AFqh2kpWGZ3vOniCRq8K69Ns3vjGXArOby0hyOHADATDYAxbC+LMeAZt
        LUv8uab04V13eC0cXZpcGwP8
X-Google-Smtp-Source: AMrXdXvZOMcQB/ZBoqS+3k2rADk7d3DCLX6WFNCx/MxVUn82xQIrp1DOK76Vvu1vLwsXnqn861Rddg==
X-Received: by 2002:aa7:9a50:0:b0:589:b85:1e32 with SMTP id x16-20020aa79a50000000b005890b851e32mr7763285pfj.16.1674054570482;
        Wed, 18 Jan 2023 07:09:30 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v6 03/17] EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's pvt_info
Date:   Wed, 18 Jan 2023 20:38:50 +0530
Message-Id: <20230118150904.26913-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

The memory for "llcc_driv_data" is allocated by the LLCC driver. But when
it is passed as "pvt_info" to the EDAC core, it will get freed during the
qcom_edac driver release. So when the qcom_edac driver gets probed again,
it will try to use the freed data leading to the use-after-free bug.

Hence, do not pass "llcc_driv_data" as pvt_info but rather reference it
using the "platform_data" in the qcom_edac driver.

Cc: <stable@vger.kernel.org> # 4.20
Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Reported-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 9e77fa84e84f..3256254c3722 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -252,7 +252,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 static int
 dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
 {
-	struct llcc_drv_data *drv = edev_ctl->pvt_info;
+	struct llcc_drv_data *drv = edev_ctl->dev->platform_data;
 	int ret;
 
 	ret = dump_syn_reg_values(drv, bank, err_type);
@@ -289,7 +289,7 @@ static irqreturn_t
 llcc_ecc_irq_handler(int irq, void *edev_ctl)
 {
 	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
-	struct llcc_drv_data *drv = edac_dev_ctl->pvt_info;
+	struct llcc_drv_data *drv = edac_dev_ctl->dev->platform_data;
 	irqreturn_t irq_rc = IRQ_NONE;
 	u32 drp_error, trp_error, i;
 	int ret;
@@ -358,7 +358,6 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->dev_name = dev_name(dev);
 	edev_ctl->ctl_name = "llcc";
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
-	edev_ctl->pvt_info = llcc_driv_data;
 
 	rc = edac_device_add_device(edev_ctl);
 	if (rc)
-- 
2.25.1

