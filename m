Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C436511DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiLSSae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiLSSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:30:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6813E1B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:30:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso1188268pjp.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=mxs/QURMh4Fchj/EQo9a4AGEN62JMD4qI4PsAb5DECS/FWcz6SEegn5LTPabE2SnAZ
         aqr/d+Vl/CV7+kvD/6L9Qlxo7EEAx6k7r0k+HTS+WCSHrb6dea46bmVMgZtpfXDOgjRR
         rJqcMYrrmHivbMDQ38bYFhbgngB04BRMW8rStF0cx+U9BW2wSrkLFNENNdtdQ7fpQMvd
         nNcznUgwpLBV6h8sajGjHUKbf+hliLlOKuLcQMeBsCoWBJ9Lr1xFYW+fqT+z/lqSwAPp
         SSxwJuPPX/LzqswbbKl5Q2GLkosy/nb9FHL79u/8IEOTDSs9oIBkhHsxr099vmFW8/B6
         +VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=yXBvWPWPSpnwSZHXc7kcm72r0zEwnO+bID6hKWMcIomBAOqvfMtSyU8n7TiYjX0bNU
         jcVcWrJ+TRT9bNkNT5LiAqKARUwpSo7Iw+nYedzbhG946vqQqBAKjvXR8Ex2ixmy6ao+
         Mx00y32ZHQnZE6s8KFTpwm5sJ98vF6IWTtZiaYRV4hBeSFA8KSFrdVlm2fcE//inRUu7
         palXlDccgQNYftEr49TgVu3P5YlGfz5rCSyAs6w2USuLmwZvmiyDoHuJbM92fVOuoWT3
         NMsb+s9Y10/9wkAoxAcAMHWubkqFL6on3hfDuKygQiRANTfz4OpAp7sA+5CfygQEA2Mv
         WJ7A==
X-Gm-Message-State: ANoB5pn6p6N3Od2JcQ58pdsehizZq0fA5vuqNjBygXP9FUvldG4tDboC
        089gwzN8UTyaRn5zVu4BLpkp
X-Google-Smtp-Source: AA0mqf5v+vtHo5VuKIcrEBj8EX9SIFPOt/nqRBd8N/jVTS5jLillcOEfaAPUTVUM87uT3teTCIhpCw==
X-Received: by 2002:a17:902:6bcc:b0:188:5256:bf60 with SMTP id m12-20020a1709026bcc00b001885256bf60mr42148384plt.25.1671474621807;
        Mon, 19 Dec 2022 10:30:21 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:30:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/15] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Mon, 19 Dec 2022 23:59:44 +0530
Message-Id: <20221219182958.476231-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
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

Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
maintaining with a new identity. So his entry needs to be removed.

Also, Sai Prakash Ranjan's email address should be updated to use
quicinc domain.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..d1df49ffcc1b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

