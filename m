Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17262BF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKPNLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:10:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C120F46;
        Wed, 16 Nov 2022 05:10:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9AF61DC3;
        Wed, 16 Nov 2022 13:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084B3C433C1;
        Wed, 16 Nov 2022 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668604256;
        bh=zCtCVJfN4MTsYIroUEMbBDznVPewtvyiuUQQBTsXqkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9woAkQDji8/wzikdc9ve1IxcgM97Wsbpo/Uf+f+RinxLecz9GA0XQjyS6sW93Dmv
         y/nNRHHyYb9bNouvoVYhVtXTkEEsuMy2j8iw475knCA96Ea2hu6Dq+8R18nvqXgsLa
         Q2Xov4e2BSwuglpf2Pbl4OtRtifSTA+JeoyZB5f5BaCOdnDmODnUQTS0ARoIM9GuA+
         xpvgrkorlt0x9Z7QcJUPsNAY+PHb9gjwi5uHxjRBsaP5b/y3HaSThovupBhHCnoYsI
         utRDbW7GcGnSavNQ288SJs8b98IgCXoK5asJ+VBP09qhMcKBpk4JfySZ90qg1EDQ4j
         PDqvYYZP+Mekw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8783B4034E; Wed, 16 Nov 2022 10:10:53 -0300 (-03)
Date:   Wed, 16 Nov 2022 10:10:53 -0300
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
Message-ID: <Y3ThXYH3SAyEGmQ+@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org>
 <Y3TOwYdhzURKTgyB@kernel.org>
 <Y3Tah5Ocvx6lQ4jP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Tah5Ocvx6lQ4jP@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 09:41:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> But then:
 
> [root@five ~]# perf list syscalls:sys_enter_open* |& grep syscalls:
>   syscalls:sys_enter_open                            [Tracepoint event]
>   syscalls:sys_enter_open_by_handle_at               [Tracepoint event]
>   syscalls:sys_enter_open_tree                       [Tracepoint event]
>   syscalls:sys_enter_openat                          [Tracepoint event]
>   syscalls:sys_enter_openat2                         [Tracepoint event]
> [root@five ~]#
> 
> This stops working, looking into it.

Sidetracked with other stuff, please find what I have patched at
perf/perf-list-json-output in my tree.

I removed the last two patches and I'm testing so that I can push
perf/core with your series modulo the last two + Namhyung's 'perf list'
kit.

- Arnaldo
