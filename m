Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5274F653050
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiLULej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLULeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:34:37 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9746FE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:34:35 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id f189so14414819vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqp5h2G0o1D47DEepedTLD764sowPrFDF+33IDQEmnI=;
        b=I9qyMFSju8mqnAnv5jRtM119ICRMxcmggG4XNqO/FT6Nzz/iFzzgibduR8DDTNbheN
         Mqg6ooA0ZBaQOgRuuF0DzR1vJ94K+q9bvUnYiVvN8QfjNPfNitJBM3v5ZHQTmpxvIz7R
         hTi0k93A3rbs6B/vPvdHP9YccDtX5jI8BUD9gsBUvOzaQFN2l2yvhE2+7H2opVpzV6aR
         C4Telqqt3/sQttb4pL99RSC1cl/oCcUUnEqRBQwbKoWbIRk4d/tEl7ifZgFYdb8HmtTd
         /RfxPey6MBuQ+laGkscbaSbqiZahSF2N0eReK1sPukK0Bb/4kfUVnYoOzQZBKx+quRFg
         PcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqp5h2G0o1D47DEepedTLD764sowPrFDF+33IDQEmnI=;
        b=oTkdaLBxYIMmAWKUE7YSQ5MdMfusSoC3FZW/zO8pfiWiUJ1tzj8vRVZxRs1UF9XZCM
         edLq6tRx9fWIAFwPF3CMJR+aXRMKg3kXxHJ/cZhFF6BK7MUNpluteyqy8y+9QP2OXvyM
         9jpw0w5tNFAWf1qQTu7rEvS3a16FOjifTG/8LTf6A/HM5yKRu0rqS7zReLbTBIoHeWEP
         lwyFYoMs8ihrwVLBvBT1HhBFAMZiMcskss8BZOw0UCn7WwMbHrAhZUeciuELAT7Rig5O
         rLUVKpjZ9sgijtn3rfLssAvGpKx6ZE80PTvKC+NKDOdZxnNGwkaP35oG/uNIc1jQZ/fO
         AvYw==
X-Gm-Message-State: AFqh2ko8H43SXwGqn6vw3+huzR1wovKUJB+w8jCKW4cnNZIXjYuub1ZO
        63mZqKnQB6u94SNqyYYI7xRS+ZtJC9XGxLjvvKTDUg==
X-Google-Smtp-Source: AMrXdXtp0v/R72NOTcUNN1rnRCk2XUHl09Jbcq47OJpk3jODl7hk8leumWQWjVG9FfNpnXRSK1dHn0/szrfn/Qa2EFY=
X-Received: by 2002:a67:d018:0:b0:3b3:560:f2ad with SMTP id
 r24-20020a67d018000000b003b30560f2admr215871vsi.17.1671622474909; Wed, 21 Dec
 2022 03:34:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006c411605e2f127e5@google.com> <000000000000b60c1105efe06dea@google.com>
 <Y5vTyjRX6ZgIYxgj@mit.edu> <Y5xsIkpIznpObOJL@google.com> <CANp29Y6KHBE-fpfJCXeN5Ju_qSOfUYAp2n+cNrGj25QtU0X=sA@mail.gmail.com>
 <Y5ylNxoN2p7dmcRD@mit.edu> <CANp29Y4QVp1G83pSqpxeETbw_+kQQ5CZUz+Vgi767WxE8AuhHQ@mail.gmail.com>
 <Y5y824gPqZo+vcxb@mit.edu> <CANp29Y4S0TTVjonA9ADpBKviNHR+n3nYi2hy2hcee-4ArD5t4Q@mail.gmail.com>
 <Y6CqJ8fgQQW8AhT6@mit.edu>
In-Reply-To: <Y6CqJ8fgQQW8AhT6@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 21 Dec 2022 12:34:23 +0100
Message-ID: <CANp29Y7T+sG4JYkZttpyBkz54SUwOz=BhJED+QmKOGp2CgceiA@mail.gmail.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Lee Jones <lee@kernel.org>,
        syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org, syzkaller-android-bugs@googlegroups.com,
        tadeusz.struk@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 7:15 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
< ... >
> It's not obvious what you mean by the "main page" of the namespace.
> I'm guessing, but from the bug report page, there is a horizontal set
> of icons, "Open", "Fixed", "Invalid" .... (which all have the same
> icons), that the "Open" icon is the one that gets to the main page?

Yes.

>
> Assuming that this[1] is what was meant by "main page" (which is also
> implied by the URL, but it's otherwise **really** not obvious), where
> is the list of tested trees?
>
> [1] https://syzkaller.appspot.com/android-5-10

I've just deployed the changes that add the page with the list of the
tested repositories as well as a link to it from the "main page" (look
above the table with instances). For Android, we indeed don't test
many trees:

https://syzkaller.appspot.com/android-5-10/repos

For Linux upstream, there are more trees:

https://syzkaller.appspot.com/upstream/repos

> At least for the android-5-10 namespace, why not just
> say, "I don't see that commit on the git branch <explicit git repo and
> branch name>"?

Now such email messages will include the kernel name and some of the
tested repositories (with the link to the full list page). E.g.
https://github.com/google/syzkaller/blob/4067838e6b16173af08e062ce434ecfc46d45bda/dashboard/app/notifications_test.go#L106

--
Aleksandr
