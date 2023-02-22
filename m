Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2A69F488
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBVM3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:29:07 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DEDBE9;
        Wed, 22 Feb 2023 04:29:06 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536bbef1c5eso105830877b3.9;
        Wed, 22 Feb 2023 04:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WATwXUE02YF5fbDUCE81eH8TPnQ+aGb50aBo4hFIxNk=;
        b=QiplMiJKUkp/TB3unYMhsHDTD/GjvtyQDJwG9g4AB9HorSIemK9MXheuD28uhMh8Ks
         AMPGBsz9r8OkKQh0SqQs4teBvRVkJnFdZRcNcE/7RkOrGT2eJtRI7iXwbQWcpFO6gW/3
         3LPXCeH+qvFquFojltdc4jBWqFvp84lDKoxUsxh82a/aGX3NNKl4i8MMVd5Eer6waXiF
         MeNhluqpC4vi+0DIMGAINO7VlqHX6IYCxMJ1xlt6yh0NDh3ndRbtN7H17DDCaWQkmZ/u
         kdgjhpo22NH4PunI5qk82PmqpzCp3bhCe0iUi3OWS6sIhHr43KNfSRQM41FWJGTRg+L7
         dZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WATwXUE02YF5fbDUCE81eH8TPnQ+aGb50aBo4hFIxNk=;
        b=08ZqtWSWYCyWBGvflt+XxZj7P+mgGlj5rbnM+QxYmP1TzeUDgs6NkFxZ3QdeislLbT
         z139Li689X71xeMsqgNZfFOjGNgwxa+TKOWFaTr9wS283ob25XoyX2bNKz2XHkDzn9Q3
         1KNoLBF8qhlh6mGwgre77XnRZo7XdKzacV5ZrPb9vNlB3DFXr+nZ6vhY1evgyPebivc3
         iM2zNt3UqfDbFAxTG6cCqN8V1+Sjj2pNQqyqsPNDp5/XpVOaD/M9ek7S/Xmk2oaais1s
         AyzxpM0Qr7H9Lmo6xO2/YQOCUxyDjDzIlK8qzLd3WgHhj+XyoSuSxserIG1SUSdftQk7
         raTA==
X-Gm-Message-State: AO0yUKWHDY0Kn9VBDLCgj0zBGoZEJbI/mF58MFkmSlQXWK/9CEyAdVGJ
        8shXQQK0LtA+ZYjDK8NKXmg0BUsDeEHaoWU/VcV4LFrD7R8=
X-Google-Smtp-Source: AK7set9iQGEwnkH6nWOLKIx3MM7kSE/R4iRhOK7Pktwfd/hIpbvEvpG36h+EpIRBkU11LdyJJUgCZPWV2Ry1J0o3GJ0=
X-Received: by 2002:a81:66c5:0:b0:527:9733:fdee with SMTP id
 a188-20020a8166c5000000b005279733fdeemr692330ywc.490.1677068945192; Wed, 22
 Feb 2023 04:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <Y/TP6as7qqwfcI42@boqun-archlinux> <87h6vfnh0f.ffs@tglx>
 <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net> <87edqioo1e.ffs@tglx>
 <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com> <87o7pmmtre.ffs@tglx>
In-Reply-To: <87o7pmmtre.ffs@tglx>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 22 Feb 2023 13:28:53 +0100
Message-ID: <CANiq72=oPCO=+yksn4qKemp+OkCm-+T54DQz9f3sSD5SQQLRMQ@mail.gmail.com>
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Asahi Lina <lina@asahilina.net>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
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

On Wed, Feb 22, 2023 at 1:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Back to time deltas (or duration types). Independent of the above it
> might make sense to be type strict about these as well. Especially if we
> go one step further and have timers based on CLOCK_* which need to be
> armed by either timestamps for absolute expiry or time deltas for
> relative to now expiry. I definitely can see a point for requiring
> matching time delta types there.

Yeah, if you think having several delta types would make sense for
some use case, or at least prevent some bugs statically (especially if
you have been similar issues in the past), then I think we should
eventually do it. Not necessarily now, of course. We should just keep
it in mind before the types get a lot of use, because it can be easier
to merge types (if they end up being unneeded) than to split them
later (double-checking each instance).

Thanks for all your feedback on this!

Cheers,
Miguel
