Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8FD7392BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjFUW6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:58:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D219AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687388297; x=1718924297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XyZi0tLe5yLvTI2TlFkR3CvZQjJ1rTFfCx4cp0H2vh8=;
  b=d1XiKGBVlnE+YZCw2iTCVzpBEeN1+gx+RGBmfveH3vcFoJPimFhYzDBV
   d3xs9IJZVbrC8WR4qpo63XgSkZJo+TkF1CMKqbtdV4GQRogqcQkt/7dvY
   sVJAuMB1+HxjTEKhjhdfPdQP1tVQBrJ4FAj6814jTqpB+sT2qI80pwHoH
   ppAIfdJp08ShgQejIOeGg9/gRsR1y12TMhFP+SdbEg1x2ZxJKetqnR+y7
   zuyjG1RJoagAIQ1ftVTV3pBYvHDMKUIxDMhtss0Jn6OFhgtcfUy9vfEFJ
   r3MmRUCXhsR9E0hz5Ybp9UZxBxf9k/erJB971SeNYrcZ3XVKIACVdyUxI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357825278"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357825278"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:58:16 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="748916643"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="748916643"
Received: from rmathew-mobl2.amr.corp.intel.com (HELO [10.212.134.235]) ([10.212.134.235])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:58:10 -0700
Message-ID: <0c908258-2b03-ebb3-bc7d-af5ea66479d4@intel.com>
Date:   Wed, 21 Jun 2023 15:58:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk> <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk> <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
 <d9bc78ed-1f05-47db-e916-d4d8bc76634e@intel.com> <ZJN/SGwvOBZmChJw@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZJN/SGwvOBZmChJw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 15:52, Breno Leitao wrote:
> On Wed, Jun 21, 2023 at 03:35:45PM -0700, Dave Hansen wrote:
>> On 6/21/23 12:41, Pawan Gupta wrote:
>>> Yes, a single series (or a patch) that adds config for each mitigation
>>> would be good.
>> Do people _really_ want per-mitigation compile-time controls?  That
>> seems like kinda a pain.
>>
>> I Boris suggested it, but it seems like a _bit_ of overkill to me.
>>
>> Would a compile-time option that just defaulted _everything_ to
>> mitigations=off behavior work instead?  That way we don't end up with a
>> billion new config options.
> This is exactly what my original patch proposed. It solves the problem with
> a few lines of changes.
> 
> https://lore.kernel.org/lkml/20230203120615.1121272-1-leitao@debian.org/

Hey Boris,

I like this simple thingy better.  If for no other reason than it
reduces the burden of what we have to do for every _new_ mitigation
going forward.

Do you like the direction this is going?  Maybe I'm missing something.
