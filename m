Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC32738580
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjFUNlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUNlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:41:47 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6A1998
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:41:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 41B655FD90;
        Wed, 21 Jun 2023 16:41:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687354897;
        bh=oF9EC/59syy+imHfhHbD4ox01r0Kl3E+5auyHknGjvg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=Wi2tbOxsocBljiyT5yJODzCEG6fBVirWEvBFH7jU/zPG/4U2fLASaV0ATX3ycxQJ2
         KdtPQmvYYLtzlvaHZ5qq7VRWJzOJYv9RQaU9JZdps0MqRv3wsVCELNHh/El0ftqfRc
         1Jm27xrVYar0fLrIRoxLT5rnsdWBcovXQCzCiX64wM+m37sbKhQDrKTNo1VQfxP1yo
         jTDJllGCKWNT1NiugR/2DHyIAx8HvBIIDIkuDIpOyT+bES/ZPMPbxkTSu0A6pYZEoz
         JI2D8E3+Q1QbVISmymSzzl1vtM++DDBTWSUbc6v75RFqUW58aqg7RdfdhvtnioNiym
         LfQ21CDZTrkSQ==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 21 Jun 2023 16:41:36 +0300 (MSK)
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
Thread-Index: AQHZortECyHNmKOx4kiy6hdprH0m0a+TTmOAgAALNICAAbQNAIAABsUA
Date:   Wed, 21 Jun 2023 13:41:34 +0000
Message-ID: <20230621134130.tm2oucg5eskelwzr@cab-wsm-0029881>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
 <20230620103629.GA42985@google.com>
 <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
 <20230621131716.GC2934656@google.com>
In-Reply-To: <20230621131716.GC2934656@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92FD89CDCBE3784D961EF788F2599752@sberdevices.ru>
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

Hi!

On Wed, Jun 21, 2023 at 10:17:16PM +0900, Sergey Senozhatsky wrote:
> On (23/06/20 11:16), Alexey Romanov wrote:
> > If sizeof(unsigned int) >=3D 32 bits the this will be enough for us.=20
> > Of course, in rare cases this will not be the case. But it seems that
> > zram and kernel already has similiar places. For example, if page size
> > is 256 Kb and sizeof(unsigned int) =3D 16 bits (2 byte), zram will not
> > wotk on such system, because we can't store offset. But such case is
> > very rare, most systems have unsigned int over 32 bits.=20
> >=20
> > Therefore, I think that my idea is still applicable, we just need to
> > change the counter type. What do you think?
>=20
> My gut feeling is that we better avoid mixing in architecture specific
> magic into generic code. It works fine until it doesn't. May be Minchan
> will have a different opinion tho.
>=20
> There can be other ways to avoid linear scan of empty sub-pages. For
> instance, something like below probably can cover less cases than your
> patch 0002, but on the other hand is rather generic, trivial and doesn't
> contain any assumptions on the architecture specifics.
>=20
> (composed/edited in mail client, so likely is broken, but outlines
>  the idea)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> mm/zsmalloc: do not scan empty zspages
>=20
> We already stop zspage migration when we detect that target
> zspage has no space left for any new objects. There is
> one more thing we can do in order to avoid doing useless
> work: stop scanning for allocated objects in sub-pages when
> we have migrated the last inuse object from the zspage in
> question.
>=20
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 02f7f414aade..2875152e6497 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1263,6 +1263,11 @@ static bool zspage_full(struct size_class *class, =
struct zspage *zspage)
>         return get_zspage_inuse(zspage) =3D=3D class->objs_per_zspage;
>  }
> =20
> +static bool zspage_empty(struct zspage *zspage)
> +{
> +	return get_zspage_inuse(zspage) =3D=3D 0;
> +}
> +
>  /**
>   * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
>   * that hold objects of the provided size.
> @@ -1787,6 +1792,10 @@ static void migrate_zspage(struct zs_pool *pool, s=
truct size_class *class,
>  		obj_idx++;
>  		record_obj(handle, free_obj);
>  		obj_free(class->size, used_obj, NULL);
> +
> +		/* Stop if there are no more objects to migrate */
> +		if (zspage_empty(get_zspage(s_page)))
> +			break;
>  	}

Yes it seems my version is not as good as I thought. Looks bad for an
architecturally dependent PAGE_SIZE.

Your version sounds good. In general, I can implement this option. I'll
test this and send patch this week.

--=20
Thank you,
Alexey=
