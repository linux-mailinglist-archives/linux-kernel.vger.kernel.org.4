Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962D6F7C17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjEEEw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEEEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:52:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00111577
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 21:52:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965d2749e2eso87310066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 21:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683262371; x=1685854371;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=/umBrr/+8MsQ2amP5tN8KzJYTVLE9BeSF+USiLTiVog=;
        b=tXzTcGtDpZ2hv+PrIx2STELgS3prgQCqqvVb9bjdp0jjIkZoB7pzbGyexpe3yLpXBS
         8MjNIMOjVVVAq52cyERA9JJQMN05iCJCwPattPVMipQozKFVzRFXw9I8iDhti6Db50GQ
         5LKMzft9exGLgxNxxFdx0gVTlKW+TA/JRhx2h+mohzfNOszOw5bsBf1vqwW+5a6Y8NEE
         cFg+EEYiRw46eAj/qo2MDJPfHwy2N2ojF+/0j+Jt/Dca/7jac0MCEVzvbi4/DaNB8v1u
         vpImqe7DkJv4ERO7+xjmh/Zcd8ZywLG6t2kB1ie2NxWPyQBO/qcgLBYQE6vkULvRaSkW
         vy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683262371; x=1685854371;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/umBrr/+8MsQ2amP5tN8KzJYTVLE9BeSF+USiLTiVog=;
        b=D5hes/qBCYUrV9kTQ8Z1H0TaiTe8XGEkDVRuMJ3eJJ0TZLPvE88YJZjFXBgWgT3VaN
         ZnhES8WbzD17HzfaFvO/tHNBL9Sgdwhx37Of+6G5Ps8LFi78NJn5sEf+CXFvlwbnhnps
         Jf7ZetLVTfgVSuIT78SLrnWqvEMQbXbWyABDIS2yqdOFpSoCx3Wf50o4i29JMVHqiNiu
         eFJ2vTCkLUaQjq4sI6cCZuu06ouZAx9jOLWj9WaMJAmfUZoz+5pAmqi0RXFlu0ymUI8T
         eHDkikH13P5P6hp2Cp8RMWVneInRl3bW0hSNjQ0YW0xxUhxSBLDG47I8bggTrRZb0HtM
         o3/g==
X-Gm-Message-State: AC+VfDwLjCH3aWi1JDC2egydRwnaOQhe+kMTeVUE3XZaterdApM9rVmQ
        hyaWd3JkrnxuNWUNzJ0zo1vXUA==
X-Google-Smtp-Source: ACHHUZ51HEoFJMqYrm3H2FlYiP0pOtdCPxbARiykKLzb3FndktmpW9+dWEBw37G8enwYGcBU4x7cdA==
X-Received: by 2002:a17:907:a01:b0:94a:5d5c:fe6f with SMTP id bb1-20020a1709070a0100b0094a5d5cfe6fmr13631ejc.47.1683262371189;
        Thu, 04 May 2023 21:52:51 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906948f00b0095f06c0247asm417667ejx.209.2023.05.04.21.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:52:50 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-2-nmi@metaspace.dk>
 <ZFSATHV0gY8raccj@casper.infradead.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 01/11] rust: add radix tree abstraction
Date:   Fri, 05 May 2023 06:49:49 +0200
In-reply-to: <ZFSATHV0gY8raccj@casper.infradead.org>
Message-ID: <87wn1ns7kt.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Wed, May 03, 2023 at 11:06:58AM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> Add abstractions for the C radix_tree. This abstraction allows Rust code to use
>> the radix_tree as a map from `u64` keys to `ForeignOwnable` values.
>
> Please, no.  The XArray interface is the preferred one; the radix tree
> is legacy.  Don't make Rust code use the radix tree.  It has the GFP
> arguments in the wrong place, for one thing.

I have a similar argument to not using xarrray as to not using folios,
see my other response. But the Rust xarray API is in the works [1].

Best regards,
Andreas

[1] https://lore.kernel.org/rust-for-linux/1bb98ef1-727a-45d6-3cf6-39765fe99c5c@asahilina.net/
