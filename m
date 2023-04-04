Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A76D5B52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjDDI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjDDI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:57:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711C187
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6LazMVRn6NnFVN/DGpqyJKNdqqZ1WB0zgjGpnPrQ73U=; b=uhtWX++QeGxiq+IBIFvaGjuBAv
        LYW5viqH5UGIfKpG35gShVF4+na5mR8k+0UxRUUxNKsn4UDfNe2lR41i0vXyzArWagxXJ4K0MWKfI
        3FuggorIKtetMYkUQ36ezREuWiOlpnLT4XAkFD1gvrR5QAg489cSvclfqSX7s3OtDegpWmqhCapz7
        qXhTa8KIMlADC+h1+Xyst+DorrpOgK7tTti6Z1pxeFCvRzxJQ26nCVzIuasSYJ1xYWF8U7rudjCLJ
        tJjB2V4gOd3j0Ts0KjWeiK/pBafTVjJSQC5ZUU5GguYaY7AjfhyMppczHYDnDKYtC1FlkKk58NEfJ
        GTDrsoRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjcUB-00FCs2-7X; Tue, 04 Apr 2023 08:57:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24CB630003A;
        Tue,  4 Apr 2023 10:57:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAF3D2B6E1F52; Tue,  4 Apr 2023 10:57:49 +0200 (CEST)
Date:   Tue, 4 Apr 2023 10:57:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230404085749.GA284733@hirez.programming.kicks-ass.net>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for being a little late to the party.

On Mon, Apr 03, 2023 at 02:13:42PM -0400, Mathieu Desnoyers wrote:

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0722859c3647..21466fdc4dc6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -609,6 +609,14 @@ struct mm_struct {
>  		 * were being concurrently updated by the updaters.
>  		 */
>  		raw_spinlock_t cid_lock;
> +		/**
> +		 * @pcpu_cid: Per-cpu current cid.
> +		 *
> +		 * Keep track of the currently allocated mm_cid for each cpu.
> +		 * The per-cpu mm_cid values are serialized by their respective
> +		 * runqueue locks.
> +		 */
> +		int __percpu *pcpu_cid;

This *might* be a problem... Consider running *many* single threaded
processes, this could exhaust the limited per-cpu storage (32bit) or use
excessive memory on large CPU systems.

Consider having to allocate per-cpu storage on a 4K CPU system while
only running single threaded processes -- but *LOTS* of them..


