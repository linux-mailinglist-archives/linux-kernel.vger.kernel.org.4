Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD8712EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbjEZVR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjEZVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:17:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B9BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685135841; x=1716671841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jvczHAS3VHMKx9c3PkNvEtFNL1bha8QOhxzfjqa/32Q=;
  b=IgOW90pRrtVLC7l3erPJRr79ofoQUuIbpLQEGp5gWFdOHLN7gacodLTp
   FCToTRBAjQDwJcxllGZYiMcOR1aVZ15zxxEFkhD7Q0Cld3bHnE+ooZndJ
   oDmK29dGgbHWw5ga7xlGHzzJowqA11s8uzKrbbBx6xXgvv028JrjCRbst
   RKmE2CmX4ZCjv+C8ivHfC1vxkAt5fe+YB2dhEXURNdxNDoev6pCnouHJm
   +iu6r+9KofqnuyCLHpT2kFTKRe1NA7NOK00k/FMZKvLwCIrzVwzyiU2dI
   ypfQaBVkZ1O3MNJtBrC2o4YLH1KxJ/SnswcmUa9gZCH4QtG6bPQrSQ5lp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="343803602"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="343803602"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="775209657"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="775209657"
Received: from ggreenle-mobl1.amr.corp.intel.com (HELO [10.212.214.91]) ([10.212.214.91])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 14:17:20 -0700
Message-ID: <e6cd1909-2776-28d2-ccc0-4b3d2d09e9ce@intel.com>
Date:   Fri, 26 May 2023 14:17:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
 <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
 <20230526204559.GAZHEahxxnQaHhSUul@nazgul.local>
 <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <D63AB9E6-BA52-4E24-B8EF-C7B9DB1595CC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 14:10, Nadav Amit wrote:
>>> I did not ask to make them global. Just to keep them as local after
>>> linkage in the executable, like all other functions in the kernel.
>> Ok, not global. But local and present in the symbol table:
>>
>> 105185: ffffffff81b89330    17 NOTYPE  LOCAL  DEFAULT    1 bad_get_user_clac
>>
>> And again, this helps how exactly?
> Allowing debuggers, tracers, disassemblers and instrumentation tools to
> work the same way they work as they work with any other piece of code in
> the kernel.
> 
> I personally work on code instrumentation and this makes my life hard for
> no good reason.
> 
> [ Perhaps the question should go the other way around: why addresses of
> code in these functions should not be mapped to any symbol? ]

Nadav, is there a chance you could give us a real-life example of how
this affects you as an end user?  What's a specific tool that you were
using or a specific problem that you were trying to solve where these
local symbols caused a problem?  How would the global symbol have helped?

I can certainly _imagine_ some, but I'm curious what you saw that
prompted you to send this patch.
