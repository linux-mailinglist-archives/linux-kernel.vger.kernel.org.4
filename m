Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57773B5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFWKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFWKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:49:31 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7270E6D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:49:26 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CF7595FDBC;
        Fri, 23 Jun 2023 13:49:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687517364;
        bh=o7SjNQ7Zf16HDqlpdkyqkg/PUSUWOCHMtcBhIcmmOgA=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=P11jX83O8gNbA0Dr4PFeIxgAX0AsZHK+QVw6K0usllJ7rSokxuxvnElJtCaF4gsX8
         JqjJN9f0hXhbA5gjfxqgna4I/pmqZx92FE1VCP1zS18DeqvKxfbuesXLfBoxQiixNz
         97CmQwG6CS1Cg7HR83UptoVQDagLTywV0i+psegwvZl2Y002P60pTP1NFVUWkkHTxU
         gimafgcIIrKbcTYzcUv/rRw5Jvg24ux9/QBWmfhVdEJSs4X/It/lxn/D0Zl1O2Euwf
         JjCoIzByvm3TUlRKbF14VrlBHzEnWaiyvg4aI67PA1eoTFCrQiJ9it8Z+Z0rkPCyPX
         5AzfT5fH/JBPg==
Received: from p-i-exch-sc-m02.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 13:49:23 +0300 (MSK)
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
Thread-Index: AQHZpYzRyNUr9zsPBkK5T8L0XRRTxK+YA1KA
Date:   Fri, 23 Jun 2023 10:49:07 +0000
Message-ID: <20230623104917.2n6vcxvhvlwmjm2m@cab-wsm-0029881>
References: <20230623044016.366793-1-senozhatsky@chromium.org>
 <20230623044016.366793-2-senozhatsky@chromium.org>
In-Reply-To: <20230623044016.366793-2-senozhatsky@chromium.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10E761D8E9F63E41BB49AB9A123FFF8E@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/23 08:45:00 #21561595
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

Hello!

On Fri, Jun 23, 2023 at 01:40:01PM +0900, Sergey Senozhatsky wrote:
> zspage migration can terminate as soon as it moves the last
> allocated object from the source zspage.  Add a simple helper
> zspage_empty() that tests zspage ->inuse on each migration
> iteration.
>=20
> Suggested-by: Alexey Romanov <AVRomanov@sberdevices.ru>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3f057970504e..5d60eaedc3b7 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1147,6 +1147,11 @@ static bool zspage_full(struct size_class *class, =
struct zspage *zspage)
>  	return get_zspage_inuse(zspage) =3D=3D class->objs_per_zspage;
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
> @@ -1625,6 +1630,10 @@ static void migrate_zspage(struct zs_pool *pool, s=
truct size_class *class,
>  		obj_idx++;
>  		record_obj(handle, free_obj);
>  		obj_free(class->size, used_obj);
> +
> +		/* Stop if there are no more objects to migrate */
> +		if (zspage_empty(get_zspage(s_page)))
> +			break;
>  	}
> =20
>  	/* Remember last position in this iteration */
> --=20
> 2.41.0.162.gfafddb0af9-goog
>=20

I think we can add similar check in zs_reclaim_page() function.
There we also scan zspage to find the allocated object.

--=20
Thank you,
Alexey=
