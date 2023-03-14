Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA33F6B9FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCNThN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCNThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:37:11 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE32A6DE;
        Tue, 14 Mar 2023 12:37:02 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id cn21so36408414edb.0;
        Tue, 14 Mar 2023 12:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcgqrEEeAkKKOQl82NDw/a48a4KrmvHxuMGEj//jCFE=;
        b=lGiGWfynM/jBFGYSd8NhCjaCVRbtUAtZ9ujELBNN3qzirSf1mOBQVw9cCibQ2bdsY1
         8sY0thj/GODYvedi9rQfeDM8WReZsVVMqovz2IG1fzFOO+AfjvREPA8m47cpkn9fPOvB
         jJRarDG3mkeFE5NEjYgjMyu08uXb3i91veX42zNQ0ypwt9AvVwZC8NZk5Yju3ok57LL6
         J7h8EYqkYY+/CHtzFIHSnLOEbebopWK0vNmmz/MRk3IClunlIjL1efvRk/eoHpn2NJKk
         QZlhxRJvN6/ExAURyPpjMmCQrMe/TD7NYyH0cKv/A0tuoO/hEMhg2zlqV6eg/L2MnXEd
         +jOg==
X-Gm-Message-State: AO0yUKV/4hpAru5O0xa46wn1TiWq3cfenUt5odl+Z0SKFkH/hitWG8so
        7qdXVcTXmebqOhqdd35PrjT2UebB7jed29XdXRc=
X-Google-Smtp-Source: AK7set+cMfoe4bsEnRmrY5E8XZQiF35wuilUo433PUun4G3b9dikVzXxdDU1zSSwxhJLUHQRdYf+f05lopA3NNj34t8=
X-Received: by 2002:a50:8754:0:b0:4fb:c8e3:1adb with SMTP id
 20-20020a508754000000b004fbc8e31adbmr138552edv.3.1678822620191; Tue, 14 Mar
 2023 12:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230308112632.1908748-1-sudeep.holla@arm.com> <d9e5fdc4-3db0-4aa7-147c-c3c6bfbeac84@arm.com>
In-Reply-To: <d9e5fdc4-3db0-4aa7-147c-c3c6bfbeac84@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Mar 2023 20:36:48 +0100
Message-ID: <CAJZ5v0h36OPPZ4tFy0cnfcYcKipGXVcRGH9dSbQDNtUd4pKVLQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix to avoid sleep in the atomic context when
 PPTT is absent
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 2:34 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
>
> On 3/8/23 12:26, Sudeep Holla wrote:
> > Commit 0c80f9e165f8 ("ACPI: PPTT: Leave the table mapped for the runtime usage")
> > enabled to map PPTT once on the first invocation of acpi_get_pptt() and
> > never unmapped the same allowing it to be used at runtime with out the
> > hassle of mapping and unmapping the table. This was needed to fetch LLC
> > information from the PPTT in the cpuhotplug path which is executed in
> > the atomic context as the acpi_get_table() might sleep waiting for a
> > mutex.
> >
> > However it missed to handle the case when there is no PPTT on the system
> > which results in acpi_get_pptt() being called from all the secondary
> > CPUs attempting to fetch the LLC information in the atomic context
> > without knowing the absence of PPTT resulting in the splat like below:
> >
> >   | BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:164
> >   | in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> >   | preempt_count: 1, expected: 0
> >   | RCU nest depth: 0, expected: 0
> >   | no locks held by swapper/1/0.
> >   | irq event stamp: 0
> >   | hardirqs last  enabled at (0): 0x0
> >   | hardirqs last disabled at (0): copy_process+0x61c/0x1b40
> >   | softirqs last  enabled at (0): copy_process+0x61c/0x1b40
> >   | softirqs last disabled at (0): 0x0
> >   | CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-rc1 #1
> >   | Call trace:
> >   |  dump_backtrace+0xac/0x138
> >   |  show_stack+0x30/0x48
> >   |  dump_stack_lvl+0x60/0xb0
> >   |  dump_stack+0x18/0x28
> >   |  __might_resched+0x160/0x270
> >   |  __might_sleep+0x58/0xb0
> >   |  down_timeout+0x34/0x98
> >   |  acpi_os_wait_semaphore+0x7c/0xc0
> >   |  acpi_ut_acquire_mutex+0x58/0x108
> >   |  acpi_get_table+0x40/0xe8
> >   |  acpi_get_pptt+0x48/0xa0
> >   |  acpi_get_cache_info+0x38/0x140
> >   |  init_cache_level+0xf4/0x118
> >   |  detect_cache_attributes+0x2e4/0x640
> >   |  update_siblings_masks+0x3c/0x330
> >   |  store_cpu_topology+0x88/0xf0
> >   |  secondary_start_kernel+0xd0/0x168
> >   |  __secondary_switched+0xb8/0xc0
> >
> > Update acpi_get_pptt() to consider the fact that PPTT is once checked and
> > is not available on the system and return NULL avoiding any attempts to
> > fetch PPTT and thereby avoiding any possible sleep waiting for a mutex
> > in the atomic context.
> >
> > Fixes: 0c80f9e165f8 ("ACPI: PPTT: Leave the table mapped for the runtime usage")
> > Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> > Cc: Pierre Gondois <pierre.gondois@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/acpi/pptt.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index 10975bb603fb..a35dd0e41c27 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -536,16 +536,19 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
> >   static struct acpi_table_header *acpi_get_pptt(void)
> >   {
> >       static struct acpi_table_header *pptt;
> > +     static bool is_pptt_checked;
> >       acpi_status status;
> >
> >       /*
> >        * PPTT will be used at runtime on every CPU hotplug in path, so we
> >        * don't need to call acpi_put_table() to release the table mapping.
> >        */
> > -     if (!pptt) {
> > +     if (!pptt && !is_pptt_checked) {
> >               status = acpi_get_table(ACPI_SIG_PPTT, 0, &pptt);
> >               if (ACPI_FAILURE(status))
> >                       acpi_pptt_warn_missing();
> > +
> > +             is_pptt_checked = true;
> >       }
> >
> >       return pptt;

Applied as 6.3-rc material, thanks!
