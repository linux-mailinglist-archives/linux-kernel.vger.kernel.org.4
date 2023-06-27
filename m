Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9C73FB49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjF0LmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjF0LmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:42:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E82735
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:42:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so6232868e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687866122; x=1690458122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VSnLiTkQ1dzquJmbrvFVUB5iYnq0MwIQjudEDRHCVs=;
        b=CaZ/NHOSfc424KgLTlHip2E51at0aW0HHPdboV+8HoMgAFjWN82skPWUcE9AMwhVU8
         DuGj7RZ9xqr/A4tAFcfb/8LvDTjVaTfGIFexBxFTJLjl+1fcApI1UXAOxxVpLo1ZAe/f
         Zj6Lqe1ezphoKkEUcZlF+Jus6I1HRJ16z672q0fNOR45gtxw7OJxf8CfvhTsXZgcTQ6y
         F21uqTFn/9RSDzUcUhAY70C+0laeiX8f/717vW9uxpOeSVdJifWmNfx2vsoyGYYLVW+W
         sh0fMGT3YK+thFno74m3y1TwpQkHFLkSCr18Pg+MDhWKIr+/91Im7gyWaO6E8U0iH0Rr
         6wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866122; x=1690458122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VSnLiTkQ1dzquJmbrvFVUB5iYnq0MwIQjudEDRHCVs=;
        b=abFBZ/bC6qXq8olmpvht9qSTRGkaTW54YNeB9RJtAtYaTOKEjXV+qeuuMhtRqpiOxy
         /fCqUM5oLCxygjYbpcGuCX1y/nJw2XVwXH9elHdAAJ6yzsHWEbUyLJBc0WwpT0A348M1
         j2dBEUeoZj+wSGzVg3lP7ZUE0pdqwg2Mz/Fwwpa9e0g3VCAVUF1vc6tFas8nUKzA9Iql
         /2zloZGcoajDz1p/lj6Te3rHOJ1Cf+zCnkzRNv1wlwxqAllOtk+Hlj6Od2+RcJV3Q+BZ
         N6TOaVz/CbEVNZtf7U8U9f/ZDK4emYuapjvVtU6SCsX2RAN22nMoY213fvNswymbJl+c
         8JYg==
X-Gm-Message-State: AC+VfDzNF6WNEvJK21Hvno9wQUlbDIt2gqCbv+bgojzJ2WlROXs7AVox
        NIqU5JBkFRc3QzsUAmkpfTk=
X-Google-Smtp-Source: ACHHUZ7Xx3+/qq+mhRlzocpzunZ2Y2YOr1cogfwyoCPxXHsIFYZkW00vQnl44DxBd2W+PuxK0+CXyw==
X-Received: by 2002:a05:6512:3b8e:b0:4fb:744e:17db with SMTP id g14-20020a0565123b8e00b004fb744e17dbmr4917328lfv.1.1687866122079;
        Tue, 27 Jun 2023 04:42:02 -0700 (PDT)
Received: from suse.localnet (host-79-12-109-185.retail.telecomitalia.it. [79.12.109.185])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003fba2734f1esm1815198wmc.1.2023.06.27.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:42:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Deepak R Varma <drv@mailo.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v2] gfs2: Replace deprecated kmap_atomic() by kmap_local_page()
Date:   Tue, 27 Jun 2023 13:41:59 +0200
Message-ID: <14943541.tv2OnDr8pf@suse>
In-Reply-To: <ZJk1XTtgLFxIcxzp@bu2204.myguest.virtualbox.org>
References: <ZJk1XTtgLFxIcxzp@bu2204.myguest.virtualbox.org>
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

On luned=EC 26 giugno 2023 08:51:09 CEST Deepak R Varma wrote:
> kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
>=20
> Therefore, replace kmap_atomic() with kmap_local_page() in
> gfs2_internal_read() and stuffed_readpage().
>=20
> kmap_atomic() disables page-faults and preemption (the latter only for
> !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> gfs2_internal_read() and stuffed_readpage() does not depend on the
> above-mentioned side effects.
>=20
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Note: The Patch is build tested only. I will be happy to run recommended
> testing with some guidance if required.
>=20
> Changes in v2:
>    - Update patch description to correct the replacement function name fr=
om
>      kmap_local_folio to kmap_local _page

Ah, well done. I didn't note this with the comment on v1.
=20
>  fs/gfs2/aops.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 3b41542d6697..7bd92054d353 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip,
> struct page *page) if (error)
>  		return error;
>=20
> -	kaddr =3D kmap_atomic(page);
> +	kaddr =3D kmap_local_page(page);
>  	memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
>  	memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	flush_dcache_page(page);
>  	brelse(dibh);
>  	SetPageUptodate(page);
> @@ -498,12 +498,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char=
=20
*buf,
> loff_t *pos, continue;
>  			return PTR_ERR(page);
>  		}
> -		p =3D kmap_atomic(page);
> +		p =3D kmap_local_page(page);
>  		amt =3D size - copied;
>  		if (offset + size > PAGE_SIZE)
>  			amt =3D PAGE_SIZE - offset;
>  		memcpy(buf + copied, p + offset, amt);

As said in the comment on v1, the memcpy_from_page() helper is better suite=
d=20
here, unless you noted something that prevents its use and that I'm not abl=
e=20
to see at the moment.

Thanks,

=46abio

> -		kunmap_atomic(p);
> +		kunmap_local(p);
>  		put_page(page);
>  		copied +=3D amt;
>  		index++;
> --
> 2.34.1




