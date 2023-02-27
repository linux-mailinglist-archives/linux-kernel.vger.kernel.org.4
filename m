Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADA6A3F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjB0KGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjB0KGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:06:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE614986
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+t0UQb+OuF/ea7hjpluYOHI5k4fqZTVVQzf1SC2bteU=; b=PJaYD/nTBbDXwpsANs1mCl8ZxZ
        z1pfi0i40murZWh+B7js0o+DWmEk5Yj8bUGd5kF8KSD7aXP7h7QwlTbt2+bR+fU6/b4U1tciCZf/n
        q/M406RgEg6GvODxJ/DMtHjZ85IxvtbBj+tzwWuBIE3Nl1qMLcYKndvoF6Li2XNM+LTiPNKgkUPd6
        NioNCKns8jTqMmWKXtJUgNM4HN0Xg1PYZ1ZTEYIN+FFi/4L7QA7xtFhlVFs1rAram6d6CP0TlOXiu
        oIo0Z3dPWu5FH7n3+5yI5wb1IWTlLgukKt/B4b3LxzcbpraVIRW59ApJBpOP+jfkna7XRFUHYv8XD
        4fl7emOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWaOg-00ECOz-2W;
        Mon, 27 Feb 2023 10:06:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A536330030B;
        Mon, 27 Feb 2023 11:06:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E429209F7545; Mon, 27 Feb 2023 11:06:16 +0100 (CET)
Date:   Mon, 27 Feb 2023 11:06:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Message-ID: <Y/yAmDj6tQVfOdqK@hirez.programming.kicks-ass.net>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
 <048964e8-179f-de7b-1190-831779d9911f@amd.com>
 <ccba1a65-fe4f-89d5-a32b-2efba30a1350@amd.com>
 <c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:10:41PM +0530, Raghavendra K T wrote:
> In summary: I do see that access to VMAs from disjoint sets is not fully
>  fair, But on the other hand it is not very bad too. There is definitely
> some scope or possibility to explore/improve fairness in this area
> further.

Ok, might be good to summarize some of this in a comment near here, so
that readers are aware of the caveat of this code.

> PS: I have also tested above applying V3 patch (which incorporates your
> suggestions), have not seen much deviation in observation with patch.

I'll see if I can find it in this dumpester fire I call inbox :-)
