Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B625F106B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiI3RDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiI3RDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E051D8F0B;
        Fri, 30 Sep 2022 10:03:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h7so7738072wru.10;
        Fri, 30 Sep 2022 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=FGZtzTXHVj5GfR1XpxsY3MGOgIN3YvwraJoWKqDkN6w=;
        b=g52B5KzPHziA5nUM+tRfF0rytQKolgCNXltXE6EZH2WFqgy2RFwSgSHa9w0IxQAi/z
         fJBZ12LeRKaZOLff7o91S/e03rk6jP+8ERWUmOkUPltKaL3oQ5juwMxQpdVEnevImGwj
         gOgeJ67mYqEZplucxrpr1mJkGjZDE1bCM3nQoBl9kDa6f76Moeox/aAKVTa1SWrNCJM8
         udCytD3p3rS+Gm3hHw/6vJ7QBvphrp6oMdg869RZfq1RlupL1KCEMmMpZiVRk30f3GIP
         dku3Mjsdft0WjLEUmpszSv0DWhj+EJH8a+EMXXVrkHTpq28UqE+cLLBv8NuNgnXHOMwE
         pFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FGZtzTXHVj5GfR1XpxsY3MGOgIN3YvwraJoWKqDkN6w=;
        b=cji6bK2TThjKn4f82FyH+0YGTuqw9efRE3YgZcUlommoT1RT7srTxBY8BNvMNDvVnr
         DpmGRlhWMZx3k513ESW3VO3wmYUu92ONKbuPQwT7bv6IpkBIJTM5olWLCaHsEfE7Jdmr
         TzbN5zt4x8ycmxbIqfRO1YHzY59DJWBQgbUkIJ/TKWsELlvlzic9rSTeakKEabyaXy6M
         YP1j1Ew1shbHCSP6H/06FVtWGdmm8N75jK1Mzv/0SGEg9if2My2QLXY/kLUCy5SJVB55
         0SJYuZf+D2j4G61O+6YYtuMH8jlokX8zwXIYJwgCZ1QbgSpvjUs1nSz/Vj+MFuEqNyXE
         NCXw==
X-Gm-Message-State: ACrzQf2H/Lh6cHiVFJaY3I9KC1QNha51d1hztvZK67EdBY5MhXhNtk5y
        V2X44irnz+ao/l8YYGQjmu8=
X-Google-Smtp-Source: AMsMyM5ecdyZtxaTQSXWmyDTDjON7GR/VvSXWfXqmGb9YXGv1URUT8IB89myJCIX84YvCHwNV5ZFjg==
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id r2-20020a5d6c62000000b0022a2f59cb7dmr6460278wrz.405.1664557382237;
        Fri, 30 Sep 2022 10:03:02 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b003b31c560a0csm2777336wmb.12.2022.09.30.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:03:01 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 30 Sep 2022 19:02:58 +0200
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        eranian@google.com, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 06/15] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
Message-ID: <YzchQmEyzB+uQ7hu@krava>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-7-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928095805.596-7-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
there's typo in the subject 'PHYS' ;-)

jirka

On Wed, Sep 28, 2022 at 03:27:56PM +0530, Ravi Bangoria wrote:
> IBS_DC_PHYSADDR provides the physical data address for the tagged load/
> store operation. Populate perf sample physical address using it.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 8 +++++++-
>  kernel/events/core.c      | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 0ad49105c154..3271735f0070 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -989,6 +989,11 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
>  		data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
>  		data->sample_flags |= PERF_SAMPLE_ADDR;
>  	}
> +
> +	if (sample_type & PERF_SAMPLE_PHYS_ADDR && op_data3.dc_phy_addr_valid) {
> +		data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
> +		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
> +	}
>  }
>  
>  static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
> @@ -998,7 +1003,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
>  	    (perf_ibs == &perf_ibs_op &&
>  	     (sample_type & PERF_SAMPLE_DATA_SRC ||
>  	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
> -	      sample_type & PERF_SAMPLE_ADDR)))
> +	      sample_type & PERF_SAMPLE_ADDR ||
> +	      sample_type & PERF_SAMPLE_PHYS_ADDR)))
>  		return perf_ibs->offset_max;
>  	else if (check_rip)
>  		return 3;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e1ffdb861b53..49bc3b5e6c8a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7435,7 +7435,8 @@ void perf_prepare_sample(struct perf_event_header *header,
>  		header->size += size;
>  	}
>  
> -	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
> +	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
> +	    filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		data->phys_addr = perf_virt_to_phys(data->addr);
>  
>  #ifdef CONFIG_CGROUP_PERF
> -- 
> 2.31.1
> 
