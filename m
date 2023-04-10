Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC26DCC37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDJUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:37:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C619A0;
        Mon, 10 Apr 2023 13:37:17 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f64b29207so12465877b3.8;
        Mon, 10 Apr 2023 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681159036; x=1683751036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8QvW1VarPjYVTHLxFJpvXLheEBz6bVhRPOQi5hYm98=;
        b=OubFNi9n8x1DQAAsaljbTa3uy1mW1ABNLjmnFjAYxNtXJHc0xd+/WBO2f76vtmmQWO
         HsARpOz/J6JBSP2EiXJwGaQdulsK4yZwVKUDrY4c2F6/YLmK7dUufryhq22Ws1lslVtv
         BuRIUXNfxUvF22B2PaIcmfcGJsBCPoDETrnzKdVSkFSRialq6owF8PhKzWkOJ7EPl2GS
         asxomAv8mjpaUSxF9roYzQ9ybfwH1YVJztC233PfuHUFRQdZsV2Gp93uuaA+oyDbaPfj
         UXvYo/GHRmYjWqGPBhGQPz9eMFTLcR0usgwwzUiTfApLBJpPtWQTMHvP9e1BuOUw8+9g
         x0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681159036; x=1683751036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8QvW1VarPjYVTHLxFJpvXLheEBz6bVhRPOQi5hYm98=;
        b=bAmlcjBJUYp9usCMW562ID62JChU2cCOXeMt8xQYTOWgvf313IfuW0Z3W89Y6BUwQe
         kcpzD0z3oQJ1yW06Ead/AnppodQ0CXOwIAhq1M6tO6GRxhFiWxXfLyppIyQXG0w3hBCz
         PQP+3S8YzQQ8WCBVAqsMnOCpX4dbsFLdTRrkxP2CuGl0QDPL3JMBYvaK52vnKNqHhyte
         wK+J7/SWmoL7RotgPztg/jDMzpRrEElmVAgqMyQTBWMrW7b/kwbskXp98NXxEWb+8n9z
         /3qoXYv7aKmObLcF0PbhCppmwhRnxZtR5SM+T2Xa4ZzMk8BNzh9/fk/aSlYcCnttXKN6
         PzNg==
X-Gm-Message-State: AAQBX9cvZoAYQlbryA9grp7xvlR9ln8D+28qruCwsyxoI9/Uln1F3A3R
        QdT0sYr4FlfmbA170WmH7elMEUoE0Qur7RHOdz8=
X-Google-Smtp-Source: AKy350Zfo/UKBdmut9j3vGbVJr5E+g68a0Q3jVpAFqX2SKJuvmU14Qc/J+nbfYOt6JKMpSlpHzSlkQjeIlGwJYlgDdg=
X-Received: by 2002:a81:c609:0:b0:53c:6fda:835f with SMTP id
 l9-20020a81c609000000b0053c6fda835fmr3657739ywi.0.1681159036275; Mon, 10 Apr
 2023 13:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230223025924.526200-1-yakoyoku@gmail.com>
In-Reply-To: <20230223025924.526200-1-yakoyoku@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Apr 2023 22:37:05 +0200
Message-ID: <CANiq72=wqAJeqCdwDr8yXh29B_70dc51+auMmnWAahOz+f8p0w@mail.gmail.com>
Subject: Re: [PATCH] scripts: read cfgs from Makefile for rust-analyzer
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 3:59=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Both `core` and `alloc` had their `cfgs` missing in `rust-project.json`,
> to remedy this `generate_rust_analyzer.py` scans the Makefile from
> inside the `rust` directory for them to be added to a dictionary that
> each key corresponds to a crate and each value, to an array of `cfgs`.

We should pass the values to the script instead, rather than relying
on how our `Makefile` is written, even if we control it.

Cheers,
Miguel
