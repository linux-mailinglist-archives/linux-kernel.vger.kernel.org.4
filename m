Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081C074EF93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjGKM6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGKM61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B600E69;
        Tue, 11 Jul 2023 05:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB568614D4;
        Tue, 11 Jul 2023 12:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E816FC433C8;
        Tue, 11 Jul 2023 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689080269;
        bh=7oED2ssqzJahdIRFuzndkoETQuTxFWg0yCYG9eYOpIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TT2HG2cwmze98fWDZWbplLZohFFXhBNYgpZ5uYCDqx6BivasskTkS/cSOJlbvdF25
         N5aDuRDTVW+g1eNmtsGUSIbNxmJiJ21aaPzpnb4RqFmZPJs/T/ngRCiSZqafi8am46
         vflDGIjHi8QcUfghb+hdDMp+DVd+0p3D3OdpX0rTh+mO6bccblMB4RtGIvRe6QroOF
         WweIeMfezo4UoWD3ZEGFCqJypCrdNmSBo2SLrw7QV6ZPesPKD3/Md7xh7/KG0Zf7uW
         LjhE6l4R8kd5U44ubxF7VUingUmExEim7RA1hyY0aw+/un7d/jKeqDhqktX9kEqyIE
         V91AlNCW3l/cQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE8EA40516; Tue, 11 Jul 2023 09:57:45 -0300 (-03)
Date:   Tue, 11 Jul 2023 09:57:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: read DWARF files from the correct CU
Message-ID: <ZK1RyVue7OMXzVl4@kernel.org>
References: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
 <20230615200147.664346-3-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615200147.664346-3-georgmueller@gmx.net>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 15, 2023 at 10:01:37PM +0200, Georg Müller escreveu:
> After switching from dwarf_decl_file() to die_get_decl_file(), it is not
> possible to add probes for certain functions of certain binaries:
> 
>  $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
>  A function DIE doesn't have decl_line. Maybe broken DWARF?
>  A function DIE doesn't have decl_line. Maybe broken DWARF?
>  Probe point 'match_unit_removed' not found.
>     Error: Failed to add events.
> 
> The problem is that die_get_decl_file() uses the wrong CU to search for
> the file. elfutils commit e1db5cdc9f has some good explanation for this:
> 
>     dwarf_decl_file uses dwarf_attr_integrate to get the DW_AT_decl_file
>     attribute. This means the attribute might come from a different DIE
>     in a different CU. If so, we need to use the CU associated with the
>     attribute, not the original DIE, to resolve the file name.
> 
> This patch uses the same source of information as elfutils: use attribute
> DW_AT_decl_file and use this CU to search for the file.

Thanks, applied to the perf-tools branch, that will be submitted for
Linux v6.5.

- Arnaldo
 
> Fixes: dc9a5d2ccd5c ("perf probe: Fix to get declared file name from clang DWARF5")
> Signed-off-by: Georg Müller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net/
> ---
>  tools/perf/util/dwarf-aux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index b07414409771..137b3ed9897b 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -478,8 +478,10 @@ static const char *die_get_file_name(Dwarf_Die *dw_die, int idx)
>  {
>  	Dwarf_Die cu_die;
>  	Dwarf_Files *files;
> +	Dwarf_Attribute attr_mem;
> 
> -	if (idx < 0 || !dwarf_diecu(dw_die, &cu_die, NULL, NULL) ||
> +	if (idx < 0 || !dwarf_attr_integrate(dw_die, DW_AT_decl_file, &attr_mem) ||
> +	    !dwarf_cu_die(attr_mem.cu, &cu_die, NULL, NULL, NULL, NULL, NULL, NULL) ||
>  	    dwarf_getsrcfiles(&cu_die, &files, NULL) != 0)
>  		return NULL;
> 
> --
> 2.41.0
> 

-- 

- Arnaldo
