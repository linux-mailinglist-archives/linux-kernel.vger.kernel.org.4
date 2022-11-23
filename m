Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C3636A16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiKWTvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiKWTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CF92B78
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i12so27160057wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhRbA3Bqp5wzwk6l8nkMnlzM8NPWC0TqClYGwAsB7GE=;
        b=cZryXwPDfXWRdMGvqWJnGJRO7WwwLZ6mD2mcnPZr4X+qr6c/03itTmlsif+1sMK+0K
         +ymWQPWywcwdB2f0aGlNCRz3Vusw4tGDHnDQQlsqeziN0XCQSGVQ+T8yVSmRMbav/zYH
         jQp+Qc76B6SMBtg0oIFWcjRcaXNmKnQgif7N4Bhlg0aHUqo68nX7JLJK11PLJff4iHob
         x25BYSba4DwDQzRv0agSGZJcTa4PLQSxIpkUO3wznX5VBLf6oInRPJFsr7woJuPA3ags
         2/JR8mD11FabTwv8yMheCmZlrfgEKZGpPL5EroRGf0e89KxRaK9tQw7D844ieOO7Bcza
         A70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhRbA3Bqp5wzwk6l8nkMnlzM8NPWC0TqClYGwAsB7GE=;
        b=CQatTS+ucTiCngblq8Xr1UPUgwdb5dHW6YY1AmtCYK5q5kmX65Ofxca1uvgK4t4eQr
         sZMBlIFT+QlUFDgSsSQWAZp/5s+dwrClZQ5wVVei/m/aFyDxF68yloDFZs6lO7XfJuPd
         tZ6Iq5vkQcp9FD/j36Wzzdok2FkURxHCq1KcwfQc0ElBmHlji6Ci5yH3nprUWEU+mJBC
         ysOs5Iqh/I9cRyL0wCzJbJ4WpAJQA8+90brWfdbjeH5vTsZJqyoUJKEJx9YGVIbICcSm
         uhHkqRPZ2HZfzd74KrQzLNPOnLDR3n4KpNbUu4hjgkHOkC/ndklDrTkTrEg7Ko+krCk8
         mSdg==
X-Gm-Message-State: ANoB5pmHwKyfWUo4zQkJ2XUX/iOL8PJxdT8DTfyu2w4MpniyAcxbP6jm
        cwOHsYqw3hVRTfhLbck18WpMRS9izG32ag==
X-Google-Smtp-Source: AA0mqf6KKEFVkffTxpaEdfZ0VXAsXtwCJbKntviKH0lMQ0dqFVgelLlQ7xjR+ByXKNG3AkjD+j1JnQ==
X-Received: by 2002:a05:6000:691:b0:241:b92b:d086 with SMTP id bo17-20020a056000069100b00241b92bd086mr18360854wrb.259.1669233029527;
        Wed, 23 Nov 2022 11:50:29 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:29 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 08/14] coresight: trace id: Remove legacy get trace ID function.
Date:   Wed, 23 Nov 2022 19:50:04 +0000
Message-Id: <20221123195010.6859-9-mike.leach@linaro.org>
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

Removes legacy coresight_get_trace_id() function now its use has been
removed from the ETM code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/coresight-pmu.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index ffff4e6277e5..624f4843453e 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -8,7 +8,6 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
 
 /*
  * The legacy Trace ID system based on fixed calculation from the cpu
@@ -44,15 +43,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
-- 
2.17.1

