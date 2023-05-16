Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5FB7058FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjEPUjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEPUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:39:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C61BF4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:39:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso25697471a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684269549; x=1686861549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpDlsq4DWXJxkzFXNYYIaH5Li3Jq/c277d8BOdohRpo=;
        b=GPXrfczHAAHCLWWgY4VLG9dyPiG7grI7bz4KKuf2nHT8vF1XxoZVNPXq8fILDHvs1K
         uaj+/RJOHGCDU5GCYcA58Tczg9yoWT2vPfmSPVgQj3F7R9vbuI5gypdD9seeMfaMO7nL
         S7HQh7+om2VRs6N7d7uP6kRl8xzdmZ6dtBp6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269549; x=1686861549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpDlsq4DWXJxkzFXNYYIaH5Li3Jq/c277d8BOdohRpo=;
        b=OIYFgD/BlvdfakdUqnQgN5G02PPBEswHdWbndosqDQ+Ru5ksCQF8EgBbDE/Ub2Xh/4
         trk0ImreVSkgFj255kHjhuzJfiKyFTemvkrsxEvkkommc2rS1KWZFOIGZSgjHvK3Usl6
         QhQ3GXLtGmS/4bdQ7RAGKuz+OogK2nJz1lZ4/XuE09HidDwJo/pHc3f9j0NklHcVjnc0
         u7PSx0te9FLED/xuqrxAIIMjyVwO0jVSJBgjmL8HttLE/prdY29cjCuEDmn/jleDqrFS
         3h9cmKgVtLxBBDhdTwOpLog4DTS5lJvbfnwA/g57E6EuAOHnLHh8uzEQrC3GwDAJrCK1
         hk0g==
X-Gm-Message-State: AC+VfDxkBBzFl3IvzNvOJEbpw9Kc/dwNACKLCowUshEmXerrWf3+ctJk
        79YB46y0cZrydJb+Qq14iAILuwhSE/kD2YXWhGUbRYrT
X-Google-Smtp-Source: ACHHUZ46kCZYofviICZaui8fCHYyYFlhyCKMceXPMDKYLiZ5iYYCmqHCMd1wi1uSh0wrvXQMXZidfQ==
X-Received: by 2002:a05:6402:3d0:b0:50b:c377:e7fd with SMTP id t16-20020a05640203d000b0050bc377e7fdmr279453edw.15.1684269549322;
        Tue, 16 May 2023 13:39:09 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7d358000000b0050bc6c04a66sm8527313edr.40.2023.05.16.13.39.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 13:39:08 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so25731360a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:39:08 -0700 (PDT)
X-Received: by 2002:a17:907:3e13:b0:94e:5679:d950 with SMTP id
 hp19-20020a1709073e1300b0094e5679d950mr41167904ejc.72.1684269548354; Tue, 16
 May 2023 13:39:08 -0700 (PDT)
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
Date:   Tue, 16 May 2023 13:38:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6TWSvb8Lk5uEu=QKQRFj7vewMsqLhuah4_7r2S=dXWA@mail.gmail.com>
Message-ID: <CAHk-=wg6TWSvb8Lk5uEu=QKQRFj7vewMsqLhuah4_7r2S=dXWA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 3:40=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I *think* fork() could do something like this:
>
>   struct fork_cookie; // dummy type purely for type checking
>   static struct fork_cookie *is_singe_threaded(void)
>   {
>         struct mm_struct *mm =3D current->mm;
>         mutex_lock(&mm->fork_lock);

Actually, let's not even bother with a new fork_lock.

I for some reason thought that fork only took the mmap_lock for
reading (because it kind of does just read the old VM data), but when
I actually look at dup_mmap() I notice that what it does is actually
just

        if (mmap_write_lock_killable(oldmm)) ..

and so I think we can just use that as the lock.

So then all we'd need is to use mmap_read_lock(mm) in kthread_use_mm()
around the mmgrab.

I don't think we even need it in kthread_unuse_mm(), because
*decrementing* the mm counters isn't even something we need to worry
about.

How does that sound?

                Linus
