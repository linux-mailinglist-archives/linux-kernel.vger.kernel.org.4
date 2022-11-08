Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09FB622085
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKHX56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKHX54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:57:56 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCB5EF8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:57:55 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l127so17226268oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiWDvOMLwtx+qPtph++uEc23arTX0z6pKT8ouEUAZKA=;
        b=VhaLnrVOPlT9+AiF3gjA4pZdCY1AUaJK+gXTX87j1/FvwXegXEM7fcg7DdgAU9OJ0H
         p7kdQDggNPDYuEqWv01Kzj0p9aKeVPNQSNrAGL3b+ZZMXf/6fjNVzJsOe32I+w/uu9Af
         sN0d+/VDQbYNLOxI/jeEeg4saTLX/vXEVN58Vb7g0vr9Euyka4tV/Ga6/k/BqcWCMArU
         X00lBhVoOAuiECivbh/ZelqIzR9qJ8lq680sfxko6PBoMRRgYOoNrHOOoJ9/dkTPTLJY
         uw/xVOXAkr0y8iSUdIgXMr4fv7CaqSfi6VuMrlzwf2Wq0tAbNU4537GrOMEtMsqLJVKk
         v1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiWDvOMLwtx+qPtph++uEc23arTX0z6pKT8ouEUAZKA=;
        b=hYiKuMHPE4Bvd9lnmAjsPtNaYgBhVVLqZyYhpRxzpZiqxAcwdJYD/s4DkyEffju+XO
         /GbFJDjG3TvksYihMTIo2YAPBdQbkHhrSRf/EGUruenx7IDw9JkHPnjWDyroLJrW2gS9
         xtuFc4D/OHRIaY56uOt6fJZYEnas3A3/+dR/5hpvA2AIai7Xszjok765N1tMWzB+xIir
         Fh95iQFb3jGnziEoij9dI51EQBKG5LuXF2/EkTnKeODQVUFjCoyed2BqhnLVFMlELBBe
         +rEgEFJTx1/ZKImDzkX0Asod6ZrMExnn23NaJkT3rU1OCReyUDqHFk8xfd3XG5zyeU9g
         3BRg==
X-Gm-Message-State: ACrzQf0o337ailU4CbvCwKpCVC9CcTGTki2Ur4fIb7Y1VvPufWW/58I8
        TUjzL/aufSmulthmM/UOO8T9wFAJGT0=
X-Google-Smtp-Source: AMsMyM5xmoES1i0QIvQLNLj35NsWKoYedHY6JpYljmcdg4PXbhxcx+hYvVqG+qE4wi6uQNhJeAT8GQ==
X-Received: by 2002:a05:6808:1488:b0:35a:5eed:f5b4 with SMTP id e8-20020a056808148800b0035a5eedf5b4mr13117557oiw.73.1667951874760;
        Tue, 08 Nov 2022 15:57:54 -0800 (PST)
Received: from macondo.. ([2804:431:e7cc:805:20d8:ca0b:7b1e:63d3])
        by smtp.gmail.com with ESMTPSA id t12-20020a056870f20c00b001375188dae9sm5333818oao.16.2022.11.08.15.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 15:57:54 -0800 (PST)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/eprobe: Fix memory leak of filter string
Date:   Tue,  8 Nov 2022 20:57:38 -0300
Message-Id: <20221108235738.1021467-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filter string doesn't get freed when a dynamic event is deleted. If a
filter is set, then memory is leaked:

root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core \
        sched/sched_stat_runtime runtime=$runtime:u32 if cpu < 4' >> dynamic_events
root@localhost:/sys/kernel/tracing# echo "-:egroup/stat_runtime_4core"  >> dynamic_events
root@localhost:/sys/kernel/tracing# echo scan > /sys/kernel/debug/kmemleak
[  224.416373] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
root@localhost:/sys/kernel/tracing# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88810156f1b8 (size 8):
  comm "bash", pid 224, jiffies 4294935612 (age 55.800s)
  hex dump (first 8 bytes):
    63 70 75 20 3c 20 34 00                          cpu < 4.
  backtrace:
    [<000000009f880725>] __kmem_cache_alloc_node+0x18e/0x720
    [<0000000042492946>] __kmalloc+0x57/0x240
    [<0000000034ea7995>] __trace_eprobe_create+0x1214/0x1d30
    [<00000000d70ef730>] trace_probe_create+0xf6/0x110
    [<00000000915c7b16>] eprobe_dyn_event_create+0x21/0x30
    [<000000000d894386>] create_dyn_event+0xf3/0x1a0
    [<00000000e9af57d5>] trace_parse_run_command+0x1a9/0x2e0
    [<0000000080777f18>] dyn_event_write+0x39/0x50
    [<0000000089f0ec73>] vfs_write+0x311/0xe50
    [<000000003da1bdda>] ksys_write+0x158/0x2a0
    [<00000000bb1e616e>] __x64_sys_write+0x7c/0xc0
    [<00000000e8aef1f7>] do_syscall_64+0x60/0x90
    [<00000000fe7fe8ba>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Additionally, in __trace_eprobe_create() function, if an error occurs after
the call to trace_eprobe_parse_filter(), which allocates the filter string,
then memory is also leaked. That can be reproduced by creating the same
event probe twice:

root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core \
        sched/sched_stat_runtime runtime=$runtime:u32 if cpu < 4' >> dynamic_events
root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core \
        sched/sched_stat_runtime runtime=$runtime:u32 if cpu < 4' >> dynamic_events
-bash: echo: write error: File exists
root@localhost:/sys/kernel/tracing# echo scan > /sys/kernel/debug/kmemleak
[  207.871584] kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
root@localhost:/sys/kernel/tracing# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8881020d17a8 (size 8):
  comm "bash", pid 223, jiffies 4294938308 (age 31.000s)
  hex dump (first 8 bytes):
    63 70 75 20 3c 20 34 00                          cpu < 4.
  backtrace:
    [<000000000e4f5f31>] __kmem_cache_alloc_node+0x18e/0x720
    [<0000000024f0534b>] __kmalloc+0x57/0x240
    [<000000002930a28e>] __trace_eprobe_create+0x1214/0x1d30
    [<0000000028387903>] trace_probe_create+0xf6/0x110
    [<00000000a80d6a9f>] eprobe_dyn_event_create+0x21/0x30
    [<000000007168698c>] create_dyn_event+0xf3/0x1a0
    [<00000000f036bf6a>] trace_parse_run_command+0x1a9/0x2e0
    [<00000000014bde8b>] dyn_event_write+0x39/0x50
    [<0000000078a097f7>] vfs_write+0x311/0xe50
    [<00000000996cb208>] ksys_write+0x158/0x2a0
    [<00000000a3c2acb0>] __x64_sys_write+0x7c/0xc0
    [<0000000006b5d698>] do_syscall_64+0x60/0x90
    [<00000000780e8ecf>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix both issues by releasing the filter string in
trace_event_probe_cleanup().

Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 kernel/trace/trace_eprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index c2153bf59936..e888446d80fa 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -52,6 +52,7 @@ static void trace_event_probe_cleanup(struct trace_eprobe *ep)
 	kfree(ep->event_system);
 	if (ep->event)
 		trace_event_put_ref(ep->event);
+	kfree(ep->filter_str);
 	kfree(ep);
 }
 
-- 
2.34.1

