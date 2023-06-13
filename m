Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417972E5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbjFMOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbjFMOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D921984;
        Tue, 13 Jun 2023 07:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB9F6372F;
        Tue, 13 Jun 2023 14:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D9CC433D9;
        Tue, 13 Jun 2023 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666887;
        bh=NWQpVweySUGtTFluolLZUifuigOzM3AUnOsX1rmj5WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUN9hi6kipzMOsyjXkx4Cf6xPJZbRWGnEHn7khXREmZ9hF2KvZFYruVDssC5hvw9M
         LofBHO/46ALmslq8vySPi1vnHT+Y7puVOqKIT6wXWnTGIZR9u+nb7O1jqDHQYOYZIr
         S1S2FS5f1Dan/dEmdnvaDro4Sxs4oU8LVc3h+dpsljtuGXPkDTKOTDEzZhASKtcA/7
         f1cxNLXdcIm7VFPXKYH6AMQaUpXyc9DKKh5gJwkQ00ywXoNjwC720HpXM1cfm7tGXG
         24KAw/uluv5hVmRzECcfXih60MlURD3h6g6RNm/gmY2ByWXApE+/aFHcBZ/nsKMGZq
         IEGWUoAdXx9Gg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6DB1340692; Tue, 13 Jun 2023 11:34:44 -0300 (-03)
Date:   Tue, 13 Jun 2023 11:34:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/2] perf dwarf-aux: Fix off-by-one in die_get_varname()
Message-ID: <ZIh+hC6cNE9BDIza@kernel.org>
References: <20230612234102.3909116-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612234102.3909116-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 12, 2023 at 04:41:01PM -0700, Namhyung Kim escreveu:
> The die_get_varname() returns "(unknown_type)" string if it failed to
> find a type for the variable.  But it had a space before the opening
> parenthesis and it made the closing parenthesis cut off due to the
> off-by-one in the string length (14).

Thanks, applied both patches.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index e4593a71556b..1ac88b79687d 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1103,7 +1103,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
>  	ret = die_get_typename(vr_die, buf);
>  	if (ret < 0) {
>  		pr_debug("Failed to get type, make it unknown.\n");
> -		ret = strbuf_add(buf, " (unknown_type)", 14);
> +		ret = strbuf_add(buf, "(unknown_type)", 14);
>  	}
>  
>  	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
