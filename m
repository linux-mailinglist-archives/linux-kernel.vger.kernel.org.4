Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223986802EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjA2XU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2XUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:20:54 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA1D4694;
        Sun, 29 Jan 2023 15:20:53 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id a9so12105142ybb.3;
        Sun, 29 Jan 2023 15:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uGp/W+kz+8p9dV+FBd4h0typIOnCFR5yowjgzLdEKRU=;
        b=MnrFj7NBOwZgie+ttjcrII0Lk6lue3GXwl49Fp0qaPnN5nDfYYJkO+FBsxN0pkMbN0
         EZ3WmOSEhk2Vy/oD1yzOTVtW0GjGwD17+xskMYp5Zq+as4VATLN3Ki2XlzXNpOJvCXJQ
         D+fRvlChY1tjGvg13fcMhy/lb5bHkpTJA7hlSYbnpxOcV6pr7EUiz0ma4gIEm/E4W2qA
         5Nyfgbt0ekckKSnPwmnaNna3xzVOForEf0qPetm6oWmRm50q39/rH4GGRC2dkrUm8dkb
         6RzK5pWXtTlTtI57d8OgT2lY5DwKGtHGh6RVlj+bHqcI5yd3Mhsv2XgJMGa4wqD4b8lq
         24HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGp/W+kz+8p9dV+FBd4h0typIOnCFR5yowjgzLdEKRU=;
        b=vapV1+8RT6KJMLI6yt7M4oA83Z7RwvhaFfmHS7/Wj5urWae32AuQnM6YSViJZVBdkp
         q64JeZCc6LzZcRysSY4vIvRktdtk1HVFC4XH/jA6dI/pwxqyhEM8gBCdEiMRQjWi5g7E
         R899RuXQ6kToEDjh1z8glGLpElp7SXPpOKRitYt+Xym3CdXJ2wJM5HjXf+2swWIl3zDH
         mpqPzKXgaB7eNrtEaZC8D2ykaGZYV/VfyKVvoPfLYESdbeWVvAsztAwXgx4KW8O8zHCr
         wxO2JDP7XD/t8bZTvIowC2wI2Jkv7MwgDzz53MG7u44rR8hrHHja/yeDBpWfBbgFIXHs
         Bp7A==
X-Gm-Message-State: AFqh2krixbRq5ouxcPrOZxKodeSC6ivkPWI4D7+K/GROAjyAdoT3hhYj
        c34+L02izvp00FoUPCVZ0+ZbOja9P9+uzVwLh/ooXIhddfuJBraw
X-Google-Smtp-Source: AMrXdXtXSNrvDaR5AKvdKM/zYpp8OzVBI6K7jTCGYe431RaH0pbbDDFUf6WKrgJ8f3tISlw5XRaQxETUNgRQekgfoDE=
X-Received: by 2002:a25:24c4:0:b0:803:197f:3f41 with SMTP id
 k187-20020a2524c4000000b00803197f3f41mr3926427ybk.489.1675034452741; Sun, 29
 Jan 2023 15:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20230129184602.3974058-1-masahiroy@kernel.org> <20230129184602.3974058-4-masahiroy@kernel.org>
In-Reply-To: <20230129184602.3974058-4-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 30 Jan 2023 00:20:41 +0100
Message-ID: <CANiq72=BRW9TunjKQmeMthm7Esc_YKM++NmWh-Dqc9Av13SNow@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kbuild: srcrpm-pkg: create source package without cleaning
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
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

On Sun, Jan 29, 2023 at 7:46 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> -               include init io_uring ipc kernel lib mm net rust \

For Rust, it is early to deal with packaging, so removing this from
here should not hurt.

In any case, I quickly tried the series and noticed that the
`.src.rpm` does not end in the `SRPMS` folder (as it did before) -- is
that expected?

Thanks!

Cheers,
Miguel
