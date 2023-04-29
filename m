Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D46F222E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbjD2BuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjD2BuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6CD2D49;
        Fri, 28 Apr 2023 18:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F62063230;
        Sat, 29 Apr 2023 01:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436AEC433EF;
        Sat, 29 Apr 2023 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733004;
        bh=V0xNBDU27uJw/4ysu7P4wSS5Jd542x3OSlYGm6qvVS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhGFgGSQbXEPEsl34VskzKPtLa4l97tyO7W8bQai4TnJinLpnlDbNPp1gDczF9hTw
         ynnctD17+fQDo3Z/qOqXxTT1/52T9UYcRriF3Hw4Y6E4EbzB7WMiEGuvk932i20NG+
         ji7QW3TGpN3O3dzjAJ5H8TuG+dnIRbXVhHKo6dIEUAhvz+mIJVFpVKaTRDaWY6UDlm
         gjqJIcpPn5U6oGpsnZInn9dnVChd3d2ydpNH7PPUIBPbkS1+9AS71jj8MPgIGLoEPP
         ODpj3m2KMIWjdvr2b6zDlwqHh5+QDHpzy09UMhh5+14kFmYUE/g/oYpgpOSiEIi+9N
         mUN06Cjf6o4/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8BA8403B5; Fri, 28 Apr 2023 22:50:01 -0300 (-03)
Date:   Fri, 28 Apr 2023 22:50:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf script: Align kfree_skb tracepoint parameters
Message-ID: <ZEx3yRDPypu0giCo@kernel.org>
References: <20230426104149.14089-1-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426104149.14089-1-sriram.yagnaraman@est.tech>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 26, 2023 at 12:41:49PM +0200, Sriram Yagnaraman escreveu:
> Not sure if the scripts changed in this patch are used, but nevertheless
> here is a patch with a minor bug fix.
> ---
> 
> Include reason parameter that was added in
> commit c504e5c2f964 ("net: skb: introduce kfree_skb_reason()")

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> ---
>  tools/perf/scripts/python/net_dropmonitor.py | 4 ++--
>  tools/perf/scripts/python/netdev-times.py    | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
> index 101059971738..a97e7a6e0940 100755
> --- a/tools/perf/scripts/python/net_dropmonitor.py
> +++ b/tools/perf/scripts/python/net_dropmonitor.py
> @@ -68,9 +68,9 @@ def trace_end():
>  	get_kallsyms_table()
>  	print_drop_table()
>  
> -# called from perf, when it finds a correspoinding event
> +# called from perf, when it finds a corresponding event
>  def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
> -		   skbaddr, location, protocol):
> +		   skbaddr, location, protocol, reason):
>  	slocation = str(location)
>  	try:
>  		drop_log[slocation] = drop_log[slocation] + 1
> diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
> index a0cfc7fe5908..00552eeb7178 100644
> --- a/tools/perf/scripts/python/netdev-times.py
> +++ b/tools/perf/scripts/python/netdev-times.py
> @@ -288,9 +288,9 @@ def net__net_dev_xmit(name, context, cpu, sec, nsec, pid, comm, callchain,
>  	all_event_list.append(event_info)
>  
>  def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
> -			skbaddr, protocol, location):
> +			skbaddr, location, protocol, reason):
>  	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
> -			skbaddr, protocol, location)
> +			skbaddr, location, protocol, reason)
>  	all_event_list.append(event_info)
>  
>  def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain, skbaddr):
> @@ -430,7 +430,7 @@ def handle_net_dev_xmit(event_info):
>  
>  def handle_kfree_skb(event_info):
>  	(name, context, cpu, time, pid, comm,
> -		skbaddr, protocol, location) = event_info
> +		skbaddr, location, protocol, reason) = event_info
>  	for i in range(len(tx_queue_list)):
>  		skb = tx_queue_list[i]
>  		if skb['skbaddr'] == skbaddr:
> -- 
> 2.34.1
> 

-- 

- Arnaldo
