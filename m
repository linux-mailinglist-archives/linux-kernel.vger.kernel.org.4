Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1164A52E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiLLQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiLLQjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:39:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2FA165AC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670863042; x=1702399042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9m98shoiHRD8thtXOIoPpIhyXXaG4Y2A8foSH8f3lII=;
  b=g2H5xoQZq90wK8V+efipKd8Uem/RMG0was2r9R3XPM4O0lVgDWRXncRg
   o/2NLwhnEn5+HiZLvQZVQcZr6Ngk1MAmd8VfNjeItUz0MCkVUPfO+vIeE
   cL56PZ421bhcjbp4fbhiwJ+YO6BbyKN9Bf8Gh3+pAmedyA8tPYUpDY6R3
   4LtjTY37dcwjq7pZ6KyMX4J4KxvVTJ6A3H0Tx64E2oUBASOOBTZFXFnA4
   g/ArM+nKlJ6SNMDi4GmKlhCOmsgDRgyqAo547pPq6VmCDOawcs2MCMqcC
   62JR3qprMTPG88M/DoZ5wi0b9b1xpF1Vz9d9POunlr9i9lSoJoPPaFn6V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="317929849"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="317929849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 08:37:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="822545833"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="822545833"
Received: from vasanth1-mobl.amr.corp.intel.com (HELO [10.251.4.160]) ([10.251.4.160])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 08:37:09 -0800
Message-ID: <f1937bd1-0400-608d-3cda-b9597c0e4393@linux.intel.com>
Date:   Mon, 12 Dec 2022 08:37:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <e79c4b97-5718-9a60-406f-1df994ba089c@linux.intel.com>
 <20221209170647.r32yjyc3hsqtnffo@box.shutemov.name>
 <2e305bb5-9595-3531-6134-24344ff5c797@linux.intel.com>
 <e13331b2-a68c-c823-d02f-ba50949214cb@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e13331b2-a68c-c823-d02f-ba50949214cb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/22 8:10 AM, Dave Hansen wrote:
> On 12/9/22 12:51, Sathyanarayanan Kuppuswamy wrote:
>>>>> +	while (1) {
>>>>> +		__tdx_hypercall(&args, 0);
>>>>> +	}
>>>> Instead of an infinite loop, I'm wondering if the guest should panic after
>>>> retrying for few times.
>>> Hm. What difference would it make?
>> IIUC, the goal of this patch is to report the fatal error to VMM and panic.
>> But, if VMM does not terminate the guest as we expect, rather than trying 
>> continuously, isn't it better to panic ourselves? That way the behavior
>> will be similar to what we have currently.
> 
> What does "panic ourselves" mean exactly?  What is the current behavior
> which that would match?

I meant directly calling panic(). Before this patch, if the SEPT VE DISABLE
attribute was not set, we would call panic(). In this patch, we try to report
the error to VMM and wait for it to terminate the guest in the same case.
But after reporting the error, if VMM does not terminate the guest as expected,
I thought instead of retrying continuously, we can call panic() directly after
some retries. 


> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
