Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98488619EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDRcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDRce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:32:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626FACE11
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667583153; x=1699119153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pPOPNM3vYCz/Z1s0LA7RHwJYYh7DKEACrCv7Y9YF86s=;
  b=Madbhs+2oULlPfVVYfrWhAibaCngy72xKNiMzBKC9WQJ0qTO/KpUJVj7
   RBKjF7Yy+fOicFE+iBeK8DMtf6N+j4clY60uRdLLpuSxLQejwDuqwA0l5
   akPZCPy6gD4xKHX6GFpWrGvNb3xn05dQpkA2B9WxQJvNNwO36pQCK7+kW
   e1V1SrliNf6+ugY/y5xp8bd3lTBENZrYTPFhO/XQNEAPoeSMNRMr3254y
   rVUOxUuBBiHEGYzOeVykrSPLK+pHGpRH2NFPe6/tdh0tFjCfPkEO53fKl
   94PZskqUBOhG1y7S+T+LF/6PwD3ZLp3wpeIG7PbVMsbAQI7E0ywUweOJP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="372132741"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="372132741"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:32:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="635164724"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="635164724"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:32:32 -0700
Message-ID: <0a04e55c-ccfb-9383-1768-a88f4602fb4e@intel.com>
Date:   Fri, 4 Nov 2022 10:32:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 5/5] x86: switch to cpu_feature_enabled() for
 X86_FEATURE_XENPV
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>
References: <20221104072701.20283-1-jgross@suse.com>
 <20221104072701.20283-6-jgross@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104072701.20283-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 00:27, Juergen Gross wrote:
> Convert the remaining cases of static_cpu_has(X86_FEATURE_XENPV) and
> boot_cpu_has(X86_FEATURE_XENPV) to use cpu_feature_enabled(), allowing
> more efficient code in case the kernel is configured without
> CONFIG_XEN_PV.

As with the rest:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Seems like a very straightforward, sane set of cleanups.
