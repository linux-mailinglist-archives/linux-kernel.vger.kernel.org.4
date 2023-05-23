Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720E870E684
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbjEWUdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbjEWUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:33:08 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA065DD;
        Tue, 23 May 2023 13:33:07 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 717BACFB2A;
        Tue, 23 May 2023 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684873985; bh=4Fi/VxwOwD866PDaqJ+pluJDA2/P40kdcSvWCGnuZ74=;
        h=From:Date:Subject:To:Cc;
        b=d7W35bq6ZwD5YwlSXfeidpm5iuuSlPzZVUjz5ex5hVw3/WLvIrh6AiLjCbPCGLCra
         XxcepkWoZCJ0aJRBVt27qBltG2KJ/LIMAJBlzkve10X88Q7K+sqYCZxN+9qQj3ot1e
         MtG8+dHqARsd9NtpsUnAa9ZrEbWVy++/qA3kHQbg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:32:52 +0200
Subject: [PATCH v2] soc: qcom: ocmem: Add OCMEM hardware version print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-ocmem-hwver-v2-1-8c8793a07dfc@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAPMibWQC/22OzRKCIBSFX8Vh3XUQzLBV79G4ELoGC6DAyJ/x3
 UPXLb8z55tzVhIxGIzkWqwkYDLReJeBnQqidO+eCOaRmTDKOD3TFryyaEF/EwZoW6kk55IyIUk
 2ZB8RZOid0rvzVt6CjVa0lxqasi7nvfQKOJjpmLx3mbWJow/z8SBVe/p/LFVQgRQcFfKBVY24L
 dyNn3KaF9Jt2/YDOLYv3csAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4Fi/VxwOwD866PDaqJ+pluJDA2/P40kdcSvWCGnuZ74=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSL0CmSMn/+CDWJmaln7Jw3BulA6nbLWEEjAZ
 /lrRFmktYyJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0i9AAKCRBy2EO4nU3X
 VtwlEADY7o2LKFkknKLLi+72sn4OP2pKygUyIcWdgA4RZXyFkV45uzoh5L6JATSZG0k4CdinVa7
 4QlguJTGXyQLaKuzPPLxeAOyXHwHeyE/7RVOQrWiVwv+03PNwR+KgCHGkWnKZ6xtOJu7Op1J/xR
 D4dlTiPuOjqtcJ3vVkGesWokPoDonIArtQNalXgP1bjgvu0HC8M6y9TeoeTB/hTRQx/akOyIF/H
 FmWMJjd22B21cnsuGcHhkINjlwClq/6d3W/uaoG2eJgy9c2+3jTtGJEsgkiltNeTo7TZ+Mh6ou2
 9sV/vT2a1Fb3fhVT1qQtkYB7W2RJpP2hH6Ml+3KO59KtBQIN8OJIr6/FuwbkbaWRZiSGV7lQNMB
 f3U7dfkyOLq3VgcxJFtM4YDqmk6ht627Rv5Nr1dpsF9eQaBb1QXr7dKz/h29wCs1ICSUXWXgKoa
 3MgooYQYCJq0Iw2Bgly1sZFF3fXBlF8pg1nrcQmoEZDMc7MhGUhs6ktwNePv16HajrSYn/dvbgw
 ARsRrRbNOcJZ4+wQwtRu6w71SVuoQkdALayJCfnnOYB6YFcyTx+OsPv2zSyVu2LdUF4xpLgTfNb
 q62CjUHNtlPkT4TqK5Aghruc0uMEk/BuHANWnFYyYCC73DfaierJVDOCWm97Ey4l+IVvyQsX47H
 uKq5LfZznWGb7jQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be useful to know what hardware version of the OCMEM block the
SoC contains. Add a debug print for that.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
This patch is depends on [0] but could also be applied in the other
order, if conflicts are resolved.

[0] https://lore.kernel.org/linux-arm-msm/20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz/
---
Changes in v2:
- Use FIELD_GET macros for getting correct bits from register (take
  wording from mdp5: major, minor, step which hopefully is sort of
  accurate)
- Link to v1: https://lore.kernel.org/r/20230509-ocmem-hwver-v1-1-b83ece3f2168@z3ntu.xyz
---
 drivers/soc/qcom/ocmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index c3e78411c637..9f7c3348cbb9 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -76,6 +76,10 @@ struct ocmem {
 #define OCMEM_REG_GFX_MPU_START			0x00001004
 #define OCMEM_REG_GFX_MPU_END			0x00001008
 
+#define OCMEM_HW_VERSION_MAJOR(val)		FIELD_GET(GENMASK(31, 28), val)
+#define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
+#define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
+
 #define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
 #define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
 
@@ -355,6 +359,11 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
+	dev_dbg(dev, "OCMEM hardware version: %ld.%ld.%ld\n",
+		OCMEM_HW_VERSION_MAJOR(reg), OCMEM_HW_VERSION_MINOR(reg),
+		OCMEM_HW_VERSION_STEP(reg));
+
 	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
 	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
 	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);

---
base-commit: 8705151771af822ac794b44504cd72eebc423499
change-id: 20230509-ocmem-hwver-99bcb33b028b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

