Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775CA6BB1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjCOM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjCOM3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:29:25 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD81681CF7;
        Wed, 15 Mar 2023 05:28:29 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id o2so16765293vss.8;
        Wed, 15 Mar 2023 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678883303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNVHjgACw5m4etYQygiQVMUCwIq83fKlHnf6HwLgnPY=;
        b=ad+ZD6vU572cmzFO31pw7Da/rJHjF2M6YDbB43dD6IKR0DLEwLhhsaL9uRhQUhEdla
         BSNhbkmUJeuz4Ehw4O8A6RSjkdzO4zZLbgxUyr1kF/v2xiKIw7ylA10xKBDHG8voFloC
         gxwIQMCrYQ19lRMAxji4Jf1Msxj92IQYWN2DFJH+niMUknehluMj0kYRDBBjmVgeHB8M
         B6vIOlw2HABR4gbYKqFoa0XffhHvpVI+LA1qd1MAasCDQVEiViF33Gd2NgL6bxMzNu1H
         X/i6jsUcm3Iz9OYEwq1zPnrgaL6PqPHTwoVZaX6+BRQMyJwFrJPpPelOir99vnzrYlFQ
         9+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNVHjgACw5m4etYQygiQVMUCwIq83fKlHnf6HwLgnPY=;
        b=v+rxquRghOKJFuJamF463z7O2TPiFWkv0SmXrvj2v6QIqhlNLUEBzEVV+ZoZqTUbsS
         pMmEXODsDL9jmePTFy5YiUTU+HP8z8rqkGgyDz44FPikJLAjqxRZ37/JAAToZKzzQHxQ
         LQGy6Q1yGJ6YLhBO4fX9HJFrvPna7e38G9gmlCYytljSFvDiMgIZ8gKEU1zq7YMrN/Q9
         NYDxsAJihLqjNaypOItzdAyqnTU3BGxy1jEdh8A08qSOK988YGwd3O806GdWtqYrS0SL
         QAHRCxDwzTd/c8zPgn0h1zL7k1wDY6DyRlXQL+J/YzFs/FjUD0jTC5wU4Ta/tPn6rE5r
         r1oA==
X-Gm-Message-State: AO0yUKXIhVIyMmva1wroIpEur6Ta1+9/iFep95N2ZGZgx1ub7GWf6Xbr
        QTblLo7NdAtetjCOASG0DpUuiGvJJBvd2JQX7QPdQmEr86AwDAOM
X-Google-Smtp-Source: AK7set8+bi06WRs0QVtLJ5jyk5rHeeEH3WrPrItgBraivb0Ap0YZTz3fIoZ3F94Lfx9Pie8xlJLbewg5Dto+lIfK40w=
X-Received: by 2002:a67:c990:0:b0:414:4ef3:839 with SMTP id
 y16-20020a67c990000000b004144ef30839mr26101454vsk.7.1678883303182; Wed, 15
 Mar 2023 05:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230315092254.1042615-1-harperchen1110@gmail.com> <360b814b-40e0-5444-8d6b-1e29719e4414@suse.de>
In-Reply-To: <360b814b-40e0-5444-8d6b-1e29719e4414@suse.de>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Wed, 15 Mar 2023 20:27:47 +0800
Message-ID: <CAO4mrfeGWBic546QyDG=CwDuZ-ouCc8UUV_aH7syqO+WhbDBBw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: au1200fb: Fix potential divide by zero
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,

Thank you for the kind advice.

In fact, I notice there was a discussion regarding whether to put the
check in each individual driver or solve this problem as a whole as
you suggested. The conclusion is that it is better to keep the check per
driver rather than in the caller.

Related discussions are here:
https://lore.kernel.org/all/YXclZQGFTr1NFjbc@ravnborg.org/
https://lore.kernel.org/all/YPgbHMtLQqb1kP0l@ravnborg.org/
https://lore.kernel.org/all/20220404084723.79089-1-zheyuma97@gmail.com/

Thanks,
Wei

------ Original Message ------
From "Thomas Zimmermann" <tzimmermann@suse.de>
To "Wei Chen" <harperchen1110@gmail.com>; deller@gmx.de
Cc linux-fbdev@vger.kernel.org; linux-kernel@vger.kernel.org;
dri-devel@lists.freedesktop.org
Date 2023/3/15 18:25:52
Subject Re: [PATCH] fbdev: au1200fb: Fix potential divide by zero


On Wed, 15 Mar 2023 at 18:25, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:
>
> Hi,
>
> thanks for looking through these drivers.
>
> Am 15.03.23 um 10:22 schrieb Wei Chen:
> > var->pixclock can be assigned to zero by user. Without
> > proper check, divide by zero would occur when invoking
> > macro PICOS2KHZ in au1200fb_fb_check_var.
> >
> > Error out if var->pixclock is zero.
> >
> > Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> > ---
> >   drivers/video/fbdev/au1200fb.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au120=
0fb.c
> > index 81c315454428..b6b22fa4a8a0 100644
> > --- a/drivers/video/fbdev/au1200fb.c
> > +++ b/drivers/video/fbdev/au1200fb.c
> > @@ -1040,6 +1040,9 @@ static int au1200fb_fb_check_var(struct fb_var_sc=
reeninfo *var,
> >       u32 pixclock;
> >       int screen_size, plane;
> >
> > +     if (!var->pixclock)
> > +             return -EINVAL;
> > +
>
> Instead of the whale-a-mole approach of fixing individual drivers, could
> this be solved by testing in fb_set_var [1] and fb_try_mode.? [2]
>
> Best regards
> Thomas
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/video/fbdev/core/f=
bmem.c#L958
> [2]
> https://elixir.bootlin.com/linux/latest/source/drivers/video/fbdev/core/m=
odedb.c#L567
>
> >       plane =3D fbdev->plane;
> >
> >       /* Make sure that the mode respect all LCD controller and
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
