Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9B6BD2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCPOq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCPOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:46:55 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055B85B3A;
        Thu, 16 Mar 2023 07:46:50 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id g9so1359325qvt.8;
        Thu, 16 Mar 2023 07:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLpipT1Tz1VQNjc5cu78WLpqLixJr0rtLfLSC6kntW0=;
        b=Ank8+IsQU7jzldv3EGq+/Y9Ej8AAFI7UdtmdBrGUemD/Nyieos04AyvVD7cryh1Vzs
         hwzVMHlSVQNJRCuY4VyaC8Nar4tmRIHxMyfgUlB399djPlq0YeBymIc0XFCmPnRF1Yw4
         g5NGVPtE13Sk5DxkzkIqtJsWhNJKdDorYhuANOjcp8PIMghdCT5V4Wb6DzQjdawOPs8F
         T05nP39aQ87XczQEiZC2URkV2l0LQE+ViTwcVF0ty1c4cSEr83HOmUniAbmhT3X2k1kv
         1BoS4FJa/H53fm3DTv8Bj04a/lVO7gHHgI2pzWKdoFtEgdxOjsH3uIK+ekjlyaiv/FxN
         jgRA==
X-Gm-Message-State: AO0yUKVk/cA/uBoLNI5xrg2vd1k3Tgfi401UTEcCmMmEnYHfg9IRHtZg
        uEYdPmiN6gWCYjdjra+0jAw=
X-Google-Smtp-Source: AK7set8OXkpPwJfLRPv/02lUQWiXkybBSK7AvUo0XEpMYajc8NNY4msMpjsKmnxoytxUDVXjt8Tshw==
X-Received: by 2002:a05:6214:20c1:b0:56e:af8a:a85b with SMTP id 1-20020a05621420c100b0056eaf8aa85bmr39029442qve.7.1678978009296;
        Thu, 16 Mar 2023 07:46:49 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id d192-20020ae9efc9000000b00745df1fac2bsm4664913qkg.76.2023.03.16.07.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:46:41 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc:     bwensley@redhat.com, constantine.shulyupin@gmail.com,
        Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] tracing/hwlat: Replace sched_setaffinity with set_cpus_allowed_ptr
Date:   Thu, 16 Mar 2023 16:45:35 +0200
Message-Id: <20230316144535.1004952-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with the behavior of hwlat in a container,
resulting in incorrect output. A warning message is generated:
"cpumask changed while in round-robin mode, switching to mode none",
and the tracing_cpumask is ignored. This issue arises because
the kernel thread, hwlatd, is not a part of the container, and
the function sched_setaffinity is unable to locate it using its PID.
Additionally, the task_struct of hwlatd is already known.
Ultimately, the function set_cpus_allowed_ptr achieves
the same outcome as sched_setaffinity, but employs task_struct
instead of PID.

Test case:

  # cd /sys/kernel/tracing
  # echo 0 > tracing_on
  # echo round-robin > hwlat_detector/mode
  # echo hwlat > current_tracer
  # unshare --fork --pid bash -c 'echo 1 > tracing_on'
  # dmesg -c

Actual behavior:

[573502.809060] hwlat_detector: cpumask changed while in round-robin mode, switching to mode none

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/trace/trace_hwlat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d440ddd5fd8b..444dfc31f258 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -339,7 +339,7 @@ static void move_to_next_cpu(void)
 	cpumask_clear(current_mask);
 	cpumask_set_cpu(next_cpu, current_mask);
 
-	sched_setaffinity(0, current_mask);
+	set_cpus_allowed_ptr(current, current_mask);
 	return;
 
  change_mode:
@@ -446,7 +446,7 @@ static int start_single_kthread(struct trace_array *tr)
 
 	}
 
-	sched_setaffinity(kthread->pid, current_mask);
+	set_cpus_allowed_ptr(kthread, current_mask);
 
 	kdata->kthread = kthread;
 	wake_up_process(kthread);
-- 
2.39.2

