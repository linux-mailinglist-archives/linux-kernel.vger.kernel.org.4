Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDD675BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjATRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjATRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:45:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948460C8C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674236750; x=1705772750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SCZuOG9Rzb5F2pmy8moxyJlPCOLcAapt3jFx7fPUAHA=;
  b=bH9Lq0f35KsH+3P+aFdZrtCmy3RzEa1WemhYby6ztDylcEmD3arwVo/T
   H1if/S/lbN2aIzlfUnylsJ2V3gyVxh0yxGePScOD/2hGAiDliQEVLdCAz
   kKvNQ/Jgc9/FbKO2sCg2A3HUg3+y7TpdJ9uBfZJW97KUIeAjQULaphPHH
   73pLfBdSZW4x7A+NxeibyBQ6ZpMMuxll6VT3FMK0ZbCCkLIMFh95eY+B9
   ofQDx4Tt79WCagrOaZ/E0eeL1B5J0jE9r3PDeLQtDVl08BnrN6xgvkKUh
   XECUO9W1WwSBdEvueyd3LN/xXvvHpB2iGiZMxn5keyvM7L61KoQixnSv5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390147060"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="390147060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:45:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="662609587"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="662609587"
Received: from rray-mobl.amr.corp.intel.com (HELO [10.209.69.101]) ([10.209.69.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:45:26 -0800
Message-ID: <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
Date:   Fri, 20 Jan 2023 09:45:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Content-Language: en-US
To:     "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "H.Peter Anvin" <hpa@zytor.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
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

On 1/19/23 23:49, Li, Xin3 wrote:
> The x86 sysret_rip test has the following assertion:
> 
>         /* R11 and EFLAGS should already match. */
>         assert(ctx->uc_mcontext.gregs[REG_EFL] ==
>                ctx->uc_mcontext.gregs[REG_R11]);
> 
> This is being tested to avoid kernel state leak due to sysret vs iret,
> but that on FRED r11 is *always* preserved, and the test just fails.

Let's figure out the reason that FRED acts differently, first.  Right
now, the SDM says:

	SYSCALL also saves RFLAGS into R11

so that behavior of SYSCALL _looks_ architectural to me.  Was this
change in SYSCALL behavior with FRED intentional?

If not intentional, it might be something that can still be fixed.  If
it is intentional and is going to be with us for a while we have a few
options.  If userspace is _really_ depending on this behavior, we could
just clobber r11 ourselves in the FRED entry path.  If not, we can
remove the assertion in the selftest.
