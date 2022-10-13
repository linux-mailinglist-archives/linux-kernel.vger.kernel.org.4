Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C086C5FDF34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJMRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:44:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE030107CFD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665683072; x=1697219072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fMNF/crpspLBkNONcxAtBMjQqkGRhHUU38huokuciFo=;
  b=MFCtHikAvNDq+dciwpNgz85z3tHBrJQZWh5Ob/ePPxUjl/weY/+vt2Af
   0lycoaiuQzTwTUQpSxdPz9pBjmFAQgjw6lKUtnudspbW8EEtVAaniQNHD
   cbEYV3mT3+d0pea4v30P/9gtNVcDip9c3MlbgokSFXF88/PKduwZIC1vC
   VAl/09ezyP0YFwtGTLpRrTRVL3Sz4vAC/0ciOxDh/azrCVi+X6hwOpxcq
   kiw1AoiTiHLdytu0YVlDzDEigbjot81o29hXm8bORvURftTUCoSwXZWSJ
   4lw+4zSeHQ2zfn9W3DweE9W8bIuvHgK4tOraO2grH2pqmThZPpffUSVmw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="306808944"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="306808944"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 10:44:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="605071129"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="605071129"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 10:44:27 -0700
Message-ID: <dd5815fa-ec61-b7d1-c0b3-70cd0f33bbee@intel.com>
Date:   Thu, 13 Oct 2022 10:44:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
 <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
 <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
 <9be1413b-ce30-acf8-86fb-3e302dc98396@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9be1413b-ce30-acf8-86fb-3e302dc98396@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 10:33, Chang S. Bae wrote:
>>>
>>> -       mask = fpstate->user_xfeatures;
>>> +       mask = fpstate->user_xfeatures & fpstate->xfeatures;
>>
>> I'm not sure this is quite right either.
>>
>> Doesn't kvm expect that all of the ->user_xfeatures will end up being
>> copied out?  We surely can't copy them from 'fpstate' if the feature
>> isn't there, but we can't skip them entirely, can we?
> 
> No, we can't skip them. IIUC, the code will zero out:
> 
>     /*
>      * ... The gap tracking will zero these states.
>      */
>     mask = fpstate->user_xfeatures;
> 
>     for_each_extended_xfeature(i, mask) {
>         /*
>          * If there was a feature or alignment gap, zero the space
>          * in the destination buffer.
>          */
>         if (zerofrom < xstate_offsets[i])
>             membuf_zero(&to, xstate_offsets[i] - zerofrom);
> 
>         <snip>

Ahh, good point.  A better comment for that would be:

	 * Some user_xfeatures may not be present in the fpstate.
	 * Remove those from 'mask' to zero those features in the
	 * user buffer instead of retrieving them from fpstate.

