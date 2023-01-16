Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2566B75E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjAPGOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAPGOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:14:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4A44483;
        Sun, 15 Jan 2023 22:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673849680; x=1705385680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fYWke13lKCI4mRfwIKwzjkt+o2kD3ODpPS5FXnrynV0=;
  b=jKSlyF108jfoVcKLw/I39QYVahW7OwmjMo1kreWkMQVKc9FpYa91QbPE
   lvN707oee7uCVBN4YOHFSZiiWGgV5ADudZgFEbMjmRbVExxYTc8Neb4+m
   JlsSzSHmdy3hrNcDxdIzbNhYLDrxKLlXWrzNGXVQhyFWaabQqvlzEfP2y
   6u7V286/9p0BhU1gawz4j4nIfpfeJRlvkFcEHSvPm7nb6nbX4I2d0F7jy
   YfcYXm6V+It5vgdIaUpPzDhjsVZ2im6xoha7bL3dUmyMyLgPNOr9ErEBQ
   lNcs3SaiH2b5Ne7uaymVGm4C8mbMtzH0UC869kkQwN30YdWhj7ZzMKwe0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="307947882"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="307947882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:14:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832725848"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="832725848"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.56])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:14:34 -0800
Message-ID: <cbcb6109-0c23-9270-a534-c4fabdddfbbc@intel.com>
Date:   Mon, 16 Jan 2023 08:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [RFC 3/4] perf tool: Introduce PERF_RECORD_KMOD_SEC_MAP
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, james.clark@arm.com,
        german.gomez@arm.com, leo.yan@linaro.org,
        alexey.v.bayduraev@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
References: <20230110055859.685-1-ravi.bangoria@amd.com>
 <20230110055859.685-4-ravi.bangoria@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230110055859.685-4-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/23 07:58, Ravi Bangoria wrote:
> Introduce, perf tool only, synthetic event type PERF_RECORD_KMOD_SEC_MAP.
> Also add stub code for it. This event will be used to save/restore kernel
> module section maps to/from perf.data file. This is needed because kernel
> module elfs does not contain program header table and thus there is no
> easy way to find out how kernel would have loaded module sections in the
> memory.

Currently machine__addnew_module_map() adds a map for a
module, and then perf_event__synthesize_modules() creates
an MMAP/MMAP2 event for it.  Why can't we do that for the
sections?

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  1 +
>  tools/lib/perf/include/perf/event.h      | 25 ++++++++++++++++++++++++
>  tools/perf/util/event.c                  |  1 +
>  tools/perf/util/session.c                | 12 ++++++++++++
>  tools/perf/util/tool.h                   |  3 ++-
>  5 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index a8f1a237931b..b62730b84cc5 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -211,6 +211,7 @@ SYNOPSIS
>    struct perf_record_time_conv;
>    struct perf_record_header_feature;
>    struct perf_record_compressed;
> +  struct perf_record_kmod_sec_maps;
>  --
>  
>  DESCRIPTION
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index ad47d7b31046..404b23b6902b 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -438,6 +438,29 @@ struct perf_record_compressed {
>  	char			 data[];
>  };
>  
> +/* Kernel module elf section maps */
> +struct perf_record_kmod_sec_map {
> +	struct perf_event_header header;
> +	/* Machine id. Same as synthesized PERF_RECORD_MMAP */
> +	__u32			 pid;
> +	/* Section start ip address */
> +	__u64			 start;
> +	/* Section length */
> +	__u64			 len;
> +	/* Section page offset in kernel module elf file */
> +	__u64			 pgoff;
> +	/* Section name length, including '\0' */
> +	__u16			 sec_name_len;
> +	/* Kernel module filename(path) length, including '\0' */
> +	__u16			 filename_len;
> +	/*
> +	 * Section name and filename stored as: "sec_name\0filename\0". i.e:
> +	 * data[0]: Section name
> +	 * data[sec_name_len + 1]: File name
> +	 */
> +	char			 data[];
> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_USER_TYPE_START		= 64,
>  	PERF_RECORD_HEADER_ATTR			= 64,
> @@ -459,6 +482,7 @@ enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_HEADER_FEATURE		= 80,
>  	PERF_RECORD_COMPRESSED			= 81,
>  	PERF_RECORD_FINISHED_INIT		= 82,
> +	PERF_RECORD_KMOD_SEC_MAP		= 83,
>  	PERF_RECORD_HEADER_MAX
>  };
>  
> @@ -499,6 +523,7 @@ union perf_event {
>  	struct perf_record_time_conv		time_conv;
>  	struct perf_record_header_feature	feat;
>  	struct perf_record_compressed		pack;
> +	struct perf_record_kmod_sec_map		kmod_sec_map;
>  };
>  
>  #endif /* __LIBPERF_EVENT_H */
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 1fa14598b916..1b03061440bc 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -77,6 +77,7 @@ static const char *perf_event__names[] = {
>  	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
>  	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
>  	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
> +	[PERF_RECORD_KMOD_SEC_MAP]		= "KMOD_SEC_MAP",
>  };
>  
>  const char *perf_event__name(unsigned int id)
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7c021c6cedb9..4f5165cd58de 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -563,6 +563,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>  		tool->compressed = perf_session__process_compressed_event;
>  	if (tool->finished_init == NULL)
>  		tool->finished_init = process_event_op2_stub;
> +	if (tool->kmod_sec_map == NULL)
> +		tool->kmod_sec_map = process_event_stub;
>  }
>  
>  static void swap_sample_id_all(union perf_event *event, void *data)
> @@ -997,6 +999,12 @@ static void perf_event__time_conv_swap(union perf_event *event,
>  	}
>  }
>  
> +static void perf_event_kmod_sec_map_swap(union perf_event *event __maybe_unused,
> +					  bool sample_id_all __maybe_unused)
> +{
> +	/* FIXME */
> +}
> +
>  typedef void (*perf_event__swap_op)(union perf_event *event,
>  				    bool sample_id_all);
>  
> @@ -1035,6 +1043,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>  	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
>  	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
>  	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
> +	[PERF_RECORD_KMOD_SEC_MAP]	  = perf_event_kmod_sec_map_swap,
>  	[PERF_RECORD_HEADER_MAX]	  = NULL,
>  };
>  
> @@ -1727,6 +1736,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>  		return err;
>  	case PERF_RECORD_FINISHED_INIT:
>  		return tool->finished_init(session, event);
> +	case PERF_RECORD_KMOD_SEC_MAP:
> +		/* Currently PERF_RECORD_KMOD_SEC_MAP is supported only for host */
> +		return tool->kmod_sec_map(tool, event, &sample, &session->machines.host);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index c957fb849ac6..8ea7fb85c196 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -60,7 +60,8 @@ struct perf_tool {
>  			unthrottle,
>  			ksymbol,
>  			bpf,
> -			text_poke;
> +			text_poke,
> +			kmod_sec_map;
>  
>  	event_attr_op	attr;
>  	event_attr_op	event_update;

