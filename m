Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA26E2116
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjDNKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:39:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C7E55
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rebm7+CKRMo/BpUkgmXudGTY0jKExX44QwLHd/QW7dw=; b=glt2g541FioIt8pno0lGm8H+Me
        iZhbDH3vYL6VJfCnAqp+dkiD0Nx6BoxAvJV3yGJcmXesmNAP9kAWy0PvUaqqgGgy2HL6A9QKx0fUk
        4EwPlZi3mHIkV8avCqV9cLddAvhb8HpTtihvyQf7MXaNxdVxaB/U/0gRnB8nbK/fdZIw+nFyBTmjg
        uqS/hkEI4+LI3iwhe9Baw0Zp7QhxIoF2RDA/8sftQJA1QkGKCDSM0Cq/Ue+059YThUWpkgtZDRWGa
        1s0ChHRI4gL7MxNrrcAnLSXpKMtZq7GS2Loox7xaFTYKiOrkNh1W75S41CWi4w9AbIayy8+urmB6J
        tFN1bljA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnGp7-008g0l-7p; Fri, 14 Apr 2023 10:38:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94C7430002F;
        Fri, 14 Apr 2023 12:38:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CBD4265F26D5; Fri, 14 Apr 2023 12:38:32 +0200 (CEST)
Date:   Fri, 14 Apr 2023 12:38:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230414103832.GD83892@hirez.programming.kicks-ass.net>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410204352.1098067-2-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 01:43:48PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> With the cycle time information between branches, stalls can be easily
> observed. But it's difficult to explain what causes the long delay.
> 
> Add a new field to collect the occurrences of events since the last
> branch entry, which can be used to provide some causality information
> for the cycle time values currently recorded in branches.
> 
> Add a new branch sample type to indicate whether include occurrences of
> events in branch info.
> 
> Only support up to 4 events with saturating at value 3.
> In the current kernel, the events are ordered by either the counter
> index or the enabling sequence. But none of the order information is
> available to the user space tool.
> Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, and generic
> support to dump the event IDs of the branch events.
> Add a helper function to detect the branch event flag.
> These will be used in the following patch.

I'm having trouble reverse engineering this. Can you more coherently
explain this feature and how you've implemented it?
