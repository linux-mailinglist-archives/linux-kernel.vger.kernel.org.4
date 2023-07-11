Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4543374E5A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGKECG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGKECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:02:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3511B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:02:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55be1ce1669so2604115a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689048120; x=1691640120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hny8DHnsH9fXH1ztmtRkuB/ydS5JleP+QV+kh8T0PBI=;
        b=Vz6aNtmzsr4I5LPKP67EDg1TyWWYa6etpXj7SaOhqgb18Pb3Jn5VpfUbHi3B3QM2MH
         +QFB0xeaEgcmTPb9Q+DYYA6ZgfNaYXavYbLP/PBpXXybMoRJ8Hh4I7PHWu+bRDuDC3Si
         sgSV8TvZsL7FaEr7zhs5jalq72Fnsav0Ul7vL8cpMvJUhkj7TNizkACJxdLxyBGBCwxO
         5dnnNEcIO1iTajR76WlW/71BlxUBE3MGLhsBGaIaBLh3PCkj5yEskLbkQ+vXXGgSnmET
         B7ofP9LOcUtMB/G9XUAfmwOW9G0gQEMIB4LdKoMN7TcRUsxt65B2Mvpl1Dyzvnl69+M+
         wYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048120; x=1691640120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hny8DHnsH9fXH1ztmtRkuB/ydS5JleP+QV+kh8T0PBI=;
        b=VOvP2aAJZT85ETvZmyasrn7/r9GdX3GsrGh8fuOhQ/JnscwuHBt6yeKf6lOqWucsVZ
         Ke93g7GhkZKlNvExmi5V3lnz6SQD//m9eb6l/UQzpwReODjbkbVpTDAi0gl3+ZkamMDh
         5eGS5kV9UNNkq7INrKtovbcoDrg75u+NiwxDfx7wC5HoFCbMguCX5vGLqGk1H8qztXpy
         W9911yHXv2f5myx76OqZO2ZmnVxN8PG9CyGURZxHus22gP43OnZRnaAvk8m0xHbgD9Jq
         JhZfQ/siV8h4mO70NohQuREB++pLl799dtJPA6bF5sqWd8e3Ao/g/Guf2AH2y0T3WFLT
         Gv4Q==
X-Gm-Message-State: ABy/qLY9W0hNbOcGwjhgMvemlFqPB7sROePhHsad5MKI6sO9dh6n/hfR
        ceFVbowzm4YDplmgLciDSRks0uSH0+DlKAhd0TQ=
X-Google-Smtp-Source: APBJJlHzqpFoYdpbxMbS8ImvmGjOnnY7IExl+yGPz/BT/pKXsaluMEIMwBJ4Gy9hsVVEL5yxght4P8c1vOzrOo+KgHQ=
X-Received: by 2002:a17:90b:1081:b0:262:f0e8:a389 with SMTP id
 gj1-20020a17090b108100b00262f0e8a389mr11058261pjb.36.1689048120004; Mon, 10
 Jul 2023 21:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005ca92705d877448c@google.com> <ZKx8+B3gI9/1g5A3@google.com>
In-Reply-To: <ZKx8+B3gI9/1g5A3@google.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 11 Jul 2023 12:01:48 +0800
Message-ID: <CALm+0cUurycz1=pt85sChA2dpzhk3KNLmTo5vfSb_uObOxQPRQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in kthread_bind_mask
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jul 11, 2023 at 6:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Trimmed the Cc list to avoid annoying folks with my thread necromancy.
>
> On Sun, Feb 20, 2022, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.=
org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11daf74a700=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dda674567f7b=
6043d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D087b7effddeec=
0697c66
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com
> >
> > BTRFS info (device loop3): disk space caching is enabled
> > BTRFS info (device loop3): has skinny extents
> > ------------[ cut here ]------------
>

Cc: Tejun

Full email path here:
https://lore.kernel.org/all/0000000000005ca92705d877448c@google.com/T/
https://syzkaller.appspot.com/bug?extid=3D087b7effddeec0697c66


static void __kthread_bind_mask(struct task_struct *p, const struct
cpumask *mask, unsigned int state)
{
        unsigned long flags;

        if (!wait_task_inactive(p, state)) {
                WARN_ON(1);      <--------------------------trigger warning
                return;
        }
....
}

Inconsistent task state trigger WARN_ON().


Thanks
Zqiang



>
> Dropping the "kvm" label as this isn't a KVM bug, but rather something in=
 either
> workqueues or sched that KVM often triggers through its use of alloc_work=
queue().
>
> #syz set subsystems: kernel
