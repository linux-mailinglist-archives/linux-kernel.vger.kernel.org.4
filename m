Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D166D08C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjAPUxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjAPUw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:52:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879A2D177
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 12:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C0461139
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA58AC433EF;
        Mon, 16 Jan 2023 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673902287;
        bh=AJywCZGTrHNvlPQqOZFoEpIXxH9k1JRffYVtm1YaUzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dKsb9xjJll0S3VIrFztTMf6JzsJ7Ev+08a1vY64cR+/JbnoOuvgOBc33DkYHcifFv
         LQ4S5Kc8US8OCrabWe9MIeL/MzUBYx4lJTZI9AqUWDFScgAhyA1eLPnBqF+97pv/Kq
         OoM3gH2f3/xRGxjULH3Aoeae2toYKYH1FFNL6px8=
Date:   Mon, 16 Jan 2023 12:51:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kuleshovmail@gmail.com>, <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] mm/mlock: return EINVAL if len overflows for
 mlock/munlock
Message-Id: <20230116125126.ed715ddf00ff4ffa2952ca29@linux-foundation.org>
In-Reply-To: <20230116115813.2956935-2-mawupeng1@huawei.com>
References: <20230116115813.2956935-1-mawupeng1@huawei.com>
        <20230116115813.2956935-2-mawupeng1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 19:58:10 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:

> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
> The return value of mlock is zero. But nothing will be locked since the
> len in do_mlock overflows to zero due to the following code in mlock:
> 
>   len = PAGE_ALIGN(len + (offset_in_page(start)));
> 
> The same problem happens in munlock.
> 
> Add new check and return -EINVAL to fix this overflowing scenarios since
> they are absolutely wrong.
> 
> ...
>
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -569,6 +569,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>  	unsigned long locked;
>  	unsigned long lock_limit;
>  	int error = -ENOMEM;
> +	size_t old_len = len;

I'm not sure that "old_len" is a good identifier.  It reads to me like
"the length of the old mlocked region" or something.

I really don't like it when functions modify the values of the incoming
argument like this.  It would be better to leave `len' alone and create
a new_len or something.

>  	start = untagged_addr(start);
>  
> @@ -578,6 +579,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
>  	len = PAGE_ALIGN(len + (offset_in_page(start)));
>  	start &= PAGE_MASK;
>  
> +	if (old_len != 0 && len == 0)
> +		return -EINVAL;

It would be clearer to do this immediately after calculating the new
value of `len'.  Before going on to play with `start'.

Can we do something like this?

--- a/mm/mlock.c~a
+++ a/mm/mlock.c
@@ -575,7 +575,12 @@ static __must_check int do_mlock(unsigne
 	if (!can_do_mlock())
 		return -EPERM;
 
-	len = PAGE_ALIGN(len + (offset_in_page(start)));
+	if (len) {
+		len = PAGE_ALIGN(len + (offset_in_page(start)));
+		if (len == 0)	/* overflow */
+			return -EINVAL;
+	}
+
 	start &= PAGE_MASK;
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
_

That depends on how we handle len==0.  afaict, mlock(len==0) will
presently burn a bunch of cpu cycles (not that we want to optimize this
case), do nothing then return 0?

