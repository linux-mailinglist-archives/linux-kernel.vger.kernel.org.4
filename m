Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35AE6457BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLGK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:26:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597AD2A418
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:25:57 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEA9B1FDCD;
        Wed,  7 Dec 2022 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670408755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0XdCXVXpqjQNkWrbVjFvvNm5DuOUK/JRA//vhJE++k=;
        b=BZvjAT6nGmbotT5gYiaKaRb/q6PlKaHqCTZUizz2e5rqmquSU/k2ecvse/vKlYiDZMZcju
        7Ii7SP7TL9W2yHFZ2NZt3x1ktpEeOVA3/xLXPV4o+rLwt5Tsq2LsWDDuFLF80Y9txonk5m
        7BkhNISoBIh3IWUzBvm1CnF8biW+A1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670408755;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0XdCXVXpqjQNkWrbVjFvvNm5DuOUK/JRA//vhJE++k=;
        b=TIDGF/ZlrnH0iquGienzQf6UHu6uRJC5f0IqmqoAy+5tWumie626uRSJ22K8ryxIWFSyos
        zspkRffp6vHlUgAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D0A93134CD;
        Wed,  7 Dec 2022 10:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qsrnMjNqkGOnCwAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 10:25:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 613F8A0725; Wed,  7 Dec 2022 11:25:55 +0100 (CET)
Date:   Wed, 7 Dec 2022 11:25:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     lczerner@redhat.com, linux-kernel@vger.kernel.org, jack@suse.cz,
        heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "ext4_xattr_block_set" WARNING in
 v6.1-rc8 guest kernel
Message-ID: <20221207102555.m77yk7oznzx2b2xt@quack3>
References: <Y5BT+k6xWqthZc1P@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BT+k6xWqthZc1P@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed 07-12-22 16:51:06, Pengfei Xu wrote:
> Platform: raptor lake
> 
> There is "ext4_xattr_block_set" WARNING in v6.1-rc8 guest kernel.
> "
> [   27.922337] loop0: detected capacity change from 0 to 1024
> [   27.922663] =======================================================
> [   27.922663] WARNING: The mand mount option has been deprecated and
> [   27.922663]          and is ignored by this kernel. Remove the mand
> [   27.922663]          option from the mount to silence this warning.
> [   27.922663] =======================================================
> [   27.923771] EXT4-fs: Ignoring removed bh option
> [   27.923947] EXT4-fs: Ignoring removed i_version option
> [   27.924204] EXT4-fs: Journaled quota options ignored when QUOTA feature is enabled
> [   27.925839] EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.
> [   27.928984] ------------[ cut here ]------------
> [   27.929173] WARNING: CPU: 0 PID: 567 at fs/ext4/xattr.c:2069 ext4_xattr_block_set+0x170d/0x1770

Thanks for report! I see where the problem is, I just don't see why mount
API would be really related to that. That is likely just a coincidence
caused by the particular reproducer from syzbot.

The core of the problem is that we try to expand i_extra_isize on every
__ext4_mark_inode_dirty() call. Now there are certainly moments when the
inode is dirtied without setting up quotas - in this case when
ext4_setattr() was called to modify file permissions but e.g. timestamp
updates can be another such occasion. If the inode already has enough
xattrs that after expanding i_extra_isize they don't fit into the inode and
we need to allocate external xattr block, the warning triggers.

Generally we cannot initialize quotas in ext4_try_to_expand_extra_isize()
because we may be relatively deep in the call stack and I'd be worried
about the lock ordering. Also making sure quota is initialized whenever we
call __ext4_mark_inode_dirty() looks like playing a whack-a-mole game. So I
think the easiest approach would be bail from expansion if we need to
allocate block and we don't have quotas initialized. I'll send a patch.

								Honza

> [   27.929514] Modules linked in:
> [   27.929651] CPU: 0 PID: 567 Comm: repro Not tainted 6.1.0-rc8-76dcd734eca2 #1
> [   27.929931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   27.930355] RIP: 0010:ext4_xattr_block_set+0x170d/0x1770
> [   27.930562] Code: e8 78 18 ff ff 48 8b 7d a0 e8 4f eb e5 ff e9 80 fe ff ff e8 25 3d b5 ff 4c 89 ff e8 fd c2 e9 ff e9 b6 f5 ff ff e8 13 3d b5 ff <0f> 0b e9 21 1
> [   27.931241] RSP: 0018:ffffc90000fc7a10 EFLAGS: 00010246
> [   27.931442] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff816fa04d
> [   27.931708] RDX: 0000000000000000 RSI: ffff88800cb6cc80 RDI: 0000000000000002
> [   27.931973] RBP: ffffc90000fc7ae8 R08: ffff88800bae3824 R09: ffff88800bae3bfe
> [   27.932236] R10: ffffc90000fc7e28 R11: 00000000fa83b201 R12: 0000000000000000
> [   27.932502] R13: ffff88800cb85800 R14: 0000000000000000 R15: 0000000000000000
> [   27.932781] FS:  00007f69b3c68740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   27.933079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   27.933296] CR2: 000055c48486e5e8 CR3: 000000000b76a005 CR4: 0000000000770ef0
> [   27.933569] PKRU: 55555554
> [   27.933676] Call Trace:
> [   27.933773]  <TASK>
> [   27.933861]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   27.934048]  ext4_expand_extra_isize_ea+0x5e9/0xcd0
> [   27.934242]  __ext4_expand_extra_isize+0x188/0x1f0
> [   27.934443]  __ext4_mark_inode_dirty+0x246/0x370
> [   27.934637]  ? ext4_setattr+0x1380/0x1380
> [   27.934794]  ext4_dirty_inode+0x7a/0xa0
> [   27.934946]  __mark_inode_dirty+0xa3/0x650
> [   27.935107]  ? setattr_copy+0x11e/0x320
> [   27.935259]  ext4_setattr+0xb26/0x1380
> [   27.935407]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   27.935593]  ? ext4_journalled_write_end+0x900/0x900
> [   27.935792]  notify_change+0x3f8/0xb50
> [   27.935943]  chmod_common+0xef/0x200
> [   27.936085]  ? chmod_common+0xef/0x200
> [   27.936235]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   27.936420]  do_fchmodat+0x76/0xf0
> [   27.936558]  __x64_sys_chmod+0x28/0x40
> [   27.936713]  do_syscall_64+0x3b/0x90
> [   27.936862]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   27.937062] RIP: 0033:0x7f69b3d8d59d
> [   27.937203] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> [   27.937900] RSP: 002b:00007ffccac7eef8 EFLAGS: 00000246 ORIG_RAX: 000000000000005a
> [   27.938184] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f69b3d8d59d
> [   27.938450] RDX: 0031656c69662f2e RSI: 0000000000000140 RDI: 0000000020000100
> [   27.938719] RBP: 00007ffccac7ef00 R08: 00007ffccac7ed60 R09: 00000000004028e0
> [   27.938985] R10: 00007ffccac7ed60 R11: 0000000000000246 R12: 00000000004011a0
> [   27.939250] R13: 00007ffccac7efe0 R14: 0000000000000000 R15: 0000000000000000
> [   27.939517]  </TASK>
> [   27.939605] ---[ end trace 0000000000000000 ]---
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
