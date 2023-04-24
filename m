Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957436ED6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjDXViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjDXVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:37:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565374C1F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:37:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f7a0818aeso732311966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682372275; x=1684964275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrwnaZWjXEThBGNt6dinryO7jmM1jZWEW+zc57nY1i0=;
        b=eVKWMbmShpy6Z2F9ca+KltuN3iRYVCMbpYdVaFaQCwtTNRTUUiY3qN0/GJTjvdz+r1
         ux9NXTkElriNuQjHI+eqluNVY0HlMg5/10+WNpy3jqK4rZiLYzwPgk0fMOb8xcncp4DQ
         NJ2TX3pbGlQLWrMrsWAJ4N3zEp5rBtpRWunrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372275; x=1684964275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrwnaZWjXEThBGNt6dinryO7jmM1jZWEW+zc57nY1i0=;
        b=Mgs5TNgqz5TMLbOCHi4h/8Nll1R66OjYUfhJon1Sm2lqbIwDSbzDwUkoDE+5dHXZz5
         JUB0yHGc8BIFSrhFnNM2xyva1+UgicATNxgy9pRIlQ+UZEd6/EDtnx0L0re8upeZFl7p
         S479II90TujAjoxaGmHTOZp6H/X3CQFeM7TrV7zG0jq7AakU74EI1A4MEZbjSonjrYxN
         +8lHjsaiu6fD/wEejKolJPNBTQUb+wpiaam5CdvYmySlpSy/pOyIJkix0XFHIx7ggKkH
         MbgopVwKXMNK+Arup0U8kTFO76uavvp6w2W7gDzqo1wRiXGrFUzTCOy2MbeTQiHj7TJ3
         AbCg==
X-Gm-Message-State: AAQBX9eQfL3jM+vHcZXpwI0WRK851PJ1rDIjv+B7tgFs78oo/LeB5tRT
        STCsKdvk+mAMHb6xmOdYZJtRn5aFZESlb7bXsVBLSklv
X-Google-Smtp-Source: AKy350YPOEPexZUab/0pNHD3WxtKQXMagtN+Cf7iLTiEcIWX1lIDeEeQFFHi7jvBf/fIrpkMSrYwNA==
X-Received: by 2002:a17:907:3d5:b0:953:43a1:1988 with SMTP id su21-20020a17090703d500b0095343a11988mr8250655ejb.46.1682372275487;
        Mon, 24 Apr 2023 14:37:55 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906169600b0094f3132cb86sm5930868ejd.40.2023.04.24.14.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:37:55 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso7472098a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:37:54 -0700 (PDT)
X-Received: by 2002:a17:906:dc8b:b0:953:8322:a99f with SMTP id
 cs11-20020a170906dc8b00b009538322a99fmr15462944ejc.0.1682372274606; Mon, 24
 Apr 2023 14:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com> <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
In-Reply-To: <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 14:37:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
Message-ID: <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 2:22=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> If we don't ever wait for IO with the pipe lock held, then we can skip
> the conditional locking. But with splice, that's not at all the case! We
> most certainly wait for IO there with the pipe lock held.

I think that then needs to just be fixed.

I really think that trylock due to "nonblocking" IO is fundamentally
wrong. Thinking that you need it is just a sign of something else
being very wrong.

That "very wrong" thing might well be splice then not honoring
non-blocking IO on a non-blocking pipe.

And I completely refuse to add that trylock hack to paper that over.
The pipe lock is *not* meant for IO.

             Linus
