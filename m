Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112195FF596
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJNVvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJNVvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:51:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED17E196A;
        Fri, 14 Oct 2022 14:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71E54B82415;
        Fri, 14 Oct 2022 21:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E361FC433C1;
        Fri, 14 Oct 2022 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665784287;
        bh=t6X96WrTpHzdY9RCCykaXUjgjeyB9rZdjgF4GHa+934=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCx7BuO5YRXbqYheQl/7LXwHPvnAiVyq01lWSZLiBOYp2Ii8q4SJAv6vryvHMuYlG
         BZg/YTm7gGMrsE5EwgqLsNPuJYL+Pi2gcmzbhN7QkY9EWNpEocbSm9uNlYikXAsa9q
         61aNJIuW+f0n0IzT0EgNYrGeyUeMAWTkwvAr/J7Rq8aSIHETZI5gOiIPtxmTyfv/pw
         W+eHVPFRo4090wXzBgUSEZKp82jc6jkV8GYyNiRpDB8TAcqo5LBJLeteawiqCxwcyI
         GkJ++oT8cGx2PeMmdlWd9zsLW4CCFRbkoJAyGSFHWGCVMlay5jp/yryDJZC2kVSCy4
         VTmTC40ZuC7JA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35F7B403B6; Fri, 14 Oct 2022 18:51:24 -0300 (-03)
Date:   Fri, 14 Oct 2022 18:51:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v4 2/3] perf tools: Sync perf_event_attr::config3 addition
Message-ID: <Y0nZ3HQ6q9HzvEas@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v4-2-83c098e6212e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v4-2-83c098e6212e@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 04, 2022 at 02:12:36PM -0500, Rob Herring escreveu:
> Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> existing perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config3' field.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This patch is dependent on the kernel side landing first.
> ---
>  include/uapi/linux/perf_event.h       | 3 +++
>  tools/include/uapi/linux/perf_event.h | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 03b370062741..b53f9b958235 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -333,6 +333,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -474,6 +475,8 @@ struct perf_event_attr {
>  	 * truncated accordingly on 32 bit architectures.
>  	 */
>  	__u64	sig_data;
> +
> +	__u64	config3; /* extension of config2 */
>  };
>  
>  /*


I'm removing the above part, as this is for the kernel, not for tooling.

Was this part submitted upstream? I couldn't find, so far, where it was
submitted, can you please clarify?

- Arnaldo

> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 581ed4bdc062..7fad17853310 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -333,6 +333,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -474,6 +475,8 @@ struct perf_event_attr {
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
> b4 0.11.0-dev

-- 

- Arnaldo
