Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC06F89AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjEETnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjEETmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA53596;
        Fri,  5 May 2023 12:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB406369C;
        Fri,  5 May 2023 19:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60754C433D2;
        Fri,  5 May 2023 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683315767;
        bh=It0TtiZb//uROZ5cWhVNKXLlllsZ45sz2CJA0QNwm5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocANPOvGTUU8Hm74Y1ZCs7l4Is0x8LtFspz/fo2ycoYkvVFzUiamadDeUrhtP/MpM
         T0uP4W52yM90HXYijmM1NOFFjDjokmp2gwSqs9C9RPrfDJKhXQ7mcXkZZQMMqSwhTp
         seMaThWDLLlVO3EmAwihgJzP88o6lthBt1THhyQw4ltq4Vlor4a0o7fzvDWW8hSRYq
         eYareRU64HfMX42y/E/exm0rwgyA3F8Ut4bEkSIzNN/AKpYFYo09vxuzv1g1xMsjMi
         jESdOiAFG6BNfDOr6nnxAcui8HqKNAtIOwnBCLAg1d4iJARXbwZHei+z0UougmGuVw
         BzYwQlV0lkyVw==
Date:   Fri, 5 May 2023 13:42:42 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
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
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Message-ID: <ZFVcMtRFoaEK/PqY@kbusch-mbp.dhcp.thefacebook.com>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com>
 <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
 <80ed2c0e-54db-777a-175b-1aa3ff776724@kernel.dk>
 <CANiq72=3kGRy-3Lq5oxUEhu5d-377QrhuzhvoKRL+_QvbnJE7A@mail.gmail.com>
 <ZFT1mOQq0YllZl7V@Boquns-Mac-mini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFT1mOQq0YllZl7V@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 05:24:56AM -0700, Boqun Feng wrote:
> 
> The Rust bindings are actually the way of communication between
> subsystem mantainers and Rust driver writers, and can help reduce the
> amount of work: You can have the abstraction the way you like.

We don't have stable APIs or structures here, so let's be clear-eyed
about the maintenance burden these bindings create for linux-block
contributors. Not a hard "no" from me, but this isn't something to
handwave over.
