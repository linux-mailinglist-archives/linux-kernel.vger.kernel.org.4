Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC960C23C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiJYD0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJYD0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:26:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462167FF80
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:26:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14944157pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paDBg16p6YRUPglFeZrsN+RssI7F8VwXvdzXMRIMWZ8=;
        b=o75qzlM0+kPwb3ZW3hftahzUFIy6ArxiI0FbGOn73VeyLgbCnph2zCmWTL1gWzRAWj
         QmzL7oD+czpalzF/QSPEr8AfCTx/XjNlvBBzvCsc/G8Ro6gTHZziYnTBI8LVMpbjuBre
         E4EItFpYhFhm2n3GPtPUA9kSdARq6B/TkDhUqlcThT9yH3sR+Gxi8S2nw6cCOC0oNZuG
         IwrvNZSljR7NdGR2yXXb1OUpRp0MbhCkGW2gmgEgIIsQz3J5G33E7u+hA+MAgjni32Ic
         3wS40G5w97hLnPF1fs8GRAyk3GYriudAHBtE8MYVYq0nBxqcMk16IXBIUy2r9NFRRTQh
         JSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paDBg16p6YRUPglFeZrsN+RssI7F8VwXvdzXMRIMWZ8=;
        b=3Q/Q/tMiWNOD4IivhV6eVfj6SdE8wBYm/oMQ2AD3cI3ZSgRQfCgimiaOIi9k1DbFhw
         TUPkclBmI7FHdc80CbKISwHbyDW34HdDx1GVZg7Z/xgDxzmSyV8hI9wATXVp0c+aZRBW
         WBn/TkgsrezTyTHWqt8jfLSvAu0WtW0UcjFElxMfVdi2zk+KwWDzV+6COO2fje+o20dL
         VQxWoZaXOnv9NPb5vSgqPdpIqiD627bGhS1aYt2++oLzCAFlZi4AERNmMZb0rk/fEFgS
         TkJwmatyAhxGOlzwrYsLayvY47PYazQ4EDWColMO9ZoptqpQkTWBziZ1ZSEIWUckf90I
         67/g==
X-Gm-Message-State: ACrzQf0/YxDu16T/EP62Q3SfKew+NUZqmMkWQUCqrddQ1YIzn1fXyYSL
        3iM2mNnF6OevcAimNq2Q7T4=
X-Google-Smtp-Source: AMsMyM7woeVXOy9+FfMmuYzQm+OPdUEiGb3oaSK4p9PxL+CEZStmaJcRzE6iFkyJ2RIgIo2LxSPjgw==
X-Received: by 2002:a17:902:d64d:b0:186:634e:5517 with SMTP id y13-20020a170902d64d00b00186634e5517mr25462476plh.3.1666668365663;
        Mon, 24 Oct 2022 20:26:05 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-62.three.co.id. [116.206.28.62])
        by smtp.gmail.com with ESMTPSA id s5-20020a656445000000b00462ae17a1c4sm437781pgv.33.2022.10.24.20.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:26:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7B3D21002B9; Tue, 25 Oct 2022 10:26:01 +0700 (WIB)
Date:   Tue, 25 Oct 2022 10:26:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/6] zsmalloc/zram: configurable zspage size
Message-ID: <Y1dXSeqwX/WfUcjt@debian.me>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5BUiyQSp/khvQ8r+"
Content-Disposition: inline
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5BUiyQSp/khvQ8r+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 01:12:07AM +0900, Sergey Senozhatsky wrote:
> 	Hello,
>=20
> 	Some use-cases and/or data patterns may benefit from
> larger zspages. Currently the limit on the number of physical
> pages that are linked into a zspage is hardcoded to 4. Higher
> limit changes key characteristics of a number of the size
> clases, improving compactness of the pool and redusing the
> amount of memory zsmalloc pool uses.
>=20
> For instance, the huge size class watermark is currently set
> to 3264 bytes. With order 3 zspages we have more normal classe
> and huge size watermark becomes 3632. With order 4 zspages
> huge size watermark becomes 3840.
>=20
> Commit #1 has more numbers and some analysis.
>=20
> Sergey Senozhatsky (6):
>   zsmalloc: turn zspage order into runtime variable
>   zsmalloc/zram: pass zspage order to zs_create_pool()
>   zram: add pool_page_order device attribute
>   Documentation: document zram pool_page_order attribute
>   zsmalloc: break out of loop when found perfect zspage order
>   zsmalloc: make sure we select best zspage size
>=20
>  Documentation/admin-guide/blockdev/zram.rst | 31 +++++--
>  drivers/block/zram/zram_drv.c               | 44 ++++++++-
>  drivers/block/zram/zram_drv.h               |  2 +
>  include/linux/zsmalloc.h                    | 15 +++-
>  mm/zsmalloc.c                               | 98 +++++++++++++--------
>  5 files changed, 145 insertions(+), 45 deletions(-)
>=20

Sorry, I can't cleanly apply this patch series due to conflicts in
patch [1/6]. On what tree and commit the series is based?

--=20
An old man doll... just what I always wanted! - Clara

--5BUiyQSp/khvQ8r+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1dXRAAKCRD2uYlJVVFO
oxsdAP0czu/j5ZhnUC/xT78qaPXkUubnV2evpencu4KBrAcyigEAsYKD77TJp0VY
0n2vNLsoCAN9P3HtQaUYONTu6nC3TQs=
=SGwH
-----END PGP SIGNATURE-----

--5BUiyQSp/khvQ8r+--
