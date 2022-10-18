Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8799A602EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJROyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJROx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:53:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55DD9944
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:53:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 70so14204909pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ats1U1GKP5ySkCQcFs4Bt8DbrtP8aKLYh292IozDhn8=;
        b=ZrAC8O0zV5XMJISD0nU0tmntzsIrWrAzLhnfv5ntWDNrY7cSWrniEMtWh+1pQO10RM
         uNRQ+npKwnQKBo6GzbbSHzgC0vJuS+JkQ/7nRUmu4JiVvUqvHwyrzQyqYt4/Zkc+/e5G
         Jynopflmt053WmFJqqnt4OTJXn22409fjaW4nMlJwKyGWhj3CHH5Mrb6Q1h0lqQYmJva
         JCqhXJ/2iWzCOVVykBWZrEvrAFJRToY2tRA5XZtREZlT35McytzE0zUW75YUjbU5AmnS
         BN5j14tVCdMht0slkxfFokS/XUjlDgjb/GOQlFqq68LYccaTFjRrloWE8ZQ2zFFe3L/9
         T/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ats1U1GKP5ySkCQcFs4Bt8DbrtP8aKLYh292IozDhn8=;
        b=XIFe53n7wx78hX8rohjpTnASnjt7KIGIl5MTBKaPb7kcHr3xgUwNkwI8+ahdNWyZFL
         xSY0DJCoqfT73GuuCdZdqKFAZC0Jf4xlg1xEmTZDTKWj54t6H4KjbUsnSYsqmnr03i+q
         a9baudLc2ROlqw5ORrxc5nPd48NdmlyMIrm5sKqDmjKbhSzR+ZEhR6Q9loa39IbxvQGF
         sFl9yaVrTe1jDLM9+lJ2YCaCqZQSuINDdwbYz3DClDhgM81F8ygHN+mA9BX/InGqroBX
         MBGjwEPBypqBwUQgqfzpE2mo9oFl8TpuARsQwM9a1lPELhILtH3TD9BTu1fjg7SChv96
         9/+w==
X-Gm-Message-State: ACrzQf22DLCUY1lfI0imaY5QMmxNFKi4gKAfFl+HvqckX5WFFXR8GXBN
        gMKXXimnMPJHmKfjyRNkPK+YTg==
X-Google-Smtp-Source: AMsMyM5ba3pgVFa5RG65wrHNrhugFZ9F6QITUf4ry3gX63r7xh5Fhx5Am+itfgaWnxIuhaT9gWXx+g==
X-Received: by 2002:a17:90a:2bcb:b0:20a:ea55:32ef with SMTP id n11-20020a17090a2bcb00b0020aea5532efmr39655500pje.59.1666104836204;
        Tue, 18 Oct 2022 07:53:56 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.186])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b001784a45511asm8775248plb.79.2022.10.18.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:53:55 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: qrb5165-rb5: Disable cpuidle states
Date:   Tue, 18 Oct 2022 20:23:48 +0530
Message-Id: <20221018145348.4051809-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
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

Disable cpuidle states for RB5. These cpuidle states
made the device highly unstable and it runs into the
following crash frequently:

[    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
[    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
[    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110

Fixes: 32bc936d7321 ("arm64: dts: qcom: sm8250: Add cpuidle states")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cc003535a3c5..f936c41bfbea 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -251,6 +251,14 @@ qca639x: qca639x {
 
 };
 
+&LITTLE_CPU_SLEEP_0 {
+	status = "disabled";
+};
+
+&BIG_CPU_SLEEP_0 {
+	status = "disabled";
+};
+
 &adsp {
 	status = "okay";
 	firmware-name = "qcom/sm8250/adsp.mbn";
-- 
2.25.1

