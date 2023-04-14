Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA86E267F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDNPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDNPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:09:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82229EF7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:09:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso135405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681484995; x=1684076995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCGUqGKs3tAkN4PWIVOkGhEmJaHLWss+zp+zjXoaqdA=;
        b=BiV1ZX1XVOjp3RYTp/kQgVb2NKLRT/hVMSM3sJFOjaKVbpQjPd+XrgO2+g/2vEuCPL
         VcJWkLr32iIkTFOyTc8Vz2wIvkclgb/IRQH208Qdx6xnVPE3waKluFljcnKdCG+cPg75
         OJQTdsL9vKavdzdAUcRRxBiMUAecMmKCzJC57GLhDRXQRuW+b2pXWE9H9LvbwqJA09FM
         rJOYSBswFOdVXmeGy5nLNcWX/CjP/AOeQ06K+FNtIXQ6tYE18Y98ekB3NmeUkHscJMxK
         TgNYY0BoIF+xAHuneV6baHatEyNFKISfm3dJNyTjwEsWW7NpgTmeSODYjTwWK9zUWtcJ
         xynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681484995; x=1684076995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCGUqGKs3tAkN4PWIVOkGhEmJaHLWss+zp+zjXoaqdA=;
        b=jNNtX2I5XJH97uXB7R2eIXvccUsCnrPFJWbDeNejhU1LfMleqkMLQIZOQ3AUOEIs4X
         XvweImBJgA6MIHK+rJCZkNXEt7JuKj/h+xv/7of+ccoM9SLGzP8eAconxoYIWjRHFeSV
         IAde1mpr799QSYQyRzoJA/3LPCPJVNxxMkRQDXnKD7Xty+Wuilrd/O0X9kCsW9vpZIXL
         d0UmUa0vTMlekLCxSVGOZTtdK4E1G3+R8jUG7YWRf42QqtwyI33gYhGYjJhllbeBDmf9
         5SHYabiSY/Vz1A4L6Gy7WD6XS6fUVrLJuQeX/AKandC9vwdwn5qKDjS9W3Vsfp1YXqih
         DMFw==
X-Gm-Message-State: AAQBX9e3nT/OfUdgNh7+umox4+vnHKgnYM/hSlMLx0M1/2Ew+3HYrmJS
        Gn7sKs/+w1hRb2ob4vpuBakkszjX2s4IdrX9hIZqoQ==
X-Google-Smtp-Source: AKy350YNRE9KdzSv0BHHlgzjJenLNDx4WAMSbv1tLKKMPCwWVZ8F1ulyGQwBz/MxzGz5BO3rakg76/qLgAOnVLD86HM=
X-Received: by 2002:a05:600c:12c5:b0:3df:f3cb:e8ce with SMTP id
 v5-20020a05600c12c500b003dff3cbe8cemr107763wmd.7.1681484995027; Fri, 14 Apr
 2023 08:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d5a93805f8930638@google.com> <CAJfpegsGjFQX9t_NS8-oiE0K8Y0xEmr60VXMg6d4HQCCXOrOXg@mail.gmail.com>
In-Reply-To: <CAJfpegsGjFQX9t_NS8-oiE0K8Y0xEmr60VXMg6d4HQCCXOrOXg@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 14 Apr 2023 17:09:42 +0200
Message-ID: <CANp29Y6=HkcQYNEnpjozNhp7h5hmCnRUSXpjYKqyS6yaeTMQpQ@mail.gmail.com>
Subject: Re: [syzbot] Monthly fuse report
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+list69b50efce6f847334104@syzkaller.appspotmail.com>
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

On Wed, Apr 12, 2023 at 3:52=E2=80=AFPM 'Miklos Szeredi' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Wed, 5 Apr 2023 at 11:00, syzbot
> <syzbot+list69b50efce6f847334104@syzkaller.appspotmail.com> wrote:
> >
> > Hello fuse maintainers/developers,
> >
> > This is a 30-day syzbot report for the fuse subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/fuse
> >
> > During the period, 0 new issues were detected and 0 were fixed.
> > In total, 8 issues are still open and 34 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Crashes Repro Title
> > 146     Yes   INFO: task hung in fuse_simple_request
> >               https://syzkaller.appspot.com/bug?extid=3D46fe899420456e0=
14d6b
> > 26      Yes   INFO: task hung in lookup_slow (3)
> >               https://syzkaller.appspot.com/bug?extid=3D7cfc6a4f6b025f7=
10423
> > 13      Yes   INFO: task hung in walk_component (5)
> >               https://syzkaller.appspot.com/bug?extid=3D8fba0e0286621ce=
71edd
>
> Hi Dmitry,
>
> These all look like non-kernel deadlocks.
>
> AFAIR syzbot was taught about breaking these by "umount -f" or "echo 1
> > /sys/fs/fuse/connections/$DEV/abort", right?

Hi Miklos,

syzbot indeed writes 0x1 to each /sys/fs/fuse/connections/%s/abort
See https://github.com/google/syzkaller/blob/ec410564b9e4ff241d1242febb29ed=
a2ee28b50d/executor/common_linux.h#L4614

Some C reproducers (e.g.
https://syzkaller.appspot.com/text?tag=3DReproC&x=3D128284a0b00000) also
contain that piece of code.

--
Aleksandr

>
> I wonder why they are still triggering a report then.
>
> Thanks,
> Miklos
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAJfpegsGjFQX9t_NS8-oiE0K8Y0xEmr60VXMg6d4HQCCXOrOXg%40mail=
.gmail.com.
