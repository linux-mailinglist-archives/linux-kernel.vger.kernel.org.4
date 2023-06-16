Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4817332B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345254AbjFPN5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbjFPN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:57:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878D73A87
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:56:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569fee67d9dso17853607b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686923779; x=1689515779;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fLjpuuUE/jNF1tH6F57kU3/oz9GcPLjPemMOCQa+1A=;
        b=kNEwOe7XFugcmTjzejkuLqe708dE86ZSA2Z02MR+itoEcBA1IIXVGzEzNcM+7B/yit
         /G4/KfRJfYi8TfuA+schY99QKI/TgMRFSYQ3YShmf+jecxNfsH3FIycYHMvFkGYx3dO6
         csX3FpYeN9nHCvPR5xqobGs5gY/sWUAvRRDrsHMm4O/O/5Os7zOZs5Kn9EgWQFrxh4yp
         N3ffTABcIaPkXXPUx2UnPJ+63qtXb5iRnFA1BvlKY85/2QpvaUgCXGQ7Bbjqpa4jFC5K
         dYPkhAwcHFMJzsjx5/8e7eryiOfCf+EYLwADTFT7G50bhph4lhHC4vtoySHvJ5NdcK9u
         MgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686923779; x=1689515779;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+fLjpuuUE/jNF1tH6F57kU3/oz9GcPLjPemMOCQa+1A=;
        b=gz5LfAHEEkPXsa3QAgr6VtviOZd0+O8T+iBrsxaQ57FqU6O2RpesgRi2Mpjw9DrbS9
         xQglfq+caFUhc3Eep19OXV6xTIM27IfcqjwpP8eJ9fgy+tmX//nKzmlp9ZAD67sQa1Th
         84WNG+sm4jsemZrFPcXo4vTfnXUKV3qn/iCB9AnQAB6sJgyy5iC7a8JOjbWnIPGqiLDy
         b7cPXQ3Iaye1mXwih3jEJJ+FLnc5UqYvXNemUBOqUembCb3+hqMmagryw2tKDMbcUIDx
         44Icqaff13c3HzIEN0aldKJC+bxbtENd3qTYVwCIF1GIExg26sljhnZFrm3QmYPg0tGH
         QNlg==
X-Gm-Message-State: AC+VfDzpRX8AF+jYfn4oQmwKAxnrpYEP51sWcVOGf9qqI99pZPa1fmW1
        lepe1pKYNKY+0hcIkTUyvDtcmUZCeWI=
X-Google-Smtp-Source: ACHHUZ7OzTA93Y1I7rU1NhrUcAYr1UEs7VGzDreSZWqL5hTvLcWQja6Louv3bjofLUuDe8EyPzVEx6z26Vk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ac04:0:b0:56d:5db:2f07 with SMTP id
 k4-20020a81ac04000000b0056d05db2f07mr3772639ywh.5.1686923778815; Fri, 16 Jun
 2023 06:56:18 -0700 (PDT)
Date:   Fri, 16 Jun 2023 06:56:17 -0700
In-Reply-To: <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
Mime-Version: 1.0
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com> <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZInLlkXsgnej9ZpT@google.com> <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
Message-ID: <ZIxqAXhy1tCVpzz7@google.com>
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Dmytro Maluka <dmy@semihalf.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
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
        Allen Webb <allenwebb@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Dmytro Maluka wrote:
> On 6/14/23 16:15, Sean Christopherson wrote:
> > On Wed, Jun 14, 2023, Elena Reshetova wrote:
> >> Not having a network access requirement doesn=E2=80=99t implicitly inv=
alidate the=20
> >> separation guarantees between the host and guest, it just makes it eas=
ier
> >> since you have one interface less between the host and guest.
> >=20
> > My point is that if the protected guest doesn't need any I/O beyond the=
 hardware
> > device that it accesses, then the threat model is different because man=
y of the
> > new/novel attack surfaces that come with the TDX/SNP threat model don't=
 exist.
> > E.g. the hardening that people want to do for VirtIO drivers may not be=
 at all
> > relevant to pKVM.

...

> But I think I get what you mean: there is no data transfer whereby the
> host is not an endpoint but an intermediary between the guest and some
> device. In simple words, things like virtio-net or virtio-blk are out of
> scope. Yes, I think that's correct for pKVM-on-x86 use cases (and I
> suppose it is correct for pKVM-on-ARM use cases as well). I guess it
> means that "guest data attacks" may not be relevant to pKVM, and perhaps
> this makes its threat model substantially different from cloud use
> cases.

Yes. =20

> >>>> +This new type of adversary may be viewed as a more powerful type
> >>>> +of external attacker, as it resides locally on the same physical ma=
chine
> >>>> +-in contrast to a remote network attacker- and has control over the=
 guest
> >>>> +kernel communication with most of the HW::
> >>>
> >>> IIUC, this last statement doesn't hold true for the pKVM on x86 use c=
ase, which
> >>> specifically aims to give a "guest" exclusive access to hardware reso=
urces.
> >>
> >> Does it hold for *all* HW resources? If yes, indeed this would make pK=
VM on
> >> x86 considerably different.
> >=20
> > Heh, the original says "most", so it doesn't have to hold for all hardw=
are resources,
> > just a simple majority.
>=20
> Again, pedantic mode on, I find it difficult to agree with the wording
> that the guest owns "most of" the HW resources it uses. It controls the
> data communication with its hardware device, but other resources (e.g.
> CPU time, interrupts, timers, PCI config space, ACPI) are owned by the
> host and virtualized by it for the guest.

I wasn't saying that the guest owns most resources, I was saying that the *=
untrusted*
host does *not* own most resources that are exposed to the guest.  My under=
standing
is that everything in your list is owned by the trusted hypervisor in the p=
KVM model.

What I was pointing out is related to the above discussion about the guest =
needing
access to hardware that is effectively owned by the untrusted host, e.g. ne=
twork
access.
