Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FED5BE739
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiITNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiITNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:37:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1EE5C;
        Tue, 20 Sep 2022 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663681028; x=1695217028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6vphUVpjJCtVYmW0Dnb93dlHUBJxwZCCp5EcdTre2U8=;
  b=CqQVmjm484x/koOrbZbjMMZvfIaBiJjVxRtJRclt0w8/X8U1toC7h2Wl
   osRfCZXrcXk39yiH6cAYsX6tT8GV6/8lxWBdd2kXSwmB18XLJncxWop/l
   QVJjhaCrr0rGoCCyJp7jDuUbGKtNb3ZHDYWX+IEm8tj5DnuQmvGywHsS4
   McufOK4GXqIMjg58QFUVpDNWET+2mznHSWMNkdOIRHqysDrYUs7LBAhia
   LoFtxcMS4lxurKrYltKXufGKKOzKe/vtu6GH84/nJq2HhHyrxRbeNQpfR
   owneG7KHRxVif+oIvLIofHfulDmOfIkIQW1WEOkYpXHQlXh3Ysymqmmgt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="361434067"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="361434067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:36:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="652095928"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.32])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 06:36:48 -0700
Message-ID: <a50941ad-ae74-933e-4d22-f4c67bafc0c1@intel.com>
Date:   Tue, 20 Sep 2022 16:36:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] perf tools: Honor namespace when synthesizing
 build-id
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220916175902.1155177-1-namhyung@kernel.org>
 <20220916175902.1155177-5-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220916175902.1155177-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/22 20:59, Namhyung Kim wrote:
> It needs to go into a namespace before reading a file.

This looks like a fix, in which case make it the first patch
and add a fixes tag?

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index e6978b2dee8f..d0d540d09196 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -391,6 +391,8 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>  	struct build_id _bid, *bid = &_bid;
>  	struct dso *dso = NULL;
>  	struct dso_id id;
> +	struct nsinfo *nsi;
> +	struct nscookie nc;
>  	int rc;
>  
>  	if (is_kernel) {
> @@ -410,8 +412,14 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>  		goto out;
>  	}
>  
> +	nsi = nsinfo__new(event->pid);
> +	nsinfo__mountns_enter(nsi, &nc);
> +
>  	rc = filename__read_build_id(event->filename, bid) > 0 ? 0 : -1;
>  
> +	nsinfo__mountns_exit(&nc);
> +	nsinfo__put(nsi);
> +
>  out:
>  	if (rc == 0) {
>  		memcpy(event->build_id, bid->data, sizeof(bid->data));

