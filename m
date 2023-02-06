Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36468C6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBFTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:19:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C0B2D50
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OBskYcCmJm4DSmxJ+NjrmWZXF5UFVcrYYt7C0YtAI/g=; b=nM8n/bqCKnKqpg+9skte84LWNg
        82gnXXwFMJvHhretSpzuVJerqX6Qyr1+2GYAz9VjjHL4PIIP8htf8QpCOxUAKEaUnQS5uFKz0LRyL
        mub5H9PrS4nur7ZIBhl8y5jksaj8TX+mBgvMJfj5AUcQbheOK0BgdGAcZ0K2s/s2BnPfooR28RRP5
        hVvYSQzMHF6xcWi9Bs0x6yOStJ5f9035ihxbYXWyAJkg1SXSEFNL76Nl+WrCasnDtjOAJQiyeWab2
        9nC7xfF9EEYVvVwrA8/KW0G36qXKMI0eCJBAzQ2UPMD4ivs4KmZOmg+sBkZF7xqrHo1F55/f/mziM
        V7Sd24Qw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP718-00H1HJ-Qd; Mon, 06 Feb 2023 19:19:06 +0000
Date:   Mon, 6 Feb 2023 19:19:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <Y+FSqkDYfhKuBZIe@casper.infradead.org>
References: <20230201195013.881721887@redhat.com>
 <20230201195104.460373427@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201195104.460373427@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:50:16PM -0300, Marcelo Tosatti wrote:
> In preparation to switch vmstat shepherd to flush
> per-CPU counters remotely, use a cmpxchg loop 
> instead of a pair of read/write instructions.

FYI, try_cmpxchg() is preferred to plain cmpxchg() these days.
Apparently it generates better code on x86.

> -				v = pzstats->vm_stat_diff[i];
> -				pzstats->vm_stat_diff[i] = 0;
> +				do {
> +					v = pzstats->vm_stat_diff[i];
> +				} while (cmpxchg(&pzstats->vm_stat_diff[i], v, 0) != v);

I think this would be:

				do {
					v = pzstats->vm_stat_diff[i];
				} while (!try_cmpxchg(&pzstats->vm_stat_diff[i], v, 0));


