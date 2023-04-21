Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE60F6EB5CA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjDUXrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjDUXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:47:34 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E481991;
        Fri, 21 Apr 2023 16:47:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b8ed0d0a33dso3144784276.1;
        Fri, 21 Apr 2023 16:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682120850; x=1684712850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKjd7Dgyz22QqQOAhKJQoIvKuhScrUfoILpg3YEc53k=;
        b=ojDKyir2xEIQowojJAF2q1fu+cujPY6VW8SqkBuiaz94WS2ONi2XCLTj8h6gtQMmNh
         HPyzcAdXSDkRXFrMU7sC6ORhewZk6uvNT4gua3zJkdRRYUfTLIysb6bVyxI7cBHaOkAz
         fO4nzTIl5ZNi68Ols11ML1+0Q+k06RggXx5fJoaoV1P6qriSIlGC0h2XeDmhaT6eo6y3
         nVT8kZ58yE7jKt5qn9flBmWPN114MnFZ1z0pNy9xaVS43OLvdu3EpFiVjtQldPr4YPYv
         jopV2Bt1HK/bFqvfpOaqaEWelNURLJ/xQtzzfdykjCnc8kRbK20D3UH0jnDRKyw2JQZR
         XrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682120850; x=1684712850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKjd7Dgyz22QqQOAhKJQoIvKuhScrUfoILpg3YEc53k=;
        b=dLmOAWADF8bGMcKcCvcmcXvhShmIlykLIXuXOo2q4odQVMeTkfguU5WhmHgl3tK+kf
         MJPWuDFwTqsTZ5QUDC9HtHoWcL/D7yeuDJRf8tsOIkjO4pN+12xlZ+2QLlPXpChuHDUb
         l+qzP0z5qDr4qwVi3fgUwEEpLLrSiwQ/3rQ8SFfKT5zCZs0MciCTw9mYx28FXVYnIeI8
         qOFK7VjdQ66TuuR8KXKlBOFowFpaBwQne3QzjfjndDH8xLXoxx/x13YBrWubUjdr4m5c
         ITMe1GmrJDYwNMiDkm22pLna6Kfexno4ih9FQ3b4UQJvJmgeczTmq1HMw0N8b1j8Trcx
         CwNQ==
X-Gm-Message-State: AAQBX9dMGMrIbJnSTUWRJgA1PiDnsGvuA0w+bkAaS1z6TADK4gTL5/0s
        1yglabb9ePHr0w8iA85lM9OPFL+j6vBhkIVL6uQ=
X-Google-Smtp-Source: AKy350Y40/d7pq1l35kZU/yvjeFP/ZiwQ441JNdgvlYCHXmUselRdsodpw/dPIIlQRMzobyttLP7M/EncjM6BPPUo0E=
X-Received: by 2002:a25:a566:0:b0:b8b:e98b:cbb with SMTP id
 h93-20020a25a566000000b00b8be98b0cbbmr4220195ybi.38.1682120849813; Fri, 21
 Apr 2023 16:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230419174426.132207-1-wedsonaf@gmail.com>
In-Reply-To: <20230419174426.132207-1-wedsonaf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Apr 2023 01:47:19 +0200
Message-ID: <CANiq72=9sSeisy4ggUxwRdtUroLbD6=LpXjjMfgkd5ehwOD4PQ@mail.gmail.com>
Subject: Re: [PATCH v4.1] rust: lock: introduce `SpinLock`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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

On Wed, Apr 19, 2023 at 7:44=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> This is the `spinlock_t` lock backend and allows Rust code to use the
> kernel spinlock idiomatically.

Applied to `rust-next` within the main series. Thanks!

Cheers,
Miguel
