Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541175EB189
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIZTsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiIZTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B14E87E;
        Mon, 26 Sep 2022 12:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE180B80DFA;
        Mon, 26 Sep 2022 19:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D88C433C1;
        Mon, 26 Sep 2022 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664221708;
        bh=KRTWSA1UWMYqxBNTs8xjpbKoUmsbN2ml/Ow3bxjo5A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2kzlGtl8PozkWQbpuNdbMhOUoXMQXtCj0KBXS/LVcnoWrgZaHmYYVURruv55myiO
         tks2ehVyLQyWQQ+MHhRCaF2lIC1FhsT5zWcZlU3ZxALvU7OrViiwV/3RVpFWPQJ35T
         lIoYjGX8bUk+6I+miHY/6Bh/yjVsj5zFheNCKx/VNcayfF1H45/WrV90TjgnLVjqH4
         eAthutHzHQHiB/CQyxmnWSS45mWTXlQlf7i+f8pvpIhNM89dEjWvdXGLVdHl9egX2u
         9d1RN15MVM7JanDN/NrR8OK4UnlPDod67bujcaKKh5M7iST2kxPJ5zzRj4xvMdhbMT
         tqigCqo0f1i7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36239403B0; Mon, 26 Sep 2022 20:48:26 +0100 (IST)
Date:   Mon, 26 Sep 2022 20:48:26 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, john.garry@huawei.com,
        adrian.hunter@intel.com, ak@linux.intel.com,
        florian.fischer@muhq.space
Subject: Re: [PATCH -next 4/5] perf: Remove unused macros __PERF_EVENT_FIELD
Message-ID: <YzICCqPw4lDY+oZi@kernel.org>
References: <20220926031440.28275-1-chenzhongjin@huawei.com>
 <20220926031440.28275-5-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926031440.28275-5-chenzhongjin@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 11:14:39AM +0800, Chen Zhongjin escreveu:
> Unused macros reported by [-Wunused-macros].
> 
> This macros were introduced as __PERF_COUNTER_FIELD and used for
> reading the bit in config.
> 
> 'cdd6c482c9ff ("perf: Do the big rename: Performance Counters -> Performance Events")'
> Changes it to __PERF_EVENT_FIELD but at this commit there is already
> nowhere else using these macros, also no macros called
> PERF_EVENT_##name##_MASK/SHIFT.
> 
> Now we are not reading type or id from config. These macros are
> useless and incomplete.
> 
> So removing them for code cleaning.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  tools/perf/util/parse-events.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index f05e15acd33f..3ed914882b96 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -149,14 +149,6 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
>  	},
>  };
>  
> -#define __PERF_EVENT_FIELD(config, name) \
> -	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
> -
> -#define PERF_EVENT_RAW(config)		__PERF_EVENT_FIELD(config, RAW)
> -#define PERF_EVENT_CONFIG(config)	__PERF_EVENT_FIELD(config, CONFIG)
> -#define PERF_EVENT_TYPE(config)		__PERF_EVENT_FIELD(config, TYPE)
> -#define PERF_EVENT_ID(config)		__PERF_EVENT_FIELD(config, EVENT)
> -
>  const char *event_type(int type)
>  {
>  	switch (type) {
> -- 
> 2.17.1

-- 

- Arnaldo
