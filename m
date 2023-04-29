Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF06F2235
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbjD2B6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbjD2B56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BE430D2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B5B615E0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 01:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B93CC433D2;
        Sat, 29 Apr 2023 01:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733473;
        bh=NAp4+2v3eip+oibXwCdkhIwyzFLv+Dzh8609RU3cAMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lH1LV7hOINe+s4Nc6Vh7izu/VeGciWZ6/+7yFxrQ61VvXmkd1YnQ2BJbWJ4Rhf1uR
         pF+lEHLru31piB42pnenrgh/TyNjlUA8WWfzbOrja39p0adzvqLD5K0lgvcsSBBohA
         /G2Kt9fT9YqHMM1D08U+plAlvJLGhwiXej4k5fJwBPsJVwWam0BB5oF+aFAGn9bMRs
         kbkTUBswaH1KPUASvliMQ79PNwQL5lmEUPSuWolarMHu480kzCSPu5cqb/Vx/TYRko
         x6mvOFx/I/9JqFiaVpxxX26HY/L6YFQvyVsvsIKHVwpKRmiB7KPSvZozRFjwoYay/j
         ZL3BM6WJ9v50Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2BB89403B5; Fri, 28 Apr 2023 22:57:51 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:57:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V2] perf cs-etm: Add fix for coresight trace for any
 range of CPUs
Message-ID: <ZEx5n8MdwuV5JE2r@kernel.org>
References: <20230421055253.83912-1-gankulkarni@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421055253.83912-1-gankulkarni@os.amperecomputing.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 20, 2023 at 10:52:53PM -0700, Ganapatrao Kulkarni escreveu:
> The current implementation supports coresight trace decode for a range
> of CPUs, if the first CPU is CPU0.
> 
> Perf report segfaults, if tried for sparse CPUs list and also for
> any range of CPUs(non zero first CPU).
> 
> Adding a fix to perf report for any range of CPUs and for sparse list.

Can some ARM people please review this?

- Arnaldo
 
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
> 
> V2:
> 	Updated with review comments.
> 	Fixed for sparse list of CPUs also.
> 
> V1:
> 	[1] https://lore.kernel.org/lkml/20230419172101.78638-1-gankulkarni@os.amperecomputing.com/
> 
>  tools/perf/util/cs-etm.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8dd81ddd9e4e..2003717f5779 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -275,6 +275,25 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
>  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
>  	})
>  
> +/*
> + * Get a metadata for a specific cpu from an array.
> + *
> + */
> +static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
> +{
> +	int i;
> +	u64 *metadata = NULL;
> +
> +	for (i = 0; i < etm->num_cpu; i++) {
> +		if (etm->metadata[i][CS_ETM_CPU] == (u64)cpu) {
> +			metadata = etm->metadata[i];
> +			break;
> +		}
> +	}
> +
> +	return metadata;
> +}
> +
>  /*
>   * Handle the PERF_RECORD_AUX_OUTPUT_HW_ID event.
>   *
> @@ -344,8 +363,11 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
>  		return 0;
>  	}
>  
> +	cpu_data = get_cpu_data(etm, cpu);
> +	if (cpu_data == NULL)
> +		return err;
> +
>  	/* not one we've seen before - lets map it */
> -	cpu_data = etm->metadata[cpu];
>  	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
>  	if (err)
>  		return err;
> -- 
> 2.39.2
> 

-- 

- Arnaldo
