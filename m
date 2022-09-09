Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBC5B4183
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIIVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIIVgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:36:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA84F3439;
        Fri,  9 Sep 2022 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662759366; x=1694295366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nOmysUMqkWG2qS+aBrtlAZ6GS6f/rSpIBnTNj+QpHbo=;
  b=de3r9CquOr4VDK1EF5PyRaYpZkJB7QhoGBMvJTp+YXRzLQd8fx9zaxoB
   QKPmceGc8GJDR4yechGKwPoSrSti0pVFSnOA5EOz8Y9ORrzcJJRSJXn7S
   7nrhNUaPts/D0z/a9TogXC0auC3EJQgX066QQQ5UXgFrgaV/HKJ76Q8cM
   zOyrNH2/uY7Q+OVINXDtPCDbP7P9x8AHMBbxU9D11QnFJAhn76OyUQ8p8
   2mvYG5WGoV9o1Who/z3nfi83NOHEzHHGqByPk9Ko8KDOpmyc86PTmzYtc
   K0qzERUnuBWRUvipMxCDxz3lXH9YlyUd3VjzIrCRdgfbV1pav2DV9Pio3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="361529380"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="361529380"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:36:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="566506447"
Received: from omeier-mobl1.ger.corp.intel.com (HELO [10.209.54.138]) ([10.209.54.138])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:36:05 -0700
Message-ID: <129981cd-32b7-0228-f932-4367f6c79316@intel.com>
Date:   Fri, 9 Sep 2022 14:36:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/4] Documentation/x86: Explain the purpose for dynamic
 features
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909201540.17705-1-chang.seok.bae@intel.com>
 <20220909201540.17705-2-chang.seok.bae@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220909201540.17705-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 13:15, Chang S. Bae wrote:
> +The purpose for dynamic features
> +--------------------------------
> +
> + - Legacy userspace libraries have hard-coded sizes for an alternate signal
> +   stack. With the arch_prctl() options, the signal frame beyond AVX-512
> +   and PKRU will not be written by old programs as they are prevented from
> +   using dynamic features. Then, the small signal stack will be compatible
> +   on systems that support dynamic features.

This doesn't really ever broach the _problem_ that dynamic features solve.

	Legacy userspace libraries often have hard-coded, static sizes
	for alternate signal stacks, often using MINSIGSTKSZ which is
	typically 2k.  That stack must be able to store at *least*
	the signal frame that the kernel sets up before jumping into
	the signal handler.  That signal frame must include an XSAVE
	buffer defined by the CPU.

	However, that means that the size of signal stacks is dynamic,
	not static, because different CPUs have differently-sized XSAVE
	buffers.  Those old <=2k buffers are now too small for new CPU
	features like AVX-512, which is causing stack overflows at
	signal entry.


> + - Modern server systems are consolidating more applications to share the
> +   CPU resource.

I'm not sure what this means.  Are you saying that CPU time is more
overcommitted?  Or that different users are more likely to be sharing
the same CPU core?  Or, is this trying to allude to the frequency
penalties that cores (and even packages) pay for using features like
AVX-512?

> The risk of applications interfering with each other is
> +   growing. The controllability on the resource trends to be more
> +   warranted. Thus, this permission mechanism will be useful for that.

Should this be something more like:

Historically, a CPU shared very few resources with its neighbors outside
of caches.  A CPU could execute whatever instructions it wanted without
impacting other CPUs.  Also, there were minimal long-lasting temporal
effects; an application that preceded yours running on a CPU would not
impact how your application runs.

That model has been eroding, first with SMT where multiple logical CPUs
share a core's resources.  Then, with features like AVX-512 that have a
frequency and thermal impact which can last even after AVX-512 use
ceases and have an impact wider than a single core.

In other words, it has become easier to be a "noisy neighbor".

Dynamic features allow the kernel limit applications' ability to become
noisy neighbors in the first place.
