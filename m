Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E2725FDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbjFGMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbjFGMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716110DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:46:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso3783168e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142018; x=1688734018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT1gco3SixkDR/OziK3JosQemihuanLlknRMm9B1CS8=;
        b=i7i4/XQ2a6an/rgAvd96eO9/R9qJ16QRQxIAyqU//tp/p+4ptLtiF/GRaZWa8F5Ms8
         sfsY51UWBXFbRQf4w/yJrgERsCiJWMaK3ue7f09ilyWHcp2ohVoj2lYvuyMIcEVYsdQD
         DWBt1K81UovndWUzvPlDTHJc9mv2CpWzMx3n5WkfF+v5nucFQYKe3BAEA66GMzCNLTjm
         017he3Em1AkvxbdBWCXodi5shTK19rROLQgBLg7y2M1KGlzySoxIr3ZLMQL6wGHE7w5Z
         LDuN79gPUIUxoWxNSkmTSTLsFRvBDJ5+TaFVlNkrT0v6loTeyr74gxtncpR8MVYzI2gz
         7gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142018; x=1688734018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT1gco3SixkDR/OziK3JosQemihuanLlknRMm9B1CS8=;
        b=FSEj1XSBnN+veM5Pkk+PefWUfnILsrn1UG4zl9FrFvx0Xwwp6sk6ODMDhX+Rvn/rrI
         uaRH9MxyfXx9En1+mDU2yGcduSvtyCpE6snpnIJuC9qfXgq2omO+ZpEXfe3ZORGfL4A1
         B3WThKWdz+EWaIf5JkPtxq7i5SR4t38VVYK0Qx1PzzFRQ12EsJjFcPViBuiASvExzikO
         IOFWYj5Y6aitTry59XRmBMSi3ihMFJVOh1VjUeQLcoQwwdSk95j1rZF6VP8/9YSmXFU1
         nyOqzg/R11Bjd4Tu+BYAqmWC8UXQScaKbkDks7BeanU2Bp7OjeJlHI63VZYPi2VVNuMw
         Npew==
X-Gm-Message-State: AC+VfDwNALnhkDYc6Mf7TuCMnYok10R3TNCnGNk5QjBIlhNTmuAkzEv/
        F7s0ORJETp/ewx94XM+S3MMDMg==
X-Google-Smtp-Source: ACHHUZ46s+CAtlnvjg/Pe4nAxStehloY+FWgmNeOggKS/r6wguvflGLIBjohnTHGZRMM8IbnFecjOw==
X-Received: by 2002:a19:f806:0:b0:4ee:dafa:cb00 with SMTP id a6-20020a19f806000000b004eedafacb00mr2163873lff.60.1686142018272;
        Wed, 07 Jun 2023 05:46:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:46:57 -0700 (PDT)
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
Subject: [PATCH 03/16] firmware: arm_scmi: Extend perf protocol ops to inform of set level support
Date:   Wed,  7 Jun 2023 14:46:15 +0200
Message-Id: <20230607124628.157465-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a subsequent change show, it's useful for an scmi module driver to know
if a performance domain can support the set level operation, hence let's
make this available by adding a new perf protocol callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 10 ++++++++++
 include/linux/scmi_protocol.h    |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 5a6ed42bfb55..216bcd68d549 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -440,6 +440,15 @@ static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 	return scmi_perf_mb_limits_get(ph, domain, max_perf, min_perf);
 }
 
+static bool
+scmi_perf_can_level_set(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	return dom->set_perf;
+}
+
 static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
 				  u32 domain, u32 level, bool poll)
 {
@@ -707,6 +716,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.name_get = scmi_perf_name_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
+	.can_level_set = scmi_perf_can_level_set,
 	.level_set = scmi_perf_level_set,
 	.level_get = scmi_perf_level_get,
 	.device_domain_id = scmi_dev_domain_id,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 07152a0baee3..99c3e985c40f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -129,6 +129,7 @@ struct scmi_perf_proto_ops {
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 *max_perf, u32 *min_perf);
+	bool (*can_level_set)(const struct scmi_protocol_handle *ph, u32 domain);
 	int (*level_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 level, bool poll);
 	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1

