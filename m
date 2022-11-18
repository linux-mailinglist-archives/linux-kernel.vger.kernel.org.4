Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9CF62ED42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiKRFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiKRFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:43:21 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59EA8F3D5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:43:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VV3jx1x_1668750195;
Received: from 30.221.129.0(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VV3jx1x_1668750195)
          by smtp.aliyun-inc.com;
          Fri, 18 Nov 2022 13:43:16 +0800
Message-ID: <9b4fd897-d5a0-7304-901e-303a5455303f@linux.alibaba.com>
Date:   Fri, 18 Nov 2022 13:43:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [Linux-cachefs] [PATCH] fscache: fix OOB Read in
 __fscache_acquire_volume
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, zhangpeng362@huawei.com,
        asmadeus@codewreck.org
Cc:     lucho@ionkov.net, linux_oss@crudebyte.com,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com,
        linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net
References: <166869954095.3793579.8500020902371015443.stgit@warthog.procyon.org.uk>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <166869954095.3793579.8500020902371015443.stgit@warthog.procyon.org.uk>
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



On 11/17/22 11:39 PM, David Howells wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The type of a->key[0] is char in fscache_volume_same().  If the length of
> cache volume key is greater than 127, the value of a->key[0] is less than
> 0.  In this case, klen becomes much larger than 255 after type conversion,
> because the type of klen is size_t.  As a result, memcmp() is read out of
> bounds.
> 
> This causes a slab-out-of-bounds Read in __fscache_acquire_volume(), as
> reported by Syzbot.
> 
> Fix this by changing the type of the stored key to "u8 *" rather than "char
> *" (it isn't a simple string anyway).  Also put in a check that the volume
> name doesn't exceed NAME_MAX.
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcmp+0x16f/0x1c0 lib/string.c:757
> Read of size 8 at addr ffff888016f3aa90 by task syz-executor344/3613
> 
> CPU: 0 PID: 3613 Comm: syz-executor344 Not tainted
> 6.0.0-rc2-syzkaller-00327-g8379c0b31fbc #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS
> Google 07/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:317 [inline]
>  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>  memcmp+0x16f/0x1c0 lib/string.c:757
>  memcmp include/linux/fortify-string.h:420 [inline]
>  fscache_volume_same fs/fscache/volume.c:133 [inline]
>  fscache_hash_volume fs/fscache/volume.c:171 [inline]
>  __fscache_acquire_volume+0x76c/0x1080 fs/fscache/volume.c:328
>  fscache_acquire_volume include/linux/fscache.h:204 [inline]
>  v9fs_cache_session_get_cookie+0x143/0x240 fs/9p/cache.c:34
>  v9fs_session_init+0x1166/0x1810 fs/9p/v9fs.c:473
>  v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1326/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f7d5064b1d9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd1700c028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffd1700c060 RCX: 00007f7d5064b1d9
> RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000020000200 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
> R13: 0000000000000000 R14: 00007ffd1700c04c R15: 00007ffd1700c050
> ==================================================================
> 
> Fixes: 62ab63352350 ("fscache: Implement volume registration")
> Reported-by: syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Peng Zhang <zhangpeng362@huawei.com>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/Y3OH+Dmi0QIOK18n@codewreck.org/ # Zhang Peng's v1 fix
> Link: https://lore.kernel.org/r/20221115140447.2971680-1-zhangpeng362@huawei.com/ # Zhang Peng's v2 fix

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
> 
>  fs/fscache/volume.c     |    7 +++++--
>  include/linux/fscache.h |    2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index a058e0136bfe..ab8ceddf9efa 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -203,7 +203,11 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
>  	struct fscache_volume *volume;
>  	struct fscache_cache *cache;
>  	size_t klen, hlen;
> -	char *key;
> +	u8 *key;
> +
> +	klen = strlen(volume_key);
> +	if (klen > NAME_MAX)
> +		return NULL;
>  
>  	if (!coherency_data)
>  		coherency_len = 0;
> @@ -229,7 +233,6 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
>  	/* Stick the length on the front of the key and pad it out to make
>  	 * hashing easier.
>  	 */
> -	klen = strlen(volume_key);
>  	hlen = round_up(1 + klen + 1, sizeof(__le32));
>  	key = kzalloc(hlen, GFP_KERNEL);
>  	if (!key)
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index 36e5dd84cf59..8e312c8323a8 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -75,7 +75,7 @@ struct fscache_volume {
>  	atomic_t			n_accesses;	/* Number of cache accesses in progress */
>  	unsigned int			debug_id;
>  	unsigned int			key_hash;	/* Hash of key string */
> -	char				*key;		/* Volume ID, eg. "afs@example.com@1234" */
> +	u8				*key;		/* Volume ID, eg. "afs@example.com@1234" */
>  	struct list_head		proc_link;	/* Link in /proc/fs/fscache/volumes */
>  	struct hlist_bl_node		hash_link;	/* Link in hash table */
>  	struct work_struct		work;
> 
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs

-- 
Thanks,
Jingbo
