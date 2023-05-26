Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3745271260E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjEZLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjEZLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:55:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEAE95;
        Fri, 26 May 2023 04:55:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso2109155e9.3;
        Fri, 26 May 2023 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685102132; x=1687694132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4iryfP1qlPbKAm/Yo0Jy1OHqtOanarb9gphCiltoRU=;
        b=bhIl2swS8lqvTF54tQxrySUcCm2jbP5UPDFvFsUlMsyLDhn1M2Ub3LnAf6p/vBcQjF
         YV7HWt2Lh+xrUjhuVLIcC/p7+yoCaENHJuzqIPY7H2sYimSQxJ0IGKKvp+GNTHdz3sSG
         cqil/hgZbj0Pn7SyQ4LJUWcMqjLsnhKlPR7sqB/sqFRKrjmyv7m0iDpFzDozNSnMErwb
         B4G/DuQM+NbvkL1HPj0q1H7KN+fUgOFY+oMzBqeVENUzE50f5ZSpn9KUMH9qPEAYBULT
         Gs35bS6XoCi11PGJyVLjg8AtvBYOVUJ0G1Y7fAcsmyZHJM6lgCkK4rGhicdyq/oWu9Wx
         btLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685102132; x=1687694132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4iryfP1qlPbKAm/Yo0Jy1OHqtOanarb9gphCiltoRU=;
        b=V1v3lldSvdWbZlbgPDDXHEkNZgX6yz06DjA6LSPK2RGogq5Prq+hQDGh4LJ8examBY
         /y40EbdzdFBwlTNZK/ulwSd9kSwtWIhVns6fy08ztaTJsIJWuBmWv2/DlOLImg+PkcZp
         3+9GNz015yosiZm0324dlpp8d72QehMWQhTYl2U+bSIbj5ChYgylLqx3aDUsBC36dxTw
         x5/5+v0Mx3thd6Inu2Zd79hQR44vu+Vo6hvqO2mypanP5JaTNHxc6e7r56rllYTttxiZ
         gkHuMGAPyCyZ88K04vD2NToT5X4eKeqi0u4kTGtK5RMhwV+2ZHT32gq+CkByXDJq9aBS
         B3UQ==
X-Gm-Message-State: AC+VfDyArHI0LoUSDZFzgjZOoqnaYbKHAwMDXuye80euiGGOefgtSXdk
        z8vKashpT+YI/ZXMSSDfI4IW5x5hpBw=
X-Google-Smtp-Source: ACHHUZ66bsEGhzGKhotncJ65yLYUqXb4A+KR8JwI7gS7eWXPiVfPmltg8RYaYQ7i1wFpMeZgHNGi6g==
X-Received: by 2002:a05:600c:3653:b0:3f6:13bb:f00b with SMTP id y19-20020a05600c365300b003f613bbf00bmr1283510wmq.8.1685102132099;
        Fri, 26 May 2023 04:55:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id b21-20020a05600c4e1500b003f4283f5c1bsm15922064wmq.2.2023.05.26.04.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 04:55:31 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup
Date:   Fri, 26 May 2023 13:55:11 +0200
Message-Id: <20230526115511.3328-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS
mem_setup") dropped the relocate check and made pas_mem_setup run
unconditionally. The code was later moved with commit f4e526ff7e38
("soc: qcom: mdt_loader: Extract PAS operations") to
qcom_mdt_pas_init() effectively losing track of what was actually
done.

The assumption that PAS mem_setup can be done anytime was effectively
wrong, with no good reason and this caused regression on some SoC
that use remoteproc to bringup ath11k. One example is IPQ8074 SoC that
effectively broke resulting in remoteproc silently die and ath11k not
working.

On this SoC FW relocate is not enabled and PAS mem_setup was correctly
skipped in previous kernel version resulting in correct bringup and
function of remoteproc and ath11k.

To fix the regression, reintroduce the relocate check in
qcom_mdt_pas_init() and correctly skip PAS mem_setup where relocate is
not enabled.

Fixes: ebeb20a9cd3f ("soc: qcom: mdt_loader: Always invoke PAS mem_setup")
Tested-by: Robert Marko <robimarko@gmail.com>
Co-developed-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/soc/qcom/mdt_loader.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 33dd8c315eb7..46820bcdae98 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -210,6 +210,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	const struct elf32_hdr *ehdr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
+	bool relocate = false;
 	size_t metadata_len;
 	void *metadata;
 	int ret;
@@ -224,6 +225,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		if (!mdt_phdr_valid(phdr))
 			continue;
 
+		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
+			relocate = true;
+
 		if (phdr->p_paddr < min_addr)
 			min_addr = phdr->p_paddr;
 
@@ -246,11 +250,13 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		goto out;
 	}
 
-	ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
-	if (ret) {
-		/* Unable to set up relocation */
-		dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
-		goto out;
+	if (relocate) {
+		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
+		if (ret) {
+			/* Unable to set up relocation */
+			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
+			goto out;
+		}
 	}
 
 out:
-- 
2.39.2

