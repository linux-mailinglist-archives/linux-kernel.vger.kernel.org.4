Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD07163D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjE3OXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjE3OXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:23:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89D10D1;
        Tue, 30 May 2023 07:22:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso6372545276.1;
        Tue, 30 May 2023 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456525; x=1688048525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jh6LcDY7P7T8yfLhT0DmS4U1CqwRWBIBUieCoRWL0M=;
        b=sgoKzqZfRp0hfI5s/9CKB1GdmFnm6Np7T/R/CIpwIt6KTVsWNn3xEp+h5XhvEwc/JB
         wQGQeiMW9+IzNnQ36AdZMEWGFCk3ZFznd0+oFYXVti+kxGuH8qD0F4q5cP/rvh1RroLg
         kNBwcqBMOuVsZYIQombYe9fxODb825w0ZVaOzMOu83J6ADvRI/l0qflb57jqf9VZMyCy
         V2IQACKVZvN37C3PeXabtyW9Me89fR2kD7wywNLSMDAVhw/ujSMd9vEtBqOw46mh2gBA
         rZG0y5tSfOm8MzGdsdYBJv0OgSbm21fXwRWrlV8QpVkSg9JHDio5Ruv2GHLPfZXidnb3
         qFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456525; x=1688048525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jh6LcDY7P7T8yfLhT0DmS4U1CqwRWBIBUieCoRWL0M=;
        b=GlPpuQcLB4ly+xfbYk7R9MeT2ftJeKjDGtqiIxBlvcQbLTOcdhVE20FJ1EnP8+fXW0
         6xt4VsG2zRualtjURE5KeWKxHc+i+7vZZTJilEQgF97XXNXTb9fBlVVEWwsyWvb74VP+
         amBq7Ay26Yu7HfS5WVCpL9cz4xF8FG+T3nBEEP6S4erF6wiZca2xNW9sMfxCxCvPsZqZ
         UWYLHqkiIfgyOpCdui7MKMMe4lbvqZMCeJ+z6F8pnW32hj22PtsM9/tgHAX3IIwNKztd
         2zxHwmDmP5AVFYEVPupcFJVc3g9Igic65G+CQJdiidSskFj7+ZEw1D1+hHJsgERqtri+
         PHrg==
X-Gm-Message-State: AC+VfDzdxjQ9+nrbGDLUodEnh/flqrdvXA2JxyJL0z+jQ3UQRSa2fyOv
        L1vMBDnxZBJtTCfNsVQkXFMMAXU8cvEsIF8wpUo=
X-Google-Smtp-Source: ACHHUZ7GPn+dc6IDYTdATPz8zQ9VOnil9TacegtHgk83Qh3Un3O4GV5XOrrxJuPGFvUtBPi4+aQR46GGt/EhYJV7VH4=
X-Received: by 2002:a25:d688:0:b0:ba6:9e94:ed26 with SMTP id
 n130-20020a25d688000000b00ba69e94ed26mr3390464ybg.19.1685456525593; Tue, 30
 May 2023 07:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com> <20230530064821.1222290-3-changxian.cqs@antgroup.com>
In-Reply-To: <20230530064821.1222290-3-changxian.cqs@antgroup.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 30 May 2023 16:21:54 +0200
Message-ID: <CANiq72ntH+6nBHLpwbYbja189TX8WvOpD98=xNROPXPfmuwjtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] samples: rust: add `SgTable` and `ScatterList` selftests
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>,
        rust-for-linux@vger.kernel.org
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

On Tue, May 30, 2023 at 8:54=E2=80=AFAM Qingsong Chen
<changxian.cqs@antgroup.com> wrote:
>
> Add a selftest module to provide a temporary place to put "pure tests"
> for Rust funtionality and wrappers.

Thanks for the patch series! Quick note on this: the `selftest` sample
module was a temporary place we had in the `rust` branch to put some
non-doctest tests until we had a better way to run them.

Even if we wanted to keep this approach for tests like this, this part
should be in its own patch -- that way you can credit Boqun properly
and avoid adding his SoB on code he did not write (which he may not
agree with).

Cheers,
Miguel
