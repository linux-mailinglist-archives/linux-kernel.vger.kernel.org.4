Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A147606BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJTWzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJTWzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:55:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B7EE89C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666306510; x=1697842510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HaEK5LbY6MR/lwCX4fGSHt+gO7IvozjsluAn35ZYRb8=;
  b=Xkuu+z+tK9hG4+LtUGI7xIPAdUBnvxz6G4mgFq4ulQfV+MysI+/4pxzI
   RPMgLPbRrnF/hjlF4ei6kBhWaNZe2az055Ax0QP2diNv7FkzNP3ORWTFS
   KKWtWFQ6FXhhTXHjGTHgkvc03qV/vEkQkQwyGcpjnYlR639jtQNjKX51S
   yCE6lnfEqmvDxZ1KarkactEkJ8CYg51B1xqsn2tiDr7GSQnMsvEl+wrVU
   Zm1Tdic6nLkdMWQ7cnI6PKwqIPRnXUFEA+ne4rjaT+AFf/LUgay8rdtpf
   ojIZ6W0M6f4KIBhDgz1IDOkiq8Wj6dgM+83CijwRL4IXmdP4cVktRbxBR
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214754768"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 06:55:03 +0800
IronPort-SDR: yZs2Y4kovGWxtoUd2t4o+Mbbqq6QZVOD9afHbtccaxdw0LcMdk6Yzmsn2quiETato+3yGUPBY7
 wbKVUe+1Xf20bCRxD+AKMlDoHO5GUQ7AUi8vHUr6Nxy0IROImCgU7Po51/KFpThG51SYSBP1P9
 DiqdNV29J95CrObI9EXM/Q7T44zdMwluHVgih0fff48eT3/zkb9h1D/e1BZ+1Az1+bfoEmoLxN
 uEigrPz+EAtxHcQG9ANt4HgYQDcLP9itpwbDMnkAhkAgmzUpU6ro9ZBKaKvSGRxYEzjRSqcZCa
 6WnrQg9PMhugcrEMeGwY4p4e
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 15:14:32 -0700
IronPort-SDR: YjUDXBhXqZXQthLvNUlV1RfyKWNo2emzlgbtBXi6L6Xg2CHxzONPXdfCLEorsWYG7r/dixvr33
 X26ZzWIE2VPagsiZOO4IUTYWs9vEhUgZc4pqHheG2N3vnM6xMRhcfMpbYMgviQveLTZ1KZkrU3
 xJ8DPXgN8ssfs+V21VgbzTEN8EhlbWYE4Az2fgy5amX3glsYO4VHpBT/9OnM4X8PNr6KLKuduA
 Qqtpzuk3ypWXjZhXhhgW3xEgb8cfxCmQavNJ2xy3gIblz5EO24sYg7hjMnjOqwKqzJn6lYOCLI
 iLg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 15:55:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtjbp4kxyz1Rwtl
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:55:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666306500; x=1668898501; bh=HaEK5LbY6MR/lwCX4fGSHt+gO7IvozjsluA
        n35ZYRb8=; b=duoJP1E7pusyvt88KdU05X0F6uQX4hQnxeQBedTFQiz4TUiyWzx
        101jSZO56W1/aHVNoQcNArAHmsYVKaLFclLF5YCTrb4xQ4V3EvpXWvLaaI4wF5YH
        XVIHkfV5w8JQf+RLmOgUUCso+WMf9MXkkXc68u/a5+rRjKqv7Poa8yBYZ3df5zTR
        DWwSe0OSZgNPyJb5bWpY6ekeNb3Ys6HLXAoz/fTWB8JaNeA+eqIYg1hTvcOP9e01
        VuWPjp16sD8P28tl4b4EgJHE+0JwHaCd0Cm36cubnpFH6vDrO7Jhx4WexONwseV0
        yQ03lm2Mfm31yqllpMe7DXebFgJ8sqp/DlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tdZrNH1B5AMu for <linux-kernel@vger.kernel.org>;
        Thu, 20 Oct 2022 15:55:00 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtjbk3dM5z1RvLy;
        Thu, 20 Oct 2022 15:54:58 -0700 (PDT)
