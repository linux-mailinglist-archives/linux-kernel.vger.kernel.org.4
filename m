Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF663D014
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiK3IDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiK3IDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:03:43 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0B4A067
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:03:41 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n205so17967180oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ytbP3aRvqVlm8X+seTdImhsEXbCGvmJphNf+aY7ZtM4=;
        b=dBvRWe1YnzaES7pn47WFrCnCiT0GGZjx95XYX3LUUWZddnoNnLEsrA1Y7zI5LPoLWS
         0qNkRpUjAHqeHGFV6DVoLjDjK43tHsa5zUvjV6ar95a2GcZz5HJu0/lo+GeNdHcO2ckr
         owrmWUmYkSD2/gdiSgdBcM+3je0Y/ZSFxozGFqHtivZDulq3DDZR7EBe7iEHsFGLsp3S
         A9NgPIq28zb2cFpXJbHRM6Y9MjYmJ2Su9DdJ1QSwNY9N/Ksep0M3VJEFDIPPnuhVIlsG
         H2zztTnOBpK4P04/xWCgBRkJanxyXJ7CQhoy49hh4CFOYuJeaRGwj3OgtrXBtfBMEGEX
         SdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytbP3aRvqVlm8X+seTdImhsEXbCGvmJphNf+aY7ZtM4=;
        b=XE0ny03HbzgxBV6zl9qGzPcHL44G9nOJ8CMgb43aSFDSIDo8qJOFSL4JCUZ+UZ5Fr8
         OowkJsRk61PfVZRorTZcJEFIw8BzaQb2mhkusUpUND9+LHmWg9W0H/F5RrBsHVWzoWHK
         HDhJJAbYXDMT19owEhyxV6BzK9DmWQDlblgpo4sEyB2hrPZHC3RYVZ3XKoiWtmMdUynl
         uD39KWjGlndH+PDc1NRZ4OlyfRxQ98KKHsCt9pZ9BmserzonebStOTSzAwFGwyes6EYo
         dMWG1SQCEIAXG81a5JgbNN8Ho9Lp5ysow5uo5ZS5q3OjpH5BmIj3SPjQ8TNHEB2DsRpj
         ZfYA==
X-Gm-Message-State: ANoB5pn8rO21Bn2eeaI+wsLDvAYJUs3OlJGYh16+GLTsi8ltZWPqfyTj
        y8sNe+7Avd64nKNm0lue8nhLmuv2qRHatj1LEzdx/Q==
X-Google-Smtp-Source: AA0mqf6mrJR21gWUw7tAuTewggFc3IE/iuTMg+Ois8Wv2ezIzwb2jGZrnXNTrFZBHyj02JMnmdXWjA6nCfdVxl2hTWI=
X-Received: by 2002:aca:1110:0:b0:35a:7e1d:3d72 with SMTP id
 16-20020aca1110000000b0035a7e1d3d72mr31818485oir.233.1669795420248; Wed, 30
 Nov 2022 00:03:40 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000c379205ec806d6e@google.com> <000000000000d921ab05ee8e4f48@google.com>
 <CANpmjNMS3BGeWix=-OBKCK_iorQiGVay58f5U4fJiebF6msPSQ@mail.gmail.com>
In-Reply-To: <CANpmjNMS3BGeWix=-OBKCK_iorQiGVay58f5U4fJiebF6msPSQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Nov 2022 09:03:29 +0100
Message-ID: <CACT4Y+ZSvTdN1ARBgVeM=z_s5wWkkybo83wZ5nMDhyEdpwjFaQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in btrfs_commit_transaction
To:     syzbot <syzbot+9c37714c07194d816417@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Marco Elver <elver@google.com>
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

On Tue, 29 Nov 2022 at 23:13, 'Marco Elver' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> #syz fix: btrfs: don't print stack trace when transaction is aborted
> due to ENOMEM

fix truncated line

#syz fix:
btrfs: don't print stack trace when transaction is aborted due to ENOMEM

> On Mon, 28 Nov 2022 at 22:11, syzbot
> <syzbot+9c37714c07194d816417@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 8bb808c6ad91ec3d332f072ce8f8aa4b16e307e0
> > Author: David Sterba <dsterba@suse.com>
> > Date:   Thu Nov 3 13:39:01 2022 +0000
> >
> >     btrfs: don't print stack trace when transaction is aborted due to ENOMEM
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e020bd880000
> > start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9c37714c07194d816417
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17401632880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13176716880000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: btrfs: don't print stack trace when transaction is aborted due to ENOMEM
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d921ab05ee8e4f48%40google.com.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CANpmjNMS3BGeWix%3D-OBKCK_iorQiGVay58f5U4fJiebF6msPSQ%40mail.gmail.com.
