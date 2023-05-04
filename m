Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9B6F6D54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjEDNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjEDNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:53:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E77D9F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:53:23 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef36d814a5so764241cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683208402; x=1685800402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diSEiQiFgwIgMo9GDEtvgWQfTBdTd6Sf1hxoMMcBYP0=;
        b=YnM2H1m0PgGcfjuL9VYkbea6xR/do+cHfqCgFGFo3XnNXejrzDqmn1r7QFTlmcT6Og
         othBFqXagV1v5yzzzWCHRja8D9e5ieBH6m+26gXNh+3Ka1bcNQw0+lbjbPHwHIy0yk8u
         SBmnY0RlVIFkwbJfCHvPMZ0p9kN/JDp0QcEh7A7udMP3haLOvxGGTydzZs3sSCLT8XBW
         WZy53L7SXlQEm8lqn6/hmpBmJqYcFi6Tnqa+IdX0tXxBcB+xBh4UBs29/fVPIJEuSppL
         FWpW+yOvs4+N7TYo+bhdQvkIuWwCAPyPVn+ugtcNF2Zu0BfVxWzP/ViShYYJF3Lyz1fx
         w7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683208402; x=1685800402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diSEiQiFgwIgMo9GDEtvgWQfTBdTd6Sf1hxoMMcBYP0=;
        b=E0QvBfzOCihVxDFVWuI1mzQ998SCuDHPqxnx0pTZmtK9mYVQf73CkhcFWRoKG74/pt
         mGTd5CGcdjA2eNxHkzw9jzau0AJRj8aQWSAUP+seIraecgeMiouiDGh5I9Yok7rbe3pa
         Ii3PHu5SBbQbK1G5IICg1p/3JMsxsGelrh7yYETOoO4vDBu2sX2INV3ey/2RS5zXTsk+
         b0C6QqmoK1D7DKGTqetDx2MB9UeafImOYyzItNij1AJi8wy/rBUkQVjY2qw9gO8vWDwI
         E++4XxbTIMi4aOF5Xn2N2mmTz9Kwhx22vPCFQFMeCtgN+4mNolezHiQ3JZqCI6eBq8Dw
         ke2w==
X-Gm-Message-State: AC+VfDyqXHVkmFbUMHzpSckpncZZSJ1Gnli028odv4P/F7jyhwDKmpqi
        96f78sb0Ut6Tebylt5a8YSWWd+fjw6xS6JHpwesikg==
X-Google-Smtp-Source: ACHHUZ5UtAGgtzHyxYKa9b8zHjOj0L90pDM2500dbhfNnSWdFaCa9vlgC16gec7O6Ny1aqgPpwNCUxaJFnYLpeSksoQ=
X-Received: by 2002:a05:622a:553:b0:3ef:5008:336f with SMTP id
 m19-20020a05622a055300b003ef5008336fmr309875qtx.1.1683208402652; Thu, 04 May
 2023 06:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000032909d05fade30c8@google.com> <d6a26ad8-3c90-d932-d966-85414e0ae42a@kernel.org>
In-Reply-To: <d6a26ad8-3c90-d932-d966-85414e0ae42a@kernel.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 4 May 2023 15:53:11 +0200
Message-ID: <CANp29Y4qwdptMDHA37u7eXWCC-1p7PP8d0RcdfKBUT4S=o5s_Q@mail.gmail.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_write_single_data_page
To:     Chao Yu <chao@kernel.org>
Cc:     syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 3:48=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> Hi,
>
> On 2023/5/4 21:31, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still trigge=
ring an issue:
>
> It said the reproducer is still triggering an issue, however, there is
> no error output from the test.
>
> Could you please help to check whether such status is normal or not, or
> am I missing something?

The status means that syzbot has not received a single byte from the
VM for 5 minutes in a row, i.e. the kernel likely just hung.

--=20
Aleksandr

>
> Thanks,
>
> > no output from test machine
> >
> >
> >
> > Tested on:
> >
> > commit:         2adb872d f2fs: fix potential deadlock due to unpaired .=
.
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/li=
nux.git dev-test
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D114b5338280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D86e4eb913e9=
0d4b2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Deb6201248f684=
e99b9f8
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> >
> > Note: no patches were applied.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/d6a26ad8-3c90-d932-d966-85414e0ae42a%40kernel.org.
