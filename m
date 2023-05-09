Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A56FD184
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjEIVhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjEIVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:37:05 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAECA7AAA;
        Tue,  9 May 2023 14:36:39 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0E3BBCED2A;
        Tue,  9 May 2023 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683667589; bh=pvHSiUMrczlMpzSjgH+98eice2Ngyu7aqn2T7T+Okic=;
        h=From:Date:Subject:To:Cc;
        b=UT5rEHIm2ZCkIwcF9lrpDvkMpQib+0yZa9v9YQO6q616ozY56lzkJPWL1t0n9wDxx
         nO3zYm1sKwOmKx7OIIuohQreKM6IgC6HW2k7CpvQjhx3moG1giEFF2rPIqybD/kc5D
         cXouqdSAXhHtUI8cAMO6s4tamLzIigpu2mFhjp0c=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 09 May 2023 23:26:26 +0200
Subject: [PATCH] soc: qcom: ocmem: Add OCMEM hardware version print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-ocmem-hwver-v1-1-b83ece3f2168@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAIG6WmQC/x2NQQ7CIBAAv9Ls2W0Qqha/Ynpg11U4AApJrWn6d
 6nHSWYyK1QpQSpcuxWKzKGGnBocDx2wd+kpGO6NQStt1ElZzBwlov/MUtBaYjKGlB4JWkGuClJ
 xif3evDlHjDWO9jLguR/67y69ijzC8l/epm37Ae0G/yaCAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=pvHSiUMrczlMpzSjgH+98eice2Ngyu7aqn2T7T+Okic=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkWrqDpj1sUUfQqreFLtR4JdyyUP7ZfENK6SceR
 vBqM44szPSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFq6gwAKCRBy2EO4nU3X
 VrAuEADC9NMIwT7yWuSHJUCkwcdMIjKBRfufFiscJ8TeBnSsyNnk6AeKjijmdY4t3D2DmlfN9t5
 IHwD0LP5/bxQ1IHfLr0OSoT+NR0UI74g4Tfyhu7CacoH0/mzEeJbkEp3nSDbGKaVFnCyfzHnULY
 N0e3bTRL5WBxpJK3CGxszoGqoGeN6gtY4cl4XzGhAhR+nQeXCilgR5LUWMuj3hc5Dgf7RB75kAs
 K5qhSgwDm4TQg+1/6CZEtY1iAiJ9se/87YQ4JJCvPZJ13ElCSMI9XOeFp230Sf1ZOze9XzkSgN9
 vo1cw94wbZliAyboEo+UWfHv7BJ89NKyGZZn5fjhB/XAbODjPJR+wm+SOYcVI4pgUDKxkkZuIuo
 zB9wiZWSLgGDJ7rTf88h7Sn8Ju1mPWxgMSjQRoMGqVnkiu/fHr3mrTf4OQ0fFQMN5RTBhm4ZvZb
 SfCJcekV81adgSJqdzt6u4EIsbmuf5WCIXvL80JcMEJvfr9v+dENUz7WagcxXADTetvGuaXXo2d
 a61HW5Xj+WCnrMtYDBxUVZZMcx+8cekDdo91whrx+5U3ONJ4Ffh8cxrulgZjtUR/EkH1B8v9xxH
 1V5bNyF/NimZBAFB76OUV/EwfRfd6gCDm6j6aLEGajhYOPqlNlLTzqJAzjDW9Ui9/NCVjkCLzPJ
 EKkpNTMIBbNUhsw==
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
 drivers/soc/qcom/ocmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 199fe9872035..aa9b3c2c1322 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -355,6 +355,10 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
+	dev_dbg(dev, "OCMEM hardware version: %ld.%ld.%ld\n",
+		(reg >> 28) & 0x0F, (reg >> 16) & 0xFFF, reg & 0xFFFF);
+
 	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
 	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
 	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);

---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230509-ocmem-hwver-99bcb33b028b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

