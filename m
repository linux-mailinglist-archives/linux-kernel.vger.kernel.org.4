Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B312B72AC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjFJPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjFJPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE91FF3;
        Sat, 10 Jun 2023 08:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C8660C5A;
        Sat, 10 Jun 2023 15:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25526C433D2;
        Sat, 10 Jun 2023 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686411230;
        bh=XGqCup1lucfwQ85Mpip2O/TgSxwVwDB22fTAfGro6/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ds4VM3VxjKRwVx4PGOLxGgreNg7v8heEdk1AF6PfRqVTOAi2cymcdRFlGQc8+fIqw
         2m1MhtmKMeotQZZCG7ehUhS+8KK6EmPFu5ubk5DVCTAQiEzG7NWMqMLfttSmhlGt3e
         MoV6Ut6OCQsJXUvTr/AgOqt3EUn+hc4+HStLVFWE=
Date:   Sat, 10 Jun 2023 17:33:47 +0200
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
Message-ID: <2023061017-usable-bountiful-3f59@gregkh>
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 06:49:06PM +0800, Qingsong Chen wrote:
> Hi All!
> 
> This is a version of scatterlist abstractions for Rust drivers.
> 
> Scatterlist is used for efficient management of memory buffers, which is
> essential for many kernel-level operations such as Direct Memory Access
> (DMA) transfers and crypto APIs.
> 
> This patch should be a good start to introduce the crypto APIs for Rust
> drivers and to develop cipher algorithms in Rust later.

I thought we were getting rid of the scatter list api for the crypto
drivers, so this shouldn't be needed going forward, right?  Why not just
use the direct apis instead?

And what crypto protocols are needed to be done in rust that we are
currently missing in the C versions?

thanks,

greg k-h
