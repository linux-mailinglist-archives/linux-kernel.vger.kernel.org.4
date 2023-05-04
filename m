Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE946F7717
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjEDUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDUdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:33:43 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C061A1F3;
        Thu,  4 May 2023 13:24:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a010774a5so13765427b3.3;
        Thu, 04 May 2023 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683231817; x=1685823817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnKSnabTJgMzw4Wg+5H4XZlyvGFVU5xMwdJ1boBOdHE=;
        b=rVsx1PFx9laQzqw0f8SmE+h73WVsFUYLDtyGZb5zgICH2R0OmFlMHqxp6tWFAb4HQm
         /edWrVfVJlUEvbmUWix2tBdVlD+smfmfptE6FD+PQOsjQSPcRyvZeiSIeOZ6P7ndA/Eo
         nHSw2zyHJRAKfH+8zL2LXj1n9h5KC8Q9//mv+BhJX5YEgXOfTRaz1GWeQIUE0Kw9N8nD
         XBFOC9ubIoyL6Uf9KTUkagkCjMwpvqElF4QcM3qpCJ4Mnhm1+DMZasn6H920J4+CaZaI
         EJeyaODg4q9BNzM9+8OBed8SOZ9JhVH0WSiBuKg+4RSHbeEaV9ZoeX5aYIM9ZCZKhmW4
         G0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683231817; x=1685823817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnKSnabTJgMzw4Wg+5H4XZlyvGFVU5xMwdJ1boBOdHE=;
        b=KptUqNYnr/2aY8Jg9061JkjiZ3/jxclXND36C234hsbiLmG3KJVc5baHI9tpiDakvD
         5dONsROz7/wMa/SLW9qHzITJjvyxOD/YKjIX2dMxqFruf1RdipqRMYl82VI/tJHF1eHv
         IMNILvmysPayWP9PGNsgEN+Jeb1qzBJfyE96TqBSGZEVGXsaNx2rgPL+wx6mSQCdDHaa
         +zIoGFECJ/XEz12DRlCJz4FNTVflHkFTUSdwFBl16v3e1fJgN1VNg0Fb89vNTEU61KcJ
         y7Rf26ZMsfzV/QCDE8nVZypXD5RlswDAp1c2EIvI4bjy2MklGJSxWwkkw0L/Xx6RPYa7
         jTXw==
X-Gm-Message-State: AC+VfDyS8HwGOAmQMK4cBaW1f6xoEHgBKhilwrqH5uqq6A2d6a+TX1b9
        TPC6apnQi9Ip/T20zfSLUIjReFc1sHrwkgsO9j4PykReHKxcXg==
X-Google-Smtp-Source: ACHHUZ53o8qy5NHN8N3ZCDeCCHib6rX37ROTbGQAYH2NxbjpvNJL4+oS2yrKBdca+zAaNAp099NQ4R0kMjO3WK1f0FA=
X-Received: by 2002:a05:6902:1028:b0:b92:3e7b:d848 with SMTP id
 x8-20020a056902102800b00b923e7bd848mr1524958ybt.19.1683231083317; Thu, 04 May
 2023 13:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230503090708.2524310-1-nmi@metaspace.dk> <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk> <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com> <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
In-Reply-To: <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 4 May 2023 22:11:11 +0200
Message-ID: <CANiq72nAMH1SfGmPTEjGHfevbb9tMLN4W7gJ3nBpJcvkCEsZ4g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
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
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 9:02=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> But back to the real question... This is obviously extra burden on
> maintainers, and that needs to be sorted out first. Block drivers in

Regarding maintenance, something we have suggested in similar cases to
other subsystems is that the author gets involved as a maintainer of,
at least, the Rust abstractions/driver (possibly with a different
`MAINTAINERS` entry).

Of course, that is still work for the existing maintainer(s), i.e.
you, since coordination takes time. However, it can also be a nice way
to learn Rust on the side, meanwhile things are getting upstreamed and
discussed (I think Daniel, in Cc, is taking that approach).

And it may also be a way for you to get an extra
maintainer/reviewer/... later on for the C parts, too, even if Rust
does not succeed.

> general are not super security sensitive, as it's mostly privileged code
> and there's not a whole lot of user visibile API. And the stuff we do
> have is reasonably basic. So what's the long term win of having rust
> bindings? This is a legitimate question. I can see a lot of other more
> user exposed subsystems being of higher interest here.

From the experience of other kernel maintainers/developers that are
making the move, the advantages seem to be well worth it, even
disregarding the security aspect, i.e. on the language side alone.

Cheers,
Miguel
