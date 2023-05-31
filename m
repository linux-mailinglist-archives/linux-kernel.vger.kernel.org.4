Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFB71880A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjEaRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjEaRFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:05:36 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736EBE;
        Wed, 31 May 2023 10:05:21 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5584f8ec30cso710424eaf.0;
        Wed, 31 May 2023 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552720; x=1688144720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnVlMYKUBLV9HUzSs68t1blEmRLxmElAxhgHhe4Ab6g=;
        b=LObu1CyQEOgrJqwtg8BIxxNa9IyYSEU6G4ejrrgtIh0hV4Z4M2MfgfeXFzMGCnGo8A
         RdTYMhlDAoH+s2JutH/e9prQVCl0LpYOyyibxFY5/ixg3MbJ4c1/oHgvspuHhdHWt4ws
         xV87IGi2Q5QGuZd9zA/XvrdbF+O7/KlMWohjUFZSlplYYD1KvxaPTFzbs0RM6Qc879XI
         nddWb1qKutPfHDC2AI//Opx3AmQY19vGbgJ07FMZ4nqm2c6I9LCgLCKxRnAtuHNYZF25
         ItphmW9iTqitZn9/XfHVEjI2PeCzxRkNNtpUr7cpi0pw4cHXdbvUB6GPs0O2GIEFN29B
         itcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552720; x=1688144720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnVlMYKUBLV9HUzSs68t1blEmRLxmElAxhgHhe4Ab6g=;
        b=kL0zncX0v1oRZZW5xVC/Zws1pOYKqfjCeEfVk340vKCGAPVJHCg+MZG4UjzLUd9zT5
         rGOd3DBH8EokSC6/deeYgb3j+mPT60fg07WqH/naFmFlw0CHJLd9D+gfXhm8QJ4gp5tg
         J+9LdLoWF9NLRosI8UqrxpuVdmby9GkCWbgqkAKMHOb9QGZMJ/+ZuHrACoMowfhP2ogo
         rEhFCcPl5w0qlJNWQnuG+lF3UcrYgvae5wXxqUwZE+j4U34EoIFpBfPWyyN9Gl+5P8YJ
         9e1nJu83IA6+qWRV4YTBJ+AQyyrXyaTaNm9mDZ8pl28UaXe/gkNz8Q5q4rZH4gth+NDb
         3FOQ==
X-Gm-Message-State: AC+VfDzNYz3kOUNrvJuyMxPMudgc6BRlKBUJq4Gxh437QD+sXaNMRWn5
        GHrT6+QB4dIRLj7c0cLmInI/0vYye24EIfGgTsI=
X-Google-Smtp-Source: ACHHUZ73RZ+kXBFKRhveo7QTtajTevWdAwLtHSNQQGxqC/rFsYseQ9lyLFW/3X3dANcpSkOp7cZ29Tt66OszSzx0/gs=
X-Received: by 2002:a05:6358:6f08:b0:123:1741:dfa9 with SMTP id
 r8-20020a0563586f0800b001231741dfa9mr2427191rwn.25.1685552720406; Wed, 31 May
 2023 10:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230306220959.240235-1-ojeda@kernel.org> <87ilfcivzf.fsf@metaspace.dk>
 <CANiq72m_y=eCsJLxRP+bFvhmR5yAVK7=W6Hijb_CozWnL__dQw@mail.gmail.com>
In-Reply-To: <CANiq72m_y=eCsJLxRP+bFvhmR5yAVK7=W6Hijb_CozWnL__dQw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:05:09 +0200
Message-ID: <CANiq72=cCq=DqNrqtf3xwu8_A_YuudS3m82jqU7457OeYTRAFQ@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: point directly to the standalone installers
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Tue, Mar 7, 2023 at 1:45=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I think I will split the sentence and add an extra link to the other
> fragment, since there is one for that too (`#rustup`).

In the end, I did what you suggested Andreas; in part because their
front page has slightly different instructions (opened
https://github.com/rust-lang/rust-forge/issues/684), and in part
because adding extra links to `rustup` is better done in a different
patch (perhaps explaining what `rustup` is, too).

Cheers,
Miguel
