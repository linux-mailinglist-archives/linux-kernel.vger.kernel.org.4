Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6668A34C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjBCTzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBCTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:55:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AD1ABE8;
        Fri,  3 Feb 2023 11:55:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10953B82BB1;
        Fri,  3 Feb 2023 19:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80666C433EF;
        Fri,  3 Feb 2023 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675454138;
        bh=J0EIMP1EVgIdqMTC3teKPJoi2YQ0SpZb7fRlMo9WF18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phtagNF7fp3mlIM+dA3F/oll1WFh8PWSOuhyu9CEev4+C2MxsWVL1Kac/nyqXCoej
         Nyk0O1VM1r8+P3kcqIv9Lawr6PbUdRjZ16HFTOyZhyawthTxZXOuKeogT4fGp5eHaa
         sxhhZQo1UimZCpvGUhpfj15KDbk/JYrp65gZPIXz5V0WwwJdpK1xJ/eWtXi0Z7LMZ9
         j1zGp/fuUl9mjaOQXaa4knYWz0+oZLHbY2vT9VfIaCx+AbcH1rpsnrLM/GOnftehQZ
         dnylLYaS2kizzTYU8W4z4TH9+0dZ6BhHy6Mxfjt6R9T/Rb9I9zHDnygOJBwlEciJA/
         8t9v7/TthP1vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30682405BE; Fri,  3 Feb 2023 16:55:35 -0300 (-03)
Date:   Fri, 3 Feb 2023 16:55:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf arm-spe: Add raw decoding for SPEv1.2 previous
 branch address
Message-ID: <Y91mt3JtQ8bcVx4g@kernel.org>
References: <20230203162401.132931-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162401.132931-1-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 03, 2023 at 10:24:01AM -0600, Rob Herring escreveu:
> Arm SPEv1.2 adds a new optional address packet type: previous branch
> target. The recorded address is the target virtual address of the most
> recently taken branch in program order.
> 
> Add support for decoding the address packet in raw dumps.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Use "PBT" instead of "LBR"



Thanks, applied.

- Arnaldo


> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 +++-
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 2f311189c6e8..fed4741f372e 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -422,16 +422,18 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
>  	int ch, pat;
>  	u64 payload = packet->payload;
>  	int err = 0;
> +	static const char *idx_name[] = {"PC", "TGT", "VA", "PA", "PBT"};
>  
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

-- 

- Arnaldo
