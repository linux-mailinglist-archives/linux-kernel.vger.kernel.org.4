Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FA6D53FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDCVtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjDCVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13D10C6;
        Mon,  3 Apr 2023 14:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BBB062D46;
        Mon,  3 Apr 2023 21:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3710C4339B;
        Mon,  3 Apr 2023 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680558582;
        bh=fqVETS7SWuY15r04nn/Zh048xfVgLhJlxdN7uGgMkL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csjl+DdJF1bt5VuD3zLHrps55/jtY5V7dauWE67iiSi3SR1X+Hw+LjmlPqkXSnoeK
         8SYa+zjCt++6Y9/hZ4f5tts6warGrKhWp/51wOZJCiA9Pz0yDTl+utJ/gKeo+VwWZP
         9P5YC0WnnTZ2cRuItRXeaOdPO3CsnkaIu3Yywm8hkXdRGzOitAd0mAxJDi1FRda3lw
         2QTFBWsJEbgOVl+nBWtPGe3Jz12h3eFV0wiR0A0euPTDyeVKzNnCj88WJYQ5eL6evn
         jy7CITthHzebjkLOZf1gJxcNy9FMoQXE/3+RPmhYb6QfWHj6B12JYzoWRn6EdBVsPI
         WuNMH7ZI4mj9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4AC154052D; Mon,  3 Apr 2023 18:49:40 -0300 (-03)
Date:   Mon, 3 Apr 2023 18:49:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v1 1/2] perf build: Allow C++ demangle without libelf
Message-ID: <ZCtJ9FsTALNqfvm7@kernel.org>
References: <20230403211021.1892231-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403211021.1892231-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 02:10:20PM -0700, Ian Rogers escreveu:
> The cxa demangle support isn't dependent on libelf and so we no longer
> need to disable demangling if libelf isn't present.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 236d763181c5..dd203f0a2b7e 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -412,7 +412,6 @@ endif
>  
>  ifdef NO_LIBELF
>    NO_DWARF := 1
> -  NO_DEMANGLE := 1
>    NO_LIBUNWIND := 1
>    NO_LIBDW_DWARF_UNWIND := 1
>    NO_LIBBPF := 1
> -- 
> 2.40.0.348.gf938b09366-goog
> 

-- 

- Arnaldo
