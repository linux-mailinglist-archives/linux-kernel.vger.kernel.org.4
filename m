Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC70723688
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjFFFAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjFFFAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:00:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F63196;
        Mon,  5 Jun 2023 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686027639; x=1717563639;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=eIUAsbJdL5hO7Ybe0uE+3+sTJNj411vUQzur9r3Syv4=;
  b=KAwnYhTFIE3OhhbVDlC05KI3s4/jwZB5qXCZeEUWfKwik+bO23LqlMx9
   ww2vkvBg2JeyxZ400HAi3v4j/frM92Lm0UY5k2mP6rBdnCtysuq/UPxEX
   WRT/Yioe0BguUtWOTzURxzsQ7eT+Mai8Iof5W7g62pGKkt3Em0JUFz25Z
   FgxFGMQ0aabx5GwgpFSY8YCtuU/Uc5opXdF9rWI+ZW5fKvRjvMTu4obqa
   YvFPN1Q4J3bYyHwbVM7xWXdWP7t1RMMETfXsdPrIuLrqAmM8M7zdy1kHz
   7Lv+IOdwY7XhSID0zMvcKTZ3KOYIQkVu6nnwovAFOlv0M0yMHug90yUUP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="359017134"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="359017134"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="708923710"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="708923710"
Received: from cutzinge-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.224])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 22:00:37 -0700
Message-ID: <afe1c05a-2b77-c3d8-aacf-b4c7bebb8bf8@intel.com>
Date:   Tue, 6 Jun 2023 08:00:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH V3 0/1] perf tools: Allow config terms with breakpoints
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230525082902.25332-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230525082902.25332-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/23 11:29, Adrian Hunter wrote:
> Hi
> 
> Here is a patch (V3) to the event parser for breakpoint events.
> I am not that familiar with flex / bison, but it seemed to
> need trailing context to stop the mem event colon and slash
> delimiters from getting mixed up with delimiters for config
> terms or event modifiers.  Please look closely at that.
> 
> 
> Changes in V3:
> 
>       Add Ian's Reviewed-by
>       Re-base

Still applies.  Any more comments?

> 
> Changes in V2:
> 
>       Add comments to tools/perf/util/parse-events.l
>       Add a test for 2 mem events back to back with config terms
> 
> 
> Adrian Hunter (1):
>       perf tools: Allow config terms with breakpoints
> 
>  tools/perf/tests/parse-events.c | 157 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/parse-events.c  |  23 +++++-
>  tools/perf/util/parse-events.h  |   6 +-
>  tools/perf/util/parse-events.l  |  23 +++++-
>  tools/perf/util/parse-events.y  |  42 ++++++-----
>  5 files changed, 224 insertions(+), 27 deletions(-)
> 
> 
> Regards
> Adrian

