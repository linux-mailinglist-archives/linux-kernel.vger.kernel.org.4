Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410D60C909
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiJYJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJYJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:53:18 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063731FCF9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:49:32 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 48A6C5FD03;
        Tue, 25 Oct 2022 12:49:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1666691369;
        bh=kS9Z1X/DqIKrCZgbFlzhtfGQRkZjQf1bNgDwTuLCDyQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=kxTRYUYLCno509qT91V4EDOdRNtkesbW9Kppo1J6BV0RJkc5RT0CTg+VIOWg0GG3g
         ssETNhmchTIYD/UygOYXsZH0qqbpdaHwp5KqDGuhsu368/OLCXQ7gqBMmWBBqiIr7l
         RW722vV3/35hRVbkSNpYbu9S+g/xuzjOZ71i1WFUQf4o9XppzUjKxGwIaoDwGwkuMZ
         7fFgZJkOP8C1tYaYF051b7JDTsq0qd/NZgD6WQ1Ocx0IlLr6ykJe5aQhZjNjQXHaIQ
         mkcFzV74fOCterIS0U3BQhWJS5X0OQIsIQ0+yG1C9hI4jSCM2qqtv4A8riJrhu1j3W
         o4IZw+MmCxvSg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 25 Oct 2022 12:49:27 +0300 (MSK)
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
Thread-Index: AQHY56FoneIKBPF3rEq28K0jaPH8QK4eJ6gAgAADEgCAAIHKAA==
Date:   Tue, 25 Oct 2022 09:49:22 +0000
Message-ID: <20221025094859.7kbcqknlkmo4hj2y@cab-wsm-0029881.lan>
References: <20221024120942.13885-1-avromanov@sberdevices.ru>
 <Y1dBpLDf+mRH6cLf@google.com> <Y1dEOLjD+kpdz0Vo@google.com>
In-Reply-To: <Y1dEOLjD+kpdz0Vo@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE802CC04B39C8469BED7E24648A12FC@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/25 05:11:00 #20514016
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:04:40AM +0900, Sergey Senozhatsky wrote:
> On (22/10/25 10:53), Sergey Senozhatsky wrote:
> > > +unsigned int zs_get_class_size(struct zs_pool *pool, unsigned int si=
ze)
> > > +{
> > > +	struct size_class *class =3D pool->size_class[get_size_class_index(=
size)];
> > > +
> > > +	return class->size;
> > > +}
> > > +EXPORT_SYMBOL_GPL(zs_get_class_size);
> >=20
> > I'll kindly ask for v2. This conflicts with configurable zspage order
> > patch set which I posted last night. get_size_class_index() now takes
> > the pool parameter.
>=20
> Oh, apparently Andrew already has a fixup patch for this.

Hi! Thanks for the quick response.

Do I need to submit v2 with a fix for >=3D? Also, I forgot to=20
correct the comment on the zs_get_class_size() function:

> * Return: the size (in bytes) of the zsmalloc &size_class into which
> * the object with specified size will be inserted.

... or already inserted.

--=20
Thank you,
Alexey=
