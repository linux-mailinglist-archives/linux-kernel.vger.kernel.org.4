Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7075FEF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJNNyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJNNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:54:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13C1C492B;
        Fri, 14 Oct 2022 06:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ADB9B82354;
        Fri, 14 Oct 2022 13:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146EFC43470;
        Fri, 14 Oct 2022 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665755597;
        bh=ART5k5Bn2tI53V+/SpuTXXx18eS07m2smakbgwYnQlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIUvCx4FkvGBFvOcP2XMMefMyBaqcXxSe6J5USOiu18D0QOOcmM70LRtltXFyUgJX
         Ym4W8axBp9A3fwSlKaOgI8T83wP4IyeT8Dvs0wpRiu9AAO7RZ+no8OPEQ4JIazfVTE
         hRE44zErYssghEDXUAmgqgILomM38QcCzfwf7Eebw1jUlm8KVEBkhr0QiSgeF0Yn8D
         3A9UmNTArTsV+lJztHCYsd02l0q7lPEvYJO23ZSLrElnxcBPvypSctVMai8ORnA/QO
         MozxLZBe4RWttz3/qDZD+XX63zKqA176kcSSPV3U/23Hf0wt+z5OJGPDVt3mbY2+iB
         DNztVrT0dUdGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5AEB4062C; Fri, 14 Oct 2022 10:53:14 -0300 (-03)
Date:   Fri, 14 Oct 2022 10:53:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Message-ID: <Y0lpylA86mEnmefg@kernel.org>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
 <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
 <a36ffee0-b0d5-5941-8d98-cc8e9b100a50@amd.com>
 <88c920de-5af6-c7b0-d6a8-6c365491dd3e@linux.intel.com>
 <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
 <d428b526-a592-2ea5-dad8-d6eae72eb118@linux.intel.com>
 <585535bf-47d0-178c-706a-3d71bfc31f68@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585535bf-47d0-178c-706a-3d71bfc31f68@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 05:08:55PM +0530, Ravi Bangoria escreveu:
> On 03-Oct-22 6:45 PM, Liang, Kan wrote:
> >> PERF_MEM_LVLNUM_EXTN_MEM was introduced to cover CXL devices but it's
> >> bit ambiguous name and also not generic enough to cover cxl.cache and
> >> cxl.io devices. Rename it to PERF_MEM_LVLNUM_CXL to be more specific.

> > Looks good to me.

> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

> Thanks Kan.

> Peter, can you please include this patch along with the series?

> Arnaldo, I'll respin tool side of patches with this change.

Its already upstream, so please go on from there, ok?

I'm now processing perf patches after getting lost in pahole land for a
bit :-)

- Arnaldo
