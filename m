Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062967D3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAZSGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAZSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:06:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292723D83
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB07618F4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD75C433D2;
        Thu, 26 Jan 2023 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674756390;
        bh=tHltRXrnA6dUZq7inzUDFKsGsrQkPFVDwOWcAcd+SEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UspI6O9+kGa6OxND4wEmzaSzt6kMDbJbYZNLVlWrBIOyNnfwpOfLFSA+RaayEZWHt
         uOWnS5+Ac+kjuKavwLmI0PkroHH5Xqbit12qvtzkua5NfRVf5G4of5N2uvvLW0FBWN
         5rYP9fPlPTarZrJwHy59cRS7SU9p6t3xgjmSIYpyIX3BSxIxfxdVRLEvKpDbmUArZI
         ss5II0/mxOJLcXyqykSXGsjHe9aN5w1vzwZ8XgLTD41X88mQCuohpsH1+Ara9rhGH4
         RNDFwlFuSlSDLNSIzdxbwX6cgwN/iLzhBIMUKv95i7Z+GfbC6HD4VoOpS77T8Io4aM
         NZZhuhJCBfuBw==
Date:   Thu, 26 Jan 2023 20:06:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9LBInM4uBNCSMDT@unreal>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9KG6g0CHlnKwuW+@work-vm>
 <DM8PR11MB57509016CEF6C939DCBD718FE7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57509016CEF6C939DCBD718FE7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:48:33PM +0000, Reshetova, Elena wrote:
> 
> > * Reshetova, Elena (elena.reshetova@intel.com) wrote:
> > > > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena wrote:
> > > > > Replying only to the not-so-far addressed points.
> > > > >
> > > > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > > > > Hi Greg,
> > > >
> > > > <...>
> > > >
> > > > > > > 3) All the tools are open-source and everyone can start using them right
> > > > away
> > > > > > even
> > > > > > > without any special HW (readme has description of what is needed).
> > > > > > > Tools and documentation is here:
> > > > > > > https://github.com/intel/ccc-linux-guest-hardening
> > > > > >
> > > > > > Again, as our documentation states, when you submit patches based on
> > > > > > these tools, you HAVE TO document that.  Otherwise we think you all are
> > > > > > crazy and will get your patches rejected.  You all know this, why ignore
> > > > > > it?
> > > > >
> > > > > Sorry, I didn’t know that for every bug that is found in linux kernel when
> > > > > we are submitting a fix that we have to list the way how it has been found.
> > > > > We will fix this in the future submissions, but some bugs we have are found
> > by
> > > > > plain code audit, so 'human' is the tool.
> > > >
> > > > My problem with that statement is that by applying different threat
> > > > model you "invent" bugs which didn't exist in a first place.
> > > >
> > > > For example, in this [1] latest submission, authors labeled correct
> > > > behaviour as "bug".
> > > >
> > > > [1] https://lore.kernel.org/all/20230119170633.40944-1-
> > > > alexander.shishkin@linux.intel.com/
> > >
> > > Hm.. Does everyone think that when kernel dies with unhandled page fault
> > > (such as in that case) or detection of a KASAN out of bounds violation (as it is in
> > some
> > > other cases we already have fixes or investigating) it represents a correct
> > behavior even if
> > > you expect that all your pci HW devices are trusted? What about an error in
> > two
> > > consequent pci reads? What about just some failure that results in erroneous
> > input?
> > 
> > I'm not sure you'll get general agreement on those answers for all
> > devices and situations; I think for most devices for non-CoCo
> > situations, then people are generally OK with a misbehaving PCI device
> > causing a kernel crash, since most people are running without IOMMU
> > anyway, a misbehaving device can cause otherwise undetectable chaos.
> 
> Ok, if this is a consensus within the kernel community, then we can consider
> the fixes strictly from the CoCo threat model point of view. 
> 
> > 
> > I'd say:
> >   a) For CoCo, a guest (guaranteed) crash isn't a problem - CoCo doesn't
> >   guarantee forward progress or stop the hypervisor doing something
> >   truly stupid.
> 
> Yes, denial of service is out of scope but I would not pile all crashes as
> 'safe' automatically. Depending on the crash, it can be used as a
> primitive to launch further attacks: privilege escalation, information
> disclosure and corruption. It is especially true for memory corruption
> issues. 
> 
> >   b) For CoCo, information disclosure, or corruption IS a problem
> 
> Agreed, but the path to this can incorporate a number of attack 
> primitives, as well as bug chaining. So, if the bug is detected, and
> fix is easy, instead of thinking about possible implications and its 
> potential usage in exploit writing, safer to fix it.
> 
> > 
> >   c) For non-CoCo some people might care about robustness of the kernel
> >   against a failing PCI device, but generally I think they worry about
> >   a fairly clean failure, even in the unexpected-hot unplug case.
> 
> Ok.

With my other hat as a representative of hardware vendor (at least for
NIC part), who cares about quality of our devices, we don't want to hide
ANY crash related to our devices, especially if it is related to misbehaving
PCI HW logic. Any uncontrolled "robustness" hides real issues and makes
QA/customer support much harder.

Thanks
