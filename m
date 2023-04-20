Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893596E9A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjDTRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDTRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:20:54 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3DB49FA;
        Thu, 20 Apr 2023 10:20:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fe82d8bf5so52070437b3.3;
        Thu, 20 Apr 2023 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682011239; x=1684603239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwTtrw+r1WUcCtmB6Bx5/S6sQw5KJg+GPT72yGlCNGg=;
        b=MNFbGRLJo4mjCizEuy16KObC2DnvUVdrbD2YITULLtbplRAwzAcv4PWwIz+AV3z4EM
         d2mTuZNkXh00s5ihM/srW9H5d0nkWmAgMJsIA0klb6JoG7QI4RFI+SPSM60VupLo+i2u
         2WXN2yXfidIcOQgXkFPuxJ35y8mOObQvzGWEKkih5T9zHWnau2QlaB9W9SU7MqPpje4s
         3G3BEFAnqWwq8TzY7Kgsox4t8EVTN1VGLRRV3vwaKEkMKyZma9DkUSO0LGdGd3HrET/O
         8ftZhf7H7kXX7oGXumNHP9UhhJB566/YR1F3q4qEalbPvpshxIb5JeRgQJLtLWXCrw5Q
         WYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011239; x=1684603239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwTtrw+r1WUcCtmB6Bx5/S6sQw5KJg+GPT72yGlCNGg=;
        b=AOlYTsts7bUaL+SPKp/JsGUe5iZJXsOnb2rHzV/dS4FmKUrx9505Y2h8vqQzw4tRa9
         5AdAwCeDKl8YqbnFbkr1n7BUjXOoSRds8gzxhrWi8zxevn7d8rNjrsVq3ph/FpoDhGJK
         CsK/G1SQCxpeT3IC/pNdMB4SRptZsgdlhtL6haqAgGsUdpJ2cYzxifqmMtCb11smD1Om
         H1tahcgQWN2PWK8g0ma1AtmrgdjGRvBgvVYQB3w7Ihd2X260WIA4sNuTl7DBwCJnNvbm
         ljYeG2ughHFUabXIFuOFse+16i/XLKLkFk75ZSvdfGo4HhoLrEII+4ZvBBrhlinSIvf8
         Vstw==
X-Gm-Message-State: AAQBX9fkkQmQbCa0uMaxzyOh1gnDC6Dv+QfyNhfLI6fwOUY1WSfmUOr/
        7vlzuF46rcAJpf+IM26nyN/V70gPcN6sPBcpu6Y=
X-Google-Smtp-Source: AKy350ZwndeKcfKTpMQARPd7+kh+yusWRapvjGVYLmKPLyCj6aJEjXv8FwUxBCSjmek11dZH68B5uz98rLkmiSL+km4=
X-Received: by 2002:a81:73c6:0:b0:54f:752e:9e60 with SMTP id
 o189-20020a8173c6000000b0054f752e9e60mr1407987ywc.37.1682011238718; Thu, 20
 Apr 2023 10:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org> <CAPDJoNsG1E25yYM+L_H21vVCt-5S16etx3KMxx8ySZtWMQt4FQ@mail.gmail.com>
 <CANiq72mtb9V+1a7nPEHBCeg_fob4rpPTWJZjdahnGL2Mg3uoUA@mail.gmail.com> <CAPDJoNvGQBNN6X6fs26tjUy7LbpJjWwPvQuf=1+nSwj94aa6LA@mail.gmail.com>
In-Reply-To: <CAPDJoNvGQBNN6X6fs26tjUy7LbpJjWwPvQuf=1+nSwj94aa6LA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Apr 2023 19:20:27 +0200
Message-ID: <CANiq72m7zdYo566PxX3g03+XPpHnrQy7GG9WkgEP82mK_2JBpw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Ariel Miculas <ariel.miculas@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Thu, Apr 20, 2023 at 7:18=E2=80=AFPM Ariel Miculas <ariel.miculas@gmail.=
com> wrote:
>
> Yes, I've edited the commands since I've run them out of order, let me
> include the output of commands and my general setup.

Thanks for confirming! (and for all the output!).

Cheers,
Miguel
