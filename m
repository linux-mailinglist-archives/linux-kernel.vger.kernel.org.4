Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC7770EBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbjEXDih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjEXDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:38:35 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B3BF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:38:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjMPeag_1684899508;
Received: from 30.221.130.24(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VjMPeag_1684899508)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 11:38:29 +0800
Message-ID: <e9fc4b2f-1fcc-7c31-f346-59eccff50f9b@linux.alibaba.com>
Date:   Wed, 24 May 2023 11:38:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ocfs2: fix use-after-free when unmounting read-only
 filesystem
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Heming Zhao <heming.zhao@suse.com>,
        akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20230523093310.2628-1-lhenriques@suse.de>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230523093310.2628-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 5:33 PM, Luís Henriques wrote:
> It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
> fstest generic/452.  After a read-only remount, quotas are suspended and
> ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info().  When unmounting
> the filesystem, an UAF access to the oinfo will eventually cause a crash.
> 
> BUG: KASAN: slab-use-after-free in timer_delete+0x54/0xc0
> Read of size 8 at addr ffff8880389a8208 by task umount/669
> ...
> Call Trace:
>  <TASK>
>  ...
>  timer_delete+0x54/0xc0
>  try_to_grab_pending+0x31/0x230
>  __cancel_work_timer+0x6c/0x270
>  ocfs2_disable_quotas.isra.0+0x3e/0xf0 [ocfs2]
>  ocfs2_dismount_volume+0xdd/0x450 [ocfs2]
>  generic_shutdown_super+0xaa/0x280
>  kill_block_super+0x46/0x70
>  deactivate_locked_super+0x4d/0xb0
>  cleanup_mnt+0x135/0x1f0
>  ...
>  </TASK>
> 
> Allocated by task 632:
>  kasan_save_stack+0x1c/0x40
>  kasan_set_track+0x21/0x30
>  __kasan_kmalloc+0x8b/0x90
>  ocfs2_local_read_info+0xe3/0x9a0 [ocfs2]
>  dquot_load_quota_sb+0x34b/0x680
>  dquot_load_quota_inode+0xfe/0x1a0
>  ocfs2_enable_quotas+0x190/0x2f0 [ocfs2]
>  ocfs2_fill_super+0x14ef/0x2120 [ocfs2]
>  mount_bdev+0x1be/0x200
>  legacy_get_tree+0x6c/0xb0
>  vfs_get_tree+0x3e/0x110
>  path_mount+0xa90/0xe10
>  __x64_sys_mount+0x16f/0x1a0
>  do_syscall_64+0x43/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Freed by task 650:
>  kasan_save_stack+0x1c/0x40
>  kasan_set_track+0x21/0x30
>  kasan_save_free_info+0x2a/0x50
>  __kasan_slab_free+0xf9/0x150
>  __kmem_cache_free+0x89/0x180
>  ocfs2_local_free_info+0x2ba/0x3f0 [ocfs2]
>  dquot_disable+0x35f/0xa70
>  ocfs2_susp_quotas.isra.0+0x159/0x1a0 [ocfs2]
>  ocfs2_remount+0x150/0x580 [ocfs2]
>  reconfigure_super+0x1a5/0x3a0
>  path_mount+0xc8a/0xe10
>  __x64_sys_mount+0x16f/0x1a0
>  do_syscall_64+0x43/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Tested with following procedures:
mkfs.ocfs2 -b 4k -C 1M -N 2 --fs-features=usrquota,grpquota /dev/vdc
/etc/init.d/o2cb.init online ocfs2cluster
mount.ocfs2 -o usrquota,grpquota /dev/vdc /mnt/ocfs2
mount.ocfs2 -o remount,ro,heartbeat=local /dev/vdc /mnt/ocfs2
umount /mnt/ocfs2

> ---
> Changes since v1:
>  - Fixed changelog to explicitly state 'read-only remount'
>  - Added KASAN splat to changelog
> 
>  fs/ocfs2/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 0b0e6a132101..988d1c076861 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -952,8 +952,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
>  	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
>  		if (!sb_has_quota_loaded(sb, type))
>  			continue;
> -		oinfo = sb_dqinfo(sb, type)->dqi_priv;
> -		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
> +		if (!sb_has_quota_suspended(sb, type)) {
> +			oinfo = sb_dqinfo(sb, type)->dqi_priv;
> +			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
> +		}
>  		inode = igrab(sb->s_dquot.files[type]);
>  		/* Turn off quotas. This will remove all dquot structures from
>  		 * memory and so they will be automatically synced to global
