Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7146DCD78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDJWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDJWbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611501FED;
        Mon, 10 Apr 2023 15:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEE3F61C9A;
        Mon, 10 Apr 2023 22:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC2EC433EF;
        Mon, 10 Apr 2023 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681165895;
        bh=ODPUu4XbPkXfqtVifM59v1vcAU5MV/y3Fow3J7M6KfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dN8+hSwAS9KrTzT4zswys1zsGvx5iSy3DBvXy8/h+Pcs/UTlkzGSRE7TWe/FGBHqn
         IINC5xbQuqJ3uOf+8tO9A814X541r2ObdNmVQlWWB1L1qDv5+DzqLME2/Q+6qDU/Gx
         XS20hF6jjRdRZe/BqhfhBDzpZPDiZ7I+SSY0GHOCumlVZ/kNoYLMfxJ594iEvPZH/W
         sMkf7jLCBbP+2dCIW6Vm7+2rZwBKRWLGFE8HhBS/M6j1k4dtJxjCiFe27+RxfU5hkF
         GuXP8wPmv0XywIrmC53V/9skcBCYjBMjjXje1GcQu/hTtLm67vwO4Xdxh65TcYafMY
         JtbJfDFHnAQoA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AAA1940009; Mon, 10 Apr 2023 19:31:32 -0300 (-03)
Date:   Mon, 10 Apr 2023 19:31:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
        mingo@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 0/9] perf/mem: AMD IBS and generic tools improvements
Message-ID: <ZDSORDbkoN0PvfkL@kernel.org>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
 <CAM9d7cijvZBsaXTMm8d=sxUWy6s+umCCnWhunD3KVhKbpVp_-A@mail.gmail.com>
 <631876a2-5946-82d5-6f70-bf7734db3992@amd.com>
 <ZDQoJFcyxpF+4Qu+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDQoJFcyxpF+4Qu+@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 10, 2023 at 12:15:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Apr 10, 2023 at 07:53:57AM +0530, Ravi Bangoria escreveu:
> > On 08-Apr-23 3:14 AM, Namhyung Kim wrote:
> > > Hi Ravi,
> > > 
> > > On Fri, Apr 7, 2023 at 4:25 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> > >>
> > >> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
> > >> limitations. Mainly:
> > >>
> > >> 1. mem_lvl_num doesn't allow setting multiple sources whereas old API
> > >>    allows it. Setting multiple data sources is useful because IBS on
> > >>    pre-zen4 uarch doesn't provide fine granular DataSrc details (there
> > >>    is only one such DataSrc(2h) though).
> > >> 2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
> > >>    c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
> > >>    prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
> > >>
> > >> Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
> > >> first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
> > >> setting new API fields, convert all individual field assignments to
> > >> compile time wrapper macros built using PERF_MEM_S(). Also convert
> > >> DataSrc conditional code to array lookups.
> > >>
> > >> Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
> > >> non-intuitive. Make it sane.
> > > 
> > > Looks good, but I think you need to split kernel and user patches.
> > 
> > Patch #1 to #3 are kernel changes. Patch #4 to #9 are userspace changes.
> > Arnaldo, Peter, please let me know if you wants to split the series and
> > resend.
> 
> I can always use b4's -P option :-) So no need to resubmit, I can pick
>> the tools bits,

Done
 
> - Arnaldo
>  
> > > 
> > >>
> > >> v2: https://lore.kernel.org/r/20230327130851.1565-1-ravi.bangoria%40amd.com
> > >> v2->v3:
> > >>   - IBS: Don't club RmtNode with DataSrc=7 (IO)
> > >>   - Make perf_mem__lvl_scnprintf() more sane
> > >>   - Introduce PERF_MEM_LVLNUM_UNC, set it along with PERF_MEM_LVL_UNC
> > >>     and interpreat it in tool.
> > >>   - Add PERF_MEM_LVLNUM_NA to default data_src value
> > >>   - Change some of the IBS bit description according to latest PPR
> > >>
> > >> Namhyung Kim (1):
> > >>   perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
> > >>
> > >> Ravi Bangoria (8):
> > >>   perf/mem: Introduce PERF_MEM_LVLNUM_UNC
> > >>   perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
> > >>   perf headers: Sync uapi/linux/perf_event.h
> > >>   perf mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_DATA_SRC_NONE
> > >>   perf mem: Add support for printing PERF_MEM_LVLNUM_UNC
> > >>   perf mem: Refactor perf_mem__lvl_scnprintf()
> > >>   perf mem: Increase HISTC_MEM_LVL column size to 39 chars
> > >>   perf script ibs: Change bit description according to latest PPR
> > > 
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks!
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
