Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0288C70BF91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjEVNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjEVNWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:22:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9FB3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:22:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33CD221C93;
        Mon, 22 May 2023 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684761763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCuK3LPZF5iDHF6eAIMdoiAoNyzIubdp5oaBuFWw3Hg=;
        b=y0buT+Ce4L02Be6wKZkwOpa/RfvnLye+GPy36fZD27pzS8fsZZ5IGVspUcj6i6MdSiCxxl
        dj4mgbcgVpODvdt0Gk7FGiYsCVPLo5hUJjn5N27BA1K4h8pLXclDMitoDbELT73dq2/kx5
        hH7NyqDRjjJL4FVdvYoCK7ESXyo5WGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684761763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCuK3LPZF5iDHF6eAIMdoiAoNyzIubdp5oaBuFWw3Hg=;
        b=RB/kNeMWqcXftJlo79BIV81Malm0prE/Ab5eZ3ZZfKljo9R5gxvRHx6dgWgwgU/1RVF7y9
        20It/fzu0BDdaUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C37D513336;
        Mon, 22 May 2023 13:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KUlwLKJsa2QkeAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 22 May 2023 13:22:42 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 074c87ad;
        Mon, 22 May 2023 13:22:41 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Heming Zhao <heming.zhao@suse.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] ocfs2: fix use-after-free when unmounting read-only
 filesystem
References: <20230522102506.9205-1-lhenriques@suse.de>
        <a57047d6-8f57-3dde-f15f-b24f63d675cd@linux.alibaba.com>
        <87h6s47dxw.fsf@brahms.olymp> <20230522123623.eozzedrogy4oaj3w@p15>
Date:   Mon, 22 May 2023 14:22:41 +0100
In-Reply-To: <20230522123623.eozzedrogy4oaj3w@p15> (Heming Zhao's message of
        "Mon, 22 May 2023 20:36:23 +0800")
Message-ID: <87cz2s7b6m.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heming Zhao <heming.zhao@suse.com> writes:

> On Mon, May 22, 2023 at 01:23:07PM +0100, Lu=C3=ADs Henriques wrote:
>> Joseph Qi <joseph.qi@linux.alibaba.com> writes:
>>=20
>> > On 5/22/23 6:25 PM, Lu=C3=ADs Henriques wrote:
>> >> It's trivial to trigger a use-after-free bug in the ocfs2 quotas code=
 using
>> >> fstest generic/452.  After mounting a filesystem as read-only, quotas=
 are
>> >
>> > generic/452 is for testing ext4 mounted with dax and ro.
>> > But ocfs2 doesn't support dax yet.
>>=20
>> Right, but I think it's still useful to run the 'generic' test-suite in a
>> filesystem.  We can always find issues in the test itself or, in this
>> case, a bug in the filesystem.
>
> It looks you did some special steps for 452. In my env, without changing
> anything, I could pass this case successfully.=20

No, I haven't changed anything to the test.  I just make sure there's a
scratch device to be used.

Maybe you can try to enable KASAN to catch the UAF.  I've found the bug
without KASAN (i.e. I saw a NULL pointer panic), but enabling it also
detects the issue -- see below.

Cheers,
--=20
Lu=C3=ADs

[   91.928109] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   91.929519] BUG: KASAN: slab-use-after-free in timer_delete+0x54/0xc0
[   91.930869] Read of size 8 at addr ffff8880389a8208 by task umount/669
[   91.932533] CPU: 1 PID: 669 Comm: umount Not tainted 6.4.0-rc3 #236
[   91.933807] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   91.936158] Call Trace:
[   91.936678]  <TASK>
[   91.937123]  dump_stack_lvl+0x32/0x50
[   91.937909]  print_report+0xc5/0x5f0
[   91.938685]  ? _raw_spin_lock_irqsave+0x72/0xc0
[   91.939642]  ? __virt_addr_valid+0xac/0x130
[   91.940534]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   91.941574]  ? timer_delete+0x54/0xc0
[   91.942357]  kasan_report+0x9e/0xd0
[   91.943110]  ? timer_delete+0x54/0xc0
[   91.943902]  timer_delete+0x54/0xc0
[   91.944643]  ? __pfx_timer_delete+0x10/0x10
[   91.945492]  ? detach_if_pending+0x112/0x140
[   91.946405]  try_to_grab_pending+0x31/0x230
[   91.947252]  __cancel_work_timer+0x6c/0x270
[   91.948102]  ? __pfx___cancel_work_timer+0x10/0x10
[   91.949073]  ? try_to_grab_pending+0x31/0x230
[   91.949956]  ? __cancel_work+0xe3/0x130
[   91.950746]  ? mutex_unlock+0x6b/0xb0
[   91.951485]  ocfs2_disable_quotas.isra.0+0x3e/0xf0 [ocfs2]
[   91.952635]  ocfs2_dismount_volume+0xdd/0x450 [ocfs2]
[   91.953676]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[   91.954757]  ? __pfx_ocfs2_dismount_volume+0x10/0x10 [ocfs2]
[   91.955898]  ? filemap_check_errors+0x46/0xb0
[   91.956737]  generic_shutdown_super+0xaa/0x280
[   91.957604]  kill_block_super+0x46/0x70
[   91.958415]  deactivate_locked_super+0x4d/0xb0
[   91.959861]  cleanup_mnt+0x135/0x1f0
[   91.960862]  task_work_run+0xe3/0x140
[   91.961887]  ? __pfx_task_work_run+0x10/0x10
[   91.962887]  ? __x64_sys_umount+0xbb/0xd0
[   91.963343]  exit_to_user_mode_prepare+0xda/0xe0
[   91.963867]  syscall_exit_to_user_mode+0x1d/0x50
[   91.964392]  do_syscall_64+0x4f/0x90
[   91.964800]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   91.965387] RIP: 0033:0x7fa7664baacb
[   91.965796] Code: fa 90 90 31 f6 e9 13 00 00 00 0f 1f 44 00 00 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 90 90 b8 a6 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 058
[   91.967851] RSP: 002b:00007ffc8d30da28 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6
[   91.968671] RAX: 0000000000000000 RBX: 00005628ef17a9c0 RCX: 00007fa7664=
baacb
[   91.969464] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005628ef1=
7cdd0
[   91.970253] RBP: 00005628ef17aad8 R08: 0000000000000073 R09: 00000000000=
00001
[   91.971031] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[   91.971790] R13: 00005628ef17cdd0 R14: 00005628ef17abf0 R15: 00007ffc8d3=
10088
[   91.972546]  </TASK>

