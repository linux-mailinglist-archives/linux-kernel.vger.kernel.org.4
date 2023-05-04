Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C946F7225
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjEDSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF159FB;
        Thu,  4 May 2023 11:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14136361C;
        Thu,  4 May 2023 18:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22E1C433D2;
        Thu,  4 May 2023 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683226357;
        bh=6Yh0/0aM/AqOO+dqL35sXvkTa/tsPV21goxWcKkSeIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPgmmiY9J7ZjUXMN4xS6eBWkojLGjvlXI1zwNcxidNYGKcPyRBxykUjQTxDPCLvA+
         aXzBaJ8oQTN8TDd59iHcO2NO2iT7c8Lr4hdVgwOaySNOTkEPdzw/t5TTgf0q5iAVCg
         fyNroR7U3QvcCk7KU5h9yWHw2c2tPC0VPVL0F2sq9Gl2jlHQ+Gr2HAZG5fxUEHPH4+
         Gsl9K64dICfWAhqzAGDYRmE8j4oXDrgZWYazvjF6Qk91Mnq20wSTjwPaYapw1APJ9a
         GRJ5AoTX0HBxZzsDbgmGhG26vy2sr6x8LH3h2atAouWXLXbIch25i8bC0RTzCu1kqJ
         lS6ze7ud18msg==
Date:   Thu, 4 May 2023 12:52:33 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 11:36:01AM -0700, Bart Van Assche wrote:
> On 5/4/23 11:15, Andreas Hindborg wrote:
> > If it is still unclear to you why this effort was started, please do let
> > me know and I shall try to clarify further :)
> 
> It seems like I was too polite in my previous email. What I meant is that
> rewriting code is useful if it provides a clear advantage to the users of
> a driver. For null_blk, the users are kernel developers. The code that has
> been posted is the start of a rewrite of the null_blk driver. The benefits
> of this rewrite (making low-level memory errors less likely) do not outweigh
> the risks that this effort will introduce functional or performance regressions.

Instead of replacing, would co-existing be okay? Of course as long as
there's no requirement to maintain feature parity between the two.
Actually, just call it "rust_blk" and declare it has no relationship to
null_blk, despite their functional similarities: it's a developer
reference implementation for a rust block driver.
