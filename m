Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB0725FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbjFGMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjFGMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:46:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1919B6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:46:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso4280403e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142015; x=1688734015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vB+Qk0nYaVi1WO1VQhpSxexbfUtjHX4k0hpme2L5O4=;
        b=jdN7ywFxLhK8X6RqDS4B0s8KTU2HagkqP0C0NTT0QgNlR6AIqlo7dEneqXoIkus/O6
         ulUaxe6WWr6nHZ0L3T+lJmhC2/MMKT8Zy9Qlb6ISkfrK5LHjgxi9Qjy3Ugv7xZ26br2W
         yTh1YC6M4SOSmTWfNgBiXl5/fL3sVISbT9cHRKUt1m5A5jgGW4o1mHxEyIenDhfabrwA
         eSlRbuWIt3DFLhXAGakzkKUQE/vcohN7w45XJ37kNYzCo8FXp7mIWb+P+1XJxHilF19t
         lLd0THGGA46ca1ZnR32tZ0LphWZmkJ/50icpq91ZS+1TehQBi8pg31CUgZr0qa7Tu5Ed
         OqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142015; x=1688734015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vB+Qk0nYaVi1WO1VQhpSxexbfUtjHX4k0hpme2L5O4=;
        b=hwsQco/hGio8yMitNsgtXcYKucHoJW9X2kJCDWdoC77bsZoQPCIbKPC8Nd7Mf3ZTs3
         dkxshm+g5gm0yOCRIBQfA9RMTsC0KIwi0GhOTxZZS7uACpUtUC1ojzsqutzJU/hYop80
         QVW7RXcNfZyfEt7apRtfR0llFvCaOmQgIE3fZjcW6B6YAxFa17Y2ar3NvKzmlLdmO/5R
         vNqn+BwQPQk0yu93f2dLlLGUWjirL2amAxMOZs0aK12SnnOpJ+2nX5AuUxh7hfq0BEDL
         FvwOOZ7G7i3A8YwOo+5/7wEPnS9kkvK9sQ2nrL/fSSetdQzE1WRGYwcJX/xRFJsmcdiw
         qZaA==
X-Gm-Message-State: AC+VfDz6KjsZRSgxhqKRLZYDv2sTrE32yp2k6LQpX6qEhNaDJ0hSTeVj
        2FaqjeyPo8LvNDeFabEU3w7eIA==
X-Google-Smtp-Source: ACHHUZ6D+C4NpbNoxCfgmPsZQ50kDR5QPp3pkMQp16akUThB15rGqbHji35tEVPV9lef0Imt0aUl7A==
X-Received: by 2002:a19:f808:0:b0:4f1:4cdc:ec03 with SMTP id a8-20020a19f808000000b004f14cdcec03mr1867918lff.18.1686142015701;
        Wed, 07 Jun 2023 05:46:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:46:55 -0700 (PDT)
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
Subject: [PATCH 01/16] firmware: arm_scmi: Extend perf protocol ops to get number of domains
Date:   Wed,  7 Jun 2023 14:46:13 +0200
Message-Id: <20230607124628.157465-2-ulf.hansson@linaro.org>
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

Similar to other protocol ops, it's useful for an scmi module driver to get
the number of supported performance domains, hence let's make this
available by adding a new perf protocol callback. Note that, a user is
being added from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 8 ++++++++
 include/linux/scmi_protocol.h    | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ecf5c4de851b..cf7f0de4d6db 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -333,6 +333,13 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 	return ret;
 }
 
+static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+
+	return pi->num_domains;
+}
+
 static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 				   u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -687,6 +694,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 }
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
+	.num_domains_get = scmi_perf_num_domains_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0ce5746a4470..4e42274a68b7 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -101,6 +101,7 @@ struct scmi_clk_proto_ops {
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
+ * @num_domains_get: gets the number of supported performance domains
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -120,6 +121,7 @@ struct scmi_clk_proto_ops {
  *	or in some other (abstract) scale
  */
 struct scmi_perf_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1

