Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F66715B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjE3KU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjE3KU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7803116
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so4862260e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442014; x=1688034014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5pKv67SCvWkHc0QurzW12VoUa0PE3F8cR0whlnzmJ0=;
        b=wfbN4jm1v5Ht90KVkR0zLhZmQd6bTPrzSXRI+6OEs5E7AOT09GAY/epcFyNKYLurkn
         jEhhTbCKP702Ar+tGhWJ/BgT6v2Id1QJsC87+YgRPUqMAPM0BpBL/C4CAdSiNpvEGtiO
         8+ea1386sNY9MKJJe2FHBSvo5bRd6rBJwhzfIARE4d58A54iyCgrhayd6IFHUONNS/hM
         cnS+IJ9P1+1TQeS4bcuGN5xTbJbRaUIA4C6j46RiEcIOmtnpxandGsm5k7UhlJbs7bYF
         xirLXUiwS0HMtdzYMBErGcZ4oa6t7FR/2y7jL144Dj8YLR9RSKbaI006AvdJxm49ALMT
         od7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442014; x=1688034014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5pKv67SCvWkHc0QurzW12VoUa0PE3F8cR0whlnzmJ0=;
        b=Qp9W/8ABWcZz3BEsoUbRsVO8yTZm98L3zO5K+HdLjZ3zoX+9p9S6T0LeeLwD8sYG8Q
         zsGZcnhLK04ubk8+NM04d8OE1aHhJzL4VDhHCto8coX2BOqvO2Fo67tmV6n21TtlStUB
         pVq9YwjFADL6xpoDGg7WFj1YwQQzawm1My4TIBctKqgk1/pUTM3viHK1oHPiAb+VXR9q
         IKJuGI5AyOv/ahMY0eQ/Qoy669eFU1reCAoKhV24djBjBczHvuphQYCkFjSi/Mb//VBv
         pbl+z449OnLjZCXZTZXczSmDwfOEgPOAM39hUbd6sxyqO/159FGKpb3XQrnEhYkGxKGI
         t3aA==
X-Gm-Message-State: AC+VfDwplqeUc5VhSrgLoW2VUNrxfwhK5H9TPTzB7DK2wpC7jobGN8kr
        PbpKs0cGB1ZmwAZa6ixYb3Udtw==
X-Google-Smtp-Source: ACHHUZ7pBDQm5wEIq4FCv5g9aoMY7CDigAjTvS2AEatr9+cx5siS2uKW9B2XKPW/qahwjPGDpWse+A==
X-Received: by 2002:ac2:518f:0:b0:4f4:ecdf:115e with SMTP id u15-20020ac2518f000000b004f4ecdf115emr466722lfi.31.1685442014244;
        Tue, 30 May 2023 03:20:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:07 +0200
Subject: [PATCH 08/20] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-8-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=3840;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lbirBFQbhuAVhAb0+63FVhDq39bzOe3C4uTqONUNCjk=;
 b=rst79zGQlnDddeNIjb0+n5GgA/RMNEm224Kx+DthzI+2wx5rd+xMKAxO7qVK8Bz9Rd3nJex7M
 hYe/L8ERvuDD7IQE+5gdB3oAxyh+b2ol3gLtbscGFwkIWT6v/66dsxn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
clock resources within the interconnect framework. This lets us greatly
simplify all of the code handling, as setting the rate comes down to:

u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
write_to_rpm(clock.description, rate_khz);

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 9b4ea4e39b9f..aec192321411 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -22,6 +22,18 @@ enum qcom_icc_type {
 	QCOM_ICC_QNOC,
 };
 
+/**
+ * struct rpm_clk_resource - RPM bus clock resource
+ * @resource_type: RPM resource type of the clock resource
+ * @clock_id: index of the clock resource of a specific resource type
+ * @branch: whether the resource represents a branch clock
+*/
+struct rpm_clk_resource {
+	u32 resource_type;
+	u32 clock_id;
+	bool branch;
+};
+
 #define NUM_BUS_CLKS	2
 
 /**
@@ -47,6 +59,7 @@ struct qcom_icc_provider {
 	int qos_offset;
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool is_on;
@@ -104,6 +117,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
+	const struct rpm_clk_resource *bus_clk_desc;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool keep_alive;
@@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
 
 bool qcom_icc_rpm_smd_available(void);
 int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate);
 
 #endif
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index b0183262ba66..6c51e346b326 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -16,6 +16,7 @@
 #include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
+#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
 
 static struct qcom_smd_rpm *icc_smd_rpm;
 
@@ -44,6 +45,38 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
 
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate)
+{
+	struct clk_smd_rpm_req req = {
+		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+	};
+	int ret;
+
+	/* Branch clocks are only on/off */
+	if (clk->branch) {
+		active_rate = !!active_rate;
+		sleep_rate = !!sleep_rate;
+	}
+
+	req.value = cpu_to_le32(active_rate);
+	ret = qcom_rpm_smd_write(icc_smd_rpm,
+				 QCOM_SMD_RPM_ACTIVE_STATE,
+				 clk->resource_type,
+				 clk->clock_id,
+				 &req, sizeof(req));
+	if (ret)
+		return ret;
+
+	req.value = cpu_to_le32(sleep_rate);
+	return qcom_rpm_smd_write(icc_smd_rpm,
+				  QCOM_SMD_RPM_SLEEP_STATE,
+				  clk->resource_type,
+				  clk->clock_id,
+				  &req, sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_set_bus_rate);
+
 static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
 {
 	icc_smd_rpm = NULL;
@@ -60,6 +93,10 @@ static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* We need the clock driver to kick things off first to avoid ugly races */
+	if (!qcom_smd_rpm_scaling_available())
+		return -EPROBE_DEFER;
+
 	return 0;
 }
 

-- 
2.40.1

