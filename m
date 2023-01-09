Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93DF66267D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjAINHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjAINHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:07:17 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B36164A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:05:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bt23so12803197lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjtKBsVWMgW2GNrLzxrlTPfu2SeNxxyqf1piISfDRW4=;
        b=KCy8NCQr4FTC5yvXL+uWYFlwRFVQgxvS4bSsuh2yOuf1XOlsE/t9EMrCSoWppt5Xdp
         jw6mcBDXBFRnII7VuMlNooeCIjlGtNqmKP4G6xpj5+Hu+++iC8NiMa3cE8LvluMRpEfL
         i1ZP7f+yXGDVHZ5WawXpwpmu4WajyHcaHbyevUzXzY+vysnuwpIf6Fdbs0AwnPdAX5GN
         fDthPNVjVwh8LM9AKd8M0H/X7xiaOrJndOhxf+FhA80lVNcBr5XWfV4MetLXzdYnS9Lz
         8ZbF3wAt7NLKXJ1aKfrv38EPCW0dknu25oEi6IELP3rLzk3M2Ed3jO1hd2JcZpnaj6U2
         rBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjtKBsVWMgW2GNrLzxrlTPfu2SeNxxyqf1piISfDRW4=;
        b=SPHgFJDHRbdiljQ5KYkXByBzln+BZABlZ/dgmcqgzbRq03ixG4G+K9qYaohH80nh95
         MVj8QF/YQHJU0wefDUvU4hel4cYpX6NHAsnbOYrcPFEtGEpSoz0qDCaLblUhOr600QLm
         Tmqlv97x2cREkITTv7s7rBeeuXqcOLkVVgjwZPs+M2BjOgUOEng5jzG3ii4oA5+S/pWg
         cg2XhlU8xcszYQ0gEWhEmJyOQ24uJpG23m2QFHwl7TObu5LyCKMiRaWw0IdpRv3Rl8vS
         SY1XgnO8qTNwBLHJlL3vyy5/n/bPcvTq8n1XUQkL9Wsid2pODQRf3fvnbkM1OuXrSidk
         axRw==
X-Gm-Message-State: AFqh2kqQsjklHPkZzqBz8OSdx9ejFEa4lTnI/jxaaVYyjrpDkw5JfwVY
        QPMvNM0WH+cCynb5cEXLLAbhaA==
X-Google-Smtp-Source: AMrXdXuwlQbA69Cc+KH4JH40+vtgHTn9f3ID5J0i5tA5eCZEbjUOcTII4YbpYww87qLbhRMPaxEJkg==
X-Received: by 2002:a05:6512:b23:b0:4cb:d3:3b99 with SMTP id w35-20020a0565120b2300b004cb00d33b99mr16785246lfu.36.1673269530153;
        Mon, 09 Jan 2023 05:05:30 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512360100b004cc5e97d356sm1615031lfs.148.2023.01.09.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:05:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 2/3] soc: qcom: rmtfs: Optionally map RMTFS to more VMs
Date:   Mon,  9 Jan 2023 14:05:22 +0100
Message-Id: <20230109130523.298971-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109130523.298971-1-konrad.dybcio@linaro.org>
References: <20230109130523.298971-1-konrad.dybcio@linaro.org>
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

From: Loic Poulain <loic.poulain@linaro.org>

Some SoCs require that RMTFS is also mapped to the NAV VM. Trying to
power on the modem without that results in the whole platform
crashing and forces a hard reboot within about 2 seconds. Add support
for mapping the region to additional VMs, such as NAV to open a path
towards enabling modem on such platforms.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
[Konrad: reword, make conditional and flexible, add a define for NAV VMID]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v3 -> v4:
No changes

 drivers/soc/qcom/rmtfs_mem.c | 29 ++++++++++++++++++++++-------
 include/linux/qcom_scm.h     |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0feaae357821..9d59ad509a5c 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -17,6 +17,7 @@
 #include <linux/qcom_scm.h>
 
 #define QCOM_RMTFS_MEM_DEV_MAX	(MINORMASK + 1)
+#define NUM_MAX_VMIDS		2
 
 static dev_t qcom_rmtfs_mem_major;
 
@@ -171,12 +172,12 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
 static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct qcom_scm_vmperm perms[2];
+	struct qcom_scm_vmperm perms[NUM_MAX_VMIDS + 1];
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
 	u32 client_id;
-	u32 vmid;
-	int ret;
+	u32 num_vmids, vmid[NUM_MAX_VMIDS];
+	int ret, i;
 
 	rmem = of_reserved_mem_lookup(node);
 	if (!rmem) {
@@ -226,7 +227,18 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		goto put_device;
 	}
 
-	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
+	num_vmids = of_property_count_u32_elems(node, "qcom,vmid");
+	if (num_vmids < 0) {
+		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", ret);
+		goto remove_cdev;
+	} else if (num_vmids > NUM_MAX_VMIDS) {
+		dev_warn(&pdev->dev,
+			 "too many VMIDs (%d) specified! Only mapping first %d entries\n",
+			 num_vmids, NUM_MAX_VMIDS);
+		num_vmids = NUM_MAX_VMIDS;
+	}
+
+	ret = of_property_read_u32_array(node, "qcom,vmid", vmid, num_vmids);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
 		goto remove_cdev;
@@ -238,12 +250,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 		perms[0].vmid = QCOM_SCM_VMID_HLOS;
 		perms[0].perm = QCOM_SCM_PERM_RW;
-		perms[1].vmid = vmid;
-		perms[1].perm = QCOM_SCM_PERM_RW;
+
+		for (i = 0; i < num_vmids; i++) {
+			perms[i + 1].vmid = vmid[i];
+			perms[i + 1].perm = QCOM_SCM_PERM_RW;
+		}
 
 		rmtfs_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
 		ret = qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
-					  &rmtfs_mem->perms, perms, 2);
+					  &rmtfs_mem->perms, perms, num_vmids + 1);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "assign memory failed\n");
 			goto remove_cdev;
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644a01a..150b72edb879 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -55,6 +55,7 @@ enum qcom_scm_ice_cipher {
 #define QCOM_SCM_VMID_MSS_MSA    0xF
 #define QCOM_SCM_VMID_WLAN       0x18
 #define QCOM_SCM_VMID_WLAN_CE    0x19
+#define QCOM_SCM_VMID_NAV        0x2B
 #define QCOM_SCM_PERM_READ       0x4
 #define QCOM_SCM_PERM_WRITE      0x2
 #define QCOM_SCM_PERM_EXEC       0x1
-- 
2.39.0

