Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57FB635350
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiKWIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKWIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:53:22 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059EC91C0B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:53:16 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E45685FD05;
        Wed, 23 Nov 2022 11:53:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669193593;
        bh=EFUj1UfeBU4lrWGe8L6tswKd0unOyhOedJJPTmNlouY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=SbRe53/WmTFlRN+ALDK4FXfRTFqIShTM4LjPVmpjwhZlUC32G4JpBTWqXpJNY7yT4
         yDaYK53NUbhvO51XbJPS/eo6jq6VKrCd4wjzd4ufhSTOZnnyI9LJpm8vPutzTna1rc
         2insrmgxK4jzUfKBEdF/7B61UyQANIxmIHBptrc3KZKQijZ6Isfssq/t5O0lhBY7Ep
         4Gw0q0g2ce0POzINaQRPaEUcyAcrGQpc4u1NHLsZWU6WXphQVq1sjX2PwZnSR9Jk8h
         +077W9Ahr+d29+md32q1FUYAFNCDzzV6ABePMITSlrNv0dUuWa1XxvsMvL3uhHIllr
         Tbh7abN8pgRAg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 23 Nov 2022 11:53:12 +0300 (MSK)
Date:   Wed, 23 Nov 2022 11:53:06 +0300
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
Message-ID: <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org>
 <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y32eA93V7w1Wu3VH@google.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/23 05:15:00 #20600357
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

Thank you for your quick and detailed support! Here is my two cents
below.

On Wed, Nov 23, 2022 at 01:13:55PM +0900, Sergey Senozhatsky wrote:
> On (22/11/22 12:14), Aleksey Romanov wrote:
> > > IIRC that was patent in question:
> > > 
> > > https://patentimages.storage.googleapis.com/e2/66/9e/0ddbfae5c182ac/US9977598.pdf
> > 
> > I think the patent is talking about "mapping the virtual address" (like
> > in KSM). But zram works with the "handle" abstraction, which is a boxed
> > pointer to the required object. I think my implementation and the patent
> > is slightly different. 
> > 
> > Also, the patent speaks of "compressing" pages. In this case, we can add
> > zs_merge() function (like zs_compact()), that is, remove the merge logic
> > at the allocator level. zsmalloc doesn't say anything about what objects
> > it can work with. Implementation at the zsmalloc level is possible,
> > though more complicated that at the zram level. 
> > 
> > I believe that we can implement at least one of the options I proposed.
> > 
> > What do you think?
> 
> Oh, yeah, I'm not saying that we cannot have something like that
> in zram/zsmalloc, just wanted to give some historical retrospective
> on this and point at some implementation details that should be
> considered.

It's a very curious situation, I would say. I'm not so familiar with US
patent law, but I suppose it should be based on some keywords and
algorithms.

If we speak in terms of algorithm Alexey patch is different a little bit
from suggested in the patent paper. If we care about keywords, I think by
moving Alexey same page merging algorithm to zsmalloc we lose
"compressing" keyword, because zsmalloc operates with "objects" only,
doesn't matter if they are compressed or not.

Anyway, could you please suggest who can help to understand if it's safe
to use such same page merging algorithm in the upstream or not?
Maybe we can ask Linux Foundation lawyers to help us, just a guess.
I'm sure we shouldn't decline helpful features and optimization without
complete certainty about all restrictions.

-- 
Thank you,
Dmitry
