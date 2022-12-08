Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02076476F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLHUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLHUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:06:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455E6932E;
        Thu,  8 Dec 2022 12:06:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so1897470wmb.5;
        Thu, 08 Dec 2022 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HJzctfs0A7+67wrWEyjqiiApDxFj7bBAuqDA0docR8=;
        b=JFXQzVZhIytYnODAFNYIoJhU3fu85Q0qDIXPnks2LUwHobMp1Qfh9ik/oOO9ZeC7SS
         G60FU533BawspTAQ91j0mrt+c1qedmr+Szh4qB0pJjQpwc2G5KYy5QM1nv0BGX7MXCuR
         yougPIUeWVYgoJmNtehonr0Lij5RO4aL8dl2psOKLQYML08draDBICLRWTL3dfTG/g5h
         cIrk1YEnC3hkOgte/f+AbMhssZlo8s+3PRGqmm/uqg4ni3F/pCXwRqOpsyAgcb4Dl6pS
         dcfsLNWp1+1tLkFIX6cN3ZTcflhCtsQoKfxkwbBrk5IRfVeGRsv3GvUgbCZv7Cz1LjJZ
         BIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HJzctfs0A7+67wrWEyjqiiApDxFj7bBAuqDA0docR8=;
        b=HIs0/2Mphhx7SHe+2q48JBx07nzeAcwJmL+SRS1XJMKnsTq9e4mDwo5o1Rv97uU/hA
         VqJKGBjBpEWUN7k4FIT3+9AxLcwQb31SrJoBVkobeOTAquqdGAZoSxAS3vZkeXig8Tc1
         NfCpHhbUDKfxAP5RDkW0GuVal0ZO8k3Q/+1yb9egXiI3fu05+ttNcUIMQBFcyqXWAp6h
         Kpw0+II/7tOEbLfniKkfu52WqCOyqpqjg1b9Z3TwWDpxW50yhrzDRY+dtudJgpW0iE97
         HFtGNn9TS9zn3CC9B8uUgDs/D+y0Yf+oIV8l77j7JN9ihBNk8BYcjGPlc1rN3n3iWqud
         nJPw==
X-Gm-Message-State: ANoB5plqeIznSCLhA8bKszIMgU1VyGTt4CoByahM1EHxYLRHZkbbjdjB
        mxkrVLX56g+1bZQMiFmUZmv3WaxtjX8=
X-Google-Smtp-Source: AA0mqf53iw5pBXG2lLUX2tXR2ljdn/DuiP0//O+YiWqTgo+EuFU1OoZ/hwTOfToMwL2LqnpV3AoYWA==
X-Received: by 2002:a05:600c:1d98:b0:3cf:74b4:c3c8 with SMTP id p24-20020a05600c1d9800b003cf74b4c3c8mr2940495wms.17.1670529958638;
        Thu, 08 Dec 2022 12:05:58 -0800 (PST)
Received: from suse.localnet (host-79-26-108-238.retail.telecomitalia.it. [79.26.108.238])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b003c6d21a19a0sm7068929wms.29.2022.12.08.12.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:05:57 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Thu, 08 Dec 2022 21:05:56 +0100
Message-ID: <21697972.EfDdHjke4D@suse>
In-Reply-To: <Y5FmjdBNEO8aP/Ls@debian.me>
References: <20221207225308.8290-1-fmdefrancesco@gmail.com> <Y5FmjdBNEO8aP/Ls@debian.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 8 dicembre 2022 05:22:37 CET Bagas Sanjaya wrote:
> On Wed, Dec 07, 2022 at 11:53:08PM +0100, Fabio M. De Francesco wrote:
> > diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> > index 0f731d9196b0..59d1078f53df 100644
> > --- a/Documentation/mm/highmem.rst
> > +++ b/Documentation/mm/highmem.rst
> > @@ -57,7 +57,8 @@ list shows them in order of preference of use.
> >=20
> >    It can be invoked from any context (including interrupts) but the
> >    mappings
> >    can only be used in the context which acquired them.
> >=20
> > -  This function should be preferred, where feasible, over all the othe=
rs.
> > +  This function should always be used. kmap_atomic() and kmap() have b=
een
> > +  deprecated.
>=20
> "... always be used, whereas ..."
>=20
> > +  NOTE: Conversions to kmap_local_page() must take care to follow the
> > mapping +  restrictions imposed on kmap_local_page(). Furthermore, the=
=20
code
> > between +  calls to kmap_atomic() and kunmap_atomic() may implicitly=20
depend
> > on the side +  effects of atomic mappings, i.e. disabling page faults or
> > preemption, or both. +  In that case, explicit calls to=20
pagefault_disable()
> > or preempt_disable() or +  both must be made in conjunction with the us=
e=20
of
> > kmap_local_page(). +
> > <snipped>...
> > +  NOTE: Conversions to kmap_local_page() must take care to follow the
> > mapping +  restrictions imposed on kmap_local_page(). In particular, it=
 is
> > necessary to +  make sure that the kernel virtual memory pointer is only
> > valid in the thread +  that obtained it.
> > +
>=20
> What about using note block to signify conversion notes above?
>=20
> ---- >8 ----
>=20
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index 59d1078f53df57..ef53eb580d4cda 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -103,12 +103,14 @@ list shows them in order of preference of use.
>=20
>  * kmap_atomic(). This function has been deprecated; use kmap_local_page(=
).
>=20
> -  NOTE: Conversions to kmap_local_page() must take care to follow the=20
mapping
> -  restrictions imposed on kmap_local_page(). Furthermore, the code betwe=
en=20
=2D
>  calls to kmap_atomic() and kunmap_atomic() may implicitly depend on the=
=20
side
> -  effects of atomic mappings, i.e. disabling page faults or preemption, =
or
> both. -  In that case, explicit calls to pagefault_disable() or
> preempt_disable() or -  both must be made in conjunction with the use of
> kmap_local_page(). +  .. note::
> +     Conversions to kmap_local_page() must take care to follow the mappi=
ng
> +     restrictions imposed on kmap_local_page(). Furthermore, the code=20
between
> +     calls to kmap_atomic() and kunmap_atomic() may implicitly depend on=
=20
the
> +     side effects of atomic mappings, i.e. disabling page faults or
> preemption, +     or both. In that case, explicit calls to
> pagefault_disable() or +     preempt_disable() or both must be made in
> conjunction with the use of +     kmap_local_page().
>=20
>    [Legacy documentation]
>=20
> @@ -129,10 +131,11 @@ list shows them in order of preference of use.
>=20
>  * kmap(). This function has been deprecated; use kmap_local_page().
>=20
> -  NOTE: Conversions to kmap_local_page() must take care to follow the=20
mapping
> -  restrictions imposed on kmap_local_page(). In particular, it is necess=
ary
> to -  make sure that the kernel virtual memory pointer is only valid in t=
he
> thread -  that obtained it.
> +  .. note::
> +     Conversions to kmap_local_page() must take care to follow the mappi=
ng
> +     restrictions imposed on kmap_local_page(). In particular, it is
> necessary +     to make sure that the kernel virtual memory pointer is on=
ly
> valid in the +     thread that obtained it.
>=20
>    [Legacy documentation]
>=20
> Thanks.
>=20
> --
> An old man doll... just what I always wanted! - Clara

You provided valid suggestions, thanks!
However, immediately after submitting this v2 patch, Andrew added it to the=
 -
mm mm-unstable branch.
I'll do the changes that you suggested in a subsequent patch which will bui=
ld=20
on this.

Again thanks,

=46abio




