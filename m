Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3701E619F36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKDRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKDRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:48:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02F43ACC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:48:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e129so4970863pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5l5QzlOsdz0E8rg7EvGAnbUkW895BFAzArj6ILHnga0=;
        b=eUqkvaIHmhiSg6rsDi81B4DCQC1kzU0csvD4vuW6u8/wRDVTdqTH1jJ11MZt2pQ2jh
         aI3DitNCgmMKPsiXcgVlxDx36Mkh4SeLCUSPiBHrnwlMDYraG6ffHOkMB22+KWHcXb5s
         341c4yMJzUsnO+6GIjcT154bHQjcdgFnU72cOSx0Hxi9ZfGEIQ7BgyR1Ag7/MUTB/8oz
         4sTzuS+1rKhzpTrDQRI2x+FKr6vt6cO29j/uPPJBQuEyknuqmOP4FobIuUMLiwCJtKrX
         pt/GxpA2DT+0chssbUgyvY0km7vOYyzIszMxYF4OHQtCDEAHfoA0EnaeXwdXkhMU2ugn
         IBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l5QzlOsdz0E8rg7EvGAnbUkW895BFAzArj6ILHnga0=;
        b=r4+a+TFJwlcJbIKj276sJ2Bugjn/VWuADgSP8s9HL641TUguL1gW+5GE6KpRFpKj+G
         xJ+7ZHCDiPNUN7FWHuHoC8EHVEILi5htPnlNpLrmO1Mq+xirao+7Noi8TtbGSDy609JT
         8AISw5qg9PWn5pnbH5phWamiW1icO7E0iIVshvDCr1PJQSAeWd3xkH+Mn/KdjmifqR2M
         WYp7/kFEcHa5YyPhGTF6OJTWjY11i70X7IABneBVg0McBPqGNgCUTS83CeetjhABivG5
         Znr8fossJ1TeiT3x3yGZgFw0QHHhCGpU64lgDUfKKKp2iEFOYeR4596FLMbc4rMMKpKJ
         Yvbg==
X-Gm-Message-State: ACrzQf2nCkw8/azPUpUx50E8BeQLKNLKAxMhIYhEcoZ9qDUhsis7V5JS
        a4cv46PfyQLGhC8QxZoWRcycpOdPNbIdaMBDARMx2w==
X-Google-Smtp-Source: AMsMyM4qC7Iyi1gVKtVc2stn5RVy9melN6rjcsvgt4Ntey2FQpc93zMaQFSsBnVCGjdulBQppLcI/P1cI8NPVVv/nuE=
X-Received: by 2002:a63:689:0:b0:46e:be81:566c with SMTP id
 131-20020a630689000000b0046ebe81566cmr32156347pgg.403.1667584129188; Fri, 04
 Nov 2022 10:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <1667568213-26227-1-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1667568213-26227-1-git-send-email-quic_mojha@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Nov 2022 10:48:37 -0700
