Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEC62C256
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiKPPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiKPPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:21:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739B2AD3;
        Wed, 16 Nov 2022 07:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5416361E9C;
        Wed, 16 Nov 2022 15:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88999C433D6;
        Wed, 16 Nov 2022 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668612065;
        bh=CZHRUprQ4Szz7S5zdkW0Po6xn0FmY1Hxxb/CTgTtlhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZpiuppzFb0/NjOyFxqxM/jLs/1MrrX3R/xYlCLvVbteMCZRintOvI8TISMXsP13H
         VAx2C7GUp0sK79FEXvfc2KdoPWyhi5x7kPfCcaBGadxqjPPIanWCPfo4GY3h67noJH
         CDFKAgPQBilOvXJqx9Ivsa4TVwVzYJRFjlriG9XlqzEtO7VPTwqnrnIhwHom/AxllN
         K3610CsKIAvwFGa4Q+pWsXDoZoa+BwyW0Y1rQJfERfCKU/JxOutmovxmcH533x1bz5
         6H+EfVBGjpgTLMedvRR08RY26FK22+fD7gpR9auKst02b4o5sN1qIU/XBxl3xtvN/z
         CGWZTTwprBEVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A5E74034E; Wed, 16 Nov 2022 12:21:03 -0300 (-03)
Date:   Wed, 16 Nov 2022 12:21:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
Message-ID: <Y3T/35DcAw+h4R93@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org>
 <Y3TOwYdhzURKTgyB@kernel.org>
 <Y3Tah5Ocvx6lQ4jP@kernel.org>
 <Y3ThXYH3SAyEGmQ+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ThXYH3SAyEGmQ+@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 10:10:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 16, 2022 at 09:41:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > But then:
>  
> > [root@five ~]# perf list syscalls:sys_enter_open* |& grep syscalls:
> >   syscalls:sys_enter_open                            [Tracepoint event]
> >   syscalls:sys_enter_open_by_handle_at               [Tracepoint event]
> >   syscalls:sys_enter_open_tree                       [Tracepoint event]
> >   syscalls:sys_enter_openat                          [Tracepoint event]
> >   syscalls:sys_enter_openat2                         [Tracepoint event]
> > [root@five ~]#
> > 
> > This stops working, looking into it.
> 
> Sidetracked with other stuff, please find what I have patched at
> perf/perf-list-json-output in my tree.
> 
> I removed the last two patches and I'm testing so that I can push
> perf/core with your series modulo the last two + Namhyung's 'perf list'
> kit.

I just saw you sent a patch on top of the previous one, will try and
combine stuff to remove failures from the bisect history.

- Arnaldo
