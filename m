Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A2718BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjEaVbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:31:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB7139;
        Wed, 31 May 2023 14:31:05 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba8151a744fso80663276.2;
        Wed, 31 May 2023 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568665; x=1688160665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qbtUs9ndxd3DZRGurVSS0a+crEkg2YIykbFZmkROUY=;
        b=FaD+YPSqNsZY/mGSAAERnzZe1f2X33jjBoiDb+rH4NSczlyBLiZXKo2Qnn+2BKWWjm
         jAPpgAXMav1WJQUJYY1TVFPKggA/4pXXSlxATfA2WpTmFR2+AN/t00m28ai2DunyRoxk
         +nt549zpGxdeyExkhr457WFgTCMik9qkgFyjMzJ9yVSolvHfimxS+QzxXnSWzef4aPvM
         wdEYfKPVQN0ilYkx2csygwReFSUjwGdHf1cEhVwcaDG2QaHbcqZzJc6lF9TQ/M0ypSBz
         2aL0L7OuiZKD2r7QGnp/9EVDWb6PsR5tAnldMmEtLlO7MP18fDXJgX11XBDsmbW3i6Ai
         i7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568665; x=1688160665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qbtUs9ndxd3DZRGurVSS0a+crEkg2YIykbFZmkROUY=;
        b=aMDZCIm5TbUxZ5Q26wMfmkf/hxVjvf1XtbTCPROpln6GtESpwPGKFPmqSb9rXrM1MK
         ScvZjw3NXpazNZSdGObw9SOUY8LBpvTNGtUAwEvgrK94PNp8XjRocbEATVXpRd2IV7Cb
         NNIF/hI231izQwOIc6Vx0N3mvBKUgNl3JDSFMzRAuhqxqMCgw9zAEpeUqOzbZZYuW3DQ
         yWyDiDOZArWMauFIHhQPk21gZGADxTdU8asDcGb5E7Le8xjEX+9/qhbjX+MC2B6e+WB4
         5zdAkSSErOp0DC+u9dCHtmgYZaxS/jFxYCZgvbqg8e5B6+BU3rmYMpWN17eyexfxu7kK
         3fEQ==
X-Gm-Message-State: AC+VfDxA7xaTCg+XNBd6gGoRSKrBT5ejuq5pK640ZSnTQfhL86ce8qaN
        LRHm0gFZMwU1GApzUSoDvpXxwj4mjbblHaulc+c=
X-Google-Smtp-Source: ACHHUZ6ujjbi0ShQS7ASNw1bhHvEiNCLTRsHW0EEGz+/LG1Ttic9lcyt7OE5oEvg/mvDfWhqz9p4zHaFpSLA7EMnmcA=
X-Received: by 2002:a25:df87:0:b0:bac:7621:84d4 with SMTP id
 w129-20020a25df87000000b00bac762184d4mr8791481ybg.19.1685568664934; Wed, 31
 May 2023 14:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-4-ojeda@kernel.org> <20230419030243.540348-1-yakoyoku@gmail.com>
 <CANiq72knVpyaKdT2iwrBNYorAt3Y5M-r6pXHc9JAZRCVmBYusQ@mail.gmail.com> <22ac8a99-d243-c537-41c7-ff2c5e69d28f@gmail.com>
In-Reply-To: <22ac8a99-d243-c537-41c7-ff2c5e69d28f@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 23:30:53 +0200
Message-ID: <CANiq72nm8DQECm0CRjCSyzjPQK+z44_LHpanjTVv9mWRvYqVPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.68.2
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gyakovlev@gentoo.org, jan.steffens@gmail.com, jistone@redhat.com,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        william.brown@suse.com
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

On Wed, May 31, 2023 at 9:48=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> It seems that kind of URL comparisons in GitHub aren't supported yet
> per the docs say [1]. Sad but maybe in the future they are going to be
> supported, or at least I hope GitLab or Gitea do it.
>
> Link: https://docs.github.com/en/pull-requests/committing-changes-to-your=
-project/viewing-and-comparing-commits/comparing-commits [1]

Thanks! There is also "comparing releases" [1], but it does not seem
to allow to restrict to a folder... :(

A dedicated view where one could navigate everything between two
points (or at least two releases), including PRs, content diff,
commits, closed issues, etc.; and being able to restrict it to
particular folders would be great.

[1] https://docs.github.com/en/repositories/releasing-projects-on-github/co=
mparing-releases

Cheers,
Miguel
