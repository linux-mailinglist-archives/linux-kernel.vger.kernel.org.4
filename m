Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3B5FDED9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJMRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJMRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:21:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE127E0986
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665681699; x=1697217699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oLJ+o0oAH5MFeN5yUjW7hBZIGAyvQOvhPgb6VSY7qag=;
  b=AIKD27RJvMmKMThhH1sdogV1xBft9QfLMR4JHEeuJDjV5ws9+AJdGqYo
   1vBrO7IoqFvtY62Em9I6djoRAeDws2ptQdRoXJc7OpZGETWDd2L88hAgF
   tksPulurs4eEdESUzBV0F0HaNUYAjGPTbpPhR5uf5yraE8DFso9VRb67H
   4qjARWvl9nxC7QNdFAyOzx7/uL7JtyhCaiaHFUAbcYUc5MTE2snhvc+vh
   tWXPfzZgM6lXQTIqAKvIezTx7Bf6uqT0vGrSZk/8MxDqIL3IyRUAflshI
   a8EFlVkHYAiz2tn8WaMkuJha8gFe/kLPcozi/7xlPYZ5nGwz8y75yJpYM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="292493499"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="292493499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 10:21:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="578322416"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="578322416"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 10:21:34 -0700
Message-ID: <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
Date:   Thu, 13 Oct 2022 10:21:28 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 09:23, Chang S. Bae wrote:
> 
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1127,8 +1127,12 @@ void __copy_xstate_to_uabi_buf(struct membuf to,
> struct fpstate *fpstate,
>          * non-compacted format disabled features still occupy state space,
>          * but there is no state to copy from in the compacted
>          * init_fpstate. The gap tracking will zero these states.
> +        *
> +        * In the case of guest fpstate, this user_xfeatures does not
> +        * dynamically reflect the capacity of the XSAVE buffer but
> +        * xfeatures does. So AND them together.
>          */
> -       mask = fpstate->user_xfeatures;
> +       mask = fpstate->user_xfeatures & fpstate->xfeatures;

I'm not sure this is quite right either.

Doesn't kvm expect that all of the ->user_xfeatures will end up being
copied out?  We surely can't copy them from 'fpstate' if the feature
isn't there, but we can't skip them entirely, can we?
