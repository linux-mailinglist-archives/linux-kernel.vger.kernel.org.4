Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93966E3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjAQQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjAQQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:35:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA10442E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673973328; x=1705509328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w7ARafRWynHn6oellqveNiK4RDbgFDZHr2svNf5dEns=;
  b=Wc+wIP0kBpsmP0wkqTfOJ7joOm5nc7v9oKj/UeiFtuprzCEnX6kfVr4x
   TGBCveD/MTMoDOoPE4f2WzWbkjR4v9txecTJJcXltGMK8maf3e0LGhNT0
   CKGEjDwPGJDFUelAXwXr5XHi17CUzJhs0Y+JS4eo3STdoLn21FaY4wcCU
   cX+4+j5h7EylY9KtfBC9NDWz4rQ2V/M3QdhknmQBfgHTdSSqXsGkwpd1e
   QGUPNkX6d7U3GYbbeP3GuNSfA7LpPQR8jhu7CanwGIan98f7veDWuaDKt
   2G0WsihCznMzF3kSXr4pZBbkgMvjkBpvpF1GTBwJdWmvdMZojjb0EkBhl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="312614222"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312614222"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:35:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="988184444"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="988184444"
Received: from youli-mobl1.amr.corp.intel.com (HELO [10.255.228.205]) ([10.255.228.205])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:35:26 -0800
Message-ID: <f7ca6ffb-d623-a22e-da5e-d0acdd3ad672@intel.com>
Date:   Tue, 17 Jan 2023 08:35:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230109153555.4986-7-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 07:35, Ashok Raj wrote:
> -static void print_ucode(int old_rev, int new_rev, int date)
> +static void print_ucode(bool failed, int old_rev, int new_rev, int date)
...
>  	if (rev != mc->hdr.rev)
> -		return -1;
> +		retval = -1;
>  
>  	uci->cpu_sig.rev = rev;
>  
>  	if (early)
> -		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
> +		print_ucode(retval, old_rev, mc->hdr.rev, mc->hdr.date);
>  	else
> -		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
> +		print_ucode_info(retval, old_rev, uci->cpu_sig.rev, mc->hdr.date);
>  
> -	return 0;
> +	return retval;
>  }

I'm generally not a _huge_ fan of having an 'int' implicitly cast to a
bool.  The:

	print_ucode_info(retval, ...

Line could be right or wrong based on what the retval is logically.
This, on the other hand:

	bool failed = false;
	...
	if (rev != mc->hdr.rev) {
		retval = -1;
		failed = true;
	}
	...
	print_ucode_info(failed, old_rev, uci->cpu_sig.rev, ...

*Clearly* and unambiguously matches up with:

	static void print_ucode(bool failed, int old_rev, ...


