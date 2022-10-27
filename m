Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DEC60F24D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiJ0I0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiJ0I0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:26:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC853DBF7;
        Thu, 27 Oct 2022 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cyV55dw90naYEG3Ap/95NF6dsAJTLZCPc38XNt8Lu6M=; b=Q9XTqCBIN4KYQwVI2HKkTOpyIH
        MtUhXT9sX7JdpWWiR7/DghIpuoDT3twXkAIZdk+H70/bBpllZVXM/esCO55OiUzrJ1/IYLVMG+qxb
        44gxAshQa2/kmfAeIsqJruK+844SBmKCR5W80iN/g0CP9QorEWoD40IDRGasr/UiJ8lNX5O0tLjjp
        xbNiupxI83d/e/aSDEfPHSAui6OAeVKM52Qm922YTPRP3Er1Vobw59g0/iGcIrSTuf8UjOkHghXK1
        hAfPfjoa+6kcXxYRGceGregLTDwSeYqH9chbGiJQD8UCJD/y8VgN6SBGNRbLXOLmGwi4pzqkp7N50
        cWG7MDIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onyCu-000312-IG; Thu, 27 Oct 2022 08:25:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1E4930035C;
        Thu, 27 Oct 2022 10:25:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C8E120125B3B; Thu, 27 Oct 2022 10:25:37 +0200 (CEST)
Date:   Thu, 27 Oct 2022 10:25:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        kajoljain <kjain@linux.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Message-ID: <Y1pAgRHpV294J0Kw@hirez.programming.kicks-ass.net>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
 <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
 <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
 <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 12:07:40PM +0530, Ravi Bangoria wrote:

> From 5deb2055e2b5b0a61403f2d5f4e5a784b14a65e3 Mon Sep 17 00:00:00 2001
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> Date: Sat, 1 Oct 2022 11:37:05 +0530
> Subject: [PATCH] perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
>  PERF_MEM_LVLNUM_CXL
> 
> PERF_MEM_LVLNUM_EXTN_MEM was introduced to cover CXL devices but it's
> bit ambiguous name and also not generic enough to cover cxl.cache and
> cxl.io devices. Rename it to PERF_MEM_LVLNUM_CXL to be more specific.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks!

> ---
>  arch/x86/events/amd/ibs.c       | 2 +-
>  include/uapi/linux/perf_event.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3271735f0070..4cb710efbdd9 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -801,7 +801,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>  	/* Extension Memory */
>  	if (ibs_caps & IBS_CAPS_ZEN4 &&
>  	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
> -		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
>  		if (op_data2->rmt_node) {
>  			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>  			/* IBS doesn't provide Remote socket detail */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 85be78e0e7f6..eb1090604d53 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1337,7 +1337,7 @@ union perf_mem_data_src {
>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
>  /* 5-0x8 available */
> -#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
> +#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
>  #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
>  #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
>  #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
> -- 
> 2.31.1
