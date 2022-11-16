Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E562C08B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiKPOI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiKPOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:06:53 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B442F4FFA9;
        Wed, 16 Nov 2022 06:02:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l12so29631522lfp.6;
        Wed, 16 Nov 2022 06:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waFWwp1Q9xsrYAHIZHHl4wa6/owP8Da4UpTGKP35GHs=;
        b=MOhebyLNqZneqCrVQhfg3EuSiBh1483yDUPqL+hG/l3euXSCY5Pj+bcSWKjGrSQOG5
         uYoOjqMTTBu3eeU9ROGG5Sp6r4SMhQgZ38NmPJlQi9QinR7kl9EUDrCYqPjhgrzdyUk+
         rzI9Q8UR1S8rnkhzwoPa+uKNfbXqJOxI6y0sp/g3g9s1f/hxwwgKGH+YjMXNT5SCvh04
         uXbg0pCH+2kVkBXROoWYycNX2uRMOU8vcaXKnDlF5uBQw/K1mZd1mdZgovBLOY9eKIWy
         FWbGaIz8Lz1b9pk7PZk9WBjtduxHhcqSdxyX4zAQySBfowRBuZcrJYKS/D2/XneyKLW0
         UqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waFWwp1Q9xsrYAHIZHHl4wa6/owP8Da4UpTGKP35GHs=;
        b=tizx6nXRzD03WlqBZmydHBOnffF3CMiPxGYyUMQIsqrRxgIs9Z8uIvpkVFHhaqTSw0
         0FZwgk7YRQRR02ySfv3HtBHkAirqtiUHIVx+ZVQr/+sNo53aNX0qt9uGqJSMCtwTIU5I
         qQxii2WY8oUHgE84sC8G1uaWsJlDG9KLunQuoA3RRF1+kfFtczVAFhawyK4RHPoX5RZM
         R3Wgy9nLxVAGDQ8x/8Lsad7hU6ALp15FAad3aRkOsKRTsgEVPUg7qsZtxWF8CTX5aPdh
         Vj1HgfpyhO0WLe6x1F+PGvHNkOiidXXShImsmxQsB+NmN8UOl/OTKkZ7SYPYg+NFBcXE
         fZHA==
X-Gm-Message-State: ANoB5pmo8MJHtoCKZO7FfTsEBEkTUy9LZbWGWrmDKHI1HI4REn5H8hYs
        wVfTjP42BzO2OYE8v3Qs4wRTesHt+O+ByKRsHWU=
X-Google-Smtp-Source: AA0mqf7U90ZcQIOt4cCKBFMGxvahbJZyksd4KAokcOvWgyaLs1cuX+VmpPOCNPwfeb0Zsv4xx6e63TRkl0TP7XvF00c=
X-Received: by 2002:a05:6512:759:b0:4b0:65c6:11fc with SMTP id
 c25-20020a056512075900b004b065c611fcmr8423244lfs.193.1668607333229; Wed, 16
 Nov 2022 06:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20221115161627.4169428-1-kristen@linux.intel.com>
 <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com> <87cz9nqff2.ffs@tglx>
In-Reply-To: <87cz9nqff2.ffs@tglx>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Wed, 16 Nov 2022 15:01:56 +0100
Message-ID: <CAPj211shRbJQcnhEpjs461nEMQw2x53f+2G46CXWJg6_Rc-x-g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
To:     jarkko@kernel.org, ira.weiny@intel.com,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 16 novembre 2022 12:58:41 CET Thomas Gleixner wrote:
> On Wed, Nov 16 2022 at 11:16, Fabio M. De Francesco wrote:
> > On marted=C3=AC 15 novembre 2022 17:16:26 CET Kristen Carlson Accardi w=
rote:
> >> The use of kmap_atomic() in the SGX code was not an explicit design
> >> choice to disable page faults or preemption, and there is no compellin=
g
> >> design reason to using kmap_atomic() vs. kmap_local_page().
> >
> > This is at the core of the reasons why you are converting, that is to
avoid
> > the potential overhead (in 32 bit architectures) of switching in atomic
> > context where it is not required.
>
> No. The point is that kmap_atomic() is an historical artifact of 32bit
> HIGHMEM support.

I just saw that the last part of my email is missing. In fact it's enough
clear that what I was saying was still incomplete and that no signature was
visible.

I meant that, before we had kmap_local_page(), the choice was between kmap(=
)
and kmap_atomic().

