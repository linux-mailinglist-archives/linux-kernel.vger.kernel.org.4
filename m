Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7D658C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiL2L1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiL2L1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:27:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2BF13DCE;
        Thu, 29 Dec 2022 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672313267; x=1703849267;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=izooh+aJOq0y9ZY7bsO6ygU34U8zhrGdVSoaIebW5LI=;
  b=iJkknKiY/uwtGE6fAzcqbWT3Yf42bDd8ODErIVUb8HM3P+DCdix5puf/
   5/rkOw1T+0CCwOo5rvh6IfmwtEx10Y56+el7CQdVfiqKXPFet78/OinyH
   S148Y8ZvhPubBjGMkRDcy8Ce76D3Wql+4NqBiN0YpCs+TumlmYmitOzTI
   AyqRagcSuIPcwoQ3RUqCGJCZ/ZEuqdP21pnxNeXplHDR+ksofrtoa0SQ/
   x9Eb+aD8NEnJ0JxZdim6ZCkBpsIrUBfoLplHLcWq+XCnV4MojZaN9Kdg+
   9thj/RDX2VbWWV2SNHQosBPPm9qVB9KbpTm8w9uYTQ7V0fsHg89R1LyQM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="383324171"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="383324171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 03:27:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="653581106"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="653581106"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.128])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 03:27:44 -0800
Message-ID: <d0cf59ae-87c3-3aab-34fa-aa88ea467423@intel.com>
Date:   Thu, 29 Dec 2022 13:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] perf tools: Fix resources leak in perf_data__open_dir
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221229090903.1402395-1-linmq006@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221229090903.1402395-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/22 11:09, Miaoqian Lin wrote:
> In perf_data__open_dir(), opendir() opens the directory stream.
> Add missing closedir() to release it after use.
> 
> Fixes: eb6176709b23 ("perf data: Add perf_data__open_dir_data function")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index a7f68c309545..fc16299c915f 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -132,6 +132,7 @@ int perf_data__open_dir(struct perf_data *data)
>  		file->size = st.st_size;
>  	}
>  
> +	closedir(dir);
>  	if (!files)
>  		return -EINVAL;
>  
> @@ -140,6 +141,7 @@ int perf_data__open_dir(struct perf_data *data)
>  	return 0;
>  
>  out_err:
> +	closedir(dir);
>  	close_dir(files, nr);
>  	return ret;
>  }

