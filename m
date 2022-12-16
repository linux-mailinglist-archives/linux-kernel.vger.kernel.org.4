Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAF64E5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLPCiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLPCit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:38:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4E43855
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671158328; x=1702694328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Can1VMciW9+iGry05ZaUPplZlSS1yfiZiqhl/6xn7us=;
  b=kFNDa3rLuCwj4OgaD6t96IdMuT6WaxnqabYSqkHethKTK40IcbSRMiW2
   2ARI2PgR08a9W8w12e9YRKNvgypq9Bat1xTuxKDhqSZFY3FKHWTGhS0gO
   5yiOyDV7zxisQTEiiWrqQL7cKngE7Or6PX3cNrufhQo2gXc+1MX5LIvcZ
   6HYuGp5T4ShS1uR+aW/w5Q173Z846oIQeb20cUVARQfudDqbZMu0W/7Tx
   45nG76RCo339ZZCPlzlOFeJ6crnqE+YqG2Lykfs/CH6oF8V//+rR6YNEe
   DEerOlu7aF6qjmpP1pvgsA/kalnkNzF513lJuhiLDP3DVtQD0Axh9Pmiz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="383195696"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="383195696"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 18:38:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="599787679"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="599787679"
Received: from ivklotch-mobl.ccr.corp.intel.com (HELO box.shutemov.name) ([10.249.39.236])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 18:38:44 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A8E3E100557; Fri, 16 Dec 2022 05:38:41 +0300 (+03)
Date:   Fri, 16 Dec 2022 05:38:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Message-ID: <20221216023841.g7ebxefl2zglagek@box.shutemov.name>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
 <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
 <795d6e1d-c79c-b079-3412-69ca2f8ee874@intel.com>
 <20221215185144.tjctmkwp5vodep3u@box>
 <b19600bd-d5cf-3359-60d8-1ecd9c1ff4f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19600bd-d5cf-3359-60d8-1ecd9c1ff4f5@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 01:09:10PM -0800, Dave Hansen wrote:
> On 12/15/22 10:51, Kirill A. Shutemov wrote:
> >>> So ReportFatalError() is no good for the task. And I don't have anything
> >>> else :/
> >> Do we *really* have to do a hard stop when SEPT_VE_DISABLE is missing?
> >>
> >> Wouldn't it be simpler to just defer the check until we can spit out a
> >> sane error message about it?
> >>
> >> Or is there too much security exposure by continuing?
> > Well, I guess we can. We always have attestation as a backstop. No
> > sensitive user data has to be exposed to the TD before it passed
> > the attestation.
> 
> OK, so let's just pretend that SEPT_VE_DISABLE=0 is a blatant root hole
> that lets the VMM compromise the TDX guest (I know it's not, but let's
> just pretend it is).
> 
> The guest starts up, the VMM compromises it after the attestation has
> run.  The now compromised guest send along its report.  But, since the
> report contains (or implies???) SEPT_VE_DISABLE=0, the guest will be
> assumed to be compromised and won't get any secrets provisioned?
> 
> That assumes that the attestation service knows that SEPT_VE_DISABLE==0
> plus Linux is bad.  Is that a good assumption?

I know that attestation quote includes all required information
(attributes and kernel hash) to make the decision and I assume that
attestation service is competent. So, yes, I think expectation Linux +
SEPT_VE_DISABLE==0 going to be rejected is reasonable.

Elena, is there anything you can elaborate on here?

> > Do you prefer to have a separate initcall just to check SEPT_VE_DISABLE?
> 
> I don't feel strongly about where the check should be as long as it can
> get a message out to the console.

I would rather keep current approach with simple tdx_panic() for early
use if it works for you.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
