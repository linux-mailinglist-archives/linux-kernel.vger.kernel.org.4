Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2C686DC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBASTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBASTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:19:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D61B7BE6D;
        Wed,  1 Feb 2023 10:19:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3981761901;
        Wed,  1 Feb 2023 18:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18537C433D2;
        Wed,  1 Feb 2023 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675275558;
        bh=b+wlHDCzi8AdBnLpjdjGeEQLMS0qfahPSzCmwkMSiqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptKD62LX78owda4w+Y0RYSwG/OXKHYW9gSEjj671KQR76Ta78vlE4GMdxxs917kzR
         PCfbb2N85zBghqkfACFMRL+3ZxXNtYLf4aSBG0SAHb6yFKqDEANTmgwPUc4JdE0Bql
         UNksukzT9Zu1Bgzqhmcu/MxeVgzk4miNdZdxRHbw=
Date:   Wed, 1 Feb 2023 19:19:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Message-ID: <Y9qtI+CZaX051rLo@kroah.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <Y9nyWVNtfBEny66w@kroah.com>
 <SJ1PR11MB6083EBD2D2826E0A247AF242FCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083EBD2D2826E0A247AF242FCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:22:18PM +0000, Luck, Tony wrote:
> > > +/* MSR_ARRAY_BIST bit fields */
> > > +union ifs_array {
> > > +   u64     data;
> > > +   struct {
> > > +           u32     array_bitmask           :32;
> > > +           u32     array_bank              :16;
> > > +           u32     rsvd                    :15;
> > > +           u32     ctrl_result             :1;
> >
> > This isn't going to work well over time, just mask the bits you want off
> > properly, don't rely on the compiler to lay them out like this.
> 
> What is this "time" issue?  This driver is X86_64 specific (and it seems
> incredibly unlikely that some other architecture will copy this h/w
> interface so closely that they want to re-use this driver. There's an x86_64
> ABI that says how bitfields in C are allocated. So should not break moving
> to other C compilers.

Ok, but generally this is considered a "bad idea" that you should not
do.  It's been this way for many many years, just because this file only
runs on one system now, doesn't mean you shouldn't use the proper apis.

Also, odds are, using the proper apis will get you faster/smaller code
than using a bitfield like this as compilers were notorious for doing
odd things here in the past.

> Is there going to be a "re-write all drivers in Rust" edict coming soon?

Don't be silly, it's been this way for drivers for decades.

> 
> > Note, we have bitmask and bitfield operations, please use them.
> 
> We do, but code written using them is not as easy to read (unless
> you wrap in even more macros, which has its own maintainability
> issues).

It shouldn't be that hard, lots of people use them today.

Try and see!

thanks,

greg k-h