Message-ID: <a0e17831-7b11-6982-1d5c-d384211a0479@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 07:54:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V4 3/8] block, bfq: move io_cq-persistent bfqq data into a
 dedicated struct
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        glen.valante@linaro.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221020152643.21199-1-paolo.valente@linaro.org>
 <20221020152643.21199-4-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221020152643.21199-4-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 00:26, Paolo Valente wrote:
> With a multi-actuator drive, a process may get associated with multiple
> bfq_queues: one queue for each of the N actuators. So, the bfq_io_cq
> data structure must be able to accommodate its per-queue persistent
> information for N queues. Currently it stores this information for
> just one queue, in several scalar fields.
> 
> This is a preparatory commit for moving to accommodating persistent
> information for N queues. In particular, this commit packs all the
> above scalar fields into a single data structure. Then there is now
> only one fieldi, in bfq_io_cq, that stores all the above information. This
> scalar field will then be turned into an array by a following commit.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
> Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 118 +++++++++++++++++++++++---------------------
>  block/bfq-iosched.h |  52 +++++++++++--------
>  2 files changed, 94 insertions(+), 76 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 57de6a6a7f06..d2bd94ea2e95 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -406,7 +406,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  	 */
>  	bic->bfqq[is_sync][actuator_idx] = bfqq;
>  
> -	if (bfqq && bic->stable_merge_bfqq == bfqq) {
> +	if (bfqq && bic->bfqq_data->stable_merge_bfqq == bfqq) {

Nit: instead of dereferencing bic->bfqq_data 3 times in this function,
what about adding a "bfqq_data = bic->bfqq_data" local variable ? That
would make the code more readable.

>  		/*
>  		 * Actually, these same instructions are executed also
>  		 * in bfq_setup_cooperator, in case of abort or actual
> @@ -415,9 +415,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  		 * did so, we would nest even more complexity in this
>  		 * function.
>  		 */
> -		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		bfq_put_stable_ref(bic->bfqq_data->stable_merge_bfqq);
>  
> -		bic->stable_merge_bfqq = NULL;
> +		bic->bfqq_data->stable_merge_bfqq = NULL;
>  	}
>  }
>  
> @@ -1177,35 +1177,36 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>  	unsigned int old_wr_coeff = 1;
>  	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
>  
> -	if (bic->saved_has_short_ttime)
> +	if (bic->bfqq_data->saved_has_short_ttime)

Same comment here, but given the number of times you dereference that
pointer in this function, I would consider that comment more than a nit here.

The same comment applies to many of the functions you modify after this hunk.

