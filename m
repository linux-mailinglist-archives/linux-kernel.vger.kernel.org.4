Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8014F603769
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJSBOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSBOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:14:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BFAB7FD;
        Tue, 18 Oct 2022 18:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8D7AB821C4;
        Wed, 19 Oct 2022 01:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C47C43470;
        Wed, 19 Oct 2022 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666142070;
        bh=/x/Nbs+MOxR5ewlwjl0kxPzPeO4VdkQiX3wZPLpziiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDhp3KoOWOnlu6uF2tJ9c/NQrSkD/Rb3QTVyax06ft4W+wlfKCh21m+zsmbcOUU/9
         2JOoxARmsgDALTezhtK6+VJLxCuetaIY1DZy4xLm9HiXfZ3QgfAN5Zzvsioa4MNgTX
         XWw3SMR5Af359qpxKygS9KPlkUjxdtHRsd2Pn72GyybM3rvySIlDCnebJwjffTiipm
         lvI9hrTIp9mdgX4qh5SKlmkOQ6ALEchI4cWt0zqRDU5EwtqjKY4ohAttanEa/EszUK
         q2VhdtJNBeqsRP7tjYnbEY9BuQBJUoO51Wk49EdAHBEvz1WjsUo8WQcYc1LJxLyhm1
         AHntknizZG6pg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A957B40B44; Tue, 18 Oct 2022 16:18:53 -0300 (-03)
Date:   Tue, 18 Oct 2022 16:18:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] perf report: Skip symbols for idle symbols
Message-ID: <Y078HUZ5FgZ/ZyaU@kernel.org>
References: <20220608055146.1446-1-zajec5@gmail.com>
 <f7e79f3a-be97-334b-84f2-76da0981e991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7e79f3a-be97-334b-84f2-76da0981e991@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 18, 2022 at 02:54:07PM +0200, Rafał Miłecki escreveu:
> On 8.06.2022 07:51, Rafał Miłecki wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > Displaying idle symbols is rather useless and makes reviewing "real"
> > symbols harder. perf top already skips them so perf report should
> > probably do the same.
> > 
> > BEFORE
> > 
> > # Overhead  Command          Shared Object          Symbol
> > # ........  ...............  .....................  ...................................
> > #
> >      75.04%  swapper          [kernel.kallsyms]      [k] arch_cpu_idle
> >       1.05%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___inval_dcache_area
> >       0.78%  ksoftirqd/0      [kernel.kallsyms]      [k] __netif_receive_skb_core
> >       0.75%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_table_lookup
> >       0.58%  ksoftirqd/0      [kernel.kallsyms]      [k] __dev_queue_xmit
> >       0.56%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_start_xmit
> >       0.55%  ksoftirqd/0      [kernel.kallsyms]      [k] __skb_flow_dissect
> >       0.53%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___clean_dcache_area_poc
> > 
> > AFTER
> > 
> > # Overhead  Command          Shared Object          Symbol
> > # ........  ...............  .....................  ...................................
> > #
> >       4.21%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___inval_dcache_area
> >       3.13%  ksoftirqd/0      [kernel.kallsyms]      [k] __netif_receive_skb_core
> >       3.01%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_table_lookup
> >       2.32%  ksoftirqd/0      [kernel.kallsyms]      [k] __dev_queue_xmit
> >       2.23%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_start_xmit
> >       2.21%  ksoftirqd/0      [kernel.kallsyms]      [k] __skb_flow_dissect
> >       2.13%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___clean_dcache_area_poc
> >       2.00%  ksoftirqd/0      [kernel.kallsyms]      [k] eth_type_trans
> >       1.86%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_poll_rx
> >       1.73%  ksoftirqd/0      [kernel.kallsyms]      [k] __local_bh_enable_ip
> >       1.63%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_rules_lookup
> >       1.61%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_poll_tx
> >       (...)
> > 
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> Ping? Does it look OK to you?

Its ok, but I wonder if after all those years changing this default
won't confuse users, so perhaps adding a 'I' hotkey to toggle showing
idle symbols?

Additionally having a 'perf config report.hide_idle=true' (for 'perf
top' as well), so that users can just switch to their liking?

Also add an entry to tools/perf/Documentation/tips.txt so that it
appears from time to time on the last line on the screen?

- Arnaldo
