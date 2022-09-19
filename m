Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6ED5BD649
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiISVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiISVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A7447B95;
        Mon, 19 Sep 2022 14:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFFA611DB;
        Mon, 19 Sep 2022 21:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CBAC433C1;
        Mon, 19 Sep 2022 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663622539;
        bh=fbxWbYcpv+Xlpl8GPsmdhWofyWA7VUTSh+HjIQ+CX1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gnu9OWbfuDKxIm0HYMi2CpJTSuEA1gnX80dzv6AReiFMamFnchNTCwRHsh62BvkCT
         MgClcADZHWmggQoTEmKSnZWXtn3bb6St88FtjRHdVlhmwmur9uwylRLLnPuu0C8rb8
         ZUlL7MkZdKRVWHiMQZr1piFBIQbAATMwb9VR65QnpoPHGx1AW0VxzP2wXYIIvso+qA
         0Vk6kphseY76zKW97nlEjQ9335Fm57LcAeA7PNhSaMJ2GO8TaZpBmU5+CvKs9nK7p3
         wbtY3or7u4L5tJzpL7g16psODevZCqdiV09HeuspaVB/+Hg6QEgC+4AHsngBA57qpd
         Tf0mXxjdgM5eg==
Date:   Mon, 19 Sep 2022 15:22:16 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
        Jan Kara <jack@suse.cz>, Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <YyjdiKC0YYUkI+AI@kbusch-mbp>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 02:10:51PM -0700, Hugh Dickins wrote:
> I have almost no grasp of all the possible sbitmap races, and their
> consequences: but using the same !waitqueue_active() check as used
> elsewhere, fixes the lockup and shows no adverse consequence for me.

 
> Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  lib/sbitmap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
>  		 * function again to wakeup a new batch on a different 'ws'.
>  		 */
>  		if (cur == 0)
> -			return true;
> +			return !waitqueue_active(&ws->wait);

If it's 0, that is supposed to mean another thread is about to make it not zero
as well as increment the wakestate index. That should be happening after patch
48c033314f37 was included, at least.

Prior to 4acb83417cad, the code would also return 'true' if the count was
already zero, and this batched code wasn't supposed to behave any different in
that condition.

Anyway, I don't think the waitqueue_active criteria of the current waitstate is
correct either. The next waitstate may have waiters too, so we still may need
to account for this batch's count in order to wake them.