[   91.972961] Allocated by task 632:
[   91.973342]  kasan_save_stack+0x1c/0x40
[   91.973760]  kasan_set_track+0x21/0x30
[   91.974160]  __kasan_kmalloc+0x8b/0x90
[   91.974584]  ocfs2_local_read_info+0xe3/0x9a0 [ocfs2]
[   91.975168]  dquot_load_quota_sb+0x34b/0x680
[   91.975624]  dquot_load_quota_inode+0xfe/0x1a0
[   91.976092]  ocfs2_enable_quotas+0x190/0x2f0 [ocfs2]
[   91.976679]  ocfs2_fill_super+0x14ef/0x2120 [ocfs2]
[   91.977249]  mount_bdev+0x1be/0x200
[   91.977622]  legacy_get_tree+0x6c/0xb0
[   91.978014]  vfs_get_tree+0x3e/0x110
[   91.978415]  path_mount+0xa90/0xe10
[   91.978774]  __x64_sys_mount+0x16f/0x1a0
[   91.979171]  do_syscall_64+0x43/0x90
[   91.979537]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[   91.980213] Freed by task 650:
[   91.980535]  kasan_save_stack+0x1c/0x40
[   91.980925]  kasan_set_track+0x21/0x30
[   91.981317]  kasan_save_free_info+0x2a/0x50
[   91.981744]  __kasan_slab_free+0xf9/0x150
[   91.982151]  __kmem_cache_free+0x89/0x180
[   91.982568]  ocfs2_local_free_info+0x2ba/0x3f0 [ocfs2]
[   91.983140]  dquot_disable+0x35f/0xa70
[   91.983509]  ocfs2_susp_quotas.isra.0+0x159/0x1a0 [ocfs2]
[   91.984096]  ocfs2_remount+0x150/0x580 [ocfs2]
[   91.984584]  reconfigure_super+0x1a5/0x3a0
[   91.984993]  path_mount+0xc8a/0xe10
[   91.985357]  __x64_sys_mount+0x16f/0x1a0
[   91.985750]  do_syscall_64+0x43/0x90
[   91.986125]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

[   91.986799] The buggy address belongs to the object at ffff8880389a8000
                which belongs to the cache kmalloc-1k of size 1024
[   91.987965] The buggy address is located 520 bytes inside of
                freed 1024-byte region [ffff8880389a8000, ffff8880389a8400)

[   91.989287] The buggy address belongs to the physical page:
[   91.989812] page:00000000bc93f4e4 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x389a8
[   91.990719] head:00000000bc93f4e4 order:3 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[   91.991483] flags: 0x4000000000010200(slab|head|zone=3D1)
[   91.991981] page_type: 0xffffffff()
[   91.992321] raw: 4000000000010200 ffff888003041dc0 dead000000000100 dead=
000000000122
[   91.993064] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000=
000000000000
[   91.993812] page dumped because: kasan: bad access detected

[   91.994505] Memory state around the buggy address:
[   91.994973]  ffff8880389a8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   91.995656]  ffff8880389a8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   91.996366] >ffff8880389a8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   91.997050]                       ^
[   91.997399]  ffff8880389a8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   91.998087]  ffff8880389a8300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[   91.998774] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
