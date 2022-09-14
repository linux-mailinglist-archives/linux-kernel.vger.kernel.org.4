Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048035B909C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiINWvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiINWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:51:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15837823D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5E1B8125A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 22:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09A7C433C1;
        Wed, 14 Sep 2022 22:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663195903;
        bh=wJhU+7BFoQR8B41LdXid8aho7nAH+Au1OFPhdMiF+IQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1fGFwzB+QZmC43IuwyQHTJ7LV9Hm8QZVDFIHX+IIyYDHoI3rD8mAintXcfZ2iPpTO
         TSneBTeL8XVVxmNpsVQ1Wpkjsa5CudvPSYe86yvZoiLAWENX+WrsCVxkYp0aBtzyR0
         GoYnA71YUw6dMeqb2FsbtD5ogjGcQhAfVczGqBDg=
Date:   Wed, 14 Sep 2022 15:51:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
Message-Id: <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
In-Reply-To: <20220914023318.549118-1-zhanghongchen@loongson.cn>
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 10:33:18 +0800 Hongchen Zhang <zhanghongchen@loongson.cn> wrote:

> when a process falls into page fault and there is not enough free
> memory,it will do direct reclaim. At the same time,it is holding
> mmap_lock.So in case of multi-thread,it should exit from page fault
> ASAP.
> When reclaim memory,we do scan adjust between anon and file lru which
> may cost too much time and trigger hung task for other thread.So for a
> process which is not kswapd,it should just do a little scan adjust.

Well, that's a pretty nasty bug.  Before diving into a possible fix,
can you please tell us more about how this happens?  What sort of
machine, what sort of workload.  Can you suggest why others are not
experiencing this?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3042,11 +3042,17 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  		nr[lru] = targets[lru] * (100 - percentage) / 100;
>  		nr[lru] -= min(nr[lru], nr_scanned);
>  
> +		if (!current_is_kswapd())
> +			nr[lru] = min(nr[lru], nr_to_reclaim);
> +
>  		lru += LRU_ACTIVE;
>  		nr_scanned = targets[lru] - nr[lru];
>  		nr[lru] = targets[lru] * (100 - percentage) / 100;
>  		nr[lru] -= min(nr[lru], nr_scanned);
>  
> +		if (!current_is_kswapd())
> +			nr[lru] = min(nr[lru], nr_to_reclaim);
> +
>  		scan_adjusted = true;
>  	}
>  	blk_finish_plug(&plug);

It would be better if these additions had code comments explaining why
they're there.  But let's more fully understand the problem before
altering your patch.

