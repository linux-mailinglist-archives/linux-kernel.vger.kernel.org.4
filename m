Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46187078CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjEREMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEREMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:12:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF935B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:12:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso2343822a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684383148; x=1686975148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBiK7zqzCv4YO32S9qrBa6a2V7ip3iodPxLIsQgbycE=;
        b=OC3DpLAIgwgMaxu6536uxiVSMkMWAXUyAUvvt8zzh0qHAfQTnsw+BOdZRupUy8lRnD
         Hh20CVgnPKpn+PgPJWDcgb1QLr8gClJ+Dkc1pcPBYxq30E2BhVGtwuVOOlIi6LY8LHVg
         31i5lr+0NacNWWrKyG+0WMIzz3jqeTJ0jN/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684383148; x=1686975148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBiK7zqzCv4YO32S9qrBa6a2V7ip3iodPxLIsQgbycE=;
        b=cj+Xt1EAPctZMVbPhfOBTnGgdrOUIL+SWzMYr8ce2Vvcmb1CQilNXy32UDerU5yA/u
         mb14FZddHKpz1cStA8hdBkSSUdAyiNtcW51Ng2qJ167sfvGq0VTF1+jCigKruYyu022C
         S+i8AYpezhOk11emwUcMoA+CiG+M3y7nJUxNwEGL8M4IGfWyFJjsA0U+Awefb/VTOxvH
         vTheGEYKaWLFSuBVVUMl2nYKifqMybrflCiUbHrZYVZvz2ynMLuSw/k+4WuujB5GNW4L
         wFXyRg7JLVFfW8H56b3MTR6/St/qEBSmktI4IFG/K4nuNuqsH1nRdK2sGQSB2oDSOuOZ
         TPBQ==
X-Gm-Message-State: AC+VfDz1ZGu+sraqIAcoJtPUQ7RCduFWcgs1CM4gkUEeYti9201DUJ8V
        ihAKAA0s7IJRCitbiHO/6X9wRuh5KuigYzl2NWBQG6tE
X-Google-Smtp-Source: ACHHUZ4cppr35lYrAGHY4fjQsdjCvU6yR3INJFSd3BJ7vEM6XOLGvw5xt46iHmSdlZHsu5R+bg6NMw==
X-Received: by 2002:a17:907:26c8:b0:965:9f86:4fe4 with SMTP id bp8-20020a17090726c800b009659f864fe4mr36121437ejc.56.1684383147993;
        Wed, 17 May 2023 21:12:27 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090655c600b0094f3e169ca5sm401122ejp.158.2023.05.17.21.12.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 21:12:26 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso2739714a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:12:25 -0700 (PDT)
X-Received: by 2002:a17:906:da8c:b0:94f:7a8:a902 with SMTP id
 xh12-20020a170906da8c00b0094f07a8a902mr31637538ejb.14.1684383145429; Wed, 17
 May 2023 21:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230518021825.712742-1-joel@joelfernandes.org> <20230518021825.712742-2-joel@joelfernandes.org>
In-Reply-To: <20230518021825.712742-2-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 21:12:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi20GzWeK=vUoreX6AXOEmeJKczou1McCOC9JytVO=TQg@mail.gmail.com>
Message-ID: <CAHk-=wi20GzWeK=vUoreX6AXOEmeJKczou1McCOC9JytVO=TQg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Wed, May 17, 2023 at 7:18=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This warning will only trigger when there is mutual alignment in the
> move operation. A solution, as suggested by Linus Torvalds [2], is to
> initiate the copy process at the PMD level whenever such alignment is
> present.

So this patch is actually simpler than I thought it would be.

But I'm a bit nervous about it. In particular, it ends doing

        old_end =3D old_addr + len;
        ... expand old_addr/new_addr down to the pmd boundary ..
        return len + old_addr - old_end;        /* how much done */

doesn't that return value end up being nonsensical now?

In particular, I think it can return a *negative* value, because of
how old_addr was moved down, and the "now much done" might indeed be
"negative" in the sense that it failed the move even "before" the
original starting point.

And that negative value then ends up being a large positive one as an
"unsigned long", of course.

So I get the feeling that it wants something like

        if (old_addr + len < old_end)
                return 0;

there at the end.

But maybe there is something in there that guarantees that that case
never happens. I didn't think too deeply about it, I just felt this
looked odd.

               Linus
