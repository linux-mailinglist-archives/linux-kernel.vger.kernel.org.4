Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0EF7164A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjE3Oo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjE3Oos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:44:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA1FC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:44:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso13546a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685457886; x=1688049886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+t5dTE8kSUxjA4+aUdL/P2lX5zwmHCfFiqOu5qhUdY=;
        b=yw5ljc9t+qw8qp9m8RjQ71WrnyGtmNel4ldkFtv8NgwQ1lFcOiGyM5Y03pdzODVReB
         XyA5LjDDtSrpAlzcw1kSC1vp6NoPzPenOhFIgzKlHd5tK/DGsWmxxLtS2zmVns88oEZZ
         QHZfYe0C2eXuG9BCcrzZ2ZQru7H9GN5RdesPqnhapoaBWpzy10rxs0zca7JQXlqagULZ
         jXE4wNcdiezkrXnejvIocjwvEuMNRuApA3uiDinisBkxhDDdkGa1UzHa8a+BMZl4cW4W
         L6Y6HFlfGJORz6N3HHTzZU6UmOdER60ImpOy2QZHQCfOUUvpg/jMtsDa4n61z5DAMdIM
         7JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457886; x=1688049886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+t5dTE8kSUxjA4+aUdL/P2lX5zwmHCfFiqOu5qhUdY=;
        b=OmtqL10f+nfNzhod3i03Pc2R0Wwf+HMaC7YtHoZFWKErJEL/yuxFtJ9BbXXKafg9es
         1SlpEKg8VZ/8x5DhI2Kfg9Jp3hr4SKsPRu4DDBwm8dsql0wMK1doN1nkyjKaYJNhx88l
         zbknYIiP4oZW6bsraIb5jrrKjf+bG04LqfSb/g1lR/W9NvKbd5kWC7NBnouDQgO9WUuq
         PZms/AI8l3WDvmJtqxio1Bmd4kWoW6Oc8ctIwX5XDeIbq5LQ6gHcvUCac1qSYiD2uOGG
         xZrXANZVwhyXvgfmv2CzYuU0y5nBdBGDUX+oLJqmm/yiCJH25j1VJ8iLoV5dsNbysycT
         hvmQ==
X-Gm-Message-State: AC+VfDxi25muCJgq488rc7xfdEQi/bKQQFg5zVAKIw/VsKQIw+EjPvYa
        UieuMs2iydtnXZH7tWJVB7bxWsc6jnaa47NdY7xpqw==
X-Google-Smtp-Source: ACHHUZ4Lgy3noCUYRa49sMjUxhZy3XuJzFJvHTwdNMNfQRVP8eoz3gaoIpD8RTQf3zd55SfsnQjpmhiQug5cjIozG+s=
X-Received: by 2002:a50:d55d:0:b0:50b:c48c:8a25 with SMTP id
 f29-20020a50d55d000000b0050bc48c8a25mr84565edj.6.1685457885886; Tue, 30 May
 2023 07:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230517225838.never.965-kees@kernel.org> <20230518-jemand-ehrte-80f8b538ca03@brauner>
In-Reply-To: <20230518-jemand-ehrte-80f8b538ca03@brauner>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 30 May 2023 07:44:09 -0700
Message-ID: <CALmYWFt6F6h+NQR+BdrsjP53naS=Ps99Cpxmr4vpHM82=0-JSQ@mail.gmail.com>
Subject: Re: [PATCH] pid: Replace struct pid 1-element array with flex-array
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 8:07=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, 17 May 2023 15:58:42 -0700, Kees Cook wrote:
> > For pid namespaces, struct pid uses a dynamically sized array member,
> > "numbers". This was implemented using the ancient 1-element fake flexib=
le
> > array, which has been deprecated for decades. Replace it with a C99
> > flexible array, refactor the array size calculations to use struct_size=
(),
> > and address elements via indexes. Note that the static initializer (whi=
ch
> > defines a single element) works as-is, and requires no special handling=
.
> >
> > [...]
>
> Applied to the kernel.fork branch of the brauner/linux.git tree.
> Patches in the kernel.fork branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
Acked-by: Jeff Xu <jeffxu@google.com>


> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> branch: kernel.fork
>
> [1/1] pid: Replace struct pid 1-element array with flex-array
>       https://git.kernel.org/brauner/linux/c/ad0ff58dc959
