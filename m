Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0665B807B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiINFLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINFL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:11:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D346605;
        Tue, 13 Sep 2022 22:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663132286; x=1694668286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dlIkkaMKGQF7N/2BgFt96GCxbvKLNSarA0u+VVorGrA=;
  b=eCrpaOtw7Qeb0WQAVrGHh28AyXTk80jVAXpOAdqSEbj31KTaE1bN5QgT
   OXILZWwXakAHUi5FPGOW7vmH5a1dB+oHmqyk6ydCPnYbSxhAWhA5Em0yq
   6gB5GnXV4IJNKZeU9tqxriSsQy2guJj8VtmZgoeoFGgoLbdZhGW5544aQ
   SSirp5kjUXtMEQfpWzDcIG1CaL32lrn+ohYEALHl6nnNXM4umzJZB3XcE
   AHzpiOelZS3l7hX5UEU8hDf78nE7TaKj5ICIbKIcU1S9b2IEnrmNz4+vh
   C5MJuJAw4925/fzGiXRlqywToxzU1Afyxlqx8XQy5+4iQE72D83ba/gCE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299149703"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="299149703"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 22:11:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="678892519"
Received: from malbecki-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 22:11:23 -0700
Message-ID: <ca460f5e-644f-8c55-670f-76d8a6f95e40@intel.com>
Date:   Wed, 14 Sep 2022 08:11:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] perf inject: Clarify build-id options a little bit
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220914040844.352514-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220914040844.352514-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/22 07:08, Namhyung Kim wrote:
> Update the documentation of --build-id and --buildid-all options to
> clarify the difference between them.  The former requires full sample
> processing to find which DSOs are actually used.  While the latter simply
> injects every DSO's build-id from MMAP{,2} records, skipping SAMPLEs.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/Documentation/perf-inject.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
> index 70e2ac3cc91a..c972032f4ca0 100644
> --- a/tools/perf/Documentation/perf-inject.txt
> +++ b/tools/perf/Documentation/perf-inject.txt
> @@ -25,10 +25,12 @@ OPTIONS
>  -------
>  -b::
>  --build-ids::
> -        Inject build-ids into the output stream
> +	Inject build-ids of DSOs hit by samples into the output stream.
> +	This means it needs to process all SAMPLE records to find the DSOs.
>  
>  --buildid-all::
> -	Inject build-ids of all DSOs into the output stream
> +	Inject build-ids of all DSOs into the output stream regardless of hits
> +	and skip SAMPLE processing.
>  
>  --known-build-ids=::
>  	Override build-ids to inject using these comma-separated pairs of

