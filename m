Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30D7246C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbjFFOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjFFOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:49:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C91E10C3;
        Tue,  6 Jun 2023 07:48:27 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id E1A7D20BE465; Tue,  6 Jun 2023 07:47:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1A7D20BE465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686062872;
        bh=qLHYhKuYBtuXRBJvoSPy62jmKZ/caVCPu3WR3egdbeo=;
        h=Date:From:To:Cc:Subject:From;
        b=pd1OoyGSpJhSYfZjTwSkeYoGKh1BrP7UaODyLArUdmvTYCb+WvxLCUxOMvio+P2hC
         /8jdD+KeT9aF85+OO4YYvSZIW3kh4TQuLSTjHXsk+nyQDSNph2Dh7ccKnYX/cL13rt
         JZua3R4taITDoPEgZIcAwfIcAXkHvkIvCGCdEoOo=
Date:   Tue, 6 Jun 2023 07:47:52 -0700
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     dpark@linux.microsoft.com, t-lo@linux.microsoft.com,
        stable@vger.kernel.org
Subject: soft lockup on Ampere Altra on v6.1.30
Message-ID: <20230606144752.GA31904@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're currently trying to update the kernel in our distro (Flatcar) from
v5.15.x to v6.1.x. When testing on Equinix Metal Ampere instances
(c3.large.arm64) we now get a soft lockup about a minute after boot.

Has anyone else seen this? The splat looks like this, full dmesg is at [1]
(trying without the attachement this time as LKML detects my mail as spam :/)

[   84.297829] watchdog: BUG: soft lockup - CPU#45 stuck for 26s! [kworker/45:1:474]
[   84.297834] Modules linked in: veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables nfnetlink bonding mlx5_ib ipmi_ssif ipmi_devintf ib_core ipmi_msghandler evdev sch_fq_codel fuse configfs dmi_sysfs nls_ascii nls_cp437 vfat fat ext4 crc16 mbcache jbd2 dm_verity dm_bufio nvme nvme_core xhci_pci t10_pi xhci_hcd crc64_rocksoft_generic crc64_rocksoft igb crc_t10dif i2c_algo_bit crct10dif_generic mlx5_core usbcore i2c_core crc64 crct10dif_common usb_common hwmon pci_hyperv_intf btrfs blake2b_generic xor xor_neon lzo_compress zlib_deflate raid6_pq zstd_compress libcrc32c crc32c_generic dm_mirror dm_region_hash dm_log qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi dm_multipath dm_mod scsi_mod scsi_common br_netfilter bridge stp llc overlay
[   84.435381] CPU: 45 PID: 474 Comm: kworker/45:1 Not tainted 6.1.30-flatcar #1
[   84.447678] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F17a (SCP: 1.07.20210713) 07/22/2021
[   84.467226] Workqueue: rcu_par_gp sync_rcu_exp_select_node_cpus
[   84.478239] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   84.490336] pc : smp_call_function_single+0xe4/0x1d0
[   84.500287] lr : __sync_rcu_exp_select_node_cpus+0x278/0x480
[   84.510869] sp : ffff80000b99bcc0
[   84.518979] x29: ffff80000b99bcc0 x28: 0000000000000200 x27: ffffab5be3134080
[   84.530897] x26: ffffab5be302d6a8 x25: ffff07ff89f01f40 x24: ffff083e5fba8540
[   84.542751] x23: ffffab5be2e43ab0 x22: 0000000000000a00 x21: ffffab5be2e47540
[   84.554510] x20: 000000000000f5ff x19: ffff80000b99bce0 x18: ffff80002be3bc58
[   84.566213] x17: 0000000000000000 x16: ffffab5be06cdfc0 x15: 0000000000000001
[   84.577841] x14: 0000000000000000 x13: 0000000000000010 x12: ffffab5be2e43ab0
[   84.589361] x11: 0000000000000001 x10: 0000000000000040 x9 : ffffab5be312c270
[   84.600832] x8 : ffffab5be2e34008 x7 : 0000000000028fb0 x6 : ffffab5bdfd0ef20
[   84.612285] x5 : 0000000000000000 x4 : ffff083e5fc1c748 x3 : 0000000000000001
[   84.623812] x2 : 0000000000000000 x1 : ffff083e5fc1c740 x0 : 0000000000000029
[   84.635277] Call trace:
[   84.641994]  smp_call_function_single+0xe4/0x1d0
[   84.650957]  __sync_rcu_exp_select_node_cpus+0x278/0x480
[   84.660664]  sync_rcu_exp_select_node_cpus+0x14/0x20
[   84.669988]  process_one_work+0x214/0x490
[   84.678313]  worker_thread+0x6c/0x430
[   84.686206]  kthread+0x108/0x10c
[   84.693668]  ret_from_fork+0x10/0x20
[   84.701417] Kernel panic - not syncing: softlockup: hung tasks
[   84.711437] CPU: 45 PID: 474 Comm: kworker/45:1 Tainted: G             L     6.1.30-flatcar #1
[   84.724261] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F17a (SCP: 1.07.20210713) 07/22/2021
[   84.741870] Workqueue: rcu_par_gp sync_rcu_exp_select_node_cpus
[   84.751900] Call trace:
[   84.758325]  dump_backtrace+0xe0/0x140
[   84.765958]  show_stack+0x18/0x30
[   84.773057]  dump_stack_lvl+0x64/0x80
[   84.780384]  dump_stack+0x18/0x34
[   84.787220]  panic+0x180/0x358
[   84.793698]  watchdog_nmi_enable+0x0/0x10
[   84.801040]  __hrtimer_run_queues+0x17c/0x340
[   84.808624]  hrtimer_interrupt+0xe8/0x244
[   84.815807]  arch_timer_handler_phys+0x2c/0x44
[   84.823388]  handle_percpu_devid_irq+0x88/0x230
[   84.830995]  generic_handle_domain_irq+0x2c/0x44
[   84.838682]  gic_handle_irq+0x50/0x140
[   84.845468]  call_on_irq_stack+0x24/0x4c
[   84.852402]  do_interrupt_handler+0x80/0x84
[   84.859569]  el1_interrupt+0x34/0x6c
[   84.866100]  el1h_64_irq_handler+0x18/0x2c
[   84.873134]  el1h_64_irq+0x64/0x68
[   84.879415]  smp_call_function_single+0xe4/0x1d0
[   84.886933]  __sync_rcu_exp_select_node_cpus+0x278/0x480
[   84.895205]  sync_rcu_exp_select_node_cpus+0x14/0x20
[   84.903118]  process_one_work+0x214/0x490
[   84.910040]  worker_thread+0x6c/0x430
[   84.916645]  kthread+0x108/0x10c
[   84.922733]  ret_from_fork+0x10/0x20

Thanks,
Jeremi

[1]: https://gist.githubusercontent.com/dongsupark/3ab5fc464a995623a14542edd9b193ac/raw/db7c0216dcb260603a4ec0052015f86d82d4de30/kernel-6.1-softlockup-EM-arm64.txt
