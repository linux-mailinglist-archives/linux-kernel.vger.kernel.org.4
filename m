Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795AE5B5C28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiILO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiILOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:25:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA02D1C4;
        Mon, 12 Sep 2022 07:25:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9892200FE;
        Mon, 12 Sep 2022 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662992753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQ816uq/z72h01vUJ3WqCOqE0rBSfyAYPOG1bRSmGEU=;
        b=t7mrZjRhOopakSQTCP0Fl9xQuAjyYgCTr6Gzk4Iq3U3adDGwB/3yw8e6pUqOUyl1CAmcu+
        4UnRA7+r6SS4W1tH1JxveYYCUw7Up4wr9eS4qCR0igZiGjYRWCn2+Cn/DVBkGofk4B6cUX
        CnuWsecIrEeLgI4fMW0hGPcMBcMSKgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662992753;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQ816uq/z72h01vUJ3WqCOqE0rBSfyAYPOG1bRSmGEU=;
        b=tIHy8hhDKDLLP+9AI60M7pgy8tF+VM0uyaFTyjEknOMr4UIr2yXj46OpMGsz774UkvH6de
        8L2r3wZlsp/1ZMAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A8DD139C8;
        Mon, 12 Sep 2022 14:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lqwYF3FBH2M6RwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 12 Sep 2022 14:25:53 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id fe7b8088;
        Mon, 12 Sep 2022 14:26:45 +0000 (UTC)
References: <20220822094235.2690-1-lhenriques@suse.de>
From:   =?utf-8?Q?Lu=C3=ADs?= Henriques <lhenriques@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Lu=C3=ADs?= Henriques <lhenriques@suse.de>,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v4] ext4: fix bug in extents parsing when eh_entries ==
 0 and eh_depth > 0
Date:   Mon, 12 Sep 2022 15:23:14 +0100
In-reply-to: <20220822094235.2690-1-lhenriques@suse.de>
Message-ID: <87h71cwtwa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ping?

I have written an fstest for this fix, but since it generates a corrupted
image that crashes the kernel I'd rather have the bug fixed before
submitting it.

Cheers,
--=20
Lu=C3=ADs

Lu=C3=ADs Henriques <lhenriques@suse.de> writes:

> When walking through an inode extents, the ext4_ext_binsearch_idx() funct=
ion
> assumes that the extent header has been previously validated.  However, t=
here
> are no checks that verify that the number of entries (eh->eh_entries) is
> non-zero when depth is > 0.  And this will lead to problems because the
> EXT_FIRST_INDEX() and EXT_LAST_INDEX() will return garbage and result in =
this:
>
> [  135.245946] ------------[ cut here ]------------
> [  135.247579] kernel BUG at fs/ext4/extents.c:2258!
> [  135.249045] invalid opcode: 0000 [#1] PREEMPT SMP
> [  135.250320] CPU: 2 PID: 238 Comm: tmp118 Not tainted 5.19.0-rc8+ #4
> [  135.252067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [  135.255065] RIP: 0010:ext4_ext_map_blocks+0xc20/0xcb0
> [  135.256475] Code:
> [  135.261433] RSP: 0018:ffffc900005939f8 EFLAGS: 00010246
> [  135.262847] RAX: 0000000000000024 RBX: ffffc90000593b70 RCX: 000000000=
0000023
> [  135.264765] RDX: ffff8880038e5f10 RSI: 0000000000000003 RDI: ffff88800=
46e922c
> [  135.266670] RBP: ffff8880046e9348 R08: 0000000000000001 R09: ffff88800=
2ca580c
> [  135.268576] R10: 0000000000002602 R11: 0000000000000000 R12: 000000000=
0000024
> [  135.270477] R13: 0000000000000000 R14: 0000000000000024 R15: 000000000=
0000000
> [  135.272394] FS:  00007fdabdc56740(0000) GS:ffff88807dd00000(0000) knlG=
S:0000000000000000
> [  135.274510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  135.276075] CR2: 00007ffc26bd4f00 CR3: 0000000006261004 CR4: 000000000=
0170ea0
> [  135.277952] Call Trace:
> [  135.278635]  <TASK>
> [  135.279247]  ? preempt_count_add+0x6d/0xa0
> [  135.280358]  ? percpu_counter_add_batch+0x55/0xb0
> [  135.281612]  ? _raw_read_unlock+0x18/0x30
> [  135.282704]  ext4_map_blocks+0x294/0x5a0
> [  135.283745]  ? xa_load+0x6f/0xa0
> [  135.284562]  ext4_mpage_readpages+0x3d6/0x770
> [  135.285646]  read_pages+0x67/0x1d0
> [  135.286492]  ? folio_add_lru+0x51/0x80
> [  135.287441]  page_cache_ra_unbounded+0x124/0x170
> [  135.288510]  filemap_get_pages+0x23d/0x5a0
> [  135.289457]  ? path_openat+0xa72/0xdd0
> [  135.290332]  filemap_read+0xbf/0x300
> [  135.291158]  ? _raw_spin_lock_irqsave+0x17/0x40
> [  135.292192]  new_sync_read+0x103/0x170
> [  135.293014]  vfs_read+0x15d/0x180
> [  135.293745]  ksys_read+0xa1/0xe0
> [  135.294461]  do_syscall_64+0x3c/0x80
> [  135.295284]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> This patch simply adds an extra check in __ext4_ext_check(), verifying th=
at
> eh_entries is not 0 when eh_depth is > 0.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215941
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216283
> Cc: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> ---
>  fs/ext4/extents.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> Changes since v3:
> - Fixed typo (I had 'eh_depth' instead of 'depth')
>
> Changes since v2:
> - Dropped usage of le16_to_cpu() because we're comparing values against 0
> - Use 'depth' instead of 'eh->eh_depth' because we've checked earlier that
>   both have the same value.
>
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c148bb97b527..5235974126bd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -460,6 +460,10 @@ static int __ext4_ext_check(const char *function, un=
signed int line,
>  		error_msg =3D "invalid eh_entries";
>  		goto corrupted;
>  	}
> +	if (unlikely((eh->eh_entries =3D=3D 0) && (depth > 0))) {
> +		error_msg =3D "eh_entries is 0 but eh_depth is > 0";
> +		goto corrupted;
> +	}
>  	if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
>  		error_msg =3D "invalid extent entries";
>  		goto corrupted;

