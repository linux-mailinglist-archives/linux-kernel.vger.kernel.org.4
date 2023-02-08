Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3268F00E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjBHNoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjBHNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:43:51 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140764942C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:43:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 318DgZaj013022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 08:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675863760; bh=xyb6v65nXuHP/xG5TcxP1ne6MztEMsgn/VqCrtkrf9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HJGrzMDtNqQUvEs34B3TQmwiLMRpnmdRZpR1xMITfSZH5tk/6ZRko4EfF7OKOhx1y
         CRxNyCkhyDZyyVt6OIIKvX4fS4KCA/VyCNM1lkOh4LFxmKtTyWfD/ySX0j3YZwa8Ti
         g4/S23TNi1ldNDMrkqWMxMHdgxajG7koDrN0yBEF/MCCNqiMkZFymjtzjYVcDGsSSq
         rBTqR7ZlYlDEs3ffpZey4lKf+nYs3/Dkt/j69PNO09MnStayU3twnlcUUaJLFIC2p4
         9NBO3x5p0r27mi7Q1pMo3JT6T3jxPlq80HMtJ0lnllBU+XpA+2cPLsxKcG+0hiYZlY
         UjoSRMcr1NgXA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E6DF015C35A2; Wed,  8 Feb 2023 08:42:34 -0500 (EST)
Date:   Wed, 8 Feb 2023 08:42:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
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
Message-ID: <Y+OmytFP2ASNXil5@mit.edu>
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
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:44:25AM +0000, Reshetova, Elena wrote:
> 2. rest of non-needed drivers must be disabled. Here we can argue about what 
> is the correct method of doing this and who should bare the costs of enforcing it. 
> But from pure security point of view: the method that is simple and clear, that
> requires as little maintenance as possible usually has the biggest chance of
> enforcing security. 
> And given that we already have the concept of authorized devices in Linux,
> does this method really brings so much additional complexity to the kernel? 
> But hard to argue here without the code: we need to submit the filter proposal first
> (under internal review still).

I think the problem here is that we've had a lot of painful experience
where fuzzing produces a lot of false positives which then
security-types then insist that all kernel developers must fix so that
we can see the "important" security issues from the false positives.

So "as little maintenance as possible" and fuzzing have not
necessarily gone together.  It might be less maintenance costs for
*you*, but it's not necessarily less maintenance work for *us*.  I've
seen Red Hat principal engineers take completely bogus issues and
raise them to CVE "high" priority levels, when it was nothing like
that, thus forcing distro and data center people to be forced to do
global pushes to production because it's easier than trying to explain
to FEDramp auditors why the CVE SS is bogus --- and every single
unnecessary push to production has its own costs and risks.

I've seen the constant load of syzbot false positives that generate
noise in my inbox and in bug tracking issues assigned to me at $WORK.
I've seen the false positives generated by DEPT, which is why I've
pushed back on it.  So if you are going to insist on fuzzing all of
the PCI config space, and treat them all as "bugs", there is going to
be huge pushback.

Even if the "fixes" are minor, and don't have any massive impact on
memory used or cache line misses or code/maintainability bloat, the
fact that we treat them as P3 quality of implementation issues, and
*you* treat them as P1 security bugs that must be fixed Now!  Now!
Now! is going to cause friction.  (This is especially true since CVE
SS scores are unidimentional, and what might be high security --- or
at least embarassing --- for CoCo, might be completely innocuous QOI
bugs for the rest of the world.)

So it might be that a simple, separate, kerenl config is going to be
the massively simpler way to go, instead of insisting that all PCI
device drivers must be fuzzed and be made CoCo safe, even if they will
never be used in a CoCo context.  Again, please be cognizant about the
costs that CoCo may be imposing and pushing onto the rest of the
ecosystem.

Cheers,

					- Ted
