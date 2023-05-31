Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40153718BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjEaV1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEaV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:27:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4EE12F;
        Wed, 31 May 2023 14:27:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4e71a09a7so270940e87.1;
        Wed, 31 May 2023 14:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568461; x=1688160461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmGRIWXBp3HvZBL8UWz5wMSP/7nqOL/RMhMi6KYkHks=;
        b=FcpN/mh8cXkbNo+CIlVmIrUGdutwSm4/R1pMOT/IyhLP+I83WWkChubz9sfDC/kuqn
         p7ClzAQ65KzsACCu+go1zZnqt7FGXsQS2bKayXgqP5hTAGnw3ZhXiEAtzzer0JEebME3
         xNvkJ6uLwkzGJmK9wKQvaaXrdsRciyVbm8Tc8YkIZZGKb50hTzblYXsFAccwUJuEDFFf
         WvEAFs+kFyw0zQ7LVmb9PatmBSVjAN8jVT9wvu/qDzAmbYuNosmc2bJEYhox7rXQlett
         tMGDHOphJoUjepHjumcdOJ6SBH2x8F171xzexjuDB8zn2xYF3267ebNlMvvdEqd5W7wi
         Op8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568461; x=1688160461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmGRIWXBp3HvZBL8UWz5wMSP/7nqOL/RMhMi6KYkHks=;
        b=ES4oDM4Y+MJ0c2IW/lpnS8TCpQvjfiJmfUyGB4b13QYkOALeNQ/JtsiQyj9aElgfXV
         DzD1PiLeTgVkl8aQSio+ElDVvNvCEIk0Fu5kYBgyL1txQhhCeld0fHdquCp8oIJun729
         7IsklGLsn6eflEnfMST8Zpnl68bGI4agnxEEThlAhFhqqrXLg51HDBNWnVwIcrgrCEvo
         Mc50JlO5chvpCSEs5qG7xj9TErR32qdRlGCzHRFjalue2hrNwfqR9n4UGGXHY/XcAGMi
         Oe5FO5L4BCNDL2KaEGDX3Uh+VgIIjFDTEIEucLWqTnD5E/B/P99wQhrBTjoBed2ozXM3
         8vAg==
X-Gm-Message-State: AC+VfDxolKHbJb0u4aqGD2bmaqPe03widTZQ/hYhn/swOJ/mf9XcCwCn
        cBWk8RUM1fHlE1Av7dcadJTy9HdgonLomyMCit8=
X-Google-Smtp-Source: ACHHUZ5Xg3flrGOmNSIrwETWIc0iScTUfmpexxAf15uqKG+Hq+PHPLzlZ1IpahHdKGlwqsGnFkKrYJ82lMO98YSQTr0=
X-Received: by 2002:a05:6512:4013:b0:4f3:a763:ccb7 with SMTP id
 br19-20020a056512401300b004f3a763ccb7mr122967lfb.2.1685568460892; Wed, 31 May
 2023 14:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230531174450.3733220-1-aliceryhl@google.com>
In-Reply-To: <20230531174450.3733220-1-aliceryhl@google.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 31 May 2023 17:27:28 -0400
Message-ID: <CAGngYiW_3HfebWZO5S=RXFqhNnsbnix-NaA0UGYRnRLd4SK65w@mail.gmail.com>
Subject: Re: [PATCH v1] rust: error: integrate Rust error type with `errname`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alice, as we discussed through a separate channel,
you have my permission to use my name in
Co-Developed-by and Signed-off-by tags.

On Wed, May 31, 2023 at 1:45=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> From: Gary Guo <gary@garyguo.net>
>
> This integrates the `Error` type with the `errname` by making it
> accessible via the `name` method or via the `Debug` trait.
>
> Co-Developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-Developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
