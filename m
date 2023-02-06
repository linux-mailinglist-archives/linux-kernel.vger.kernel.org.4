Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B1668B8DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBFJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:42:53 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9B76AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1675676566; bh=HZzQ2iIvouqD7dUVVUrUzA9tkZZK0Oxxi7YTpggp7Uc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jWr3N/DCjBdsWN/UIiQpuOGxzTsU2kBYG8UYdvSRK+v+bDUAwRsq/I0KDRhuD1wvY
         QaS5265+QjBwrrrWLCpK5LDwNWCNvr5tCcjsz83PqlnZ+31/P73Py6CwTBTT5LdsT7
         bmB78f6c9DMHWYVvqU4Y6g+AvnJvHqeoHIGhs4LpBWi02NmA3zyGqLf1nCmnxSIng4
         4kpgAHKBaI9mTZR8xnHiMgROEi+Yxv96BeXRZvmhmp+/1TRhwyz5IpMurqSYSwf5bk
         0l+ThQodj26bTgl/Tc3CgEOgX0Fg+MbKPhol8d19B0zqj0RMq/4T+WJVexiTSANjIE
         31Yx45FnxyIUQ==
Received: by gentwo.de (Postfix, from userid 1001)
        id 16173B00159; Mon,  6 Feb 2023 10:42:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 14D5DB00100;
        Mon,  6 Feb 2023 10:42:46 +0100 (CET)
Date:   Mon, 6 Feb 2023 10:42:46 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
In-Reply-To: <Y91X3hA5i7FQJwEo@tpad>
Message-ID: <47a289f0-ae96-e0e6-c579-70ec61fff384@gentwo.de>
References: <20230201195013.881721887@redhat.com> <20230201195104.460373427@redhat.com> <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de> <Y9vcpO5Dh2G3Y6ib@tpad> <5615572-974e-74cc-6c34-1de618b777cf@gentwo.de> <Y91X3hA5i7FQJwEo@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023, Marcelo Tosatti wrote:

> > Isnt there some lock/serializtion to stall the kernel until you are done?
>
> Not that i know of. Anyway, an additional datapoint is:
>
> "Software defined PLC"
> (https://www.redhat.com/en/blog/software-defined-programmable-logic-controller-introduction),
> applications
> can perform system calls in their time sensitive loop.
>
> One example of an opensource software is OpenPLC.
>
> One would like to avoid interruptions for those cases as well.

Well allowing sytem calls during "time sensitiveness" implies
it is not that sensitive to vmstat updates which have a smaller impact
than system calls.

Unless we are talking about virtual system calls like gettimeofday or
clock_gettime. These do not enter the kernel if configured correctly.
