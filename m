Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD45F68E59D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBHBxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBHBxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:53:37 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66413DEC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:53:34 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3181pu6l006504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 20:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675821122; bh=5fUlmHVo8EqeNtEv09IzdSEnwXA8A1TlW7h4INci1bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=J5/ggEOJpG8DyjY3ouEYgPuqBuBy5x5aZ8ZdKGt+CrAAArhjK3ua3bVQVRRF1GkW7
         KzJEiZVfW7nNZf8zou5eKrVhFGcZb6giJuloszaEbUZctafNnuWZpXxPhhui+Eq/kx
         mrY2ViKd58pObbxIglPG/9r2FZ78TQq76aoMMyXcMGEpnW4TSPS01qnFYT6F9s9k+E
         WGFdGqyo0tqRF6T6hBDdbSQ8T0yoYubCQA9YEC5I+VZGIB7OOwha9JdodPRGwoJHl2
         gdRnkSAW0+kUBVLVqyaDRnmczQynXUOJvHpo+OMUBrkyyC99EjD52fe2IdupRjfJeG
         XF3LQPtMQ1Xqw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4453E15C35A2; Tue,  7 Feb 2023 20:51:56 -0500 (EST)
Date:   Tue, 7 Feb 2023 20:51:56 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y+MAPHZNLeBY13Pj@mit.edu>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:53:34PM -0600, Carlos Bilbao wrote:
> Currently proposed device filtering does not stop the __init() functions
> from these drivers to be called. Whatever memory is allocated by
> blacklisted drivers is wasted because those drivers cannot ever be used.
> Sure, memory can be allocated and freed as soon as it is no longer needed,
> but these memory would never be needed.
> 
> 
> More pressing concern than wasted memory, which may be unimportant, there's
> the issue of what are those driver init functions doing. For example, as
> part of device setup, MMIO regs may be involved, which we cannot trust. It's
> a lot more code to worry about from a CoCo perspective.

Why not just simply compile a special CoCo kernel that doesn't have
any drivers that you don't trust.  Now, the distros may be pushing
back in that they don't want to support a separate kernel image.  But
this apparently really a pain allocation negotiation, isn't it?  Intel
and other companies want to make $$$$$ with CoCo.

In order to make $$$$$, you need to push the costs onto various
different players in the ecosystem.  This is cleverly disguised as
taking current perfectly acceptable design paradigm when the trust
boundary is in the traditional location, and causing all of the
assumptions which you have broken as "bugs" that must be fixed by
upstream developers.

But another place to push the costs is to the distro vendors, who
might need to maintain a separate CoCo kernel that is differently
configured.  Now, Red Hat and company will no doubt push back.  But
the usptream development community will also push back if you try to
dump too much work on *us*.

				- Ted
