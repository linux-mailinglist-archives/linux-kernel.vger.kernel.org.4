Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4ED6F7234
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEDS7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEDS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:59:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD585247
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:59:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9619095f479so143039866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683226739; x=1685818739;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=5Gnpb8Pit9ODAQa/Dl7YsN552lqqxPpumkkQRUQtbno=;
        b=gFxUXXv74ptlEz90pPEpPK/SWJEikKvKD/UjZFkDR5Y1K+cPsbQK6zF7NXWxsS96pJ
         aY8rVOAwuzAH7feAtshqmAvfAOslz4PvTyiCbT6bSTK6LUkyloV1MXl6oCqKuHBtf9ia
         gZHMdEiiTtJZRjaLV7St4BOeYT9ZF60YUxPkOsio8bDOMCt7Lo43mXCMUJQfvzOILhyL
         xzkyvpibU9t5qYLtFbqyew/ai7jV0ycgnXnjYnuMZ8ae6ltJV46szGZsekHfUXWtpZbA
         B/a9Ldb2QMbBzhGkw+DelMLRT2H3NZ/fV4ZrHFbYVLa3za2eAHjup4gMF0K/eI26wOoc
         sphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226739; x=1685818739;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Gnpb8Pit9ODAQa/Dl7YsN552lqqxPpumkkQRUQtbno=;
        b=EsCj+mmtf/MFkhTmJ6kQRX1ZHqTy0B2xAQk5t5LkNT1fmsevQR2hBiIKOm4vPipmkQ
         gIjNknmxwfpRgIyRT+ugw6yAXc8+5yl0WTf3BsTHUIduLKulBC8xfV275z6eWxUJoDRc
         L+QrD3VpoZkfaZVPlHK/wUAsYWC0obIy9r1BYul8fNJEZR0uTlMED+MeUu+iMu9MCNYN
         NK0X6CTPu1bVBL5qeNkBa8XMyUHiwzvYbJ5pGQr4uFnAYAOXkSBJJBL5fRDYnEpt9YSP
         7iq/wJEtVcaNRUZDKl29JAmQaCOolTWdxpX0NVqt7DMfiZz5yretDB0+Had7ZyaDzvGN
         kV6w==
X-Gm-Message-State: AC+VfDx/bo6z+hlowLxBJN/9a8paiMZwgOLSAy3OHWFGa5F4sebCLjky
        HqT4XdjUNAouIbYKjMMO/TyvuUcwFjymbIqk0r0=
X-Google-Smtp-Source: ACHHUZ7brWhm7CLYDsOZJTQscaZ8hG+0gbAUXFqR5sBWrv85AvVFR38ZNrkAtrPNgicnV1jQ+2tyZA==
X-Received: by 2002:a17:907:2ce2:b0:8aa:a9fe:a3fc with SMTP id hz2-20020a1709072ce200b008aaa9fea3fcmr9416573ejc.8.1683226738785;
        Thu, 04 May 2023 11:58:58 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b009658f5a90d2sm1834778ejl.189.2023.05.04.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:58:58 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Thu, 04 May 2023 20:46:35 +0200
In-reply-to: <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
Message-ID: <87fs8budn1.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bart Van Assche <bvanassche@acm.org> writes:

> On 5/4/23 11:15, Andreas Hindborg wrote:
>> If it is still unclear to you why this effort was started, please do let
>> me know and I shall try to clarify further :)
>
> It seems like I was too polite in my previous email. What I meant is that
> rewriting code is useful if it provides a clear advantage to the users of
> a driver. For null_blk, the users are kernel developers. The code that has
> been posted is the start of a rewrite of the null_blk driver. The benefits
> of this rewrite (making low-level memory errors less likely) do not outweigh
> the risks that this effort will introduce functional or performance regressions.

If this turns in to a full rewrite instead of just a demonstrator, we
will be in the lucky situation that we have the existing C version to
verify performance and functionality against. Unnoticed regressions are
unlikely in this sense.

If we want to have Rust abstractions for the block layer in the kernel
(some people do), then having a simple driver in Rust to regression test
these abstractions with, is good value.

Best regards,
Andreas
