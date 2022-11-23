Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2B635480
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiKWJIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiKWJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:07:44 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22418634E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:07:43 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 58CFE5FD05;
        Wed, 23 Nov 2022 12:07:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669194461;
        bh=xF2LqQnAmt9x2NwV89/RQYiuJ8szJL/yCkefPCbEAkg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=dTX0CzUQjFUGbZD15aRoquNKkkaEASXHDIVpsmg6jI7nmBLLH0kg+LovniGLl+af0
         xNFv1aHqOqU3TEoibDolerwkyGmyJ7HD7gk8HkkPZo4XZrWlIjaRW8IQEftWNax9hM
         lzJ3Oeu8WgUigSi8xmZxnslXqn5eDWeftQpJxnb6GRrq+WUHAiSL4jwb413iCEwGiq
         cyrhG+24QjmX02wVEin+VepOi0DxWI04D9AXc/btHWvOGmxT3SeVgJ+arEEKsH8ete
         UHJLn73CAn2BVCdJi64BRK1MW5/jprQTiYnz0zLnfqYDZur/hTP9kTpO4Zv+c8O8kp
         DqOA4Fsdjp+rA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 23 Nov 2022 12:07:41 +0300 (MSK)
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
Thread-Index: AQHY/duSaivivX4eVEi4n5R4teXteK5JpjKAgABo/ACAAAH8AIAAmLKAgAEMI4CAAFIJAA==
Date:   Wed, 23 Nov 2022 09:07:40 +0000
Message-ID: <20221123090732.7aktww2jk6axdrld@cab-wsm-0029881.lan>
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org> <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com>
 <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com>
In-Reply-To: <Y32eA93V7w1Wu3VH@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2068E6DE403ECC48BB19CC683B9416B6@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

On Wed, Nov 23, 2022 at 01:13:55PM +0900, Sergey Senozhatsky wrote:
> On (22/11/22 12:14), Aleksey Romanov wrote:
> > > IIRC that was patent in question:
> > >=20
> > > https://patentimages.storage.googleapis.com/e2/66/9e/0ddbfae5c182ac/U=
S9977598.pdf
> >=20
> > I think the patent is talking about "mapping the virtual address" (like
> > in KSM). But zram works with the "handle" abstraction, which is a boxed
> > pointer to the required object. I think my implementation and the paten=
t
> > is slightly different.=20
> >=20
> > Also, the patent speaks of "compressing" pages. In this case, we can ad=
d
> > zs_merge() function (like zs_compact()), that is, remove the merge logi=
c
> > at the allocator level. zsmalloc doesn't say anything about what object=
s
> > it can work with. Implementation at the zsmalloc level is possible,
> > though more complicated that at the zram level.=20
> >=20
> > I believe that we can implement at least one of the options I proposed.
> >=20
> > What do you think?
>=20
> Oh, yeah, I'm not saying that we cannot have something like that
> in zram/zsmalloc, just wanted to give some historical retrospective
> on this and point at some implementation details that should be
> considered.

Okay, in this case, can you review my patches please?

--=20
Thank you,
Alexey=
