Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36D6369F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiKWTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKWTio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:38:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F3B663C5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:38:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso1595364wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA1TxnCI4aGjZIOXtnNz0T0s8Q9jNSPBYnICWkTbI38=;
        b=cEKZO+LqY/b+Azmi1mie8YZvHvVtdHyjovX4gtNAenqcxgFrJtJXWWtKI0FhXXBTNb
         UlxrJKXLyd4E2xz9jKo129BwTISIEvXAGZ1/fE3/6wz5/UA7FCxJNlT1hzunXygzf00L
         eRbkHYSKt48Qi+kwOtuKHePKVi8XPWbtzo0Q6YeAWhjTfW8Ir6Ff5hpIbjNxlq5eFRms
         UJNyu7J3tVvqHXA1i1rakesVNrdZWIRJ/ebdkhXFRfK6KB72EbD8Oa5m1zWb1Sbc9hfb
         ue3aq0A7ka0tHvvo9JqVClOBEeUnfqJk5jVGlAxLXbv/hIqfpoyUf2TAWlSjakd0RYxp
         Di1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA1TxnCI4aGjZIOXtnNz0T0s8Q9jNSPBYnICWkTbI38=;
        b=H6twAFTu4a5M34S8eyQt2xdoHDBlML/2okPpDF2v8o2dKKT56asvtg0JGrVh/R5LX9
         RH30OZI4SP0ii/4izkFBi18EwqWtIfgntz8k7CuFLoVAdwMmeciXCuEwjP8VQoeos0uO
         xw7utowkRMsFtHnTYQThsHECU4bHEFafz1IDA1Zl5ONxEKarh+LIYsH/iqdS+yUWRCPq
         kG+gXf2L1xRHUarFxWCRNYzaI682V8UVeMBp0Tol6Dp2n9YGE94t7CQUDhHbbFXzJ15s
         0nZ7XW2zGcVfxfvJIw4oW0Ns391P7pL8afwM/79WL74XNJNFvR9u9rInC8VINLnwQOld
         8Qbg==
X-Gm-Message-State: ANoB5pmu4RAy4d2cI5OYtpPh57LZ6aAu6SKWippxOh26MJeb6gu6IT7c
        BFNTgrHyoN2INPpHq0GMr1Ts3g==
X-Google-Smtp-Source: AA0mqf7ZSt1rSGF1YqE7COxjrjursOSSTsUwt13ItIc/EsU8/0abpA3W0v7xlVBFFkakcDJUH1CxjA==
X-Received: by 2002:a05:600c:1e1a:b0:3cf:7959:d8be with SMTP id ay26-20020a05600c1e1a00b003cf7959d8bemr13496374wmb.85.1669232320798;
        Wed, 23 Nov 2022 11:38:40 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:fcbc:7b5d:8d6c:43a4])
        by smtp.gmail.com with ESMTPSA id q2-20020adff502000000b00241cfa9333fsm11222353wro.5.2022.11.23.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:38:39 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, acme@kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: cti: Fix null pointer error on CTI init before ETM
Date:   Wed, 23 Nov 2022 19:38:18 +0000
Message-Id: <20221123193818.6253-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CTI is discovered first then the function
coresight_set_assoc_ectdev_mutex() is called to set the association
between CTI and ETM device. Recent lockdep fix passes a null pointer.

This patch passes the correct pointer.

Before patch: log of boot oops sequence with CTI discovered first:

[   12.424091]  cs_system_cfg: CoreSight Configuration manager initialised
[   12.483474] coresight cti_sys0: CTI initialized
[   12.488109] coresight cti_sys1: CTI initialized
[   12.503594] coresight cti_cpu0: CTI initialized
[   12.517877] coresight-cpu-debug 850000.debug: Coresight debug-CPU0 initialized
[   12.523479] coresight-cpu-debug 852000.debug: Coresight debug-CPU1 initialized
[   12.529926] coresight-cpu-debug 854000.debug: Coresight debug-CPU2 initialized
[   12.541808] coresight stm0: STM32 initialized
[   12.544421] coresight-cpu-debug 856000.debug: Coresight debug-CPU3 initialized
[   12.585639] coresight cti_cpu1: CTI initialized
[   12.614028] coresight cti_cpu2: CTI initialized
[   12.631679] CSCFG registered etm0
[   12.633920] coresight etm0: CPU0: etm v4.0 initialized
[   12.656392] coresight cti_cpu3: CTI initialized

