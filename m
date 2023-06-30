Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766B9744361
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjF3Umk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3Umg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:42:36 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B66BD;
        Fri, 30 Jun 2023 13:42:35 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id FKRcqfuqWfaVXFKwsqzAH0; Fri, 30 Jun 2023 20:42:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id FKwrqtbpVyWX6FKwrqUAfS; Fri, 30 Jun 2023 20:42:33 +0000
X-Authority-Analysis: v=2.4 cv=L5IO/sf8 c=1 sm=1 tr=0 ts=649f3e39
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8
 a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8
 a=xjWn6lA6g3CWHTlZJwwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22 a=HkZW87K1Qel5hWWM3VKY:22 a=cQPPKAXgyycSBL8etih5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/P25XoWocTqeuunlFiDXa1Xh7ntxGZHuVbgXimvxP/4=; b=J9pW7WBzoZOlUBf+XKCdg/O/2X
        lC4vz/JAL+vdIgIyGqv37WIIDIpzGuRbCUe7iARzNp2iJhMfIOt97N1ayoIMsqZoc+sOX3LfSqDe9
        hGWScXsBjb140P9OguMZRZKhtvgbd1r4wpBo+M9kpNEhDHZKWpRkZej22DyQMj1VXd8q89+mBu6lA
        Hehp8DGRrCC7r0HKYIdm/h4U4px/l9iXg972Ov4RBRD7YQtePXL0U5SXJKbCtkVWIYf5vrp/gv0kb
        8ZuqJNMJVkPd4J26qWMxbFZuUZNOYqAIhqZwzZtjFmDRWTLV+dwFOisN2PZSICkbkasdtGbYWZMtM
        AOxRS90A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:39270 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qFJLR-002Yq2-37;
        Fri, 30 Jun 2023 13:59:50 -0500
Message-ID: <a55bdeae-149b-5d08-9544-57ac8140147c@embeddedor.com>
Date:   Fri, 30 Jun 2023 13:00:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] pid: Replace struct pid 1-element array with
 flex-array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230630180418.gonna.286-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230630180418.gonna.286-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qFJLR-002Yq2-37
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:39270
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP0LiplCTGFH3P4K5KOoIsaFnaQT2Zh5TUxSfm849qkC1LGnfLU6AjuFvu7KTaXqWkFTw+utLoit+ZRcjpUUHMVjPhYbOrDPQya3kxPGHxrIlo6rDzqX
 ZLEQbn2xdGbGFLBPzfDIkdgI7CA7G5SFY902njp1Uh6swghyoQEbb4cyDB2MC79jXP/yyQomXUZBNc/uLTZyJHExJvMuVwdYlgixRGGsHzIgPOtPK58/bNYn
 HeGAJP/tcfZ3tIJ7M2d43ULovYNKyleWm+2trz6CsuM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/23 12:04, Kees Cook wrote:
> For pid namespaces, struct pid uses a dynamically sized array member,
> "numbers". This was implemented using the ancient 1-element fake flexible
> array, which has been deprecated for decades. Replace it with a C99
> flexible array, refactor the array size calculations to use struct_size(),
> and address elements via indexes. Note that the static initializer (which
> defines a single element) works as-is, and requires no special handling.
> 
> Without this, CONFIG_UBSAN_BOUNDS (and potentially CONFIG_FORTIFY_SOURCE)
> will trigger bounds checks when entering a pid namespace:
> https://lore.kernel.org/lkml/20230517-bushaltestelle-super-e223978c1ba6@brauner
> 
> For example: unshare --fork --pid --mount-proc readlink /proc/self
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Daniel Verkamp <dverkamp@chromium.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000c6de2a05fbdecbbb@google.com/
> Acked-by: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I would vote in favor of the array over the pointer notation, but anyway... we need
to land this change, and that's what matters.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> v2:
>   - drop pointer math to array index conversions (torvalds)
>   - use struct_size_t now that it exists (torvalds)
>   - updated commit log with reproducer example
> v1: https://lore.kernel.org/lkml/20230517225838.never.965-kees@kernel.org/
> ---
>   include/linux/pid.h    | 2 +-
>   kernel/pid.c           | 7 +++++--
>   kernel/pid_namespace.c | 2 +-
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index b75de288a8c2..653a527574c4 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -67,7 +67,7 @@ struct pid
>   	/* wait queue for pidfd notifications */
>   	wait_queue_head_t wait_pidfd;
>   	struct rcu_head rcu;
> -	struct upid numbers[1];
> +	struct upid numbers[];
>   };
>   
>   extern struct pid init_struct_pid;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index f93954a0384d..6a1d23a11026 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -656,8 +656,11 @@ void __init pid_idr_init(void)
>   
>   	idr_init(&init_pid_ns.idr);
>   
> -	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
> -			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
> +	init_pid_ns.pid_cachep = kmem_cache_create("pid",
> +			struct_size_t(struct pid, numbers, 1),
> +			__alignof__(struct pid),
> +			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
> +			NULL);
>   }
>   
>   static struct file *__pidfd_fget(struct task_struct *task, int fd)
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index b43eee07b00c..0bf44afe04dd 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -48,7 +48,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>   		return kc;
>   
>   	snprintf(name, sizeof(name), "pid_%u", level + 1);
> -	len = sizeof(struct pid) + level * sizeof(struct upid);
> +	len = struct_size_t(struct pid, numbers, level + 1);
>   	mutex_lock(&pid_caches_mutex);
>   	/* Name collision forces to do allocation under mutex. */
>   	if (!*pkc)
