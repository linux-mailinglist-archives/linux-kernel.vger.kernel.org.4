Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74525BC5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiISJ4c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Sep 2022 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiISJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:56:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CD3A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:56:27 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oaDVp-00054Z-TZ; Mon, 19 Sep 2022 11:56:25 +0200
Message-ID: <c38235e9-b620-510c-4b53-6b190b83f997@leemhuis.info>
Date:   Mon, 19 Sep 2022 11:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Patrick S <kernel@mail.get-it.us>,
        Igor Raits <igor.raits@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [REGRESSION] Bug 216493 - Panic on __kernfs_remove (probably after
 5.19.8)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663581387;3afb8ef9;
X-HE-SMSGID: 1oaDVp-00054Z-TZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216493 :

>  Igor Raits 2022-09-15 15:53:22 UTC
> 
> [16071.749181] docker0: port 3(veth2730772) entered disabled state
> [16071.750124] vethf9339cf: renamed from eth0
> [16071.774285] docker0: port 3(veth2730772) entered disabled state
> [16071.775441] device veth2730772 left promiscuous mode
> [16071.776285] docker0: port 3(veth2730772) entered disabled state
> [16071.856224] XFS (dm-2): Unmounting Filesystem
> [16072.131068] ------------[ cut here ]------------
> [16072.131511] WARNING: CPU: 1 PID: 47162 at fs/kernfs/dir.c:504 __kernfs_remove.part.22+0x1c6/0x200
> [16072.132102] Modules linked in: mptcp_diag(E) xsk_diag(E) raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) veth(E) udp_diag(E) tcp_diag(E) inet_diag(E) nfs_layout_nfsv41_files(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) fscache(E) netfs(E) binfmt_misc(E) br_netfilter(E) bridge(E) stp(E) llc(E) nf_conntrack_netlink(E) xfs(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) loop(E) overlay(E) dummy(E) fuse(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E) nf_tables(E) libcrc32c(E) nfnetlink(E) isofs(E) intel_rapl_msr(E) intel_rapl_common(E) nfit(E) libnvdimm(E) kvm_intel(E) kvm(E) irqbypass(E) rapl(E) cirrus(E) drm_shmem_helper(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) i2c_i801(E) i2c_smbus(E) drm(E) virtio_balloon(E) ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E)
> [16072.132154]  crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ahci(E) libahci(E) ghash_clmulni_intel(E) libata(E) serio_raw(E) virtio_net(E) net_failover(E) virtio_blk(E) failover(E) sunrpc(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [16072.137239] Unloaded tainted modules: skx_edac(E):6 intel_cstate(E):6 intel_uncore(E):6 acpi_cpufreq(E):6
> [16072.139248] CPU: 1 PID: 47162 Comm: dockerd Tainted: G            E     5.19.8-1.gdc.el8.x86_64 #1
> [16072.139820] Hardware name: RDO OpenStack Compute/RHEL-AV, BIOS 1.16.0-1.module_el8.7.0+1140+ff0772f9 04/01/2014
> [16072.140468] RIP: 0010:__kernfs_remove.part.22+0x1c6/0x200
> [16072.140897] Code: 01 00 00 80 75 e1 48 89 e6 4c 89 ef e8 c3 f8 d0 ff 48 89 df e8 eb 22 00 00 4c 89 f7 e8 43 29 68 00 48 8b 43 08 e9 02 ff ff ff <0f> 0b e9 d2 fe ff ff 0f 0b e9 f4 fe ff ff 48 8b 57 10 48 c7 c6 32
> [16072.142177] RSP: 0018:ffffbfd6c1cfbaf8 EFLAGS: 00010246
> [16072.142588] RAX: 0000000000000000 RBX: ffff9daeda3b1980 RCX: 0000000080200002
> [16072.143117] RDX: 0000000080200003 RSI: 0000000080200002 RDI: ffff9daeda3b19c8
> [16072.143656] RBP: ffffbfd6c1cfbb48 R08: 0000000000000001 R09: ffffffffa4633600
> [16072.144167] R10: 0000000000000001 R11: ffff9db488f48ff8 R12: ffff9daeda3b1980
> [16072.144711] R13: ffff9dad001c2e40 R14: ffff9dad001c2ea0 R15: ffff9dae47d8fc00
> [16072.145245] FS:  00007f1d2b7fe700(0000) GS:ffff9dbb43c40000(0000) knlGS:0000000000000000
> [16072.145799] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16072.146301] CR2: 00007f8c21f4dfa8 CR3: 000000017f166003 CR4: 0000000000770ee0
> [16072.146815] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [16072.147396] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [16072.147891] PKRU: 55555554
> [16072.148253] Call Trace:
> [16072.148610]  <TASK>
> [16072.148884]  ? cpumask_next+0x1f/0x30
> [16072.149288]  ? kernfs_name_hash+0x12/0x90
> [16072.149654]  kernfs_remove_by_name_ns+0x60/0xa0
> [16072.150040]  sysfs_slab_add+0x141/0x1e0
> [16072.150426]  __kmem_cache_create+0x3a4/0x480
> [16072.150804]  kmem_cache_create_usercopy+0x16d/0x2c0
> [16072.151234]  kmem_cache_create+0x12/0x20
> [16072.151591]  bioset_init+0x214/0x2b0
> [16072.151944]  dm_alloc_md_mempools+0x136/0x180 [dm_mod]
> [16072.152419]  dm_table_complete+0x3b8/0x6e0 [dm_mod]
> [16072.152836]  table_load+0x15f/0x2e0 [dm_mod]
> [16072.153257]  ? retrieve_status+0x1e0/0x1e0 [dm_mod]
> [16072.153657]  ctl_ioctl+0x1b7/0x420 [dm_mod]
> [16072.154036]  dm_ctl_ioctl+0xa/0x20 [dm_mod]
> [16072.154433]  __x64_sys_ioctl+0x89/0xc0
> [16072.154778]  do_syscall_64+0x790]  ? pick_next_task+0x76d/0x910
> [16072.171119]  ? rcu_note_context_switch+0xfc/0x580
> [16072.171466]  ? finish_task_switch+0x86/0x2c0
> [16072.171805]  ? radix_tree_delete_item+0xb0/0xc0
> [16072.172158]  kernfs_put+0xe6/0x1a0
> [16072.172482]  __kernfs_remove.part.22+0x114/0x200
> [16072.172837]  ? cpumask_next+0x1f/0x30
> [16072.173151]  ? kernfs_name_hash+0x12/0x90
> [16072.173470]  kernfs_remove_by_name_ns+0x60/0xa0
> [16072.173817]  sysfs_slab_add+0x141/0x1e0
> [16072.174172]  __kmem_cache_create+0x3a4/0x480
> [16072.174506]  kmem_cache_create_usercopy+0x16d/0x2c0
> [16072.174871]  kmem_cache_create+0x12/0x20
> [16072.175198]  bioset_init+0x214/0x2b0
> [16072.175503]  dm_alloc_md_mempools+0x136/0x180 [dm_mod]
> [16072.175876]  dm_table_complete+0x3b8/0x6e0 [dm_mod]
> [16072.176238]  table_load+0x15f/0x2e0 [dm_mod]
> [16072.176561]  ? retrieve_status+0x1e0/0x1e0 [dm_mod]
> [16072.176915]  ctl_ioctl+0x1b7/0x420 [dm_mod]
> [16072.177241]  dm_ctl_ioctl+0xa/0x20 [dm_mod]
> [16072.177556]  __x64_sys_ioctl+0x89/0xc0
> [16072.177856]  do_syscall_64+0x37/0x90
> [16072.178155]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [16072.178500] RIP: 0033:0x7f1d5b8397cb
> [16072.178789] Code: 73 01 c3 48 8b 0d bd 66 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8d 66 38 00 f7 d8 64 89 01 48
> [16072.179870] RSP: 002b:00007f1d2b7fd808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [16072.180347] RAX: ffffffffffffffda RBX: 0000563b6406e150 RCX: 00007f1d5b8397cb
> [16072.180792] RDX: 00007f1d2002df00 RSI: 00000000c138fd09 RDI: 000000000000000c
> [16072.181246] RBP: 00007f1d5bc4a143 R08: 00007f1d20013de0 R09: 0000000000000007
> [16072.181689] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f1d2002df00
> [16072.182136] R13: 00007f1d2002dfb0 R14: 00007f1d20004ed0 R15: 0000000000000000
> [16072.182562]  </TASK>
> [16072.182796] Modules linked in: mptcp_diag(E) xsk_diag(E) raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) veth(E) udp_diag(E) tcp_diag(E) inet_diag(E) nfs_layout_nfsv41_files(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) fscache(E) netfs(E) binfmt_misc(E) br_netfilter(E) bridge(E) stp(E) llc(E) nf_conntrack_netlink(E) xfs(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) loop(E) overlay(E) dummy(E) fuse(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E) nf_tables(E) libcrc32c(E) nfnetlink(E) isofs(E) intel_rapl_msr(E) intel_rapl_common(E) nfit(E) libnvdimm(E) kvm_intel(E) kvm(E) irqbypass(E) rapl(E) cirrus(E) drm_shmem_helper(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) i2c_i801(E) i2c_smbus(E) drm(E) virtio_balloon(E) ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E)
> [16072.182837]  crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ahci(E) libahci(E) ghash_clmulni_intel(E) libata(E) serio_raw(E) virtio_net(E) net_failover(E) virtio_blk(E) failover(E) sunrpc(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [16072.187578] Unloaded tainted modules: skx_edac(E):6 intel_cstate(E):6 intel_uncore(E):6 acpi_cpufreq(E):6
> [16072.189381] ---[ end trace 0000000000000000 ]---
> [16072.189737] RIP: 0010:__slab_free+0x271/0x3c0
> [16072.190114] Code: ff 80 7c 24 4b 00 0f 89 33 ff ff ff 48 83 c4 60 48 89 ee 4c 89 ef ba 01 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1f 0f 00 00 <0f> 0b 65 ff 0d b6 49 ad 5b 74 47 f3 90 48 8b 45 00 a8 01 75 f6 e9
> [16072.191234] RSP: 0018:ffffbfd6c1cfba20 EFLAGS: 00010246
> [16072.191634] RAX: ffff9daeda3b19c0 RBX: ffff9daeda3b1980 RCX: ffff9daeda3b1980
> [16072.192123] RDX: 0000000080200002 RSI: fffff687cb68ec40 RDI: ffff9dad001c5800
> [16072.192593] RBP: fffff687cb68ec40 R08: 0000000000000001 R09: ffffffffa46336b6
> [16072.193104] R10: 0000000000000001 R11: ffff9dad001c2e58 R12: ffff9daeda3b1980
> [16072.193578] R13: ffff9dad001c5800 R14: ffff9dad001c2ea0 R15: ffff9daeda3b1980
> [16072.194072] FS:  00007f1d2b7fe700(0000) GS:ffff9dbb43c00000(0000) knlGS:0000000000000000
> [16072.194586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [16072.195013] CR2: 00007f9a959a3000 CR3: 000000017f166005 CR4: 0000000000770ef0
> [16072.195501] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [16072.195987] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [16072.196488] PKRU: 55555554
> [16072.196794] Kernel panic - not syncing: Fatal exception
> [16072.197312] Kernel Offset: 0x23200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> ---
> 
> I could not find any existing patch / discussion but https://lore.kernel.org/lkml/20220913121723.691454-1-lk@c--e.de/T/#mc068df068cfd19c43b16542e74d4b72dfc1b0569 looks similar from my POV.
> 
> Why I think it did not happen before is that we have many VMs running on 5.19.6 and there was no issue like this. Today after upgrade to .8, one of the VMs crashed this way very quickly (not even 1 day uptime).
> 
> Sadly I did not take dump of a VM, but hopefully information above is somewhat enough.
> 
> Thanks
See the ticket for more details. Someone else later confirmed that this
is new in 5.19.8. A bisection was already asked for.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.19.7..v5.19.8
https://bugzilla.kernel.org/show_bug.cgi?id=216493
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
