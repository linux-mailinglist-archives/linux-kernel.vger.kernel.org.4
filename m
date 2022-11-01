Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C3614BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKANhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKANhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:37:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D51156
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:37:06 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N1rb71XyMzJn2H;
        Tue,  1 Nov 2022 21:34:11 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 21:37:03 +0800
Subject: Re: [PATCH v2] x86/cpu: replacing the open-coded shift with BIT(x)
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <puwen@hygon.cn>, <TonyWWang-oc@zhaoxin.com>,
        <peterz@infradead.org>, <gregkh@linuxfoundation.org>,
        <andrew.cooper3@citrix.com>, <tony.luck@intel.com>,
        <mario.limonciello@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
        <chenyi.qiang@intel.com>, <rdunlap@infradead.org>,
        <jithu.joseph@intel.com>, <rafael.j.wysocki@intel.com>,
        <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221101111418.816139-1-cuigaosheng1@huawei.com>
 <Y2EEY63DnDodJFoz@zx2c4.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <eed4512b-ac6e-bcec-2f66-7ab45aef9be9@huawei.com>
Date:   Tue, 1 Nov 2022 21:37:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y2EEY63DnDodJFoz@zx2c4.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Others might feel differently and that's fine, but I always found the
> BIT() thing so much less clear than doing 1<<n, which is not only a
> pattern that I recognize as builtin to my brain, but also provides a
> direct description of what's happening, "shift a 1 over n times",
> leaving no off-by-one ambiguity about it. If anything I'd like to see
> the BIT() macro expanded throughout and then removed entirely.
>
> Probably just me though. You can safely ignore my opinion.

Thanks for taking time to review the patch, I submit the patch to remove
the UBSAN warning, even it's not a bug, for example, when I am testing the
kernel, I get some logs as follows, maybe it's better to avoid this?

> [ 0.951719][ T0] 
> ================================================================================ 
> 215 [ 0.953146][ T0] UBSAN: shift-out-of-bounds in mm/shmem.c:3749:18 
> 216 [ 0.953863][ T0] left shift of 1 by 31 places cannot be 
> represented in type 'int' 217 [ 0.955067][ T0] CPU: 0 PID: 0 Comm: 
> swapper/0 Not tainted 6.1.0-rc2-00062-ga970174d7a10 #5 218 [ 
> 0.956400][ T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014 219 [ 
> 0.958278][ T0] Call Trace: 220 [ 0.958777][ T0] <TASK> 221 [ 
> 0.959224][ T0] dump_stack_lvl+0x8d/0xcf 222 [ 0.959922][ T0] 
> ubsan_epilogue+0xa/0x44 223 [ 0.960599][ T0] 
> __ubsan_handle_shift_out_of_bounds+0x1e7/0x208 224 [ 0.961575][ T0] ? 
> __kmem_cache_alloc_node+0x167/0x290 225 [ 0.962434][ T0] ? 
> shmem_fill_super+0x2e/0x2e0 226 [ 0.963187][ T0] ? 
> rcu_read_lock_held_common+0x9/0x40 227 [ 0.963857][ T0] ? 
> shmem_alloc_hugefolio+0x110/0x110 228 [ 0.963857][ T0] ? 
> shmem_fill_super+0x2cc/0x2e0 229 [ 0.963857][ T0] 
> shmem_fill_super+0x2cc/0x2e0 230 [ 0.963857][ T0] 
> vfs_get_super+0x78/0x160 231 [ 0.963857][ T0] vfs_get_tree+0x28/0x100 
> 232 [ 0.963857][ T0] fc_mount+0x12/0x60 233 [ 0.963857][ T0] 
> vfs_kern_mount.part.38+0xa5/0xc0 234 [ 0.963857][ T0] 
> kern_mount+0x2e/0x60 235 [ 0.963857][ T0] shmem_init+0x63/0xef 236 [ 
> 0.963857][ T0] mnt_init+0x159/0x2e0 237 [ 0.963857][ T0] ? 
> trace_init_perf_perm_irq_work_exit+0xe/0xe 238 [ 0.963857][ T0] 
> vfs_caches_init+0xd4/0xde 239 [ 0.963857][ T0] 
> start_kernel+0x837/0x8a4 240 [ 0.963857][ T0] 
> secondary_startup_64_no_verify+0xce/0xdb 241 [ 0.963857][ T0] </TASK> 
> 242 [ 0.963860][ T0] 
> ================================================================================ 
> 243 [ 0.965288][ T0] Kernel panic - not syncing: panic_on_warn set ... 
> 244 [ 0.966299][ T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
> 6.1.0-rc2-00062-ga970174d7a10 #5 245 [ 0.967645][ T0] Hardware name: 
> QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014 246 [ 
> 0.969548][ T0] Call Trace: 247 [ 0.970050][ T0] <TASK> 248 [ 
> 0.970499][ T0] dump_stack_lvl+0x8d/0xcf 249 [ 0.971195][ T0] 
> panic+0x182/0x387 250 [ 0.971797][ T0] ? ubsan_epilogue+0x33/0x44 251 
> [ 0.972539][ T0] ubsan_epilogue+0x3f/0x44 252 [ 0.973237][ T0] 
> __ubsan_handle_shift_out_of_bounds+0x1e7/0x208 253 [ 0.973857][ T0] ? 
> __kmem_cache_alloc_node+0x167/0x290 254 [ 0.973857][ T0] ? 
> shmem_fill_super+0x2e/0x2e0 255 [ 0.973857][ T0] ? 
> rcu_read_lock_held_common+0x9/0x40 256 [ 0.973857][ T0] ? 
> shmem_alloc_hugefolio+0x110/0x110 257 [ 0.973857][ T0] ? 
> shmem_fill_super+0x2cc/0x2e0 258 [ 0.973857][ T0] 
> shmem_fill_super+0x2cc/0x2e0 259 [ 0.973857][ T0] 
> vfs_get_super+0x78/0x160 260 [ 0.973857][ T0] vfs_get_tree+0x28/0x100 
> 261 [ 0.973857][ T0] fc_mount+0x12/0x60 262 [ 0.973857][ T0] 
> vfs_kern_mount.part.38+0xa5/0xc0 263 [ 0.973857][ T0] 
> kern_mount+0x2e/0x60 264 [ 0.973857][ T0] shmem_init+0x63/0xef 265 [ 
> 0.973857][ T0] mnt_init+0x159/0x2e0 266 [ 0.973857][ T0] ? 
> trace_init_perf_perm_irq_work_exit+0xe/0xe 267 [ 0.973857][ T0] 
> vfs_caches_init+0xd4/0xde 268 [ 0.973857][ T0] 
> start_kernel+0x837/0x8a4 269 [ 0.973857][ T0] 
> secondary_startup_64_no_verify+0xce/0xdb 270 [ 0.973857][ T0] </TASK> 
> 271 [ 0.973857][ T0] Rebooting in 86400 seconds..

On 2022/11/1 19:34, Jason A. Donenfeld wrote:
> Others might feel differently and that's fine, but I always found the
> BIT() thing so much less clear than doing 1<<n, which is not only a
> pattern that I recognize as builtin to my brain, but also provides a
> direct description of what's happening, "shift a 1 over n times",
> leaving no off-by-one ambiguity about it. If anything I'd like to see
> the BIT() macro expanded throughout and then removed entirely.
>
> Probably just me though. You can safely ignore my opinion:).
