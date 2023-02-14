Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58F669688D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBNP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjBNP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:57:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9029E37
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HyVFMAuwbcfMrpUqEGrGZQNJ9VPzga/RX8IG6Gc7BUk=; b=eCvYQHVl1O4S8sVirMIy7Bd/ex
        FDbWsV686v3H6dAGvc00hKs5aRwvIF+iy3GDYCSdJ9AjrPre9mZrDKC3WPxz/lAuNCMkyiKXu8Ni1
        DmLgZsSvws+EtQaqbiDiUbg1FrWLzmvZfXlxXmhZ9UA2IWa1Wh/z/22gxDwA3FLT6Xsh9Jv47Siev
        gySm3kgSi2XwGr8ivJpxs6USdHxUnkxeYT4jZ6uiOMyyzjGaZ1wWkra4EnTD8H8eI2P9MHxEy8ozV
        8XldW4zGF4H6MoFJ1c3/756B4xdabwPi5cQZSE2ypfE+yfVDge9NGVIi/9wThpMNgTF2P+yl906rA
        5/YFpdBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRxfk-006cUG-C3; Tue, 14 Feb 2023 15:56:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E3B2300B52;
        Tue, 14 Feb 2023 11:43:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F34EC23BDB63F; Tue, 14 Feb 2023 11:43:33 +0100 (CET)
Date:   Tue, 14 Feb 2023 11:43:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
Message-ID: <Y+tl1ZJiWuMeKCnB@hirez.programming.kicks-ass.net>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com>
 <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com>
 <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 02:22:39PM -0800, John Stultz wrote:
> The interpoloation is pretty easy to do:
> 
> do {
>     start= readtsc();
>     clock_gett(CLOCK_MONOTONIC_RAW, &ts);
>     end = readtsc();
>     delta = end-start;
> } while (delta  > THRESHOLD)   // make sure the reads were not preempted
> mid = start + (delta +(delta/2))/2; //round-closest
> 
> and be able to get you a fairly close matching of TSC to
> CLOCK_MONOTONIC_RAW value.
> 
> Once you have that mapping you can take a few samples and establish
> the linear function.

Right, this is how we do the TSC calibration in the first place, and if
NTP can achieve high correctness over a network, then surely we can do
better locally.

That is, this scheme should work for all CLOCKs, not only MONOTONIC_RAW.
