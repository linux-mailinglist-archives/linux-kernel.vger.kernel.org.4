Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1E68CF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBGGDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGGDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:03:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB07298FB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:03:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 835F2CE1C9C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BA1C433EF;
        Tue,  7 Feb 2023 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675749787;
        bh=n0NSw6MLeyqaJNIB2F0bB4A/V51VTRATE/PybeUZGeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lq+fuoKJWnx5lwARuKY8fU+ugkgKvxmnmh/wFX7tUoTQM1p8cHZYpQzcu6oES9p5j
         UT4YZIbx9zIBGdQlil9TetkVt3C1vzsVtli86X15g/HRoGuso2qjnCZqbI4Lrq4hfV
         OAkrv5Bz5aHu3eMR/Ulh4c61HzIVjj/qp7DQmRhg=
Date:   Tue, 7 Feb 2023 07:03:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <Y+HpmIesY96cYcWQ@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:27:48PM -0600, Carlos Bilbao wrote:
> On 1/25/23 6:28 AM, Reshetova, Elena wrote:
> > 2) One of the described in the above doc mitigations is "hardening of the enabled
> > code". What we mean by this, as well as techniques that are being used are
> > described in this document: > https://intel.github.io/ccc-linux-guest-hardening-docs/tdx-guest-hardening.html
> 
> Regarding driver hardening, does anyone have a better filtering idea?
> 
> The current solution assumes the kernel command line is trusted and cannot
> avoid the __init() functions that waste memory.

That is two different things (command line trust and __init()
functions), so I do not understand the relationship at all here.  Please
explain it better.

Also, why would an __init() function waste memory?  Memory usage isn't
an issue here, right?

> I don't know if the
> __exit() routines of the filtered devices are called, but it doesn't sound
> much better to allocate memory and free it right after.

What device has a __exit() function?  Drivers have module init/exit
functions but they should do nothing but register themselves with the
relevant busses and they are only loaded if the device is found in the
system.

And what exactly is incorrect about allocating memory and then freeing
it when not needed?

So again, I don't understand the question, sorry.

thanks,

greg k-h
