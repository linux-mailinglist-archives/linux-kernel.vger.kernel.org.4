Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D95FF39E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJNSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJNSfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:35:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585074E19D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:35:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d26so12297869ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dlOttIcbfyJ9Meuwl/3DVPLPY7LTZL8V6KpgIWHa/o8=;
        b=bo+sSeamjV3ogFeVE4woZcjggXzUoZaHSUx6jp0WPOZzpXDNmcc/cEcYdKtM48zH7e
         Q8hrssyWU3nff+vqi1+2UwgCpwkQ9mNZwhoxtCYtoyOImHoU6sr2EgS5FSVJHeHv72Gx
         ivMoH1EYL5oEpkIYp3Altv+OuFDnh25XvMft3oq6CAX7Lg1bHdcRUDF5uanM4EvvYYLH
         ScOMwLnABxganJ5jJ69lPKPQm06FeCCSHiH114ov0w+bi1KMynXHAw6J/ybjpBOkwQ60
         Njc0xgYtm7geqQcvVxY6MqZQHxUA67w1M6uCS77zWiYeNi3Td5G/+xAI/uKs52rqfCAx
         VPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlOttIcbfyJ9Meuwl/3DVPLPY7LTZL8V6KpgIWHa/o8=;
        b=E5ZsnAxKsqdvhEI1QizrP+lTIYsLEMnUizQyg6kuQg9AuV4M5/BkUanGw5YTwD7uEh
         CrnVWU2/QJaDa7PlVjfWl4mTDKwRAvGcbm68teinez62jj+Ju9x4OFp7oOaeC9j8Npsg
         +KsRnsrj+WIUt8SdORlvqdaLY7uvP+XOrrJP5tW/7n5fRp7tqZT5Zm8CLh21iHgwPzkn
         zb6mRXbO7yD/N45/0qUsv9yG/qtYEF7oQV151ezXpctfiLRj3AHBACSTWLiLN04Rmwck
         bI3qu/a8bx5oBVIEvKP4LAXb8SKgLe35Tcg0ngY7KD+a9Lit2PQPw+r/8rdaOKpYHXMn
         jM2A==
X-Gm-Message-State: ACrzQf0YZVqfki8Wj1gJ+5uRDe9FRFy6h+8XiNzRFHmM1yfwDV1nvxTj
        mtbF1+ygyl9o+LzGgDjYCfahk3H9RRngNBOBZRK6+g==
X-Google-Smtp-Source: AMsMyM5PxvI7q1eLhIz1kRuPl4pgKS5NxzGTkhgVaLLpKkixQpMznDKsv3NsRyMn7CuF+C/HYyOrjzaNom7zJdwX7EI=
X-Received: by 2002:a17:907:e93:b0:78d:46ae:cf61 with SMTP id
 ho19-20020a1709070e9300b0078d46aecf61mr4483765ejc.579.1665772507710; Fri, 14
 Oct 2022 11:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org>
 <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com>
 <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
In-Reply-To: <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 14 Oct 2022 11:34:30 -0700
Message-ID: <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com>
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 11:05 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 11, 2022 at 1:16 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Rust supports IBT with -Z cf-protection=branch, but I don't see this
> > option being enabled in the kernel yet. Cross-language CFI is going to
> > require a lot more work though because the type systems are not quite
> > compatible:
> >
> > https://github.com/rust-lang/rfcs/pull/3296
>
> I have pinged Ramon de C Valle as he is the author of the RFC above
> and implementation work too; since a month or so ago he also leads the
> Exploit Mitigations Project Group in Rust.

Thanks, Miguel. I also talked to Ramon about KCFI earlier this week
and he expressed interest in helping with rustc support for it. In the
meanwhile, I think we can just add a depends on !CFI_CLANG to avoid
issues here.

Sami
