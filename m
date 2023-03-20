Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20966C1A07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCTPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjCTPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:42:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9C36463
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679326427; x=1710862427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oq7Wui3I94lahNhshgANSPuzTUgQnDPMOCGMMVDE6/o=;
  b=j8Yz2kt9vLoefJ6ta7wQuOaLGW8IqElKYQRthO3UY234QcPL4+uSsk5g
   doFBbnQqvgvGQeT9kGMfUGleZr40VfWFxOx0T4VDQTwNNiLxMYrGWLiv+
   Gtl1/Qk8niF587u+s44KYWwb7Li2i2xYL5KHyq+CaaVOnpQt9G/rwATix
   GR2TUyakIlwT06qXm9ZBsk5j9GECbczNU541tvTQAZWmLkoEZ4aWyCGnO
   dcA5AREdWLEocSEh3lyn0i2GTlIfdRuI4kkY57A6n6DRkqVTj+t1+WLU8
   GHrQrU4UiGVyPV60bPF/3Xk+fkPEebc5Nnt8nKgndHwVF100S828IN2VW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322534146"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="322534146"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770239461"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="770239461"
Received: from vrchili-mobl2.amr.corp.intel.com (HELO [10.209.117.85]) ([10.209.117.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 08:31:48 -0700
Message-ID: <422b2b56-499e-da5c-b071-7c5f2cd27569@intel.com>
Date:   Mon, 20 Mar 2023 08:31:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 07/12] x86/mtrr: allocate mtrr_value array dynamically
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-8-jgross@suse.com>
 <cad6b9d384c3a87803023289ae4ade1ba1a4c49b.camel@intel.com>
 <d1ed7b07-d485-6f73-901b-25478fa4f303@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d1ed7b07-d485-6f73-901b-25478fa4f303@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 06:49, Juergen Gross wrote:
>>>
>>> @@ -750,6 +750,7 @@ static int __init mtrr_init_finialize(void)
>>>        * TBD: is there any system with such CPU which supports
>>>        * suspend/resume? If no, we should remove the code.
>>>        */
>>> +    mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value),
>>> GFP_KERNEL);
>>
>> Theoretically dynamic allocation can fail, although it should not
>> happen as this
>> happens during kernel boot and the size is small.  Maybe a WARN()?
> 
> Fine with me.

What *actually* happens if the system is running out of memory and this
is the _first_ failure?  Does a WARN_ON() here help someone debug what
is going on?
