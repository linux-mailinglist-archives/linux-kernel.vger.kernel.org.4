Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1369BA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBRNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBRNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:22:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F078D1A649;
        Sat, 18 Feb 2023 05:21:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A737160B95;
        Sat, 18 Feb 2023 13:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0140C433D2;
        Sat, 18 Feb 2023 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676726512;
        bh=CeupupIsVHIMUQQJUZ3jIKyLcZQLpPGrGd5qnaaeig4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBwuHJFxur0MBgyRVuRSB67Ddv77q2jXCiAFQUF0kZZZvqS498U5dzKMonJ38iQn5
         bOA/1CJLSZrwt2pdVcg568tSsivySdjfiu/8mK0HHXsLWnNFE2WRJK1lLOEt20Xzf/
         bE7r6K75SCc0WvCGtVI4mYoFSG1eY9E/L+eMDu6rcM4AQXFw5Qg/X7xY/NFFe1Di9L
         IUsAuB3sBwUGI1WmVwVlEJaHWdL1hq73YvulwcFXaHO3WEh9qLZYywGI9T122izm7l
         2i9EF9cEpkgZ/hyi9/CmNh96INoJXmkrwJb/919TUKamcgU5HZPgAhcOC99lAwxVwr
         AKRPbDSSB37Bw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 486B740025; Sat, 18 Feb 2023 10:21:49 -0300 (-03)
Date:   Sat, 18 Feb 2023 10:21:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf tools: Sync perf_event_attr::config3 addition
Message-ID: <Y/DQ7Y+FD4cMn29J@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v5-1-2cf5210b2f77@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v5-1-2cf5210b2f77@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 17, 2023 at 04:32:10PM -0600, Rob Herring escreveu:
> Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> existing perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config3' field.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This matches commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> for the kernel queued in linux-next.

When you mention linux-next where was it that it picked this from?

For me to get this merged into the perf tools "next" (perf/core) it must
already have been merged in the kernel counterpart (tip/perf/core).

Ok so it is not in tip/perf/core, but got in next yesterday, and PeterZ
acked it, good, will process it soon.

- Arnaldo

⬢[acme@toolbox perf]$ git show 09519ec3b19e
commit 09519ec3b19e4144b5f6e269c54fbb9c294a9fcb
Author: Rob Herring <robh@kernel.org>
Date:   Mon Jan 9 13:26:23 2023 -0600

    perf: Add perf_event_attr::config3

    Arm SPEv1.2 adds another 64-bits of event filtering control. As the
    existing perf_event_attr::configN fields are all used up for SPE PMU, an
    additional field is needed. Add a new 'config3' field.

    Tested-by: James Clark <james.clark@arm.com>
    Signed-off-by: Rob Herring <robh@kernel.org>
    Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v4-7-327f860daf28@kernel.org
    Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ccb7f5dad59be96b..37675437b76860ae 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -374,6 +374,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5    112     /* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6    120     /* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7    128     /* add: sig_data */
+#define PERF_ATTR_SIZE_VER8    136     /* add: config3 */

 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -515,6 +516,8 @@ struct perf_event_attr {
         * truncated accordingly on 32 bit architectures.
         */
        __u64   sig_data;
+
+       __u64   config3; /* extension of config2 */
 };

 /*
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ git tag --contains 09519ec3b19e4144b5f6e269c54fbb9c294a9fcb
next-20230217
⬢[acme@toolbox perf]$


> ---
>  tools/include/uapi/linux/perf_event.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index ea6defacc1a7..a38814ce9485 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -365,6 +365,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -506,6 +507,8 @@ struct perf_event_attr {
>  	 * truncated accordingly on 32 bit architectures.
>  	 */
>  	__u64	sig_data;
> +
> +	__u64	config3; /* extension of config2 */
>  };
>  
>  /*
> 
> -- 
> 2.39.1
> 