>  		bfq_mark_bfqq_has_short_ttime(bfqq);
>  	else
>  		bfq_clear_bfqq_has_short_ttime(bfqq);
>  
> -	if (bic->saved_IO_bound)
> +	if (bic->bfqq_data->saved_IO_bound)
>  		bfq_mark_bfqq_IO_bound(bfqq);
>  	else
>  		bfq_clear_bfqq_IO_bound(bfqq);
>  
> -	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
> -	bfqq->inject_limit = bic->saved_inject_limit;
> -	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
> +	bfqq->last_serv_time_ns = bic->bfqq_data->saved_last_serv_time_ns;
> +	bfqq->inject_limit = bic->bfqq_data->saved_inject_limit;
> +	bfqq->decrease_time_jif = bic->bfqq_data->saved_decrease_time_jif;
>  
> -	bfqq->entity.new_weight = bic->saved_weight;
> -	bfqq->ttime = bic->saved_ttime;
> -	bfqq->io_start_time = bic->saved_io_start_time;
> -	bfqq->tot_idle_time = bic->saved_tot_idle_time;
> +	bfqq->entity.new_weight = bic->bfqq_data->saved_weight;
> +	bfqq->ttime = bic->bfqq_data->saved_ttime;
> +	bfqq->io_start_time = bic->bfqq_data->saved_io_start_time;
> +	bfqq->tot_idle_time = bic->bfqq_data->saved_tot_idle_time;
>  	/*
>  	 * Restore weight coefficient only if low_latency is on
>  	 */
>  	if (bfqd->low_latency) {
>  		old_wr_coeff = bfqq->wr_coeff;
> -		bfqq->wr_coeff = bic->saved_wr_coeff;
> +		bfqq->wr_coeff = bic->bfqq_data->saved_wr_coeff;
>  	}
> -	bfqq->service_from_wr = bic->saved_service_from_wr;
> -	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
> -	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
> -	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
> +	bfqq->service_from_wr = bic->bfqq_data->saved_service_from_wr;
> +	bfqq->wr_start_at_switch_to_srt =
> +		bic->bfqq_data->saved_wr_start_at_switch_to_srt;
> +	bfqq->last_wr_start_finish = bic->bfqq_data->saved_last_wr_start_finish;
> +	bfqq->wr_cur_max_time = bic->bfqq_data->saved_wr_cur_max_time;
>  
>  	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
>  	    time_is_before_jiffies(bfqq->last_wr_start_finish +
> @@ -1878,7 +1879,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	wr_or_deserves_wr = bfqd->low_latency &&
>  		(bfqq->wr_coeff > 1 ||
>  		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
> +		  (bfqq->bic || RQ_BIC(rq)->bfqq_data->stably_merged) &&
>  		   (*interactive || soft_rt)));
>  
>  	/*
> @@ -2923,21 +2924,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		 * stable merging) also if bic is associated with a
>  		 * sync queue, but this bfqq is async
>  		 */
> -		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
> +		if (bfq_bfqq_sync(bfqq) && bic->bfqq_data->stable_merge_bfqq &&
>  		    !bfq_bfqq_just_created(bfqq) &&
>  		    time_is_before_jiffies(bfqq->split_time +
>  					  msecs_to_jiffies(bfq_late_stable_merging)) &&
>  		    time_is_before_jiffies(bfqq->creation_time +
>  					   msecs_to_jiffies(bfq_late_stable_merging))) {
>  			struct bfq_queue *stable_merge_bfqq =
> -				bic->stable_merge_bfqq;
> +				bic->bfqq_data->stable_merge_bfqq;
>  			int proc_ref = min(bfqq_process_refs(bfqq),
>  					   bfqq_process_refs(stable_merge_bfqq));
>  
>  			/* deschedule stable merge, because done or aborted here */
>  			bfq_put_stable_ref(stable_merge_bfqq);
>  
> -			bic->stable_merge_bfqq = NULL;
> +			bic->bfqq_data->stable_merge_bfqq = NULL;
>  
>  			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
>  			    proc_ref > 0) {
> @@ -2946,10 +2947,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  					bfq_setup_merge(bfqq, stable_merge_bfqq);
>  
>  				if (new_bfqq) {
> -					bic->stably_merged = true;
> +					bic->bfqq_data->stably_merged = true;
>  					if (new_bfqq->bic)
> -						new_bfqq->bic->stably_merged =
> -									true;
> +						new_bfqq->bic->bfqq_data->stably_merged =
> +							true;
>  				}
>  				return new_bfqq;
>  			} else
> @@ -3057,18 +3058,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  	if (!bic)
>  		return;
>  
> -	bic->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> -	bic->saved_inject_limit = bfqq->inject_limit;
> -	bic->saved_decrease_time_jif = bfqq->decrease_time_jif;
> -
> -	bic->saved_weight = bfqq->entity.orig_weight;
> -	bic->saved_ttime = bfqq->ttime;
> -	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
> -	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
> -	bic->saved_io_start_time = bfqq->io_start_time;
> -	bic->saved_tot_idle_time = bfqq->tot_idle_time;
> -	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
> -	bic->was_in_burst_list = !hlist_unhashed(&bfqq->burst_list_node);
> +	bic->bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> +	bic->bfqq_data->saved_inject_limit = bfqq->inject_limit;
> +	bic->bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
> +
> +	bic->bfqq_data->saved_weight = bfqq->entity.orig_weight;
> +	bic->bfqq_data->saved_ttime = bfqq->ttime;
> +	bic->bfqq_data->saved_has_short_ttime =
> +		bfq_bfqq_has_short_ttime(bfqq);
> +	bic->bfqq_data->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
> +	bic->bfqq_data->saved_io_start_time = bfqq->io_start_time;
> +	bic->bfqq_data->saved_tot_idle_time = bfqq->tot_idle_time;
> +	bic->bfqq_data->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
> +	bic->bfqq_data->was_in_burst_list =
> +		!hlist_unhashed(&bfqq->burst_list_node);
> +
>  	if (unlikely(bfq_bfqq_just_created(bfqq) &&
>  		     !bfq_bfqq_in_large_burst(bfqq) &&
>  		     bfqq->bfqd->low_latency)) {
> @@ -3081,17 +3085,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  		 * to bfqq, so that to avoid that bfqq unjustly fails
>  		 * to enjoy weight raising if split soon.
>  		 */
> -		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
> -		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
> -		bic->saved_last_wr_start_finish = jiffies;
> +		bic->bfqq_data->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> +		bic->bfqq_data->saved_wr_start_at_switch_to_srt =
> +			bfq_smallest_from_now();
> +		bic->bfqq_data->saved_wr_cur_max_time =
> +			bfq_wr_duration(bfqq->bfqd);
> +		bic->bfqq_data->saved_last_wr_start_finish = jiffies;
>  	} else {
> -		bic->saved_wr_coeff = bfqq->wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt =
> +		bic->bfqq_data->saved_wr_coeff = bfqq->wr_coeff;
> +		bic->bfqq_data->saved_wr_start_at_switch_to_srt =
>  			bfqq->wr_start_at_switch_to_srt;
> -		bic->saved_service_from_wr = bfqq->service_from_wr;
> -		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
> -		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
> +		bic->bfqq_data->saved_service_from_wr =
> +			bfqq->service_from_wr;
> +		bic->bfqq_data->saved_last_wr_start_finish =
> +			bfqq->last_wr_start_finish;
> +		bic->bfqq_data->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
>  	}
>  }
>  
> @@ -5421,8 +5429,8 @@ static void bfq_exit_icq(struct io_cq *icq)
>  		spin_lock_irqsave(&bfqd->lock, flags);
>  
>  	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
> -		if (bic->stable_merge_bfqq)
> -			bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		if (bic->bfqq_data->stable_merge_bfqq)
> +			bfq_put_stable_ref(bic->bfqq_data->stable_merge_bfqq);
>  
>  		bfq_exit_icq_bfqq(bic, true, act_idx);
>  		bfq_exit_icq_bfqq(bic, false, act_idx);
> @@ -5617,8 +5625,8 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		return bfqq;
>  
>  	if (new_bfqq->bic)
> -		new_bfqq->bic->stably_merged = true;
> -	bic->stably_merged = true;
> +		new_bfqq->bic->bfqq_data->stably_merged = true;
> +	bic->bfqq_data->stably_merged = true;
>  
>  	/*
>  	 * Reusing merge functions. This implies that
> @@ -5748,7 +5756,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  			/*
>  			 * Record the bfqq to merge to.
>  			 */
> -			bic->stable_merge_bfqq = last_bfqq_created;
> +			bic->bfqq_data->stable_merge_bfqq = last_bfqq_created;
>  		}
>  	}
>  
> @@ -6682,12 +6690,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  
>  	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>  	if (split && is_sync) {
> -		if ((bic->was_in_burst_list && bfqd->large_burst) ||
> -		    bic->saved_in_large_burst)
> +		if ((bic->bfqq_data->was_in_burst_list && bfqd->large_burst) ||
> +		    bic->bfqq_data->saved_in_large_burst)
>  			bfq_mark_bfqq_in_large_burst(bfqq);
>  		else {
>  			bfq_clear_bfqq_in_large_burst(bfqq);
> -			if (bic->was_in_burst_list)
> +			if (bic->bfqq_data->was_in_burst_list)
>  				/*
>  				 * If bfqq was in the current
>  				 * burst list before being
> @@ -6802,12 +6810,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	if (likely(!new_queue)) {
>  		/* If the queue was seeky for too long, break it apart. */
>  		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
> -			!bic->stably_merged) {
> +			!bic->bfqq_data->stably_merged) {
>  			struct bfq_queue *old_bfqq = bfqq;
>  
>  			/* Update bic before losing reference to bfqq */
>  			if (bfq_bfqq_in_large_burst(bfqq))
> -				bic->saved_in_large_burst = true;
> +				bic->bfqq_data->saved_in_large_burst = true;
>  
>  			bfqq = bfq_split_bfqq(bic, bfqq);
>  			split = true;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index d98e31be447f..6bc7bed97956 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -415,27 +415,9 @@ struct bfq_queue {
>  };
>  
>  /**
> - * struct bfq_io_cq - per (request_queue, io_context) structure.
> - */
> -struct bfq_io_cq {
> -	/* associated io_cq structure */
> -	struct io_cq icq; /* must be the first member */
> -	/*
> -	 * Matrix of associated process queues: first row for async
> -	 * queues, second row sync queues. Each row contains one
> -	 * column for each actuator. An I/O request generated by the
> -	 * process is inserted into the queue pointed by bfqq[i][j] if
> -	 * the request is to be served by the j-th actuator of the
> -	 * drive, where i==0 or i==1, depending on whether the request
> -	 * is async or sync. So there is a distinct queue for each
> -	 * actuator.
> -	 */
> -	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
> -	/* per (request_queue, blkcg) ioprio */
> -	int ioprio;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	uint64_t blkcg_serial_nr; /* the current blkcg serial */
> -#endif
> +* struct bfq_data - bfqq data unique and persistent for associated bfq_io_cq
> +*/
> +struct bfq_iocq_bfqq_data {
>  	/*
>  	 * Snapshot of the has_short_time flag before merging; taken
>  	 * to remember its value while the queue is merged, so as to
> @@ -490,6 +472,34 @@ struct bfq_io_cq {
>  	struct bfq_queue *stable_merge_bfqq;
>  
>  	bool stably_merged;	/* non splittable if true */
> +};
> +
> +/**
> + * struct bfq_io_cq - per (request_queue, io_context) structure.
> + */
> +struct bfq_io_cq {
> +	/* associated io_cq structure */
> +	struct io_cq icq; /* must be the first member */
> +	/*
> +	 * Matrix of associated process queues: first row for async
> +	 * queues, second row sync queues. Each row contains one
> +	 * column for each actuator. An I/O request generated by the
> +	 * process is inserted into the queue pointed by bfqq[i][j] if
> +	 * the request is to be served by the j-th actuator of the
> +	 * drive, where i==0 or i==1, depending on whether the request
> +	 * is async or sync. So there is a distinct queue for each
> +	 * actuator.
> +	 */
> +	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
> +	/* per (request_queue, blkcg) ioprio */
> +	int ioprio;
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	uint64_t blkcg_serial_nr; /* the current blkcg serial */
> +#endif
> +
> +	/* persistent data for associated synchronous process queue */
> +	struct bfq_iocq_bfqq_data *bfqq_data;
> +
>  	unsigned int requests;	/* Number of requests this process has in flight */
>  };
>  

-- 
Damien Le Moal
Western Digital Research

