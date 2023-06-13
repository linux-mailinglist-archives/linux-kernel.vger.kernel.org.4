Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725EC72D849
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbjFMEDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:03:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCDF0;
        Mon, 12 Jun 2023 21:02:59 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QgFF44CfmzLq5B;
        Tue, 13 Jun 2023 11:59:52 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 12:02:55 +0800
Date:   Tue, 13 Jun 2023 12:02:41 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        Changbin Du <changbin.du@huawei.com>, <hw.huiwang@huawei.com>
Subject: Re: [PATCH v2 0/2] Fix srcline addr2line issue with the ',' sentinel
Message-ID: <20230613040241.phh6xxrj2orxt25p@M910t>
References: <20230613034817.1356114-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230613034817.1356114-1-irogers@google.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is fixed, thanks!

Tested-by: Changbin Du <changbin.du@huawei.com>

On Mon, Jun 12, 2023 at 08:48:15PM -0700, Ian Rogers wrote:
> addr2line makes it hard to detect when inline output has finished. To
> detect it srcline issues a bogus ',' symbol and expects to see a
> filename:line of "??:0". For binutils addr2line ',' gets turned into
> address 0 and if there is a symbol there then the sentinel isn't
> detected, this problem has been occurring with kernel binaries.
> 
> The issue was reported by and debugged by Changbin Du <changbin.du@huawei.com>.
> 
> v2. Incorporate feedback from Changbin.
> 
> Ian Rogers (2):
>   perf srcline: Make addr2line configuration failure more verbose
>   perf srcline: Make sentinel reading for binutils addr2line more robust
> 
>  tools/perf/util/srcline.c | 93 ++++++++++++++++++++++++++++++---------
>  1 file changed, 73 insertions(+), 20 deletions(-)
> 
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 
Cheers,
Changbin Du