...

[   12.708383] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000348

...

[   12.755094] Internal error: Oops: 0000000096000044 [#1] SMP
[   12.761817] Modules linked in: coresight_etm4x(+) coresight_tmc coresight_cpu_debug coresight_replicator coresight_funnel coresight_cti coresight_tpiu coresight_stm coresight
[   12.767210] CPU: 3 PID: 1346 Comm: systemd-udevd Not tainted 6.1.0-rc3tid-v6tid-v6-235166-gf7f7d7a2204a-dirty #498
[   12.782827] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   12.793154] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.800010] pc : coresight_set_assoc_ectdev_mutex+0x30/0x50 [coresight]
[   12.806694] lr : coresight_set_assoc_ectdev_mutex+0x30/0x50 [coresight]

...

[   12.885064] Call trace:
[   12.892352]  coresight_set_assoc_ectdev_mutex+0x30/0x50 [coresight]
[   12.894693]  cti_add_assoc_to_csdev+0x144/0x1b0 [coresight_cti]
[   12.900943]  coresight_register+0x2c8/0x320 [coresight]
[   12.906844]  etm4_add_coresight_dev.isra.27+0x148/0x280 [coresight_etm4x]
[   12.912056]  etm4_probe+0x144/0x1c0 [coresight_etm4x]
[   12.918998]  etm4_probe_amba+0x40/0x78 [coresight_etm4x]
[   12.924032]  amba_probe+0x11c/0x1f0

After patch: similar log

[   12.444467]  cs_system_cfg: CoreSight Configuration manager initialised
[   12.456329] coresight-cpu-debug 850000.debug: Coresight debug-CPU0 initialized
[   12.456754] coresight-cpu-debug 852000.debug: Coresight debug-CPU1 initialized
[   12.469672] coresight-cpu-debug 854000.debug: Coresight debug-CPU2 initialized
[   12.476098] coresight-cpu-debug 856000.debug: Coresight debug-CPU3 initialized
[   12.532409] coresight stm0: STM32 initialized
[   12.533708] coresight cti_sys0: CTI initialized
[   12.539478] coresight cti_sys1: CTI initialized
[   12.550106] coresight cti_cpu0: CTI initialized
[   12.633931] coresight cti_cpu1: CTI initialized
[   12.634664] coresight cti_cpu2: CTI initialized
[   12.638090] coresight cti_cpu3: CTI initialized
[   12.721136] CSCFG registered etm0

...

[   12.762643] CSCFG registered etm1
[   12.762666] coresight etm1: CPU1: etm v4.0 initialized
[   12.776258] CSCFG registered etm2
[   12.776282] coresight etm2: CPU2: etm v4.0 initialized
[   12.784357] CSCFG registered etm3
[   12.785455] coresight etm3: CPU3: etm v4.0 initialized

Error can also be triggered by manually starting the modules using modprobe
in the following order:

root@linaro-developer:/home/linaro/cs-mods# modprobe coresight
root@linaro-developer:/home/linaro/cs-mods# modprobe coresight-cti
root@linaro-developer:/home/linaro/cs-mods# modprobe coresight-etm4x

Tested on Dragonboard DB410c
Applies to coresight/next

Fixes: 23722fb46725 ("coresight: Fix possible deadlock with lock dependency")

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index c6e8c6542f24..d2cf4f4848e1 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -564,7 +564,7 @@ static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
 			 * if we found a matching csdev then update the ECT
 			 * association pointer for the device with this CTI.
 			 */
-			coresight_set_assoc_ectdev_mutex(csdev->ect_dev,
+			coresight_set_assoc_ectdev_mutex(csdev,
 							 ect_item->csdev);
 			break;
 		}
-- 
2.17.1