Despite I suppose that nobody should rely on those kmap_atomic() side effec=
ts.
I have been observing that a large part of the users of the Highmem API use=
d
to call kmap_atomic() for its implicit pagefault_disable() and
preempt_disable() side effects and so switching in atomic context only betw=
een
mappings and unmappings. Others used to call the atomic variant of kmap() j=
ust
because they wanted to default to it, instead of calling kmap().

Since 2019 we have kmap_local_page() and kmap() / kmap_atomic() have been
recently deprecated but we can't know why the author of a piece of code
decided to use kmap_atomic()...

1) Are we already in atomic context when kmap_atomic() is invoked?
2) Do we call kmap_atomic() instead of kmap() only to switch from non atomi=
c
to atomic context between the mapping the unmapping (although I stress that=
 we
shouldn't ever rely on these side effects)?

I think that who converts should tell whether or not we must explicitly, fo=
r
example, disable page faults and/or preemption along with converting to
kmap_local_page().

This is why I think that Kristen did well with the inspection of what happe=
ns
in those sections in between.

I expressed this concept in a bad way and furthermore the lines below that
sentence disappeared, making the whole much more confusing.

I think that later I'm saying a large part of what you are detailing becaus=
e I
had to learn all these things for reworking highmem.rst and the kdocs of th=
e
relevant highmem-related files.

The new documentation is upstream since months and you've been Cd'ed. If
anything is wrong please help me to correct what I wrote or do it yourself =
if
you prefer that other way.

> The back then chosen implementation was to disable preemption and
> pagefaults and use a temporary per CPU mapping. Disabling preemption was
> required to protect the temporary mapping against a context switch.
>
> Disabling pagefaults was an implicit side effect of disabling
> preemption. The separation of preempt_disable() and pagefault_disable()
> happened way later.
>
> On 64bit and on 32bit systems with CONFIG_HIGHMEM=3Dn this is not require=
d
> at all because the pages are already in the direct map.

Unfortunately, this is one of the things that were missing at the end of my
previous email. I'm aware that with HIGHMEM=3Dn all these kmap_local_page()=
 are
plain page_address(). I wrote this too in my email (and in the documentatio=
n)
but it disappeared when I sent my message.

> That means support for 32bit highmem forces code to accomodate with the
> preemption disabled section, where in the most cases this is absolutely
> not required.

This is the core: Kristen knows that the code between mapping / unmapping d=
oes
not need preemption and page faults disabling. Therefore kmap_local_page()
will work with no need to run in atomic. We all agree to the necessity to
convert but sometimes we are not sure about how to convert. Otherwise a scr=
ipt
would be enough to convert to kmap_local_page(). :-)

> That results often in suboptimal and horrible code:
>
> again:
>     kmap_atomic();
>     remaining =3D copy_to_user_inatomic();
>     kunmap_atomic();
>     if (remaining) {
>       if (try_to_handle_fault())
>             goto again;
>         ret =3D -EFAULT;
>     }
>
> instead of:
>
>     kmap_local();
>     ret =3D copy_to_user();
>     kunmap_local();
>
> It obsiously does not allow to sleep or take sleeping locks in the
> kmap_atomic() section which puts further restrictions on code just to
> accomodate 32bit highmem.

I understand and agree. I'm sorry for the missing parts and for expressing
with not so good English proficiency.

> So a few years ago we implemented kmap_local() and related interfaces to
> replace kmap_atomic() completely, but we could not do a scripted
> wholesale conversion because there are a few code pathes which rely on
> the implicit preemption disable and of course something like the above
> monstrosity needs manual conversion.
>
> kmap_local() puts a penalty exclusively on 32bit highmem systems. The
> temporary mapping is still strict per CPU, which is guaranteed by an
> implicit migrate_disable(), and it is context switched in case of
> [un]voluntary scheduling.
>
> On plain 32bit and 64bit systems kmap_local() is pretty much a NOP. All
> it does is to return the page address. It does not disable migration in
> that case either. kunmap_local() is a complete NOP.

> The goal is to eliminate _all_ use cases of kmap_atomic*() and replace
> them with kmap_local*(). This is a prerequisite for system protection
> keys and other things.

Ira confirmed that system protection keys aren't affected. I'm not sure abo=
ut
what you are referring to when talking about "other things".

> Thanks,
>
>         tglx

Can you please say if you noticed other further misleading or plainly wrong
sentences in my message? Ira and I are coordinating this conversions effort=
s
(from kmap() and kmap_atomic() to kmap_local_page), so I'm much interested =
to
know whether or not I'm wrong with regard to fundamental details.

Thanks for helping and clarify,

Fabio
