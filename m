Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A37704144
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbjEOXDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjEOXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:03:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE125185
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:03:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96aa0cab88dso691640766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684191791; x=1686783791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKOCYYZhrcXCBpj5u3tDd9MBX2qjyYOiEFbdtJlTHzY=;
        b=Tm54eW2KsZuCP8z16TJjmAI0Zg/rdQzWno0YhfnIWovY6jQ1nCcZpEou7AKTBey6FW
         7CRi1QTifEVMD9Z3zgB21RKKbyG5voar0+aQP7lIP5W9HGQg7Cb+z+DequkAfaOif44d
         sMwbuYmc5cR7PuecUnkswHIJl/VJioebIBo2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684191791; x=1686783791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKOCYYZhrcXCBpj5u3tDd9MBX2qjyYOiEFbdtJlTHzY=;
        b=jmpoALnEfDVwO/2Oc/krmT1Z5TR8My6k0Kbe3uhKOu5fHex0zqo20B2WvC2Xp5vY9F
         aYsApIzOnghzpja3g+R+g2kaTh+Bi4fiFO/7nv8fkeGTlhHslf/DaXIQ84SkrDfPtulU
         3WKL33oNgyRJcds7jEy5VaIEOEX9yCYBMZ6JzBJuzuEBJ6TTR+HBGyV7PfO+g48lPPSY
         JhNte/NgNbz5MPQoFSfMWvPL+3tJrO48SzcC8M9vxuwnKgeiPwjTaUxn3oTbjtpMwj1g
         1mUlY7LiGGcoclKrxM8zAp5C+xvzCSRORiN0A2p+TlruH7JASh7vJuszb92d9ujia4Tf
         BN+Q==
X-Gm-Message-State: AC+VfDxRJIrkOkq3M5g1oIRTl6eMeYgu6MVdGKq2CJMH00Pl9VnJtoIJ
        dKKQ6ApZS79bzVJQsuCX399bSwWbQvn4oMlaQisDvgBZ
X-Google-Smtp-Source: ACHHUZ4KskB7aLP9rbHOLbqXQv1wtZthzlf9FKw8Nh4uZjIKzPdBppR0bRGfy5dwr+LNVRDb6LidFw==
X-Received: by 2002:a17:906:ee86:b0:962:46d7:c8fc with SMTP id wt6-20020a170906ee8600b0096246d7c8fcmr35038699ejb.21.1684191791066;
        Mon, 15 May 2023 16:03:11 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b00965bf86c00asm10342426ejt.143.2023.05.15.16.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 16:03:10 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso20150903a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:03:10 -0700 (PDT)
X-Received: by 2002:a17:907:36cb:b0:961:272d:bdb9 with SMTP id
 bj11-20020a17090736cb00b00961272dbdb9mr36642667ejc.43.1684191790244; Mon, 15
 May 2023 16:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com> <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
 <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com>
 <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com> <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
 <93ae88a4-1dac-77bf-37f6-f8708a6d83b7@intel.com> <CAHk-=wgZvH9KZPVbeTeLKwnv+bO4x15JVjeqWX68-+pmbsxJCQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgZvH9KZPVbeTeLKwnv+bO4x15JVjeqWX68-+pmbsxJCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 May 2023 16:02:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFYCZzD=_y3J_sKh504_+ch_xqEo76piVm2ySUy_-nGA@mail.gmail.com>
Message-ID: <CAHk-=wjFYCZzD=_y3J_sKh504_+ch_xqEo76piVm2ySUy_-nGA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 3:40=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>         mutex_lock(&mm->fork_lock);
>         if (atomic_read(&mm->mm_users) > 1 ||
>             atomic_read(&mm->mm_count) > 1) {

Again, just to clarify: at this point the mm_users/count checks are
purely a heuristic. If they are both 1, then we know we're *currently*
the only user, and the fork_lock means that no new users that matter
can come in.

If we race with things like /proc accesses that have raised either of
those counts, and we happen to say "ok, we're not alone in the
universe", then that just means that we fall back to the slow
thread-safe path. Unfortunate, but not a huge deal.

The slow path is what we do right now, and while it might be a bit
slower with a 'lock cmpxchg' instead of a 'lock andb', it shouldn't be
some *insanely* much slower case. So what we really want to do here is
an optimistic and cheap "can we do the fast case" for the presumably
common situation where we're really just a bog-standard
single-threaded fork.

IOW, the mm counts aren't somehow semantically important, we're
literally just looking for a cheap test for a common case.

That's my argument, at least. There may be flaws in that argument,
like some memory ordering with some exit() case that decrements
mm_users, but those should very much happen only after the exit() has
already stopped using the page tables, so I don't think those can
actually matter.

Keyword here being "I don't think".

               Linus
