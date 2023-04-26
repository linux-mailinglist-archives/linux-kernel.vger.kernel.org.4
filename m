Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF266EF8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDZREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDZRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:03:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF816181
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:03:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-953343581a4so1121015566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682528635; x=1685120635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rojE/Cf5Vc/Os78fxzdIb/ZWKVxlH85NFon6s3+eQhg=;
        b=S5KwTyJbCrYSpRgabEwuFA9OPMgLGr3CoGSMLx3UJiaoG2llzimB8Na4uKpzikb5dN
         lA4MX5tUTY8epkXLYywHGwvQr9jl5GYMn+WEKJSqFejCBbhejce4rUWv7ekF/5wBxznp
         HPKFT+B9iQy9OetVh8YE6V4kpo/qxT9I5bef0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682528635; x=1685120635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rojE/Cf5Vc/Os78fxzdIb/ZWKVxlH85NFon6s3+eQhg=;
        b=O6UV4lC70XGsW5g7LgKw1ZaihXr+cDDL36DmsaUe4JicHWxPXc8acKa2UgWs/e4IuI
         1A4I5v94nPbOsmKEGepVHZ9kOg/TEpjVlu5bTrE6VFd0IzDHrDWiuhQUwWfOr8d4uDke
         OOscnevdbBPonZ+xcJ9wielGjbydC6qmPur4SKUrivl8snbTOI+/WMFZaUrnLbvT0XzE
         V68/nHaJAhDQ4Xv2N1xe60/0axg3viPgjWbDT+pXHB31b3dID+GUw5dsO7rdXcygBB/t
         jEvKMo3ui3cdlCXhUwxSgJuB87A8LXuFsdAVYoABt0DH/Wx/oXFSDkWzOXkVSiu5bTlb
         FnNA==
X-Gm-Message-State: AAQBX9dLIUlz2nh5Cu7gCafx8MJ114Ami9e1lki+CHu9n13bWYr2VqcV
        +2wgaTM9K3OzbRR8EBAXnpbrZ90eI8dop30gBul/Ig==
X-Google-Smtp-Source: AKy350ZXeWAOVbJpwf4VS233fkmQo+QY7z3XOsy5LnP7l8+72rCkTYHMJJhfsDc4OQNACuJlKQtk1Q==
X-Received: by 2002:a17:906:3c46:b0:94c:784f:7569 with SMTP id i6-20020a1709063c4600b0094c784f7569mr15315789ejg.30.1682528635629;
        Wed, 26 Apr 2023 10:03:55 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id op4-20020a170906bce400b0094f39379230sm8458363ejb.163.2023.04.26.10.03.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 10:03:54 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-957dbae98b4so857251966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:03:54 -0700 (PDT)
X-Received: by 2002:a17:907:7e9c:b0:957:28b2:560a with SMTP id
 qb28-20020a1709077e9c00b0095728b2560amr18417571ejc.46.1682528634167; Wed, 26
 Apr 2023 10:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu>
In-Reply-To: <20230425041838.GA150312@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 10:03:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
Message-ID: <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 9:18=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> Please note that after merging the mm and ext4 trees you will need to
> apply the patch found here[1].
>
> [1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infradead.or=
g
>
> This is due to a patch in the mm tree, "mm: return an ERR_PTR from
> __filemap_get_folio" changing that function to returning an ERR_PTR
> instead of returning NULL on an error.

Side note, itr would be wonderful if we could mark the places that
return an error pointer as returning "nonnull", and catch things like
this automatically at build time where people compare an error pointer
to NULL.

Howeder, it sadly turns out that compilers have gotten this completely wron=
g.

gcc apparently completely screwed things up, and "nonnull" is not a
warning aid, it's a "you can remove tests against NULL silently".

And clang does seem to have taken the same approach with
"returns_nonnull", which is really really sad, considering that
apparently they got it right for "_Nonnull" for function arguments
(where it's documented to cause a warning if you pass in a NULL
argument, rather than cause the compiler to generate sh*t buggy code)

Compiler people who think that "undefined behavior is a good way to
implement optimizations" are a menace, and should be shunned. They are
paste-eaters of the worst kind.

Is there any chance that somebody could hit compiler people with a big
clue-bat, and say "undefined behavior is not a feature, it's a bug",
and try to make them grow up?

Adding some clang people to the participants, since they at least seem
to have *almost* gotten it right.

            Linus
