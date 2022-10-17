Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E84600F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJQMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11471B793;
        Mon, 17 Oct 2022 05:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B2E16112D;
        Mon, 17 Oct 2022 12:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C851DC433D6;
        Mon, 17 Oct 2022 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666010276;
        bh=Sl2cezNTsWHRgmfGwBUNjn5QvcqSB4MRPCTSkICdqoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPwFspAhyPaRssvY4ut7N09jQgcKFfTuYHlGp8de1xYuVPyko3wGvPEJvyLtUqMf7
         LIf7fdpBG8Q9DFVEKqQsRLKiZpsYo3fN2NSrg6KqEtEfzNmT7u6le3nLanZRMcPUTQ
         kQdkCQ2uub+iq+laV6DY358IJlNfHSEbXsDMbef9REhc8nIzvoVff+T5V5a4LxHfWj
         BdX7v9YWTcktXO9Gx4PZSyyacNnnIck4eQTIIbNCNsCjugmcIEOLsTWPFMfgLV04rY
         5pkiWrDGMZ4b2K7iRRsLwnZQ/XRRSFmZGYYc/QwS544JuPgUen2rZ19+4DxhiE8SVo
         3Bu1hd+SHblHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B5C3403B6; Mon, 17 Oct 2022 09:37:53 -0300 (-03)
Date:   Mon, 17 Oct 2022 09:37:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Henry Castro <hcvcastro@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf: fix the probe finder location (.dwo files)
Message-ID: <Y01Mof9qMpFToRWY@kernel.org>
References: <CAM9d7cgMjZPa9qwuzpG3usGJvKiAQCOvN8_W0RuakNqcZ2t8-g@mail.gmail.com>
 <20221005124710.30296-1-hcvcastro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005124710.30296-1-hcvcastro@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 05, 2022 at 08:47:02AM -0400, Henry Castro escreveu:
> If the file object is compiled using -gsplit-dwarf,
> the probe finder location will fail.
> 
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
> 
> > Nit, I think we use _ELFUTILS_PREREQ(0, 171).
> Thank you

Masami, are you ok with this?

Namyung, how about you?

Thanks,

- Arnaldo
 
> > How about making it a separate function with 2 versions
> > depending on the elfutils?  Then you can have the variables
> > only if they are used.
> 
> > Something like get_source_from_debuginfod() in the same
> > file.
> 
> Sounds good, but I prefer simplicity in the patch =),
> what do you think about
> {
> 	Dwarf_Die cudie, subdie;
> 	if (dwarf_cu_info() ..)
> 	..
> }
> 
> to resolve unused variable?
> }
> 
> 
>  tools/perf/util/probe-finder.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 50d861a80f57..5f6781e712db 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1200,6 +1200,20 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
>  			continue;
>  		}
> 
> +#if _ELFUTILS_PREREQ(0, 171)
> +		{
> +			uint8_t unit_type;
> +			Dwarf_Die cudie, subdie;
> +
> +			/* Check separate debug information file. */
> +			if (dwarf_cu_info(pf->cu_die.cu, NULL,
> +					  &unit_type, &cudie,
> +					  &subdie, NULL,
> +					  NULL, NULL) == 0
> +			    && unit_type == DW_UT_skeleton)
> +				pf->cu_die = subdie;
> +		}
> +#endif
>  		/* Check if target file is included. */
>  		if (pp->file)
>  			pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
> --
> 2.20.1

-- 

- Arnaldo
