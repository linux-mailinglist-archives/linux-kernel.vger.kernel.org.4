Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC489612E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 00:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ3Xn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 19:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJ3Xny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 19:43:54 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242409FFD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667173433; x=1698709433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JMIB5HGaCJofGKYSMaAvPCg9NZU8aBHVTetJi+l9UNk=;
  b=R8ybtqQZsdsKImZ6VOQeiEukwKX6liMDYvvVzK3GaMieT1ChWH6q/aT6
   wCp6Qo16Oz0/pWDt82e8SRbXWyI3ikb3quopdwPp+WIHcvOZq7NuiUgj3
   78dGnSXgw8h9ApYs0CdRSLQqta99FwLqqBrehncNjeWH78da/xgXTeHsO
   VlHCWj8rULau/uX5qsnjXJ9RzeLtWWLCATM49b8H5q2jn8U+2RP60ri7M
   N+ykIXxsw8nIqDOC6tnRz7dvC+5pYXqts5+22hOwy2gf1dVc6Fc0zfF4x
   AStcwsNjdDe6HMTj28TT9ggINfj3KsCD+WKKSwOV9LSUya+j9vq8jSVHh
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,226,1661788800"; 
   d="scan'208";a="213380027"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 07:43:48 +0800
IronPort-SDR: ung5BTOzXyXK1Ka5UM4BfEkD6TTY7PsLruaz+GsGPHgLner6PCJqdQRQIy+cz+2f2bToczhy16
 s33h8IZJ0j2Fa6JO+0X1c2f73E02pD4eLASzOorEz2/zlR+PkBlUhPRQoXCzGDnfsdH9Et+O9w
 YOD3qQyIe8nXi0zXqKSlFAvFy2dG/Fp0A9OFrjK4we/KE7555XsLy6ONikOiIjYW8ghWBXz8pW
 YNQnWZJ4Oc6YnjCPOhlX1cJtL9kxDWxgRygnF+OsKGA1ni5mU1eI7FrYiSrwH7Ty6qHB2iTS6f
 GY4yPNSeqzWO0DfoDGO2XG0H
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 16:03:03 -0700
IronPort-SDR: xkHMLCQt+l8bbcBUaegVSUmUCrDbIsfUFdWNMHKEbi4FtFfYjYfdy1o2oieUVY1ovy95Se6LHp
 amfoYVyrd21gik9GU0YZCs9SsBYqVtKXqSVX73+G9fvGOZhiH9PiIvatKiIeU4bR3pTQOxjE+i
 9yq8lw6DUqLYcWjyCdBvXSPFEI6y792kTh8RSfehwaNRZ3oa4Mb48mcARlgy9YlANuHj+n0AlM
 jLIFWel09hDBI4NTqbmpxQhUebtmTk+6ZA9pmCLW9mpBKV+OGCdeyP8cs0jhrpHTGnjYvOUH6b
 jcU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 16:43:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0tCQ4S3pz1Rwtl
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 16:43:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667173424; x=1669765425; bh=JMIB5HGaCJofGKYSMaAvPCg9NZU8aBHVTet
        Ji+l9UNk=; b=Tdy594JZzx6I5BJIXwz2cBeLyfe4ZVn2+2PoDr7VrS75pw8QiRp
        6Ln9Q0jVzPLN1+7oX2bu7FcoMaBnHgzRVDbH+jknjzHY5WdTaUxcsme3kfuzQWZg
        dWXw6cjeXMI58siQ/VAaeGmKtU44BXEN3r3SzKxVUIg4xObv0XD0ZiYCAsOxEqE/
        xhbuy9uxMk0zWsqpAkfA0OFnWhdBlcZhqcOXjIZqhGBmgLzK9vJmIo/Itu3F/myq
        IlpPWO08rRgSF3hzNrrHun2Tv/srIcUQ0osnL/m9HLdbDPy9/fFRyvfou62jEB7T
        wTRdVOv7WBTIG53E8MmLAGbei5Ekx1sLEgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7NA8Xe3egcq6 for <linux-kernel@vger.kernel.org>;
        Sun, 30 Oct 2022 16:43:44 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0tCM2gmBz1RvLy;
        Sun, 30 Oct 2022 16:43:43 -0700 (PDT)
