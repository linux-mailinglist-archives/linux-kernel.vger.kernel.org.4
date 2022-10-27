Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EFA60EE19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiJ0CyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiJ0Cx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:53:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170812743D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:53:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p3so38441pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQp+rTjOO9UdjsGEvv6ixHqu9x9F8NVITMJFC8Rdz0Y=;
        b=Bx8Zq1GhyzQTw6V+JmbgzcD8OPYXvIJdoKfXdrU0+qUxDAcHN2MaXNbgRqLENV+7CL
         z61wzbjcJkyAnGsRD1OSVnsBuW74Phb1fMCx/4ZaV/bT8zkG11bu6cC9cBEZApf+sih4
         hDJPX93JP1wqq+kmzWvvfB6jDM9YaoELP+9O8lbsfT+wpSskve4IsaTf0w1/0ZYLNR+8
         mRFMEiZ3i7Iw/eFLGPp3su85U3CTFBbESVq64jQstkgHdIXNRlFksGBnrosfUdOBJV/D
         kAquuGwj/bce5QFzqR4uxfxHa/858FLI6/n53CLBBWz2Lx1JFsV9uiPHuc7aSnRtEbpe
         HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQp+rTjOO9UdjsGEvv6ixHqu9x9F8NVITMJFC8Rdz0Y=;
        b=q/MPxqZ1srQoXvx7Dl8b1FVKBWum7eg3aTDQ+ou+FB23GxZtcV992bALkjw2OEi+hO
         KVVow9bvA6fwpU9I13JnCHA0Drpl4w3Lsb1z6fJapf75Vxp+uC0AQ812UzK1/F4ZQpqs
         +s8ZHig8741nejC9Z5H7/IQETLj2i/Dqc2A9HLC6d30aNDPTcclzQiMpW4UySB2ruFLE
         EE3yBue28Y7deMhfETFCHlevyWvIybeWOSVCRy5LLEimySSoPv+mSCAzE21ecocNoDxh
         lRHjjEinRcY023Z2utPsPqNbuJpw/gxVNk1VNZxOgYbkT/lHnSadD0F7vtsUd5LgESds
         /uZA==
X-Gm-Message-State: ACrzQf1YaRBylpALl1odxSAw0wbeAGuj/fB5AfAXV4xYiD0yWCzdP1wQ
        E3obaT1TzA7ETV8Mlx0Vk7JaTfapWJL1dQ==
X-Google-Smtp-Source: AMsMyM4QbypPpw7SGntDNMlxFfnQRsIOTMnnz5N5dcrh6Nm7I5NadFvNB2Icf4MBJxGJk8/e/yrimQ==
X-Received: by 2002:a17:90b:254e:b0:20b:7e26:f0a0 with SMTP id nw14-20020a17090b254e00b0020b7e26f0a0mr7448390pjb.203.1666839234270;
        Wed, 26 Oct 2022 19:53:54 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id o1-20020aa79781000000b0056b6a22d6c9sm79783pfp.212.2022.10.26.19.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 19:53:53 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] sched/numa: add per-process numa_balancing
Date:   Thu, 27 Oct 2022 10:53:00 +0800
Message-Id: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Introduce
Add PR_NUMA_BALANCING in prctl.

A large number of page faults will cause performance loss when numa
balancing is performing. Thus those processes which care about worst-case
performance need numa balancing disabled. Others, on the contrary, allow a
temporary performance loss in exchange for higher average performance, so
enable numa balancing is better for them.

Numa balancing can only be controlled globally by
/proc/sys/kernel/numa_balancing. Due to the above case, we want to
disable/enable numa_balancing per-process instead.

Set per-process numa balancing:
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DISABLE); //disable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_ENABLE);  //enable
	prctl(PR_NUMA_BALANCING, PR_SET_NUMA_BALANCING_DEFAULT); //follow global
Get numa_balancing state:
	prctl(PR_NUMA_BALANCING, PR_GET_NUMA_BALANCING, &ret);
	cat /proc/<pid>/status | grep NumaB_mode

# Unixbench multithread result
I ran benchmark 20 times, but still have measurement error. I will run
benchmark more precisely on the next version of this patchset.
+-------------------+----------+
|       NAME        | OVERHEAD |
+-------------------+----------+
| Dhrystone2        | -0.27%   |
| Whetstone         | -0.17%   |
| Execl             | -0.92%   |
| File_Copy_1024    | 0.31%    |
| File_Copy_256     | -1.96%   |
| File_Copy_4096    | 0.40%    |
| Pipe_Throughput   | -3.08%   |
| Context_Switching | -1.11%   |
| Process_Creation  | 3.24%    |
| Shell_Scripts_1   | 0.26%    |
| Shell_Scripts_8   | 0.32%    |
| System_Call       | 0.10%    |
+-------------------+----------+
| Total             | -0.21%   |
+-------------------+----------+

# Changes
Changes in v5:
- replace numab_enabled with numa_balancing_mode (Peter Zijlstra)
- make numa_balancing_enabled and numa_balancing_mode inline (Peter Zijlstra)
- use static_branch_inc/dec instead of static_branch_enable/disable (Peter Zijlstra)
- delete CONFIG_NUMA_BALANCING in task_tick_fair (Peter Zijlstra)
- reword commit, use imperative mood (Bagas Sanjaya)
- Unixbench overhead result

Changes in v4:
- code clean: add wrapper function `numa_balancing_enabled`

Changes in v3:
- Fix compile error.

Changes in v2:
- Now PR_NUMA_BALANCING support three states: enabled, disabled, default.
  enabled and disabled will ignore global setting, and default will follow
  global setting.

Gang Li (2):
  sched/numa: use static_branch_inc/dec for sched_numa_balancing
  sched/numa: add per-process numa_balancing

 Documentation/filesystems/proc.rst   |  2 ++
 fs/proc/task_mmu.c                   | 20 ++++++++++++
 include/linux/mm_types.h             |  3 ++
 include/linux/sched/numa_balancing.h | 45 ++++++++++++++++++++++++++
 include/uapi/linux/prctl.h           |  7 +++++
 kernel/fork.c                        |  4 +++
 kernel/sched/core.c                  | 26 +++++++--------
 kernel/sched/fair.c                  |  9 +++---
 kernel/sys.c                         | 47 ++++++++++++++++++++++++++++
 mm/mprotect.c                        |  6 ++--
 10 files changed, 150 insertions(+), 19 deletions(-)

-- 
2.20.1

