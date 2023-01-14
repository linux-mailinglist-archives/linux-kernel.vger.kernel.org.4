Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47166A9F1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjANHYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjANHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:24:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D162711;
        Fri, 13 Jan 2023 23:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673681050; x=1705217050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EbOT0F9sF7mGT+qJRKbVYwwZl+y4osdO9GuBop7zpPs=;
  b=GJ1wcjiUSqUcF5yfaQ8sf5gxPZTPuP0h2GEa1kH5si/f/O3QQ044Vsa8
   VPQYUJps9oErO7ozb1MxiBMOEAJKoGc4m8u8kBBUL1eXJ1ScnVxuIqdKa
   vLqEWs7h7V2s9e6yCI2cAGn+F23MqN+7sw/kKW9R6E8+20qhL5UOOVgKI
   xMn+/QQ8AFY6HvK9mvxz9FhPxGlcz4ZvLd2pnEfnSjlNwBGy9HUd8jGd/
   l1tuy6Hk2r/GKaKGK3zNR2OvCTXAKPa13Syg/695jxfJdw15OUVbuNeCx
   FBaqZWkzF0/fB6JuZ4g2HmOQVU2od8A0wQb4Sdx18pes+shUgKUpvAD9f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="388667943"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="388667943"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 23:24:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="782390506"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="782390506"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.44.197])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 23:24:07 -0800
Message-ID: <a6a2e8b1-7194-75f1-d59c-7c8bc059174a@intel.com>
Date:   Sat, 14 Jan 2023 09:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] tools:perf:scripts:python:intel-pt-events del unusedvar
To:     Alexander Pantyukhin <apantykhin@gmail.com>, peterz@infradead.org,
        akpm@linux-foundation.org
Cc:     mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106215613.7159-1-apantykhin@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230106215613.7159-1-apantykhin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/01/23 23:56, Alexander Pantyukhin wrote:
> The event_attr is never used later, the var is ok be deleted.
> Additional code simplification is to substitute string slice comparison
> with "substring" function. This case no need to know the length specific
> words.
> 
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> ---
>  tools/perf/scripts/python/intel-pt-events.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> index 08862a2582f4..28d08e2fb7cd 100644
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ b/tools/perf/scripts/python/intel-pt-events.py
> @@ -340,7 +340,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
>  	print(start_str, src_str)
>  
>  def do_process_event(param_dict):
> -	event_attr = param_dict["attr"]

Should really be moved to the "Unused fields:" comment
section a few lines below.

>  	sample	   = param_dict["sample"]
>  	raw_buf	   = param_dict["raw_buf"]
>  	comm	   = param_dict["comm"]
> @@ -359,13 +358,13 @@ def do_process_event(param_dict):
>  		print(glb_switch_str[cpu])
>  		del glb_switch_str[cpu]
>  
> -	if name[0:12] == "instructions":
> +	if name.startswith("instructions"):
>  		if glb_src:
>  			print_srccode(comm, param_dict, sample, symbol, dso, True)
>  		else:
>  			print_instructions_start(comm, sample)
>  			print_common_ip(param_dict, sample, symbol, dso)
> -	elif name[0:8] == "branches":
> +	elif name.startswith("branches"):
>  		if glb_src:
>  			print_srccode(comm, param_dict, sample, symbol, dso, False)
>  		else:

