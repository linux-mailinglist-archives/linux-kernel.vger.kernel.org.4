Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D151622A03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiKILQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKILPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:15:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75222D2C7;
        Wed,  9 Nov 2022 03:15:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7CBF22669;
        Wed,  9 Nov 2022 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667992509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNPmCujJY1ps+Tz3Gg/3GI/4FYCC727YNMiyNM1sohc=;
        b=pZ199acsSOQmdv4NpOdAGxXw8IH2RzxTcCny4KsW3kQz5CbWtggHX8se2rxBGc6K4S8csM
        Pesuc8Jy6+jxR/VZd4tRVKEkT5GhWynRCuu/MQVRntII/iRxcP5O7x6GRrs4Kkj12Of0Gm
        doqwTG6mooOO0eu4nBq5wWnaaiz8Al4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667992509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNPmCujJY1ps+Tz3Gg/3GI/4FYCC727YNMiyNM1sohc=;
        b=JBg/uxE3r4syvWIReC0lQ30n5+OmAI4/klshCeOGGGUOR6QEAPvr2ySgURXzq+eZxYkD9m
        ElVm3U/ShvgURfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDC9E1331F;
        Wed,  9 Nov 2022 11:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mE47Mr2La2OjMwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 11:15:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 70B89A0704; Wed,  9 Nov 2022 12:15:09 +0100 (CET)
Date:   Wed, 9 Nov 2022 12:15:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
        Jan Kara <jack@suse.cz>, Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH 1/2] bfq: fix waker_bfqq inconsistency crash
Message-ID: <20221109111509.hauihlwywtjoofeq@quack3>
References: <20221103013937.603626-1-khazhy@google.com>
 <20221108181030.1611703-1-khazhy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108181030.1611703-1-khazhy@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-11-22 10:10:29, Khazhismel Kumykov wrote:
> This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> but woken_list_node still being hashed. This would happen when
> bfq_init_rq() expects a brand new allocated queue to be returned from
> bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> without resetting woken_list_node. Since we can always return oom_bfqq
> when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
> 
> Avoid setting woken_bfqq for oom_bfqq entirely, as it's not useful.
> 
> Crashes would have a stacktrace like:
> [160595.656560]  bfq_add_bfqq_busy+0x110/0x1ec
> [160595.661142]  bfq_add_request+0x6bc/0x980
> [160595.666602]  bfq_insert_request+0x8ec/0x1240
> [160595.671762]  bfq_insert_requests+0x58/0x9c
> [160595.676420]  blk_mq_sched_insert_request+0x11c/0x198
> [160595.682107]  blk_mq_submit_bio+0x270/0x62c
> [160595.686759]  __submit_bio_noacct_mq+0xec/0x178
> [160595.691926]  submit_bio+0x120/0x184
> [160595.695990]  ext4_mpage_readpages+0x77c/0x7c8
> [160595.701026]  ext4_readpage+0x60/0xb0
> [160595.705158]  filemap_read_page+0x54/0x114
> [160595.711961]  filemap_fault+0x228/0x5f4
> [160595.716272]  do_read_fault+0xe0/0x1f0
> [160595.720487]  do_fault+0x40/0x1c8
> 
> Tested by injecting random failures into bfq_get_queue, crashes go away
> completely.
> 
> Fixes: 8ef3fc3a043c ("block, bfq: make shared queues inherit wakers")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Looks good. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7ea427817f7f..ca04ec868c40 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6784,6 +6784,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
>  								 true, is_sync,
>  								 NULL);
> +				if (unlikely(bfqq == &bfqd->oom_bfqq))
> +					bfqq_already_existing = true;
> +			} else
> +				bfqq_already_existing = true;
> +
> +			if (!bfqq_already_existing) {
>  				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
>  				bfqq->tentative_waker_bfqq = NULL;
>  
> @@ -6797,8 +6803,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  				if (bfqq->waker_bfqq)
>  					hlist_add_head(&bfqq->woken_list_node,
>  						       &bfqq->waker_bfqq->woken_list);
> -			} else
> -				bfqq_already_existing = true;
> +			}
>  		}
>  	}
>  
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
