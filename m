Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A466EFC92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjDZVkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjDZVkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:40:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082351FCF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:40:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-958bb7731a9so971138166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682545214; x=1685137214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFtlN+f5KTeNyVfIo3GYR/FbjWj+5XTUcjpUzFHTqqw=;
        b=NxA7fGb90DYgrw3VB2AyxOK4K1MqvrBOQRzy4V4Se3lVrknTQUU8QFETzwkFz2YZE6
         trXekjQGVZp8yEhIg0WHnvJlC9WEuOBYcPmg1Cs+vrK2QqWUFAudTzt5SdA+G37VDOpa
         YFXivxONWq5ZD/rQBQjXXVnFAGlYkjEg/xWnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682545214; x=1685137214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFtlN+f5KTeNyVfIo3GYR/FbjWj+5XTUcjpUzFHTqqw=;
        b=U7LAC9pbO6Wt1SsKSsysR+Q7r156SwHX0Fnu5M/0aaimU3uOkNUTMCULp6+Axt2g0P
         LOUDy4+jhgVxJ6/3o7VIOXb/ZkoYy/9marp/Mit1wJaoHVRYYPScgdVibjfoNLFdJ78s
         hGN3hKbWmwRJBOswrR65WBYzKAzoYpRYh/Deuu60RjyH5JbYOyU5GqPrJWL6C6FYM2SU
         TExTWc2K38c89JqQsd/5Qu0p4Cfb5ihBsjBCay5DI2VXxggmbmYLusZQAiKHnWW39dvb
         detEBbU27i8xP7j0eUeHSYhsBP83pOvzAl55oso9FMkrjbuxixbtL53Nz8L+FONSNl2K
         AsXQ==
X-Gm-Message-State: AAQBX9dPeJ7Z+EwpNs7SVDXQZxxplc4NQZhA0OvcZW+W563dHLhtuAQv
        t8ooHmAJ1z0tVOBFBhvH+RaxgDqgBR0OlRwSekES+w==
X-Google-Smtp-Source: AKy350biCIS+DbQnCRdVc2W1ZFJYAPOnVMhWHoVmNuxvc43K7vOAYLWB3FkPmFyo5chDfwImcMtr9g==
X-Received: by 2002:a17:906:9b92:b0:94e:d611:836e with SMTP id dd18-20020a1709069b9200b0094ed611836emr20076438ejc.21.1682545213847;
        Wed, 26 Apr 2023 14:40:13 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090614d500b0094b87711c9fsm8736003ejc.99.2023.04.26.14.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 14:40:12 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f2548256d0so127225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:40:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1c12:b0:3f1:926e:c941 with SMTP id
 j18-20020a05600c1c1200b003f1926ec941mr297wms.2.1682545212312; Wed, 26 Apr
 2023 14:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com> <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com> <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net> <ZEk/uVlbX2wWgagN@casper.infradead.org>
 <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com> <ZEmXH1FpOgT/u6/j@casper.infradead.org>
In-Reply-To: <ZEmXH1FpOgT/u6/j@casper.infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Apr 2023 14:39:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xkg6XgSL0VVVUMm+8xQ65oDgKoTgG0qHY7ALBE3xhCmg@mail.gmail.com>
Message-ID: <CAD=FV=Xkg6XgSL0VVVUMm+8xQ65oDgKoTgG0qHY7ALBE3xhCmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 26, 2023 at 2:27=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Apr 26, 2023 at 01:46:58PM -0700, Doug Anderson wrote:
> > On Wed, Apr 26, 2023 at 8:14=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > I'm not generally a fan of lock-with-timeout approaches.  I think the
> > > rationale for this one makes sense, but we're going to see some peopl=
e
> > > try to use this for situations where it doesn't make sense.
> >
> > Although it won't completely prevent the issue, I could add a comment
>
> People don't read comments.

Agreed, it's just better than nothing...


> > > Hm.  If the problem is that we want to wait for the lock unless the
> > > lock is being held for I/O, we can actually tell that in the caller.
> > >
> > >         if (folio_test_uptodate(folio))
> > >                 folio_lock(folio);
> > >         else
> > >                 folio_trylock(folio);
> > >
> > > (the folio lock isn't held for writeback, just taken and released;
> > > if the folio is uptodate, the folio lock should only be taken for a
> > > short time; if it's !uptodate then it's probably being read)
> >
> > The current place in patch #3 where I'm using folio_lock_timeout()
> > only calls it if a folio_trylock() already failed [2]. So I guess the
> > idea would be that if the trylock failed and folio_test_uptodate()
> > returns 0 then we immediately fail, otherwise we call the unbounded
> > folio_trylock()?
>
> Looking at the actual code, here's what I'd do:
>
> +++ b/mm/migrate.c
> @@ -1156,6 +1156,14 @@ static int migrate_folio_unmap(new_page_t get_new_=
page, free_page_t put_new_page
>                 if (current->flags & PF_MEMALLOC)
>                         goto out;
>
> +               /*
> +                * In "light" mode, we can wait for transient locks (eg
> +                * inserting a page into the page table), but it's not
> +                * worth waiting for I/O.
> +                */
> +               if (mode =3D=3D MIGRATE_SYNC_LIGHT && !folio_test_uptodat=
e(folio))
> +                       goto out;
> +
>                 folio_lock(src);
>         }
>         locked =3D true;
>
> > I put some traces in and ran my test and it turns out that in every
> > case (except one) where the tre initial folio_trylock() failed I saw
> > folio_test_uptodate() return 0. Assuming my test case is typical, I
> > think that means that coding it with folio_test_uptodate() is roughly
> > the same as just never waiting at all for the folio lock in the
> > SYNC_LIGHT case. In the original discussion of my v1 patch people
> > didn't like that idea. ...so I think that for now I'm going to keep it
> > with the timeout flow.
>
> I think that means that your specific test is generally going to
> exercise the case where the lock is held because we're waiting for I/O.
> That's exactly what you set it up to produce, after all!  But it won't
> affect the cases where the folio lock is being held for other reasons,
> which your testcase is incredibly unlikely to produce.

Sure, I'm happy to do it like you say. Do you have any suggestions for
the similar lock_buffer() case, or are you OK w/ the timeout there?

Mel: do you have any comments? In your previous response [1] you
seemed to indicate that you thought that short waits for read were a
good idea.

[1] https://lore.kernel.org/r/20230420102304.7wdquge2b7r3xerj@techsingulari=
ty.net

-Doug
