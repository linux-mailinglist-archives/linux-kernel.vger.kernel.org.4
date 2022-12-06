Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC60644C44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiLFTMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFTMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:12:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A21A202;
        Tue,  6 Dec 2022 11:12:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r65-20020a1c4444000000b003d1e906ca23so1035275wma.3;
        Tue, 06 Dec 2022 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=923JxRimLSxvO+7wwtbUsSa/9xr0Tkhke8ZWL9gS4y0=;
        b=qkmf7XcS+lo2DHkVGfkMsAoqlWRXmhRAFrPaVNfmHgrWIBF91HeI/yTV6jmCFiWgI9
         V71wUFeZ8swmKSQVkwHLjkKxxLw3uqHm67uNc+S2mUJX3Q0c8ZytrkLwOELIaykdxU/P
         wvl+QDsoTy3PBdpW3Qx0oRBYNTjdITtW2diD7ul3JjtEHsjF7kwHGXIetxpVehTx6u54
         p2DSNq90fFbkdQ7qReFxk/64bA/XXEulPK0AtfgHhqBIIjh/ABmLB3iFj9UbGKQZ4Qd7
         /c5Bxt3ae54UusVC8h9bQOoZgQct2swQrkzwuhJHNuQi+FM8TL9DTfXsraCWMwa9/0Sx
         foAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=923JxRimLSxvO+7wwtbUsSa/9xr0Tkhke8ZWL9gS4y0=;
        b=LrUd01siCOl5s33C7pP9Wrn6w+8X61vuRqTMl/iNw7OSFGGD9dNCg6P34eleL6C+bo
         2lK7WYTrEcJ0s4Maghz+/k4uS6Lep9Jv6xM+aOw2yE8pWcF1Gr0L7NHTcFxhUHkI46nE
         fPM96TpOnvNR5bdpUz5EpPoo9BeW/gYysJGcFRmdQiZ4qtpMaNrsoLzzEbw2fXhSPcaW
         PBzmgy0Wz0Lhnac8jKxrdEXofVZy5H2WLftnNN38R5iRv/6chzYzw9vcKaUw/JWeLgbH
         9m41w+hUq/e57eO3UYIOWSZ1CFJkhwVwrcSgad376KekVdA8Ztx5HKlNRCL7fn1Oe7Ym
         MaUw==
X-Gm-Message-State: ANoB5pkX0h0luLG1GH4BM8WlwGwVZQRk3QMeTj/Xenz8WoHzHwbfBF7s
        7rlK0MnVP4iEZ2R5pHrNedXDuc3OWEk=
X-Google-Smtp-Source: AA0mqf5fWLlUpKtSyOQMHbSYFOFS7l2vnj7lsBXeHzKbKVvrd6Vkj4cwjW4Jzs+KUzY5WYcAYO3ymg==
X-Received: by 2002:a05:600c:4e14:b0:3d0:7477:bc89 with SMTP id b20-20020a05600c4e1400b003d07477bc89mr395032wmq.22.1670353936143;
        Tue, 06 Dec 2022 11:12:16 -0800 (PST)
Received: from suse.localnet (host-79-26-108-238.retail.telecomitalia.it. [79.26.108.238])
        by smtp.gmail.com with ESMTPSA id n29-20020a05600c3b9d00b003c21ba7d7d6sm25725783wms.44.2022.12.06.11.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:12:15 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Tue, 06 Dec 2022 20:12:13 +0100
Message-ID: <2093077.OBFZWjSADL@suse>
In-Reply-To: <Y472ipY908pHip+B@linutronix.de>
References: <20221206070029.7342-1-fmdefrancesco@gmail.com> <Y472ipY908pHip+B@linutronix.de>
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

On marted=EC 6 dicembre 2022 09:00:10 CET Sebastian Andrzej Siewior wrote:
> On 2022-12-06 08:00:29 [+0100], Fabio M. De Francesco wrote:
> > diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> > index 0f731d9196b0..9523e92299f6 100644
> > --- a/Documentation/mm/highmem.rst
> > +++ b/Documentation/mm/highmem.rst
> > @@ -100,10 +101,21 @@ list shows them in order of preference of use.
> >=20
> >    (included in the "Functions" section) for details on how to manage=20
nested
> >    mappings.
> >=20
> > -* kmap_atomic().  This permits a very short duration mapping of a sing=
le
> > -  page.  Since the mapping is restricted to the CPU that issued it, it
> > -  performs well, but the issuing task is therefore required to stay on=
=20
that
> > -  CPU until it has finished, lest some other task displace its mapping=
s.
> > +* kmap_atomic(). This function has been deprecated; use=20
kmap_local_page().
> > +
> > +  NOTE: Conversions to kmap_local_page() must take care to follow the
> > mapping +  restrictions imposed on kmap_local_page(). Furthermore, code
> > between the +  map/unmap operations may implicitly depended on the side
> > effects of +  kmap_atomic(), such as disabling pagefaults, migration,
> > and/or preemption. +  Such conversions should be changed to make explic=
it
> > calls for those +  requirements.

Sebastian, thanks for taking a look at my patch and replying.

>   Furthermore, code between the kmap_atomic() and kunmap_atomic()
>   functions may implicitly depended=20

I suppose it should be "depend"? Shouldn't it?

>   on the side effects of kmap_atomic()
>   namely disabling pagefaults or preemption or both.

I agree with you for rephrasing, mainly because it is=20
written in poor English.

However, I still have doubts about why you deleted "migration".=20
AFAIK, __kmap_local_pfn_prot() always takes care of disabling migration for=
=20
HIGHMEM enabled kernels.=20

How about !HIGHMEM, where kmap_local_page() is an indirect call to=20
page_address()? Did you mean that, if the code between kmap_atomic() and=20
kunmap_atomic() depended on migrate_disable() (in PREEMPT_RT) we should alw=
ays=20
just stay safe and call preempt_disable() together with conversion to=20
kmap_local_page()?

If so, I understand and I again agree with you. If not, I'm missing somethi=
ng;=20
so please let me understand properly.

Aside from the above, I'm not sure whether you deleted the last phrase befo=
re=20
your suggestion. What about making it to become "For the above-mentioned=20
cases, conversions should also explicitly disable page-faults and/or=20
preemption"?=20

Thanks again for noticing my mistakes.

=46abio

>=20
> > +  [Legacy documentation]
> > +
> > +  This permits a very short duration mapping of a single page.  Since =
the
> > +  mapping is restricted to the CPU that issued it, it performs well, b=
ut
> > +  the issuing task is therefore required to stay on that CPU until it =
has
> > +  finished, lest some other task displace its mappings.
> >=20
> >    kmap_atomic() may also be used by interrupt contexts, since it does =
not
> >    sleep and the callers too may not sleep until after kunmap_atomic() =
is
>=20
> Sebastian




