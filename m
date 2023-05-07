Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567E26F9CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjEGXbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:31:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E924886BE;
        Sun,  7 May 2023 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BUVBPdJNfX+NvARu2ntIXNIYA3Z9htVV8ADqSWHvC50=; b=n68XH7Z0kRUMjXqTxz0GjNZgA2
        o9gGHcpt9lf7+QviupkjuyWpJehlLY+V49Jl6wNx6GGXr4ysabnRbJ5Bs2hLB4dEwORnPQ29JbnZW
        kjCmris7SBDSp9K+n1oKXKgofxfK1LQ63ShxKPV35r87w7/2pzOp/luzgACPW8xXEcvofRaDo8lis
        rUP3woe7e8xfiz40u6LQnVp1+Eowe9aXxS2r57nJnoPyKuDTF9l3leAPhkdx4o94KyZRWHa/iKLxz
        3eQr1AA3RPBf+nfLCsh1p8kvU5P49r/aI8wNS1KhCiOyt+fXLSIj2K2l0I3jEHpBfH+MOVy8iK2BP
        2KLDrAjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvnqX-00Gpd9-03;
        Sun, 07 May 2023 23:31:17 +0000
Date:   Sun, 7 May 2023 16:31:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Message-ID: <ZFg0xPy0dbd1b0rP@bombadil.infradead.org>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 11:06:57AM +0200, Andreas Hindborg wrote:
> The statistics presented in my previous message [1] show that the C null block
> driver has had a significant amount of memory safety related problems in the
> past. 41% of fixes merged for the C null block driver are fixes for memory
> safety issues. This makes the null block driver a good candidate for rewriting
> in Rust.

Curious, how long does it take to do an analysis like this? Are there efforts
to automate this a bit more? We have efforts to use machine learning to
evaluate stable candidate patches, we probably should be able to qualify
commits as fixing "memory safety", I figure.

Because what I'd love to see is if we can could easily obtain similar
statistics for arbitrary parts of the kernel. The easiest way to break
this down might be by kconfig symbol for instance, and then based on
that gather more information about subsystems.

Then the rationale for considerating adopting rust bindings for certain areas
of the kernel becomes a bit clearer.

I figured some of this work has already been done, but I just haven't seen it
yet.

  Luis
