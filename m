Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3086272B767
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjFLFih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjFLFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C12E57;
        Sun, 11 Jun 2023 22:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13AC761EE1;
        Mon, 12 Jun 2023 05:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE5CC433D2;
        Mon, 12 Jun 2023 05:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686548310;
        bh=9ApKwB4Zg6XXvaKNY8CO0z4kQjNfRCMVQU0ON6cQu4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSRfzLgObH+aSFsiuIG7C+k7LyBXvQdbXhgbb/r3BjSGB9vBdds8Y5SyFrUFyDHkw
         GtLUddVn5T1YEgcuCUNwkSK7pluXLRkUJoNHxEEEWBOvrd7J7B4bfDdqVJeilW/soA
         Mk9i+UFikOESKmuZyJcATKWxQG5v82XQU776h1t8=
Date:   Mon, 12 Jun 2023 07:38:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Rust scatterlist abstractions
Message-ID: <2023061257-unbeaten-dropkick-a25c@gregkh>
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
 <2023061017-usable-bountiful-3f59@gregkh>
 <2023061001-immovable-mongoose-7546@gregkh>
 <37513fcd-b371-cc2f-b7f9-e94b045d8c5c@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37513fcd-b371-cc2f-b7f9-e94b045d8c5c@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:49:51AM +0800, Qingsong Chen wrote:
> On 6/10/23 11:35 PM, Greg KH wrote:
> > On Sat, Jun 10, 2023 at 05:33:47PM +0200, Greg KH wrote:
> > > On Sat, Jun 10, 2023 at 06:49:06PM +0800, Qingsong Chen wrote:
> > > > Hi All!
> > > > 
> > > > This is a version of scatterlist abstractions for Rust drivers.
> > > > 
> > > > Scatterlist is used for efficient management of memory buffers, which is
> > > > essential for many kernel-level operations such as Direct Memory Access
> > > > (DMA) transfers and crypto APIs.
> > > > 
> > > > This patch should be a good start to introduce the crypto APIs for Rust
> > > > drivers and to develop cipher algorithms in Rust later.
> > > 
> > > I thought we were getting rid of the scatter list api for the crypto
> > > drivers, so this shouldn't be needed going forward, right?  Why not just
> > > use the direct apis instead?
> > 
> > See https://lore.kernel.org/r/ZH2hgrV6po9dkxi+@gondor.apana.org.au for
> > the details of that (sorry I forgot the link first time...)
> 
> Thanks for the information. I agree that turning simple buffers into
> sg-bufs is not a good idea. If I were implementing a new cipher
> algorithm, I would definitely follow the `struct cipher_alg`, which
> takes simple `u8 *` pointer as parameter. However, if we'd like to
> utilize some existing ciphers, such as aead, we still need scatterlists
> to construct an `aead_request` for further operations, util changes are
> made to the underlying interface.

Why not make the changes to the C code first, and get those changes
merged, making this patch series not needed at all?

thanks,

greg k-h
