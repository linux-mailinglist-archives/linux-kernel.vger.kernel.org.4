Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E825F490F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJDSJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJDSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:09:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A4A455;
        Tue,  4 Oct 2022 11:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1152B81BA7;
        Tue,  4 Oct 2022 18:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E634C433D6;
        Tue,  4 Oct 2022 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664906985;
        bh=Yx/3eZ2i50Vpps7YV4UOTEWJF3t7wFpdjQlcdhRn7hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dm07/f9sNzo+kG4pchLWGw5vvCBmc/IsxdIMQwo5x5rG3SWGY+pzac5ksbV/LgWvi
         CTgrh61lPpAFdTg21t5rW9Wun35A5z1Tkve48VIhNhSAGrEOKO4JrBPzjfcG7gBsbv
         wXOfjWufS91S6Mbw7DjFhilnV0fky4HLz4oJpvfhMcN/RBXIaB0/U/yrmWXhgPPxns
         Z7pIclPwEBNi6UkFVAuf/NEq7Tt4h2Z+AXXcNv1YepcNgHF8E/HFOlf659Fjorvogr
         ewI5S5Gc38IZZscju2ZtMU58KriJHof5gSxhG00tBXayvBH6EoJTplWJdxb1m5Jt/G
         bsaalwgs6nY+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D99194062C; Tue,  4 Oct 2022 15:09:42 -0300 (-03)
Date:   Tue, 4 Oct 2022 15:09:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
Message-ID: <Yzx25psp6o4XDaVs@kernel.org>
References: <20221004021612.325521-1-irogers@google.com>
 <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
 <677c6ec7-2e01-635b-dbfb-fbb9280e5b7c@linux.intel.com>
 <CAP-5=fUFuw-WYj7xVm3WrnggN2NW7pJkznUQ-j3U4fwMB5PdnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUFuw-WYj7xVm3WrnggN2NW7pJkznUQ-j3U4fwMB5PdnA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 04, 2022 at 10:55:56AM -0700, Ian Rogers escreveu:
> On Tue, Oct 4, 2022 at 10:29 AM Andi Kleen <ak@linux.intel.com> wrote:
> > Then if I follow the wiki example here I would expect I need to do

> > $ ./perf stat -M tma_backend_bound_group ~/pmu/pmu-tools/workloads/BC1s

> > Cannot find metric or group `tma_backend_bound_group'

> > but tma_retiring_group doesn't exist. So it seems the methodology isn't
> > fully consistent everywhere? Perhaps the wiki needs to document the
> > supported CPUs and also what part of the hierarchy is supported.
 
> So I think you've not got Arnaldo's branch with the changes applied.
> Unfortunately the instructions around '_group' are only going to apply
> to Linux 6.1.

I just pushed perf/core with Ian's v3 series, please check with that
one.

- Arnaldo
