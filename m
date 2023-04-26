Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572E6EFBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjDZUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:47:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D79114
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:47:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76655852953so21693239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682542036; x=1685134036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qieP3ULrKIRmkqJSGHHaaVXipgOCBnCPp/roS3/SzsQ=;
        b=koJsYM57b8enPH1rMWWeP8K7efF/SZ/aBEp22WGtyB1+jaBDWbSU+5XegVQAyFaQmA
         eskg+TgJLSU1mGh/83zAWLxx+kSP/ifI7EkkiCB7CViZSMnneFI8pJxigrLsQASvlQAF
         SHWBgS/XxcJzT/5Et3Bg9RcIP+AxvsksGr2Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682542036; x=1685134036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qieP3ULrKIRmkqJSGHHaaVXipgOCBnCPp/roS3/SzsQ=;
        b=f0SB0KFpcXzGumk0nuvRIwXA6+WiGSAzDDYkphNEXAYPqjRldhyF/RWY5tqnmB4708
         9ugW7bWI+Z2q4S5b+pFRVV/noga8IYC+TjMJQGgK8DSGbTa8eOfPuYsdX/3XYt/qzSU9
         yJybj3DdLa6bGHa3tI/v7Uz/5spqkP4xNWc1Q0OXjfHPm0PUfk6+NFJGYRt36obtWK4G
         mL0ZfTl76xz6n5r4O9pSetef/S3jNbfuDiyAeutfXdrD1D981m8I/BEyx8vdX+vKrhdl
         pdMvZzFY9XjEH2U82kQRbl2ZXAfswN8vcdOEQhgIuAbMPxdljKyqN69lJG8AFAt1+S+G
         CjOA==
X-Gm-Message-State: AAQBX9cDjVGPinMBfW2N2wanB6Z30WZ7Ud8412EkEWs8jko6lFn+asc8
        IRb/yYztSPwa5+4RkC/tJbcOeJYz8D6+Z53yfJk=
X-Google-Smtp-Source: AKy350ZIkRXW5mWeS/Au9G25T+Dt+WgB4g1hlgVx59Juq58gZpdgb8+3i5JuO+dRugKya3nFSCL0pQ==
X-Received: by 2002:a5d:950f:0:b0:758:edfb:3f76 with SMTP id d15-20020a5d950f000000b00758edfb3f76mr11967187iom.17.1682542036084;
        Wed, 26 Apr 2023 13:47:16 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id y6-20020a056602214600b00760f256037dsm4873935ioy.44.2023.04.26.13.47.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 13:47:14 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-32ec968434eso324785ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:47:14 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d94:b0:329:3f69:539e with SMTP id
 h20-20020a056e021d9400b003293f69539emr77336ila.2.1682542033757; Wed, 26 Apr
 2023 13:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com> <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com> <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net> <ZEk/uVlbX2wWgagN@casper.infradead.org>
In-Reply-To: <ZEk/uVlbX2wWgagN@casper.infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Apr 2023 13:46:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com>
Message-ID: <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hillf Danton <hdanton@sina.com>,
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

On Wed, Apr 26, 2023 at 8:14=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> I'm not generally a fan of lock-with-timeout approaches.  I think the
> rationale for this one makes sense, but we're going to see some people
> try to use this for situations where it doesn't make sense.

Although it won't completely prevent the issue, I could add a comment
to the function (and the similar lock_buffer_timeout() added in patch
#2 [1] at least warning people that it's discouraged to use the
function without very careful consideration.

[1] https://lore.kernel.org/r/20230421151135.v2.2.Ie146eec4d41480ebeb15f0cf=
dfb3bc9095e4ebd9@changeid/


> I almost
> wonder if we shouldn't spin rather than sleep on this lock, since the
> window of time we're willing to wait is so short.

It doesn't feel like spinning is the right move in this particular
case. While we want to enable kcompactd to move forward, it's not so
urgent that it needs to take up lots of CPU cycles doing so. ...and,
in fact, the cases I've seen us be blocked is when we're under memory
pressure and spinning would be counterproductive to getting out of
that pressure.


> I'm certainly not
> willing to NAK this patch since it's clearly fixing a real problem.
>
> Hm.  If the problem is that we want to wait for the lock unless the
> lock is being held for I/O, we can actually tell that in the caller.
>
>         if (folio_test_uptodate(folio))
>                 folio_lock(folio);
>         else
>                 folio_trylock(folio);
>
> (the folio lock isn't held for writeback, just taken and released;
> if the folio is uptodate, the folio lock should only be taken for a
> short time; if it's !uptodate then it's probably being read)

The current place in patch #3 where I'm using folio_lock_timeout()
only calls it if a folio_trylock() already failed [2]. So I guess the
idea would be that if the trylock failed and folio_test_uptodate()
returns 0 then we immediately fail, otherwise we call the unbounded
folio_trylock()?

I put some traces in and ran my test and it turns out that in every
case (except one) where the tre initial folio_trylock() failed I saw
folio_test_uptodate() return 0. Assuming my test case is typical, I
think that means that coding it with folio_test_uptodate() is roughly
the same as just never waiting at all for the folio lock in the
SYNC_LIGHT case. In the original discussion of my v1 patch people
didn't like that idea. ...so I think that for now I'm going to keep it
with the timeout flow.

--

After all of the discussion and continued digging into the code that
I've done, I'm still of the opinion that this patch series is
worthwhile and in the spirit of the SYNC_LIGHT mode of migration, but
I also don't believe it's going to be a panacea for any particular
case. Presumably even if kcompactd gets blocked for a second or two
under a lot of memory pressure it won't be the absolute end of the
world.

In that spirit, I'll plan to post v3 in a day or two, but I'll also
continue to say that if someone tells me that they really hate it that
I can put it on the back burner.

[2] https://lore.kernel.org/r/20230421151135.v2.3.Ia86ccac02a303154a0b8bc60=
567e7a95d34c96d3@changeid/
