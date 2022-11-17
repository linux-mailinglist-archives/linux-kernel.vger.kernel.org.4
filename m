Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDD62E237
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiKQQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiKQQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:48:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9012849097;
        Thu, 17 Nov 2022 08:48:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 06124CE1EB1;
        Thu, 17 Nov 2022 16:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0327AC433D6;
        Thu, 17 Nov 2022 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668703679;
        bh=LBa/FWQk4tjkT7d11S/VUUI/bOAPkWA5R/HXGPMfV64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdcKHJ/BWbvfEovc8sxVXyrPw3Y0g+EyhN5oxcJjMQ6IgL8hdR9HlnafOojQy4cCp
         5RyhCSPFpQUlDTsG+EywAsT/DWFqzHgOgGTRCyB6K3IM781VyghflANcsLxtjR0HQL
         QTpTZ/vSDGwa8w7bj+nl1HPGqxD6xtyk8G2rDSGoDjYbOZP4nSfmMpcz/VaZ8DdqOg
         QPxnC1B/ISwlJ0t370VlnxXchh3MkW5YXzCqsnUNAAbEYkuaVhhbqzEC36DwWSW8e9
         prH/xf9i1q32YgeiEoosM8+3WCAFsF3Yz8GgANCaV7gVbfKJjghbofpJ2cDnNoLhd1
         sis9itYIzS14Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4840F4034E; Thu, 17 Nov 2022 13:47:55 -0300 (-03)
Date:   Thu, 17 Nov 2022 13:47:55 -0300
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
Message-ID: <Y3Zlu4lAbZI8cQhT@kernel.org>
References: <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
 <Y3TK/6bBFsHxduPc@kernel.org>
 <Y3TOwYdhzURKTgyB@kernel.org>
 <Y3Tah5Ocvx6lQ4jP@kernel.org>
 <Y3ThXYH3SAyEGmQ+@kernel.org>
 <Y3T/35DcAw+h4R93@kernel.org>
 <CAP-5=fU-tJPdxosVFfbbKtrswom7bnY6Ei3JczRJaQYyOnjcAA@mail.gmail.com>
 <Y3Zh+XTXbhrOXAla@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Zh+XTXbhrOXAla@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 17, 2022 at 01:31:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 16, 2022 at 11:52:39AM -0800, Ian Rogers escreveu:
> > I think this should be squashed into "perf list: Reorganize to use
> > callbacks". Some explanation, in porting the : glob case I'd assumed
> > the before the colon would be the PMU and the after the event. Doing
> > things caused tracepoint output to differ too much and so for
> > tracepoints the : is kept in the event name. So we can simplify the
> > matching to not be pmu and event, just use the event glob.
 
> Next time please send the patch, I did it manually and before the last
> option I get:
 
> [root@quaco ~]# perf list syscalls:sys_enter_open |& grep syscalls
>   syscalls:sys_enter_open                            [Tracepoint event]
> [root@quaco ~]# perf test 112
> 112: Check open filename arg using perf trace + vfs_getname          : Ok
> [root@quaco ~]#

Ok, adjusted the last patch in the series, everything is in my
tmp.perf/core branch, will go to perf/core later today when all tests
gets passed.

Please check that what is at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/core

Is ok, its passing 'perf test' for me, including the one that was
failing:

[root@quaco ~]# perf test 112
112: Check open filename arg using perf trace + vfs_getname          : Ok
[root@quaco ~]#

- Arnaldo
