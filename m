Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBF68ED6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBHK6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHK6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:58:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB61BD0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2221361616
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB92C4339B;
        Wed,  8 Feb 2023 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675853928;
        bh=1R6/GTmUFjHYLF6JxWCemPeZqa3OwU2ptAZJy7wanZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJqSs3MHgzZT+ABPPlw50AKhAcRN7n78voKk+Sev/UdXhhQOjmAKX3okDGt0gQTYu
         6izrl3WzC+0VxCZ+KUzumRRKmeF900jQpLZl7vpGk1KiCC73iKExCV+YZm3w2o9BEn
         iqOIs2zsIVEldC1JApd5GEVEHQ3Ofo2Vl7TDKf7s=
Date:   Wed, 8 Feb 2023 11:58:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <Y+OAZTljX1I6ZvR/@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
 <Y+MAPHZNLeBY13Pj@mit.edu>
 <20230208041913-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:44:25AM +0000, Reshetova, Elena wrote:
> 
> 
> > On Tue, Feb 07, 2023 at 08:51:56PM -0500, Theodore Ts'o wrote:
> > > Why not just simply compile a special CoCo kernel that doesn't have
> > > any drivers that you don't trust.
> 
> Aside from complexity and scalability management of such a config that has
> to change with every kernel release, what about the build-in platform drivers?

What do you mean by "built in platform drivers"?  You are creating a
.config for a specific cloud platform, just only select the drivers for
that exact configuration and you should be fine.

And as for the management of such a config, distros do this just fine,
why can't you?  It's not that hard to manage properly.

> I am not a driver expert here but as far as I understand they cannot be disabled
> via config. Please correct if this statement is wrong. 

Again, which specific drivers are you referring to?  And why are they a
problem?

> > In order to make $$$$$, you need to push the costs onto various
> > different players in the ecosystem.  This is cleverly disguised as
> > taking current perfectly acceptable design paradigm when the trust
> > boundary is in the traditional location, and causing all of the
> > assumptions which you have broken as "bugs" that must be fixed by
> > upstream developers.
> 
> The CC threat model does change the traditional linux trust boundary regardless of
> what mitigations are used (kernel config vs. runtime filtering). Because for the
> drivers that CoCo guest happens to need, there is no way to fix this problem by 
> either of these mechanisms (we cannot disable the code that we need), unless somebody
> writes a totally new set of coco specific drivers (who needs another set of 
> CoCo specific virtio drivers in the kernel?). 

It sounds like you want such a set of drivers, why not just write them?
We have zillions of drivers already, it's not hard to write new ones, as
it really sounds like that's exactly what you want to have happen here
in the end as you don't trust the existing set of drivers you are using
for some reason.

> So, if the path is to be able to use existing driver kernel code, then we need:

Wait, again, why?  Why not just have your own?  That should be the
simplest thing overall.  What's wrong with that?

> 1. these selective CoCo guest required drivers (small set) needs to be hardened 
>  (or whatever word people prefer to use here), which only means that in
> the presence of malicious host/hypervisor that can manipulate pci config space,
> port IO and MMIO, these drivers should not expose CC guest memory 
> confidentiality or integrity (including via privilege escalation into CC guest). 

Again, stop it please with the "hardened" nonsense, that means nothing.
Either the driver has bugs, or it doesn't.  I welcome you to prove it
doesn't :)

> Please note that this only applies to a small set (in tdx virtio setup we have less
> than 10 of them) of drivers and does not present invasive changes to the kernel
> code. There is also an additional core pci/msi code that is involved with discovery
> and configuration of these drivers, this code also falls into the category we need to
> make robust. 

Again, why wouldn't we all want "robust" drivers?  This is not anything
new here, all you are somehow saying is that you are changing the thread
model that the kernel "must" support.  And for that, you need to then
change the driver code to support that.

So again, why not just have your own drivers and driver subsystem that
meets your new requirements?  Let's see what that looks like and if
there even is any overlap between that and the existing kernel driver
subsystems.

> 2. rest of non-needed drivers must be disabled. Here we can argue about what 
> is the correct method of doing this and who should bare the costs of enforcing it. 

You bare that cost.  Or you get a distro to do that.  That's not up to
us in the kernel community, sorry, we give you the option to do that if
you want to, that's all that we can do.

> But from pure security point of view: the method that is simple and clear, that
> requires as little maintenance as possible usually has the biggest chance of
> enforcing security. 

Again, that's up to your configuration management.  Please do it, tell
us what doesn't work and send changes if you find better ways to do it.
Again, this is all there for you to do today, nothing for us to have to
do for you.

> And given that we already have the concept of authorized devices in Linux,
> does this method really brings so much additional complexity to the kernel? 

No idea, you tell us!  :)

Again, I recommend you just having your own drivers, that will allow you
to show us all exactly what you mean by the terms you keep using.  Why
not just submit that for review instead?

good luck!

greg k-h
