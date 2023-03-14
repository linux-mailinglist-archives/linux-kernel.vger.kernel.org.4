Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC76B93CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjCNMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCNMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:30:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B165458;
        Tue, 14 Mar 2023 05:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D74A2B81904;
        Tue, 14 Mar 2023 12:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F1C433D2;
        Tue, 14 Mar 2023 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678796902;
        bh=5N+7fNf0TDNaB7B3mQfFsCYvFNPPgUGuGzx4zeoKCto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKE+InH5nWSVBEMr80cyCZeuKgDgtqJpsysalYSmh+y4gBpHhOGo0C/vUWGhIxPbM
         HTEdA9mPtOhUdDzHLYgPYh1WhHCL7BsVRqiyifDKOJ5vR17gNnOvbq4s0sCUctqugY
         Sn4fftVffvGs6hPwe42cJRACdqEsbygweBpI+zMbyX67IqCXCHQXOligGh4NCWPoT0
         smoNI9+HOQnTse2u3yzUkiHxohKa/X1aijbTYn4MslbIAjDpZOFe6S3cnscUFSYzWe
         z0Bbb8LTxGsOa3OEN/XW4cDBZYZ9RmQvVD0FxcDgW4lKAsJZ965KGEu+US3cr409K7
         zmqXN/r7iPKZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44A334049F; Tue, 14 Mar 2023 09:28:20 -0300 (-03)
Date:   Tue, 14 Mar 2023 09:28:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 00/13] Perf tool build improvements
Message-ID: <ZBBoZATQV1WOlyox@kernel.org>
References: <20230311065753.3012826-1-irogers@google.com>
 <ZBBkWDFdBDC9Spt9@kernel.org>
 <86250a33-940f-4dce-fa6f-4331be7d806b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86250a33-940f-4dce-fa6f-4331be7d806b@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 14, 2023 at 02:21:23PM +0200, Adrian Hunter escreveu:
> On 14/03/23 14:11, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 10, 2023 at 10:57:40PM -0800, Ian Rogers escreveu:
> >> Make the default build options a more preferred set, such as making
> >> BPF skeletons default and failing the build if jevents or libtracevent
> >> dependencies fail. The binutil dependencies are opt-in given license
> >> restrictions. abi::__cxa_demangle demangling support is added so that
> >> libiberty, from binutils, isn't necessary for C++ demangling.
> >>
> >> Some build/test dependencies are fixed and the code cleaned up.
> > 
> > I'll continue fixing more stuff, like adding NO_LIBTRACEEVENT=1 to
> > things like amazonlinux devel, that still doesn't package libtraceevent,
> 
> FYI I'm currently testing a patch to allow python scripting without
> also requiring libtraceevent

Cool!

- Arnaldo
