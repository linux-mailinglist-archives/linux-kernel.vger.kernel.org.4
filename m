Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B336BDFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCQDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCQDap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:30:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958B9EF4D;
        Thu, 16 Mar 2023 20:30:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pd8ll2c5Tz4f3q1t;
        Fri, 17 Mar 2023 11:30:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CHQ3hNkwFg8FA--.47950S3;
        Fri, 17 Mar 2023 11:30:26 +0800 (CST)
Subject: Re: [PATCH v2 3/5] md: use md_thread api to wake up sync_thread
To:     kernel test robot <oliver.sang@intel.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-raid@vger.kernel.org,
        agk@redhat.com, snitzer@kernel.org, song@kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de, "yukuai (C)" <yukuai3@huawei.com>
References: <202303170904.640a8ece-oliver.sang@intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3e171048-060f-af7c-35ec-76fad4fb6f08@huaweicloud.com>
Date:   Fri, 17 Mar 2023 11:30:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202303170904.640a8ece-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CHQ3hNkwFg8FA--.47950S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8Gw4UJFyUWryrurWfZrb_yoW3XF47pF
        yq9Fn7GF48W3srJFyUG3WUCa4fXw47Aay7Kry7Grn3J345Kw12qF1v9r12vF1DtF4akFyS
        qwnrXrW09r48Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/17 10:30, kernel test robot 写道:
> 
> Greeting,
> 
> FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit (built with gcc-11):
> 
> commit: af2203c7e88c00d3ce072f18c18a36e2936372fd ("[PATCH v2 3/5] md: use md_thread api to wake up sync_thread")
> url: https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-pass-a-md_thread-pointer-to-md_register_thread/20230315-142018
> base: git://git.kernel.org/cgit/linux/kernel/git/song/md.git md-next
> patch link: https://lore.kernel.org/all/20230315061810.653263-4-yukuai1@huaweicloud.com/
> patch subject: [PATCH v2 3/5] md: use md_thread api to wake up sync_thread
> 

I don't expect there is any difference between:

if (mddev->sync_thread)
	wake_up_process(mddev->sync_thread->tsk);

and:

md_wakeup_thread(mddev->sync_thread);

I still don't understand the problem.. I'll try to reporduce this,
untill them, I guess I'll just drop this patch.

Thanks,
Kuai
> in testcase: mdadm-selftests
> version: mdadm-selftests-x86_64-5f41845-1_20220826
> with following parameters:
> 
> 	disk: 1HDD
> 	test_prefix: 07revert
> 
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303170904.640a8ece-oliver.sang@intel.com
> 
> 
> kern  :err   : [  990.133727] INFO: task mdadm:1040 blocked for more than 491 seconds.
> kern  :err   : [  990.140824]       Tainted: G S                 6.3.0-rc1-00019-gaf2203c7e88c #1
> kern  :err   : [  990.148856] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kern  :info  : [  990.157410] task:mdadm           state:D stack:0     pid:1040  ppid:963    flags:0x00000000
> kern  :info  : [  990.166483] Call Trace:
> kern  :info  : [  990.169666]  <TASK>
> kern :info : [  990.172504] __schedule (kernel/sched/core.c:5304 kernel/sched/core.c:6622)
> kern :info : [  990.176810] ? io_schedule_timeout (kernel/sched/core.c:6504)
> kern :info : [  990.181994] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> kern :info : [  990.187250] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153)
> kern :info : [  990.192255] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6699 (discriminator 1))
> kern :info : [  990.196291] do_md_stop (drivers/md/md.c:6364 (discriminator 29))
> kern :info : [  990.200603] ? md_kick_rdev_from_array (drivers/md/md.c:6344)
> kern :info : [  990.206111] ? add_ptr_to_bulk_krc_lock (arch/x86/include/asm/atomic.h:95 include/linux/atomic/atomic-instrumented.h:191 kernel/rcu/tree.c:3273)
> kern :info : [  990.211711] ? cpuacct_stats_show (kernel/sched/wait.c:418)
> kern :info : [  990.216787] ? schedule_delayed_monitor_work (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/rcu/tree.c:3044)
> kern :info : [  990.222736] ? __cond_resched (kernel/sched/core.c:8486)
> kern :info : [  990.227292] ? mutex_lock_interruptible (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:443 include/linux/atomic/atomic-instrumented.h:1781 kernel/locking/mutex.c:171 kernel/locking/mutex.c:981)
> kern :info : [  990.232725] ? __mutex_lock_interruptible_slowpath (kernel/locking/mutex.c:978)
> kern :info : [  990.239095] ? __mutex_unlock_slowpath+0x2a0/0x2a0
> kern :info : [  990.245668] md_ioctl (drivers/md/md.c:7642)
> kern :info : [  990.249809] ? hot_add_disk (drivers/md/md.c:7513)
> kern :info : [  990.254360] ? __call_rcu_common+0x363/0x900
> kern :info : [  990.260389] ? blkdev_bszset (block/ioctl.c:473)
> kern :info : [  990.265047] ? rcu_nocb_gp_kthread (kernel/rcu/tree.c:2596)
> kern :info : [  990.270224] ? __fput (include/linux/fs.h:2554 fs/internal.h:110 fs/file_table.c:328)
> kern :info : [  990.274269] ? __cond_resched (kernel/sched/core.c:8486)
> kern :info : [  990.278826] blkdev_ioctl (block/ioctl.c:615)
> kern :info : [  990.283223] ? blkdev_common_ioctl (block/ioctl.c:560)
> kern :info : [  990.288568] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> kern :info : [  990.293139] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153)
> kern :info : [  990.298137] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856)
> kern :info : [  990.302800] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> kern :info : [  990.307108] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> kern  :info  : [  990.312889] RIP: 0033:0x7f00b07c8cc7
> kern  :info  : [  990.317187] RSP: 002b:00007ffc27cbbc88 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> kern  :info  : [  990.325483] RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 00007f00b07c8cc7
> kern  :info  : [  990.333342] RDX: 0000000000000000 RSI: 0000000000000932 RDI: 0000000000000004
> kern  :info  : [  990.341195] RBP: 0000000000000004 R08: 0000000000000002 R09: 0000000000000000
> kern  :info  : [  990.349044] R10: fffffffffffff28e R11: 0000000000000206 R12: 00007ffc27cbe994
> kern  :info  : [  990.356888] R13: 0000000000000005 R14: 00007ffc27cbbd30 R15: 0000557160bdec10
> kern  :info  : [  990.364750]  </TASK>
> user  :err   : [ 1006.832241] Terminated
> 
> user  :notice: [ 1006.968217] /lkp/benchmarks/mdadm-selftests/tests/07revert-grow... FAILED - see /var/tmp/07revert-grow.log and /var/tmp/fail07revert-grow.log for details
> 
> user  :notice: [ 1007.123127] 07revert-grow TIMEOUT
> 
> user  :err   : [ 1008.444219] mdadm: cannot open /dev/md0: No such device
> 
> user  :notice: [ 1012.202178] test: please run test suite without running RAIDs environment.
> 
> user  :notice: [ 1017.437744] test: please run test suite without running RAIDs environment.
> 
> user  :notice: [ 1017.836121] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-hsw-d05/mdadm-selftests-1HDD-07revert-debian-11.1-x86_64-20220510.cgz-af2203c7e88c00d3ce072f18c18a36e2936372fd-20230317-32283-1997139-5.yaml&job_state=post_run -O /dev/null
> 
> user  :notice: [ 1019.573946] kill 528 vmstat --timestamp -n 10
> 
> user  :notice: [ 1019.588893] kill 526 dmesg --follow --decode
> 
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 

