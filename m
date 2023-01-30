Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897CF6803BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjA3CJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjA3CJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:09:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01771E5EA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:09:53 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so5233396pjt.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPrdjanhQIGa0RVyH5LzwIiE2EQ581FsINiupfwdMvY=;
        b=tS/O4n+pK/eOEplNQx8SkrcklG2o2b5T50c8M5kLBQhZ0qgswe5LunbKaRVHS81EvD
         IYZph1NMzkgJpldYJ8rzI6Zh0wwwdHwhkymY9ftx5JIDHpJMHRVdQGJsG/jsNlJDDUYQ
         jHJgt40a5gGqeN8inJVvquL/+ziWenA8HxQN+YC0AZL0YShdoNWLxToQpOmXIvI+Fg5c
         Ho6xeEz3/7g6JggtF3jk5ij1NVaKqy9ZmspxJHtVOPHLdanbyD9QkvgMfV55gejtieG6
         qHjBVbhflgoU6K5Riv8pT6rCVPLKxzp8OKeppI4OchXlkA5u5gSJV4Lwc4ixeyuf1PdR
         1dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPrdjanhQIGa0RVyH5LzwIiE2EQ581FsINiupfwdMvY=;
        b=Ynn/WvH7wVwS0Qhtx8I2HzIk4vTGuZ2DXAQpEIQYv9fxtRKMsP3JeSfsjnnZW3kji4
         ZySoSJlQXiL9RcTdtZZtE6/wL/N0QpXydw8vwdouIkcIu0/irjAADwGXKvYU98vroVtA
         DS0A5bJP/GMDgoNdlCjIPgrBrKhFe5ld19LwX3/qSZWZR6oBrQQo9t2EOhSgW8GmDa/j
         qjWqdKGNSDBLthd5ftvtEMxcXw+NuJwyg5bIeh2AtmNkR55GhqGOvIQjmpNr9c7MgANK
         zoVVC2jHkcEHRr7xmDdZAu8rdLUjDux7fMVZYEA4enD37dgdgOQUQLjzf2vengrZwTM2
         T2hw==
X-Gm-Message-State: AO0yUKWQpi/Oy8QqIF03K8GxcqIf66FxfNE4eafzU48Av994U5H41plR
        mAdQBLt3+gYLgUtBmEeqSBpWTQ==
X-Google-Smtp-Source: AK7set9QP/Dvniowg6hlJckqp7OCgbsUuywznsT+BhS+eBXNdMclqz7C83L2UhvvoW7qAOBT5/tLHQ==
X-Received: by 2002:a17:902:c943:b0:196:4652:7cff with SMTP id i3-20020a170902c94300b0019646527cffmr15166084pla.11.1675044592943;
        Sun, 29 Jan 2023 18:09:52 -0800 (PST)
Received: from leoy-yangtze.lan (211-23-48-221.hinet-ip.hinet.net. [211.23.48.221])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001963bc7bdb8sm6431362plr.274.2023.01.29.18.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:09:52 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:09:46 +0800
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
Subject: Re: [PATCH] perf arm-spe: Add raw decoding for SPEv1.2 previous
 branch address
Message-ID: <Y9cm6sLGTA6hZrIu@leoy-yangtze.lan>
References: <20230127205951.673253-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127205951.673253-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 02:59:51PM -0600, Rob Herring wrote:
> Arm SPEv1.2 adds a new optional address packet type: previous branch
> target. The recorded address is the target virtual address of the most
> recently taken branch in program order.
> 
> Add support for decoding the address packet in raw dumps.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 2f311189c6e8..e92e1a7c8a8e 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -422,16 +422,18 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  	int ch, pat;
>  	u64 payload = packet->payload;
>  	int err = 0;
> +	static const char *idx_name[] = {"PC", "TGT", "VA", "PA", "LBR" };

I know you use the "LBR" which is a naming convention from X86 arch,
Armv8 ARM defines the name "PBT", so "PBT" would be easier for us to
match code with architecture specification.

"LBR" is also fine for me, it's up to you if you want to update for
this:

Reviewed-by: Leo Yan <leo.yan@linaro.org>


>  	switch (idx) {
>  	case SPE_ADDR_PKT_HDR_INDEX_INS:
>  	case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
> +	case SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH:
>  		ns = !!SPE_ADDR_PKT_GET_NS(payload);
>  		el = SPE_ADDR_PKT_GET_EL(payload);
>  		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
>  		arm_spe_pkt_out_string(&err, &buf, &buf_len,
>  				"%s 0x%llx el%d ns=%d",
> -				(idx == 1) ? "TGT" : "PC", payload, el, ns);
> +				idx_name[idx], payload, el, ns);
>  		break;
>  	case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
>  		arm_spe_pkt_out_string(&err, &buf, &buf_len,
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 9b970e7bf1e2..f75ed3a8a050 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -65,6 +65,7 @@ struct arm_spe_pkt {
>  #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		0x1
>  #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	0x2
>  #define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	0x3
> +#define SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH	0x4
>  
>  /* Address packet payload */
>  #define SPE_ADDR_PKT_ADDR_BYTE7_SHIFT		56
> -- 
> 2.39.0
> 
