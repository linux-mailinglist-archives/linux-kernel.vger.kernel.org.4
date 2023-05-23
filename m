Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F870DBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjEWLr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjEWLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2211118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684842427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v0VP/z07BgLC7QS/kvxh6H5DbIiLL0vt6pgbTOkvMvk=;
        b=DSPkRlMraNu76Dk31EtB8hF6kPG6kSFDdK/FnMQ3I+cICOXbm8vv39FpgkXGHHuLqVMA6a
        XmmjeJHOBqIOFw4xfdFZnNkiFqBGuw8b5b8Jbabs1KBU4qVBSrtc+/oCzHCtXXlTnYZzKH
        GoTs/fMmNMohmKsNWCFPcADtMeKB+CM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-jgs3ZujHOTOgHE5VUSf1sg-1; Tue, 23 May 2023 07:47:04 -0400
X-MC-Unique: jgs3ZujHOTOgHE5VUSf1sg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3093cb05431so4690078f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842423; x=1687434423;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0VP/z07BgLC7QS/kvxh6H5DbIiLL0vt6pgbTOkvMvk=;
        b=ha4t+ubF+5Uw/ibp34BmcBmTNGvhK1hgGAc/vAUEYW+eJ5Vfq8QWiQc6tC9kuMuhXO
         HJ6GECQxgSmYzWzY65qJO1fAr/DIjGz/5Z7dFGOHhUaHn7LVx/hs7xNZ/idmaxyByGzw
         2vm3GoVNGB5ktsidj38+6pGWrD2t2mEv2hRSNG3y3c9ClMdZgF0rQO1gsaqr+6Vt/ob7
         2pMiwldAjS+ZAlaB2vBNsauG0RSfQzzqayWePvrDgK+j81WYECIYPt6KgnutEfr36fOM
         ZFqlRLnC3BG5WpTBJDvM/P4cpkWsqtx/ai6DBBWkf8c1+zk2DVDNK0gBs6BtFJiLuonX
         q2sg==
X-Gm-Message-State: AC+VfDwagRC4D/Q/9mnEclQ9krHiPvhPGpkDlLu8lFQyYeAXs5PnoLfs
        UgxDnkMXH8k+bUjAJlhCxP2R4YCB2F+xj2uS8KAjuST8lUt97eICmdLhtRTOotq6T+Mq0yaGDLb
        3AH1xxfc89chMLmJ+LpmYDgqY
X-Received: by 2002:a5d:68cd:0:b0:306:27db:16c3 with SMTP id p13-20020a5d68cd000000b0030627db16c3mr9343537wrw.50.1684842422960;
        Tue, 23 May 2023 04:47:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eJccZF0LWvmEgagWJKw8ITDCebhiZ2u5GJCh8l/ckQia0KI9XjFDWZrNypFY48uHoykLHYA==
X-Received: by 2002:a5d:68cd:0:b0:306:27db:16c3 with SMTP id p13-20020a5d68cd000000b0030627db16c3mr9343524wrw.50.1684842422603;
        Tue, 23 May 2023 04:47:02 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id k2-20020adfd842000000b0030647449730sm10882237wrl.74.2023.05.23.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 04:47:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yicong Yang <yangyicong@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Cc:     yangyicong@hisilicon.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linuxarm@huawei.com, prime.zeng@huawei.com,
        wangjie125@huawei.com
Subject: Re: [PATCH] sched/fair: Don't balance migration disabled tasks
In-Reply-To: <12a7c650-bc44-bd5a-1506-67260ab8e21e@huawei.com>
References: <20230313065759.39698-1-yangyicong@huawei.com>
 <xhsmhilf2m3k4.mognet@vschneid.remote.csb>
 <4968738b-940a-1207-0cea-3aea52c6e33e@huawei.com>
 <xhsmh7cvgnbdf.mognet@vschneid.remote.csb>
 <12a7c650-bc44-bd5a-1506-67260ab8e21e@huawei.com>
