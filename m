Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5996CD142
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC2Ewh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2Ewf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:52:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73072D46;
        Tue, 28 Mar 2023 21:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680065554; x=1711601554;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=7VVjAO7IWVyVYsb4cMvODMGsMKqTrcHRHz8e1YbJYkg=;
  b=dMpSVQ01MtSdcu7XTGKWvyKUGws6rI9OR+4Jc4n3/fjza6qEGYIiS9HP
   URD6EgAqAXhyNhvp7QFE18P/oLSIK0f0DuftRUbzqUmNh9tUFbHrxEKSR
   RiuMDUR7RIcCUgja4cXKK+JjEzNKSxJWkiTnCM4CXb8723Ua/JloaWwMu
   38lOMGp5LAaxnwMscGInkt/TcVZmrqWjC7IgfBc6Z72bQ+WFniQv5lifD
   QPXxNO/dE9Ry8huOChtDskSpnh3qNLp+q5aoB6Qa142OkUla2L/Mw3qBH
   jOwosi5NFexTmn8J/kKy0OwCwe5JrV3Kt1M/6kX3PtxWyyipCN2ueZDMU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405717449"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="405717449"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 21:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="930157132"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="930157132"
Received: from tsennhau-mobl6.gar.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.63])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 21:52:30 -0700
Message-ID: <67d81a70-1adc-dad4-4592-5e7d67e6c926@intel.com>
Date:   Wed, 29 Mar 2023 07:52:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v1] perf symbol: Avoid use after free
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230328234413.1081014-1-irogers@google.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230328234413.1081014-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/23 02:44, Ian Rogers wrote:
> If demangling succeeds then sym_name is set to the demangled string
> that is freed. Rather than test if sym_name is empty and possibly
> use-after-free on the return path, expand out the alternatives.

Looks the same as:

https://lore.kernel.org/linux-perf-users/20230316194156.8320-2-adrian.hunter@intel.com/

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/symbol-elf.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index c0a2de42c51b..b7e3e492bff3 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -577,15 +577,17 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
>  	/* Get the associated symbol */
>  	gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
>  	sym_name = elf_sym__name(&sym, di->dynstr_data);
> -	demangled = demangle_sym(di->dso, 0, sym_name);
> -	if (demangled != NULL)
> -		sym_name = demangled;
> -
> -	snprintf(buf, buf_sz, "%s@plt", sym_name);
> -
> -	free(demangled);
> +	if (*sym_name == '\0')
> +		return false;
>  
> -	return *sym_name;
> +	demangled = demangle_sym(di->dso, 0, sym_name);
> +	if (demangled != NULL) {
> +		snprintf(buf, buf_sz, "%s@plt", demangled);
> +		free(demangled);
> +	} else {
> +		snprintf(buf, buf_sz, "%s@plt", sym_name);
> +	}
> +	return true;
>  }
>  
>  static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,

