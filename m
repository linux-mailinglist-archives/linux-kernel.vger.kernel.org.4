Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9F60CCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiJYNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiJYM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:59:43 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DCA814C0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:56:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E9A215FD03;
        Tue, 25 Oct 2022 15:56:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1666702576;
        bh=FDJLYQVfAPEsI0KUWAF0tnbcOsSG/a/B7l7gy81zlRw=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=kMEA9K2eETrHcb7Da6vTw6wVBOBB4pY05MByklWuZiBAUiUZBe1zUZh22BtTR3Ofv
         w50FKjcyMJg329cOBpdaL/o0DCkpCecw52Hk93cDGlumMt3X79VeYmRg8gkZfttoJX
         kgO1LeX1itpA/g58WLW19+tTuELNF1tNqYmACuv6d1Qea9kpEiBQTw2ynX2HdHhLWy
         +lSulN6Ii3xNNswe4KGRnH25i+r/sQeBuS7g2tkrVmpqNQ8h3p5cCxfCWBAn/E22BH
         zU9eaqZheqIuVis1ECUda/9JZKTFHn0cxTJGHdNystPpXaGKL6UZW3BWW6OwqbUrsk
         rPzCbT2aiFFpQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Oct 2022 15:56:14 +0300 (MSK)
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
Thread-Index: AQHY56FoneIKBPF3rEq28K0jaPH8QK4eJ6gAgAADEgCAAIHKAIAABYEAgAAd1wCAAAvXAIAABQuA
Date:   Tue, 25 Oct 2022 12:56:08 +0000
Message-ID: <20221025125542.wenx6m624wu4vuxf@cab-wsm-0029881.lan>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com> <Y1dEOLjD+kpdz0Vo@google.com>
 <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
 <Y1e1tvMMXU5+8JQP@google.com>
 <20221025115542.5o4igroslirn6cxy@cab-wsm-0029881.lan>
 <Y1fYrM3o2ZudjZ/7@google.com>
In-Reply-To: <Y1fYrM3o2ZudjZ/7@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C30060D7AD67DC41BC57008DEC2AC97D@sberdevices.ru>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:38:04PM +0900, Sergey Senozhatsky wrote:
> On (22/10/25 11:55), Aleksey Romanov wrote:
> > >   Return: the index of the zsmalloc &size_class that hold objects of =
the
> > >   provided size.
> > >=20
> > > unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int=
 size)
> > > {
> > >         struct size_class *class =3D pool->size_class[get_size_class_=
index(size)];
> > >=20
> > >         return class->index;
> > > }
> >=20
> > Sure. I think it would be more logical, and perhaps such a function
> > would be more applicable in other cases, in the future.
> >=20
> > Will you fix it in your cherry-pick?
>=20
> For that I probably will ask you to send out v2, if possible.

Okay, I will send v2 soon.

--=20
Thank you,
Alexey=