Message-ID: <CAKwvOdkdeLEvtOmX423oYaWCami0kAFatWe25DdJq7gbmGb+5g@mail.gmail.com>
Subject: Re: [PATCH] gcov: clang: fix the buffer overflow issue
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     oberpar@linux.ibm.com, nathan@kernel.org, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 6:23 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> Currently, in clang version of gcov code when module is getting removed
> gcov_info_add() incorrectly adds the sfn_ptr->counter to all the
> dst->functions and it result in the kernel panic in below crash report.
> Fix this by properly handling it.
>
> [    8.899094][  T599] Unable to handle kernel write to read-only memory at virtual address ffffff80461cc000
> [    8.899100][  T599] Mem abort info:
> [    8.899102][  T599]   ESR = 0x9600004f
> [    8.899103][  T599]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    8.899105][  T599]   SET = 0, FnV = 0
> [    8.899107][  T599]   EA = 0, S1PTW = 0
> [    8.899108][  T599]   FSC = 0x0f: level 3 permission fault
> [    8.899110][  T599] Data abort info:
> [    8.899111][  T599]   ISV = 0, ISS = 0x0000004f
> [    8.899113][  T599]   CM = 0, WnR = 1
> [    8.899114][  T599] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000ab8de000
> [    8.899116][  T599] [ffffff80461cc000] pgd=18000009ffcde003, p4d=18000009ffcde003, pud=18000009ffcde003, pmd=18000009ffcad003, pte=00600000c61cc787
> [    8.899124][  T599] Internal error: Oops: 9600004f [#1] PREEMPT SMP
> [    8.899265][  T599] Skip md ftrace buffer dump for: 0x1609e0
> ....
> ..,
> [    8.899544][  T599] CPU: 7 PID: 599 Comm: modprobe Tainted: G S         OE     5.15.41-android13-8-g38e9b1af6bce #1
> [    8.899547][  T599] Hardware name: XXX (DT)
> [    8.899549][  T599] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [    8.899551][  T599] pc : gcov_info_add+0x9c/0xb8
> [    8.899557][  T599] lr : gcov_event+0x28c/0x6b8
> [    8.899559][  T599] sp : ffffffc00e733b00
> [    8.899560][  T599] x29: ffffffc00e733b00 x28: ffffffc00e733d30 x27: ffffffe8dc297470
> [    8.899563][  T599] x26: ffffffe8dc297000 x25: ffffffe8dc297000 x24: ffffffe8dc297000
> [    8.899566][  T599] x23: ffffffe8dc0a6200 x22: ffffff880f68bf20 x21: 0000000000000000
> [    8.899569][  T599] x20: ffffff880f68bf00 x19: ffffff8801babc00 x18: ffffffc00d7f9058
> [    8.899572][  T599] x17: 0000000000088793 x16: ffffff80461cbe00 x15: 9100052952800785
> [    8.899575][  T599] x14: 0000000000000200 x13: 0000000000000041 x12: 9100052952800785
> [    8.899577][  T599] x11: ffffffe8dc297000 x10: ffffffe8dc297000 x9 : ffffff80461cbc80
> [    8.899580][  T599] x8 : ffffff8801babe80 x7 : ffffffe8dc2ec000 x6 : ffffffe8dc2ed000
> [    8.899583][  T599] x5 : 000000008020001f x4 : fffffffe2006eae0 x3 : 000000008020001f
> [    8.899586][  T599] x2 : ffffff8027c49200 x1 : ffffff8801babc20 x0 : ffffff80461cb3a0
> [    8.899589][  T599] Call trace:
> [    8.899590][  T599]  gcov_info_add+0x9c/0xb8
> [    8.899592][  T599]  gcov_module_notifier+0xbc/0x120
> [    8.899595][  T599]  blocking_notifier_call_chain+0xa0/0x11c
> [    8.899598][  T599]  do_init_module+0x2a8/0x33c
> [    8.899600][  T599]  load_module+0x23cc/0x261c
> [    8.899602][  T599]  __arm64_sys_finit_module+0x158/0x194
> [    8.899604][  T599]  invoke_syscall+0x94/0x2bc
> [    8.899607][  T599]  el0_svc_common+0x1d8/0x34c
> [    8.899609][  T599]  do_el0_svc+0x40/0x54
> [    8.899611][  T599]  el0_svc+0x94/0x2f0
> [    8.899613][  T599]  el0t_64_sync_handler+0x88/0xec
> [    8.899615][  T599]  el0t_64_sync+0x1b4/0x1b8
> [    8.899618][  T599] Code: f905f56c f86e69ec f86e6a0f 8b0c01ec (f82e6a0c)
> [    8.899620][  T599] ---[ end trace ed5218e9e5b6e2e6 ]---
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  kernel/gcov/clang.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index cbb0bed..0aabb9a 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -271,15 +271,20 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
>   */
>  void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
>  {
> -       struct gcov_fn_info *dfn_ptr;
> -       struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
> -                       struct gcov_fn_info, head);

Hi Mukesh,
Thanks for the report and patch!

Looking closer at the existing implementation, it looks curious to me
that we use list_first_entry_or_null() since that may return NULL,
which we never check for.  I'm curious if that's safe to remove?
Probably, since we haven't had any issues reported thus far.

> +       struct gcov_fn_info *sfn_ptr;
> +       struct gcov_fn_info *dfn_ptr = list_first_entry_or_null(
> +                       &dst->functions, struct gcov_fn_info, head);
>
> -       list_for_each_entry(dfn_ptr, &dst->functions, head) {
> +       list_for_each_entry(sfn_ptr, &src->functions, head) {

This seems to be iterating BOTH src and dest, whereas previously we
were only iterating dest AFAICT.  Is this correct?  Seems to be a
change of behavior, at the least, which seems orthogonal to fixing the
panic.

Otherwise it sounds like we could just add NULL ptr checks against
sfn_ptr outside the loop, and against dfn_ptr inside the loop.
Something like this?
```
diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index cbb0bed958ab..5d4cb801aa9c 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -275,10 +275,13 @@ void gcov_info_add(struct gcov_info *dst, struct
gcov_info *src)
        struct gcov_fn_info *sfn_ptr = list_first_entry_or_null(&src->functions,
                        struct gcov_fn_info, head);

-       list_for_each_entry(dfn_ptr, &dst->functions, head) {
-               u32 i;
+       if (!sfn_ptr)
+               return;

-               for (i = 0; i < sfn_ptr->num_counters; i++)
+       list_for_each_entry(dfn_ptr, &dst->functions, head) {
+               if (!dfn_ptr)
+                       continue;
+               for (u32 i = 0, e = sfn_ptr->num_counters; i != e; ++i)
                        dfn_ptr->counters[i] += sfn_ptr->counters[i];
        }
 }
```
Can you test the above hunk or comment on whether it addresses the issue?

>                 u32 i;
>
> +               if (!dfn_ptr)
> +                       return;
> +
>                 for (i = 0; i < sfn_ptr->num_counters; i++)
>                         dfn_ptr->counters[i] += sfn_ptr->counters[i];
> +
> +               dfn_ptr = list_next_entry(dfn_ptr, head);
>         }
>  }
>
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
