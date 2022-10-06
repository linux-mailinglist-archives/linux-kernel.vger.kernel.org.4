Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5A5F7120
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJFW3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:29:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718FBF2;
        Thu,  6 Oct 2022 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665095376; x=1696631376;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=k3VDWwiUKZLEvjl46lh7KsMqnfu7pLgXi6thYeJCce4=;
  b=QvdG5G15msbQrX9Hl5cC8Nr0PwRQC4U6F321LBjJ4DaBX+XY+H7qGJ/R
   kxW/gOaxpi3ovmRssyUW+JK0zTCxILhQyH6bOCbHVeWMJ/gMU8fq6rr2V
   2fN23B8veeGVj6G6vaAnBX3P62LzUd/MPqJz4k3HRq6HKrFDlqAbULv+3
   fIUAebX3y7HMAHa5nq3Lh243L9tMYP6NbiS3EFOR1u/M7r50NEd8PBiFd
   aSKi5jHa51PzrISrxYgT17Xs30zGYCrQQdK1U0Sczq7SyttaB8SrQt8Uu
   1Rit0sZTe0Rp50iOslHJduyy+HgIc/JJv+oAX4ugDiG8bA72JahuCSm4Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="290852693"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="290852693"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:29:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="750321487"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="750321487"
Received: from iitotia-mobl1.amr.corp.intel.com (HELO [10.212.143.59]) ([10.212.143.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:29:35 -0700
Message-ID: <3dfccc80-e089-4915-d57e-96d26b237182@intel.com>
Date:   Thu, 6 Oct 2022 15:29:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        ira.weiny@intel.com
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <3694452.kQq0lBPeGt@mypc> <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
 <8124835.T7Z3S40VBb@mypc>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8124835.T7Z3S40VBb@mypc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 15:02, Fabio M. De Francesco wrote:
> On Thursday, October 6, 2022 10:45:56 PM CEST Dave Hansen wrote:
> Am I still missing anything fundamental?

Yes. :)

kmap() users can sleep.  That means the number of them that you need to
keep around is unbounded.  kmap_atomic()'s fundamentally can't sleep so
you need fewer of them.  That means that when you kunmap_atomic() you
can use a simple, fast, CPU-local TLB flushing operation.  kunmap()
eventually requires a big fat global TLB flush.

So, you're right.  On lowmem-only systems, kmap() *can* be cheaper than
kmap_atomic().  But, on highmem systems there's no contest:
kmap_atomic() is king.

That's why kmap_atomic() is and should be the default.

>> You use kmap_atomic() *always* unless you _need_ to sleep or one
>> of the other kmap()-only things.
> 
> What would happen if you rely on switching in atomic as a side effect of 
> kmap_atomic() and then you convert to kmap_local_page() without explicitly 
> disabling, for example, preemption since who converts don't care to know if 
> the code is in atomic before calling kmap_atomic() before or after the call 
> (as I said there may be cases where non atomic execution must disable 
> preemption for some reasons only between the mapping and the unmapping?
> 
> If I were a maintainer I wouldn't trust changes that let me think that the 
> developer can't tell if we need to disable something while converting to 
> kmap_local_page().

In this case, it's just not that complicated.  The SGX code isn't
relying on anything subtle that kmap_local_page() does not provide.
