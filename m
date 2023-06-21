Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06699738604
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjFUOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjFUOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:00:26 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2041BF5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:59:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id DDDB65FD89;
        Wed, 21 Jun 2023 16:59:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687355984;
        bh=zWFbewBe5gfGgxwvybbxWY3tmBMH88HB0q4OqowM55g=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=REuh7nlI6eKQgPgchgREMfasK9VVxf4ZLeudY6Tp9LHidWn1d+qtZljMcxlveqXD1
         dmPZp4MR/YKBuNtXtGpk06GCX0YfvrpUomIO5T4/z0nrCYKQLH8kmfy6snssQIbT1r
         crSzOAJ7yFB4VY2j7Cuc+sadc9rrNDGxWpD611oD84NyhfonYPunHf2IWR8QPGimLy
         3oj9PFa5fkkeXRRHbZSPOCR7OZRq91ijgfzESIcNP/pe3qwmFuMN8I+easwEMbJDLl
         iWqmyVcICjmwu173iFRTPG+wwwl+awe4o65tvW/2j1zkdCv6aNoGMqd30WnWWkkj86
         tQNyYZrI85Uxg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 21 Jun 2023 16:59:44 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Minchan Kim <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Thread-Topic: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Thread-Index: AQHZortECyHNmKOx4kiy6hdprH0m0a+TTmOAgAALNICAAbQNAIAABsUAgAAD2wCAAAE2AA==
Date:   Wed, 21 Jun 2023 13:59:43 +0000
Message-ID: <20230621135938.outx6qezuholc3hy@cab-wsm-0029881>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
 <20230620103629.GA42985@google.com>
 <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
 <20230621131716.GC2934656@google.com>
 <20230621134130.tm2oucg5eskelwzr@cab-wsm-0029881>
 <20230621135518.GD2934656@google.com>
In-Reply-To: <20230621135518.GD2934656@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F62146241E180D478EB8590748B8D9E3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/21 11:37:00 #21545586
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:55:18PM +0900, Sergey Senozhatsky wrote:
> On (23/06/21 13:41), Alexey Romanov wrote:
> [..]
> > > +static bool zspage_empty(struct zspage *zspage)
> > > +{
> > > +	return get_zspage_inuse(zspage) =3D=3D 0;
> > > +}
> > > +
> > >  /**
> > >   * zs_lookup_class_index() - Returns index of the zsmalloc &size_cla=
ss
> > >   * that hold objects of the provided size.
> > > @@ -1787,6 +1792,10 @@ static void migrate_zspage(struct zs_pool *poo=
l, struct size_class *class,
> > >  		obj_idx++;
> > >  		record_obj(handle, free_obj);
> > >  		obj_free(class->size, used_obj, NULL);
> > > +
> > > +		/* Stop if there are no more objects to migrate */
> > > +		if (zspage_empty(get_zspage(s_page)))
> > > +			break;
> > >  	}
> >=20
> > Yes it seems my version is not as good as I thought. Looks bad for an
> > architecturally dependent PAGE_SIZE. [..]
>=20
> Well, we are looking for a solution that is both reasonable (perf wise)
> and is maintainable.
>=20
> > I can implement this option. I'll test this and send patch this week.
>=20
> Either that or, if Suggested-by: Alexey Romanov <AVRomanov@sberdevices.ru=
>
> is good enough for you, then I can send a series tonight or tomorrow (aft=
er
> some testing). I have two more patches on top of that one.

Yeah, Suggested-by is OK. Let's send a patch. Thank you.

--=20
Thank you,
Alexey=
