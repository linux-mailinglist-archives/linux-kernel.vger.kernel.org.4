Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE75EDE93
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiI1OP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI1OPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B761D49;
        Wed, 28 Sep 2022 07:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B01F61E8B;
        Wed, 28 Sep 2022 14:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BBBC433C1;
        Wed, 28 Sep 2022 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664374549;
        bh=YsY1EoJjrDNVODvXIzdua83IpA1RXF/C9m3dQgOk1sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePlHjXAujImYF4ax69tV+zJhVFVToqdFhFCNpz1e7/Hz2spQhdq95OD/AasietrU2
         yBb9P7kQpQdC5q6pl9DG3PxPZIWD2vsjdSls7ajGJ/n63TyXA+w3gCLQlC6Zr43QB4
         u8TRLe6dN1IIqxtRyaE5Cmt2QctzZeakT0HG2QkDgKQMSihR0FmPJ7Z8TjNf7jbiUy
         1jmn3nX23h5rneYjSx5BXHwW7YIT3WcH/vOkvdow3WwcOr/Aw2g0DgQas85+BgddTU
         RziX3qHiYnzHrK0LlJp9ljSWe4aQh3wyGgp09opVFse47fI/qWG6umYxryVpAcCA4l
         7Jz44c1Ogn/OA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17365405F0; Wed, 28 Sep 2022 11:15:47 -0300 (-03)
Date:   Wed, 28 Sep 2022 11:15:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf: Add more syscalls to benchmark
Message-ID: <YzRXE2JTKrDzHUYL@kernel.org>
References: <1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn>
 <8eed7586-0f47-a576-195f-0180826a67f3@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eed7586-0f47-a576-195f-0180826a67f3@loongson.cn>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 28, 2022 at 09:06:03AM +0800, Tiezhu Yang escreveu:
> 
> 
> On 09/06/2022 11:06 AM, Tiezhu Yang wrote:
> > Tiezhu Yang (3):
> >   perf bench syscall: Introduce bench_syscall_common()
> >   perf bench syscall: Add close syscall benchmark
> >   perf bench syscall: Add execve syscall benchmark
> > 
> >  tools/perf/bench/bench.h   |  2 ++
> >  tools/perf/bench/syscall.c | 76 +++++++++++++++++++++++++++++++++++++++++++---
> >  tools/perf/builtin-bench.c |  2 ++
> >  3 files changed, 76 insertions(+), 4 deletions(-)
> > 
> 
> Hi all,
> 
> Any more comments? Do you think this patch series [1] is useful?
> If yes, I will send v2 to fix the build error about undeclared
> __NR_getppid reported by kernel test robot.
> 
> [1] https://lore.kernel.org/lkml/1662433577-23266-1-git-send-email-yangtiezhu@loongson.cn/


Please send the v2.

- Arnaldo
