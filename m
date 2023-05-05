Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E136F7C64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEEF20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjEEF2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:28:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8311623;
        Thu,  4 May 2023 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Ssm+pIX9YCKQZ/c1PpYxJ+8HNAswjWjxy5lFzztysA=; b=fZXbEvrS+vEDWxt4U3MRxo3LHT
        WaxYNHaJAc96HKrfswX/fCumBI7Ru9SSckoMu4booL7ZGDgoAGaL+A31oneasr64X5zzWg6lmrlD3
        iqIZy7KDMUaIaVciDMJnMb459bFN65MaK/YPY05JwyKwCMaRiQKAp19j01qEWgE+daK2NjhFdSm0T
        GQTh9uu4g+LjAYJXE5ZMwfO0s0oFJ1vMuGNCkMeCdxJM4xylu/RZlpCGoqkPcwrA1NiAhMKd5jznQ
        G9a6Vn5GLH06y4RU2kRSkixk3JR8MVVfK7RGnE6Zt9EFaTAgmYpevUmUbPsgelTmCdVME7F5AWd5h
        zzcfAzyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1punzA-00BFoZ-BC; Fri, 05 May 2023 05:28:04 +0000
Date:   Fri, 5 May 2023 06:28:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 01/11] rust: add radix tree abstraction
Message-ID: <ZFST5HAr6IQAhpjx@casper.infradead.org>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-2-nmi@metaspace.dk>
 <ZFSATHV0gY8raccj@casper.infradead.org>
 <87wn1ns7kt.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn1ns7kt.fsf@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 06:49:49AM +0200, Andreas Hindborg wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Wed, May 03, 2023 at 11:06:58AM +0200, Andreas Hindborg wrote:
> >> From: Andreas Hindborg <a.hindborg@samsung.com>
> >> 
> >> Add abstractions for the C radix_tree. This abstraction allows Rust code to use
> >> the radix_tree as a map from `u64` keys to `ForeignOwnable` values.
> >
> > Please, no.  The XArray interface is the preferred one; the radix tree
> > is legacy.  Don't make Rust code use the radix tree.  It has the GFP
> > arguments in the wrong place, for one thing.
> 
> I have a similar argument to not using xarrray as to not using folios,
> see my other response. But the Rust xarray API is in the works [1].

But the radix tree API is simply a different (and worse) API to the
exact same data structure as the XArray.  Using the XArray instead of
the radix tree is still an apples-to-apples comparison.
