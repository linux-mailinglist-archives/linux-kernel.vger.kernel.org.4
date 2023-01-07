Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43921660FDB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjAGPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjAGPMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:12:36 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202846C290;
        Sat,  7 Jan 2023 07:12:35 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4b6255ce5baso58598837b3.11;
        Sat, 07 Jan 2023 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2lZ+M87fM3OC8ADWh+asZe0Znlz2AE5Sx1l9VbP98k4=;
        b=V8lP6HTKKTqb5Sv1FQFYQmNk2m90VJmKLCYgfid7m2v8MtZIQ8bf+pNKPRapSqIeKh
         ojeFEmY57v4gbu8amvrJ/pYYc6LJUZUVYaxXu7z5rI7q0ng7wr1ur3dpJ100FNtmUynP
         qf5RcN5LR9ElXzsvR0P7BZCQm85ubZS0wqZe5uSn4dJ42t+9q896Hy2118L6hF/+awDk
         i7K5vVzuyeF5/vQqj+tihq/KdcwziXDaGULicEu2UhDWykrWFKuirFAyo3eUYIA2q07S
         t35qYQsF7fYZ7B5Ew4GLuQmTJPJfqIO/uRIvNjmQ5PTxQJTXILcb5mnZFdFv/CkLQZ+V
         nUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lZ+M87fM3OC8ADWh+asZe0Znlz2AE5Sx1l9VbP98k4=;
        b=pgyaCGTeWD+rQ5QnKchH/FT4p3sbb41JqUcUc+LoSabW8vFca05+k0XDVAcXJiUf58
         6VdLxcsN7ReqmTmyJAMfemDZ5ifXaDKpXzrN5aqeCf5+anPhLemiPKmNB4rDO99e0sz7
         lTYM2Ej638PFRf8iqayYYxQlq7Yt9ccbOgvREnWWuOBO2Q+u5LrvfMdyW4odQjoWLOUE
         Udzy1ATx5J8usNQ8iN6c8JNxIBpm/QzYuSQUs3lCmgDQpQZJrhL06TqU4+0jtislOz/Q
         uRdCCrWZGVVUVuPuVvwGIElW2eQqeSytcfx5R3yKo7o6aIKAAp/dKVxl0IxC06v13p8z
         SkgA==
X-Gm-Message-State: AFqh2krqufmfo+mJD90IdxWy8x9vkj5RQHZ9+hB3JaGT/dwRrLZtd06L
        ZYI5zo0hfbt8Wv95skH2acOdZzlMoj72JAAPUAQ=
X-Google-Smtp-Source: AMrXdXu7TDFj4AQFL2MK3k2kqI7w7EQzHTOFeKBMoJ5n/8Ho5xlJK1pCtddeDiyk2b8bPgR6heiOSJgzghp1ooCFdB8=
X-Received: by 2002:a0d:f601:0:b0:3d8:8c0e:6d48 with SMTP id
 g1-20020a0df601000000b003d88c0e6d48mr565622ywf.462.1673104354305; Sat, 07 Jan
 2023 07:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20230107091820.3382134-1-masahiroy@kernel.org>
In-Reply-To: <20230107091820.3382134-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 16:12:23 +0100
Message-ID: <CANiq72nY9X1cyu=3MwfRKTcxMUNHRTUGPFC7VR=OtL8V-NPQog@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] kbuild: refactor host*_flags
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Sat, Jan 7, 2023 at 10:18 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Remove _host*_flags.
>
> This will change the -Wp,-MMD,$(depfile) order in the command line
> but no functional change is intended.

Looks fine to me. I gave it a quick test with just this patch on top
of v6.2-rc2 and checked that the order indeed changed (was there a
reason to not keep it the same?).

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
