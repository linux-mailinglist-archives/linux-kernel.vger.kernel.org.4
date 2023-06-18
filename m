Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521E7344EC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjFREuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 00:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFREuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 00:50:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F031731
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 21:50:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so6011245e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 21:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687063807; x=1689655807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spKGmuwsJREHINCurqe1MccBaw6rOuxpPoT72kVRxDw=;
        b=UbHjy9LDXYHFS/jJ5qmSj8vIl05uQA7NVEtyz151r4X0U+aHXVFgM73QmcMp24wGX7
         INMzDhI9ifucG3TQ368SZkA37PPwpePGfac7+hTIIHZT3OXXogdrndg4OOKeYtpqH8KO
         6ZDeBqbtMGSZzgXyrSsPSXQTFjLhq5Jl8mU1rHL7UbE7a/smnxbSCiKQSccDNBYkp6qh
         ZyS/upXHKOD1YY1HXQgYEEDWHF94b/6P86X7UA+S0P2ToqmjrKtz64ZW2H3reLy1Oxy6
         /bQnAmSFfFIeBaSi+NqLH4KlevpJVol/ROVrTYXwBNKAWLuXAeU8Pnpg4SCg9ceblqJQ
         /Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687063807; x=1689655807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spKGmuwsJREHINCurqe1MccBaw6rOuxpPoT72kVRxDw=;
        b=agQ4vb/vZxx+aXZBK1EVjheBqDgF/hBhcolYBtDI2Jjyvag3oDtJ6JKNffXN3Mg5/4
         Kl0t+9iYYYzgAjAsdtM13ffg3AhTzOX+phJRTKOXTDIAjBJuingwcLPZ8I8F83xiANxi
         mhsuiOAFnLQ59YjdjKHpJxouHMa7k2icaCvfTa7CiaaTXTKvswPqxQKjGkOXvX9kWLrK
         VwvDzh5fprrye7+146Wtsx+FqS/wpwL0Ybijlp4rHxcfMYIorUFooFLwhErTWuMbDByW
         iT4Xk5+l6a/mTYkyLEtwmKrJK6Ttk5nLZ7TRZ4w5RZG84KkORdYtFfycjuPcTtsDG2Mx
         eA4A==
X-Gm-Message-State: AC+VfDz6JvBvm+NtlhNqemnWcVuELJnmcfAKKuYlh1q7uBuGPfqYlRK7
        lbDDxjbTdz7C+tjWDpvg6PU=
X-Google-Smtp-Source: ACHHUZ7qyEphBiIGyelTf1sNWRZitwwx5xQYO+IexrttRoj3sTX01OrNxqy1GwIZijlIVpSaps1OAw==
X-Received: by 2002:a7b:c409:0:b0:3f7:16ed:4ca3 with SMTP id k9-20020a7bc409000000b003f716ed4ca3mr6578872wmi.1.1687063806617;
        Sat, 17 Jun 2023 21:50:06 -0700 (PDT)
Received: from suse.localnet (host-79-26-32-1.retail.telecomitalia.it. [79.26.32.1])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003f904272d51sm3417712wmj.37.2023.06.17.21.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 21:50:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v2] lib: Replace kmap() with kmap_local_page()
Date:   Sun, 18 Jun 2023 06:50:04 +0200
Message-ID: <8275009.NyiUUSuA9g@suse>
In-Reply-To: <20230610175712.GA348514@sumitra.com>
References: <20230610175712.GA348514@sumitra.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 10 giugno 2023 19:57:12 CEST Sumitra Sharma wrote:
> kmap() has been deprecated in favor of the kmap_local_page()
> due to high cost, restricted mapping space, the overhead of
> a global lock for synchronization, and making the process
> sleep in the absence of free slots.
>=20
> kmap_local_page() is faster than kmap() and offers thread-local
> and CPU-local mappings, take pagefaults in a local kmap region
> and preserves preemption by saving the mappings of outgoing
> tasks and restoring those of the incoming one during a context
> switch.
>=20
> The mappings are kept thread local in the functions
> =E2=80=9Cdmirror_do_read=E2=80=9D and =E2=80=9Cdmirror_do_write=E2=80=9D =
in test_hmm.c
>=20
> Therefore, replace kmap() with kmap_local_page() and use
> mempcy_from/to_page() to avoid open coding kmap_local_page()
> + memcpy() + kunmap_local().
>=20
> Remove the unused variable =E2=80=9Ctmp=E2=80=9D.
>=20
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

LGTM, so...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

=46abio

P.S.: The answer to an old question from you is that "LGTM" stands for "[It=
]=20
Looks Good To Me".=20

It's just a way to introduce the "Reviewed-by" tag itself. However, "LGTM" =
is=20
not required, whereas the tag is required for a valid review and only the t=
ag=20
line will be added by maintainers in the log when your patch gets applied. =
=20

While here... Please don't put unnecessary blank lines between the tags.The=
y=20
are not required and instead may worsen readability (obviously, I'm not=20
requiring a new version for this). =20

>=20
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>=20
> Changes in v2:
> 	- Change commit subject and description.
> 	- Remove unnecessary type casting (char *).
>=20
>=20
>  lib/test_hmm.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 67e6f83fe0f8..717dcb830127 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -368,16 +368,13 @@ static int dmirror_do_read(struct dmirror *dmirror,
> unsigned long start, for (pfn =3D start >> PAGE_SHIFT; pfn < (end >>
> PAGE_SHIFT); pfn++) { void *entry;
>  		struct page *page;
> -		void *tmp;
>=20
>  		entry =3D xa_load(&dmirror->pt, pfn);
>  		page =3D xa_untag_pointer(entry);
>  		if (!page)
>  			return -ENOENT;
>=20
> -		tmp =3D kmap(page);
> -		memcpy(ptr, tmp, PAGE_SIZE);
> -		kunmap(page);
> +		memcpy_from_page(ptr, page, 0, PAGE_SIZE);
>=20
>  		ptr +=3D PAGE_SIZE;
>  		bounce->cpages++;
> @@ -437,16 +434,13 @@ static int dmirror_do_write(struct dmirror *dmirror,
> unsigned long start, for (pfn =3D start >> PAGE_SHIFT; pfn < (end >>
> PAGE_SHIFT); pfn++) { void *entry;
>  		struct page *page;
> -		void *tmp;
>=20
>  		entry =3D xa_load(&dmirror->pt, pfn);
>  		page =3D xa_untag_pointer(entry);
>  		if (!page || xa_pointer_tag(entry) !=3D DPT_XA_TAG_WRITE)
>  			return -ENOENT;
>=20
> -		tmp =3D kmap(page);
> -		memcpy(tmp, ptr, PAGE_SIZE);
> -		kunmap(page);
> +		memcpy_to_page(page, 0, ptr, PAGE_SIZE);
>=20
>  		ptr +=3D PAGE_SIZE;
>  		bounce->cpages++;
> --
> 2.25.1




