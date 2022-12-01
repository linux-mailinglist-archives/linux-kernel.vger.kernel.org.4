Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2763ED64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAKOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLAKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:14:34 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A0920AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:14:28 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A10285FD07;
        Thu,  1 Dec 2022 13:14:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669889664;
        bh=wl7vBDIsPjcpk2GTYMr4D53WkGXWEKQGydGiDJhgcJ4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=ZlAKr8tr87vLzNtu9IoGhy7OJeYNjwXj674qCLXgQajfS+7NrmpXt6IoDaKl0EhPc
         n/XNytEia+Mx+doFKxevtGGfFgGWv7nZpK3V7iOxi5cd53PXoee7CiBDTE9aSaSyAZ
         9XaQVdTr/2LGOovlyPWNeWlF55lHlVqFb6CrgHl1oDVyXEuvi/RZxefiihtLR+fAO2
         iTZdDXwC4umABxJMGf5L7EE5yfX9coIyrJdz0Ha+lBNSJ5PkH4Ne/VqssI9+xuagx1
         bv+vsg/G95WS3gTZPzf1ScbYWUwJ2ZQN+ve1kG/uPyTRHmbywWTrtdWiMN0qyIo09Y
         iOs1kNteadEaQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Dec 2022 13:14:23 +0300 (MSK)
Date:   Thu, 1 Dec 2022 13:14:17 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Aleksey Romanov <AVRomanov@sberdevices.ru>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Message-ID: <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
 <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 00:48:00 #20630840
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,LOTS_OF_MONEY,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

Hope you are doing well. Really sorry for the ping.

Did you get a chance to see the patch series, my questions, and
thoughts?

On Wed, Nov 23, 2022 at 11:53:06AM +0300, Dmitry Rokosov wrote:
> Hello Sergey,
> 
> Thank you for your quick and detailed support! Here is my two cents
> below.
> 
> On Wed, Nov 23, 2022 at 01:13:55PM +0900, Sergey Senozhatsky wrote:
> > On (22/11/22 12:14), Aleksey Romanov wrote:
> > > > IIRC that was patent in question:
> > > > 
> > > > https://patentimages.storage.googleapis.com/e2/66/9e/0ddbfae5c182ac/US9977598.pdf
> > > 
> > > I think the patent is talking about "mapping the virtual address" (like
> > > in KSM). But zram works with the "handle" abstraction, which is a boxed
> > > pointer to the required object. I think my implementation and the patent
> > > is slightly different. 
> > > 
> > > Also, the patent speaks of "compressing" pages. In this case, we can add
> > > zs_merge() function (like zs_compact()), that is, remove the merge logic
> > > at the allocator level. zsmalloc doesn't say anything about what objects
> > > it can work with. Implementation at the zsmalloc level is possible,
> > > though more complicated that at the zram level. 
> > > 
> > > I believe that we can implement at least one of the options I proposed.
> > > 
> > > What do you think?
> > 
> > Oh, yeah, I'm not saying that we cannot have something like that
> > in zram/zsmalloc, just wanted to give some historical retrospective
> > on this and point at some implementation details that should be
> > considered.
> 
> It's a very curious situation, I would say. I'm not so familiar with US
> patent law, but I suppose it should be based on some keywords and
> algorithms.
> 
> If we speak in terms of algorithm Alexey patch is different a little bit
> from suggested in the patent paper. If we care about keywords, I think by
> moving Alexey same page merging algorithm to zsmalloc we lose
> "compressing" keyword, because zsmalloc operates with "objects" only,
> doesn't matter if they are compressed or not.
> 
> Anyway, could you please suggest who can help to understand if it's safe
> to use such same page merging algorithm in the upstream or not?
> Maybe we can ask Linux Foundation lawyers to help us, just a guess.
> I'm sure we shouldn't decline helpful features and optimization without
> complete certainty about all restrictions.

-- 
Thank you,
Dmitry
