Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39993614F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiKAQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKAQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04B1C908
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:31:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs21so20912251wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GM5W8kdEVZTdrJaLxSP8hWg1gbfPZ58r3qozGiSOj2M=;
        b=SxPqmxfIyvPOuEndXUQFG+OUFf7gJowHMKLuR43rLJqZMJzPjxWJCbL8bE/XilZt6u
         6OcjOItYooR+Q2TvHWn8iOG0TOznhm5YwJKGEfJuGuWM92s+qjwmDdYep/0sR/01hARH
         k77ELga2o+iLBhcgPLz5FQDVv4DLsVvS+i04iHADLF7Fhna9/c0urtxzzElRtrN5atxI
         diKTnNlY174lxr1n0aCGRLhts1ZUoTTsgQ3KfDI/iVWLKesoS1sjrLg/wfNiINooyk2A
         EFvbRZPbQY+OETVwXNJ3MAbquUr6loK4yFJLVh+6ocClsDMRcQr+YHwhiTfwbrBKTJJQ
         L4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GM5W8kdEVZTdrJaLxSP8hWg1gbfPZ58r3qozGiSOj2M=;
        b=5t7MVRXODqvGXx5SoqG1wsJYftJnM8gE2id1sKVCqyaai2SU6sefuQGRl4A5UerTcr
         MDb3jgW6YFjymZELFCEnrbuFwsvsAxljFmRaXp0CzZnsZ+HvJ8lb+pm/W9swTH44gO83
         T8kWv7qavc8OrsmCdrqWEPWmvuYeoYwKyBxtgXYXIGRkTkbK3JxW8r1ROcgosU8cJsp/
         Of/LqejwBD6WAdHg9CXkITfC5S+Th9Psx8NQ/3L9fv8Aata5ZYPS0wOXjJ/0CTdcQLn5
         h/LCc/MmI6xA+2sQIJA5wY4PtfPlOxxIMNzPowywdIYboZZGATpAeybEGIzEth7vYQUP
         i+3g==
X-Gm-Message-State: ACrzQf2kKAg2HpxRBNfWfTP7BaJUAEswLQpfjykgzh7v3OzHDh9Z1lFU
        3kaPXRfMpl7xChr83o0CjmAcSQ==
X-Google-Smtp-Source: AMsMyM52kTyY2RnZxPGxRTLot7eIkG3eHfeIhr7G9iQxfhQaC2JfM90ZbCC99T+2gAx1zv6joxmHVg==
X-Received: by 2002:a5d:484f:0:b0:236:9c97:6f85 with SMTP id n15-20020a5d484f000000b002369c976f85mr12476548wrs.636.1667320290279;
        Tue, 01 Nov 2022 09:31:30 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e844:18b6:fc5:bbc9])
        by smtp.gmail.com with ESMTPSA id bu15-20020a056000078f00b0022ac1be009esm8339844wrb.16.2022.11.01.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:31:29 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 08/14] coresight: trace id: Remove legacy get trace ID function.
Date:   Tue,  1 Nov 2022 16:30:57 +0000
Message-Id: <20221101163103.17921-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101163103.17921-1-mike.leach@linaro.org>
References: <20221101163103.17921-1-mike.leach@linaro.org>
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

