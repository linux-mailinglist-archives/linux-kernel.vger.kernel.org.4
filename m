Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053CE65DC97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbjADTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjADTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A65738AC8;
        Wed,  4 Jan 2023 11:13:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18287617DF;
        Wed,  4 Jan 2023 19:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F6DC433EF;
        Wed,  4 Jan 2023 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672859630;
        bh=QF56ZUsa0C4fvhg9142wKLKENvj96ZUCtzVn5z9hdkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tg2UMUz7flHoDUzlIKXbXGdA550EW9g99+SciMTuTeH1STYG1I1qm8inDaLGZu0Zl
         wYKDUw7QUBTKFPnCCxEgE7QqQVrWgNVpDRFBEyvHmjVUxW4FoWk9N2Pt9SA3J/1ZgK
         cvg4wR+y0uJ3ec0zQnRcu5G524RvjIwlLJZVdSs4MdNFlXcVzw1IwGEYL5K7Nk+aTB
         VVQsKXyqiuI0EuEYkT7uaOli+kMaJpJ35V8esiS5lPwxyspFK+gvLRYGCKDD44tFAu
         kUqnqpiNJzbxgruJltqe8XRFK+D71rzeZIbdRFYHb2CmJMiCR5rslxME3jg8OPsxEe
         xswKCaPj9oZ/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7DFA940468; Wed,  4 Jan 2023 16:13:47 -0300 (-03)
Date:   Wed, 4 Jan 2023 16:13:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add missing sys/types.h include
Message-ID: <Y7XP66TlOpkVlwyp@kernel.org>
References: <20230104182313.3164736-1-jesussanp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104182313.3164736-1-jesussanp@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 04, 2023 at 10:23:13AM -0800, Jesus Sanchez-Palencia escreveu:
> Not all libc implementations define ssize_t as part of stdio.h like
> glibc does since the standard only requires this type to be defined by
> unistd.h and sys/types.h. For this reason the perf build is currently
> broken for toolchains based on uClibc, for instance.
> 
> Include sys/types.h explicitly to fix that. This is a follow up to
> commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").

Do you mean this problem started with the 378ef0f5d9d7 commit? If so
then this is the fase for adding:

Fixes: 378ef0f5d9d7 ("perf build: Use libtraceevent from the system")

To this patch, ok?

- Arnaldo
 
> Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
> ---
>  tools/perf/util/trace-event.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index add6c5d9531c..9b3cd79cca12 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -4,6 +4,7 @@
>  
>  #include <stdbool.h>
>  #include <stdio.h>
> +#include <sys/types.h>
>  #include <linux/types.h>
>  
>  struct evlist;
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 

- Arnaldo
