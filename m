Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F2735D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjFSSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjFSSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:15:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F012A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:15:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so310291cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687198516; x=1689790516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc4/7tBN8p7wiZ9yXX5gy4VqAQPUOPZGcFOvObJq8TQ=;
        b=GskT4rsHpHdR9DwEeQM3IuTonEU4XJwUGQuD+V9KBARys0TL8HzjRP+xHsy9SHc/pH
         onzFyIYCywFfqQuxScNxQzq81BqegVf4EwvDqu+jMNTtQbnJLCLWlqVlVvz8bubU0RYW
         d0dOVl32cUd/3b7M0Eiq6OCo91vcMGa6TRoIsSwge3iL8Dw6OIImbKrvJJ76wE4r+DUW
         txImMdr8HZxmV+FLS72lPiY39e9pxbRztMNPOdtTQRfM+PMobzztqDstuppxqnO4mmEa
         hFlABL1+hK8iXu9n2ePC6kS7MKX0jpFu9XSUo/g9/95Fq8TJ3/v05+tr5x4yTtfqj3on
         PD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198516; x=1689790516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc4/7tBN8p7wiZ9yXX5gy4VqAQPUOPZGcFOvObJq8TQ=;
        b=aCeJpRCbjbnQyuGFTcDeiqGg0gJyGoQNsLxhHVolJ22M9RjgvUKWIJm3PYSIjRvtOS
         suRCX2rRqUd/jhInwotnHM04X9LA1wRqqFVgIFx/rpNpfrTk3KzWRQCz0tELyYrd2UBk
         sCl1G4SwA3zOi1h8qPX22yQu63b7UVNOipRfPu/OQOf6YkVfEPvsZvpciJFGm49MuraV
         nhcQqpPJa4QLtI6Ew6OwgKDUyVJwvnUxzEUCikEoXz3K9r5gapLYQTJYbeDYz1DgJS2U
         cLgbmesSfoTCgpq827ck7Mrp11S5JP2VJOSWCj0w7wuFBbDMf6kEGR2Fd9ANGaAI57ZB
         V8Eg==
X-Gm-Message-State: AC+VfDyBj3faaH3Jyz4SAjRuDCPTwJtxJ8jb97MEW2MzuWbo+Aek+QDz
        Tbw6tRfnP28MWox6XOZe3sjVzB7LAWm0AGvDXI6eh1b30OCoadfo1wnZAqIh
X-Google-Smtp-Source: ACHHUZ6XlLsq79j8a6f5KeYGOD6WGyVTbhzXieBoei0LJXWt12gUAxujdxHCANd53rwQhGiSt5lADMbxC7OMkt3Va8s=
X-Received: by 2002:a05:622a:251:b0:3ef:4319:c6c5 with SMTP id
 c17-20020a05622a025100b003ef4319c6c5mr810463qtx.19.1687198515969; Mon, 19 Jun
 2023 11:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000fa09c05fe7cfea6@google.com> <20230619110618.6f5e4f8d299ad78f6fc99acb@linux-foundation.org>
In-Reply-To: <20230619110618.6f5e4f8d299ad78f6fc99acb@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 19 Jun 2023 12:14:39 -0600
Message-ID: <CAOUHufYSEm5dXfZJMv9=-cofzhs393jTWN5xOGpbjkaYCWkNKw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] inconsistent lock state in lru_gen_rotate_memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        "T.J. Alumbaugh" <talumbau@google.com>
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

On Mon, Jun 19, 2023 at 12:06=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 19 Jun 2023 08:14:35 -0700 syzbot <syzbot+87c490fd2be656269b6a@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kerne=
l.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1154eb17280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db55c7ca2258=
f24ba
>
> CONFIG_LRU_GEN=3Dy
> CONFIG_LRU_GEN_ENABLED=3Dy
>
> Maybe caused by TJ's series?

No, it's caused by my original series. I'll fix it shortly.
