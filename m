Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC98721588
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFDINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjFDINK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:13:10 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F0F2;
        Sun,  4 Jun 2023 01:13:09 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-557c7ffea48so2527862eaf.1;
        Sun, 04 Jun 2023 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685866388; x=1688458388;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M8EGlmoGKogetGCwINX0n2cBTILy0jP8V+Vmkpbyr0M=;
        b=rHj2Fe3ArlP0l+9j2FWB2tz2hTuNS7wEZHsomnL1yWVTxJzXT8j3Xfu4TYQb1d4zsQ
         Jo+9xz7AmGtp8k3KWeTKf15wTAMa26rpj1sksMCMZFyKPy83IVC8sGgNY/JdHu+KRMpA
         k7ABGAl8I0TeVJXXaGuM+HPJvVnxKQeb/2V1IWGZb+ASweBl8kcz2nFOMvuHoMQ8Vk7O
         43u55l7kczdsM29CZTeFVaxaFekiGOZjBbZCtMWUp+6lZbXUj6ezQeroVyfFioj5974p
         hVR3nAVoAFsoAKTnDY/uiPmw7CyeXNJ8/O90Q3+0RjX0AKYGb2G0mwYAeNyyXfxmFtu3
         /z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685866388; x=1688458388;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8EGlmoGKogetGCwINX0n2cBTILy0jP8V+Vmkpbyr0M=;
        b=JNLw+Ch/JYm3DFs1nxeiijidLvlqkCEYDMLjf0qE2NkysMiTFQFCVNq/8K7H3dI6EW
         xgGgXPKoq/an5fe6MdQZAE2NHvRLAIbAHt97TQfUHZhhXeDtdLGwMk2jfrk2ZVpNJjCo
         YwYYLm1HPCIlago0D7RyvtJRiVMziSTdmQmyTsRFNtJ+ScQTaZ52aHYUcJatXd3in8it
         dMVpXT6mC/KLaxye0lwsPJT9ERtw8Lqh5yhIF4MuKS9LqSzDkglNTN19lSb2x5wqcmVV
         cyFBwDuS49JmKgvGAIXPkUV/L+QVqrOAFSa0WwHGB8JhfAb6U+Nie09m+EJrYlU1VOHr
         xr8g==
X-Gm-Message-State: AC+VfDy/2jNKtLNNJ9Z6IgijvMojTXtFC1brGKNA3aAllpvU9qaQ27Yj
        qhOqs9lkBIBrJvy0QpQ7+OsgHWxkH8GQqI6Svvk=
X-Google-Smtp-Source: ACHHUZ47kkehNe5Gtn75GsKVCrwdyF5HJyrrWaOsn+hyZbhGN05pQZm0x5WILJyjPKkg4f1+sNXjkHRCI4iEYFLV2q0=
X-Received: by 2002:a4a:c912:0:b0:558:a804:20d3 with SMTP id
 v18-20020a4ac912000000b00558a80420d3mr1915300ooq.6.1685866388334; Sun, 04 Jun
 2023 01:13:08 -0700 (PDT)
MIME-Version: 1.0
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Sun, 4 Jun 2023 16:12:56 +0800
Message-ID: <CAFcO6XOacq3hscbXevPQP7sXRoYFz34ZdKPYjmd6k5sZuhGFDw@mail.gmail.com>
Subject: A null-ptr-deref bug in reiserfs_breada in fs/reiserfs/journal.c
To:     Jan Kara <jack@suse.cz>, akpm@linux-foundation.org,
        yi.zhang@huawei.com, trix@redhat.com, song@kernel.org,
        Matthew Wilcox <willy@infradead.org>, bvanassche@acm.org
Cc:     reiserfs-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there is a null-ptr-deref  bug in reiserfs_breada in
fs/reiserfs/journal.c, I reproduce it in the latest kernel too.

#Quick description
mount a reiserfs and open file to LOOP_SET_STATUS64 via ioctl, then In
reiserfs_breada function would call buffer_uptodate
```
for (i = 1; i < blocks; i++) {
bh = __getblk(dev, block + i, bufsize);
if (buffer_uptodate(bh)) { //// [1]
brelse(bh);
break;
} else
bhlist[j++] = bh;
}
```
The buffer_uptodate:
```
static __always_inline int buffer_uptodate(const struct buffer_head *bh)
{
/*
* make it consistent with folio_test_uptodate
* pairs with smp_mb__before_atomic in set_buffer_uptodate
*/
return test_bit_acquire(BH_Uptodate, &bh->b_state);
}
```
The bh->b_state is NULL.


#crash log
   44.064289][ T8045] loop4: detected capacity change from 252256 to 102
