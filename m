Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C862FAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiKRQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiKRQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:49:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CD793721;
        Fri, 18 Nov 2022 08:49:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 534B662675;
        Fri, 18 Nov 2022 16:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE7DC433D6;
        Fri, 18 Nov 2022 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668790192;
        bh=Ezeq8ffMYvaPt9FpoGuX5EQSh2HNXruXkEIhBtNrqXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+JTQsE5gBlbQKNkVdC+DxA8XuWAPw+UeaHxdk4s7mPJ549BmuWk3MM6R4F6c7n6C
         EsCL6Hk9H1J8XQPoNjTdfH2WJ8E6eUXq6otr2IhTOtYkxxdm3zXcv0un0lLCl5sc+t
         3VP++ldEfKNntD/Tt+XxhZ/oVmWxCS39+2V0zwu4sPIrvGXB/u4JjkclpYadaIR7LR
         m42PXa1FGhJvPcWmctVEpKKAzJetqlDkoRMDxgIJ/ipTmOv6diUYQI7rA0BGhoKyy+
         QDDPH2K1Iv6AFjuh4lxI7nQdxnJZBu0jk91emROjy0tryHhV5qU+56VwXbPiW+8s82
         OEFUywC54fQwA==
Date:   Fri, 18 Nov 2022 16:49:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3 7/8] perf: Add perf_event_attr::config3
Message-ID: <20221118164943.GA4872@willie-the-truck>
References: <20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org>
 <20220825-arm-spe-v8-7-v3-7-87682f78caac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825-arm-spe-v8-7-v3-7-87682f78caac@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:55:07AM -0500, Rob Herring wrote:
> Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> existing perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config3' field.
> 
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - No change
> v2:
>  - Drop tools/ side update
> ---
>  include/uapi/linux/perf_event.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 85be78e0e7f6..b2b1d7b54097 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -374,6 +374,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -515,6 +516,8 @@ struct perf_event_attr {
>  	 * truncated accordingly on 32 bit architectures.
>  	 */
>  	__u64	sig_data;
> +
> +	__u64	config3; /* extension of config2 */

I need an ack from the perf core maintainers before I can take this.

Will
