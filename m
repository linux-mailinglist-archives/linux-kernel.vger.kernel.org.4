Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007863DE94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiK3Sid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiK3Sib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:38:31 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D02C1;
        Wed, 30 Nov 2022 10:38:30 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id l15so11800304qtv.4;
        Wed, 30 Nov 2022 10:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvYccHRItsFtfbX1LjYVA7khVN/vC5lTWUwZfNTayMk=;
        b=4siRStvvjiA7bK4OCI/bDRbSoJSYGyoJM92jCLMx3vamOZ7vjyM9nbc2ViRmfuhCDe
         aFzxT8zkkOBHyhV0W2s4F0HVfhhaRvjpF5Vnqxj9i/+t2KOv63EUPPnT6/1iD/hwmWpf
         3rqwcrz3fm8eObVL5FG7tqdCc8/4KJ/Kev36aObEtRFeCCrIZwdgYc/OiFpQAS2ef2tS
         MVXQqAU1v1RBKh3fK24/je7CmNnzlakb/EoscSoNXJSCYPFi2D4VJgjLMKIJaMupYsNW
         5mfGR+Z6+n4uFUYYhMrt4SwFzXZ0mibgeqoQyrCsSBnIGfh892ItAebKO2iqGEI7TjsB
         bLsA==
X-Gm-Message-State: ANoB5pm9o7+rR9VR0/guo+KneK+3VWJu1pP0qteuSglNjIvvvFagrFpc
        HwG+Altv6Y05D0+DCSFMcowFeOsNoxIaHaW3dSbEHJJO
X-Google-Smtp-Source: AA0mqf60AJyzMPy+rgqZSrXCq1fakf/7vJvxHcra023KFbFYnzvwGfrSiSUxWXZe7dndQx1LZkzn70lE2HD7JJ52NpQ=
X-Received: by 2002:ac8:73c4:0:b0:3a5:a53d:a102 with SMTP id
 v4-20020ac873c4000000b003a5a53da102mr58461117qtp.153.1669833509483; Wed, 30
 Nov 2022 10:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20221110142307.981883-1-liuyongqiang13@huawei.com> <20221114032301.gipu5l3fcndq7oy3@vireshk-i7>
In-Reply-To: <20221114032301.gipu5l3fcndq7oy3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Nov 2022 19:38:18 +0100
Message-ID: <CAJZ5v0iQ1=zDmcHW_JLEtzd6UHV4MFHF_HM9RXSY0j0+QpLVpg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Init completion before kobject_init_and_add()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     rafael@kernel.org, tobin@kernel.org, zhangxiaoxu5@huawei.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 4:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-11-22, 14:23, Yongqiang Liu wrote:
> > In cpufreq_policy_alloc(), it will call uninitialed completion in
> > cpufreq_sysfs_release() when kobject_init_and_add() fails. And
> > that will cause a crash such as the following page fault in complete:
> >
> > BUG: unable to handle page fault for address: fffffffffffffff8
> > [..]
> > RIP: 0010:complete+0x98/0x1f0
> > [..]
> > Call Trace:
> >  kobject_put+0x1be/0x4c0
> >  cpufreq_online.cold+0xee/0x1fd
> >  cpufreq_add_dev+0x183/0x1e0
> >  subsys_interface_register+0x3f5/0x4e0
> >  cpufreq_register_driver+0x3b7/0x670
> >  acpi_cpufreq_init+0x56c/0x1000 [acpi_cpufreq]
> >  do_one_initcall+0x13d/0x780
> >  do_init_module+0x1c3/0x630
> >  load_module+0x6e67/0x73b0
> >  __do_sys_finit_module+0x181/0x240
> >  do_syscall_64+0x35/0x80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 69b3d61852ac..7e56a42750ea 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1207,6 +1207,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >       if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
> >               goto err_free_rcpumask;
> >
> > +     init_completion(&policy->kobj_unregister);
> >       ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
> >                                  cpufreq_global_kobject, "policy%u", cpu);
> >       if (ret) {
> > @@ -1245,7 +1246,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >       init_rwsem(&policy->rwsem);
> >       spin_lock_init(&policy->transition_lock);
> >       init_waitqueue_head(&policy->transition_wait);
> > -     init_completion(&policy->kobj_unregister);
> >       INIT_WORK(&policy->update, handle_update);
> >
> >       policy->cpu = cpu;
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.2 material, thanks!
