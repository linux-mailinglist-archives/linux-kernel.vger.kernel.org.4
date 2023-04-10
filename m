Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2993E6DCD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDJWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDJWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0E719AF;
        Mon, 10 Apr 2023 15:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 378EE61FB9;
        Mon, 10 Apr 2023 22:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ECDC433EF;
        Mon, 10 Apr 2023 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681165437;
        bh=7qpibVH+Bx7rHlHS6P/GVmFU+lfojwvqMbChbkABNfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohJ5BA+CQxDTuK4HGpmWsK4adhKm5aQENMUgOeGOkhrBnrm/QqMSggSH9gEcs5VDp
         9/Hs0xmWlVXYpbzgCmtjEZm7tGPnQ5FfFoZQrew4oGQbPZwb6aNV2ovh9MyYQ7Dmec
         P3TV6dixgtdmH0qqSUnCOiEUZYkTEfSeAKALdwPmOLCl7WhcUMVP0puC3btjNet6WJ
         /qJXjEtBc1idTGFHj31hMWRtXggBEyCyq0C8gRAPDpiLKN599eIxOtQEK1AOIgAnlh
         NjEUnkPaUFlzhoT3rSEM7ueDEDKSaOYlJMesbVJKuZQ/3RDhPCpYKEVNy7oW5jQ6g2
         L8/k2b1VBW+WA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CDD6E40009; Mon, 10 Apr 2023 19:23:54 -0300 (-03)
Date:   Mon, 10 Apr 2023 19:23:54 -0300
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
Subject: Re: [PATCH v2] perf build: Warn for BPF skeletons if endian
 mismatches
Message-ID: <ZDSMeui7IEk+D/SO@kernel.org>
References: <20230410160905.3052640-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410160905.3052640-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 10, 2023 at 09:09:05AM -0700, Ian Rogers escreveu:
> Done as a warning as I'm not fully confident of the test's robustness
> of comparing the macro definition of __BYTE_ORDER__.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> v2. Is a rebase following patch 1 being merged.

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/Makefile.config | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 16bea51f0bcd..71442c54c25f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -663,14 +663,17 @@ ifndef NO_BPF_SKEL
>    $(call feature_check,clang-bpf-co-re)
>    ifeq ($(feature-clang-bpf-co-re), 0)
>      dummy := $(error: ERROR: BPF skeletons unsupported. clang too old/not installed or build with NO_BPF_SKEL=1.)
> -  else
> -    ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
> -      dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
> -    else
> -      $(call detected,CONFIG_PERF_BPF_SKEL)
> -      CFLAGS += -DHAVE_BPF_SKEL
> -    endif
>    endif
> +  ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
> +    dummy := $(error: ERROR: BPF skeletons unsupported. BPF skeleton support requires libbpf or build with NO_BPF_SKEL=1.)
> +  endif
> +  host_byte_order=$(echo ""|$(HOSTCC) -dM -E -|grep __BYTE_ORDER__)
> +  target_byte_order=$(echo ""|$(CC) -dM -E -|grep __BYTE_ORDER__)
> +  ifneq ($(host_byte_order), $(target_byte_order))
> +    $(warning Possibly mismatched host and target endianness may break BPF skeletons)
> +  endif
> +  $(call detected,CONFIG_PERF_BPF_SKEL)
> +  CFLAGS += -DHAVE_BPF_SKEL
>  endif
>  
>  dwarf-post-unwind := 1
> -- 
> 2.40.0.577.gac1e443424-goog
> 

-- 

- Arnaldo
