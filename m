Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A16B2046
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCIJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCIJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:39:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F794E20C4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:39:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8DC81FFC1;
        Thu,  9 Mar 2023 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678354751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhkFbSmezdqWEcTL9jACXm7CTqLZyDyZfUS3Z5QYFY0=;
        b=hwrl+ZFQZdrKjKDDAQpjRZQPf9ixGcePjrieFI1meXAiSAfFCOfcbiBb+3G+XX1HcT8HMi
        pUipGkoDCDhPwjqJ9NtUHtfjKgmAixETVblo7+ujl8+jJEFCBR6K2NXxqhXnlomZQ5cMBv
        kO9thRwUrNg3TgRjIVHkBP+EIPmp1kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678354751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhkFbSmezdqWEcTL9jACXm7CTqLZyDyZfUS3Z5QYFY0=;
        b=p0CnFn+p2i/5YENiNXeZsqkhzYHmTsnbCZslASyEsRa0lC/lS8y4iml7uAwcL0UIWy/xwa
        d9dSnyIdETM+XhAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1BEA1391B;
        Thu,  9 Mar 2023 09:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AOuuKj+pCWRZFAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 09:39:11 +0000
Message-ID: <96f34c88-ca9a-1c3c-e02a-7c5cd1a269e4@suse.cz>
Date:   Thu, 9 Mar 2023 10:39:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/8] mm: shrinkers: make count and scan in shrinker
 debugfs lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-6-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-6-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 07:56, Qi Zheng wrote:
> Like global and memcg slab shrink, also use SRCU to
> make count and scan operations in memory shrinker
> debugfs lockless.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/shrinker_debug.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 39c3491e28a3..6aa7a7ec69da 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c

Forgot to mention that this file should now likely also #include <linux/srcu.h>

> @@ -9,6 +9,7 @@
>  /* defined in vmscan.c */
>  extern struct rw_semaphore shrinker_rwsem;
>  extern struct list_head shrinker_list;
> +extern struct srcu_struct shrinker_srcu;

