Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7F64B2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiLMKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiLMKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:09:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72B62D9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670926162; x=1702462162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y7mWiA5z3JdJhnUdjaksIrJ99mKqEF14NUmSP2j4CxM=;
  b=kx6UYUj7hE7Nu3aAkQDkglVrlMKh9ocU+aTL5rYzXshxQ6+K8ZBAI2O+
   lz0QALe7NmbAARIZ9SFqY8I2zhghP2EShC+tExbne8W5d8zUCQcXlyPG5
   OWv0/B1IhO75Aij0HcKB+UhdVP059pN8akS1xlpHiBjZ5NfHhKFiOIlR6
   bUadQ+ATH/mnzUtyqCW6fnLeCgGmUzTa3YHuuQLRNjs5pL5UnR7R5d7b9
   jII590Pu0Fk3ZdubRAmEcvTVNAbBULAnx3LYG55uiuhYMNzTUHDtrRt7r
   M7stHrjrhY7qPEOGAzPOYDyGFPCyl310QydDhQ4KUh6b4is7ZaJrKGqLG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319240455"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="319240455"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 02:09:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="712021323"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="712021323"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.28.83]) ([10.213.28.83])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 02:09:14 -0800
Message-ID: <398d55d0-3256-238e-132a-195baaf7f4a6@intel.com>
Date:   Tue, 13 Dec 2022 11:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [Intel-gfx] [PATCH 1/5] linux/minmax.h: add non-atomic version of
 xchg
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <Y5OE3AX7DS/DfClX@smile.fi.intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <Y5OE3AX7DS/DfClX@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.2022 19:56, Andy Shevchenko wrote:
> On Fri, Dec 09, 2022 at 04:48:39PM +0100, Andrzej Hajda wrote:
>> The pattern of setting variable with new value and returning old
>> one is very common in kernel. Usually atomicity of the operation
>> is not required, so xchg seems to be suboptimal and confusing in
>> such cases. Since name xchg is already in use and __xchg is used
>> in architecture code, proposition is to name the macro exchange.
>>
>> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
>> ---
>> Hi,
>>
>> I hope there will be place for such tiny helper in kernel.
>> Quick cocci analyze shows there is probably few thousands places
>> where it could be used, of course I do not intend to do it :).
>>
>> I was not sure where to put this macro, I hope near swap definition
>> is the most suitable place.
> 
> Ah, swap() in this context is not the same. minmax.h hosts it because
> it's often related to the swap function in the sort-type algorithms. > >> Moreover sorry if to/cc is not correct - get_maintainers.pl was
>> more confused than me, to who address this patch.
> 
> ...
> 
>>   include/linux/minmax.h | 14 ++++++++++++++
> 
> Does it really suit this header? I would expect something else.
> Maybe include/linux/non-atomic/xchg.h, dunno.

non-atomic seems quite strange for me, I would assume everything not in 
atomic is non-atomic, unless explicitly specified.

> 
> Btw, have you looked if Ingo's gigantic series have done anything to cmpxchg.h
> and related headers? Maybe some ideas can be taken from there?
> 

Grepping it didn't give any clue.

Looking at 'near' languages just to get an idea (they name the function 
differently):

C++ [1]: exchange and swap are in utility header
Rust[2]: replace and swap are in std::mem module

This is some argument to put them together.

[1]: https://en.cppreference.com/w/cpp/header/utility
[2]: https://doc.rust-lang.org/std/mem/index.html

Regards
Andrzej

