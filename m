Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA6704D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEPMCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjEPMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:02:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1E10D7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:02:03 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QLF8n6NbtzTkh7;
        Tue, 16 May 2023 19:57:13 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:01:59 +0800
Subject: Re: [PATCH] irqchipi/gic-v4: Ensure accessing the correct RD when and
 writing INVLPIR
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <chenxiang66@hisilicon.com>,
        <tangnianyao@huawei.com>
References: <20230412041510.497-1-jiangkunkun@huawei.com>
 <86y1mxl9m4.wl-maz@kernel.org>
 <f618c540-879c-ca5b-31af-e55472d8208c@huawei.com>
 <86bkikmvjk.wl-maz@kernel.org>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <b073b1f7-0567-eb45-dec9-dcd2054e41c9@huawei.com>
Date:   Tue, 16 May 2023 20:01:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <86bkikmvjk.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2023/5/16 18:15, Marc Zyngier wrote:
> On Thu, 13 Apr 2023 04:57:17 +0100,
> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>>> Wouldn't it be nice if irq_to_cpuid() could work out whether it is
>>> dealing with a LPI or a VLPI like it does today, but also directly
>>> with a VPE? We could then use the same code as derect_lpi_inv(). I
>>> came up with this the hack below, which is totally untested as I don't
>>> have access to GICv4.1 HW.
>>>
>>> Could you give it a spin?
>> Nice, I will test it as soon as possible.
> Did you ever managed to test this?
Sorry,I've only been coordinating the GICv4.1 environment in the last
few days. I have tested it with GICv4 many times, and it doesn't recur.
However, another call trace occurs with GICv4.1 when the device driver
is loaded in Guest. I haven't found out why. Maybe you can help analyze it.
😁
> [ 7853.520985] Call trace:
> [ 7853.523418]  dump_backtrace.part.0+0xc4/0xd0
> [ 7853.527679]  show_stack+0x20/0x30
> [ 7853.530980]  dump_stack_lvl+0x68/0x84
> [ 7853.534630]  dump_stack+0x18/0x34
> [ 7853.537932]  __schedule_bug+0x5c/0x74
> [ 7853.541583]  __schedule+0xe24/0x1180
> [ 7853.545146]  schedule+0x64/0x104
> [ 7853.548362]  schedule_timeout+0x184/0x1c4
> [ 7853.552358]  wait_for_completion+0x7c/0x160
> [ 7853.556528]  __synchronize_srcu.part.0+0x80/0xf4
> [ 7853.561133]  synchronize_srcu_expedited+0x38/0x4c
> [ 7853.565823]  kvm_set_irq_routing+0x268/0x2d0
> [ 7853.570081]  kvm_vm_ioctl+0x624/0x13f0
> [ 7853.573817]  __arm64_sys_ioctl+0xb0/0xf4
> [ 7853.577728]  invoke_syscall+0x50/0x120
> [ 7853.581464]  el0_svc_common.constprop.0+0x168/0x190
> [ 7853.586330]  do_el0_svc+0x40/0xc4
> [ 7853.589632]  el0_svc+0x2c/0xb4
> [ 7853.592673]  el0t_64_sync_handler+0xb8/0xbc
> [ 7853.596843]  el0t_64_sync+0x1a0/0x1a4
> [ 7874.512000] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 7874.518087] rcu:     9-...0: (507 ticks this GP) 
> idle=9054/1/0x4000000000000000 softirq=3223/3226 fqs=2255
> [ 7874.527467] rcu:     14-...0: (1182 ticks this GP) 
> idle=97fc/1/0x4000000000000000 softirq=3480/3481 fqs=2255
> [ 7874.537020] rcu:     16-...0: (1183 ticks this GP) 
> idle=af4c/1/0x4000000000000000 softirq=3355/3357 fqs=2255
> [ 7874.546573] rcu:     20-...0: (1189 ticks this GP) 
> idle=8f9c/1/0x4000000000000000 softirq=3749/3751 fqs=2255
> [ 7874.556125] rcu:     38-...0: (1192 ticks this GP) 
> idle=0204/1/0x4000000000000000 softirq=3515/3517 fqs=2255
> [ 7874.565677] rcu:     50-...0: (1194 ticks this GP) 
> idle=4224/1/0x4000000000000000 softirq=3281/3283 fqs=2255
> [ 7874.575229] rcu:     56-...0: (573 ticks this GP) 
> idle=309c/1/0x4000000000000000 softirq=3400/3400 fqs=2255
> [ 7874.584694] rcu:     58-...0: (1195 ticks this GP) 
> idle=2094/1/0x4000000000000000 softirq=3565/3567 fqs=2255
> [ 7874.594246] rcu:     60-...0: (757 ticks this GP) 
> idle=2ac4/1/0x4000000000000000 softirq=3343/3343 fqs=2255
> [ 7874.603711] rcu:     62-...0: (1183 ticks this GP) 
> idle=1da4/1/0x4000000000000000 softirq=3403/3406 fqs=2255
> [ 7874.613263] rcu:     65-...0: (214 ticks this GP) 
> idle=e40c/1/0x4000000000000000 softirq=3731/3731 fqs=2255
> [ 7874.622728] rcu:     66-...0: (1174 ticks this GP) 
> idle=b3ec/1/0x4000000000000000 softirq=3783/3784 fqs=2255
> [ 7874.632280] rcu:     68-...0: (1194 ticks this GP) 
> idle=60dc/1/0x4000000000000000 softirq=4373/4375 fqs=2255
> [ 7874.641832] rcu:     72-...0: (1183 ticks this GP) 
> idle=a61c/1/0x4000000000000000 softirq=4001/4003 fqs=2255
> [ 7874.651383] rcu:     74-...0: (1182 ticks this GP) 
> idle=ae2c/1/0x4000000000000000 softirq=4200/4202 fqs=2255
> [ 7874.660935] rcu:     79-...0: (1195 ticks this GP) 
> idle=196c/1/0x4000000000000000 softirq=3598/3600 fqs=2255
> [ 7874.670487] rcu:     84-...0: (1183 ticks this GP) 
> idle=5bac/1/0x4000000000000000 softirq=3302/3304 fqs=2255
> [ 7874.680039] rcu:     86-...0: (1183 ticks this GP) 
> idle=17bc/1/0x4000000000000000 softirq=6017/6019 fqs=2255
> [ 7874.689591] rcu:     92-...0: (1183 ticks this GP) 
> idle=8484/1/0x4000000000000000 softirq=3653/3655 fqs=2255
> [ 7874.699142] rcu:     96-...0: (1183 ticks this GP) 
> idle=4dcc/1/0x4000000000000000 softirq=3348/3350 fqs=2255
> [ 7874.708694] rcu:     102-...0: (1180 ticks this GP) 
> idle=a4bc/1/0x4000000000000000 softirq=3414/3416 fqs=2255
> [ 7874.718333] rcu:     108-...0: (1183 ticks this GP) 
> idle=5c6c/1/0x4000000000000000 softirq=3490/3492 fqs=2255
> [ 7874.727972] rcu:     118-...0: (1195 ticks this GP) 
> idle=08c4/1/0x4000000000000000 softirq=3637/3639 fqs=2255
> [ 7874.737610] rcu:     122-...0: (1181 ticks this GP) 
> idle=68dc/1/0x4000000000000000 softirq=3863/3865 fqs=2255
> [ 7874.747251]     (detected by 90, t=5308 jiffies, g=16833, q=38 
> ncpus=128)
> [ 7874.753765] Task dump for CPU 9:
> [ 7874.756980] task:qemu-system-aar state:R  running task stack:0     
> pid:8183  ppid:7426   flags:0x0000020a
> [ 7874.766881] Call trace:
> [ 7874.769314]  __switch_to+0xf0/0x170
> [ 7874.772794]  __per_cpu_offset+0x0/0x2000
> [ 7874.776705] Task dump for CPU 14:
> [ 7874.780006] task:qemu-system-aar state:R  running task stack:0     
> pid:8205  ppid:7426   flags:0x0000020a
> [ 7874.789906] Call trace:
> [ 7874.792338]  __switch_to+0xf0/0x170
> [ 7874.795814]  __per_cpu_offset+0x0/0x2000
> [ 7874.799724] Task dump for CPU 16:
> [ 7874.803024] task:qemu-system-aar state:R  running task stack:0     
> pid:8196  ppid:7426   flags:0x0000020a
> [ 7874.812924] Call trace:
> [ 7874.815357]  __switch_to+0xf0/0x170
> [ 7874.818833]  __per_cpu_offset+0x0/0x2000
> [ 7874.822742] Task dump for CPU 20:
> [ 7874.826042] task:qemu-system-aar state:R  running task stack:0     
> pid:8201  ppid:7426   flags:0x0000020a
> [ 7874.835942] Call trace:
> [ 7874.838374]  __switch_to+0xf0/0x170
> [ 7874.841850]  __per_cpu_offset+0x0/0x2000
> [ 7874.845760] Task dump for CPU 38:
> [ 7874.849061] task:qemu-system-aar state:R  running task stack:0     
> pid:8193  ppid:7426   flags:0x0000020a
> [ 7874.858960] Call trace:
> [ 7874.861393]  __switch_to+0xf0/0x170
> [ 7874.864868]  __per_cpu_offset+0x0/0x2000
> [ 7874.868778] Task dump for CPU 50:
> [ 7874.872078] task:qemu-system-aar state:R  running task stack:0     
> pid:8199  ppid:7426   flags:0x0000020a
> [ 7874.881978] Call trace:
> [ 7874.884411]  __switch_to+0xf0/0x170
> [ 7874.887887]  __per_cpu_offset+0x0/0x2000
> [ 7874.891796] Task dump for CPU 56:
> [ 7874.895097] task:qemu-system-aar state:R  running task stack:0     
> pid:8202  ppid:7426   flags:0x0000020a
> [ 7874.904996] Call trace:
> [ 7874.907429]  __switch_to+0xf0/0x170
> [ 7874.910904]  __per_cpu_offset+0x0/0x2000
> [ 7874.914814] Task dump for CPU 58:
> [ 7874.918114] task:qemu-system-aar state:R  running task stack:0     
> pid:8200  ppid:7426   flags:0x0000020a
> [ 7874.928014] Call trace:
> [ 7874.930446]  __switch_to+0xf0/0x170
> [ 7874.933922]  __per_cpu_offset+0x0/0x2000
> [ 7874.937831] Task dump for CPU 60:
> [ 7874.941132] task:qemu-system-aar state:R  running task stack:0     
> pid:8192  ppid:7426   flags:0x0000020a
> [ 7874.951032] Call trace:
> [ 7874.953464]  __switch_to+0xf0/0x170
> [ 7874.956940]  __per_cpu_offset+0x0/0x2000
> [ 7874.960849] Task dump for CPU 62:
> [ 7874.964150] task:qemu-system-aar state:R  running task stack:0     
> pid:8195  ppid:7426   flags:0x0000020a
> [ 7874.974049] Call trace:
> [ 7874.976482]  __switch_to+0xf0/0x170
> [ 7874.979958]  __per_cpu_offset+0x0/0x2000
> [ 7874.983867] Task dump for CPU 65:
> [ 7874.987167] task:qemu-system-aar state:R  running task stack:0     
> pid:8186  ppid:7426   flags:0x0000020a
> [ 7874.997067] Call trace:
> [ 7874.999499]  __switch_to+0xf0/0x170
> [ 7875.002975]  __per_cpu_offset+0x0/0x2000
> [ 7875.006885] Task dump for CPU 66:
> [ 7875.010185] task:qemu-system-aar state:R  running task stack:0     
> pid:8190  ppid:7426   flags:0x0000020a
> [ 7875.020085] Call trace:
> [ 7875.022517]  __switch_to+0xf0/0x170
> [ 7875.025993]  __per_cpu_offset+0x0/0x2000
> [ 7875.029902] Task dump for CPU 68:
> [ 7875.033203] task:qemu-system-aar state:R  running task stack:0     
> pid:8185  ppid:7426   flags:0x0000020a
> [ 7875.043103] Call trace:
> [ 7875.045535]  __switch_to+0xf0/0x170
> [ 7875.049011]  __per_cpu_offset+0x0/0x2000
> [ 7875.052920] Task dump for CPU 72:
> [ 7875.056221] task:qemu-system-aar state:R  running task stack:0     
> pid:8188  ppid:7426   flags:0x0000020a
> [ 7875.066120] Call trace:
> [ 7875.068553]  __switch_to+0xf0/0x170
> [ 7875.072029]  __per_cpu_offset+0x0/0x2000
> [ 7875.075938] Task dump for CPU 74:
> [ 7875.079238] task:qemu-system-aar state:R  running task stack:0     
> pid:8207  ppid:7426   flags:0x0000020a
> [ 7875.089138] Call trace:
> [ 7875.091570]  __switch_to+0xf0/0x170
> [ 7875.095046]  __per_cpu_offset+0x0/0x2000
> [ 7875.098955] Task dump for CPU 79:
> [ 7875.102256] task:qemu-system-aar state:R  running task stack:0     
> pid:8179  ppid:7426   flags:0x0000020a
> [ 7875.112155] Call trace:
> [ 7875.114588]  __switch_to+0xf0/0x170
> [ 7875.118064]  __per_cpu_offset+0x0/0x2000
> [ 7875.121973] Task dump for CPU 84:
> [ 7875.125273] task:qemu-system-aar state:R  running task stack:0     
> pid:8203  ppid:7426   flags:0x0000020a
> [ 7875.135173] Call trace:
> [ 7875.137605]  __switch_to+0xf0/0x170
> [ 7875.141081]  __per_cpu_offset+0x0/0x2000
> [ 7875.144990] Task dump for CPU 86:
> [ 7875.148291] task:qemu-system-aar state:R  running task stack:0     
> pid:8198  ppid:7426   flags:0x0000020a
> [ 7875.158191] Call trace:
> [ 7875.160623]  __switch_to+0xf0/0x170
> [ 7875.164099]  __per_cpu_offset+0x0/0x2000
> [ 7875.168008] Task dump for CPU 92:
> [ 7875.171309] task:qemu-system-aar state:R  running task stack:0     
> pid:8187  ppid:7426   flags:0x00000202
> [ 7875.181208] Call trace:
> [ 7875.183641]  __switch_to+0xf0/0x170
> [ 7875.187117]  __per_cpu_offset+0x0/0x2000
> [ 7875.191026] Task dump for CPU 96:
> [ 7875.194326] task:qemu-system-aar state:R  running task stack:0     
> pid:8177  ppid:7426   flags:0x0000020a
> [ 7875.204226] Call trace:
> [ 7875.206659]  __switch_to+0xf0/0x170
> [ 7875.210134]  __per_cpu_offset+0x0/0x2000
> [ 7875.214044] Task dump for CPU 102:
> [ 7875.217431] task:qemu-system-aar state:R  running task stack:0     
> pid:8176  ppid:7426   flags:0x00000202
> [ 7875.227331] Call trace:
> [ 7875.229763]  __switch_to+0xf0/0x170
> [ 7875.233239]  __per_cpu_offset+0x0/0x2000
> [ 7875.237148] Task dump for CPU 108:
> [ 7875.240536] task:qemu-system-aar state:R  running task stack:0     
> pid:8184  ppid:7426   flags:0x00000202
> [ 7875.250435] Call trace:
> [ 7875.252868]  __switch_to+0xf0/0x170
> [ 7875.256343]  __per_cpu_offset+0x0/0x2000
> [ 7875.260253] Task dump for CPU 118:
> [ 7875.263640] task:qemu-system-aar state:R  running task stack:0     
> pid:8206  ppid:7426   flags:0x0000020a
> [ 7875.273540] Call trace:
> [ 7875.275972]  __switch_to+0xf0/0x170
> [ 7875.279448]  __per_cpu_offset+0x0/0x2000
> [ 7875.283357] Task dump for CPU 122:
> [ 7875.286745] task:qemu-system-aar state:R  running task stack:0     
> pid:8189  ppid:7426   flags:0x0000020a
> [ 7875.296644] Call trace:
> [ 7875.299077]  __switch_to+0xf0/0x170
> [ 7875.302553]  __per_cpu_offset+0x0/0x2000
Thanks,
Kunkun Jiang
>
> Thanks,
>
> 	M.
>
