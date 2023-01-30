Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E56803C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjA3COB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjA3COA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:14:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D44413D50
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:13:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v23so10160966plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd9O/tR7VekNHZVuIxvEglh3Auv4HgbQ30VX5q49uEs=;
        b=d/ceRODYDTq6388o2Sj48+kUXOFYULwGnarz33zqwylf/zJkz0Bge4T7BLscO506ai
         jLUbnxaUH71+oPw308UmtNlkQTqzaDudjlP58CDyjEmXnX/6oMQfZJu5nWFNbUuNJJu2
         Sqn9oSKGDSyKZ9lyLpy7yz4uf4tWJWdUufX2sch4xsDg9qLw1lA9Dpk1qkv3Ldfw1/qN
         bInHry90CD0sWv9xg4ELRBAA7ZKIlwKBc3d4OHNwsGBlpTmVE1yodXWEdYMqdh488xlL
         kkNcmywNOklRxzmIM6YFR7FrBXJBzi0dz48n5X9SxqfjASHvrGnClC0xt5Pm5oyHC060
         fHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd9O/tR7VekNHZVuIxvEglh3Auv4HgbQ30VX5q49uEs=;
        b=Xit+V2/dHXy51suJlsE+yiHp9YCSGBL+M3uxAEDI2a5STfAN0r3bEQw0UOcNUh3LI0
         FIOrkPE9PZoSWCHT1szThLoJkesepgjZ5fmO2D5n7jPWUjRvJVrq/T/paQFw4rrCuP+S
         ioLbg0Q6Wk56X91W1XuSXqg/kp+YcLd1OhtsPnN8s1LK8Id1thVWTtbXkY8Zv4nhowfE
         gjW11QCJEhQ/ced/BQWaZV9o6pZprgYqdw0N9XQbZH6kquhkaCN1TX6jmbpC8/lOohTT
         YORyKCQ6vZLnJRBWchCKR5YKm2r8Llr7MsgIvHOkuPjymUdCMNoa8J115XSF6PfFGyQP
         tVwg==
X-Gm-Message-State: AO0yUKXtV2oVv97QdaODWgmK4eSjjAZDfm68k4HzUuAM9tgrrzIjBxef
        2/+P+s8BQefpili3tC3QpL7RJw==
X-Google-Smtp-Source: AK7set+SgtT6XMWy7cDFb1dkQK0NVFq/QUJ9BPIeOHt8108rRMeCoMgAdS2eyaIWzDM5ZebZnePAlw==
X-Received: by 2002:a17:903:1c7:b0:196:682a:b3db with SMTP id e7-20020a17090301c700b00196682ab3dbmr8566682plh.38.1675044838787;
        Sun, 29 Jan 2023 18:13:58 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902b28b00b00177efb56475sm6513067plr.85.2023.01.29.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:13:58 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:13:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Only warn once for each unsupported
 address packet
Message-ID: <Y9cn4NYvI6+XW302@leoy-yangtze.lan>
References: <20230127205546.667740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127205546.667740-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:55:46PM -0600, Rob Herring wrote:
> Unknown address packet indexes are not an error as the Arm architecture
> can (and has with SPEv1.2) define new ones and implementation defined
> ones are also allowed. The error message for every occurrence of the
> packet is needlessly noisy as well. Change the message to print just
> once for each unknown index.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 091987dd3966..40dcedfd75cd 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -68,7 +68,11 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
>  		/* Clean highest byte */
>  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  	} else {
> -		pr_err("unsupported address packet index: 0x%x\n", index);
> +		static u32 seen_idx = 0;
> +		if (!(seen_idx & BIT(index))) {
> +			seen_idx |= BIT(index);
> +			pr_warning("ignoring unsupported address packet index: 0x%x\n", index);
> +		}
>  	}
>  
>  	return payload;
> -- 
> 2.39.0
> 
