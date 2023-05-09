Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4916FCDF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjEISnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjEISnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:43:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CC1BE6;
        Tue,  9 May 2023 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683657793; x=1715193793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ns/DgmDbnP4/Q//p/4/Xg24rWlw4B0v3hnjX6n9BFBI=;
  b=bqiV3vwaQjkq3DKZCGoizEQKKqDmdY2evcszXmS+ocmM+Iwbn5rlPrl8
   /KOvtrwSZc5O1FrgZHdt+AsQcDNej0qEALueLqpkn0KzWgM+SbfjEbY28
   ePi+eFCcPhD7A3Fjmn8fEM2EdHuKiPat2htGNtzFMalcDXnx/oaWrWOPJ
   jl0kBiTpJpxjt5+pJxS+LrKMZ5aW7Rxs+rcsKM6YwKKZtQKvyDSoP/bjw
   85yEhA8nUUSBjHCkxVxZBY1JWvtM4rjNYyJtA4RXtqio3nRxqoxYEhD+B
   3ffkjgSGQEIOBy934Lg0APtOUvf617mGLct2lOUpGgBKNY3LB7xa6cSn2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436339707"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="436339707"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1028918545"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="1028918545"
Received: from dcourtn1-desk1.amr.corp.intel.com (HELO [10.212.182.218]) ([10.212.182.218])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 11:43:13 -0700
Message-ID: <c0dcbda3-e131-2460-4c61-e98d0be750ff@intel.com>
Date:   Tue, 9 May 2023 11:43:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
 <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com>
 <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
 <ea00d762-b0df-ab72-988b-98c62ffc7949@intel.com>
 <20230509184135.GDZFqT3yC/j5bJA1l5@fat_crate.local>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230509184135.GDZFqT3yC/j5bJA1l5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 11:41, Borislav Petkov wrote:
> On Tue, May 09, 2023 at 11:38:27AM -0700, Dave Hansen wrote:
>> This actually isn't _great_ for x86.  We hid X86_FEATURE_NAMES behind
>> EMBEDDED because we didn't want to see it 99% of the time.  But just
>> about everyone uses EXPERT=y, so the end result here is that everyone
>> will now see X86_FEATURE_NAMES.
>>
>> Oh well.  It's just one Kconfig option.  Not a big deal.
> Or we can make it unconditional. I haven't heard anything from the tiny
> .config folks in a while and a !X86_FEATURE_NAMES kernel is just
> unfriendly.

Like remove the option entirely?  Or just remove the prompt so folks
have to hack the .config for it?
