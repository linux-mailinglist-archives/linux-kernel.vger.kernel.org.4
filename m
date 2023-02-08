Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7468F486
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjBHR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBHR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:29:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D414FCCC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 480CB6173F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE903C433D2;
        Wed,  8 Feb 2023 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675877348;
        bh=3+VXQQUoFNE4y9ReCy+tNNais9kMLdSPpobhI6EHw3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yd/w3C8t7WAOIil+J0Etrn39O6ietPRfA9teoj0XVLyzzA2lp5THnwob+bC46jR/v
         VesSXoQN/Ba+sT2Fa10WhTZCadrMu/rQ739yH96hyYSD4srowiVWDDbvXC2ydnAOgY
         2d7xjgvolf1+3rbvLDRJB4GYfmTP5i/BPS/dwlSk=
Date:   Wed, 8 Feb 2023 18:29:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y+Pb4Ood56Wxn4sj@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
 <Y+MAPHZNLeBY13Pj@mit.edu>
 <20230208041913-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y+OAZTljX1I6ZvR/@kroah.com>
 <m2edr03xh4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2edr03xh4.fsf@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:19:37PM +0100, Christophe de Dinechin wrote:
> 
> On 2023-02-08 at 11:58 +01, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote...
> > On Wed, Feb 08, 2023 at 10:44:25AM +0000, Reshetova, Elena wrote:
> >>
> >> The CC threat model does change the traditional linux trust boundary regardless of
> >> what mitigations are used (kernel config vs. runtime filtering). Because for the
> >> drivers that CoCo guest happens to need, there is no way to fix this problem by
> >> either of these mechanisms (we cannot disable the code that we need), unless somebody
> >> writes a totally new set of coco specific drivers (who needs another set of
> >> CoCo specific virtio drivers in the kernel?).
> >
> > It sounds like you want such a set of drivers, why not just write them?
> > We have zillions of drivers already, it's not hard to write new ones, as
> > it really sounds like that's exactly what you want to have happen here
> > in the end as you don't trust the existing set of drivers you are using
> > for some reason.
> 
> In the CC approach, the hypervisor is considered as hostile. The rest of the
> system is not changed much. If we pass-through some existing NIC, we'd
> rather use the existing driver for that NIC rather than reinvent
> it.

But that is not what was proposed.  I thought this was all about virtio.
If not, again, someone needs to write a solid definition.

So if you want to use existing drivers, wonderful, please work on making
the needed changes to meet your goals to all of them.  I was trying to
give you a simple way out :)

> >> 1. these selective CoCo guest required drivers (small set) needs to be hardened
> >>  (or whatever word people prefer to use here), which only means that in
> >> the presence of malicious host/hypervisor that can manipulate pci config space,
> >> port IO and MMIO, these drivers should not expose CC guest memory
> >> confidentiality or integrity (including via privilege escalation into CC guest).
> >
> > Again, stop it please with the "hardened" nonsense, that means nothing.
> > Either the driver has bugs, or it doesn't.  I welcome you to prove it
> > doesn't :)
> 
> In a non-CC scenario, a driver is correct if, among other things, it does
> not leak kernel data to user space. However, it assumes that PCI devices are
> working correctly and according to spec.

And you also assume that your CPU is working properly.  And what spec
exactly are you referring to?  How can you validate any of that without
using the PCI authentication protocol already discussed in this thread?

> >> Please note that this only applies to a small set (in tdx virtio setup we have less
> >> than 10 of them) of drivers and does not present invasive changes to the kernel
> >> code. There is also an additional core pci/msi code that is involved with discovery
> >> and configuration of these drivers, this code also falls into the category we need to
> >> make robust.
> >
> > Again, why wouldn't we all want "robust" drivers?  This is not anything
> > new here,
> 
> What is new is that CC requires driver to be "robust" against a new kind of
> attack "from below" (i.e. from the [virtual] hardware side).

And as I have said multiple times, that is a totally new "requirement"
and one that Linux does not meet in any way at this point in time.  If
you somehow feel this is a change that is ok to make for Linux, you will
need to do a lot of work to make this happen.

Anyway, you all are just spinning in circles now.  I'll just mute this
thread until I see an actual code change as it seems to be full of
people not actually sending anything we can actually do anything with.

greg k-h
