Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8948E6C0B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCTHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCTHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:42:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105BA2367D;
        Mon, 20 Mar 2023 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679298131; x=1710834131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sbk48kWeR8tcGPniYaN2WncLmsXVlFjZA1OnqsPsU0g=;
  b=k4jDM68kHpKp5zUykaYSTXap0EHHQymqIAo3EH+lsd+N2rB4WsQS54tz
   qr0YaaMRASackeDdgvLWqfGeNEg5lG9XLdcWO+YU3NH6pTbvDnFiFhxXb
   k32ViwJ4i3qD2BsDUsmIje5mCk9k2eqbO50WGExHtb25e9DZaT5y49oaY
   dWPOc61G7uxwydr3Kgme8606ITz2Bx9AhaxWtYVApW43UCsBRrem08plX
   f+K6ycqYXVe1L6d1Stq+qD0CR7fla6Hr88P4gUhDYugIclvoI/HPN2nqF
   uh8H1nsvb2/EoWugS8mJXAcCN1QtaSQqgqc6QmWpW+R2ksXjlgyfQjMlF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340956000"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="340956000"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 00:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="804812795"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="804812795"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2023 00:42:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BCC5E1CC; Mon, 20 Mar 2023 09:42:53 +0200 (EET)
Date:   Mon, 20 Mar 2023 09:42:53 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Tom Rix <trix@redhat.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: rename shadowed variables bit to
 interrupt_bit and auto_clear_bit
Message-ID: <20230320074253.GA62143@black.fi.intel.com>
References: <20230315220450.1470815-1-trix@redhat.com>
 <20230316102048.GR62143@black.fi.intel.com>
 <20230316103744.GS62143@black.fi.intel.com>
 <2802c4c6-99d4-e084-baa4-5be7c123ddd6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2802c4c6-99d4-e084-baa4-5be7c123ddd6@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 08:33:58PM -0500, Mario Limonciello wrote:
> 
> On 3/16/23 05:37, Mika Westerberg wrote:
> > On Thu, Mar 16, 2023 at 12:20:48PM +0200, Mika Westerberg wrote:
> > > +Cc Mario
> > > 
> > > On Wed, Mar 15, 2023 at 06:04:50PM -0400, Tom Rix wrote:
> > > > cppcheck reports
> > > > drivers/thunderbolt/nhi.c:74:7: style: Local variable 'bit' shadows outer variable [shadowVariable]
> > > >    int bit;
> > > >        ^
> > > > drivers/thunderbolt/nhi.c:66:6: note: Shadowed declaration
> > > >   int bit = ring_interrupt_index(ring) & 31;
> > > >       ^
> > > > drivers/thunderbolt/nhi.c:74:7: note: Shadow variable
> > > >    int bit;
> > > >        ^
> > > > For readablity rename the outer to interrupt_bit and the innner
> > > > to auto_clear_bit.
> > > Thanks for the patch! Yeah, this did not show up in any of the kbuild
> > > tests perhaps they are missing cppcheck :(
> > > 
> > > I'm thinking that I'll just move the two commits from "fixes" to "next"
> > > and add this one on top (and drop the stable tags) as the code that we
> > > should be sending to stable should not need additional fixes IMHO. I
> > > know Mario is on vacation so probably cannot answer here so let's deal
> > > with this when he is back.
> > Applied to thunderbolt.git/next (along with the two commits from Mario).
> 
> Thanks for the fix Tom!
> 
> Mika - It's unfortunate that a fixup was needed but I'd still like if we
> can get these 3 commits into 6.3-rc and also to stable.

Fair enough. I moved them into fixes now.
