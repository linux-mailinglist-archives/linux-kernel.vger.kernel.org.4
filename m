Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BEB712337
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbjEZJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbjEZJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:18:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F059812C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:18:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f37b860173so530617e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685092687; x=1687684687;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91tk7JnZvoP+ZW5JLDTfXwmLebfjuJ7VnX3iXfJ77W0=;
        b=QS8bKhKDThq0rAuN2+fsxR00emtYae6i+vLDdt4gCEZeMJSjGK0lyiRKpfBAucZFjL
         lXJ86c8/7cbuyQ5mxw10zfrrrgdNHL4s18Om9KqnxUeNN39T8uKXQALXoPnH8XKAA3sn
         /LGJU7IBGUfV4Hr8xwnEh3v7z22V9Dx8gSEJlxTezrdk4lkklWL7BJKLnDMuluIyDqXR
         konuJc7n1imdaQGuAXdF0uP4lIcmX1KSy5LY1mGLzesbQ3reYvVf3Pr0lEC791Solvlv
         nQrLtbFqIXkIAB/gyvCn2r8RREtOCrZWdlgPVpw9r8fs/MKCup1T4NdI4cEVOTlFIN23
         t7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685092687; x=1687684687;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91tk7JnZvoP+ZW5JLDTfXwmLebfjuJ7VnX3iXfJ77W0=;
        b=XJJ07ceZsEtwaZ+MGIsUIo1zgUmKaWl94iSiHMf+/hNnjzhp/46z6AOCa6ffPtjf7v
         Y9G2HomXi7KoM3VS70p/j7Hur4NAXFE42McPw+VdVARSLqR/Y6GB9pEKVQQr6eke4ids
         AnrZPozxSy4RTM8UZ2g9WyeUZ995rPMFLmYvxzUQFRWlEhq1E9SixsRX/+FiCE37cf7C
         CxWxAaLzBTdzZ6lzZShash1TSiQoKAgYw2gJngVXSoLpyhhtp+M7uF/9mREoOHAn8C7n
         ADKcfsbKuNoSefTeYDE6Rsqq4C+A3sreGG/50QFmKOL/kQ/B6Xw7dij/ZbzVKp9z4Dbu
         fbww==
X-Gm-Message-State: AC+VfDyPJEgOU5T32T/TLaB/3urVBKtxAGgBOEb9CRlMIeZVxjRbFbFx
        FcHXqEVZmoUIiBq9trD8924GtyPiuhVuTBQWOFg=
X-Google-Smtp-Source: ACHHUZ5pVXxnq41qSI3DUD3q3lMcT395RxsySupwpCpNXWyJC1IBqJiIE9xgJ5ip/vOMblL+KfTBVw==
X-Received: by 2002:ac2:5297:0:b0:4f0:1076:2682 with SMTP id q23-20020ac25297000000b004f010762682mr299189lfm.42.1685092687181;
        Fri, 26 May 2023 02:18:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id y16-20020ac255b0000000b004eed8de597csm541544lfg.32.2023.05.26.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:18:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 26 May 2023 11:17:57 +0200
Subject: [PATCH] opp: Provide a function for just setting bandwidth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
X-B4-Tracking: v=1; b=H4sIAER5cGQC/x2N0QqDMAwAf0XyvEBX56j7lTEkrZkGpC3tNgfiv
 xt8vIPjNqhchCs8mg0K/6RKigrXSwNhpjgxyqgM1tjWdPaOn5QlYMp58Cu60dzIddS35EATT5X
 RF4ph1ih+l0VlLvyW//l4vvb9AEqQCpxzAAAA
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685092686; l=2963;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jmkpzRF+36y/udydjUbD4CkymkzSnR6tIx+s488Udkg=;
 b=pooO+7/d+QQWxeUu11CD/xGFtkMuBp2jmmtr446tuhCyL/PQzTmHgqcGjl3Xb+UcTy4HKDfUW
 FNJPdUPUBTuBqnhHj0s6oWCT/Fs2sTpaBviLJz2Y1iduC2IxlYw/RsR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's not possible to set just the bandwidth if the OPP
describes other properties (required-opps, opp-hz etc.).

Introduce dev_pm_opp_set_bw() to solve this problem.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 85cbc8de407c..00d7f7c20189 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1278,6 +1278,34 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_opp);
 
+/**
+ * dev_pm_opp_set_bw() - Configure device's interconnect bandwidth from OPP
+ * @dev: device for which we do this operation
+ * @opp: OPP to get the bandwidth data from
+ *
+ * This configures the interconnect bandwidth based on the properties of the
+ * OPP passed to this routine.
+ *
+ * Return: 0 on success, a negative error number otherwise.
+ */
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	ret = _set_opp_bw(opp_table, opp, dev);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
+
 /* OPP-dev Helpers */
 static void _remove_opp_dev(struct opp_device *opp_dev,
 			    struct opp_table *opp_table)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb5890792..5e074ac7a68e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -167,6 +167,7 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, st
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp);
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
@@ -373,6 +374,11 @@ static inline int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
 	return -EOPNOTSUPP;
 }
 
+static inline int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -EOPNOTSUPP;

---
base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
change-id: 20230526-topic-opp_bw-8d04a85a93a8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

