Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CED72CD50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjFLR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:56:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5EA1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:56:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f655293a38so5148061e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686592605; x=1689184605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0Jw3FHM9EacxH/mZ/iMD9+z20+OQwgYNEZ4cddG8cQ=;
        b=QhZpX/rju1hLcL9rV1UHZJRWDdHtqLHv5zuxlQIbNLeNhkiKC8y9MCV4BgfX0HJYwO
         u6tgfU6QmDNpYvyB/tS3ktK96aoL9rMb0U7SX1XHb3kXhOMnEevghcUsFswZbarcfrkI
         Jb2W/EbfMXh0Lw/++iprfdfwZR5M9QbI+/t10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592605; x=1689184605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0Jw3FHM9EacxH/mZ/iMD9+z20+OQwgYNEZ4cddG8cQ=;
        b=d1FXHTbMcCoai6co+grFiMNIBz/+sO6dOvlVuBGSFt3xhLRkXX8bUt7+ZXrqIdvYDD
         NM6tTHrNN2h0SF9dHpCeQMGs9/sE8+zDezzVVeLPQzpqCX/lfx6cZrs/iMGgU/jYs2D1
         79ruVVKzzCKlhxKDTR56bGUWbUi7wClerjASTC1QoTBrs9v3Mb0AaxgbSW/Ijjpi8UAj
         LSiVyR7Je8g0Qfx64CPbsIcjRaNu90+i67OPUG9BqwumDv7nQv05OGzFywRgp8UjzSYi
         AyLV3M9Me4EzhjB3ofZyMyfFjdIJrZXIxWts5+syLmC9LPu+ZCmNRMCex5btmRsnuOe0
         2yDw==
X-Gm-Message-State: AC+VfDwjnKyJ78xFXo8w6/orjuqT4fvTuiODOqbbcngYNk4g79Ndasdr
        /ozvdhq8WdvmxFEyh7B3cBFBZ1JGf5DiefUpo/FdgieF
X-Google-Smtp-Source: ACHHUZ6fiMFOYGyS9pj7CbJ8L5x2h7mEd6PGY3MofhzI68eAeAF5FhqNaZfAXr+xEApz1gxfTS0vvg==
X-Received: by 2002:a05:6512:551:b0:4ee:e0c7:434d with SMTP id h17-20020a056512055100b004eee0c7434dmr4224269lfl.51.1686592604923;
        Mon, 12 Jun 2023 10:56:44 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l9-20020ac25549000000b004f63739e2f1sm1490417lfk.255.2023.06.12.10.56.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:56:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso5569729e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:56:44 -0700 (PDT)
X-Received: by 2002:ac2:5dc9:0:b0:4ec:8816:f4fc with SMTP id
 x9-20020ac25dc9000000b004ec8816f4fcmr4979969lfq.6.1686592603732; Mon, 12 Jun
 2023 10:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area> <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area> <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
 <20230612153629.GA11427@frogsfrogsfrogs> <CAHk-=wiN-JcUh4uhDNmA4hp26Mg+c2DTuzgWY2fZ6hytDtOMCg@mail.gmail.com>
 <af31cadf-8c15-8d88-79fb-066dc87f0324@kernel.dk> <13d9e4f2-17c5-0709-0cc0-6f92bfe9f30d@kernel.dk>
 <CAHk-=wgdBfqyNHk0iNyYpEuBUdVgq1KMzHMuEqn=ADtfyK_pkQ@mail.gmail.com>
 <212a190c-f81e-2876-cf14-6d1e37d47192@kernel.dk> <CAHk-=wh0hrFjcU5C8uHvLBThrT5vQsFHb7Jk6HRP3LAJqdNx1A@mail.gmail.com>
 <ff34a007-fdd0-8575-8482-919ead39fc88@kernel.dk> <CAHk-=whXt9+-YfhgjBYxT9_ATjHbMDZ0yJdK7umrJGU8zBVZ9w@mail.gmail.com>
 <8a97ca5d-69ef-d716-9f61-2b9b2a26dd14@kernel.dk>
In-Reply-To: <8a97ca5d-69ef-d716-9f61-2b9b2a26dd14@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 10:56:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVQVkunhPL00iSzBnx8xrdW=94EYoOW24zT0ofGv3m2g@mail.gmail.com>
Message-ID: <CAHk-=wjVQVkunhPL00iSzBnx8xrdW=94EYoOW24zT0ofGv3m2g@mail.gmail.com>
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:54=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> Something like that was/is my worry. Let me add some tracing to confirm
> it's fine, don't fully trust just my inspection of it. I'll send out the
> patch separately once done, and then would be great if you can just pick
> it up so it won't have to wait until I need to send a pull later in the
> week. Particularly as I have nothing planned for 6.4 unless something
> else comes up of course.

Ack, sounds good.

                   Linus
