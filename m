Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661A7337E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjFPSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:07:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E030FE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:07:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso1008708276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686938876; x=1689530876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/xcbkC1KM0iOBe2jwKeLHJYI8b7snTFL7pXba/BOVQ=;
        b=erpa4DvJNDkn0MUrlPUdqcaWtRan5xUjwEoAKe3Ux6fnyZ+sXru7zVyCRxkgBcvmDO
         HqNB7WYCGOAtZrKTbZmh8F+MeNIDf5ssYJVqJqdO4BmZSTAmFTjdZsItG8M9AzpxtG3R
         cwxug9zPJS52gTTR9PZl/6QmnnYTJUrNzSnJ4CBRzqKDFOtdFmOQ8iZSbfBATCwsVdqG
         8w/XlM3WeZ08IcA8l2NOo3oMoV28ATIpf+4/ZIA4kxFsJJX/yl4NtpsWyU0rQv3q5xFV
         xVfxkF3ePUUkQdSbdHAnS2g0kwAUALpkqIrTInlRzLpor0v0xA3qKqoPsxRRyQjaxbBc
         1UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686938876; x=1689530876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/xcbkC1KM0iOBe2jwKeLHJYI8b7snTFL7pXba/BOVQ=;
        b=Xhl3565DNoo371e9Ge5hXuqHqJ5haYpWfvnCS4kkj3z9zzuOdHt65jknzp4o+yutEA
         nxXbqmcghQRue+wGu/a7ApwbCWbF4f4GjZBVv22NRRDefKSzrPcUww6wUtVW7aMZeUWB
         t4TBFaitEGA+rIgeb5dpB7GEKaHvqA4Qi6qN+KmmXnqzf346KL/Nc8VTaZgkA5U8v9ns
         f/1CTKMchQ4hzXKvTvOnglOSCvIZ6fTJmI70/6zTAONFKu3H0HEZtadymUnEony7XSv+
         FzMpGkVwQbvnTe2Dm4HpySDY6Gztf7tabLxgv1GMTchFyZBbUAM7LhR46gfyknw9ZGTU
         za3Q==
X-Gm-Message-State: AC+VfDxymJB3fstuwnQ52+VQ5z3Beh6D4T0797++0IiqfHxf4ZPXUtp2
        V9ONrFjwEwcFXnn8i+z7BtpLznQXxv4=
X-Google-Smtp-Source: ACHHUZ5Ac+LnyDm+15iA1sr6WqjRANVRfUVldMjYwcIj5br/nW2L2Y0dHH3VChFq2DxoRfAK6YN0s/3bANw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:20d:0:b0:ba8:2e79:c193 with SMTP id
 13-20020a25020d000000b00ba82e79c193mr286501ybc.12.1686938876277; Fri, 16 Jun
 2023 11:07:56 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:07:54 -0700
In-Reply-To: <22438996-cea6-fcdc-530b-bf3f2477a81c@semihalf.com>
Mime-Version: 1.0
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com> <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZInLlkXsgnej9ZpT@google.com> <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
 <ZIxqAXhy1tCVpzz7@google.com> <22438996-cea6-fcdc-530b-bf3f2477a81c@semihalf.com>
Message-ID: <ZIyk+qIBRD6ezlPo@google.com>
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
Content-Type: text/plain; charset="us-ascii"
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
> On 6/16/23 15:56, Sean Christopherson wrote:
> > On Fri, Jun 16, 2023, Dmytro Maluka wrote:
> >> On 6/14/23 16:15, Sean Christopherson wrote:
> >>> On Wed, Jun 14, 2023, Elena Reshetova wrote:
> >>>>>> +This new type of adversary may be viewed as a more powerful type
> >>>>>> +of external attacker, as it resides locally on the same physical machine
> >>>>>> +-in contrast to a remote network attacker- and has control over the guest
> >>>>>> +kernel communication with most of the HW::
> >>>>>
> >>>>> IIUC, this last statement doesn't hold true for the pKVM on x86 use case, which
> >>>>> specifically aims to give a "guest" exclusive access to hardware resources.
> >>>>
> >>>> Does it hold for *all* HW resources? If yes, indeed this would make pKVM on
> >>>> x86 considerably different.
> >>>
> >>> Heh, the original says "most", so it doesn't have to hold for all hardware resources,
> >>> just a simple majority.
> >>
> >> Again, pedantic mode on, I find it difficult to agree with the wording
> >> that the guest owns "most of" the HW resources it uses. It controls the
> >> data communication with its hardware device, but other resources (e.g.
> >> CPU time, interrupts, timers, PCI config space, ACPI) are owned by the
> >> host and virtualized by it for the guest.
> > 
> > I wasn't saying that the guest owns most resources, I was saying that the *untrusted*
> > host does *not* own most resources that are exposed to the guest.  My understanding
> > is that everything in your list is owned by the trusted hypervisor in the pKVM model.
> 
> Heh, no. Most of these resources are owned by the untrusted host, that's
> the point.

Ah, I was overloading "owned", probably wrongly.  What I'm trying to call out is
that in pKVM, while the untrusted host can withold resources, it can't subvert
most of those resources.  Taking scheduling as an example, a pKVM vCPU may be
migrated to a different pCPU by the untrusted host, but pKVM ensures that it is
safe to run on the new pCPU, e.g. on Intel, pKVM (presumably) does any necessary
VMCLEAR, IBPB, INVEPT, etc. to ensure the vCPU doesn't consume stale data.

> Basically for two reasons: 1. we want to keep the trusted hypervisor as
> simple as possible. 2. we don't need availability guarantees.
> 
> The trusted hypervisor owns only: 2nd-stage MMU, IOMMU, VMCS (or its
> counterparts on non-Intel), physical PCI config space (merely for
> controlling a few critical registers like BARs and MSI address
> registers), perhaps a few more things that don't come to my mind now.

The "physical PCI config space" is a key difference, and is very relevant to this
doc (see my response to Allen).

> The untrusted host schedules its guests on physical CPUs (i.e. the
> host's L1 vCPUs are 1:1 mapped onto pCPUs), while the trusted hypervisor
> has no scheduling, it only handles vmexits from the host and guests. The
> untrusted host fully controls the physical interrupt controllers (I
> think we realize that is not perfectly fine, but here we are), etc.

Yeah, IRQs are a tough nut to crack.
