Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37A461E789
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKFXYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKFXYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:24:37 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B32C64C0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:24:33 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso5686882otn.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fAx5icLyZy6p+/Pj+sdRlORwJBoVUC3ZLIszdsgAx0=;
        b=b7Ax6YPavujgHopFxQNOY5a+EVle1cCV1+/ypabjnqdwpDwLxSWoA5ciQtdUeUcUWq
         l0GjPAYyK/YRZvehD8viWoSRVScMOc91VC5BWaFmYhGjPdcjevw5Bvhpk97DaauGwj0F
         XH7VZ/9VFdQXI1qBxfUf5MnJ8Jdt5CwjIXhgvzxKlP0WE0Wpa8Un+KWXsPvOrrCxkAvE
         e7ipPP9l/ujF/MI/8CZVgLqapMsyR6abjk0HMEcFPfr2edkdF1n4lbgCtGLR6O20o5tX
         7zXX5ug4kImOVXBmOy8AMyvWKJ6igkeuHUPWulrNZVayuu5F3AwfQNln8VAITo9G55bh
         fSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fAx5icLyZy6p+/Pj+sdRlORwJBoVUC3ZLIszdsgAx0=;
        b=h6g2zSRpPezl3h6ydO2xgC+Xi4gafUVhtJ6PxsVgYVXhwk4sWSxz2kStlEoddqMWs9
         xv3EzLcsj4nNThlRJyJinrIuVGYrWLSpfWQyviM82b3bxPbfpys76Ys5e9aJVFIE3SCU
         OL0lkHWt43H3W853/45GYapi106TUgRq7nL33K5UNJEuUksxSTrr98XTV0peWSa9zmr6
         e05mOx8OWAZqInQNXJ7uSOIcz/jBYki9RoGJypqbRuHAgNQCBKD0Quv3IzkFDfi9Wy7P
         Sb+d2kmJcke0ROZmfmTKYVJEtzlQqIGr/UZUpj8r+uWMJM6mb4HufQbzXKyTqfvHtbLX
         yh5g==
X-Gm-Message-State: ACrzQf1fhuN9nO+36KBav35Y55SMKt/aSYgjowzbBZH5fUW42CPrPGQi
        nUuKh30rF8lt1nzMYS1Y43BZrMrkEYxTEx2F+VuVEw==
X-Google-Smtp-Source: AMsMyM6e6HN2rwu83SL9cQH/oONLMcyRR/dPSdz9C3gIPSEgsN4OLYApw+H+8IDXERpyQlzFE2ou4+zsr3xgIa6juWE=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr18794526otk.269.1667777072697; Sun, 06
 Nov 2022 15:24:32 -0800 (PST)
MIME-Version: 1.0
References: <00000000000082ed3805ea318a4a@google.com> <000000000000ccbdf705ecad3fda@google.com>
In-Reply-To: <000000000000ccbdf705ecad3fda@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Nov 2022 15:24:21 -0800
Message-ID: <CACT4Y+ZSF6DEshmwYy5pKOexADrGXAj0=_2OyGcWXqJTYQgoeQ@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in ext4_mb_use_inode_pa
To:     syzbot <syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 16:15, syzbot
<syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4bb26f2885ac6930984ee451b952c5a6042f2c0e
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Jul 27 15:57:53 2022 +0000
>
>     ext4: avoid crash when inline data creation follows DIO write
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eb2fb6880000
> start commit:   4fe89d07dcc2 Linux 6.0
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4998f18bcd5fc7e40c8b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bc15c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d97bc0880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ext4: avoid crash when inline data creation follows DIO write
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Looks reasonable based on subsystem and the patch:

#syz fix: ext4: avoid crash when inline data creation follows DIO write
