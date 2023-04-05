Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C76D893C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjDEVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjDEVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:07:04 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FB6A47
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:06:55 -0700 (PDT)
Date:   Wed, 05 Apr 2023 21:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680728813; x=1680988013;
        bh=vuvbMSg3XgGBVCOc1uYn3lg/ER9MH4uDgroxzs+1l8E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HgxHNdKWBNVinVaxjMslfvKpcrbRvwG6Qgj/Kdzkgr3D1lO/PcwOm8I4VKBmjA+mL
         PCbM/1pl6emJRynHM1aSO9Fe7H9I8R0VrIRfhhgSlhj1yV87OdoihW3+IqzzufmDpy
         NNaQUZvBdYf6iU9ZFSff+r2K6XAtA60LESVxUxVwSqvRq5pRiicxilGXQhsiLr6+TO
         N7pWKTjBRzBbmMfnX5ySwJFqsH2D8e1dzmRl1HIpNhbTR8qUUEYNorblrle9xI27yX
         oC4NliS72Hlx287Umvkeud/Jr7p1rQGhZEgOrGCsHFoJIuo7Pmy30xbwx/owwEkqKP
         0Cr/0EIFqPyvA==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 00/15] Rust pin-init API for pinned initialization of structs
Message-ID: <96b35c6c-6fd1-465d-fb46-aa48c73ae465@protonmail.com>
In-Reply-To: <ZC3h3q+56gM8pKOX@boqun-archlinux>
References: <20230405193445.745024-1-y86-dev@protonmail.com> <ZC3h3q+56gM8pKOX@boqun-archlinux>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.23 23:02, Boqun Feng wrote:
> On Wed, Apr 05, 2023 at 07:35:30PM +0000, Benno Lossin wrote:
>> Changelog:
>> v5 -> v6:
>> - Change `pinned_drop` macro to allow `mut self` in the signature.
>> - Change statement fragment to tt fragemnt in `pinned_drop` to prevent
>>    parsing errors.
>> - Move evaluation of the value in `stack_pin_init!`/`stack_try_pin_init!=
`
>>    to the beginning.
>
> Could you elaborate why? To make sure the $val evaluation happens
> unconditionally?

This is done to allow `stack_pin_init!(let value =3D value);` i.e. naming
the variable the same as the expression that is evaluated.

--
Cheers,
Benno

>> - Move setting uninitialized flag in front of dropping the value in
>>    `StackInit::init`.
>> - Remove `Unpin` requirement on `zeroed()`.
>> - Add note about `Pointee` to the `Zeroable` impl on raw pointers.
>>
>
> Regards,
> Boqun

