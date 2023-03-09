Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28B6B2050
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCIJkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCIJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:40:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C08E824F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:40:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F46421D96;
        Thu,  9 Mar 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678354826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvWQ2PVUQBGEt3Okq0OQm74K/a9Nj1kICx/Tp01CsfY=;
        b=m1ybD+sgyfl5MzrJqgQzJ74iON6UP1Qx4LCdBgakX8JVqAMnDblmYq3cWLn5Z79rheuMqN
        aYGbP8F2BX/x9mxdPLnM5cwx1yBIAB02tWwWt7phkOlOlOs1GnAzyw2hs4KreDmI0x1a20
        afell2zym3CtJsOdTRU4l3Q1QHDDKGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678354826;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvWQ2PVUQBGEt3Okq0OQm74K/a9Nj1kICx/Tp01CsfY=;
        b=IT/oiJ0OhkIkm7P+/XKsXrvaWEJc/2UnwwHuSZiwg8TbV30vfBHvqWP7ZmzqVNWxe06kTj
        gdT++hRwFNJkS0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7A921391B;
        Thu,  9 Mar 2023 09:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K6cYMImpCWQVFQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 09:40:25 +0000
Message-ID: <80d8df29-8077-9de7-c304-9029375fc877@suse.cz>
Date:   Thu, 9 Mar 2023 10:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from
 synchronize_shrinkers()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-8-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-8-zhengqi.arch@bytedance.com>
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
> Now there are no readers of shrinker_rwsem, so
> synchronize_shrinkers() does not need to hold the
> writer of shrinker_rwsem to wait for all running
> shinkers to complete, synchronize_srcu() is enough.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7aaf6f94ac1b..ac7ab4aa344f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>  /**
>   * synchronize_shrinkers - Wait for all running shrinkers to complete.
>   *
> - * This is equivalent to calling unregister_shrink() and register_shrinker(),
> - * but atomically and with less overhead. This is useful to guarantee that all
> - * shrinker invocations have seen an update, before freeing memory, similar to
> - * rcu.
> + * This is useful to guarantee that all shrinker invocations have seen an
> + * update, before freeing memory.
>   */
>  void synchronize_shrinkers(void)
>  {
> -	down_write(&shrinker_rwsem);
> -	up_write(&shrinker_rwsem);
>  	atomic_inc(&shrinker_srcu_generation);
>  	synchronize_srcu(&shrinker_srcu);
>  }

