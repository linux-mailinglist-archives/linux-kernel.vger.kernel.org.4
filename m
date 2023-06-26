Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0274B73DC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjFZKzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjFZKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:55:46 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C265E71
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:55:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 4021D5FD4C;
        Mon, 26 Jun 2023 13:55:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687776932;
        bh=Oj0jQJqn0/SSlMSn7VZZswEl1ygxBArda/MM4uN63bs=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=l8g7TSI2bUm0sw1P7t+HRsUqwxH9GzxJuUOSsTq5t2n41whQDH5MpGrSkZAGfGwAO
         Fzmca+dQ+1WpgCax6PHhBHvj/exdATOu38L8Xvk/eMN2GkPojbwapAbuZdoznPQLrF
         q93taIZKuv/1UKUGiJSK3EN2HnBgMKIBhd4VSbYrtOaff7oEr1HwE1xM9AyOfeq3YP
         Xi67j4dDJ5TEs7WUD3oc4KLd8fqrWc3LWZ6thH14KW8BNX4ap66wMMrs52Y0RNS61L
         9Mxrt43cp2lKmXaHvvaCN1XkTfpFykcqjGyy4J4nl70bJoMJJWb7IChbG2l9a0PPCt
         ogMgfrvLEyZ5g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 26 Jun 2023 13:55:30 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zsmalloc: do not scan for allocated objects in empty
 zspage
Thread-Topic: [PATCH 1/2] zsmalloc: do not scan for allocated objects in empty
 zspage
Thread-Index: AQHZpYzRyNUr9zsPBkK5T8L0XRRTxK+YA1KAgAEGooCAA7ITgA==
Date:   Mon, 26 Jun 2023 10:54:50 +0000
Message-ID: <20230626105502.kqjrgtrvwp4ro3vu@cab-wsm-0029881>
References: <20230623044016.366793-1-senozhatsky@chromium.org>
 <20230623044016.366793-2-senozhatsky@chromium.org>
 <20230623104917.2n6vcxvhvlwmjm2m@cab-wsm-0029881>
 <20230624022917.GF2934656@google.com>
In-Reply-To: <20230624022917.GF2934656@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2198C4204FD0134A9CBF6183F56DC4C3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/26 05:54:00 #21579740
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 11:29:17AM +0900, Sergey Senozhatsky wrote:
> On (23/06/23 10:49), Alexey Romanov wrote:
> > > +static bool zspage_empty(struct zspage *zspage)
> > > +{
> > > +	return get_zspage_inuse(zspage) =3D=3D 0;
> > > +}
> > > +
> > >  /**
> > >   * zs_lookup_class_index() - Returns index of the zsmalloc &size_cla=
ss
> > >   * that hold objects of the provided size.
> > > @@ -1625,6 +1630,10 @@ static void migrate_zspage(struct zs_pool *poo=
l, struct size_class *class,
> > >  		obj_idx++;
> > >  		record_obj(handle, free_obj);
> > >  		obj_free(class->size, used_obj);
> > > +
> > > +		/* Stop if there are no more objects to migrate */
> > > +		if (zspage_empty(get_zspage(s_page)))
> > > +			break;
> > >  	}
> > > =20
> > >  	/* Remember last position in this iteration */
> > > --=20
> > > 2.41.0.162.gfafddb0af9-goog
> > >=20
> >=20
> > I think we can add similar check in zs_reclaim_page() function.
> > There we also scan zspage to find the allocated object.
>=20
> LRU was moved to zswap, so zs_reclaim_page() doesn't exist any longer
> (in linux-next).

Yeah, sorry. Just looking in current linux master.

--=20
Thank you,
Alexey=
