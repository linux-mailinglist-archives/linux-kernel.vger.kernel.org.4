Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535C76F86F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjEEQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEEQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:42:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F8016355;
        Fri,  5 May 2023 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683304960; x=1714840960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N1JPxPIJIdERUPcr+WZPlldDq0rv6gkR5Peeo9bpwuU=;
  b=PJophe6hSSjb8lfqyHG7X0B+YzX8XsALTq4fXRYUUe+FNsPOD8JsE6jP
   KSdc7+bKOjzw21++MpxmiEb2jfUtDFLoncNLYAfNHyIAKkFeJ/myArD04
   SshN917CNGLOlEtkqXaLq6bF+5eRehE00eFmJ75/SFMUEqdXDFOAaXVfu
   yfhpnHv7jPENr2cdIDyA6w/0epsxDGSWczLVCVbdvLF1iKeSh43VfHSH3
   u+th5Wr+hfTKQzNT6VhSXoNGV5CLSeFyAzi3ur548rzUKT9c3tfyahyvH
   KTV23eLReJ2JQoJ21au3AsoaekHDRU3n2WDWhT63oupwrJCwk+JXgNl/9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="333674469"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="333674469"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700511808"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="700511808"
Received: from annguyen-mobl2.amr.corp.intel.com (HELO [10.209.140.100]) ([10.209.140.100])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:42:38 -0700
Message-ID: <55343361-d991-c157-4a88-843947aa45ff@intel.com>
Date:   Fri, 5 May 2023 09:42:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [tip: perf/core] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org
References: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
 <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 03:46, tip-bot2 for Ricardo Neri wrote:
> +#define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
> +
> +/**
> + * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
> + *
> + * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
> + * a hybrid processor. If the processor is not hybrid, returns 0.
> + */
> +u8 get_this_hybrid_cpu_type(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +		return 0;
> +
> +	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
> +}

Hi Folks,

Sorry to dredge up an old thread.  But, where does this information
about "If the processor is not hybrid, returns 0." come from?

What is there to keep cpuid_eax(0x0000001a) from having 0x0 in those
bits?  Seems to me like 0 is theoretically a valid hybrid CPU type.  Right?
