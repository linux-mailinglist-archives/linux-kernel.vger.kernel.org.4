Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7858B60F92F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiJ0Nfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiJ0Nfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:35:43 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186E1805B4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:35:43 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id mi9so1259317qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ybstN7f+kXd58VgRIov/9s6MeFgWJ+N6wj257nI0Lg=;
        b=ayUh8+OznejXo7f1dKWpgAMW3XuQtibP2G1DZgTqysx++FMKRtun60GcOPXiQfrt+8
         jRQpG50j2IU4zKFP0YxPUJ1Zxg5IMZK1zGunVusO/5m3nHZ20MXtQp+Qu5sxEreJjfLp
         l9wh3ZYONuvKcG5HW09HyYp3eZ6t/215AUOxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ybstN7f+kXd58VgRIov/9s6MeFgWJ+N6wj257nI0Lg=;
        b=gH0otLzrWE0qkFkextKfKXITL3iLtgRcHpgsAvs0Nb3IYHLNik3DhKosrCx/hQVeEz
         HTaYys6eho/a+M86zncE2syY2lsD1GLa99TaIZW6rz2SFQ4ZIpVe4qhaYB15oSY1KDJH
         UTFvjaC3TjA9L5/OUktDeQo0s6Ze0EXsoxpBIM4owIwlUHNnks0kgFYoU+oLvd6crHz+
         yFNomcSfeKpwi3Dp/e8avtC0Gi09d/dIAeNOevnsF6/jItld0CPPqBqvkgoj1/UYsI/1
         Wt31pVjH0R4/0qhPL6xF3WVEvJ5Q8csjGLlcq7/OaVFrwTi2bOuFVUS57D0tKXriD+GG
         AHiA==
X-Gm-Message-State: ACrzQf0eTa+Mrtqdmio5lzCl61TA6hSOxBth4fw3V+FaFplkA359CkHH
        DoYDFlnK/Swxmucxk5Y9q+xC+qp3mvdSWE9O
X-Google-Smtp-Source: AMsMyM6GjEspIfDhmpWT+Lgb6seweBY5igaXFywtPUP3WVl3yJPb6YUFL08ldQtHPalME0xxS98pjg==
X-Received: by 2002:a05:6214:4015:b0:4b1:78f2:8dfd with SMTP id kd21-20020a056214401500b004b178f28dfdmr42091251qvb.81.1666877731516;
        Thu, 27 Oct 2022 06:35:31 -0700 (PDT)
Received: from xryan.lan (107-142-220-210.lightspeed.wlfrct.sbcglobal.net. [107.142.220.210])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a410300b006eef13ef4c8sm971265qko.94.2022.10.27.06.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 06:35:30 -0700 (PDT)
From:   Liang Yan <lyan@digitalocean.com>
X-Google-Original-From: Liang Yan <lyan@digtalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does not have PERFCTL_CORE bit
Date:   Thu, 27 Oct 2022 09:35:11 -0400
Message-Id: <20221027133511.161922-1-lyan@digtalocean.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
still loads the pmu driver while the cpuid does not have perfctl_core.

The test is running on an EPYC Rome machine.
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
[    0.732097] Performance Events: AMD PMU driver.

By further looking,

==> init_hw_perf_events
    ==> amd_pmu_init
        ==> amd_core_pmu_init
            ==>
                if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
			return 0;

With returning 0, it will bypass amd_pmu_init and return 0 to
init_hw_perf_events, and continue the initialization.

I am not a perf expert and not sure if it is expected for AMD PMU,
otherwise, it would be nice to return -ENODEV instead.

New output after the change:
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
[    0.531609] Performance Events: no PMU driver, software events only.

Signed-off-by: Liang Yan <lyan@digtalocean.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8b70237c33f7..34d3d2944020 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
 	int i;
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
-		return 0;
+		return -ENODEV;
 
 	/* Avoid calculating the value each time in the NMI handler */
 	perf_nmi_window = msecs_to_jiffies(100);
-- 
2.34.1

