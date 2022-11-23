Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8280636184
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiKWOVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbiKWOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:20:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1563B94
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:36 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n17so16865654pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZFGbUHuj0l3eTvqxn5eZPM/wQWRlW8EgGqFLB4IDbY=;
        b=UL7NA71lQETMtiGLB4b0vM0bIK56V9BIy15nU3u5/XO87jW95LGcNVZRn2UtQZSPSc
         ib4fv/ro/oGNdRLn3kROOEzKedIeVrJ4sGqAxbtte0g5oGuRMTQhCm+Y4+hsD2aj6xks
         sFacIImq75unL4GkwndLhKm9NL5akxb8zUaN6I3uzG5cs15I5ajNYz/dy/3EM/H8x471
         o0sHHUmnjy2wQM5//on9q7SoZTzB+kxQ4gJQFRrzGAgblMp65KmmYEc69lS6gW9U12lG
         YZsJckaaoZmVJt295ri6d6ODV4/X6jgu8PGhbLxZFHKhO+6J8sgD7klB1qqFZyO++fnu
         oPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZFGbUHuj0l3eTvqxn5eZPM/wQWRlW8EgGqFLB4IDbY=;
        b=L/fB6TWmtr38g8T1RblgUly68O0b3mMcgkoK8SjSH2rInl77Ce+7mAwFrgyrwlFV3q
         suV3tCXw7IqZI0pJ4tQVWFvIcvJL7SrIb16F6RgWZXk3xnkuQhd4A6Husy0uxZNkUsjZ
         NyGxikZyYKKwpcmCeS8LlOT9xSV/K+PP290RaoIwdAmcwijOwg2ucTPCsQZUjy12D15W
         tsvh0twuGLnZD2af0tCUR4Oy3TO5/+W+e/PaGPngvdHYOdKiJ0rkxN3hKTpJcoQAl156
         StnW+9eytxLMGdeLPB6opNxUIBSA7Z+iMy1Iq57Wa3a6E0HciHewjDH29wxRAoIyV8Mg
         MUOg==
X-Gm-Message-State: ANoB5pnUt5pwQo32BaqFpJmoAG5MDNr3bFzZWD7CsuZpn+0WNO9TDBh+
        XSoUKkSEm/fyrcQ0ZCTofok=
X-Google-Smtp-Source: AA0mqf4hksRNl+NtDdclonmxEt2Mu9yopFQcQjze1yeU9La5Gipr9oXvhlZA7HVc1KIQasBaNuiYtg==
X-Received: by 2002:a63:711e:0:b0:477:5654:c37e with SMTP id m30-20020a63711e000000b004775654c37emr16425758pgc.206.1669213234292;
        Wed, 23 Nov 2022 06:20:34 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016c5306917fsm14516732plh.53.2022.11.23.06.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:20:33 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH 0/2] riscv/ftrace: add WITH_DIRECT_CALLS support
Date:   Wed, 23 Nov 2022 22:20:23 +0800
Message-Id: <20221123142025.1504030-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
here as the samples for testing DIRECT_CALLS related interface.

First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide 
register_ftrace_direct[_multi] interfaces allowing user to register 
the customed trampoline (direct_caller) as the mcount for one or 
more target functions. And modify_ftrace_direct[_multi] are also 
provided for modify direct_caller.

At the same time, the samples in ./samples/ftrace/ can be built
as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
and SAMPLE_FTRACE_DIRECT_MULTI selected.

Second, to make the direct_caller and the other ftrace hooks
(eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary register
are nominated to store the address of direct_caller in ftrace_regs_caller.
After the setting of the address direct_caller by direct_ops->func and
the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
by the `jr` inst.

The following tests have been passed in my local qemu-riscv64 virt machine. 

1. tests with CONFIG_FTRACE_STARTUP_TEST
2. tests of samples/ftrace/ftrace*.ko
3. manual tests with any combination of the following hooks
  - function/function_graph tracer 
  - ftrace*.ko
  - kprobe/kretprobe

For your reference, here is the log when function tracer, kretprobe and 
ftrace-direct-too.ko co-hooks the handle_mm_fault function.

```
[root@stage4 tracing]# echo handle_mm_fault > set_ftrace_filter
[root@stage4 tracing]# echo 'r:myr handle_mm_fault' > kprobe_events
[root@stage4 tracing]# echo function > current_tracer 
[root@stage4 tracing]# echo 1 > events/kprobes/myr/enable 
[root@stage4 tracing]# insmod /root/ftrace-direct-too.ko 
[root@stage4 tracing]# 
[root@stage4 tracing]# cat trace | tail
             cat-388     [000] ...1.   583.051438: myr: (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
             cat-388     [000] ...2.   583.057930: handle_mm_fault <-do_page_fault
             cat-388     [000] .....   583.057990: my_direct_func: handle mm fault vma=000000002d9fe19c address=ffffffae9b7000 flags=215
             cat-388     [000] ...1.   583.058284: myr: (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
            tail-389     [001] ...2.   583.059062: handle_mm_fault <-do_page_fault
            tail-389     [001] .....   583.059104: my_direct_func: handle mm fault vma=0000000017f3c48e address=aaaaaabebf3000 flags=215
            tail-389     [001] ...1.   583.059325: myr: (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
            tail-389     [001] ...2.   583.060371: handle_mm_fault <-do_page_fault
            tail-389     [001] .....   583.060410: my_direct_func: handle mm fault vma=0000000017f3c48e address=aaaaaabebf1000 flags=255
            tail-389     [001] ...1.   583.060996: myr: (do_page_fault+0x16c/0x5f2 <- handle_mm_fault)
```

Note1: 

This series is based on (riscv/ftrace: make ftrace_caller call ftrace_graph_func)
in this repo -> https://github.com/guoren83/linux/commits/ftrace_fixup_v3 .

Note2:

The checkpatch.pl will output some warnings on this series, like this

```
WARNING: Prefer using '"%s...", __func__' to using 'my_direct_func2', this function's name, in a string
111: FILE: samples/ftrace/ftrace-direct-multi-modify.c:48:
+"       call my_direct_func2\n"
```

The reason is that checkpatch depends on patch context providing the
function name. In the above warning, my_direct_func2 has some codeline
distance with the changed trunk, so its declaration doesn't come into
the patch, and then the warning jumps out.

You may notice the location of `my_ip` variable changes in the 2nd patch.
I did that for reducing the warnings to some extent. But killing all the 
warnings will makes the patch less readable, so I stopped here.

--
Song

Song Shuai (2):
  riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
  samples/ftrace: add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]

 arch/riscv/Kconfig                          |  3 ++
 arch/riscv/include/asm/ftrace.h             |  6 ++++
 arch/riscv/kernel/mcount-dyn.S              |  4 +++
 samples/ftrace/ftrace-direct-modify.c       | 35 ++++++++++++++++++-
 samples/ftrace/ftrace-direct-multi-modify.c | 37 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
 samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
 8 files changed, 154 insertions(+), 1 deletion(-)

-- 
2.20.1

