Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522526CAF79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC0UMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjC0UMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:12:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D4098
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:12:36 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ddbf70d790so953901cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679947955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6Y5nshyHGbaUWpCASV3R81gaVvM3HOB1d9ZwUYlfVk=;
        b=h5Z/tCZmHN19MXrT58got9fkyLxEy5dFq9liBwGY9EApe4RxZOIN045xW16k/wBxYL
         UbhC1miy4LpLV8Y7yrW1KBqeTzy7t4a1Dm+Z24DubabF/lECZ+mFOglf+kZ7yBqe+nVQ
         xB2IGsdAlYa2raBD9Eq8PnDtt6CiGDNu37VlW+lb++bTnpFJIxnjjg598YDYOv4QyEOo
         9mlcHZDeIaisACIZxrkjReBkaoeDzskeWL3VCoycO+qXlzNeHbXzndz2w8JHD6WADOK2
         a8ftkT0kCDGo8SZAck1Fv7D98T7B4uuoaZc90wHhZVHoS1GHLsKprD3fX7c+ZAHYrdsN
         2mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6Y5nshyHGbaUWpCASV3R81gaVvM3HOB1d9ZwUYlfVk=;
        b=Dw9T9Tax0FHj8YgOivbvuQWcX5g79zRB0vSEnKCoJValRTAiH6EZhW1Bqfq3ttTV9y
         gc/piicCSN3SKfEQU8Fl9tXD85ZK+gphI8q/HX5YFO4ZNb+bIdYuVHy5xjrj9d8v5ZED
         W6nUQ2zlVZaXGB8O7/uOhy+t1duwKHE4wgVGasvZBw+/bXTjIwO/zz8S80Jmhxg6OaNR
         Puj8dIvE9xaUR5Qap5zBrIlrLZbyCuY/J/5EMHVbNW+NCdXx848Ff/CK7+snzY51BTEV
         DolW2m13BTz+e6KybNz9CF8QxXY2CDEGbR6Id25xLbAxVSfWNmjO1lHIi9EW8fzJwmMs
         SW9w==
X-Gm-Message-State: AAQBX9fX7Nj9OnBlp1wt+6igAb11otpDjFkISyaaxmpy0Qu4x6mco+DS
        iOPQV3gLwLpn2KywRZMGH3ajcVaCLVIM8jIqvcFWsQ==
X-Google-Smtp-Source: AKy350awT4IZ8mzZ6W91yehHMzAJezkqfxxR4eqYhwRGlLxmgTqp0rN00p1NNMfFOJphz+C9hWjDTksdIx9pFQrJc1c=
X-Received: by 2002:ac8:5dc6:0:b0:3d4:edfd:8b61 with SMTP id
 e6-20020ac85dc6000000b003d4edfd8b61mr107534qtx.0.1679947955208; Mon, 27 Mar
 2023 13:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb028805f7dfab35@google.com> <2309ca53-a126-881f-1ffa-4f5415a32173@kernel.dk>
 <CANp29Y66H4-+d4hat_HCJck=u8dTn9Hw5KNzm1aYifQArQNNEw@mail.gmail.com> <75a684d6-8aca-8438-d303-f900b4db865d@kernel.dk>
In-Reply-To: <75a684d6-8aca-8438-d303-f900b4db865d@kernel.dk>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 27 Mar 2023 22:12:22 +0200
Message-ID: <CANp29Y42=xHjyW5ZUDp8f3gaWV=_FVTb0SgtpECyX9yc8wxbbw@mail.gmail.com>
Subject: Re: [syzbot] Monthly io-uring report
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+lista29bb0eabb2ddbae6f4a@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 9:20=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> > By the way, should F: fs/io-wq.c also be added to the IO_URING's
> > record in the MAINTAINERS file?
>
> I think you're looking at a really old tree, none of the supported
> stable trees even have any io_uring code in fs/ anymore. Maybe they need
> a MAINTAINERS update though? But even 5.10-stable has io-wq included,
> though it's pointing at the wrong path now...

Ah, sorry, I was indeed looking at an old crash report.

>
> --
> Jens Axboe
>
