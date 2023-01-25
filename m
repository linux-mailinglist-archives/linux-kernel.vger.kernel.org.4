Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A767B2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjAYMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjAYMn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:43:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7A1284E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:43:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB265614C7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF5C433D2;
        Wed, 25 Jan 2023 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674650637;
        bh=PwIsHuwFo5nA+InprKfHzo+Ujv7Cp1wg7w1iCpL1uZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dC2b9msDOnCmEzmf7PQV9Mdx5tYHMlGaly3M9GNbfWV6mJ5aDKnRG9CoNb8/ViPin
         /qYDVPmaWvIK+81S+uoKRPSwSeu/xSC7fIDdMsynREM6gImZbjEqAw0zi5PqDlCpcQ
         R+rA+jKzEkorWePk4AEIk4+Hi2eRIHzqH80Do4qA=
Date:   Wed, 25 Jan 2023 13:43:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "Shishkin, Alexander" <alexander.shishkin@intel.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9EkCvAfNXnJ+ATo@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> Hi Greg, 
> 
> You mentioned couple of times (last time in this recent thread:
> https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> discussing the updated threat model for kernel, so this email is a start in this direction. 

Any specific reason you didn't cc: the linux-hardening mailing list?
This seems to be in their area as well, right?

> As we have shared before in various lkml threads/conference presentations
> ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 

That is, frankly, a very funny threat model.  How realistic is it really
given all of the other ways that a hypervisor can mess with a guest?

So what do you actually trust here?  The CPU?  A device?  Nothing?

> This is a big change in the threat model and requires both careful assessment of the 
> new (hypervisor <-> guest kernel) attack surface, as well as careful design of mitigations
> and security validation techniques. This is the activity that we have started back at Intel
> and the current status can be found in
> 
> 1) Threat model and potential mitigations: 
> https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html

So you trust all of qemu but not Linux?  Or am I misreading that
diagram?

> 2) One of the described in the above doc mitigations is "hardening of the enabled
> code". What we mean by this, as well as techniques that are being used are
> described in this document: 
> https://intel.github.io/ccc-linux-guest-hardening-docs/tdx-guest-hardening.html

I hate the term "hardening".  Please just say it for what it really is,
"fixing bugs to handle broken hardware".  We've done that for years when
dealing with PCI and USB and even CPUs doing things that they shouldn't
be doing.  How is this any different in the end?

So what you also are saying here now is "we do not trust any PCI
devices", so please just say that (why do you trust USB devices?)  If
that is something that you all think that Linux should support, then
let's go from there.

> 3) All the tools are open-source and everyone can start using them right away even
> without any special HW (readme has description of what is needed).
> Tools and documentation is here:
> https://github.com/intel/ccc-linux-guest-hardening

Again, as our documentation states, when you submit patches based on
these tools, you HAVE TO document that.  Otherwise we think you all are
crazy and will get your patches rejected.  You all know this, why ignore
it?

> 4) all not yet upstreamed linux patches (that we are slowly submitting) can be found 
> here: https://github.com/intel/tdx/commits/guest-next

Random github trees of kernel patches are just that, sorry.

> So, my main question before we start to argue about the threat model, mitigations, etc,
> is what is the good way to get this reviewed to make sure everyone is aligned?
> There are a lot of angles and details, so what is the most efficient method? 
> Should I split the threat model from https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html
> into logical pieces and start submitting it to mailing list for discussion one by one? 

Yes, start out by laying out what you feel the actual problem is, what
you feel should be done for it, and the patches you have proposed to
implement this, for each and every logical piece.

Again, nothing new here, that's how Linux is developed, again, you all
know this, it's not anything I should have to say.

> Any other methods? 
> 
> The original plan we had in mind is to start discussing the relevant pieces when submitting the code,
> i.e. when submitting the device filter patches, we will include problem statement, threat model link, 
> data, alternatives considered, etc. 

As always, we can't do anything without actual working changes to the
code, otherwise it's just a pipe dream and we can't waste our time on it
(neither would you want us to).

thanks, and good luck!

greg k-h
