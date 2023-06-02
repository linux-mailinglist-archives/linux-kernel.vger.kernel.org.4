Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45772093C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjFBSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFBSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:36:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4E2196
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685731017; x=1717267017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YI4FleBJ4T8uCBrMKZe3t4UjlD12FzgHx+1Hx9ifem4=;
  b=iuDJlCZklx1UTiWllY5jQD06p6B6gck20hFu4eAFMIMuNICYcx7Ngvk6
   ZHwLqCf1LPUxBuv21I5kFwbN2JGajxwilD8d+1UywDipbPn41CHyfAocw
   24Mh0e/qqancgZ5mzjLdAIEdPg3iSZskNaVq0W3YBEPI1acyoYMwVQyn+
   arLc+Vb6XdkDaq9HAxF4zBRKjLgyE1KMVZLdeEpdWhPVJ5sxkKRixwVyf
   U7r4FxiJ6bpMnZVZpzCKRi7LwFSNjOC+qt2TZ7S6peZ1Whv/7m10CR8VI
   +YpjeR4DGxbv9x4N6a2mV7yUU/geo7QyREr+WOm/H8K1/l8R8bpyXJWlE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="358368253"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="358368253"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852242091"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="852242091"
Received: from pingshi-mobl.amr.corp.intel.com (HELO [10.251.23.169]) ([10.251.23.169])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:36:54 -0700
Message-ID: <73283eba-14b8-2da1-6109-c183586fe5b7@intel.com>
Date:   Fri, 2 Jun 2023 11:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Content-Language: en-US
To:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, rui.zhang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx> <934e9008-36db-492b-b744-9d68183c6d32@paulmck-laptop>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <934e9008-36db-492b-b744-9d68183c6d32@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 11:29, Paul E. McKenney wrote:
>>> One downside is, many VMs also has X86_FEATURE_TSC_KNOWN_FREQ set,
>>> and they will also do this recalibration.
>> It's also pointless for those SoCs which lack legacy hardware.
>>
>> So why do you force this on everyone?
> Just for the record, this patch could be helpful in allowing victims
> of TSC mis-synchronization to more easily provide a more complete bug
> report to the firmware people.  There is of course no point if there is
> already a fix available.
> 
> But it is not all that hard to work around not having this patch upstream.
> This can be hand-applied as needed, NTP drift rates can be pressed
> into service for those of us having atomic clocks near all our servers,
> or the firmware guys can be tasked with figuring it out.
> 
> So this patch would be nice to have, but we could live without it.

Is this the kind of thing we could relegate to a kernel unit test?  Like
make the recalibration logic _available_, but don't have it affect the
rest of the system.

I love patching my kernel as much as the next guy.  But, you know what I
*don't* love?  Explaining how to patch kernels to other people. ;)
