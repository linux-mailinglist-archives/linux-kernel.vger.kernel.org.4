Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F466D5B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjDDJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjDDJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:10:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997CE10F8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3BLV145yEOOg3kMKk7nR/SxSLasIzM+jajDrhUwMqq4=; b=jatgy0+7808bPpujJVChAqGktI
        wR8YCUuntcqJZ/EloiJOIL8/axRpuHURd5S26MMBi/qrvhQpzS372/SsaQ6IbZkPFGn+cwbSr3mwQ
        zg6o8EZUGwzgDYvXn9d9D69DohP6lIGHU20AP6nz2Es0J+QxlJQ7oSxxTufE1U8TDwVInhVUBdzQ9
        6bpfa1hfWsHD23+e4w2bUl2nAeiklQLKJw+NbiqVULK87ZmthGqEeANfdIWblcbxZAg088AZXj1Du
        9CgEtn3PpU5yAOmdpKAxfIZD+PvO9FkrTu5JUevUFXHK2sSrumOUTUsMB4fzHbYJKQjBHjSPzqhMa
        zIlBWdQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjcg2-00FDJH-7a; Tue, 04 Apr 2023 09:10:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7A5B300574;
        Tue,  4 Apr 2023 11:10:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E1BD242109FF; Tue,  4 Apr 2023 11:10:05 +0200 (CEST)
Date:   Tue, 4 Apr 2023 11:10:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230404091005.GA285330@hirez.programming.kicks-ass.net>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
 <20230404085749.GA284733@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404085749.GA284733@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:57:49AM +0200, Peter Zijlstra wrote:
> 
> Sorry for being a little late to the party.
> 
> On Mon, Apr 03, 2023 at 02:13:42PM -0400, Mathieu Desnoyers wrote:
> 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 0722859c3647..21466fdc4dc6 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -609,6 +609,14 @@ struct mm_struct {
> >  		 * were being concurrently updated by the updaters.
> >  		 */
> >  		raw_spinlock_t cid_lock;
> > +		/**
> > +		 * @pcpu_cid: Per-cpu current cid.
> > +		 *
> > +		 * Keep track of the currently allocated mm_cid for each cpu.
> > +		 * The per-cpu mm_cid values are serialized by their respective
> > +		 * runqueue locks.
> > +		 */
> > +		int __percpu *pcpu_cid;
> 
> This *might* be a problem... Consider running *many* single threaded
> processes, this could exhaust the limited per-cpu storage (32bit) or use
> excessive memory on large CPU systems.
> 
> Consider having to allocate per-cpu storage on a 4K CPU system while
> only running single threaded processes -- but *LOTS* of them..

Ah, mm_struct::rss_stat[] beat us and set precedent, so not our problem I
suppose :-)
