Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42F6249BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKJSlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJSll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:41:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE401B7A2;
        Thu, 10 Nov 2022 10:41:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1ED2B822E1;
        Thu, 10 Nov 2022 18:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A29C43470;
        Thu, 10 Nov 2022 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668105697;
        bh=w+3Z5Dhns/Uu8l1HGoAeP1Sn18iEhcU51UQlCIcNLhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyvETfOqRP+yEbZRIZGikbsTUFib+Yfbz6vcgLTX59dGlfhEwFDFLjDn0S2UP+npx
         /Xbh2gsAPkSAK/BGJg+8vRt2fU7f4u52aeXQCOfElpGmyevFwX+1VnffdhSMJP/BPX
         oMRKxQBDmDwloTRQUJo9Pdu1q/nG3Mu5ueLQT/tEylbbN0lmZGOtoMNR6m5Bl3Lkz/
         u62IIBX6CxL6+G5i6H3OTEY/O24WsCaowwPT639OHUtsu8UDh9GSL8XS/dqtbXqd7z
         xh0zRN+40XOXQahv/++s+n2TA9E6nPI48FfRo6f34k/8P+KIzkUbASuI0Kocca0qpG
         QuiOPtZnDoFCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BFB54034E; Thu, 10 Nov 2022 15:41:32 -0300 (-03)
Date:   Thu, 10 Nov 2022 15:41:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, al.grant@arm.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf vendor events: Add Arm Neoverse V2 PMU events
Message-ID: <Y21F3NAtArLjYpM1@kernel.org>
References: <20221020134512.1345013-1-james.clark@arm.com>
 <bf335af0-6340-333d-4b04-5bdc39a75f35@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf335af0-6340-333d-4b04-5bdc39a75f35@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 10, 2022 at 10:52:44AM +0000, Nick Forrington escreveu:
> On 20/10/2022 14:45, James Clark wrote:
> > Rename the neoverse-n2 folder to make it clear that it includes V2, and
> > add V2 to mapfile.csv. V2 has the same events as N2, visible by running
> > the following command in the ARM-software/data github repo [1]:
> > 
> >    diff pmu/neoverse-v2.json pmu/neoverse-n2.json | grep code
> > 
> > Testing:
> > 
> >    $ perf test pmu
> > 
> >    10: PMU events                                           :
> >    10.1: PMU event table sanity                             : Ok
> >    10.2: PMU event map aliases                              : Ok
> >    10.3: Parsing of PMU event table metrics                 : Ok
> >    10.4: Parsing of PMU event table metrics with fake PMUs  : Ok
> > 
> > [1]: https://github.com/ARM-software/data
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> Reviewed-by: Nick Forrington <nick.forrington@arm.com>

Thanks, applied.

- Arnaldo

