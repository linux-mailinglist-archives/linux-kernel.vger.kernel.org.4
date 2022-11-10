Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1354624A67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKJTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:14:29 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BF2CE10;
        Thu, 10 Nov 2022 11:14:29 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i131so3290420ybc.9;
        Thu, 10 Nov 2022 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5QX7uHtfmZJBGSD9wRN2efgSKLRw72121V+CgaBiz8=;
        b=Dn0rsxA4mZcz58cbzTH9lg6bXc5PfKPEKP71oiU39d38QwbWdljJRKX/K+4riEKErV
         aQ/TPalbvCgPeJqEeQDmIJJ3NU8aW3wNOYL54ICglMFYm3ylqZ6ePMfdcxsFtBiolKJO
         NHKRXyYTWXs5s7zHxB2EEgcDsamgHmPCfODhd/54lI+MZ8HjunHOmud3cu+16QEouZBQ
         UX1S4L4FhcLWsUTRWSZr3xmH5vqUkzFElLj4pUGZBzlF4a9TaCkCLHshwHAOHY0jleC7
         rl/COzXtS5c7w9UOM2fhDB3SRAQMSf6Pan160yAi9uNXuvQ+CqKQ6oPrf5ZlxzvBRZMN
         dAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5QX7uHtfmZJBGSD9wRN2efgSKLRw72121V+CgaBiz8=;
        b=15IrcJBiKGIxYj2xA7ZGeNNuprYS4q3nOaJxFwurdd2zWyhlYdCecSxnS1tSwHW9XO
         R1vZjJ4L2B06kw9bd38NNY5xYypw0in7ALXDyTMzYfG27UFrSeT+xcP3bJXtmwVH/Ei6
         QoqmobloTCHVKBXycEFiwd0NxbCyPKIUvljq7ID+Kf8FlagKYFrIAYYH9SjXGpSNtSQQ
         WdGJkZWrterQFpv8mV62ZoHrf08zjXJS3wJpUUq4e5OFjC2P7phhomrzXNm8GIHuql9g
         oQK99VQJ975TzO7Bt1lSD2VxLEr3d1zNN2Rsgg6I1YZIn1QW5IVJXPIIFmyY4y+pZVbg
         cx3w==
X-Gm-Message-State: ACrzQf3h2PoMZcKQxMPaKgHpIT4juJBs0gxbwjD/IQ2wXjujRfQjxHhB
        3mYhH8uxJSWcv5xnBird30/OW5OSseqOf9Ams4LQV+WKeSQ=
X-Google-Smtp-Source: AMsMyM6vpNwmXQB6URQ88jmewQp6LACCUdpXdONZgdbve2oZHi8cBcOo2qirgHGVTFWGHi7XeXb80pgjl/OTZPykb04=
X-Received: by 2002:a25:76cb:0:b0:6d1:698e:31e5 with SMTP id
 r194-20020a2576cb000000b006d1698e31e5mr37654398ybc.328.1668107668358; Thu, 10
 Nov 2022 11:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-24-ojeda@kernel.org>
 <Y208lVCN3VweD5iI@Boquns-Mac-mini.local>
In-Reply-To: <Y208lVCN3VweD5iI@Boquns-Mac-mini.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Nov 2022 20:14:17 +0100
Message-ID: <CANiq72kR3YZv65NYPx+H57XO7T85kioMWMZajRnk7f+ru-3x+w@mail.gmail.com>
Subject: Re: [PATCH v1 23/28] rust: std_vendor: add `dbg!` macro based on
 `std`'s one
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Niklas Mohrin <dev@niklasmohrin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 7:02 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> and I'm almost convinced ;-) Better add the gist of discussion into
> comment/document/commit log? Users need to know when to use `dbg!` and
> when to use `pr_debug!`, right?

The docs talk about it a bit:

    +/// Note that the macro is intended as a debugging tool and therefore you
    +/// should avoid having uses of it in version control for long periods
    +/// (other than in tests and similar).

That is the original wording from the standard library, but we can
definitely make the rules more concrete on our end with something
like:

    `dbg!` is intended as a temporary debugging tool to be used during
    development. Therefore, avoid committing `dbg!` macro invocations
    into the kernel tree.

    For debug output that is intended to be kept, use `pr_debug!` and
    similar facilities instead.

Cheers,
Miguel
