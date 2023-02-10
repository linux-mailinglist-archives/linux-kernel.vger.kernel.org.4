Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F17691798
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjBJEc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBJEcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D948A442EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676003523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U6pK+Wug/jEM+Tufvy4NBA9U75mUiyxs/GimEnB6hLE=;
        b=Wrj70fY6162UUtZwdlrFmGuJrOSTN/+qKWW16w9ESz1+X5/5YFUIk1v3EkfSSAlDsOfzvt
        epsM4kdJBAOzw66jp5jzK0dsN6sQE/gk6Yt8dzLB7b2jUaQN832YkFwefQsDurr0yEPQxK
        Y6aiVckqFpJUMAndMlY+Bc68oPC2EJU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-51VoCoEQNey7qVhkCCbIQQ-1; Thu, 09 Feb 2023 23:31:58 -0500
X-MC-Unique: 51VoCoEQNey7qVhkCCbIQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3436329A9D43;
        Fri, 10 Feb 2023 04:31:58 +0000 (UTC)
Received: from [10.22.34.151] (unknown [10.22.34.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3CAEC16022;
        Fri, 10 Feb 2023 04:31:57 +0000 (UTC)
Message-ID: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
Subject: rtmutex, pi_blocked_on, and blk_flush_plug()
From:   Crystal Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Keeping <john@metanate.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Feb 2023 22:31:57 -0600
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

It is possible for blk_flush_plug() to be called while
current->pi_blocked_on is set, in the process of trying to acquire an rwsem=
.
If the block flush blocks trying to acquire some lock, then it appears that
current->pi_blocked_on will be overwritten, and then set to NULL once that
lock is acquired, even though the task is still blocked on the original
rwsem.  Am I missing something that deals with this situation?  It seems
like the lock types that are supposed to call blk_flush_plug() should do so
before calling task_blocks_on_rt_mutex().

I originally noticed this while investigating a related issue on an older
RHEL kernel where task_blocked_on_mutex() has a BUG_ON if entered with
current->pi_blocked_on non-NULL.  Current kernels lack this check.

To demonstrate that the recursive blocking scenario can happen (without
actually waiting to hit the scenario where the second lock is contended),
I put a WARN_ON_ONCE(current->pi_blocked_on) in rtlock_lock() (plus a few
other places, but this is the one I hit):

[83246.479396] ------------[ cut here ]------------
[83246.479400] WARNING: CPU: 94 PID: 75492 at kernel/locking/spinlock_rt.c:=
40 rt_spin_lock+0x46/0x70
[83246.494329] Modules linked in: xt_CHECKSUM(E) xt_MASQUERADE(E) xt_conntr=
ack(E) ipt_REJECT(E) nf_reject_ipv4(E) nft_compat(E) nft_chain_nat(E) nf_na=
t(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E) nfnet=
link(E) bridge(E) stp(E) llc(E) rfkill(E) sunrpc(E) vfat(E) fat(E) intel_ra=
pl_msr(E) intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) kvm_amd(E) kvm=
(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E)=
 rapl(E) ipmi_si(E) ipmi_devintf(E) wmi_bmof(E) ipmi_msghandler(E) pcspkr(E=
) mlx5_ib(E) ib_uverbs(E) joydev(E) sp5100_tco(E) ib_core(E) ccp(E) ptdma(E=
) i2c_piix4(E) k10temp(E) i2c_designware_platform(E) i2c_designware_core(E)=
 acpi_cpufreq(E) xfs(E) libcrc32c(E) crc32c_intel(E) sd_mod(E) t10_pi(E) as=
t(E) crc64_rocksoft(E) crc64(E) drm_kms_helper(E) sg(E) syscopyarea(E) sysf=
illrect(E) mlx5_core(E) sysimgblt(E) i2c_algo_bit(E) ahci(E) drm_shmem_help=
er(E) libahci(E) mlxfw(E) drm(E) libata(E) tls(E) psample(E) wmi(E) dm_mirr=
or(E) dm_region_hash(E)
[83246.494667]  dm_log(E) dm_mod(E) fuse(E)
[83246.593228] CPU: 94 PID: 75492 Comm: kworker/u514:1 Tainted: G          =
  E      6.2.0-rc3-rt1.std+ #4
[83246.603919] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RYM=
1009B 05/14/2022
[83246.614174] Workqueue: writeback wb_workfn (flush-253:2)
[83246.620021] RIP: 0010:rt_spin_lock+0x46/0x70
[83246.626265] Code: 48 89 fb 8b 90 34 08 00 00 75 1f 65 48 8b 14 25 c0 14 =
03 00 31 c0 f0 48 0f b1 53 18 75 10 e8 d1 45 5c ff 5b 5d e9 fa c2 56 ff <0f=
> 0b eb dd 48 89 df e8 ee 42 00 00 48 89 df 48 89 c5 e8 63 ff ff
[83246.646613] RSP: 0018:ffffafd3f0cb7438 EFLAGS: 00010286
[83246.651943] RAX: ffff8ee41531cc80 RBX: ffff8ec428839f48 RCX: 00000000000=
00001
[83246.659327] RDX: 0000000000000000 RSI: ffffafd3f0cb7510 RDI: ffff8ec4288=
39f48
[83246.669216] RBP: 0000000000000001 R08: ffff8ec4494d3ec8 R09: 00000000000=
31480
[83246.676709] R10: ffff8ec41ab79000 R11: 0000000000000000 R12: ffffafd3f0c=
b7510
[83246.684536] R13: ffffafd3f0cb7510 R14: ffffcfd37e596bc0 R15: 00000000000=
00001
[83246.692026] FS:  0000000000000000(0000) GS:ffff8f02c7980000(0000) knlGS:=
0000000000000000
[83246.702144] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[83246.709800] CR2: 0000565164f09000 CR3: 00000003a2f58003 CR4: 00000000007=
70ee0
[83246.718014] PKRU: 55555554
[83246.722313] Call Trace:
[83246.726219]  <TASK>
[83246.729719]  dd_insert_requests+0x55/0x360
[83246.735712]  blk_mq_sched_insert_requests+0x64/0x170
[83246.741579]  blk_mq_flush_plug_list+0x135/0x330
[83246.747219]  __blk_flush_plug+0xf6/0x130
[83246.752481]  schedule+0x46/0xd0
[83246.756625]  __rt_mutex_slowlock.isra.18.constprop.21+0x3c2/0x9d0
[83246.763522]  __rwbase_read_lock+0xae/0x210
[83246.768737]  xlog_cil_commit+0x1e0/0xc80 [xfs]
[83246.771346]  ? __pfx_xfs_trans_precommit_sort+0x10/0x10 [xfs]
[83246.771697]  __xfs_trans_commit+0x135/0x400 [xfs]
[83246.772313]  xfs_bmapi_convert_delalloc+0x39f/0x500 [xfs]
[83246.773696]  xfs_map_blocks+0x1ad/0x480 [xfs]
[83246.774339]  iomap_writepage_map+0x105/0x710
[83246.774345]  write_cache_pages+0x1bf/0x4f0
[83246.774640]  ? __pfx_iomap_do_writepage+0x10/0x10
[83246.774644]  ? submit_bio_noacct_nocheck+0xe9/0x2b0
[83246.775236]  iomap_writepages+0x20/0x40
[83246.775238]  xfs_vm_writepages+0x7e/0xb0 [xfs]
[83246.775628]  do_writepages+0xd9/0x1c0
[83246.775633]  __writeback_single_inode+0x4a/0x490
[83246.775636]  writeback_sb_inodes+0x1f4/0x4c0
[83246.775640]  __writeback_inodes_wb+0x5d/0xd0
[83246.775643]  wb_writeback+0x244/0x370
[83246.775646]  wb_workfn+0x3c0/0x530
[83246.776510]  ? __raw_spin_unlock+0x10/0x50
[83246.776514]  ? finish_task_switch+0xbd/0x320
[83246.776517]  process_one_work+0x1a5/0x400
[83246.776521]  ? __pfx_worker_thread+0x10/0x10
[83246.776523]  worker_thread+0x34/0x360
[83246.776526]  ? __pfx_worker_thread+0x10/0x10
[83246.776527]  kthread+0x10f/0x130
[83246.776530]  ? __pfx_kthread+0x10/0x10
[83246.776532]  ret_from_fork+0x2c/0x50
[83246.776537]  </TASK>
[83246.776538] ---[ end trace 0000000000000000 ]---

-Crystal

