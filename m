Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED86675AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjATRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:12:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E7C4211;
        Fri, 20 Jan 2023 09:12:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26D8BB82952;
        Fri, 20 Jan 2023 17:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69100C433D2;
        Fri, 20 Jan 2023 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674234753;
        bh=5/Fnnbq1fiKeKGOupF8lNlxZuDViFXq6uw5YklhFebM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=csO0aUiFLUfdUVSqmCwOMSObpR3wVCXNmDJOQGeXPOvPlQ4HoZ+EuFJZTCTbmi8es
         1kNUrK4HFZf1KW7w+6ry2sostLpSsXBVT/u7XDKYlsd1IcP2qk4EjmFr7wMFc7GX1L
         +vCg65SRMQooPAdNumQlvfWC4tYdbB94l25vVwvPUAcph58mKMIacnTmurZiVZlXfw
         n/llHMj7otdYTw8BP9J0biOjLM1ey/YXe6+FvppnH2Atzs3GF4ZLA9MLtERFgWQYmk
         R7oRNudw67ERrO/Y5k4qG7eU1tZNduWaEsBAI6U4M73VqsQbo+q7ZPUP/Yscl2ik8l
         52P6D53GeRORA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8B52405BE; Fri, 20 Jan 2023 14:12:30 -0300 (-03)
Date:   Fri, 20 Jan 2023 14:12:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org, sgoutham@marvell.com,
        gcherian@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] perf: cs-etm: Ensure that Coresight timestamps
 don't go backwards
Message-ID: <Y8rLfroSyYzgr5z9@kernel.org>
References: <20230120143702.4035046-1-james.clark@arm.com>
 <20230120143702.4035046-9-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120143702.4035046-9-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 20, 2023 at 02:37:01PM +0000, James Clark escreveu:
> There are some edge cases around estimated timestamps that can result
> in them going backwards.
> 
> One is that after a discontinuity, the last used timestamp is set to 0.
> The duration of the next range is then subtracted which could result in
> an earlier timestamp than the last instruction. Fix this by not
> resetting the last timestamp used on a discontinuity, and make sure that
> new estimated timestamps are clamped to be later than that.
> 
> Another case is that estimated timestamps could compound over time to
> end up being more than the next real timestamp in the trace. Fix this by
> clamping the estimates in cs_etm_decoder__do_soft_timestamp() to be no
> later than it.
> 
> cs_etm_decoder__do_soft_timestamp() also updated next_cs_timestamp,
> which meant that the next real timestamp was lost and not stored
> anywhere. Fix that by only updating cs_timestamp for estimates and keep
> next_cs_timestamp untouched.
> 
> Finally, use next_cs_timestamp to signify if a timestamp has been
> received previously. Because cs_timestamp has the first range
> subtracted, it could technically go to 0 which would break the logic.
> 
> Testing
> =======
> 
> It can be verified that timestamps don't go backwards when tracing on a
> single core with the following commands. Across multiple cores it's
> expected that timestamps are interleaved:
> 
>  $ perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
>  $ perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent > itrace
>  $ sed 's/://g' itrace | awk -F ' ' ' { print $4 } ' | awk '{ if ($1 < prev) { print "line:" NR " " $0 } {prev=$1}}'

Trying:

root@roc-rk3399-pc:~# uname -a
Linux roc-rk3399-pc 6.1.0-rc5-00123-g4dd7ff4a0311 #2 SMP PREEMPT Wed Nov 16 19:55:11 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux
root@roc-rk3399-pc:~#
root@roc-rk3399-pc:~# perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
failed to set sink "tmc_etr0" on event cs_etm/@tmc_etr0/k with 2 (No such file or directory)
root@roc-rk3399-pc:~#

We could have a better message at some point, right? :-)

Something like:

root@roc-rk3399-pc:~# perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
This system lacks the CoreSight component.
root@roc-rk3399-pc:~#

Anyway, applied the patches and test building now.

- Arnaldo
 
> Reported-by: Tanmay Jagdale <tanmay@marvell.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 440fe844ed17..63afa2d05b46 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -283,15 +283,17 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>  				  struct cs_etm_packet_queue *packet_queue,
>  				  const uint8_t trace_chan_id)
>  {
> +	u64 estimated_ts;
> +
>  	/* No timestamp packet has been received, nothing to do */
> -	if (!packet_queue->cs_timestamp)
> +	if (!packet_queue->next_cs_timestamp)
>  		return OCSD_RESP_CONT;
>  
> -	packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
> +	estimated_ts = packet_queue->cs_timestamp +
> +			cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
>  
> -	/* Estimate the timestamp for the next range packet */
> -	packet_queue->next_cs_timestamp +=
> -		cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
> +	/* Estimated TS can never be higher than the next real one in the trace */
> +	packet_queue->cs_timestamp = min(packet_queue->next_cs_timestamp, estimated_ts);
>  
>  	/* Tell the front end which traceid_queue needs attention */
>  	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
> @@ -307,6 +309,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  {
>  	struct cs_etm_packet_queue *packet_queue;
>  	u64 converted_timestamp;
> +	u64 estimated_first_ts;
>  
>  	/* First get the packet queue for this traceID */
>  	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
> @@ -325,7 +328,12 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  	 * Function do_soft_timestamp() will report the value to the front end,
>  	 * hence asking the decoder to keep decoding rather than stopping.
>  	 */
> -	if (packet_queue->cs_timestamp) {
> +	if (packet_queue->next_cs_timestamp) {
> +		/*
> +		 * What was next is now where new ranges start from, overwriting
> +		 * any previous estimate in cs_timestamp
> +		 */
> +		packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
>  		packet_queue->next_cs_timestamp = converted_timestamp;
>  		return OCSD_RESP_CONT;
>  	}
> @@ -355,10 +363,12 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  		 * or a discontinuity.  Since timestamps packets are generated *after*
>  		 * range packets have been generated, we need to estimate the time at
>  		 * which instructions started by subtracting the number of instructions
> -		 * executed to the timestamp.
> +		 * executed to the timestamp. Don't estimate earlier than the last used
> +		 * timestamp though.
>  		 */
> -		packet_queue->cs_timestamp = converted_timestamp -
> -						(packet_queue->instr_count / INSTR_PER_NS);
> +		estimated_first_ts = converted_timestamp -
> +					(packet_queue->instr_count / INSTR_PER_NS);
> +		packet_queue->cs_timestamp = max(packet_queue->cs_timestamp, estimated_first_ts);
>  	}
>  	packet_queue->next_cs_timestamp = converted_timestamp;
>  	packet_queue->instr_count = 0;
> @@ -373,7 +383,6 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  static void
>  cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
>  {
> -	packet_queue->cs_timestamp = 0;
>  	packet_queue->next_cs_timestamp = 0;
>  	packet_queue->instr_count = 0;
>  }
> -- 
> 2.25.1
> 

-- 

- Arnaldo
