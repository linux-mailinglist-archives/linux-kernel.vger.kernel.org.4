Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9773960CB52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiJYL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJYL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:56:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425921C109
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:56:02 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1B31A5FD05;
        Tue, 25 Oct 2022 14:55:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1666698959;
        bh=WPnpYPQkgBzWbd/TOkdLi2NUtbsya4FpNFvnUymmR3I=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=CCRRQSA7oRn0GA299GT47cMNieOAmEs2JOYGFf5Kr6+sN4QrxdpdbdUQPAxndBmX4
         H04OJndsdEnCARCEGSucy8MJBqW1vModgHgsP+1rV7qW74VRCLkNQ2J9tFMFu3dhfJ
         YFNmuLTARi117RB3gU/0iyZ5N382zYCcD6gfuDkaEao1Rnj9g/LkQ0s4AWFR1vmARC
         AgsqjwyTewQPoCMF/NDAAvvM81zy8XEyam/uy4tC7DoOk8BR5yYJfSkp5njqBwP7NY
         j6rbpetFCUt3i6Z+GL1iHe+BMupVHXjIszJnv8093aDSq5xz/V8oc/ih6gwigGx36p
         irfuH/jmr5Elg==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Oct 2022 14:55:57 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] zram: add size class equals check into recompression
Thread-Topic: [PATCH v1] zram: add size class equals check into recompression
Thread-Index: AQHY56FoneIKBPF3rEq28K0jaPH8QK4eJ6gAgAADEgCAAIHKAIAABYEAgAAd1wA=
Date:   Tue, 25 Oct 2022 11:55:51 +0000
Message-ID: <20221025115542.5o4igroslirn6cxy@cab-wsm-0029881.lan>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com> <Y1dEOLjD+kpdz0Vo@google.com>
 <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
 <Y1e1tvMMXU5+8JQP@google.com>
In-Reply-To: <Y1e1tvMMXU5+8JQP@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01B5ABE957561B48AAA2754E64A57C61@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/25 10:18:00 #20514748
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:08:54PM +0900, Sergey Senozhatsky wrote:
> On (22/10/25 09:49), Aleksey Romanov wrote:
> > On Tue, Oct 25, 2022 at 11:04:40AM +0900, Sergey Senozhatsky wrote:
> > > On (22/10/25 10:53), Sergey Senozhatsky wrote:
> > > > > +unsigned int zs_get_class_size(struct zs_pool *pool, unsigned in=
t size)
> > > > > +{
> > > > > +	struct size_class *class =3D pool->size_class[get_size_class_in=
dex(size)];
> > > > > +
> > > > > +	return class->size;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(zs_get_class_size);
>=20
> I wonder if we want to return class->index instead of class->size?
>=20
> Something like this (a sketch)
>=20
>   Return: the index of the zsmalloc &size_class that hold objects of the
>   provided size.
>=20
> unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int siz=
e)
> {
>         struct size_class *class =3D pool->size_class[get_size_class_inde=
x(size)];
>=20
>         return class->index;
> }

Sure. I think it would be more logical, and perhaps such a function
would be more applicable in other cases, in the future.

Will you fix it in your cherry-pick?

--=20
Thank you,
Alexey=
