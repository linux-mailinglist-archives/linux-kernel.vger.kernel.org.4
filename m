Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F66E0D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDMMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDMMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:40:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E9893D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:40:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24684839593so443414a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681389619; x=1683981619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i16n0EuVK4Vx0ZuKRn6aio2E46/COqvGNVETpBt7N3M=;
        b=bdMi6LRsmzApVT+9lVXV449TlaEayjrcxsJPYMRY9RE/SLWpGzePKOtoVIMuhPf+6l
         rNixzs9jq31hq5YM06Zt54JOtdGbp5eR+2PHuz3J0t94ahYKRDOgRvjkntXCT94rgWCB
         4VWGNts1z+YkZfJp0FwQWTkM8xWcFyQSnhp883Y6wEWNhqT6mUTegSlAY/zW/BwOgCJa
         CbtjyXI/BwSG4enkF9adD4R7NE+5MoRiyO8+naY+H4OdJaTvdTM8QVnnVWXpaglHIYCc
         LUo6XsQTBlqfE+dWEELN8N71w3NeAuKRI7yybzA4DPatD+/Z7TbfWjDMNSusW2nB38sA
         L++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681389619; x=1683981619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i16n0EuVK4Vx0ZuKRn6aio2E46/COqvGNVETpBt7N3M=;
        b=lbmUcw2NC52ajku2s3bCKMmOHzGz7HaTkJBShaH69RhwI4/bBghM0+hflcP08NPdeQ
         vy+zVJpCmcpnrZ1JQL9xN+Hvfkg2M2s3HjFWlI6xi34g1uzoPgOA3HiEJOmf0GkId+32
         eTWPZpfZISJVgWA3AnaMqJOon6X18n+kyS7uPUI8liokRIWmveUUt9wyzWmd+LUbvqvj
         EqOtilruirpmzeCaFwT0Z3ZSyYQTOqeoTmbBk5xcPSPLO0sJ+IJWf/wUiH48JtxHXdqV
         3wreuoIfQXykFMPwV17vEdkraTrujNUVTa9UnVZoh3J65i8p45Vqu/TARlZX7uOv6Nb8
         XWYQ==
X-Gm-Message-State: AAQBX9eHz8y/uygUGczz1/kINDxyQsjFcj5KFvOyb++AGlORayfzyWA8
        aJFbugwN13+rNk86bY2aMIfkAA==
X-Google-Smtp-Source: AKy350YfB/uw5Jo/wLazNddCOrm7dQFK1n8bAWp4X8ziV89fXv+4J24xTdrtmvqrtz0KrLBIFO1rIA==
X-Received: by 2002:a17:90a:1988:b0:236:1ec1:6d30 with SMTP id 8-20020a17090a198800b002361ec16d30mr1628759pji.3.1681389618490;
        Thu, 13 Apr 2023 05:40:18 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709026bc800b001943d58268csm1416799plt.55.2023.04.13.05.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 05:40:18 -0700 (PDT)
Message-ID: <441aa796-5c39-1cf5-c71a-f04633773968@kernel.dk>
Date:   Thu, 13 Apr 2023 06:40:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
To:     Frederic Weisbecker <frederic@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     lihuafei1@huawei.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        quic_neeraju@quicinc.com, paulmck@kernel.org, heng.su@intel.com
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <ZDdsz+5/QehZ25hg@xpf.sh.intel.com> <ZDflLOCujdBNXl3D@lothringen>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDflLOCujdBNXl3D@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 5:19 AM, Frederic Weisbecker wrote:
> On Thu, Apr 13, 2023 at 10:45:35AM +0800, Pengfei Xu wrote:
>> Hi Huafei and kernel experts,
>>
>> It's a soft remind.
>> This issue could be reproduced in v6.3-rc6 kernel.
>> It could be reproduced on Alder lake, Raptor lake and so on x86 platforms.
>> After reverted the commit "0e792b89e6800c:ftrace: Fix use-after-free for
>> dynamic ftrace_ops" on top of v6.3-rc6 kernel, this issue was gone.
>>
>> New syzkaller reproduced code, repro.report, bisect_info.log and detailed logs
>> are in link:
>> https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchronize_rcu
> 
> I just tested against v6.3-rc6 and again all I get is this io_ring related
> issue:
> 
> [  448.290752] INFO: task kworker/u4:0:9 blocked for more than 294 seconds.
> [  448.293868]       Not tainted 6.3.0-rc6-kvm #1
> [  448.296019] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  448.299592] task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
> [  448.303397] Workqueue: events_unbound io_ring_exit_work
> [  448.305884] Call Trace:
> [  448.307147]  <TASK>
> [  448.308166]  __schedule+0x422/0xc90
> [  448.309824]  ? wait_for_completion+0x77/0x170
> [  448.311870]  schedule+0x63/0xd0
> [  448.313346]  schedule_timeout+0x2fe/0x4c0
> [  448.315255]  ? __this_cpu_preempt_check+0x1c/0x30
> [  448.317360]  ? _raw_spin_unlock_irq+0x27/0x60
> [  448.319400]  ? lockdep_hardirqs_on+0x88/0x120
> [  448.321395]  ? wait_for_completion+0x77/0x170
> [  448.323462]  wait_for_completion+0x9e/0x170
> [  448.325356]  io_ring_exit_work+0x2b0/0x810
> [  448.327300]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> [  448.329345]  ? _raw_spin_unlock_irq+0x27/0x60
> [  448.331397]  process_one_work+0x34e/0x720
> [  448.333212]  ? __pfx_io_ring_exit_work+0x10/0x10
> [  448.335377]  ? process_one_work+0x34e/0x720
> [  448.337295]  worker_thread+0x4e/0x530
> [  448.339079]  ? __pfx_worker_thread+0x10/0x10
> [  448.341008]  kthread+0x128/0x160
> [  448.342513]  ? __pfx_kthread+0x10/0x10
> [  448.344305]  ret_from_fork+0x2c/0x50
> [  448.346016]  </TASK>
> [  448.347176] 
> [  448.347176] Showing all locks held in the system:
> [  448.349887] 2 locks held by kworker/u4:0/9:
> [  448.351829]  #0: ffff88807eb6dd38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
> [  448.356362]  #1: ffffc9000005fe68 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
> [  448.361052] 1 lock held by rcu_tasks_kthre/11:
> [  448.363142]  #0: ffffffff83963450 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
> [  448.367396] 1 lock held by rcu_tasks_rude_/12:
> [  448.369387]  #0: ffffffff839631d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
> [  448.373808] 1 lock held by rcu_tasks_trace/13:
> [  448.375852]  #0: ffffffff83962f10 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
> [  448.380434] 1 lock held by khungtaskd/30:
> [  448.382219]  #0: ffffffff83963e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x17/0x1d0
> [  448.386291] 
> [  448.387159] =============================================
> [  448.387159] 

Is there a reproducer for this one so we can take a look? It's not
impossible to get into this state if you muck with signals, eg ring
exit work is queued but needs requests to complete, and the latter
is prevented by deliberately sending a SIGSTOP to the task that needs
to complete them.

-- 
Jens Axboe


