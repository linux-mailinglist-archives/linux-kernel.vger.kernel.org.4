Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E2739676
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjFVEn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFVEnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:43:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248B1721;
        Wed, 21 Jun 2023 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687409000; x=1718945000;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=wQoR2q3uW5UBsZHTzuc+u5TdXp0RPHRVzU+umLlMx20=;
  b=fLDac3bCVzJST0SHlg6g/Yh/UUcZGuy/YBmky0VcwGs3Xf4ZbzNvsteB
   DnfcZqt/mJAtZMxwXj3FiW3JlYOpXhGand6v9dOovjVc6RNDXNY3Ku/jN
   Fl0YZma7sVupZiluhBGI5QrPdnqQhHTj4jt2ytvmLr2b+WyllDRCwMH00
   ti/0c/1IC9ij5mzOvewyi/VFVIP2mSJNd2dkjVFUpkpdubpmAYYQBTy2k
   XUub2+Nju1iEcGI/EXZkYjROipiQGXOQMe1Fxj21TqEdZKDhnHQsjE1K4
   EAyP2XJgvDdkkcsMj0R9NJXCRMUXc3osxnM+CNoY5FqWu8L/8vQXAQDzN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339993596"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="339993596"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 21:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888947079"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="888947079"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.46.4])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 21:43:16 -0700
Message-ID: <a44290cc-5954-8d5a-f84c-9e5a68732ea4@intel.com>
Date:   Thu, 22 Jun 2023 07:43:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH 0/9] Add support for Firefox's gecko profile format
To:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1687375189.git.anupnewsmail@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cover.1687375189.git.anupnewsmail@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/23 22:35, Anup Sharma wrote:
> This patch series adds support for Firefox's gecko profile format.
> The format is documented here [1]
> 
> The series adds a new python script that can be used to convert the 
> perf script to gecko profile format. To use this script, use the
> following commands: 
> 
> perf record 
> perf script -F +pid > perf_data.txt
> python3 firefox-gecko-converter.py > gecko_profile.json

Why not use the perf script python interface?

https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-script-python.1

> 
> Also dont forget to change the chown of the output file to the user[2].
> 
> [1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
> [2] https://bugzilla.mozilla.org/show_bug.cgi?id=1823421
> 
> Anup Sharma (9):
>   scripts: python: Add check for correct perf script format
>   scripts: python: implement add sample function and return it
>   scripts: python: Introduce thread sample processing in
>     convertPerfScriptProfile
>   scripts: python: Implement parsing of input data in
>     convertPerfScriptProfile
>   scripts: python: implement function for thread creation
>   scripts: python: implement get or create stack function
>   scripts: python: implement get or create frame function
>   scripts: python: Finalize convertPerfScriptProfile and return profile
>     data
>   scripts: python: Add temporary main function for testing purposes
> 
>  .../scripts/python/firefox-gecko-converter.py | 249 ++++++++++++++++++
>  1 file changed, 249 insertions(+)
>  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> 

