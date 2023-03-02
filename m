Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE46A7D15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCBIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:55:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642E23675
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677747340; x=1709283340;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Sh4C8t8AQqwAhVUYMflOhmVNErZd2AyhOVX+CopO1UM=;
  b=Boh4vf6phbQ+g68PVpTlJvHnGdFxiH+BuN4OUxgX9v9Mu7E59grFPnwD
   lLw564BY9S42yzPGihio6gMYpYDaCKiKmzlSE4B/rHE1AdGp3xF/h9uVy
   ajY0C1Yz8HQN33vlm9f3bCVHCNKzs/RhGNFCI1RWmWYM+EpjK2arKGiJe
   ZPQaFDBRKCCV78DTdC+FolbDgagwVD6kK/FQltxcQn8TWjuY0ax9oO8AL
   k4Jdtzi3qEloYon0OttyMYFcg/bEG4+uAxq/unDkEwf7brWnSEk00w6gO
   UddW/2I/C90nNyB/ueNtQdvEunhxOlm/Z/kLMTUO0GjjLkaZ3Ucc5AsQ+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336162598"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="336162598"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624853248"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="624853248"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2023 00:55:15 -0800
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        hsinyi@chromium.org, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, david.e.box@linux.intel.com
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
 <d595de9168d45bb5e863942ab7a78e3d@kernel.org>
 <32175259-ee22-9288-475c-db0da1ccee41@linux.intel.com>
 <87o7pch6lo.wl-maz@kernel.org>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <bc72258e-ce88-6812-08bf-0f16f15e02ce@linux.intel.com>
Date:   Thu, 2 Mar 2023 16:55:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o7pch6lo.wl-maz@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zyngier and Hovold,

On 3/1/23 10:46 PM, Marc Zyngier wrote:
> On Wed, 01 Mar 2023 11:17:21 +0000,
> Bingbu Cao <bingbu.cao@linux.intel.com> wrote:
>>
>>
>> On 2/28/23 8:45 AM, Marc Zyngier wrote:
>>> On 2023-02-27 10:46, Bingbu Cao wrote:
>>>> Hi, Johan and Zyngier,
>>>>
>>>> I am using a Dell XPS laptop(Intel Processor) just update my
>>>> Linux kernel to latest tag 6.2.0, and then I see that the kernel
>>>> cannot boot successfully, it reported:
>>>> --------------------------------------------
>>>> Gave up waiting for root file system device. Common problems:
>>>>  - Boot args (cat /proc/cmdline)
>>>>    - Check rootdelay= (did the system wait long enough?)
>>>>  - Missing modules (cat /proc/modules; ls /dev)
>>>>
>>>> ALERT! UUID=xxxxxxx does not exist. Dropping to shell!
>>>> --------------------------------------------
>>>>
>>>> And then it drop into initramfs shell, I try to use 'blkid' to
>>>> get block devices information, but it showed nothing.
>>>>
>>>> I also tried add 'rootdelay' and 'rootwait' in bootargs, but it did
>>>> not work.
>>>>
>>>> I am sure that my previous kernel 6.2.0-rc4 work normally, so I
>>>> did some bisect and found the commit below cause the failure on
>>>> my system:
>>>>
>>>> 9dbb8e3452ab irqdomain: Switch to per-domain locking
>>>>
>>>> I really have no idea why it cause my problem, but I see just
>>>> reverting this commit really help me.
>>>>
>>>> Do you have any idea?
>>>
>>> Please provide us with a kernel boot log. It is very hard
>>> to figure out what is going on without it. It would also
>>> help if you indicated what sort of device is your root
>>> filesystem on (NVMe, SATA, USB...), as it would narrow the
>>> search for the culprit.
>>
>> Unfortunately, I have not find a way to capture the console log, no
>> serial for me.
> 
> You don't need serial access. Since you're able to interact with the
> machine, you can save the dmesg log on some other mass storage. Just
> make sure that USB, for example is in your initramfs, and dump the log
> there.

I can dump the log by initramfs-tool now and checked that the change
https://lore.kernel.org/all/20230223083800.31347-1-jgross@suse.com/ 
can fix my problem, thanks for your help.

