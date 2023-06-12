Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62472CEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjFLSwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbjFLSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6265810C9;
        Mon, 12 Jun 2023 11:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB5B66202E;
        Mon, 12 Jun 2023 18:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D205C433EF;
        Mon, 12 Jun 2023 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686595951;
        bh=MnmOvCi0xrEhhR2xjMfc6XM11ox3luiR0jJIXG6xoM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltFffCaHICLCZv/KVjydDeGHwENlL+flObHfDBFaQpSTpb1vL1lbX7CIBoIdM26hn
         sDRrPnJVmpW0PXmfF4mF70aDrKabOEdjAAwj5PaalYQgf3/rqphqhckP1z6omPHaAY
         Juo19MkjGEpboQZq6nj7HztT8zmXJ7pCdArCLtdHdo4+HwiQYR3UX7pSlr0/vMZfMM
         ltYj0wLgRKQ4u886Xuo2U0P4uEXUVn/Kr2jaCzqPhlwKZGBxcUnVDwgvt3fgAhQIXL
         PH79XSzqwdecrmJQKBZ60tXln/ESye1HLtFwfora9NMz52eFkmOxKDrvPlwl4WGoeJ
         /dWORCztVbbLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3B1540692; Mon, 12 Jun 2023 15:52:28 -0300 (-03)
Date:   Mon, 12 Jun 2023 15:52:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/5] lib subcmd: Avoid memory leak in exclude_cmds
Message-ID: <ZIdpbMGu/V+VO8c+@kernel.org>
References: <20230611233610.953456-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611233610.953456-1-irogers@google.com>
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

Em Sun, Jun 11, 2023 at 04:36:06PM -0700, Ian Rogers escreveu:
> exclude_cmds will shorten the cmds names array, before doing so free
> the removed entry.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/subcmd/help.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index bf02d62a3b2b..a66fb1a1a312 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -66,6 +66,7 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
>  	while (ci < cmds->cnt && ei < excludes->cnt) {
>  		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
>  		if (cmp < 0) {
> +			zfree(&cmds->names[cj]);
>  			cmds->names[cj++] = cmds->names[ci++];
>  		} else if (cmp == 0) {
>  			ci++;
> @@ -75,9 +76,12 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
>  		}
>  	}
>  
> -	while (ci < cmds->cnt)
> +	while (ci < cmds->cnt) {
> +		zfree(&cmds->names[cj]);
>  		cmds->names[cj++] = cmds->names[ci++];
> -
> +	}
> +	for (ci = cj; ci < cmds->cnt; ci++)
> +		zfree(&cmds->names[ci]);
>  	cmds->cnt = cj;
>  }
>  
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 

- Arnaldo
