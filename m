Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F39663532
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjAIX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjAIX1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:27:13 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65CB49B;
        Mon,  9 Jan 2023 15:27:11 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 16so10178962ybc.0;
        Mon, 09 Jan 2023 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UY+1Fpt0FK7lLfeSUW68NLIUA8SVjtGE9huFocWEeKs=;
        b=RsPeIV8aR7aKfgIzo27xLUiVGHbaKd/HgO/xGdeCY4Z0KxryxI15LpnavV/6d0HkhV
         1cKBycFNaX2/yd8D6T4WqDnRfD8maa7cOcBxaCQcuuADA9aHi2YzyJELnsqub6TGp2wf
         TLdcpBx0OUvtWE1eg4dBoCmAq8geiYAFNLdlFnMZtTMP507iy8hRLh/oc1b1DZYFY7zG
         3PMnSMKODrz2VQ7e08Hddf+pM4njPz0TzM62IeX22sczwbtilNPm9m5402co2okNV6pO
         ncrcgvDkMhibTOzPPDsCz34FFZr1bUXGhPG99LWJ98CDztQ+QSI3cir8Erx0QRl60ZRi
         qWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UY+1Fpt0FK7lLfeSUW68NLIUA8SVjtGE9huFocWEeKs=;
        b=xWF7Q4mHNrcmsnNu1Gk/8sf2ROuHHjvI2KqgIZoITo7xNLKJcCyVJt4fM46VpjbaUu
         GcfotEP26TFIZlmlkaRVQFqRXVf0oMUnqwFV/ZJvVwkgJ4ZIKznhfls78/zhoXUoqwqA
         JReJ/vA5Wqysf7O+RRccZhYwBtR1yL/wgMqAp2jFHUSj0RQ1NweE3HmrFrlGN0yCvGC9
         itbryDTHQVGh39IpSy/p10evGjmBLJgWw6E4uoAV/8lKAsk/DeZ08qreHOyjm4312dkL
         z2yelZlDCvmR7LD+8nL/dBqQ0ZVqVf7Ii/G5kfKGIdHw6rYALiGgWJZNZ4yFF5sk6GEk
         Xzyw==
X-Gm-Message-State: AFqh2kr19cp8Go69JdILSNrjGBcTFmNQlolAYupU6YC0UP5w+PVDMbaV
        ifKvKNhsT8XJgKCgQp2kHdPg8ArGjQoOYyQ+V2dyShXUVMRsXlkxITV6cw==
X-Google-Smtp-Source: AMrXdXvrlbd5h1RWMBpkgFbj03OSP8b8iebn8qrpIDcVK3qInC9NLlZPapSxLJBCkgA0jhZXCtuRUWOP8uBZd2h4Q1M=
X-Received: by 2002:a25:7702:0:b0:7b4:bdd7:e631 with SMTP id
 s2-20020a257702000000b007b4bdd7e631mr2014500ybc.507.1673306831157; Mon, 09
 Jan 2023 15:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-3-ojeda@kernel.org>
 <Y7yZTBIF58+1Fj5m@boqun-archlinux>
In-Reply-To: <Y7yZTBIF58+1Fj5m@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 Jan 2023 00:27:00 +0100
Message-ID: <CANiq72=bqp_tPL9qq6OYBv1uyByL65_e4Bp4r8pfdBFf-2gBwA@mail.gmail.com>
Subject: Re: [PATCH 3/6] kbuild: rust_is_available: add check for `bindgen` invocation
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alexandru Radovici <msg4alex@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
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

On Mon, Jan 9, 2023 at 11:47 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Per Documentation/process/maintainer-tip.rst, the "Reported-by" tag does
> require "Name <mailaddress>" format. Given we already have the GitHub
> issue link, I wonder whether it's better we ask for the reporter's
> email address (and real name) for the "Reported-by" field, and if they
> prefer to not providing one, we just don't use the "Reported-by" tag
> since we still have the GitHub issue link for their contribution.
>
> Thoughts?

As far as I understand, that is for the tip tree (though
`checkpatch.pl` complained too), and I am not sure in that guide they
intend it to mean it is the only form accepted.

In this case, I ended up deciding to add it since it was not a
Signed-off-by/Reviewed-by/Acked-by (so not as critical, i.e. no
DCO/RSO/...) and there are quite a few other instances, including
different CIs and tools, raw emails, security teams, etc.

So it doesn't look like it is required to be a "real name" like some
of the other tags, and sometimes we may need to do otherwise anyway
(for those cases), and I guess we don't want to discourage reports too
much. Perhaps we can, at least, ask for an email address -- that is
way more common in the log, and gives us a potential way to contact
people and send the patches to.

In any case, I agree we should prefer the "real name" way as much as
possible. I had sent a message to each GitHub issue/PR linking back to
the patches, but I will send another to offer them to use their real
name if they prefer.

Thanks for taking a look! :)

Cheers,
Miguel
