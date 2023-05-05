Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB66F7BAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjEEDwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEEDwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:52:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47D11572;
        Thu,  4 May 2023 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GAX3xUURHmNrkqo48U3apChUo8nPnawKi2Wp+78HVCE=; b=oe8Fd59RI3I0udKddZe67tmtWu
        26Z6CrfGkbKBTyULCmFyjGbF350CBZXF60nLAxLmejJgwjGeOdaXtumY4liwrk8k4sCOQfHC0WWMr
        b3XoA8krZlnoxINZdJa79wPOGg9dKhNYKcYBptxkOuShmxxQNTkGCT7qDdy2ZSZW1sMQ5sJJY9+ix
        vKij9ozHGnjb8MNDk3BC1WtulxGIVYmDuW6AJkc+k0eDyCOTEBSMWlmXTuGKnMCW0cxR83XQx3pD0
        +y5ohfzHT7Hzg1HGAy0n13SelXE98QeNBxU4UcIY7NncRRPDguTcyMmVkdDm+DEwIuxj4xiylss6Z
        6JCa8Pyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pumUF-009eOy-1o;
        Fri, 05 May 2023 03:52:03 +0000
Date:   Thu, 4 May 2023 20:52:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Message-ID: <ZFR9Y12sSRGHvUZK@infradead.org>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 01:02:19PM -0600, Jens Axboe wrote:
> null_blk or not, it's more if we want to go down this path of
> maintaining rust bindings for the block code in general. If the answer
> to that is yes, then doing null_blk seems like a great choice as it's
> not a critical piece of infrastructure. It might even be a good idea to
> be able to run both, for performance purposes, as the bindings or core
> changes.

Yes.  And I'm not in favor of it, especially right now.  There is
so much work we need to do that requires changes all over (e.g.
sorting out the request_queue vs gendisk, and making the bio_vec
folio or even better physical address based), and the last thing I
need is a binding to a another language, one that happens to have
nice features but that also is really ugly.
