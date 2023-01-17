Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6553A66DD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjAQMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjAQME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:04:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2C136FE5;
        Tue, 17 Jan 2023 04:04:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76045C14;
        Tue, 17 Jan 2023 04:05:06 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09BB3F67D;
        Tue, 17 Jan 2023 04:04:22 -0800 (PST)
Message-ID: <563274be-5acf-3452-4031-797b1ca9c30c@arm.com>
Date:   Tue, 17 Jan 2023 12:04:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 09/15] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20230116124928.5440-1-mike.leach@linaro.org>
 <20230116124928.5440-10-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230116124928.5440-10-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike


On 16/01/2023 12:49, Mike Leach wrote:
> The information to associate Trace ID and CPU will be changing.
> 
> Drivers will start outputting this as a hardware ID packet in the data
> file which if present will be used in preference to the AUXINFO values.
> 
> To prepare for this we provide a helper functions to do the individual ID
> mapping, and one to extract the IDs from the completed metadata blocks.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   tools/include/linux/coresight-pmu.h |  5 ++
>   tools/perf/util/cs-etm.c            | 91 +++++++++++++++++++----------
>   tools/perf/util/cs-etm.h            | 14 ++++-
>   3 files changed, 77 insertions(+), 33 deletions(-)
> 

...

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 33303d03c2fa..f77260b9253e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

...

>   int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   				       struct perf_session *session)
>   {
> @@ -2755,7 +2809,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   	int event_header_size = sizeof(struct perf_event_header);
>   	int total_size = auxtrace_info->header.size;
>   	int priv_size = 0;
> -	int num_cpu, trcidr_idx;
> +	int num_cpu;
>   	int err = 0;
>   	int i, j;
>   	u64 *ptr = NULL;
> @@ -2794,23 +2848,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   				cs_etm__create_meta_blk(ptr, &i,
>   							CS_ETM_PRIV_MAX,
>   							CS_ETM_NR_TRC_PARAMS_V0);
> -
> -			/* The traceID is our handle */
> -			trcidr_idx = CS_ETM_ETMTRACEIDR;
> -
>   		} else if (ptr[i] == __perf_cs_etmv4_magic) {
>   			metadata[j] =
>   				cs_etm__create_meta_blk(ptr, &i,
>   							CS_ETMV4_PRIV_MAX,
>   							CS_ETMV4_NR_TRC_PARAMS_V0);
> -
> -			/* The traceID is our handle */
> -			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
>   		} else if (ptr[i] == __perf_cs_ete_magic) {
>   			metadata[j] = cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);
> -
> -			/* ETE shares first part of metadata with ETMv4 */
> -			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
>   		} else {
>   			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
>   				  ptr[i]);
> @@ -2822,26 +2866,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>   			err = -ENOMEM;
>   			goto err_free_metadata;
>   		}
> -
> -		/* Get an RB node for this CPU */
> -		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
> -
> -		/* Something went wrong, no need to continue */
> -		if (!inode) {
> -			err = -ENOMEM;
> -			goto err_free_metadata;
> -		}
> -
> -		/*
> -		 * The node for that CPU should not be taken.
> -		 * Back out if that's the case.
> -		 */
> -		if (inode->priv) {
> -			err = -EINVAL;
> -			goto err_free_metadata;
> -		}
> -		/* All good, associate the traceID with the metadata pointer */
> -		inode->priv = metadata[j];


This gives me a build error as below :

util/cs-etm.c: In function ‘cs_etm__process_auxtrace_info_full’:
util/cs-etm.c:2808:19: error: unused variable ‘inode’ 
[-Werror=unused-variable]
  2808 |  struct int_node *inode;
       |                   ^~~~~


I have folded the following fix in:

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f77260b9253e..413a89b22fec 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2805,7 +2805,6 @@ int cs_etm__process_auxtrace_info_full(union 
perf_event *event,
  {
         struct perf_record_auxtrace_info *auxtrace_info = 
&event->auxtrace_info;
         struct cs_etm_auxtrace *etm = NULL;
-       struct int_node *inode;
         int event_header_size = sizeof(struct perf_event_header);
         int total_size = auxtrace_info->header.size;
         int priv_size = 0;


Thanks
Suzuki

