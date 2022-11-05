Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2584861A762
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKEDtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:48:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B656BEC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667620135; x=1699156135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/b+BfNBdoLmIoUOEm2BmKecQlLl2LYOXTwt+If0z6WQ=;
  b=DPv6oXR7oQLr2lRl32JWKY+L4IqD3lW04yao25syUqXT4skovi6nwhgo
   SPrlisGtegV+mLktn7xeslsMnAe/MbGUca27jo6ECV+xOvpoitx82t2/S
   9T47wYYSUa4q05xBw1PZygJsFNie9rvowXy7jRxoYfzezBhZecqMgMqxr
   bEtu+LWvZ5Y8DmYUZjHTFLWq7hLIGiKkhnZ53uHEawVGaJs+yQqmJoVDQ
   hr7Not4YwI/ZCi4t1QBNvVzHL0DmFIS2DCvd6Tktgx9JDHo2kr4scPR0+
   uAnxyLUcbYFBeEEb6LvQ58dskE258WrcS3F6PJ1GAbUzpoaJiNxUrIZ7q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="396427113"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="396427113"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 20:45:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="760542221"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="760542221"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 20:45:12 -0700
Date:   Sat, 5 Nov 2022 03:45:09 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Andrew Cooper <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <Y2XcRbaN9mDkWF9V@araj-dh-work>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
 <YvzbFXnBjNjK+UJK@araj-dh-work>
 <Yvz53AAh+p5Db7CK@zn.tnic>
 <Yv0JQGa/2BlbQChZ@araj-dh-work>
 <Yv0vu6OqCptK6gc+@zn.tnic>
 <Yv1WXxcIXSQ7nMji@araj-dh-work>
 <Yv1j8v7o3lOniUoH@zn.tnic>
 <Yv4NXOlLHcx1Ghf3@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv4NXOlLHcx1Ghf3@araj-dh-work>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Thu, Aug 18, 2022 at 09:58:52AM +0000, Ashok Raj wrote:
> Hi Boris
> 
> On Wed, Aug 17, 2022 at 11:56:02PM +0200, Borislav Petkov wrote:
> > On Wed, Aug 17, 2022 at 08:58:07PM +0000, Ashok Raj wrote:
> > > For this specific patch in question, its not for testing though.. Its
> > > required for functional purposes?
> > 
> > From its commit message:
> > 
> > "However, there are microcode patches which do per-thread modification,
> > see Link tag below.
> > 
> 
> I did read the commit log. I was just stating the fact that reload isn't
> just for testing, for e.g. in this case its required for functional
> reasons.
> 
> if cpu_rev > ucode_rev, there is no need to reload microcode correct?
> There are a bunch of changes in the original post that seemed like it had
> nothing to do with force load on a sibling.
> 
> Completely untested, no commit log to spare you from fixing them :-)
> 
> Seemed like we were simply passing over each other with emails, thought
> I'll convey what I meant here via a patch. Hope this helps.
> 
> lemme know what you think.

I saw your original patch got tipbot notification, but I don't see the
patch in the staging area. 

I didn't see a followup to this, and wasn't sure if you fixed it some other
way.

I was cleaning up my mbox and want to be sure I didn't drop the ball. 

Cheers,
Ashok
