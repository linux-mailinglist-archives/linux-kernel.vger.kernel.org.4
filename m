Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82B633C32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiKVMOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiKVMO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:14:29 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167512A8A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:14:24 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A5DD65FD11;
        Tue, 22 Nov 2022 15:14:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669119261;
        bh=QsZAzuI9qBQHnlaxynSPsWNk5m9eu8gwQdPWrQGY0OI=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=pQjf9JAdqM4OgHzn+B5B9bAW63aFd1bKK54xEfxZiFwe5ClZhIrmS+ERR77j3d5gH
         q8JFNNSC7JnVz2SAcRBPnZzYKAdNrMjC14SRRJ7WlOYQFyLE12yXiKKDXWNAkouzzd
         UZmEndhKwc+Ne/4WMTbyw3bVrAQ/y2/S2gZJFY6SOqPRP+iPMSlpNcLpOIGUI4tgsV
         aoaj7Lm/oqyPFdsNDCs8spmR5GtU7TC2BcD1uZqg6kRCI2H9RSAHmhGhPiA8TJc2Rn
         La4w6eb+xq/Rcp6PY9YFJ7aW6Ct23tBMGTu70VNQp3l6gvUzssJRwlRgNF+pRkevbe
         VQS00m0DaIJog==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 22 Nov 2022 15:14:19 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "Dmitry Rokosov" <DDRokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Thread-Topic: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
Thread-Index: AQHY/duSaivivX4eVEi4n5R4teXteK5JpjKAgABo/ACAAAH8AIAAmLKA
Date:   Tue, 22 Nov 2022 12:14:19 +0000
Message-ID: <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org> <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
In-Reply-To: <Y3w8/q/HoSbqamoD@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FF7E9E2A2A16F438D29FD93C6512969@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/22 08:14:00 #20597802
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Nov 22, 2022 at 12:07:42PM +0900, Sergey Senozhatsky wrote:
> On (22/11/22 12:00), Sergey Senozhatsky wrote:
> > On (22/11/21 15:44), Johannes Weiner wrote:
> > > This looks pretty great.
> > >=20
> > > However, I'm curious why it's specific to zram, and not part of
> > > zsmalloc? That way zswap would benefit as well, without having to
> > > duplicate the implementation. This happened for example with
> > > page_same_filled() and zswap_is_page_same_filled().
> > >=20
> > > It's zsmalloc's job to store content efficiently, so couldn't this
> > > feature (just like the page_same_filled one) be an optimization that
> > > zsmalloc does transparently for all its users?
> >=20
> > Yea, that's a much needed functionality, but things may be "complicated=
".
> > We had that KSM-ish thing in the past in zram. Very briefly as we quick=
ly
> > found out that the idea was patented by some company in China and we co=
uldn't
> > figure our if it was safe to land that code upstream. So we ended up dr=
opping
> > the patches.
> >=20
> > https://lore.kernel.org/lkml/1494556204-25796-1-git-send-email-iamjoons=
oo.kim@lge.com/
>=20
> IIRC that was patent in question:
>=20
> https://patentimages.storage.googleapis.com/e2/66/9e/0ddbfae5c182ac/US997=
7598.pdf

I think the patent is talking about "mapping the virtual address" (like
in KSM). But zram works with the "handle" abstraction, which is a boxed
pointer to the required object. I think my implementation and the patent
is slightly different.=20

Also, the patent speaks of "compressing" pages. In this case, we can add
zs_merge() function (like zs_compact()), that is, remove the merge logic
at the allocator level. zsmalloc doesn't say anything about what objects
it can work with. Implementation at the zsmalloc level is possible,
though more complicated that at the zram level.=20

I believe that we can implement at least one of the options I proposed.

What do you think?

--=20
Thank you,
Alexey=