Message-ID: <102b5b70-5c4f-21d8-ba87-48276b2785b8@opensource.wdc.com>
Date:   Mon, 31 Oct 2022 08:43:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V5 3/8] block, bfq: move io_cq-persistent bfqq data into a
 dedicated struct
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221030100300.3085-1-paolo.valente@linaro.org>
 <20221030100300.3085-4-paolo.valente@linaro.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221030100300.3085-4-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 19:02, Paolo Valente wrote:
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
>  block/bfq-iosched.c | 129 +++++++++++++++++++++++++-------------------
>  block/bfq-iosched.h |  52 ++++++++++--------
>  2 files changed, 105 insertions(+), 76 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ec4b0e70265f..139b8f1ba439 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -404,9 +404,10 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  	 * we cancel the stable merge if
>  	 * bic->stable_merge_bfqq == bfqq.
>  	 */
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;

I was going to comment that "Why is this not a pointer ?" but the build
bot bit me to it :)

>  	bic->bfqq[is_sync][actuator_idx] = bfqq;
>  
> -	if (bfqq && bic->stable_merge_bfqq == bfqq) {
> +	if (bfqq && bfqq_data.stable_merge_bfqq == bfqq) {
>  		/*
>  		 * Actually, these same instructions are executed also
>  		 * in bfq_setup_cooperator, in case of abort or actual
> @@ -415,9 +416,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  		 * did so, we would nest even more complexity in this
>  		 * function.
>  		 */
> -		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		bfq_put_stable_ref(bfqq_data.stable_merge_bfqq);
>  
> -		bic->stable_merge_bfqq = NULL;
> +		bfqq_data.stable_merge_bfqq = NULL;
>  	}
>  }
>  
> @@ -1174,38 +1175,40 @@ static void
>  bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>  		      struct bfq_io_cq *bic, bool bfq_already_existing)
>  {
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  	unsigned int old_wr_coeff = 1;
>  	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
>  
> -	if (bic->saved_has_short_ttime)
> +	if (bfqq_data.saved_has_short_ttime)
>  		bfq_mark_bfqq_has_short_ttime(bfqq);
>  	else
>  		bfq_clear_bfqq_has_short_ttime(bfqq);
>  
> -	if (bic->saved_IO_bound)
> +	if (bfqq_data.saved_IO_bound)
>  		bfq_mark_bfqq_IO_bound(bfqq);
>  	else
>  		bfq_clear_bfqq_IO_bound(bfqq);
>  
> -	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
> -	bfqq->inject_limit = bic->saved_inject_limit;
> -	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
> +	bfqq->last_serv_time_ns = bfqq_data.saved_last_serv_time_ns;
> +	bfqq->inject_limit = bfqq_data.saved_inject_limit;
> +	bfqq->decrease_time_jif = bfqq_data.saved_decrease_time_jif;
>  
> -	bfqq->entity.new_weight = bic->saved_weight;
> -	bfqq->ttime = bic->saved_ttime;
> -	bfqq->io_start_time = bic->saved_io_start_time;
> -	bfqq->tot_idle_time = bic->saved_tot_idle_time;
> +	bfqq->entity.new_weight = bfqq_data.saved_weight;
> +	bfqq->ttime = bfqq_data.saved_ttime;
> +	bfqq->io_start_time = bfqq_data.saved_io_start_time;
> +	bfqq->tot_idle_time = bfqq_data.saved_tot_idle_time;
>  	/*
>  	 * Restore weight coefficient only if low_latency is on
>  	 */
>  	if (bfqd->low_latency) {
>  		old_wr_coeff = bfqq->wr_coeff;
> -		bfqq->wr_coeff = bic->saved_wr_coeff;
> +		bfqq->wr_coeff = bfqq_data.saved_wr_coeff;
>  	}
> -	bfqq->service_from_wr = bic->saved_service_from_wr;
> -	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
> -	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
> -	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
> +	bfqq->service_from_wr = bfqq_data.saved_service_from_wr;
> +	bfqq->wr_start_at_switch_to_srt =
> +		bfqq_data.saved_wr_start_at_switch_to_srt;
> +	bfqq->last_wr_start_finish = bfqq_data.saved_last_wr_start_finish;
> +	bfqq->wr_cur_max_time = bfqq_data.saved_wr_cur_max_time;
>  
>  	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
>  	    time_is_before_jiffies(bfqq->last_wr_start_finish +
> @@ -1878,7 +1881,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	wr_or_deserves_wr = bfqd->low_latency &&
>  		(bfqq->wr_coeff > 1 ||
>  		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
> +		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
>  		   (*interactive || soft_rt)));
>  
>  	/*
> @@ -2902,6 +2905,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		     void *io_struct, bool request, struct bfq_io_cq *bic)
>  {
>  	struct bfq_queue *in_service_bfqq, *new_bfqq;
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  
>  	/* if a merge has already been setup, then proceed with that first */
>  	if (bfqq->new_bfqq)
> @@ -2923,21 +2927,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		 * stable merging) also if bic is associated with a
>  		 * sync queue, but this bfqq is async
>  		 */
> -		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
> +		if (bfq_bfqq_sync(bfqq) && bfqq_data.stable_merge_bfqq &&
>  		    !bfq_bfqq_just_created(bfqq) &&
>  		    time_is_before_jiffies(bfqq->split_time +
>  					  msecs_to_jiffies(bfq_late_stable_merging)) &&
>  		    time_is_before_jiffies(bfqq->creation_time +
>  					   msecs_to_jiffies(bfq_late_stable_merging))) {
>  			struct bfq_queue *stable_merge_bfqq =
> -				bic->stable_merge_bfqq;
> +				bfqq_data.stable_merge_bfqq;
>  			int proc_ref = min(bfqq_process_refs(bfqq),
>  					   bfqq_process_refs(stable_merge_bfqq));
>  
>  			/* deschedule stable merge, because done or aborted here */
>  			bfq_put_stable_ref(stable_merge_bfqq);
>  
> -			bic->stable_merge_bfqq = NULL;
> +			bfqq_data.stable_merge_bfqq = NULL;
>  
>  			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
>  			    proc_ref > 0) {
> @@ -2946,10 +2950,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  					bfq_setup_merge(bfqq, stable_merge_bfqq);
>  
>  				if (new_bfqq) {
> -					bic->stably_merged = true;
> +					bfqq_data.stably_merged = true;
>  					if (new_bfqq->bic)
> -						new_bfqq->bic->stably_merged =
> -									true;
> +						new_bfqq->bic->bfqq_data.stably_merged =
> +							true;
>  				}
>  				return new_bfqq;
>  			} else
> @@ -3048,6 +3052,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  
>  	/*
>  	 * If !bfqq->bic, the queue is already shared or its requests
> @@ -3057,18 +3062,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
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
> +	bfqq_data.saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> +	bfqq_data.saved_inject_limit = bfqq->inject_limit;
> +	bfqq_data.saved_decrease_time_jif = bfqq->decrease_time_jif;
> +
> +	bfqq_data.saved_weight = bfqq->entity.orig_weight;
> +	bfqq_data.saved_ttime = bfqq->ttime;
> +	bfqq_data.saved_has_short_ttime =
> +		bfq_bfqq_has_short_ttime(bfqq);
> +	bfqq_data.saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
> +	bfqq_data.saved_io_start_time = bfqq->io_start_time;
> +	bfqq_data.saved_tot_idle_time = bfqq->tot_idle_time;
> +	bfqq_data.saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
> +	bfqq_data.was_in_burst_list =
> +		!hlist_unhashed(&bfqq->burst_list_node);
> +
>  	if (unlikely(bfq_bfqq_just_created(bfqq) &&
>  		     !bfq_bfqq_in_large_burst(bfqq) &&
>  		     bfqq->bfqd->low_latency)) {
> @@ -3081,17 +3089,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  		 * to bfqq, so that to avoid that bfqq unjustly fails
>  		 * to enjoy weight raising if split soon.
>  		 */
> -		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
> -		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
> -		bic->saved_last_wr_start_finish = jiffies;
> +		bfqq_data.saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> +		bfqq_data.saved_wr_start_at_switch_to_srt =
> +			bfq_smallest_from_now();
> +		bfqq_data.saved_wr_cur_max_time =
> +			bfq_wr_duration(bfqq->bfqd);
> +		bfqq_data.saved_last_wr_start_finish = jiffies;
>  	} else {
> -		bic->saved_wr_coeff = bfqq->wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt =
> +		bfqq_data.saved_wr_coeff = bfqq->wr_coeff;
> +		bfqq_data.saved_wr_start_at_switch_to_srt =
>  			bfqq->wr_start_at_switch_to_srt;
> -		bic->saved_service_from_wr = bfqq->service_from_wr;
> -		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
> -		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
> +		bfqq_data.saved_service_from_wr =
> +			bfqq->service_from_wr;
> +		bfqq_data.saved_last_wr_start_finish =
> +			bfqq->last_wr_start_finish;
> +		bfqq_data.saved_wr_cur_max_time = bfqq->wr_cur_max_time;
>  	}
>  }
>  
> @@ -5413,6 +5425,7 @@ static void bfq_exit_icq(struct io_cq *icq)
>  	unsigned long flags;
>  	unsigned int act_idx;
>  	unsigned int num_actuators;
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  
>  	/*
>  	 * bfqd is NULL if scheduler already exited, and in that case
> @@ -5432,8 +5445,8 @@ static void bfq_exit_icq(struct io_cq *icq)
>  		num_actuators = BFQ_MAX_ACTUATORS;
>  	}
>  
> -	if (bic->stable_merge_bfqq)
> -		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +	if (bfqq_data.stable_merge_bfqq)
> +		bfq_put_stable_ref(bfqq_data.stable_merge_bfqq);
>  
>  	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
>  		bfq_exit_icq_bfqq(bic, true, act_idx);
> @@ -5624,13 +5637,14 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  {
>  	struct bfq_queue *new_bfqq =
>  		bfq_setup_merge(bfqq, last_bfqq_created);
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  
>  	if (!new_bfqq)
>  		return bfqq;
>  
>  	if (new_bfqq->bic)
> -		new_bfqq->bic->stably_merged = true;
> -	bic->stably_merged = true;
> +		new_bfqq->bic->bfqq_data.stably_merged = true;
> +	bfqq_data.stably_merged = true;
>  
>  	/*
>  	 * Reusing merge functions. This implies that
> @@ -5699,6 +5713,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  		&bfqd->last_bfqq_created;
>  
>  	struct bfq_queue *last_bfqq_created = *source_bfqq;
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  
>  	/*
>  	 * If last_bfqq_created has not been set yet, then init it. If
> @@ -5760,7 +5775,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  			/*
>  			 * Record the bfqq to merge to.
>  			 */
> -			bic->stable_merge_bfqq = last_bfqq_created;
> +			bfqq_data.stable_merge_bfqq = last_bfqq_created;
>  		}
>  	}
>  
> @@ -6681,6 +6696,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  {
>  	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
>  	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
> +	struct bfq_iocq_bfqq_data bfqq_data = bic->bfqq_data;
>  
>  	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
>  		return bfqq;
> @@ -6694,12 +6710,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  
>  	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>  	if (split && is_sync) {
> -		if ((bic->was_in_burst_list && bfqd->large_burst) ||
> -		    bic->saved_in_large_burst)
> +		if ((bfqq_data.was_in_burst_list && bfqd->large_burst) ||
> +		    bfqq_data.saved_in_large_burst)
>  			bfq_mark_bfqq_in_large_burst(bfqq);
>  		else {
>  			bfq_clear_bfqq_in_large_burst(bfqq);
> -			if (bic->was_in_burst_list)
> +			if (bfqq_data.was_in_burst_list)
>  				/*
>  				 * If bfqq was in the current
>  				 * burst list before being
> @@ -6788,6 +6804,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	struct bfq_queue *bfqq;
>  	bool new_queue = false;
>  	bool bfqq_already_existing = false, split = false;
> +	struct bfq_iocq_bfqq_data bfqq_data;
>  
>  	if (unlikely(!rq->elv.icq))
>  		return NULL;
> @@ -6811,15 +6828,17 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
>  					 &new_queue);
>  
> +	bfqq_data = bic->bfqq_data;
> +
>  	if (likely(!new_queue)) {
>  		/* If the queue was seeky for too long, break it apart. */
>  		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
> -			!bic->stably_merged) {
> +			!bfqq_data.stably_merged) {
>  			struct bfq_queue *old_bfqq = bfqq;
>  
>  			/* Update bic before losing reference to bfqq */
>  			if (bfq_bfqq_in_large_burst(bfqq))
> -				bic->saved_in_large_burst = true;
> +				bfqq_data.saved_in_large_burst = true;
>  
>  			bfqq = bfq_split_bfqq(bic, bfqq);
>  			split = true;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index bfcbd8ea9000..f2e8ab91951c 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -411,27 +411,9 @@ struct bfq_queue {
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
> @@ -486,6 +468,34 @@ struct bfq_io_cq {
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
> +	struct bfq_iocq_bfqq_data bfqq_data;
> +
>  	unsigned int requests;	/* Number of requests this process has in flight */
>  };
>  

-- 
Damien Le Moal
Western Digital Research

