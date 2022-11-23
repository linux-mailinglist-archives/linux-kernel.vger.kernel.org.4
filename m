Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91C636A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiKWTuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiKWTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497D2786D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so3410050wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PCemn0i95mwoh/MU/VK1Wd9F6OgWQRZUEuH/awNPIM8=;
        b=z218x5Q/M0KY3qzQjZ577viE1gZ3bAfoy6NYn4+j6+8OpNLrY8knQqojg2+3XwSHzZ
         icsi5lw4DkpkIPl3CtoPL7b+PG2gYUWUBwoK179GdLQ0HNkEq/fOKpapRca+exFZZ6JZ
         cuqciA8aWKjlWbkCUUXzOJn0LkCitykQ0f/BDEiIPoidhisHE/C+O626GoBso6sVbtV0
         mVuUbGP/5nqB6Nb6ArObEcCHtvIVhVzPAoo0hm3lWsHDdlDeevMlhdM8DOFKR9C6afQy
         /P712JroPFpdZE4kvQwuAmo3N/kS41ZAhuxVKdC2MXXpKG9UaZ4X3dlk85AGz5/ppqIX
         zUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCemn0i95mwoh/MU/VK1Wd9F6OgWQRZUEuH/awNPIM8=;
        b=hBEHgfyBNtvih1FNrPG+F64ZpYKvyent1pPyzKeC+CFrfcbA4ZHVNb58yTTGkh30nR
         c0C6eir5DGUxxMl0jYbFKClqI9OF1patQCSLYwqTWq0zk+xBmJF4URb9FCYR3vuwhzSX
         /OuU3+TSxJsaApZPht8bT0L4oheI2jpfRWTtQ9me6hHKTcGJIeNSzoRve7g6jMMVJTLt
         lZ54fTtxuOLUaFVBLE50W868jfAAugnsdtghzuj118MKBGK1TqpzFbf/550WCPXq/XLp
         VOtUM8Ir/kNNcDsRkmHXTqfVe/jdd9fcV9dL/sJyulCf6lgEbn1PyojRzCf1NXyUWzXL
         kf1g==
X-Gm-Message-State: ANoB5pkJp47pUKwf/2AxlZkLv5fUqM2l8VkZ+reviSDYm2NOyzME3zhB
        8aBLHh5qYfdCmK1XogcrTU8cHw==
X-Google-Smtp-Source: AA0mqf54X/O6AocXr0g+3elhIcOrpuwp4viSFFefXweQE2Lq6dzCpZcO2F6C9p34Ri1y3O2WMYFVcA==
X-Received: by 2002:adf:e687:0:b0:241:c3c6:cf78 with SMTP id r7-20020adfe687000000b00241c3c6cf78mr14949792wrm.237.1669233022875;
        Wed, 23 Nov 2022 11:50:22 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:22 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 02/14] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Wed, 23 Nov 2022 19:49:58 +0000
Message-Id: <20221123195010.6859-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123195010.6859-1-mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 45 --------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f3068175ca9d..ce3aa845ecc2 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -112,45 +112,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
-static int coresight_id_match(struct device *dev, void *data)
-{
-	int trace_id, i_trace_id;
-	struct coresight_device *csdev, *i_csdev;
-
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/*
-	 * No need to care about oneself and components that are not
-	 * sources or not enabled
-	 */
-	if (i_csdev == csdev || !i_csdev->enable ||
-	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
-		return 0;
-
-	/* Get the source ID for both components */
-	trace_id = source_ops(csdev)->trace_id(csdev);
-	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
-
-	/* All you need is one */
-	if (trace_id == i_trace_id)
-		return 1;
-
-	return 0;
-}
-
-static int coresight_source_is_unique(struct coresight_device *csdev)
-{
-	int trace_id = source_ops(csdev)->trace_id(csdev);
-
-	/* this shouldn't happen */
-	if (trace_id < 0)
-		return 0;
-
-	return !bus_for_each_dev(&coresight_bustype, NULL,
-				 csdev, coresight_id_match);
-}
-
 static int coresight_find_link_inport(struct coresight_device *csdev,
 				      struct coresight_device *parent)
 {
@@ -459,12 +420,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!coresight_source_is_unique(csdev)) {
-		dev_warn(&csdev->dev, "traceID %d not unique\n",
-			 source_ops(csdev)->trace_id(csdev));
-		return -EINVAL;
-	}
-
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
 			ret = coresight_control_assoc_ectdev(csdev, true);
-- 
2.17.1

