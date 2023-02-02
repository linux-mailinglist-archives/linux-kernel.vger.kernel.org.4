Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00BD6872EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjBBBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjBBBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A71757AE;
        Wed,  1 Feb 2023 17:22:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 387B1619A5;
        Thu,  2 Feb 2023 01:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A33FC4339B;
        Thu,  2 Feb 2023 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675300919;
        bh=ZqssXvl/r9Caev0Gff135a6zz+FodrS97LdDXa2bXnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CajBJa3NCdeeMJh1dvzhLPkNKv8kRN/a83tCFUzCHTDeZYO+ib0oJpYvWwJvvY/yY
         4l/t+8wTf41TMJhLyZ5HAfna1l9K72QXliarXZEOK0faXoPZTV3ORmQ83uV5Kx14BA
         K0HQCfDg5bFl8x4xGMD+l5hUbhsblxxOZc0f/7JHLztpXYurmdEbwkIjix3loTWX/w
         a9TPLOMouerbgZ+mhBoXK7IO1hwkYaY6Z+mF0p7rqFg/E+EXoPB5nesZCGzoeQ61Sm
         wrPM007WQgv2GLawk89yFDm/YWBzKReBSoBT+kdCkIu7MLTz1wXkYy9IyoWwz23jlX
         Uy3rj6u//NoWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2068A405BE; Wed,  1 Feb 2023 22:21:57 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:21:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Henry Castro <hcvcastro@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf: fix the probe finder location (.dwo files)
Message-ID: <Y9sQNUqaLqFCf0dN@kernel.org>
References: <Y01Mof9qMpFToRWY@kernel.org>
 <20230129232145.31307-1-hcvcastro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129232145.31307-1-hcvcastro@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 29, 2023 at 07:21:28PM -0400, Henry Castro escreveu:
> If the file object is compiled using -gsplit-dwarf,
> the probe finder location will fail.
> 
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
> 
> Hi,
> 
> Polite ping?  Any feedback?

Namhyung, are you ok now? Masami, can you please take a look and provide
an Acked-by or Reviewed-by?

- Arnaldo
 
> Regards
> Henry
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
> 

-- 

- Arnaldo
