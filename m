Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0F710979
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbjEYKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjEYKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C8412E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685009288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4akXK1FMFW2OFS+ihaAaDKhkDvyFarFcsLkbO3dPNk=;
        b=P92tIrZf9VXhCgSgijs919r8qCNZQQVLl9Jrzni3YMngYxAK1u/YoV8GCiOjWT9woeJDoH
        14il+YlWc1lHID15jYheZwIZUvStoIirQwyOtTLfQROvlckRPpcNeg02ZuwRPWLKtsg25n
        UfEnUwnwxWJ7/F1fwDoyfqa8RKOvUfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-7RhFpgxFMw2I0tFbQw9qqA-1; Thu, 25 May 2023 06:07:59 -0400
X-MC-Unique: 7RhFpgxFMw2I0tFbQw9qqA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42b226871so1932195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685009278; x=1687601278;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4akXK1FMFW2OFS+ihaAaDKhkDvyFarFcsLkbO3dPNk=;
        b=UZlYFuwrEaC4CgONjbi777foKukvb1JD5m9/bWDK0PN4Mfo95hX8tXnP9c3WttpBQc
         SWpiPyqJNL522gAc7+6VnMFhw5ZtWv4Jl2u3i5ao8p76AMOjX2aor4Ro3HOvhOmKrAF1
         jJKmGx/oB7NgdIj3YS7Suqfpyw4zKcqoy7ARxbtyb0OvG+IwyDbSBEvBWRorkfaAPAN7
         iLU90Wd88Gt8B09tC00dimf5GWlMo+a1X2ltFzQ7P3GxFLxQ4ymHV2Z5cyL4VKa0okFo
         aoD7LQ4XVxeUhZAX/XUyzEO22iz0pLN5gvFPkUSc6hjNiah/a6RHCl0km/+KTikFAAWp
         BQKQ==
X-Gm-Message-State: AC+VfDzAe3/0/RoM0Nf4G7oTOFRiDnsO+frg+PjhrC3vh8LUcgSdGIbC
        TsLegbudgfrShg7VF8/MhlrE2sx9jej6ZN6IawE7hK8s9STpyfXzrQ3i5jQLR4Tten5E8w9z5rm
        ZdVs8vAGVNWW/Rt5Lt98mTtRI
X-Received: by 2002:a1c:4c11:0:b0:3f4:2cb2:a6cf with SMTP id z17-20020a1c4c11000000b003f42cb2a6cfmr2191034wmf.10.1685009278514;
        Thu, 25 May 2023 03:07:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qM4l0aFUNyAaglZIDdVq94GoCTUm/JXTXxeRLQlYpY5fMAkmavlsUCvohYLfu27wF+uBPMA==
X-Received: by 2002:a1c:4c11:0:b0:3f4:2cb2:a6cf with SMTP id z17-20020a1c4c11000000b003f42cb2a6cfmr2191016wmf.10.1685009278201;
        Thu, 25 May 2023 03:07:58 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c378700b003f4ddde398csm1582641wmr.21.2023.05.25.03.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 03:07:57 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yicong Yang <yangyicong@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, yu.c.chen@intel.com, linuxarm@huawei.com,
        prime.zeng@huawei.com, wangjie125@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH] sched/fair: Don't balance task to its current running CPU
In-Reply-To: <20230524072018.62204-1-yangyicong@huawei.com>
References: <20230524072018.62204-1-yangyicong@huawei.com>
Date:   Thu, 25 May 2023 11:07:55 +0100
Message-ID: <xhsmhcz2opvus.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/23 15:20, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> We've run into the case that the balancer tries to balance a migration
> disabled task and trigger the warning in set_task_cpu() like below:
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 7 PID: 0 at kernel/sched/core.c:3115 set_task_cpu+0x188/0x240
>  Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT nf_reject_ipv4 <...snip>
>  CPU: 7 PID: 0 Comm: swapper/7 Kdump: loaded Tainted: G           O       6.1.0-rc4+ #1
>  Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B221.01 12/09/2021
>  pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : set_task_cpu+0x188/0x240
>  lr : load_balance+0x5d0/0xc60
>  sp : ffff80000803bc70
>  x29: ffff80000803bc70 x28: ffff004089e190e8 x27: ffff004089e19040
>  x26: ffff007effcabc38 x25: 0000000000000000 x24: 0000000000000001
>  x23: ffff80000803be84 x22: 000000000000000c x21: ffffb093e79e2a78
>  x20: 000000000000000c x19: ffff004089e19040 x18: 0000000000000000
>  x17: 0000000000001fad x16: 0000000000000030 x15: 0000000000000000
>  x14: 0000000000000003 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000001 x10: 0000000000000400 x9 : ffffb093e4cee530
>  x8 : 00000000fffffffe x7 : 0000000000ce168a x6 : 000000000000013e
>  x5 : 00000000ffffffe1 x4 : 0000000000000001 x3 : 0000000000000b2a
>  x2 : 0000000000000b2a x1 : ffffb093e6d6c510 x0 : 0000000000000001
>  Call trace:
>   set_task_cpu+0x188/0x240
>   load_balance+0x5d0/0xc60
>   rebalance_domains+0x26c/0x380
>   _nohz_idle_balance.isra.0+0x1e0/0x370
>   run_rebalance_domains+0x6c/0x80
>   __do_softirq+0x128/0x3d8
>   ____do_softirq+0x18/0x24
>   call_on_irq_stack+0x2c/0x38
>   do_softirq_own_stack+0x24/0x3c
>   __irq_exit_rcu+0xcc/0xf4
>   irq_exit_rcu+0x18/0x24
>   el1_interrupt+0x4c/0xe4
>   el1h_64_irq_handler+0x18/0x2c
>   el1h_64_irq+0x74/0x78
>   arch_cpu_idle+0x18/0x4c
>   default_idle_call+0x58/0x194
>   do_idle+0x244/0x2b0
>   cpu_startup_entry+0x30/0x3c
>   secondary_start_kernel+0x14c/0x190
>   __secondary_switched+0xb0/0xb4
>  ---[ end trace 0000000000000000 ]---
>
> Further investigation shows that the warning is superfluous, the migration
> disabled task is just going to be migrated to its current running CPU.
> This is because that on load balance if the dst_cpu is not allowed by the
> task, we'll re-select a new_dst_cpu as a candidate. If no task can be
> balanced to dst_cpu we'll try to balance the task to the new_dst_cpu
> instead. In this case when the migration disabled task is not on CPU it
> only allows to run on its current CPU, load balance will select its
> current CPU as new_dst_cpu and later triggers the the warning above.
>
> This patch tries to solve this by not select the task's current running
> CPU as new_dst_cpu in the load balance.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks!

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

