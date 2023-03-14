Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B76B9A81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjCNQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjCNQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:01:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9AA3B57
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678809708; x=1710345708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r0VX/GIYJ1UZ3WSQfnwj06orRjs0JjhC14AkYrDJGrA=;
  b=cmdU22/qmJyxbWgBu4xC70XiaO+nuL7X2P7xDvPULkRJA8TGV+5pS0dS
   /WTiRZcy9ZP5kGfgWfje4dWDs64EjLdX5wFL5PWoCLIKd28PQA1bBdlEp
   jGd3bLtAzo7x+Nu5OaT5Ae7B/zfJaG4AMsavuF4prX+b4WzjLWqYWy09y
   lg4Hti2b2rmdBw4BQSCGlFTedYq6U04ij/CcSfMnGYrDr7fTJqiJLmdHx
   yh9ig25Co2R3NT0Y2Yt6pRxwHf2cMigmwaXDla+rCM+565F/ZNV4TZO2X
   DIvuGy0w3W+u2UofvUaG8TX2xijdQCH2GcPv9Dn7y9mWwSl45AEnVTWBp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="334953869"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="334953869"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656398070"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="656398070"
Received: from jstavrid-mobl.amr.corp.intel.com (HELO [10.212.216.78]) ([10.212.216.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:01:19 -0700
Message-ID: <ada3e064-fdb3-afc5-8c0c-bff54a591189@intel.com>
Date:   Tue, 14 Mar 2023 09:01:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86/amd: Work around Erratum 1386 - XSAVES malfunction on
 context switch
Content-Language: en-US
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Monakov <amonakov@ispras.ru>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <20230307174643.1240184-1-andrew.cooper3@citrix.com>
 <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
 <940596cc-a440-181a-a72a-36282a26dd0a@citrix.com>
 <20230307185632.GDZAeI4LwBDUU3/OP9@fat_crate.local>
 <ee866b3e-a53b-4c26-0272-20e798c0650d@citrix.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ee866b3e-a53b-4c26-0272-20e798c0650d@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 12:01, Andrew Cooper wrote:
> On 07/03/2023 6:56 pm, Borislav Petkov wrote:
>> On Tue, Mar 07, 2023 at 06:22:01PM +0000, Andrew Cooper wrote:
>>> Well yes - more and more reports of impacted systems.
>>>
>>> Having the full list of affected models is great and all, but how is it
>>> going to change this patch as a workaround ?
>> We don't have to clear the feature flag on those systems which have
>> a fix.
> Sure, but why is that helpful?
> 
> XSAVES and XSAVEC are functionally identical on Zen1/2 because these
> CPUs don't advertise any supervisor XSAVE states.

On Intel at least, XSAVES uses the modified optimization and XSAVEC does
not.  I'm not sure if you include this in your definition of
"functionally identical", but it is one of those little XSAVE
architecture oddities that's bitten me a time or two.

The AMD docs don't talk about the modified optimization verbatim, but I
think this nugget is alluding to the same behavior:

> 4. XRSTOR loads an internal state value XRSTOR_INFO that can be used to further optimize a
> subsequent XSAVEOPT or XSAVES. This reflects the current privilege level and virtualization
> mode as well as the save area's base address and XCOMP_BV field.


