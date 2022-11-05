Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79B61DD87
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKETCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiKETBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:01:54 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112895BA;
        Sat,  5 Nov 2022 12:01:06 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id w10so5583652qvr.3;
        Sat, 05 Nov 2022 12:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMRQpkt+46bPIVTYGYV/Az4BkAq6gnC1hbvHXSkejWg=;
        b=zeC9upKZ2Ja1HVK0OEjEt04x3iJqZ4BafeyuPrNMcuL/k/PcFIZaOVnhNeUUEZcTEM
         hNp4aNbVRlosMMRsVvSQ2zsIUA2inCKBpvVihKYQ6x6P6hYLAebBTMaK7N1aGNwknA7T
         P6p7d22yKnUivAJ2rigzxM6Z0reHVOdchSOCcj+RZIfWROzkzRbuRQv30VsYmcmvMZjy
         ur0qpdPQd9FPTZ/8SA1EspZVhTRuDCLGaFUL0S+HEZUBy4YK9EoNUpOx20zCqMrgOWye
         UC/6UdB5oqJtZHpdCiDdZahgB0lxt1IwBhkTdt1Le2oHfsZbwJRwLOXR6uCDImLIjXKb
         HAqw==
X-Gm-Message-State: ACrzQf3hAa3Lj4W8uVQ9hvQ6WyuaitJxjYz8UIIAMNVZQZTQ+rhBHw7k
        JrRLsBfA5XcBzf49uygk2/xWedUGVbE43UlB9nLENt0bntI=
X-Google-Smtp-Source: AMsMyM7JuW9nTEWfj2RIShvPEv4weLZYP521+yycifgQoazHtN5fbx3w9v55I//lNsMeDfxVTozVG2unPM6FpjhFCB8=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr29253554qvj.3.1667674865176; Sat, 05 Nov
 2022 12:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221019073443.248215-1-chenzhongjin@huawei.com> <CAJZ5v0hV2AFEgiuxxbDFUWLa0ZthSz3a=-9U4pjXm-GmmSgexw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hV2AFEgiuxxbDFUWLa0ZthSz3a=-9U4pjXm-GmmSgexw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 5 Nov 2022 20:00:54 +0100
Message-ID: <CAJZ5v0jPCGoss6X5bmv9Nw9ZxrDxirEEMh6UKSgOoArs2d9ffA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix use-after-free in acpi_ps_parse_aml()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael.j.wysocki@intel.com, lenb@kernel.org, lv.zheng@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 5:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Oct 19, 2022 at 9:38 AM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> >
> > KASAN reports a use-after-free problem and causes kernel panic
> > triggered by: modprobe acpiphp_ibm
> >
> > BUG: KASAN:
> > use-after-free in acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
> > Read of size 8 at addr ffff888002f843f0 by task modprobe/519
> >
> > CPU: 2 PID: 519 Comm: modprobe Not tainted 6.0.0+
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> >     Call Trace:
> >     <TASK>
> >     acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
> >     acpi_ds_method_error (drivers/acpi/acpica/dsmethod.c:232)
> >     acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
> >     ...
> >     </TASK>
> >
> >     Allocated by task 519:
> >     ...
> >     __kasan_kmalloc (mm/kasan/common.c:526)
> >     acpi_ds_create_walk_state (drivers/acpi/acpica/dswstate.c:519)
> >     acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:498)
> >     acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
> >     ...
> >
> >     Freed by task 519:
> >     ...
> >     __kmem_cache_free+0xb6/0x3c0
> >     acpi_ds_delete_walk_state (drivers/acpi/acpica/dswstate.c:722)
> >     acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:586)
> >     acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
> >     ...
> > ---[ end Kernel panic - not syncing: Fatal exception ]---
> >
> > In the error path in acpi_ps_parse_aml():
> >
> >     acpi_ds_call_control_method()
> >         acpi_ds_create_walk_state()
> >             acpi_ds_push_walk_state()
> >             # thread->walk_state_list = walk_state
> >
> >         acpi_ds_init_aml_walk # *fail*
> >         goto cleanup:
> >         acpi_ds_delete_walk_state() # ACPI_FREE(walk_state)
> >
> >     acpi_ds_method_error()
> >         acpi_ds_dump_method_stack()
> >         # using freed thread->walk_state_list
> >
> > Briefly, the walk_state is pushed to thread, and freed without being poped.
> > Then it is used in acpi_ds_dump_method_stack() and causes use-after-free.
> >
> > Add acpi_ds_pop_walk_state(thread) to the error path to fix the problem.
> >
> > Fixes: 0bac4295526c ("ACPICA: Dispatcher: Move stack traversal code to dispatcher")
> >
> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>
> This should be submitted to the upstream project on GitHub, but it
> looks bad enough, so I'll take care of this.
>
> Applied as 6.1-rc material, thanks!
>
> > ---
> >  drivers/acpi/acpica/dsmethod.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
> > index ae2e768830bf..19da7fc73186 100644
> > --- a/drivers/acpi/acpica/dsmethod.c
> > +++ b/drivers/acpi/acpica/dsmethod.c
> > @@ -581,6 +581,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
> >
> >         acpi_ds_terminate_control_method(obj_desc, next_walk_state);
> >         acpi_ds_delete_walk_state(next_walk_state);
> > +       acpi_ds_pop_walk_state(thread);

On second thought, though, should it be popped before deleting?
Otherwise it looks like there will be still use-after-free, because
acpi_ds_pop_walk_state() accesses the walk_state at the top of the
queue.

Moreover, it is not correct to pop the walk state if next_walk_state
is NULL AFAICS.

I'm dropping this one.


> >
> >         return_ACPI_STATUS(status);
> >  }
> > --
>
> Bob, this looks correct to me, but I may be missing something in which
> case please let me know.
