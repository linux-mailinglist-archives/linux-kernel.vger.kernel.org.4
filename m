Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1E6DF255
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDLK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:57:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8086376B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:57:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso55185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681297019; x=1683889019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2nt7ejQK3jr9r1+vnQD1e3FmdrT042GNN9tIEQMZ1E=;
        b=t7IOWsunQ1sr66lSoyGmmloi1T7w/NIIGJTgTYknCs01CRxFh0HkL+XaWQZeJTATMh
         r6QHRJc3LNXb8iHN0R505gFWgcLgHKVpuJhHIpIF2SsQ3b9Jmoxr/agsV8XqsLsIDZFX
         Z+qpDunVqPcRk9zrzNmHnwNHHc4P2VKyUcseK+zcEp8O3lL9H/0XmOMvsSznsUqbmX5J
         PsrZ9Nk7fMzmQrgKayfGs0Fh21dySgLR0Vc/qGE5rmjQTtJWCjXLnGieu8CdAO1PrPgl
         zyVhFPsa2WNucdD87EcMD/7aI+bqug13OCFd+dkQmTPqH7/BKllfO0Fd9yt1rJabNLA7
         sz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681297019; x=1683889019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2nt7ejQK3jr9r1+vnQD1e3FmdrT042GNN9tIEQMZ1E=;
        b=WisuLMxOvQKfwl4CRAeixb33BfUWBnnxaJjLAH9QCdzE/h46e1EgdOrJDJGT6XZiuC
         Zzf7EOr1E7dFQk3DfLE4doPmzUbz8AVP6POc9o7tEbq9KzfhWSKQ591qABB/1IktST3K
         rCZN0HJglE/E1vg+CvADQFK6AM6F4DKkZthC4X2q/DzhCKbA96LH2s+65z2YJS71ESlR
         jmhno8qDoCBIrtccHl9S/oQsZq8Fz1xMT7FTB716a8vTbb7nqJS6buBX+Q2QPocGn+4r
         3Dq2KHCEB3oy8uIc87ZuTKaWofEItnUnEuKhYOOBFRvKVKT0AqE4jZ6JaF+XnYdrAb3d
         U+ig==
X-Gm-Message-State: AAQBX9dOIJH5HwVerVpT9+1nlctkMKzpPzibbWpu87nsxL4fzyaajL6n
        nS7Iuk65pWLAtjTORQIAgQZPUEVd9VksNe8BB6iuwA==
X-Google-Smtp-Source: AKy350ZR5xCsHi5eVXAzVMAg74DbXOVxZwSG6Tj6+e2urajU4bQH/MinMa3dSR5ARaqb2khKmss74CtU7opeYyoeB+U=
X-Received: by 2002:a05:600c:5405:b0:3df:f3cb:e8ce with SMTP id
 he5-20020a05600c540500b003dff3cbe8cemr393512wmb.7.1681297018926; Wed, 12 Apr
 2023 03:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANp29Y4V7LsaJk0h3GyWV-chE8YkwM2qX33_hy9ZF5si8ZLdDg@mail.gmail.com>
 <000000000000e9e5a905f9214d8c@google.com>
In-Reply-To: <000000000000e9e5a905f9214d8c@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 12 Apr 2023 12:56:47 +0200
Message-ID: <CANp29Y4UGZpm6JadD0+5kWFZn1DuL54VWN4QT+2CnaryeqWBXg@mail.gmail.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp
To:     syzbot <syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        rodrigosiqueiramelo@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's close the bug on syzbot so that the bot can report similar bugs
in the future:

#syz fix: drm/atomic-helper: Don't set deadline for modesets

On Wed, Apr 12, 2023 at 12:45=E2=80=AFPM syzbot
<syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-and-tested-by: syzbot+75cc0f9f7e6324dd2501@syzkaller.appspotmail=
.com
>
> Tested on:
>
> commit:         7d8214bb Add linux-next specific files for 20230412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1387763dc8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D923e20c1867d7=
c1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D75cc0f9f7e6324d=
d2501
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
>
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.
