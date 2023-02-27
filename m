Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC06A433C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjB0NtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB0NtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:49:03 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5CF30D7;
        Mon, 27 Feb 2023 05:49:01 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-536c02c9dfbso176058687b3.11;
        Mon, 27 Feb 2023 05:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsIz50zjyJWoV4yTGujEpF6auIkGsJx425uJLy5GoWg=;
        b=mziWa4DuN7lEcg+EmTxmyEVoPTTO4f3VzO52ePtD+mVYj9IG8XSb7PqOP5TYipj0LO
         ZHJICBSNhvI2lS50six5WhTisF/0wkZoRAdJxRI+e3WorN/lQeOwZKAXgzCti1mDzkHc
         /0iLGth1vrQFUW9e+awc+9LpN3QMOlDSsr7yHvQvq6b8zEcBpmISJcB4iZHhms5tc3mj
         wpWo2hMsKFdMdeILOuZ1WEfHN8ZxpusxEYo5BLdkKn9jwOZcSCAjwgzL7L2F5hZFC/2L
         qN2+AthmKkcTemKKw+7pm48M8v9I3Orc7RPmWF2e9zA89PLy4yL0zjirix55oVF7k/6E
         iSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsIz50zjyJWoV4yTGujEpF6auIkGsJx425uJLy5GoWg=;
        b=MetsKhWEUAj8b0JS+TFqfbtdynkz3k9dlInX9/ps+SHPl195yl2mk/R/srKEPvjxy+
         xw8FEIjR2HdaOMWXj8XaU7Bpquhg9/DIMaYd9zUW4xSn7lXAsR/5Ih20P0iwruFHMRdr
         G29u8xlOXM4c70zENcIBTqFN+CYjENjB2+ToSJJXrsk9URF1Hj90wGq6zlBmnagOMf7j
         E023JUniBIyS87ghaoqETI7WiFS3DOZ7B4Pwm1UeoI1CDaEv26vwCQF0knMLLqjFHR3B
         BKN0LgPl3mGe7ZPTI5XsMWEd9sydBjcHUlHve4ozJ+nHMxb13QUwpL01VMDL6V0iuix/
         Fbvg==
X-Gm-Message-State: AO0yUKWeGg7MfOSFLfsIQtIeAfKm4yZQdxw49418S+aaJeUJaSeAiAzj
        +EabZFOeT76in7xW3fiOPJqF0eblf2woqSiOzec=
X-Google-Smtp-Source: AK7set/Gy9HX3Hc99cqeB48DmPz48RcGzSSWrCthvZvgP3KcDblaI61+VePiCAujvESdltCKxw7O/OBDCOX8Apm0TNs=
X-Received: by 2002:a5b:50b:0:b0:a36:3875:564a with SMTP id
 o11-20020a5b050b000000b00a363875564amr7639099ybp.2.1677505740979; Mon, 27 Feb
 2023 05:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net> <87pm9v9rmg.fsf@metaspace.dk>
In-Reply-To: <87pm9v9rmg.fsf@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 27 Feb 2023 14:48:50 +0100
Message-ID: <CANiq72=Q2kUihi2Yve5b9LGZYreEovrgqfjWb8WhPRtNWfq+wA@mail.gmail.com>
Subject: Re: [PATCH] rust: Enable the new_uninit feature for kernel and driver crates
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 2:15=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> What is the purpose of adding the feature here? The kernel crate seems
> to compile fine without this.

`rust_allowed_features` is the list of features that crates outside
`rust/` can use (e.g. drivers).

The goal is to control which unstable features are used outside the
`kernel` crate and to avoid mistakenly relying on them.

Cheers,
Miguel
