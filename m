Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400E4631BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKUIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKUIpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:45:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B97EBEF;
        Mon, 21 Nov 2022 00:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669020320; x=1700556320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RDUUSENrZBWktghAjmuOUPhABNfGjIGLGX0RlGyUMgg=;
  b=CJGtNDAFm0AKtErdydpW2yRY/P9ZwmOxoHijqaa9Fmh7/9x3wWnD/9gp
   MQzq4vV0I8MoheLfF+S8/WqdyxeMz9WJ9O7NcTR0nfnTxeF+gDO3vK9en
   bNL+kTesxYlQosigwK53oAEaHYWdqJU5mqBsj9f/RcD40opZDFilqZeQB
   JYkCc+RDiknA9Dmt5flxOa5dAeewusKmOhZ0zVuezWG4DY5xztAzXIGd8
   FDv32RJezX89fSUAiojCTOQ+hyR3PJAvn9WjhnR6lXZX1mgzrwb/qPBkV
   cyKYtK5yzPhC7dOCn5pYD3RWv4C07hn1F/Vjz7uwYz4pyNAfIAW0nh2VY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="314654321"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="314654321"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:45:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="635110094"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="635110094"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:45:17 -0800
Message-ID: <5e408880-3394-c943-6ed5-6ceb8d05fd07@intel.com>
Date:   Mon, 21 Nov 2022 10:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] perf inject: Set PERF_RECORD_MISC_BUILD_ID_SIZE
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20221119002750.1568027-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221119002750.1568027-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/22 02:27, Namhyung Kim wrote:
> With perf inject -b, it synthesizes build-id event for DSOs.  But it
> missed to set the size and resulted in having trailing zeros.
> 
> As perf record sets the size in write_build_id(), let's set the size
> here as well.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/synthetic-events.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index cccd293b5312..0645795ff080 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2218,8 +2218,9 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
>  	len = pos->long_name_len + 1;
>  	len = PERF_ALIGN(len, NAME_ALIGN);
>  	memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
> +	ev.build_id.size = pos->bid.size;
>  	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
> -	ev.build_id.header.misc = misc;
> +	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
>  	ev.build_id.pid = machine->pid;
>  	ev.build_id.header.size = sizeof(ev.build_id) + len;
>  	memcpy(&ev.build_id.filename, pos->long_name, pos->long_name_len);

