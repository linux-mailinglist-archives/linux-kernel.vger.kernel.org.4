Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE16560B38C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiJXRJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJXRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:08:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A11EEFA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666626247; x=1698162247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=scPGQVBLMaQrG09DIbO3cleczY2v35W9feMZEkD75Ak=;
  b=bMOZLLlVv+yD50YxnWchp55MIQiW3Asf09PyHnMNLFcIt7WBfLCG4HxL
   UlCgDdb8XJ+RYwSERT88Q3rWS1z+Dk8c44zqVdYcwVLhT0CYXY432HMVi
   nG+MrFBXQe8fhPve3an51+SVbku/UrguFuIozNwSvz70tB4hFEZgxpaSm
   bpd9dYJyV3wqjh7bQV7CmWtmvIOSq9t4oZJOiye6vuD/BXXTwfdnzr8tS
   LylVREQOPSqvWyiFj/HT/kRHWVeGA9CA5qBjvjby80b/7s9BYIJxblj3s
   avdTNb38/1xMV7e/PW+xaUNRWW9iMScFnYQkG+hqDVl4xlJY5dQEj9vQ4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="371669524"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="371669524"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:42:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609238440"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="609238440"
Received: from csun9-mobl.amr.corp.intel.com (HELO [10.209.104.152]) ([10.209.104.152])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:42:30 -0700
Message-ID: <dfd2fb43-2a19-545a-fea8-f793a685ef30@intel.com>
Date:   Mon, 24 Oct 2022 08:42:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
 <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
 <6636557f617ea5a1a1ab6f30f7aea0ececdd2a36.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <6636557f617ea5a1a1ab6f30f7aea0ececdd2a36.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 09:12, Zhang Rui wrote:
>>> I'm not sure if we have a perfect solution here.
>> Are the implementations fixable?
> currently, I don't have any idea.
> 
>>   Or, at least tolerable?

That would be great to figure out before we start throwing more patches
around.

>> For instance, I can live with the implementation being a bit goofy
>> when
>> kernel commandlines are in play.  We can pr_info() about those cases.
> My understanding is that the cpus in the last package may still have
> small cpu id value. This means that the 'logical_packages' is hard to
> break unless we boot with very small CPU count and happened to disable
> all cpus in one/more packages. Feng is experiencing with this and may
> have some update later.
> 
> If this is the case, is this a valid case that we need to take care of?

Well, let's talk through it a bit.

What is the triggering event and what's the fallout?

Is the user on a truly TSC stable system or not?

What kind of maxcpus= argument do they need to specify?  Is it something
that's likely to get used in production or is it most likely just for
debugging?

What is the maxcpus= fallout?  Does it over estimate or under estimate
the number of logical packages?

How many cases outside of maxcpus= do we know of that lead to an
imprecise "logical packages" calculation?

Does this lead to the TSC being mistakenly marked stable when it is not,
or *not* being marked stable when it is?

Let's get all of that info in one place and make sure we are all agreed
on the *problem* before we got to the solution space.
