Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46C6CD97C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC2Mmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC2Mmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD2F4;
        Wed, 29 Mar 2023 05:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E54A61C83;
        Wed, 29 Mar 2023 12:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CBCC433EF;
        Wed, 29 Mar 2023 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680093752;
        bh=+ViLwzOwM+bAxSQOSldp0asillAvy/13rCO6C4cxHLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vD/uc0UacBov9dyJqj+44dngNUhkBdq3kdh6RmlbAErh6sqQIAASRhxPdo0fJDLaO
         5hlLBhpRvnxXuyt35JOyrndA5f8ePiuWDCz7Gal4ZMkRIdj8JgLC0PkKYmozfZWILV
         G9aYTk3hywwMDvQQfCDrw4TBRLJeYC7fz+h3Vq9RotYyIuEstclTKl7u6Fc0hms94c
         UKR3JrZzPwrGtrP/adOK5j93yTUFhBvGHJ1obXSNXhlnYNKMb6HUlneyAtsejBE6Eb
         clQuqaZlaquN4J840nqjA+fEwdy3W9wIzI1Wiz3/a10BMLNekGgAIEzdbBTNrSC3gG
         DgQeEV9VnGniQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36B804052D; Wed, 29 Mar 2023 09:42:30 -0300 (-03)
Date:   Wed, 29 Mar 2023 09:42:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, john.garry@huawei.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Message-ID: <ZCQyNnk/vfHZkSda@kernel.org>
References: <20230329111422.3693-1-mike.leach@linaro.org>
 <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCQx5HlPnxCIFaNQ@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 29, 2023 at 09:41:08AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 29, 2023 at 12:14:20PM +0100, Mike Leach escreveu:
