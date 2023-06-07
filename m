Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D8725FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbjFGMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjFGMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498DE198B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f122ff663eso9008412e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142022; x=1688734022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5W7DSQz0XGzmUVAYDRU/7Hmd5AwjW0mpCMReAxukdE=;
        b=mLisO38cP2z5noWRWcLzOzp5YY32LvUp+JEhRltnTXAD5TBbox8aP89KUVN8s3fsR/
         DwWY0uYoSa+nJQIzB7r2e+rf/KI2bFuH95ESITDpTx48nHfmHA9beT7WQtANyf+vrVSJ
         bHpXxH3oms+bkrCG34OXoGenW9T09xFUvu5grPmMzTCSwlIEdCCaL9L8CjwbITbX5UxW
         HRGWN6fu6RvRAqPm9CRpY1Pbnz5eidioS4YLshqVIC1zwVzHiLGGpNYIqjP6cUJNvbCi
         0FKAxwYVhaugeILq7zV3Uvj/YsWOneb1cxLDBZYXtZYv18jjAvsa2Y8cyeIbWOGUqfNS
         3mOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142022; x=1688734022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5W7DSQz0XGzmUVAYDRU/7Hmd5AwjW0mpCMReAxukdE=;
        b=Mom1HpvOYPzUp/PVcDaduU/Cv688QXvtlwE1cSw8GIO0npJl7ObHayr9U9/9Ygsh2K
         KsDI97HwiqSSDszHQjDNrGuwckbfbA7SPiLsSsP5gtDHX1uEJ2MK8PU5ii89cVxxtK5D
         Mp4sGTScKbEes80vbfwdEXb9hym9HaKK7HoGpO1HkFObj86Eu3O6e25Qpcaqqww5lWNQ
         9FffhKTsSAmGnqKMcmPRQAT0JGps6p3NBFZmVCD2LLlvL5H4wCSTAeb+5zQQBP7ZScZD
         kpju466hzNNt9sqtEvAxNZFj89TOoDo2dxieptdFcJJL49BxPabiv2Tfrr4KV5taQknU
         pJ8Q==
X-Gm-Message-State: AC+VfDy7V1RIowA8/B7IGnESxysAl5VrO+68EKAFoBlAb5BCfmdZGSiE
        5Pjsp5YnKS7iXOC0LGNBOs2GnA==
X-Google-Smtp-Source: ACHHUZ7g1f70lwwKvVi9uQ9AnE07znTdJVmBmwg54LTiryfbtvg3r86goEy/WPUp84BpZGMefKd3FQ==
X-Received: by 2002:ac2:59c8:0:b0:4f3:8196:80c8 with SMTP id x8-20020ac259c8000000b004f3819680c8mr1943174lfn.1.1686142022518;
        Wed, 07 Jun 2023 05:47:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
Date:   Wed,  7 Jun 2023 14:46:18 +0200
Message-Id: <20230607124628.157465-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no longer any users of the ->device_domain_id() ops in the
scmi_perf_proto_ops, therefore let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 13 -------------
 include/linux/scmi_protocol.h    |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 563fa44b1a71..9c5340f590e4 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -580,18 +580,6 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 	*p_fc = fc;
 }
 
-/* Device specific ops */
-static int scmi_dev_domain_id(struct device *dev)
-{
-	struct of_phandle_args clkspec;
-
-	if (of_parse_phandle_with_args(dev->of_node, "clocks", "#clock-cells",
-				       0, &clkspec))
-		return -EINVAL;
-
-	return clkspec.args[0];
-}
-
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev, u32 domain)
 {
@@ -711,7 +699,6 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.can_level_set = scmi_perf_can_level_set,
 	.level_set = scmi_perf_level_set,
 	.level_get = scmi_perf_level_get,
-	.device_domain_id = scmi_dev_domain_id,
 	.transition_latency_get = scmi_dvfs_transition_latency_get,
 	.device_opps_add = scmi_dvfs_device_opps_add,
 	.freq_set = scmi_dvfs_freq_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 34ecaeeb51bc..21aea1b2a355 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -107,7 +107,6 @@ struct scmi_clk_proto_ops {
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
  * @level_get: gets the performance level of a domain
- * @device_domain_id: gets the scmi domain id for a given device
  * @transition_latency_get: gets the DVFS transition latency for a given device
  * @device_opps_add: adds all the OPPs for a given device
  * @freq_set: sets the frequency for a given device using sustained frequency
@@ -134,7 +133,6 @@ struct scmi_perf_proto_ops {
 			 u32 level, bool poll);
 	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 *level, bool poll);
-	int (*device_domain_id)(struct device *dev);
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
 				      u32 domain);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
-- 
2.34.1

