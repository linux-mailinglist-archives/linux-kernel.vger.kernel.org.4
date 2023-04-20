Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD96E8E69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjDTJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjDTJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:44:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 658B9525A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:43:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9E61480;
        Thu, 20 Apr 2023 02:44:08 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F253F5A1;
        Thu, 20 Apr 2023 02:43:23 -0700 (PDT)
Message-ID: <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
Date:   Thu, 20 Apr 2023 10:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf cs-etm: Add support for coresight trace for any
 range of CPUs
Content-Language: en-US
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com
References: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2023 18:21, Ganapatrao Kulkarni wrote:
> The current implementation supports coresight trace for a range of
> CPUs, if the first CPU is CPU0.
> 
> Adding changes to enable coresight trace for any range of CPUs by
> decoding the first CPU also from the header.
> Later, first CPU id is used instead of CPU0 across the decoder functions.
> 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
>  tools/perf/util/cs-etm.c                      | 62 ++++++++++++-------
>  3 files changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 82a27ab90c8b..41ab299b643b 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -724,7 +724,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  }
>  
>  struct cs_etm_decoder *
> -cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
> +cs_etm_decoder__new(int first_decoder, int decoders, struct cs_etm_decoder_params *d_params,
>  		    struct cs_etm_trace_params t_params[])
>  {
>  	struct cs_etm_decoder *decoder;
> @@ -769,7 +769,7 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
>  	/* init raw frame logging if required */
>  	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>  
> -	for (i = 0; i < decoders; i++) {
> +	for (i = first_decoder; i < decoders; i++) {
>  		ret = cs_etm_decoder__create_etm_decoder(d_params,
>  							 &t_params[i],
>  							 decoder);
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 92a855fbe5b8..b06193fc75b4 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -90,7 +90,8 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
>  				       size_t len, size_t *consumed);
>  
>  struct cs_etm_decoder *
> -cs_etm_decoder__new(int num_cpu,
> +cs_etm_decoder__new(int first_decoder,
> +		    int decoders,
>  		    struct cs_etm_decoder_params *d_params,
>  		    struct cs_etm_trace_params t_params[]);
>  
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 94e2d02009eb..2619513ae088 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -55,6 +55,8 @@ struct cs_etm_auxtrace {
>  	u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
>  
>  	int num_cpu;
> +	int first_cpu;
> +	int last_cpu;
>  	u64 latest_kernel_timestamp;
>  	u32 auxtrace_type;
>  	u64 branches_sample_type;
> @@ -638,14 +640,13 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
>  }
>  
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> -				     struct cs_etm_auxtrace *etm,
> -				     int decoders)
> +				     struct cs_etm_auxtrace *etm)
>  {
>  	int i;
>  	u32 etmidr;
>  	u64 architecture;
>  
> -	for (i = 0; i < decoders; i++) {
> +	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>  		architecture = etm->metadata[i][CS_ETM_MAGIC];
>  
>  		switch (architecture) {
> @@ -817,7 +818,7 @@ static void cs_etm__free(struct perf_session *session)
>  	/* Then the RB tree itself */
>  	intlist__delete(traceid_list);
>  
> -	for (i = 0; i < aux->num_cpu; i++)
> +	for (i = aux->first_cpu; i < aux->last_cpu; i++)
>  		zfree(&aux->metadata[i]);
>  
>  	thread__zput(aux->unknown_thread);
> @@ -921,7 +922,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>  	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
>  	 * needed.
>  	 */
> -	int decoders = formatted ? etm->num_cpu : 1;
> +	int first_decoder = formatted ? etm->first_cpu : 0;
> +	int decoders = first_decoder + (formatted ? etm->num_cpu : 1);
>  
>  	etmq = zalloc(sizeof(*etmq));
>  	if (!etmq)
> @@ -937,7 +939,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>  	if (!t_params)
>  		goto out_free;
>  
> -	if (cs_etm__init_trace_params(t_params, etm, decoders))
> +	if (cs_etm__init_trace_params(t_params, etm))
>  		goto out_free;
>  
>  	/* Set decoder parameters to decode trace packets */
> @@ -947,8 +949,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
>  					formatted))
>  		goto out_free;
>  
> -	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
> -					    t_params);
> +	etmq->decoder = cs_etm_decoder__new(first_decoder, decoders, &d_params, t_params);
>  
>  	if (!etmq->decoder)
>  		goto out_free;
> @@ -2959,11 +2960,11 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
>   * Loop through the ETMs and complain if we find at least one where ts_source != 1 (virtual
>   * timestamps).
>   */
> -static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
> +static bool cs_etm__has_virtual_ts(u64 **metadata, struct cs_etm_auxtrace *etm)
>  {
>  	int j;
>  
> -	for (j = 0; j < num_cpu; j++) {
> +	for (j = etm->first_cpu; j < etm->last_cpu; j++) {
>  		switch (metadata[j][CS_ETM_MAGIC]) {
>  		case __perf_cs_etmv4_magic:
>  			if (HAS_PARAM(j, ETMV4, TS_SOURCE) || metadata[j][CS_ETMV4_TS_SOURCE] != 1)
> @@ -2982,13 +2983,14 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
>  }
>  
>  /* map trace ids to correct metadata block, from information in metadata */
> -static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
> +static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm)
>  {
>  	u64 cs_etm_magic;
> +	u64 **metadata = etm->metadata;
>  	u8 trace_chan_id;
>  	int i, err;
>  
> -	for (i = 0; i < num_cpu; i++) {
> +	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>  		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>  		switch (cs_etm_magic) {
>  		case __perf_cs_etmv3_magic:
> @@ -3015,12 +3017,13 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
>   * If we found AUX_HW_ID packets, then set any metadata marked as unused to the
>   * unused value to reduce the number of unneeded decoders created.
>   */
> -static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
> +static int cs_etm__clear_unused_trace_ids_metadata(struct cs_etm_auxtrace *etm)
>  {
>  	u64 cs_etm_magic;
> +	u64 **metadata = etm->metadata;
>  	int i;
>  
> -	for (i = 0; i < num_cpu; i++) {
> +	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
>  		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
>  		switch (cs_etm_magic) {
>  		case __perf_cs_etmv3_magic:
> @@ -3049,7 +3052,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	int event_header_size = sizeof(struct perf_event_header);
>  	int total_size = auxtrace_info->header.size;
>  	int priv_size = 0;
> -	int num_cpu;
> +	int num_cpu, first_cpu = 0, last_cpu;
>  	int err = 0;
>  	int aux_hw_id_found;
>  	int i, j;
> @@ -3068,22 +3071,31 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	/* First the global part */
>  	ptr = (u64 *) auxtrace_info->priv;
>  	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> -	metadata = zalloc(sizeof(*metadata) * num_cpu);
> +
> +	/* Start parsing after the common part of the header */
> +	i = CS_HEADER_VERSION_MAX;
> +
> +	/*Get CPU id of first event */
> +	first_cpu = ptr[i + CS_ETM_CPU];
> +	last_cpu = first_cpu + num_cpu;
> +
> +	if (first_cpu > cpu__max_cpu().cpu ||
> +			last_cpu > cpu__max_cpu().cpu)
> +		return -EINVAL;
> +
> +	metadata = zalloc(sizeof(*metadata) * last_cpu);

Hi Ganapatrao,

I think I see what the problem is, but I'm wondering if a better fix
would be to further decouple the CPU ID from the index in the array.

With your change it's not clear what happens with sparse recordings, for
example 'perf record -e cs_etm// -C 1,3,5'. And it seems like there is
some wastage in the zalloc here for example if only CPU 256 is traced
then we'd still make 256 decoders but 255 of them would be unused?

I tried to test sparse recordings, but your change doesn't apply to the
latest coresight/next branch. I did notice that 'perf report -D' doesn't
work with them on coresight/next (it just quits), but I couldn't see if
that's fixed with your change.

Would a better fix not be to keep the metadata loops from 0-N and
instead save the CPU ID in cs_etm_decoder_params or the decoder. That
way it would support both sparse and not starting from 0 cases? I think
the code would be better if it's worded like "i < recorded_cpus" rather
than "i < cpu" to make it clear that i isn't actually the CPU ID it's
just an index.

Also a new test for this scenario would probably be a good idea.

Thanks
James

