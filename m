Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F1166BE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAPMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjAPMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6D1F487
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so22062671wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ScWzcZ8GlnQaw7+uEXztcqpehjbIj8j0N5YRKyPA8bU=;
        b=WHPVyZdCVyEzH3IQumz+ZQa93TPXD+IvVnD5r+JQl0+23uLtICALw+QIWV2Yh+OEBC
         +/Ig9NhloS97/UP2/soGvPQgGbwWyM4iD5vx0OIdXvWmqPF8vW00G6gJeFha7LFz+0zb
         RfiDzlmmgjZzZdC5eA0NuGwKVeQU0wvwM7wHlISyQEQj+PeXKaKoEVd3tZf66lI15I8A
         9L/yh+PaZuuWaPS6R72qonxwrJmNWTPXWz9qvqYs0sx3ueFYZcQ4E8+ISyx7dg2zgso8
         yeccJi1N6Mi1C8hXYyyfd/6fAC/8KitdyACjiZeNuhE47g7FHPUh6ERVNbwbQulo3c//
         6BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScWzcZ8GlnQaw7+uEXztcqpehjbIj8j0N5YRKyPA8bU=;
        b=5MycN3QLFi6c/8cnW2CL2a+zfyOZIrdSzrrCVZUhxW8Et5f2wgFVE4E6tmfZSJqQaM
         uI7s33dl8Sx83AftSlJ+Dti9UJmoFxaSbcgjkzf+uQ86S3nPmK5mMAl5mNBdxfL1+0cx
         8lRBghtYz9wTknyefnElpqzGC/ERgMbiBca5oP6JahByfvNGVjrHhgu4roS2NPXW524C
         K99z0yX6mEVXILcShRhSSgY2Ks6KQObDDOHGQokPJuLVYHgEqIgNch1NG972pk1k2z2w
         dJ0t+lQUzMUMbZL4szq5m9AM+Cg5K6xRaulfSt+X+Yu0EF9x9lakkYL201T3gX9/kRX2
         tlaw==
X-Gm-Message-State: AFqh2kr7DqoPf5EGZTpg5aunYbpHhdeaqVf+7nTR8e0GoI+HOACIwUTu
        HUy4VfWsMKCksoRo8DIVK4nt2g==
X-Google-Smtp-Source: AMrXdXtBIDna1fmJkgO9b5RpMFwOmD6mfayzSdk8279hx3uLfniDASDnGAKy9HI2AHknxxCIGXuuEQ==
X-Received: by 2002:a05:600c:1e10:b0:3da:1d51:ef9d with SMTP id ay16-20020a05600c1e1000b003da1d51ef9dmr12313675wmb.15.1673873386615;
        Mon, 16 Jan 2023 04:49:46 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:46 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 11/15] kernel: events: Export perf_report_aux_output_id()
Date:   Mon, 16 Jan 2023 12:49:24 +0000
Message-Id: <20230116124928.5440-12-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d56328e5080e..f7036ed53b3f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9399,6 +9399,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