Date:   Tue, 23 May 2023 12:47:00 +0100
Message-ID: <xhsmh4jo3qngr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/23 19:10, Yicong Yang wrote:
> Hi Valentin,
> Sorry for the late reply. Yes it can be reproduced on the upstream kernel (tested below on
> 6.4-rc1). Since it happens occasionally with the normal setup, I wrote a test kthread
> with migration enable/disable periodically:
>
> static int workload_func(void *data)
> {
>       cpumask_var_t cpumask;
>       int i;
>
>       if (!zalloc_cpumask_var(&cpumask, GFP_KERNEL))
>               return -ENOMEM;
>
>       for (i = 0; i < 8; i++)
>               cpumask_set_cpu(i, cpumask);
>
>       set_cpus_allowed_ptr(current, cpumask);
>       free_cpumask_var(cpumask);
>
>       while (!kthread_should_stop()) {
>               migrate_disable();
>               mdelay(1000);
>               cond_resched();
>               migrate_enable();
>               mdelay(1000);
>       }
>
>       return -1;
> }
>
> Launching this and bind another workload to the same CPU it's currently running like
> `taskset -c $workload_cpu stress-ng -c 1` will trigger the issue. In fact, the problem
> is not because of the migration disable mechanism which works well, but because the
> balancing policy after found all the tasks on the source CPU are pinned. With below
> debug print added:
>
> @@ -8527,6 +8527,20 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>         if (kthread_is_per_cpu(p))
>                 return 0;
>
> +       if (is_migration_disabled(p)) {
> +               if (!p->on_cpu && cpumask_test_cpu(env->dst_cpu, p->cpus_ptr))
> +                       pr_err("dst_cpu %d on_cpu %d cpus_ptr %*pbl cpus_mask %*pbl",
> +                               env->dst_cpu, p->on_cpu, cpumask_pr_args(p->cpus_ptr),
> +                               cpumask_pr_args(&p->cpus_mask));
> +       }
> +
>         if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>                 int cpu;
>
> I got below output:
>
> [  686.135619] dst_cpu 1 on_cpu 0 cpus_ptr 1 cpus_mask 0-7
> [  686.148809] ------------[ cut here ]------------
> [  686.169505] WARNING: CPU: 64 PID: 0 at kernel/sched/core.c:3210 set_task_cpu+0x190/0x250
> [  686.186537] Modules linked in: kthread_workload(O) bluetooth rfkill xt_CHECKSUM iptable_mangle xt_conntrack ipt_REJECT nf_reject_ipv4 ip6table_filter ip6_tables iptable_filter ib_isert iscsi_target_mod ib_ipoib ib_umad rpcrdma ib_iser libiscsi scsi_transport_iscsi crct10dif_ce hns_roce_hw_v2 arm_spe_pmu sbsa_gwdt sm4_generic sm4 xts ecb hisi_hpre hisi_uncore_l3c_pmu hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_trng_v2 rng_core hisi_uncore_pmu spi_dw_mmio hisi_zip hisi_sec2 hisi_qm uacce hclge hns3 hnae3 hisi_sas_v3_hw hisi_sas_main libsas [last unloaded: kthread_workload(O)]
> [  686.293937] CPU: 64 PID: 0 Comm: swapper/64 Tainted: G           O       6.4.0-rc1-migration-race-debug+ #24
> [  686.314616] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V5.B211.01 11/10/2021
> [  686.333285] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  686.347930] pc : set_task_cpu+0x190/0x250
> [...]
>
> It shows that we're going to balance the task to its current CPU (CPU 1) rather than
> the balancer CPU (CPU 64). It's because we're going to find a new dst_cpu if the task
> on the src_cpu is pinned, and the new_dst_cpu happens to be the task's current CPU.
>

Nicely found! Thanks for having spent time on this. I haven't been able to
retrigger the issue using your reproducer, but I think you have indeed
found the root cause of it.

> So the right way to solve this maybe avoid selecting the src_cpu as the new_dst_cpu and
> below patch works to solve this issue.
>
> @@ -8550,7 +8564,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>
>                 /* Prevent to re-select dst_cpu via env's CPUs: */
>                 for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
> -                       if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                       if (cpumask_test_cpu(cpu, p->cpus_ptr) && cpu != env->src_cpu) {
>                                 env->flags |= LBF_DST_PINNED;
>                                 env->new_dst_cpu = cpu;
>                                 break;
>

Other than having some better inplace cpumask helpers, I don't think we can
make this look better. Could you send this change as a proper patch, please?

> Thanks,
> Yicong

