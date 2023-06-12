Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB2B72CEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjFLTFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjFLTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:04:54 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A111B;
        Mon, 12 Jun 2023 12:04:45 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a2c85ef3c2so3253255fac.0;
        Mon, 12 Jun 2023 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686596684; x=1689188684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OOA/ytQLN+B3gWqHcQscrH2RGfHUDPpsGBgPoTwMwU=;
        b=mqmplgHYcbdHCEUJBJPwAOzEH/KkA5KlZpIohsz5YZEbmJGpEnMObhD9cebeOTpo+E
         uuIT92aZjFYZivmy5hQVJHX8fJFJDPUVMx1aYMVEHgA4At2pgLE3V053Wb/t2L8Gb8GO
         a/kwFV/O3Ef/8b2fADgHY32cyyyO/dTmTsutoQYiejCaccDScUBH60nXHRTlfjTl3LGt
         AF/pb/yU9DYO+kjNLenmrA1nRXJMpNwQggfrSTbC+9AS0m92c9DL6Ms+A3/wOVAej0EK
         lNybC0/qHKkH+rFA9cMlXEE4QLyS6CVZXzSTYOyHm3XMG24Mjiq5BfndBHNwMyXlQ/Mg
         QLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596684; x=1689188684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OOA/ytQLN+B3gWqHcQscrH2RGfHUDPpsGBgPoTwMwU=;
        b=bQeaM7WuhSfNUMkNM6a4s9icGV3liCB0YOv3PjjQaTgkh3f2mL4M9uULN64hsSnzs9
         DrZgD9EhYZfLIWQTrRhDLT6X+knxcqwyh1raokhbzqRBgvBzzZZE5tmFFutMG1IB87HL
         wLf5GvsLuKTOQGiHTbjHfCmyFSbXZpFP7S0binHSbcCtHuXi/MHuCyIt1lMnVuOJs21Y
         ND+oaWattSv8uum6EpKOsEkK6YA1KM7na+lNYAG3Nq1aVhhayzs8ZGz2Zq8DB1STdYcY
         hzKZEWXRTyUn5nRVBaIQ8KvrIP95VOn2BmxH8z672W8cI3dFzomq4h92fKxb7KsZFMj7
         16rQ==
X-Gm-Message-State: AC+VfDy1ANo56wKD/rYx2M5KAb262JcLQj0Gi90TZ0Dp7kekE3aMjY5X
        3Jlp7M8S74E1e/Wx5APuAJxGGez3ITu6gkfbjy+xtHSW
X-Google-Smtp-Source: ACHHUZ5kJ9Ts8hH1r36b3HYZo25DalArBDj1PkqRJv6R/2FQYkSp/gjvpguhX/6PkBYsyURQiz7scSpqX4offUdreoc=
X-Received: by 2002:a9d:7acb:0:b0:6b0:73fe:cf10 with SMTP id
 m11-20020a9d7acb000000b006b073fecf10mr7185541otn.5.1686596684199; Mon, 12 Jun
 2023 12:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230531174450.3733220-1-aliceryhl@google.com> <CAGngYiW_3HfebWZO5S=RXFqhNnsbnix-NaA0UGYRnRLd4SK65w@mail.gmail.com>
In-Reply-To: <CAGngYiW_3HfebWZO5S=RXFqhNnsbnix-NaA0UGYRnRLd4SK65w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 12 Jun 2023 21:04:32 +0200
Message-ID: <CANiq72=DJBW82L44icrrTo=_jrv=BS3cd10s6WuraXX7suW4tg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: error: integrate Rust error type with `errname`
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
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

On Wed, May 31, 2023 at 11:27=E2=80=AFPM Sven Van Asbroeck <thesven73@gmail=
.com> wrote:
>
> Hello Alice, as we discussed through a separate channel,
> you have my permission to use my name in
> Co-Developed-by and Signed-off-by tags.

Thanks a lot Sven for the confirmation!

Applied to `rust-next` -- reworded for clarity. Thanks!

Cheers,
Miguel
