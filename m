Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEE065BDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjACKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjACKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:20:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF060B1D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:20:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1AF611A4;
        Tue,  3 Jan 2023 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672741204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WxwzilripMrMET7cDXrClsfcZECAT4drpWNCobXQpAM=;
        b=an+tYDRSWJI67+lk8LBlngSSuYmwlz1zLTlFZ+NtuMAWAQVrizDo+RMIK8n+eBkeBovvji
        5WJrajd2OQk8VXCFgdUQaKQFC3OCbtHr63ckwqYFI1+eFmvQo6nOVfkrzjGpDQ+RG9Hz39
        zugmIkR4dVaxvCffsrqMij1BLrycVgE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 506C11392B;
        Tue,  3 Jan 2023 10:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t1SmElQBtGM7PwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Jan 2023 10:20:04 +0000
Date:   Tue, 3 Jan 2023 11:20:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: (2) [PATCH] page_alloc: avoid the negative free for meminfo
 available
Message-ID: <Y7QBUx0Ds9SrzK9g@dhcp22.suse.cz>
References: <Y7PoBkLyCaH1KHbB@dhcp22.suse.cz>
 <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
 <20230103072807.19578-1-jaewon31.kim@samsung.com>
 <20230103082008epcms1p6f75b54cbfeba0a1ab9a8044dc650134b@epcms1p6>
 <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcms1p7>
 <20230103092232epcms1p7f2df94d75fc1b6f11ee986a3a1aa1900@epcms1p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103092232epcms1p7f2df94d75fc1b6f11ee986a3a1aa1900@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-01-23 18:22:32, 김재원 wrote:
> >> >On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
> >> >> The totalreserve_pages could be higher than the free because of
> >> >> watermark high or watermark boost. Handle this situation and fix it to 0
> >> >> free size.
> >> >
> >> >What is the actual problem you are trying to address by this change?
> >> 
> >> Hello
> >> 
> >> As described on the original commit,
> >>   34e431b0ae39 /proc/meminfo: provide estimated available memory
> >> mm is tring to provide the avaiable memory to user space.
> >> 
> >> But if free is negative, the available memory shown to userspace
> >> would be shown smaller thatn the actual available size. The userspace
> >> may do unwanted memory shrinking actions like process kills.
> >
> >Do you have any specific example? Have you seen this happening in
> >practice or is this based on the code inspection?
> 
> I found this from a device using v5.10 based kernel.
> Actually the log was printed by user space in its format after reading /proc/meminfo.
> 
> MemFree          38220 KB
> MemAvailable     90008 KB
> Active(file)    137116 KB
> Inactive(file)  124128 KB
> SReclaimable    100960 KB
> 
> Here's /proc/zoneinfo for wmark info.
> 
> ------ ZONEINFO (/proc/zoneinfo) ------
> Node 0, zone    DMA32
>   pages free     17059
>         min      862
>         low      9790
>         high     18718
>         spanned  524288
>         present  497920
>         managed  413348
> Node 0, zone   Normal
>   pages free     12795
>         min      1044
>         low      11855
>         high     22666
>         spanned  8388608
>         present  524288
>         managed  500548
> 
> The pagecache at this time, seems to be 174,664 KB.
>   pagecache -= min(pagecache / 2, wmark_low)
> We also need to add the reclaimable and the actual free on it to be MemAvaiable.
> 
> The MemAvailable should be bigger at leat this 174,664 KB, but it was 90,008 KB only
> because the big wmark high 165,536 seems to be used.

How have you concluded that? Are you saying that a userspace would be
behaving more sanely when considering more memory to be available?
Please see more on the semantics below.

> >Also does this patch actually fix anything? Say the system is really
> >struggling and we are under min watermark. Shouldn't that lead to
> >Available to be reported as 0 without even looking at other counters?
> >
> 
> Sorry but I did not understand,

What I meant here is that the core of the high level definition says:
"An estimate of how much memory is available for starting new
applications, without swapping." If the system is close enough to watermarks 
that NR_FREE_PAGES < reserves then it is likely that further memory
allocations will not do without reclaim and potentially swapout.

So the question really is whether just clamping the value to 0 is
actually making MemAvailable more "correct"? See my point?

The actual value is never going to be lazer cut precise. Close to
watermark behavior will vary wildly depending on the memory
reclaimability. Kswapd might easily keep up with memory demand but it
also could get stuck. MemAvailable should be considered a hint rather
than an exact value IMHO.
-- 
Michal Hocko
SUSE Labs
