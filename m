Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B786F7C67
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjEEF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEEF30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3CA5C8;
        Thu,  4 May 2023 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LQA4GbnUf0oYoIkNnpkgzYq4G7BremfMrzKcIO5uhSU=; b=WTkLoGwYgeTEav6wxaGuDNJQE+
        eFWyclwUrUJtrmHDy3DKLjTSKlh2OJWFXvwrDa1/e5Ex8y+NVlnGpktMz5H9E6cPSrAa85ADuPtHs
        Lqxenv+UZG3U2crlGQ2gSmV4VACixDb0luXKoQXG4JT+KopxH4WZ5WlO772CWplY28bBKM9TU/i4j
        F3oiu8ddOtvd48FJfWd4JeMSo/dhTpjCSGTIWJviNbFleqvHBLqKdJrIM650Ag/Nm3GYARpr7Ytu4
        X/DmBMNHko1g7Aq5CLalf3IapC42jOdmNlonr1eh8p1VTpo6DKRA00M7NcEHcN0ph+KyewE2HuflE
        96cFoorQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puo0N-00BFr5-9p; Fri, 05 May 2023 05:29:19 +0000
Date:   Fri, 5 May 2023 06:29:19 +0100
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
Subject: Re: [RFC PATCH 02/11] rust: add `pages` module for handling page
 allocation
Message-ID: <ZFSUL41P5t1NQPes@casper.infradead.org>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-3-nmi@metaspace.dk>
 <ZFSBkFuvJOiz600W@casper.infradead.org>
 <871qjvtmb5.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qjvtmb5.fsf@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 06:42:02AM +0200, Andreas Hindborg wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Wed, May 03, 2023 at 11:06:59AM +0200, Andreas Hindborg wrote:
> >> From: Andreas Hindborg <a.hindborg@samsung.com>
> >> 
> >> This patch adds support for working with pages of order 0. Support for pages
> >> with higher order is deferred. Page allocation flags are fixed in this patch.
> >> Future work might allow the user to specify allocation flags.
> >> 
> >> This patch is a heavily modified version of code available in the rust tree [1],
> >> primarily adding support for multiple page mapping strategies.
> >
> > This also seems misaligned with the direction of Linux development.
> > Folios are the future, pages are legacy.  Please, ask about what's
> > going on before wasting time on the past.
> 
> I see, thanks for the heads up! In this case I wanted to do an
> apples-apples comparison to the C null_blk driver. Since that is using
> kmap I wanted to have that. But let's bind to the folio_* APIs in the
> future, that would make sense.

Well, kmap() is essentially a no-op on 64-bit systems, so it's not
terribly relevant to doing a comparison.
