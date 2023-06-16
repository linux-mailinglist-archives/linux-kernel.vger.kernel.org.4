Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC17333D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbjFPOmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:42:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90FA19B5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:42:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc97822915aso862868276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686926533; x=1689518533;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsAZEJAZHUUDfMyKwjNpCmfGXNQVlottGvYSAOdxPyg=;
        b=adpwsG2H6cpXugvKqirjGhwUIFMPDcrBNE0i5r4CFwEKGocnR4sJRF7wBs8wMBmquK
         B+M/fAOZqbFOi4HcCIIshkQ7WTG4l88FJE2SX4H8+BNDNA70XujEppAqcFuF+KSwr4Bo
         hARZWZADr2pxF2gdWzt1a5z+uKnqTBqWVuiSPd0uBNbkrLZ2CBXTMZz9qs/kzwhBQ8IK
         3euvvKxfXe9uYn0RD9DOa27WKXJzrMVq01WfPol+DS9Svc0BwPl1Ezr//SlQh4PevOkh
         bTf6+6UNgkkF64pw9ZxpYCob2zIUbQUJkOLve05ZOVnUHp1UCoTUk6S6dKiiQdoMHYFS
         PRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926533; x=1689518533;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsAZEJAZHUUDfMyKwjNpCmfGXNQVlottGvYSAOdxPyg=;
        b=TA9DtIpQFYmmMs3qI6pVHV5JGxhQcgLYaUqALzKeGELcWTk4DNUf3Oid5YJ0tG4i6I
         UmtLfXh+zrc7QB8d7XPFu6DFWGlE5/9GWjhzIVKV2cVpOzBgHkLSABJHpk5ovNrr7vsJ
         Uo1bxqk+jPCMWpUxkQMIek+KGv07EIZnJ6zxU0lGKEsX2G8gEUqXkAjbbh+TWHbVsxAK
         QTQF+frMuZ+aNnygLcKlTUEdxkYauz7Zxp5ZqobIX9W3XrkhRMVNf+uF20aSs8/ItVrz
         gPDbzB+vVCjsHK76crtNPORWDzAXmR+yHx+s+VUaW2xur0x6sFv9vOAF8tYC2mvxyQb6
         kESw==
X-Gm-Message-State: AC+VfDxqQUadb6t8M7E0Xfs93Q54cN1RzNqRC9AAjrfaoyAsFBfSNoCo
        fxZsLKCzcJfivNwwLg2O94NdwlWXetg=
X-Google-Smtp-Source: ACHHUZ5/bTcM/mh07b6qS3v6DnPe8AMZwvh2fDqGKoK5zWLOOOCqR5PZeey9PqzVxOVOUQZXiO1+K9ZJ45U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:951:0:b0:bcc:883f:ea2 with SMTP id
 u17-20020a250951000000b00bcc883f0ea2mr746955ybm.2.1686926532961; Fri, 16 Jun
 2023 07:42:12 -0700 (PDT)
Date:   Fri, 16 Jun 2023 07:42:11 -0700
In-Reply-To: <CAJzde06TP5D1UAko6tJmdPt-0Ja4cnByWEDF0c6KJ4k__WjODg@mail.gmail.com>
Mime-Version: 1.0
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com> <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZInLlkXsgnej9ZpT@google.com> <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
 <ZIxqAXhy1tCVpzz7@google.com> <CAJzde06TP5D1UAko6tJmdPt-0Ja4cnByWEDF0c6KJ4k__WjODg@mail.gmail.com>
Message-ID: <ZIx0w/1x7HbmOKYr@google.com>
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Allen Webb <allenwebb@google.com>
Cc:     Dmytro Maluka <dmy@semihalf.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Jason CJ Chen <jason.cj.chen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>, android-kvm@google.com,
        Dmitry Torokhov <dtor@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Allen Webb wrote:
> On Fri, Jun 16, 2023 at 8:56=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jun 16, 2023, Dmytro Maluka wrote:
> > > On 6/14/23 16:15, Sean Christopherson wrote:
> > > > On Wed, Jun 14, 2023, Elena Reshetova wrote:
> > > >>>> +This new type of adversary may be viewed as a more powerful typ=
e
> > > >>>> +of external attacker, as it resides locally on the same physica=
l machine
> > > >>>> +-in contrast to a remote network attacker- and has control over=
 the guest
> > > >>>> +kernel communication with most of the HW::
> > > >>>
> > > >>> IIUC, this last statement doesn't hold true for the pKVM on x86 u=
se case, which
> > > >>> specifically aims to give a "guest" exclusive access to hardware =
resources.
> > > >>
> > > >> Does it hold for *all* HW resources? If yes, indeed this would mak=
e pKVM on
> > > >> x86 considerably different.
> > > >
> > > > Heh, the original says "most", so it doesn't have to hold for all h=
ardware resources,
> > > > just a simple majority.
> > >
> > > Again, pedantic mode on, I find it difficult to agree with the wordin=
g
> > > that the guest owns "most of" the HW resources it uses. It controls t=
he
> > > data communication with its hardware device, but other resources (e.g=
.
> > > CPU time, interrupts, timers, PCI config space, ACPI) are owned by th=
e
> > > host and virtualized by it for the guest.
> >
> > I wasn't saying that the guest owns most resources, I was saying that t=
he *untrusted*
> > host does *not* own most resources that are exposed to the guest.  My u=
nderstanding
> > is that everything in your list is owned by the trusted hypervisor in t=
he pKVM model.
> >
> > What I was pointing out is related to the above discussion about the gu=
est needing
> > access to hardware that is effectively owned by the untrusted host, e.g=
. network
> > access.
>=20
> The network case isn't a great example because it is common for user
> space applications not to trust the network and to use verification
> schemes like TLS where trust of the network is not required, so the
> trusted guest could use these strategies when needed.=20

There's a bit of context/history that isn't captured here.  The network bei=
ng
untrusted isn't new/novel in the SNP/TDX threat model, what's new is that t=
he
network *device* is untrusted.

In the SNP/TDX world, the NIC is likely to be a synthetic, virtual device t=
hat is
provided by the untrusted VMM.  Pre-SNP/TDX, input from the device, i.e. th=
e VMM,
is trusted; the guest still needs to use e.g. TLS to secure network traffic=
, but
the device configuration and whatnot is fully trusted.  When the VMM is no =
longer
trusted, the device itself is no longer trusted.

To address that, the folks working on SNP and TDX started posting patches[1=
][2]
to harden kernel drivers against bad device configurations and whanot, but =
without
first getting community buy-in on this new threat model, which led us here[=
3].

There is no equivalent in existing userspace applications, because userspac=
e's
memory is not private, i.e. the kernel doesn't need to do Iago attacks to c=
ompromise
userspace, the kernel can simply read whatever memory it wants.

And for pKVM, my understanding is that devices and configuration informatio=
n that
are exposed to the guest are trusted and/or verified in some way, i.e. the =
points
of contention that led to this doc don't necessarily apply to the pKVM use =
case.

[1] https://lore.kernel.org/linux-iommu/20210603004133.4079390-1-ak@linux.i=
ntel.com
[2] https://lore.kernel.org/all/20230119170633.40944-1-alexander.shishkin@l=
inux.intel.com
[3] https://lore.kernel.org/lkml/DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8=
PR11MB5750.namprd11.prod.outlook.com
