Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336767966E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjAXLRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjAXLRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:17:17 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF169CC1A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:17:15 -0800 (PST)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30OBGdod017722;
        Tue, 24 Jan 2023 20:16:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Tue, 24 Jan 2023 20:16:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30OBGdJr017719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Jan 2023 20:16:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a41a1cec-d1b0-16b2-171b-213e27fe96ca@I-love.SAKURA.ne.jp>
Date:   Tue, 24 Jan 2023 20:16:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [perf] lockdep warning between cpu_add_remove_lock and
 &dev->mutex.
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org
References: <b7bc63c8-bb28-d21d-7c3f-97e4e79a9292@I-love.SAKURA.ne.jp>
 <20230124095424.4448-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230124095424.4448-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/24 18:54, Hillf Danton wrote:
> Given device locked in the probe path, bind device to driver without lock held.
> Just to see whatever deadlock two steps ahead.
> 
>  void device_initial_probe(struct device *dev)
>  {
> +	/* invoked with device locked */
>  	__device_attach(dev, true);
>  }

Applying your diff with below diff resulted in flood of lockdep warnings
saying that device_initial_probe() is invoked without device locked.

--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1058,6 +1058,7 @@ EXPORT_SYMBOL_GPL(device_attach);
 void device_initial_probe(struct device *dev)
 {
         /* invoked with device locked */
+        device_lock_assert(dev);
         __device_attach(dev, true);
 }

----------
[    0.476081][    T1] PCI: Using configuration type 1 for base access
[    0.476375][    T1] ------------[ cut here ]------------
[    0.477185][    T1] WARNING: CPU: 0 PID: 1 at include/linux/device.h:851 device_initial_probe+0x37/0x50
[    0.478046][    T1] Modules linked in:
[    0.479046][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc5+ #13
[    0.480046][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[    0.481046][    T1] RIP: 0010:device_initial_probe+0x37/0x50
[    0.481268][    T1] Code: fb 85 c0 75 10 48 89 df be 01 00 00 00 e8 21 f4 ff ff 5b 5d c3 48 8d bf e8 00 00 00 be ff ff ff ff e8 cd 6d 2b 00 85 c0 75 db <0f> 0b be 01 00 00 00 48 89 df e8 fa f3 ff ff 5b 5d c3 0f 1f 80 00
[    0.483046][    T1] RSP: 0000:ffffaa0540017d48 EFLAGS: 00010246
[    0.484220][    T1] RAX: 0000000000000000 RBX: ffffa2e4f6e1a928 RCX: 0000000000000001
[    0.485233][    T1] RDX: 0000000000000001 RSI: ffffffffbde45e07 RDI: ffffffffbdea29ee
[    0.486065][    T1] RBP: ffffaa0540017d50 R08: 0000000000000001 R09: 0000000000000000
[    0.487056][    T1] R10: b7eeca500c46dbc8 R11: 0000000000000000 R12: ffffffffbe43ff40
[    0.488046][    T1] R13: ffffa2e4f6e1a928 R14: 0000000000000000 R15: ffffa2e4f6e1a928
[    0.489053][    T1] FS:  0000000000000000(0000) GS:ffffa2e4f6e00000(0000) knlGS:0000000000000000
[    0.489663][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.490226][    T1] CR2: ffffa2e3e8202000 CR3: 0000000127011001 CR4: 0000000000370ef0
[    0.491046][    T1] Call Trace:
[    0.491208][    T1]  <TASK>
[    0.492084][    T1]  bus_probe_device+0x9b/0xb0
[    0.492317][    T1]  device_add+0x3e1/0x900
[    0.493046][    T1]  ? __init_waitqueue_head+0x4a/0x70
[    0.493276][    T1]  ? rdinit_setup+0x27/0x27
[    0.494174][    T1]  device_register+0x15/0x20
[    0.494327][    T1]  register_cpu+0xda/0x120
[    0.495146][    T1]  arch_register_cpu+0x48/0x110
[    0.495288][    T1]  topology_init+0x35/0x3e
[    0.496110][    T1]  ? enable_cpu0_hotplug+0x10/0x10
[    0.496283][    T1]  do_one_initcall+0x58/0x300
[    0.497153][    T1]  ? rdinit_setup+0x27/0x27
[    0.498058][    T1]  ? rcu_read_lock_sched_held+0x4a/0x70
[    0.498255][    T1]  kernel_init_freeable+0x181/0x1d2
[    0.499046][    T1]  ? rest_init+0x190/0x190
[    0.499249][    T1]  kernel_init+0x15/0x120
[    0.500046][    T1]  ret_from_fork+0x1f/0x30
[    0.500258][    T1]  </TASK>
[    0.501059][    T1] irq event stamp: 101019
[    0.501161][    T1] hardirqs last  enabled at (101029): [<ffffffffbd0d9953>] __up_console_sem+0x53/0x60
[    0.502054][    T1] hardirqs last disabled at (101046): [<ffffffffbd0d9938>] __up_console_sem+0x38/0x60
[    0.503063][    T1] softirqs last  enabled at (101044): [<ffffffffbd8d524b>] __do_softirq+0x30b/0x46f
[    0.504061][    T1] softirqs last disabled at (101039): [<ffffffffbd06e859>] irq_exit_rcu+0xb9/0xf0
[    0.505076][    T1] ---[ end trace 0000000000000000 ]---
[    0.506065][   T11] Callback from call_rcu_tasks() invoked.
----------


