Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B906742AF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjASTV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjASTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:58 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388F9CBB5;
        Thu, 19 Jan 2023 11:20:08 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4fda31c3351so12357377b3.11;
        Thu, 19 Jan 2023 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2y96hSgZOdNiQi3iVUDGW1zmbq/2ZeqfDpIjbWl/+AM=;
        b=ReQBSuZnjQ/Hzn9MjrayyI00pkEWhj7Djpqlg/g38iGqjIo4Sq7re3LPR5NKsWo9Nm
         rmijSW7CCq1C2Qdp7/ky7GCkKbPD6xEDKXk305vsRjjmvhP21tX3QKgIjkm4F3ckbHnU
         3rsLopUK6HQfuzAeTV8Gfeem6hCoLYXkKH10aIMTpV67Itec0/0QpXWGecCbZyWvBxWi
         HMb29GK2QtB8DekCsdq6oAVcEzk4KtxgxCvfmYU+Dt+rTUuSwLkYqHnEr/te+cjWSrxM
         NZ3B4MJ4fDhLb0uqTI/T9CcOhWI9zQWWGgQxqW0IustVc/+u90vkW/tlIPMHHewHNDmv
         Ynbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2y96hSgZOdNiQi3iVUDGW1zmbq/2ZeqfDpIjbWl/+AM=;
        b=s47YwG/hj2TSxc9ceJNIXtcSGSptBOHvndYZieGB6XQmaQtL3z/iBAbCTWu1cWNkum
         dzmceLzNiNz7kJc40IwB8wp/olu7YWJq0RvM5dPbLrsa8V82ZlKln+i6PvA5k122KlMm
         3LR62dN8D52KwrKalMlVe66mibNGcV6PyFalaPTLT26DvPW+iLxaGK3gpG8HB4cn7qnL
         sKDaOULv4x36GF4IYvmKHpXgpNx91IdVBowJ9uYuahtyhrYqCw+fnhGDlWfbGUSdz1NB
         Umw51BHSkdm7RhCb1X2waM0uS3dbnU63eHq0WaC5D6zlLk5IdD34c6QFVX8Qof+y6T3U
         KzlQ==
X-Gm-Message-State: AFqh2kpnDO9Js3SdTficsXztiMDjDC+y7PGzoWHV4O8uHpI9K5PIciwP
        7G/ZV0Jednc9CQukPTFuKMo9q1rMS09n0SViP1w=
X-Google-Smtp-Source: AMrXdXuhMbeLfhMzO3dNO8FM0BS93W/XkG/FHlqBpBtG6GK7C62jMILFqgYHbTQjwIRvsrMCEslAihTwcRRHs+ouDnU=
X-Received: by 2002:a81:5402:0:b0:3d8:8c0e:6d48 with SMTP id
 i2-20020a815402000000b003d88c0e6d48mr1018356ywb.462.1674156007567; Thu, 19
 Jan 2023 11:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20230111161155.1349375-1-gary@garyguo.net> <20230112214059.o4vq474c47edjup6@ldmartin-desk2>
 <20230113181841.4d378a24.gary@garyguo.net> <20230117175144.GI16547@kitsune.suse.cz>
 <20230117192059.z5v5lfc2bzxk4ad2@ldmartin-desk2.lan> <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
In-Reply-To: <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 19 Jan 2023 20:19:56 +0100
Message-ID: <CANiq72n4MbR+AE7eHfVQZOu26FeSttQnEEMT3Jpft+CcGwk9jw@mail.gmail.com>
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
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

On Wed, Jan 18, 2023 at 8:02 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>     - *.mod.c is kept human readable.

On the topic of `.mod.c` readability: for approaches that may be less
readable, we could improve that by adding some extra comments or
rearrange things in a different way (it is a generated file, after
all!).

For instance, for the original approach: https://godbolt.org/z/6oh45axnc

Cheers,
Miguel
