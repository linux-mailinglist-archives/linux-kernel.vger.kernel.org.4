Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A573DC94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFZK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFZK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:57:59 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66D8F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:57:57 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 086765FD4C;
        Mon, 26 Jun 2023 13:57:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687777076;
        bh=tF8tjj7sdIyMXAlJ3nUVa6bWrMEF1krZs+eU62ZwWlM=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=iMv7yrHtdWJS2xtGZYFvF6VNySfmW6k3eI2quO4DVtsFxwrmkoAkf9g/A70mczdDt
         OAidEaicyr8PHxs89vEp4XIrCOAWlbPM/6nVAZXt6pgiIbYLzGxeShhpYDNITrVqBp
         uuJrpxOc/1cmxnJQnL2Ql37sIVyXmmRKQi76+pMXeV9LSb1F93tnFRgSS1Efz7Uhxi
         FJSUiovHDMNVarM3pJc9RRdBgqSd5jbKJJO9qYKaMv+ZUdy10yYxYEFqekRrXlB+g1
         irkS0/UXUqL6mNIRaKXlwhndqsJAChWVTWfThBs8GPBwQOyX2vimPcqMujcgAzWZmb
         tCxGGrmFEpmnQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 26 Jun 2023 13:57:56 +0300 (MSK)
From:   Alexey Romanov <AVRomanov@sberdevices.ru>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/3] zsmalloc: do not scan for allocated objects in
 empty zspage
Thread-Topic: [PATCHv2 1/3] zsmalloc: do not scan for allocated objects in
 empty zspage
Thread-Index: AQHZpl0UZXCORNUGAkShFrCp/4fRxa+cuxQA
Date:   Mon, 26 Jun 2023 10:57:15 +0000
Message-ID: <20230626105750.x7dxn7z4l6t4sicb@cab-wsm-0029881>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-2-senozhatsky@chromium.org>
In-Reply-To: <20230624053120.643409-2-senozhatsky@chromium.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B30B94A8F941E04998D7A666222F0D45@sberdevices.ru>
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

Hi,

On Sat, Jun 24, 2023 at 02:12:14PM +0900, Sergey Senozhatsky wrote:
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

not sure if I can keep this tag but,

Reviewed-by: Alexey Romanov <avromanov@sberdevices.ru>

--=20
Thank you,
Alexey=
