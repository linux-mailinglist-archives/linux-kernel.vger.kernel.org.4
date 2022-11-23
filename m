Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F458636A29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiKWTvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiKWTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:50:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58137A1A23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x5so26965895wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=Y0wzeg/9IEcrSrRDjm7ewn/WmRVLl9UfqDflyrgJ9IvuIAkyBU71uuBK++bvGEkdBS
         cBKsQM9HBAjhqCRA05xgQhQfmSaQ32g/6tLlrugADv7VQQ1B46VcGwY1VGRZ+0XePHqo
         tUU2qNaUxoTJVRD3r3y7Kx+lb35dMY7UBYvUrG6J+YOzEomA//1xxqz6gdk2bxBUkihB
         RgRMCwsDeT8HCDqK0TuLt5kJTl9bI0/b/eG5k+FzAfSz5IyYKGZU3qDb8UP/0FcAa1aS
         stE219YI2e8ekdnspHR7Xns+ih/fw88y9ATSKPvblGnWdf405TqixObxDC4Fs9o7Ywv1
         nY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/rZtCQJIH1tcdWsQUgVvKDosjDAE+Gq7OIwmjNOiDI=;
        b=gjzuxW8SekFitGB8DlAtDTolBkf8XtUsBcWmaHu31QhJBJzthfLlsMtaePru1Q/OsX
         JecSrZBRorOnp8a2OZk7P5Bn4vh5TZ8y8sQleEytEo/mIN6keTk8JIut7FggK6mFA3lZ
         FIg1B8fGKPcryJhVu1U1TcBmTdyrylkMMtRitsi9hQgJagpuEzdMH1jLNLlnVu2PdlUL
         sUvz5cc2ylUz7w/KBaCAGTHeJVl/4dK3EqT5ASFJWybVUa8lHK0eVqQwb9spaHGUXZV3
         1dNNfcdqpwI41piwL9hx7XQJv0AQ/001RnCZq2RfppIIQh3P6zZ1Up87y4X0QL5AUbnp
         fFBA==
X-Gm-Message-State: ANoB5plGi4zIiT4TefCr6L+5hInKXyxfieXi9JeSBEP4f1dTlvw/TdoW
        HETwlbHUdDjAgshnOxOH/jxnrg==
X-Google-Smtp-Source: AA0mqf5Ymr48oHJexOSABWqRTfaBxwQ6JYV5duyinhabrT6UzI2CSiqCwawpQ+QIa/NWw32+bwWSJg==
X-Received: by 2002:adf:f805:0:b0:236:ef0b:68c5 with SMTP id s5-20020adff805000000b00236ef0b68c5mr18911996wrp.373.1669233032908;
        Wed, 23 Nov 2022 11:50:32 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002364c77bcacsm7267414wru.38.2022.11.23.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:50:32 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 11/14] kernel: events: Export perf_report_aux_output_id()
Date:   Wed, 23 Nov 2022 19:50:07 +0000
Message-Id: <20221123195010.6859-12-mike.leach@linaro.org>
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

CoreSight trace being updated to use the perf_report_aux_output_id()
in a similar way to intel-pt.

This function in needs export visibility to allow it to be called from
kernel loadable modules, which CoreSight may configured to be built as.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..ad388552f1d5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9231,6 +9231,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

