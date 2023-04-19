Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2948A6E72A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDSF33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 01:29:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7344697
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:29:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52079a12451so373254a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681882166; x=1684474166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/tN8bRwblazfyrY8uiba8tnTzSo4HB+oXO1oAVkqrM=;
        b=d+HySIK/GP3om2qth7Zu89GOKCUZsz15lrX+l6gLUe5NQw/OpiwLMp2MWudW8rV63q
         0OeZZAAWWiM+xxGAzJ7xENtKy6PPnL5GEft0Vqb1UgY3yIzlR4T8lOThfTTQgi3W1ekU
         Xpq9pNR3rkrb0h5w/CImwreeMB/NHkLvTheJk7Za4rV7kC3MmqoAGGQVRqnmTJ3zB7PG
         dGSGlV1lFpbocS+yo/qWsBs1tx6Jkwp8zumGNwPSjkRhU2jPbDBrKz6HCRc0M9F701Yl
         jbyWhV/ReQBE0jmjyPe4Hsi8Jo1lw8TSi4Vqz5Wk2ADniOgxyenDMGYxpvCiwoet9RZ+
         JgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681882166; x=1684474166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/tN8bRwblazfyrY8uiba8tnTzSo4HB+oXO1oAVkqrM=;
        b=bw1EDr3VXdB+izEAVngsI8nqrWrpzHV2zVNoJyVDj/qA+paXqQqwmGGZnfrOmEataL
         MCHBW4F5lfhLPtDUJW4mrJgDbLEOEUYjveTrUUlTj7MVh1hyEusHce/e2kKAis2eIFyZ
         z14yjZUX0V2ioG6K7mVYcT9WNMRHw+KEMubEF15I1iw0p9Q52hx06yOS8c9VIy4FGdcl
         WBF8o8al/OhOD2nw1zfwdt+Kw/Twf87c9aZzGDz9dNJ0+NSdDhfxdIdEslyn0e4oiI6w
         5Es7q1bLiP2cxh7d0VMoc0pDpEH/kyXTtN6d3ce4VOHkiReq1bKRTxiHFP48mznTFs1Q
         4YVg==
X-Gm-Message-State: AAQBX9e7IGsEjw6/8HCjErbi7yUdoLT2QVKIRWgT++lmIKe/OUDWN2Nf
        oTXGiCsqejTDBAjfD2q1EXNnqhvlYm8ShTpHLrs=
X-Google-Smtp-Source: AKy350ah+hUa4foBonTZibettNZYPQiD+XIFizviGhQEJxLvLzMwm9bRy8WftOD67reewZqvoIXUGl0MMe8UtjCaXoY=
X-Received: by 2002:a17:90b:104:b0:247:e4c:d168 with SMTP id
 p4-20020a17090b010400b002470e4cd168mr1894363pjz.10.1681882166055; Tue, 18 Apr
 2023 22:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230417165246.467723-1-zyytlz.wz@163.com> <2023041756-scoop-splendor-0e01@gregkh>
In-Reply-To: <2023041756-scoop-splendor-0e01@gregkh>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 19 Apr 2023 13:29:15 +0800
Message-ID: <CAJedcCx_BxWyJFje+iwsJXoW0bngUD79cBuj+VSv08azDN1FjQ@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use after free bug in ilo_remove due to
 race condition with ilo_open
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, matt.hsiao@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C 01:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 18, 2023 at 12:52:46AM +0800, Zheng Wang wrote:
> > --- a/drivers/misc/hpilo.h
> > +++ b/drivers/misc/hpilo.h
> > @@ -62,6 +62,7 @@ struct ilo_hwinfo {
> >       spinlock_t fifo_lock;
> >
> >       struct cdev cdev;
> > +     struct kref refcnt;
>
> You now have 2 different structures doing reference counting logic on
> the same structure.  That's just not ok at all, and is totally broken.
>

Thanks for your reply. I'll look into it and figure out effective fix.

Best regards,
Zheng

> greg k-h
