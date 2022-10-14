Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAC5FEB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJNJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJNJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:01:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C194170DC9;
        Fri, 14 Oct 2022 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665738110; x=1697274110;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PyLfj9vufEmvAjD1zEhcRmlredi/7EfQLLd8DYWF1+s=;
  b=K1+Pl3DWqnJhbieSihoi3cCa3PO2f/y5wW/fshUv9Eme81RIl2avL38Y
   d+cSW67u/V0SgSjdW0FnoxIo2Dcu83/U/Br9wNbRe6oQTdAmENYd9YjVB
   /ImlsZSbOgNbcdWjQM5oyHWzOEcZK8GYeUpsZb8cm0AazeI7xGqmMBLuH
   0o0lOsZ0sEyAfsydaHr/CTOUVjhnusSXcmPA4dyMLvot0gVQGB8676S5p
   L5EeOgxkFqSXox+5ezOSUBqJSb2HLUXjZEYmegOYlCTfcPdOO+uLUuuFh
   c6inKmYpMT1tnrmYbtZdsI5/RnrTn0BoyFYEM/MMf5S9o3/2dZN38x80Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="369515341"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="369515341"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 02:01:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690470445"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690470445"
Received: from keweilu-mobl.ccr.corp.intel.com ([10.254.208.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 02:01:45 -0700
Message-ID: <1ca9f3e8e52ccbca151f00d0514fae9262791f55.camel@intel.com>
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, corbet@lwn.net, fenghua.yu@intel.com,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com
Date:   Fri, 14 Oct 2022 17:01:42 +0800
In-Reply-To: <Y0ka/UKSEb36BPxt@hirez.programming.kicks-ass.net>
References: <20220922133800.12918-1-rui.zhang@intel.com>
         <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
         <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
         <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
         <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
         <0307a5881c875e0b104051792b0f5e7f0ff973c1.camel@intel.com>
         <147a619e-e595-90c5-7a2a-ffbc2d20be7c@intel.com>
         <Y0ka/UKSEb36BPxt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-14 at 10:17 +0200, Peter Zijlstra wrote:
> On Thu, Oct 13, 2022 at 08:19:03PM -0700, Dave Hansen wrote:
> > On 10/13/22 19:06, Zhang Rui wrote:
> > > Patch 4/8 ~ 5/8 are real fixes and they depends on patch 2/8 and
> > > 3/8 to
> > > avoid possible regressions. So patch 2/8 ~ 5/8 should be stable
> > > material.
> > > 
> > > patch 6/8 is also a bugfix, but we have not observed any
> > > functionality
> > > issues so far.
> > 
> > If you want to make this really easy on me, you could take the
> > changelog
> > and comment revisions that I made in that testing branch that I
> > shared,
> > integrate them, and send it out again, and *only* include the
> > bugfixes.
> 
> It's really simple; if it don't have a Fixes tag, it ain't a fix :-)

Thanks for pointing this out.
Patches updated with Fixes tag in V4 series.

thanks,
rui

