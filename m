Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C26A881E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCBRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCBRwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:52:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625F36FC3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:52:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so553210edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677779529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5aFcQHv0N7yL7akZl+srFSiIjdpFMlk0jHiL9q2NCU=;
        b=Rg0CNtgX0eLMgdHgQfPOud2SKsPZqOhhVKlMy0ALZrL/PHjt/MVnWeuBIBz3oznil8
         n2igdVoUYYnz9o9meqnpj07f/GNys7NpBg7aaiI9JwdK5uF7yecJ2qT9EUUy+7x54Ya1
         qvVGdXUZ7F+oR+IKyvKYNwqUGp1/67jnibc+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677779529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5aFcQHv0N7yL7akZl+srFSiIjdpFMlk0jHiL9q2NCU=;
        b=SxFhn3M+JeepfyS5UNgEDEstI4WiV+DFva8l0x/4aQVJ8824DXEA4kp0LtHg/MT166
         l7Cld/O6gJhIy1NZq8Vhi53e4QQyWgjQzQwW5ueqmdqSrvYwe8qB56SykKY0jWm4bRRJ
         ypyNy+MOeyyuczfZhmBlj9GHSrchz8770nPaJMC2CeE71xyN7+0Sfl6a56KWQQawYXJQ
         aPENpuzzloOGr0KoELBdQXYTTwZ0a2MFfwt8SoqRQ6U9os7nMrrKRRWeOxJb5s0D+2PT
         zqMLMyIn4fLZSBe7ip8ybpJ30SGRCeZdrDwrSoRs7YPUD2aKQ8+bTgXiZOQrGInXkns9
         8mpQ==
X-Gm-Message-State: AO0yUKXauhRL8r7rsJXyVYp25ZI5IO5Su6JKBs4W3OgpP2lFl2qSlw5r
        aN+YvtsZX4yBqZv4H1TRVs5tLZQf3cVDhu13yXk=
X-Google-Smtp-Source: AK7set9oAGxiq1TEuMctQWLSyKB1uQtvKV0P9ZJfePiaq3B0wqhFmDXf9RjhTs068kHzMbc/CSFvoA==
X-Received: by 2002:a17:907:7254:b0:8e2:49c2:1a12 with SMTP id ds20-20020a170907725400b008e249c21a12mr7986556ejc.20.1677779528952;
        Thu, 02 Mar 2023 09:52:08 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709061e8600b008cecb8f374asm7313296ejj.0.2023.03.02.09.52.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 09:52:06 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id o12so226918edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 09:52:06 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr5367831eji.0.1677779526028; Thu, 02 Mar
 2023 09:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com> <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
In-Reply-To: <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 09:51:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
Message-ID: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> it I'm happy to pick up more stuff like this. I've done it before and
> have worked in this area so I'm happy to help with some of the load.

Yeah, that would work. We've actually had discussions of vfs
maintenance in general.

In this case it really wasn't an issue, with this being just two
fairly straightforward patches for code that I was familiar with.

              Linus
