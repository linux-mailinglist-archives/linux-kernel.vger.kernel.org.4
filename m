Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20FD62849D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiKNQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:06:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E419C36;
        Mon, 14 Nov 2022 08:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F10B8105F;
        Mon, 14 Nov 2022 16:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092BC433C1;
        Mon, 14 Nov 2022 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668442000;
        bh=xyWUquctCgNLHTWoRXdAySXc382E+bpNpRue83ITrpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnDltw0kRGUACLQs4C1R+kwkbpZitnKDqn8xe9SnD8NGEB2/wfU8LPdryC67G7UgS
         euPF7KkMKUvsxWSJE6ZtBqQPmeFTPOvs/YJda23pP/DsPIKywvruJ14Kxb6sScTR3e
         w788Ij46RwocEAbu/2Z5HqktbCxSbaAIkprhDef9Pp35WDGZAMoJr7c+h7poDjewQC
         Xk86qjGYkqVx5MCq/qT/nQHfy7wz2DC9EiJF6f5U67FgwqEfsf+yNzVOHsvyNYmNdK
         aWmSLs0evm9OVPclXwcRp5OgSOxe3u380dxeMU1lxb+MkWwgl64vVy8oaqsR5eAulK
         7LVaYB40KZJcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 577F54034E; Mon, 14 Nov 2022 13:06:38 -0300 (-03)
Date:   Mon, 14 Nov 2022 13:06:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] perf list: Add PMU pai_ext event description for IBM
 z16
Message-ID: <Y3JnjmxPX+m7G9HL@kernel.org>
References: <20221111135402.858623-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135402.858623-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 11, 2022 at 02:54:02PM +0100, Thomas Richter escreveu:
> Add the event description for the IBM z16 pai_ext PMU released with
> commit c432fefe8e62 ("s390/pai: Add support for PAI Extension 1 NNPA counters")
> 
> The document SA22-7832-13 "z/Architecture Principles of Operation",
> published May, 2022, contains the description of the
> Processor Activity Instrumentation Facility and the NNPA counter
> set., See Pages 5-113 to 5-116.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  .../pmu-events/arch/s390/cf_z16/pai_ext.json  | 198 ++++++++++++++++++
>  tools/perf/pmu-events/jevents.py              |   1 +
>  2 files changed, 199 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> 
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> new file mode 100644
> index 000000000000..8bee481f05d5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> @@ -0,0 +1,198 @@
> +[
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6144",
> +		"EventName": "NNPA_ALL",
> +		"BriefDescription": "NNPA ALL",
> +		"PublicDescription": "Sum of all non zero NNPA counters"
> +	},

Since the Brief description mentions NNPA, shouldn't the Public
Description expand on this "NNPA" acronym?, something like:

Oops, can't expand on that since there isn't a link to that SA22-7832-13
document.

Googling for it...

https://www-40.ibm.com/servers/resourcelink/svc03100.nsf/pages/zResourceLinkUrl?OpenDocument&url=http://www.ibm.com/servers/resourcelink/lib03010.nsf/0/B9DE5F05A9D57819852571C500428F9A/$file/SA22-7832-13.pdf

Ok, requires registration.

I wonder what is the value of these descriptions then :-\

I miss Ingo jumping into these discussions :-)

- Arnaldo

> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6145",
> +		"EventName": "NNPA_ADD",
> +		"BriefDescription": "NNPA ADD",
> +		"PublicDescription": "NNPA ADD function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6146",
> +		"EventName": "NNPA_SUB",
> +		"BriefDescription": "NNPA SUB",
> +		"PublicDescription": "NNPA SUB function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6147",
> +		"EventName": "NNPA_MUL",
> +		"BriefDescription": "NNPA MUL",
> +		"PublicDescription": "NNPA MUL function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6148",
> +		"EventName": "NNPA_DIV",
> +		"BriefDescription": "NNPA DIV",
> +		"PublicDescription": "NNPA DIV function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6149",
> +		"EventName": "NNPA_MIN",
> +		"BriefDescription": "NNPA MIN",
> +		"PublicDescription": "NNPA MIN function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6150",
> +		"EventName": "NNPA_MAX",
> +		"BriefDescription": "NNPA MAX",
> +		"PublicDescription": "NNPA-MAX function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6151",
> +		"EventName": "NNPA_LOG",
> +		"BriefDescription": "NNPA LOG",
> +		"PublicDescription": "NNPA-LOG function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6152",
> +		"EventName": "NNPA_EXP",
> +		"BriefDescription": "NNPA EXP",
> +		"PublicDescription": "NNPA-EXP function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6153",
> +		"EventName": "NNPA_IBM_RESERVED_9",
> +		"BriefDescription": "Reserved for IBM use",
> +		"PublicDescription": "Reserved for IBM use"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6154",
> +		"EventName": "NNPA_RELU",
> +		"BriefDescription": "NNPA RELU",
> +		"PublicDescription": "NNPA-RELU function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6155",
> +		"EventName": "NNPA_TANH",
> +		"BriefDescription": "NNPA TANH",
> +		"PublicDescription": "NNPA-TANH function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6156",
> +		"EventName": "NNPA_SIGMOID",
> +		"BriefDescription": "NNPA SIGMOID",
> +		"PublicDescription": "NNPA-SIGMOID function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6157",
> +		"EventName": "NNPA_SOFTMAX",
> +		"BriefDescription": "NNPA SOFTMAX",
> +		"PublicDescription": "NNPA-SOFTMAX function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6158",
> +		"EventName": "NNPA_BATCHNORM",
> +		"BriefDescription": "NNPA BATCHNORM",
> +		"PublicDescription": "NNPA-BATCHNORM function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6159",
> +		"EventName": "NNPA_MAXPOOL2D",
> +		"BriefDescription": "NNPA MAXPOOL2D",
> +		"PublicDescription": "NNPA-MAXPOOL2D function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6160",
> +		"EventName": "NNPA_AVGPOOL2D",
> +		"BriefDescription": "NNPA AVGPOOL2D",
> +		"PublicDescription": "NNPA-AVGPOOL2D function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6161",
> +		"EventName": "NNPA_LSTMACT",
> +		"BriefDescription": "NNPA LSTMACT",
> +		"PublicDescription": "NNPA-LSTMACT function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6162",
> +		"EventName": "NNPA_GRUACT",
> +		"BriefDescription": "NNPA GRUACT",
> +		"PublicDescription": "NNPA-GRUACT function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6163",
> +		"EventName": "NNPA_CONVOLUTION",
> +		"BriefDescription": "NNPA CONVOLUTION",
> +		"PublicDescription": "NNPA-CONVOLUTION function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6164",
> +		"EventName": "NNPA_MATMUL_OP",
> +		"BriefDescription": "NNPA MATMUL OP",
> +		"PublicDescription": "NNPA-MATMUL-OP function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6165",
> +		"EventName": "NNPA_MATMUL_OP_BCAST23",
> +		"BriefDescription": "NNPA NNPA-MATMUL_OP_BCAST23",
> +		"PublicDescription": "NNPA-MATMUL-OP-BCAST23 function ending with CC=0"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6166",
> +		"EventName": "NNPA_SMALLBATCH",
> +		"BriefDescription": "NNPA SMALLBATCH",
> +		"PublicDescription": "NNPA function with conditions as described in Common Operation"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6167",
> +		"EventName": "NNPA_LARGEDIM",
> +		"BriefDescription": "NNPA LARGEDIM",
> +		"PublicDescription": "NNPA function with conditions as described in Common Operation"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6168",
> +		"EventName": "NNPA_SMALLTENSOR",
> +		"BriefDescription": "NNPA SMALLTENSOR",
> +		"PublicDescription": "NNPA function with conditions as described in Common Operation"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6169",
> +		"EventName": "NNPA_1MFRAME",
> +		"BriefDescription": "NNPA 1MFRAME",
> +		"PublicDescription": "NNPA function with conditions as described in Common Operation"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6170",
> +		"EventName": "NNPA_2GFRAME",
> +		"BriefDescription": "NNPA 2GFRAME",
> +		"PublicDescription": "NNPA function with conditions as described in Common Operation"
> +	},
> +	{
> +		"Unit": "PAI-EXT",
> +		"EventCode": "6171",
> +		"EventName": "NNPA_ACCESSEXCEPT",
> +		"BriefDescription": "NNPA ACCESSEXCEPT",
> +		"PublicDescription": "NNPA function with conditions as described in Common Operation"
> + 	}
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 0daa3e007528..da630aab948b 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -225,6 +225,7 @@ class JsonEvent:
>            'CPU-M-CF': 'cpum_cf',
>            'CPU-M-SF': 'cpum_sf',
>            'PAI-CRYPTO' : 'pai_crypto',
> +          'PAI-EXT' : 'pai_ext',
>            'UPI LL': 'uncore_upi',
>            'hisi_sicl,cpa': 'hisi_sicl,cpa',
>            'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> -- 
> 2.37.3

-- 

- Arnaldo