> > The information to associate Trace ID and CPU will be changing.
> > 
> > Drivers will start outputting this as a hardware ID packet in the data
> > file which if present will be used in preference to the AUXINFO values.
> 
>   CC      /tmp/build/perf-tools-next/util/symbol-elf.o
>   LD      /tmp/build/perf-tools-next/util/cs-etm-decoder/perf-in.o
> util/cs-etm.c: In function ‘cs_etm__process_auxtrace_info_full’:
> util/cs-etm.c:2866:26: error: unused variable ‘inode’ [-Werror=unused-variable]
>  2866 |         struct int_node *inode;
>       |                          ^~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/cs-etm.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> gmake[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Err
> 
> Trying to fix...

Seems simple, the variable isn't used at all, so I added:

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f6ca07f68b251274..5fc9c288080b4526 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2863,7 +2863,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
-	struct int_node *inode;
 	struct perf_record_time_conv *tc = &session->time_conv;
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;


  
> > To prepare for this we provide a helper functions to do the individual ID
> > mapping, and one to extract the IDs from the completed metadata blocks.
> > 
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  tools/include/linux/coresight-pmu.h |  5 ++
> >  tools/perf/util/cs-etm.c            | 91 +++++++++++++++++++----------
> >  tools/perf/util/cs-etm.h            | 14 ++++-
> >  3 files changed, 77 insertions(+), 33 deletions(-)
> > 
> > diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> > index 6c2fd6cc5a98..db9c7c0abb6a 100644
> > --- a/tools/include/linux/coresight-pmu.h
> > +++ b/tools/include/linux/coresight-pmu.h
> > @@ -7,9 +7,14 @@
> >  #ifndef _LINUX_CORESIGHT_PMU_H
> >  #define _LINUX_CORESIGHT_PMU_H
> >  
> > +#include <linux/bits.h>
> > +
> >  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> >  #define CORESIGHT_ETM_PMU_SEED  0x10
> >  
> > +/* CoreSight trace ID is currently the bottom 7 bits of the value */
> > +#define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
> > +
> >  /*
> >   * Below are the definition of bit offsets for perf option, and works as
> >   * arbitrary values for all ETM versions.
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index f65bac5ddbdb..f6ca07f68b25 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -196,6 +196,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
> >  	return 0;
> >  }
> >  
> > +static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
> > +{
> > +	struct int_node *inode;
> > +
> > +	/* Get an RB node for this CPU */
> > +	inode = intlist__findnew(traceid_list, trace_chan_id);
> > +
> > +	/* Something went wrong, no need to continue */
> > +	if (!inode)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * The node for that CPU should not be taken.
> > +	 * Back out if that's the case.
> > +	 */
> > +	if (inode->priv)
> > +		return -EINVAL;
> > +
> > +	/* All good, associate the traceID with the metadata pointer */
> > +	inode->priv = cpu_metadata;
> > +
> > +	return 0;
> > +}
> > +
> >  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> >  					      u8 trace_chan_id)
> >  {
> > @@ -2804,6 +2828,36 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
> >  	return true;
> >  }
> >  
> > +/* map trace ids to correct metadata block, from information in metadata */
> > +static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
> > +{
> > +	u64 cs_etm_magic;
> > +	u8 trace_chan_id;
> > +	int i, err;
> > +
> > +	for (i = 0; i < num_cpu; i++) {
> > +		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
> > +		switch (cs_etm_magic) {
> > +		case __perf_cs_etmv3_magic:
> > +			trace_chan_id = (u8)((metadata[i][CS_ETM_ETMTRACEIDR]) &
> > +					     CORESIGHT_TRACE_ID_VAL_MASK);
> > +			break;
> > +		case __perf_cs_etmv4_magic:
> > +		case __perf_cs_ete_magic:
> > +			trace_chan_id = (u8)((metadata[i][CS_ETMV4_TRCTRACEIDR]) &
> > +					      CORESIGHT_TRACE_ID_VAL_MASK);
> > +			break;
> > +		default:
> > +			/* unknown magic number */
> > +			return -EINVAL;
> > +		}
> > +		err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
> > +		if (err)
> > +			return err;
> > +	}
> > +	return 0;
> > +}
> > +
> >  int cs_etm__process_auxtrace_info_full(union perf_event *event,
> >  				       struct perf_session *session)
> >  {
> > @@ -2814,7 +2868,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
> >  	int event_header_size = sizeof(struct perf_event_header);
> >  	int total_size = auxtrace_info->header.size;
> >  	int priv_size = 0;
> > -	int num_cpu, trcidr_idx;
> > +	int num_cpu;
> >  	int err = 0;
> >  	int i, j;
> >  	u64 *ptr = NULL;
> > @@ -2853,23 +2907,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
> >  				cs_etm__create_meta_blk(ptr, &i,
> >  							CS_ETM_PRIV_MAX,
> >  							CS_ETM_NR_TRC_PARAMS_V0);
> > -
> > -			/* The traceID is our handle */
> > -			trcidr_idx = CS_ETM_ETMTRACEIDR;
> > -
> >  		} else if (ptr[i] == __perf_cs_etmv4_magic) {
> >  			metadata[j] =
> >  				cs_etm__create_meta_blk(ptr, &i,
> >  							CS_ETMV4_PRIV_MAX,
> >  							CS_ETMV4_NR_TRC_PARAMS_V0);
> > -
> > -			/* The traceID is our handle */
> > -			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> >  		} else if (ptr[i] == __perf_cs_ete_magic) {
> >  			metadata[j] = cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);
> > -
> > -			/* ETE shares first part of metadata with ETMv4 */
> > -			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> >  		} else {
> >  			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
> >  				  ptr[i]);
> > @@ -2881,26 +2925,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
> >  			err = -ENOMEM;
> >  			goto err_free_metadata;
> >  		}
> > -
> > -		/* Get an RB node for this CPU */
> > -		inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
> > -
> > -		/* Something went wrong, no need to continue */
> > -		if (!inode) {
> > -			err = -ENOMEM;
> > -			goto err_free_metadata;
> > -		}
> > -
> > -		/*
> > -		 * The node for that CPU should not be taken.
> > -		 * Back out if that's the case.
> > -		 */
> > -		if (inode->priv) {
> > -			err = -EINVAL;
> > -			goto err_free_metadata;
> > -		}
> > -		/* All good, associate the traceID with the metadata pointer */
> > -		inode->priv = metadata[j];
> >  	}
> >  
> >  	/*
> > @@ -2994,6 +3018,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
> >  	if (err)
> >  		goto err_delete_thread;
> >  
> > +	/* before aux records are queued, need to map metadata to trace IDs */
> > +	err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
> > +	if (err)
> > +		goto err_delete_thread;
> > +
> >  	err = cs_etm__queue_aux_records(session);
> >  	if (err)
> >  		goto err_delete_thread;
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index 98a4f7113d2f..6d3078e042b4 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -29,13 +29,17 @@ enum {
> >  /*
> >   * Update the version for new format.
> >   *
> > - * New version 1 format adds a param count to the per cpu metadata.
> > + * Version 1: format adds a param count to the per cpu metadata.
> >   * This allows easy adding of new metadata parameters.
> >   * Requires that new params always added after current ones.
> >   * Also allows client reader to handle file versions that are different by
> >   * checking the number of params in the file vs the number expected.
> > + *
> > + * Version 2: Drivers will use PERF_RECORD_AUX_OUTPUT_HW_ID to output
> > + * CoreSight Trace ID. ...TRACEIDR metadata will be set to unused ID.
> >   */
> > -#define CS_HEADER_CURRENT_VERSION 1
> > +#define CS_HEADER_CURRENT_VERSION	2
> > +#define CS_AUX_HW_ID_VERSION_MIN	2
> >  
> >  /* Beginning of header common to both ETMv3 and V4 */
> >  enum {
> > @@ -97,6 +101,12 @@ enum {
> >  	CS_ETE_PRIV_MAX
> >  };
> >  
> > +/*
> > + * Check for valid CoreSight trace ID. If an invalid value is present in the metadata,
> > + * then IDs are present in the hardware ID packet in the data file.
> > + */
> > +#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
> > +
> >  /*
> >   * ETMv3 exception encoding number:
> >   * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
> > -- 
> > 2.32.0
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