[   44.065874][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.065874][ T8065] loop4: rw=0, sector=14984, nr_sectors = 8 limit=102
[   44.066917][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.066917][ T8065] loop4: rw=0, sector=14992, nr_sectors = 8 limit=102
[   44.067912][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.067912][ T8065] loop4: rw=0, sector=15000, nr_sectors = 8 limit=102
[   44.068897][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.068897][ T8065] loop4: rw=0, sector=15008, nr_sectors = 8 limit=102
[   44.069909][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.069909][ T8065] loop4: rw=0, sector=15016, nr_sectors = 8 limit=102
[   44.070904][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.070904][ T8065] loop4: rw=0, sector=15024, nr_sectors = 8 limit=102
[   44.071898][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.071898][ T8065] loop4: rw=0, sector=15032, nr_sectors = 8 limit=102
[   44.072905][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.072905][ T8065] loop4: rw=0, sector=15040, nr_sectors = 8 limit=102
[   44.073937][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.073937][ T8065] loop4: rw=0, sector=15048, nr_sectors = 8 limit=102
[   44.078718][ T8065] reiserfs_breada: attempt to access beyond end of device
[   44.078718][ T8065] loop4: rw=0, sector=15056, nr_sectors = 8 limit=102
[   44.080474][ T8065]
==================================================================
[   44.081090][ T8065] BUG: KASAN: null-ptr-deref in reiserfs_breada+0x16f/0x460
[   44.081679][ T8065] Read of size 8 at addr 0000000000000000 by task
reiserfs_breada/8065
[   44.082304][ T8065]
[   44.082495][ T8065] CPU: 0 PID: 8065 Comm: reiserfs_breada Not
tainted 6.4.0-rc4-00276-ge5282a7d8f6b-dirty #23
[   44.083273][ T8065] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   44.083953][ T8065] Call Trace:
[   44.084207][ T8065]  <TASK>
[   44.084433][ T8065]  dump_stack_lvl+0x150/0x210
[   44.084816][ T8065]  ? reiserfs_breada+0x16f/0x460
[   44.085197][ T8065]  kasan_report+0xb2/0xe0
[   44.085544][ T8065]  ? reiserfs_breada+0x16f/0x460
[   44.085921][ T8065]  kasan_check_range+0x144/0x190
[   44.086298][ T8065]  reiserfs_breada+0x16f/0x460
[   44.086674][ T8065]  ? reiserfs_end_ordered_io+0xc0/0xc0
[   44.087095][ T8065]  ? journal_transaction_is_valid+0x7af/0xc30
[   44.087555][ T8065]  ? __sanitizer_cov_trace_pc+0x11/0x70
[   44.087982][ T8065]  journal_init+0x23a3/0x6230
[   44.088347][ T8065]  ? vprintk+0x8c/0xa0
[   44.088667][ T8065]  ? syslog_print_all+0x3a0/0x3a0
[   44.089052][ T8065]  ? journal_release_error+0xa0/0xa0
[   44.089448][ T8065]  ? reiserfs_init_bitmap_cache+0xfc/0x1d0
[   44.089877][ T8065]  ? vmalloc+0x6b/0x80
[   44.090188][ T8065]  ? reiserfs_init_bitmap_cache+0xfc/0x1d0
[   44.090640][ T8065]  ? reiserfs_fill_super+0x1098/0x2e60
[   44.091059][ T8065]  reiserfs_fill_super+0xc1f/0x2e60
[   44.091459][ T8065]  ? reiserfs_remount+0x15b0/0x15b0
[   44.091856][ T8065]  ? __kmalloc+0x5e/0x160
[   44.092192][ T8065]  ? snprintf+0xbf/0x100
[   44.092507][ T8065]  ? vsprintf+0x30/0x30
[   44.092817][ T8065]  ? mutex_unlock+0x7f/0xd0
[   44.093160][ T8065]  mount_bdev+0x345/0x400
[   44.093499][ T8065]  ? reiserfs_remount+0x15b0/0x15b0
[   44.093905][ T8065]  ? reiserfs_kill_sb+0x1e0/0x1e0
[   44.094297][ T8065]  legacy_get_tree+0xf7/0x200
[   44.094627][ T8075] loop3: detected capacity change from 0 to 252256
[   44.094652][ T8065]  vfs_get_tree+0x87/0x330
[   44.095459][ T8065]  path_mount+0x675/0x1d20
[   44.095812][ T8065]  ? kmem_cache_free+0xc4/0x480
[   44.096216][ T8065]  ? finish_automount+0x780/0x780
[   44.096649][ T8065]  ? putname+0x102/0x140
[   44.097027][ T8065]  __x64_sys_mount+0x283/0x300
[   44.097407][ T8065]  ? copy_mnt_ns+0xae0/0xae0
[   44.097776][ T8065]  ? fpregs_assert_state_consistent+0xc0/0xe0
[   44.098265][ T8065]  ? exit_to_user_mode_prepare+0x3f/0x200
[   44.098720][ T8065]  do_syscall_64+0x39/0xb0
[   44.099074][ T8065]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   44.099531][ T8065] RIP: 0033:0x45228e
[   44.099835][ T8065] Code: 48 c7 c0 ff ff ff ff eb aa e8 7e 04 00 00
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff 8
[   44.101183][ T8065] RSP: 002b:00007fff8e731d68 EFLAGS: 00000286
ORIG_RAX: 00000000000000a5
[   44.101722][ T8065] RAX: ffffffffffffffda RBX: 00007fff8e732198
RCX: 000000000045228e
[   44.102110][ T8065] RDX: 0000000020000000 RSI: 0000000020000100
RDI: 00007fff8e731de0
[   44.102549][ T8065] RBP: 00007fff8e731f30 R08: 00007fff8e731e20
R09: 0000000000000000
[   44.102978][ T8065] R10: 0000000000000000 R11: 0000000000000286
R12: 0000000000000001
[   44.103495][ T8065] R13: 00007fff8e732188 R14: 00000000004ca790
R15: 0000000000000001
[   44.104029][ T8065]  </TASK>
[   44.104257][ T8065]
==================================================================

If needed, I would provide reproduce.

Regards,
 butt3rflyh4ck.

--
Active Defense Lab of Venustech
