Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3262250B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKIICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKIIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:01:59 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497A1C906
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:01:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VUN.-.w_1667980911;
Received: from 30.221.128.156(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VUN.-.w_1667980911)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 16:01:52 +0800
Message-ID: <d36d09ba-271a-dc42-395f-0613fc75259b@linux.alibaba.com>
Date:   Wed, 9 Nov 2022 16:01:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2] ocfs2: fix memory leak in ocfs2_mount_volume()
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>, akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
        ocfs2-devel@oss.oracle.com, srinivas.eeda@oracle.com
References: <05c24286-427d-e572-aa70-8f1d882b9602@linux.alibaba.com>
 <20221109074627.2303950-1-lizetao1@huawei.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20221109074627.2303950-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/22 3:46 PM, Li Zetao wrote:
> There is a memory leak reported by kmemleak:
> 
>   unreferenced object 0xffff88810cc65e60 (size 32):
>     comm "mount.ocfs2", pid 23753, jiffies 4302528942 (age 34735.105s)
>     hex dump (first 32 bytes):
>       10 00 00 00 00 00 00 00 00 01 01 01 01 01 01 01  ................
>       01 01 01 01 01 01 01 01 00 00 00 00 00 00 00 00  ................
>     backtrace:
>       [<ffffffff8170f73d>] __kmalloc+0x4d/0x150
>       [<ffffffffa0ac3f51>] ocfs2_compute_replay_slots+0x121/0x330 [ocfs2]
>       [<ffffffffa0b65165>] ocfs2_check_volume+0x485/0x900 [ocfs2]
>       [<ffffffffa0b68129>] ocfs2_mount_volume.isra.0+0x1e9/0x650 [ocfs2]
>       [<ffffffffa0b7160b>] ocfs2_fill_super+0xe0b/0x1740 [ocfs2]
>       [<ffffffff818e1fe2>] mount_bdev+0x312/0x400
>       [<ffffffff819a086d>] legacy_get_tree+0xed/0x1d0
>       [<ffffffff818de82d>] vfs_get_tree+0x7d/0x230
>       [<ffffffff81957f92>] path_mount+0xd62/0x1760
>       [<ffffffff81958a5a>] do_mount+0xca/0xe0
>       [<ffffffff81958d3c>] __x64_sys_mount+0x12c/0x1a0
>       [<ffffffff82f26f15>] do_syscall_64+0x35/0x80
>       [<ffffffff8300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> This call stack is related to two problems. Firstly, the ocfs2 super uses
> "replay_map" to trace online/offline slots, in order to recover offline
> slots during recovery and mount. But when ocfs2_truncate_log_init()
> returns an error in ocfs2_mount_volume(), the memory of "replay_map"
> will not be freed in error handling path. Secondly, the memory of
> "replay_map" will not be freed if d_make_root() returns an error in
> ocfs2_fill_super(). But the memory of "replay_map" will be freed normally
> when completing recovery and mount in ocfs2_complete_mount_recovery().
> 
> Fix the first problem by adding error handling path to free "replay_map"
> when ocfs2_truncate_log_init() fails. And fix the second problem by
> calling ocfs2_free_replay_slots(osb) in the error handling path
> "out_dismount". In addition, since ocfs2_free_replay_slots() is static,
> it is necessary to remove its static attribute and declare it in header
> file.
> 
> Fixes: 9140db04ef18 ("ocfs2: recover orphans in offline slots during recovery and mount")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> v1 was posted at: https://lore.kernel.org/all/20221108152516.1189165-1-lizetao1@huawei.com/
> v1 -> v2: Rename the label "out_truncate_log" to "out_check_volume"
> 
>  fs/ocfs2/journal.c | 2 +-
>  fs/ocfs2/journal.h | 1 +
>  fs/ocfs2/super.c   | 5 ++++-
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 126671e6caed..3fb98b4569a2 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -157,7 +157,7 @@ static void ocfs2_queue_replay_slots(struct ocfs2_super *osb,
>  	replay_map->rm_state = REPLAY_DONE;
>  }
>  
> -static void ocfs2_free_replay_slots(struct ocfs2_super *osb)
> +void ocfs2_free_replay_slots(struct ocfs2_super *osb)
>  {
>  	struct ocfs2_replay_map *replay_map = osb->replay_map;
>  
> diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
> index 969d0aa28718..41c382f68529 100644
> --- a/fs/ocfs2/journal.h
> +++ b/fs/ocfs2/journal.h
> @@ -150,6 +150,7 @@ int ocfs2_recovery_init(struct ocfs2_super *osb);
>  void ocfs2_recovery_exit(struct ocfs2_super *osb);
>  
>  int ocfs2_compute_replay_slots(struct ocfs2_super *osb);
> +void ocfs2_free_replay_slots(struct ocfs2_super *osb);
>  /*
>   *  Journal Control:
>   *  Initialize, Load, Shutdown, Wipe a journal.
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 42c993e53924..0b0e6a132101 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -1159,6 +1159,7 @@ static int ocfs2_fill_super(struct super_block *sb, void *data, int silent)
>  out_dismount:
>  	atomic_set(&osb->vol_state, VOLUME_DISABLED);
>  	wake_up(&osb->osb_mount_event);
> +	ocfs2_free_replay_slots(osb);
>  	ocfs2_dismount_volume(sb, 1);
>  	goto out;
>  
> @@ -1822,12 +1823,14 @@ static int ocfs2_mount_volume(struct super_block *sb)
>  	status = ocfs2_truncate_log_init(osb);
>  	if (status < 0) {
>  		mlog_errno(status);
> -		goto out_system_inodes;
> +		goto out_check_volume;
>  	}
>  
>  	ocfs2_super_unlock(osb, 1);
>  	return 0;
>  
> +out_check_volume:
> +	ocfs2_free_replay_slots(osb);
>  out_system_inodes:
>  	if (osb->local_alloc_state == OCFS2_LA_ENABLED)
>  		ocfs2_shutdown_local_alloc(osb);
