Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D746B64E37D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLOVrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLOVrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:47:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043EB2D1E6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ericO2JP21XAYQtxMKC0PuaSNwuk659UUj4IZKm+oic=; b=a+5wtMegakJuXcj9xMnG+QwIHp
        fvFe0urh1FqzJjdtfIzvQSmMEZd9ADAMeg46UpRtiLBWoUxBpMBfmsentD7dXJgVzoMff2E68AizQ
        I/KFoDOouZsZtTpr8/nvJFzeFZBI6H8NnsAd+pGzSsyr3cXcWev+wIT4hds1cv1q3ABL+Ciq5nYdf
        9gT0IW07TrAOBV84oz5zW8BpcV0FF3tcLX1mZd9xsQC/EVotxfxtCykuMoq6xlf/UY2g6DFZTti84
        KHiqyKLmaXZ5ly5csYpGVg/cMELi1qCsE0/Ka8JhCrka9ijcxlBS/S0oXeNHFtzZdbksO9LIulyHQ
        lBR1edkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w4M-00Emdp-Ee; Thu, 15 Dec 2022 21:47:10 +0000
Date:   Thu, 15 Dec 2022 21:47:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nico Pache <npache@redhat.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, gerald.schaefer@linux.ibm.com,
        Waiman Long <llong@redhat.com>
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in
 set_compound_order
Message-ID: <Y5uV3sS/nb+J+Akx@casper.infradead.org>
References: <20221213234505.173468-1-npache@redhat.com>
 <Y5oCD0gFV+Cq1JqJ@casper.infradead.org>
 <CAA1CXcA2dGeG2tzc+-OZ77eMVpnSN2SKkdtz9LqpLPywhJMOwA@mail.gmail.com>
 <CAA1CXcCboCaVNgLv56Pc9ju95Yc9cK4XHCQObGPA_fbVZGxtTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1CXcCboCaVNgLv56Pc9ju95Yc9cK4XHCQObGPA_fbVZGxtTg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 02:38:28PM -0700, Nico Pache wrote:
> To expand a little more on the analysis:
> I computed the latency/throughput between <+24> and <+27> using
> intel's manual (APPENDIX D):
> 
> The bitmath solutions shows a total latency of 2.5 with a Throughput of 0.5.
> The branch solution show a total latency of 4 and throughput of 1.5.
> 
> Given this is not a tight loop, and the next instruction is requiring
> the data computed, better (lower) latency is the more ideal situation.
> 
> Just wanted to add that little piece :)

I appreciate how hard you're working on this, but it really is straining
at gnats ;-)  For a modern cpu, the most important thing is cache misses
and avoiding dirtying cachelines.  Cycle counting isn't that important
when an L3 cache miss takes 2000 (or more) cycles.