[    1.581072] PM:   Magic number: 15:512:8
[    1.581667] memory memory52: hash matches
[    1.582493] RAS: Correctable Errors collector initialized.
[    1.586949] Freeing unused decrypted memory: 2036K
[    1.588182] Freeing unused kernel image (initmem) memory: 4584K
[    1.604878] Write protecting the kernel read-only data: 26624k
[    1.606123] Freeing unused kernel image (rodata/data gap) memory: 928K
[    1.614504] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.615193] Run /init as init process
[    1.615867]   with arguments:
[    1.615868]     /init
[    1.615869]   with environment:
[    1.615869]     HOME=/
[    1.615870]     TERM=linux
[    1.615870]     BOOT_IMAGE=/vmlinuz-6.2.0-ipu
[    1.722303] wmi_bus wmi_bus-PNP0C14:02: WQBC data block query control method not found
[    1.723991] hid: raw HID events driver (C) Jiri Kosina
[    1.726080] BUG: kernel NULL pointer dereference, address: 0000000000000050
[    1.726874] #PF: supervisor read access in kernel mode
[    1.727687] #PF: error_code(0x0000) - not-present page
[    1.728491] PGD 0 P4D 0 
[    1.729280] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    1.730078] CPU: 3 PID: 154 Comm: systemd-udevd Not tainted 6.2.0-ipu #10
[    1.730870] Hardware name: Dell Inc. XPS 9315/, BIOS 0.0.22 12/23/2021
[    1.731670] RIP: 0010:irq_domain_create_hierarchy+0x2d/0x70
[    1.732470] Code: 00 00 55 48 89 e5 41 55 49 89 fd 48 89 cf 41 54 53 89 f3 85 d2 74 3f 89 d6 31 c9 89 d2 e8 6b fd ff ff 49 89 c4 4d 85 e4 74 1e <49> 8b 45 50 41 09 5c 24 28 4c 89 e7 4d 89 ac 24 80 00 00 00 49 89
[    1.733321] RSP: 0018:ffffb811c08e38f8 EFLAGS: 00010282
[    1.734156] RAX: ffff975001456540 RBX: 0000000000000010 RCX: 0000000000000000
[    1.734993] RDX: ffffffffadf8be90 RSI: ffffffffac7290a0 RDI: ffff975001456570
[    1.735841] RBP: ffffb811c08e3910 R08: ffff975001452900 R09: ffff975001452900
[    1.736676] R10: ffff975001452900 R11: ffff97510145206f R12: ffff975001456540
[    1.737515] R13: 0000000000000000 R14: 0000000000000013 R15: ffff975011860628
[    1.738349] FS:  00007f20175c08c0(0000) GS:ffff97537f8c0000(0000) knlGS:0000000000000000
[    1.739198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.740042] CR2: 0000000000000050 CR3: 0000000111e1c004 CR4: 0000000000770ee0
[    1.740892] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.741741] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[    1.742592] PKRU: 55555554
[    1.743415] Call Trace:
[    1.744226]  <TASK>
[    1.745045]  __msi_create_irq_domain+0xb8/0x180
[    1.745863]  msi_create_irq_domain+0x13/0x20
[    1.746680]  pci_msi_create_irq_domain+0x7a/0xe0
[    1.747493]  vmd_probe+0x85e/0x9a0 [vmd]
[    1.748313]  local_pci_probe+0x48/0xb0
[    1.749133]  pci_device_probe+0xc8/0x280
[    1.749961]  really_probe+0x186/0x3f0
[    1.750779]  __driver_probe_device+0x8a/0x190
[    1.751596]  driver_probe_device+0x23/0xb0
[    1.752422]  __driver_attach+0xc5/0x190
[    1.753246]  ? __pfx___driver_attach+0x10/0x10
[    1.754075]  bus_for_each_dev+0x7a/0xd0
[    1.755273]  driver_attach+0x1e/0x30
[    1.756095]  bus_add_driver+0x11c/0x230
[    1.756916]  driver_register+0x64/0x130
[    1.758073]  ? __pfx_init_module+0x10/0x10 [vmd]
[    1.758890]  __pci_register_driver+0x68/0x70
[    1.759696]  vmd_drv_init+0x23/0xff0 [vmd]
[    1.760495]  do_one_initcall+0x46/0x220
[    1.761290]  ? kmalloc_trace+0x2a/0xa0
[    1.762079]  do_init_module+0x52/0x230
[    1.762876]  load_module+0x2190/0x27c0
[    1.763662]  ? security_kernel_post_read_file+0x5c/0x70
[    1.764453]  __do_sys_finit_module+0xc8/0x140
[    1.765246]  ? __do_sys_finit_module+0xc8/0x140
[    1.766039]  __x64_sys_finit_module+0x1a/0x20
[    1.766829]  do_syscall_64+0x59/0x90
[    1.767599]  ? exit_to_user_mode_prepare+0x3d/0x190
[    1.768369]  ? syscall_exit_to_user_mode+0x26/0x50
[    1.769146]  ? __x64_sys_mmap+0x33/0x50
[    1.769912]  ? do_syscall_64+0x69/0x90
[    1.770685]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    1.771462] RIP: 0033:0x7f2017ca0c4d
[    1.772244] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 f1 0d 00 f7 d8 64 89 01 48
[    1.773071] RSP: 002b:00007fffd75e47b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    1.773904] RAX: ffffffffffffffda RBX: 0000555f7823dac0 RCX: 00007f2017ca0c4d
[    1.774744] RDX: 0000000000000000 RSI: 00007f2017e22458 RDI: 0000000000000005
[    1.775592] RBP: 00007f2017e22458 R08: 0000000000000000 R09: 0000000000000000
[    1.776430] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000020000
[    1.777269] R13: 0000555f78233ab0 R14: 0000000000000000 R15: 0000555f78236f40
[    1.778115]  </TASK>
[    1.778955] Modules linked in: intel_ishtp(+) idma64 xhci_pci_renesas vmd(+) hid cxl_acpi wmi cxl_core fjes(-) pinctrl_tigerlake
[    1.779839] CR2: 0000000000000050
[    1.780704] ---[ end trace 0000000000000000 ]---
[    1.781573] RIP: 0010:irq_domain_create_hierarchy+0x2d/0x70
[    1.782437] Code: 00 00 55 48 89 e5 41 55 49 89 fd 48 89 cf 41 54 53 89 f3 85 d2 74 3f 89 d6 31 c9 89 d2 e8 6b fd ff ff 49 89 c4 4d 85 e4 74 1e <49> 8b 45 50 41 09 5c 24 28 4c 89 e7 4d 89 ac 24 80 00 00 00 49 89
[    1.783349] RSP: 0018:ffffb811c08e38f8 EFLAGS: 00010282
[    1.784250] RAX: ffff975001456540 RBX: 0000000000000010 RCX: 0000000000000000
[    1.785158] RDX: ffffffffadf8be90 RSI: ffffffffac7290a0 RDI: ffff975001456570
[    1.786065] RBP: ffffb811c08e3910 R08: ffff975001452900 R09: ffff975001452900
[    1.786972] R10: ffff975001452900 R11: ffff97510145206f R12: ffff975001456540
[    1.787860] R13: 0000000000000000 R14: 0000000000000013 R15: ffff975011860628
[    1.788748] FS:  00007f20175c08c0(0000) GS:ffff97537f8c0000(0000) knlGS:0000000000000000
[    1.789646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.790539] CR2: 0000000000000050 CR3: 0000000111e1c004 CR4: 0000000000770ee0
[    1.791439] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.792342] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[    1.793239] PKRU: 55555554
[    1.794123] note: systemd-udevd[154] exited with irqs disabled
[    1.845219] ACPI: bus type thunderbolt registered
[    1.846114] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.846128] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.847456] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.849893] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
[    1.851081] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    1.853686] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.854119] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.855088] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    1.856121] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.857265] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.857325] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.02
[    1.858276] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)

> 
>> I am using a NVMe for my rootfs. By checking the screen log, I see
>> that 1 kernel message is missing:
>>
>> [    4.193375] EXT4-fs (nvme0n1p3): mounted filesystem a9e1243b-332f-46ce-a5e7-cea86b44f797 with ordered data mode. Quota mode: none.
> 
> OK, at least we know that NVMe is in the loop, but we don't know *why*
> yet. Please try and get the dmesg for us. I'm sure someone at Intel
> can help you with this.
> 
> Thanks,
> 
> 	M.
> 

-- 
Best regards,
Bingbu Cao
