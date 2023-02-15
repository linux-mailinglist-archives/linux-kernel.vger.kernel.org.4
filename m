Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4B6977CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjBOIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjBOINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:13:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791F7294
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mo1cLpGdKDY4uulgiNcnFm0Ec2uXKdttKXI4poEPOf8=;
        t=1676448834; x=1677658434; b=IafBY+/KkaMIfDBPepNmwrPWU5WPLwH0velJlvNKEXYj3ws
        cGeWLlC3tGVBthj4YeU51zEKSz+sRR0hdozsuQHIwM306YGBDiLFI/DgbXR9vD7tRJ6xrm7y1+yrM
        qpdrxRQJ7lKG+idhIJgXp+b5uddgAU2ze4isH8xh3C9PfykJ6bf9GtFevs1kGA3wtQEfgNtBHhbS2
        y61ERXr1ZcgVKMcOze3yBJsVKJG6oFYDis45MYoCMGWycxc51Bl82NX4tHLhBg3Wkw406ybuuoWI7
        GwRmpewaCWN25oBboLPXhGrS/aGnUcS/aFPspfLl2GXvIY1+pAC8IMHTSFC9e4lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSCv9-00CypS-0k;
        Wed, 15 Feb 2023 09:13:43 +0100
Message-ID: <b4bacb46e3a18c1f8d66d25f946dae09ccfcdc4f.camel@sipsolutions.net>
Subject: Re: [PATCH V1] um: Fix compilation warnings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Feb 2023 09:13:36 +0100
In-Reply-To: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
         <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
         <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
         <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-15 at 09:07 +0100, Geert Uytterhoeven wrote:
> Hi Srinivasarao,
>=20
> On Wed, Feb 15, 2023 at 6:36 AM Srinivasarao Pathipati
> <quic_c_spathi@quicinc.com> wrote:
> > On 2/15/2023 3:27 AM, Richard Weinberger wrote:
> > > ----- Urspr=C3=BCngliche Mail -----
> > > > Von: "Srinivasarao Pathipati" <quic_c_spathi@quicinc.com>
> > > > static void sig_handler_common(int sig, struct siginfo *si, mcontex=
t_t *mc)
> > > > {
> > > > -    struct uml_pt_regs r;
> > > > +    struct uml_pt_regs *r;
> > > >      int save_errno =3D errno;
> > > >=20
> > > > -    r.is_user =3D 0;
> > > > +    r =3D malloc(sizeof(struct uml_pt_regs));
> > > I fear this is not correct since malloc() is not async-signal safe.
> >=20
> > Thanks Richard for quick response. Could you please suggest alternative
> > function of malloc() with async-signal safe.
> >=20
> > if that is not possible Is there any other way to fix this warning? OR
> > do we need to live with that warning?
>=20
> Does this limit actually apply to this file, which calls into the host OS=
?

Not really. Also, we know we have a signal stack that's large enough,
since we set it up ourselves:

                set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);

and it's a full page, so even the OS eating up some of that won't cause
us any trouble. We do have somewhat deep calls into do_IRQ() but those
really shouldn't use much stack space since they can (in non-UM kernels)
be called on top of arbitrary kernel stacks already.

> How come you even see this warning, as we have
>=20
>     CFLAGS_signal.o +=3D -Wframe-larger-than=3D4096
>=20
> since commit 517f60206ee5d5f7 ("um: Increase stack frame size threshold
> for signal.c") in v5.11?
>=20

Good question, I don't see it. However we probably should make that a
_bit_ smaller since we only have a page and still need to call do_IRQ()
and all.

johannes
