Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFF686DED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBAS2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:28:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04114AD25
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276081; x=1706812081;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KJfvR0PNRjVIZ5qVTjcc05Xxt8yxLl4gMU5LDLRTEu0=;
  b=ZS/BmpPImOtMdT7aj84rMFE3dBbAtFKv6JuwyLmzFHLEbiFb4zzgyPec
   WLr1R5ig/Tke6B1Oh8cZiHe21ykT1nh4CQTOKYCasz84xGbThSz1AWJ0B
   QmjEF7YbQrqkjUMDMsVz6REFAxPbJw5oQEMQxv0JoS8v39GlNQRng79Wp
   nKorZKkm6NhmjfwgHT4sLpsJgwOLqPJI1qrBfCZLThRE4HOe+PEMFUcDk
   Nry/u4iRTNuWL0doBEOxa2t4mPEFxOR++7q3r2TRb1wmpJt9ERMEn8nIS
   hmkmyJJiGxTaA2BiUbQ3z8kGbm0wvEx7b5wJfJfr21z/0LD6VPKhoIZ4V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414437036"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="414437036"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:20:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667009268"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="667009268"
Received: from sgkhacha-mobl1.amr.corp.intel.com (HELO [10.212.227.86]) ([10.212.227.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:20:34 -0800
Message-ID: <b1ea8d3b-d5f4-0aac-d7b4-45fef9afe778@intel.com>
Date:   Wed, 1 Feb 2023 10:20:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        "Chen, Yian" <yian.chen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
 <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
 <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
 <9e0a8b20-cb76-b06d-67fb-f8942df5a2f7@intel.com>
 <f8352c29-6b9f-2711-ddf4-223a6806f42f@intel.com>
 <ed41ccf1-8f2d-6d4a-7692-7a3465aca73a@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ed41ccf1-8f2d-6d4a-7692-7a3465aca73a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 18:25, Sohil Mehta wrote:
>> 	/*
>> 	 * Set cr4 to a known state:
>> 	 *  - physical address extension enabled
>> 	 *  - 5-level paging, if it was enabled before
>> 	 */
>> 	movl	$X86_CR4_PAE, %eax
>> 	testq	$X86_CR4_LA57, %r13
>> 	jz	1f
>> 	orl	$X86_CR4_LA57, %eax
>> 1:
>> 	movq	%rax, %cr4
>>
>> 	jmp 1f
>> 1:
> Dave, does this address your concern or were you looking for something
> else? Is there some path other than kexec that should also be audited
> for this scenario?

Yep, that addresses it.  I don't know of any other path that would
matter.  Couldn't hurt to poke around and look for other CR4
manipulation that might need to be LASS-aware, though.

