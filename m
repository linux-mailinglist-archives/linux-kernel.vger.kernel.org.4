Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22DD744928
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGANQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGANQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:16:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B017135
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:16:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso25133145e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688217411; x=1690809411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6hdMojFpTugy3dUd9JSBh6ZcDdqFBKf/4RDp5ymPwQ=;
        b=DAVOHVXgPkuMzrjcCUtc/w2Zgp3tBzSiYh1qEX0+5Muyay333Afk+S35smIlh0NcR+
         G+rZ2xgMbLQdA9VCGmOdz6cZEKn3kxwmpWGhMoPARivTGYqPFBuDwsZwqETPNQkGU+eO
         m872eFLtQPtafdn7Rzw/+XPPv6Sz8jjA3G/51f/PuHXOq7rhJzrSxyNOA1hRNXIgyt2N
         59UkQgAeZWcTPB3p6RVPoudUw9TVJGCUjktfcrbIuUc1uvR+TUMYf7HcAa5o9rMWE7f6
         oXTknBXOk8dr1DRl9wMNcJsZZv4riG8txHvZB+lxPWFsvEFukh7PAI4xTFAE5tcDOS9I
         Vutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688217411; x=1690809411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6hdMojFpTugy3dUd9JSBh6ZcDdqFBKf/4RDp5ymPwQ=;
        b=j0yFrmbEqBxY87YTefz1JbZOm3zrR7mkRNzdEAAbUXg+V4KkE8nFCQB6IWBOv3pq+Y
         2/woljm/rVMrVk+nkL5t6ifclS2Akr/PtIpX9wT4l5kzz3F9GgJTW+RS8ISyVLKkfdsj
         Md7fyBOCPCTdKb6spb+BDOne9ErqkQdXUUFrhugOLscYQZL/F8TIaxTfxEFWabAC1mD3
         62r5omXWJ2ahiRnlqv45lw9A0Sw9LEyzGb1cYX6h2KW9lklo8GZEKHKTaftB/xgECrK2
         pVNOZn4GNux2AvOKlTBRQezUp8X8e+UfgC7r8D1+84n7/g7X04kBR0aj4r21TdG8NMXl
         1Dyw==
X-Gm-Message-State: AC+VfDyBDTykjPLlnYyFr/vliFdvIBxPaDLLJyMxO2/Lzz9w47Cr7TVD
        IKBVHYGpuIG5GYvSTKaENnlPm56aHN0=
X-Google-Smtp-Source: ACHHUZ5pNq3JMe5rmis9M7o5vU1rFwHnTXefGhidMDlhyDd3scNNOTaMqhaOZ2dIgT6bM5u3YbXjYQ==
X-Received: by 2002:a05:600c:8606:b0:3fa:125c:8d65 with SMTP id ha6-20020a05600c860600b003fa125c8d65mr9897885wmb.3.1688217410430;
        Sat, 01 Jul 2023 06:16:50 -0700 (PDT)
Received: from suse.localnet (host-212-171-6-230.pool212171.interbusiness.it. [212.171.6.230])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c224a00b003faef96ee78sm15587581wmm.33.2023.07.01.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 06:16:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v3 4/6] gfs2: Replace kmap_atomic() by kmap_local_page() in lops.c
Date:   Sat, 01 Jul 2023 15:16:48 +0200
Message-ID: <5948996.alqRGMn8q6@suse>
In-Reply-To: <4817527acb9e015b3c6929517993ea50ba3427ad.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
 <4817527acb9e015b3c6929517993ea50ba3427ad.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 29 giugno 2023 23:51:17 CEST Deepak R Varma wrote:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().

Deepak,

Can you please add a reference to the highmem documentation and to the patc=
h=20
from Ira that added a deprecation check for kmap() and kmap_atomic() in his=
=20
commit regarding checkpatch.pl?

There may be maintainers / reviewers who are still unaware of this=20
information. It would surely help them with reviewing. Furthermore it might=
=20
suggest maintainers to convert their subsystem / driver to the new API or=20
remove and use plain page_address() (if it is possible to prove that pages=
=20
can't come from ZONE_HIGHMEM).

>=20
> Therefore, replace kmap_atomic() with kmap_local_page() in following
> functions of lops.c:
>    - gfs2_jhead_pg_srch()
>    - gfs2_check_magic()
>    - gfs2_before_commit()
>=20
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> stuffed_readpage() does not depend on the above-mentioned side effects.
>=20
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v3:
>    - Patch included in patch series
>=20
> Changes in v2:
>    - None
>=20
>=20
>  fs/gfs2/lops.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 1902413d5d12..a7c2296cb3c6 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -427,7 +427,7 @@ static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
>  {
>  	struct gfs2_sbd *sdp =3D GFS2_SB(jd->jd_inode);
>  	struct gfs2_log_header_host lh;
> -	void *kaddr =3D kmap_atomic(page);
> +	void *kaddr =3D kmap_local_page(page);
>  	unsigned int offset;
>  	bool ret =3D false;
>
Deepak,

Are we mixing declarations with functions calls? Is it good practice? If no=
t,=20
I'd suggest to move the mapping to a better suited place.
>=20
> @@ -441,7 +441,7 @@ static bool gfs2_jhead_pg_srch(struct gfs2_jdesc *jd,
>  			}
>  		}
>  	}
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	return ret;
>  }
>=20
> @@ -626,11 +626,11 @@ static void gfs2_check_magic(struct buffer_head *bh)
>  	__be32 *ptr;
>=20
>  	clear_buffer_escaped(bh);
> -	kaddr =3D kmap_atomic(bh->b_page);
> +	kaddr =3D kmap_local_page(bh->b_page);
>  	ptr =3D kaddr + bh_offset(bh);
>  	if (*ptr =3D=3D cpu_to_be32(GFS2_MAGIC))
>  		set_buffer_escaped(bh);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  }
>=20
>  static int blocknr_cmp(void *priv, const struct list_head *a,
> @@ -699,10 +699,10 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp,
> unsigned int limit, void *kaddr;
>  				page =3D mempool_alloc(gfs2_page_pool,=20
GFP_NOIO);
>  				ptr =3D page_address(page);
> -				kaddr =3D kmap_atomic(bd2->bd_bh-
>b_page);
> +				kaddr =3D kmap_local_page(bd2->bd_bh-
>b_page);
>  				memcpy(ptr, kaddr + bh_offset(bd2-
>bd_bh),
>  				       bd2->bd_bh->b_size);
>
Deepak,

How about memcpy_from_page()?

Thanks,

=46abio
>
> -				kunmap_atomic(kaddr);
> +				kunmap_local(kaddr);
>  				*(__be32 *)ptr =3D 0;
>  				clear_buffer_escaped(bd2->bd_bh);
>  				unlock_buffer(bd2->bd_bh);
> --
> 2.34.1




