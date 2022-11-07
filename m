Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C460761FBEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiKGRve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiKGRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:51:26 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B6B22BFE;
        Mon,  7 Nov 2022 09:51:25 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id k4so7624450qkj.8;
        Mon, 07 Nov 2022 09:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SlUrGbirdQzWHUgwyPncnELFtyuxA8lTkiM6wFuPfo=;
        b=46iUO0TBeDY2dG47VvZ8QRm0m8nqicwqV8ngfkRE/EYyZiSMpUGaH0I2Olf10W6R20
         MSYe1f2SQBUC6ncXTqQDnrt8aYB/ZuqIppp3+KvCCaQpsrQQyO38L2Rvw7NTAtq/y2pl
         tgZ3fwlnszogL4bUuHYTfffu9/mhOm8NGf0/ohyzxw0eMZuUq9tpH9ZZSJMXG6UJyOMY
         oZbx+fbsruH6C8+LX3gyNEdYEi/gZWIixwflAZ7Jt/SqEmlGbNLlDnc+vznFqwjg0rzB
         XToRJrg9wnYCVNqJbTFKG5jcutxasQt46gCCvrnoMcoJEEZ5izwsouoB7QArByRQJ4W3
         gjFg==
X-Gm-Message-State: ACrzQf0fe5zCqpW5LXEMNL3wDz9Uw1tPw/J2KquRdYFjc4An22UROYBr
        09rtcbWQtPskivjdCgB8Kbj2NIl0EGWpc2YELXN8ziNsAuY=
X-Google-Smtp-Source: AMsMyM5zUK+Gh915z1TyTg6StkwnO/8vZLN1whloAVcgcGrRtIM/HNXJDT+11oLUGenW86ULPplS1oQLVef62P+bFiM=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr35366284qkl.443.1667843484838; Mon, 07
 Nov 2022 09:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20221019073443.248215-1-chenzhongjin@huawei.com>
 <CAJZ5v0hV2AFEgiuxxbDFUWLa0ZthSz3a=-9U4pjXm-GmmSgexw@mail.gmail.com>
 <CAJZ5v0jPCGoss6X5bmv9Nw9ZxrDxirEEMh6UKSgOoArs2d9ffA@mail.gmail.com> <c01b8c85-59d0-20a8-5e72-4e628a84bf05@huawei.com>
In-Reply-To: <c01b8c85-59d0-20a8-5e72-4e628a84bf05@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Nov 2022 18:51:08 +0100
Message-ID: <CAJZ5v0ixwximCOMPwqMhkBKuTd2yNtbQsphKzpk2jmRZfrj9wA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix use-after-free in acpi_ps_parse_aml()
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael.j.wysocki@intel.com, lenb@kernel.org, lv.zheng@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 10:30 AM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> Hi,
>
> On 2022/11/6 3:00, Rafael J. Wysocki wrote:
> > On Fri, Oct 28, 2022 at 5:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Wed, Oct 19, 2022 at 9:38 AM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> >>> KASAN reports a use-after-free problem and causes kernel panic
> >>> triggered by: modprobe acpiphp_ibm
> >>>
> >>> BUG: KASAN:
> >>> use-after-free in acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
> >>> Read of size 8 at addr ffff888002f843f0 by task modprobe/519
> >>>
> >>> CPU: 2 PID: 519 Comm: modprobe Not tainted 6.0.0+
> >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> >>>      Call Trace:
> >>>      <TASK>
> >>>      acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
> >>>      acpi_ds_method_error (drivers/acpi/acpica/dsmethod.c:232)
> >>>      acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
> >>>      ...
> >>>      </TASK>
> >>>
> >>>      Allocated by task 519:
> >>>      ...
> >>>      __kasan_kmalloc (mm/kasan/common.c:526)
> >>>      acpi_ds_create_walk_state (drivers/acpi/acpica/dswstate.c:519)
> >>>      acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:498)
> >>>      acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
> >>>      ...
> >>>
> >>>      Freed by task 519:
> >>>      ...
> >>>      __kmem_cache_free+0xb6/0x3c0
> >>>      acpi_ds_delete_walk_state (drivers/acpi/acpica/dswstate.c:722)
> >>>      acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:586)
> >>>      acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
> >>>      ...
> >>> ---[ end Kernel panic - not syncing: Fatal exception ]---
> >>>
> >>> In the error path in acpi_ps_parse_aml():
> >>>
> >>>      acpi_ds_call_control_method()
> >>>          acpi_ds_create_walk_state()
> >>>              acpi_ds_push_walk_state()
> >>>              # thread->walk_state_list = walk_state
> >>>
> >>>          acpi_ds_init_aml_walk # *fail*
> >>>          goto cleanup:
> >>>          acpi_ds_delete_walk_state() # ACPI_FREE(walk_state)
> >>>
> >>>      acpi_ds_method_error()
> >>>          acpi_ds_dump_method_stack()
> >>>          # using freed thread->walk_state_list
> >>>
> >>> Briefly, the walk_state is pushed to thread, and freed without being poped.
> >>> Then it is used in acpi_ds_dump_method_stack() and causes use-after-free.
> >>>
> >>> Add acpi_ds_pop_walk_state(thread) to the error path to fix the problem.
> >>>
> >>> Fixes: 0bac4295526c ("ACPICA: Dispatcher: Move stack traversal code to dispatcher")
> >>>
> >>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> >> This should be submitted to the upstream project on GitHub, but it
> >> looks bad enough, so I'll take care of this.
> >>
> >> Applied as 6.1-rc material, thanks!
> >>
> >>> ---
> >>>   drivers/acpi/acpica/dsmethod.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
> >>> index ae2e768830bf..19da7fc73186 100644
> >>> --- a/drivers/acpi/acpica/dsmethod.c
> >>> +++ b/drivers/acpi/acpica/dsmethod.c
> >>> @@ -581,6 +581,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
> >>>
> >>>          acpi_ds_terminate_control_method(obj_desc, next_walk_state);
> >>>          acpi_ds_delete_walk_state(next_walk_state);
> >>> +       acpi_ds_pop_walk_state(thread);
> > On second thought, though, should it be popped before deleting?
> > Otherwise it looks like there will be still use-after-free, because
> > acpi_ds_pop_walk_state() accesses the walk_state at the top of the
> > queue.
>
> You are right it is wrong and sorry I didn't notice that.
>
> I have reproduced same problem on current tree... Have no idea why I
> missed it before.
>
>
> I noticed that this patch have been on next-tree so I submitted another
> one to fix it.
>
> See "ACPICA: Fix pop_walk_state called after walk_state is deleted"

At this point I have my own version of the fix, please see:

https://patchwork.kernel.org/project/linux-acpi/patch/2669303.mvXUDI8C0e@kreacher/
