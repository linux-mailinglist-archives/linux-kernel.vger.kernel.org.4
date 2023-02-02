Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A368732C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjBBBrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBBrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:47:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F367E7164B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 17:47:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2C7FB82221
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8B6C433EF;
        Thu,  2 Feb 2023 01:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675302437;
        bh=W01dOOpXnS15pOfV6QhaXXSz+Tnf1lnLDUkvbC9nagg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EaE9T6gHCFrgogIzcXLWSeGqpykDRorVTXABxyg85csl578vmRCRdm9Ac9WZttB21
         bTKSRJTsNs+noc5N5L6vKMkFaBNKgkDrUNa0KSgj/i1sDvDRZBC5impBGoxO4++4dx
         Pa7oiJSOR41GLdDeTOUSp8lD/rsCT7u6duWWjWhNjKv2WhcntpM2Xl/HxsCdfo6za4
         zxQ5wN9ga2G1RlLKHal49SIYUodi5ZUUWJsOmMx2dRJuSr/zsM4SULB8QEy/RQ3038
         WJR99DLTkPGX/acpvYhJLGxmRNIn9vijQtKRkiMc335aVp7s6qZ0uinF3UUr5qJfWk
         T/aV+yhd3iF5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6AFD5405BE; Wed,  1 Feb 2023 22:47:14 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:47:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
Message-ID: <Y9sWImm4v5I/MZId@kernel.org>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
 <20230104201349.1451191-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104201349.1451191-7-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
> are also supported.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

Did the kernel bits land upstream?

- Arnaldo
 
> No change since V1
> 
>  arch/x86/events/msr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> index ecced3a52668..074150d28fa8 100644
> --- a/arch/x86/events/msr.c
> +++ b/arch/x86/events/msr.c
> @@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
>  	case INTEL_FAM6_RAPTORLAKE:
>  	case INTEL_FAM6_RAPTORLAKE_P:
>  	case INTEL_FAM6_RAPTORLAKE_S:
> +	case INTEL_FAM6_METEORLAKE:
> +	case INTEL_FAM6_METEORLAKE_L:
>  		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
>  			return true;
>  		break;
> -- 
> 2.35.1

-- 

- Arnaldo
