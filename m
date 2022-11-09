Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF4B622B17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKIMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIMER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:04:17 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2242A726
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:04:17 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso9971879otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4vtgBkJ9+Vy+9EhJU5rTGh1H78MM04EIshNvBaitw8=;
        b=JDFYBWQRFva9aIbtyICwb140cRFYk760yFTxuR3lybcx0dhvV/OliBD8FwhH8Azb1i
         JZNCxfK5Jn8neGkg27K6xwigo+d0BQfaiqafPTsljC/VbJYWr87l5FlFyGmewWsX5+hM
         P7J39MUn+OsHoXLNDVFMPMSXkj7pSbU/UYGgRSkupMedGYix55F0VjSv0Qn0knUJW+/V
         6Z+JMmh6uLumM6uKCE3vMJHEPHTBe45732GY97LNuk4v5VcnjkmpycrrNHnTEi1g3uxs
         LCTdfpCXUtgyXl4i2jsF4ztG/m3CbtKU7MLVhzzsBHCu/VPsEohfFyoUY8R2YkVeVQe4
         pvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4vtgBkJ9+Vy+9EhJU5rTGh1H78MM04EIshNvBaitw8=;
        b=4Cb4GHV/RTm1PEcPFwC491eOYDrcPyUi+9DwXlnDx6/X7gy7ftiTtKZZS/iRgftU/y
         vSgSYZRHX6gDOjosAYF1d0Vm3wZfxnOsrNJXN4vp/Q/XM6HE23IhuKgCNnJ1ySsalQpN
         xbGRIY6lSwV0svDnrbbxpyUAfO0HTCEi7BQoOhYagQJc3kgEpg4DA8GGPj9NM5p8IeYj
         oYzvCyNNwZRMrmCGiS5rXjJ7Ufz0W3747FUDna0cMPasPRZeKKB4tNvQwdvF+7gi6Mka
         XcnuCaUjHpfBIwHfpSDNmV/STuNe6X861MT3X7/oeGBU5KZYsVk5SI9c7g3u0nGV/QiW
         rRoQ==
X-Gm-Message-State: ACrzQf0mgCWOXXl9/zG5n3G0ZOZ3cvTgxJW9b7X3heKcDHm5K7m4trcC
        ai7HfBeHf6ZJoK4FwEq3GzcNTy7oiXPetye0250=
X-Google-Smtp-Source: AMsMyM6YV3D3O9XzaWpSobPMckredTZf1dDlP5SYenqZKtauPiXHFe/YKQMAvjp+rGrSDMrl4kUoJlYRwhtDyO0Gwcc=
X-Received: by 2002:a05:6830:628b:b0:660:d639:f380 with SMTP id
 ce11-20020a056830628b00b00660d639f380mr28592000otb.181.1667995456321; Wed, 09
 Nov 2022 04:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20221109105158.230081-1-zyytlz.wz@163.com> <Y2uLK6Zxsz9TD9WV@kroah.com>
In-Reply-To: <Y2uLK6Zxsz9TD9WV@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 9 Nov 2022 20:04:04 +0800
Message-ID: <CAJedcCyN+D+gsVo10r-bGpAtnL4x_N3TpqhVYBi1P7=dD8fNCw@mail.gmail.com>
Subject: Re: [PATCH v8] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=B8=89 19:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 09, 2022 at 06:51:58PM +0800, Zheng Wang wrote:
> > Gts may be freed in gru_check_chiplet_assignment.
> > The caller still use it after that, UAF happens.
>
> I do not understand what this text means, sorry.  Can you try to make it
> more descriptive?
>

Sorry for my unclear description. The new candidate is as follows:
In some bad situation, the gts may be freed gru_check_chiplet_assignment.
The call chain can be gru_unload_context->gru_free_gru_context->gts_drop
and kfree finally. However, the caller didn't know if the gts is freed
or not and
use it afterwards. This will trigger a Use after Free bug.

> >
> > Fix it by introducing a return value to see if it's in error path or no=
t.
> > Free the gts in caller if gru_check_chiplet_assignment check failed.
>
> Please wrap all of your changelog text at 72 columns, you have 2
> paragraphs with different wrappings.
>

Get it, sorry for that.

> >       /*
> >        * If the current task is the context owner, verify that the
> > @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_threa=
d_state *gts)
> >        */
> >       gru =3D gts->ts_gru;
> >       if (!gru || gts->ts_tgid_owner !=3D current->tgid)
> > -             return;
> > +             return ret;
>
> Why does this check return "all is good!" ?
>
> Shouldn't that be an error?
>
This check is something like "if the gts has been initiiazed properly".
If it's not, I thinks we shouldn't treat the gts like something very
bad happend. Because in the later request, the gts can still have a
chance to be configed/updated properly. This is different from "it's
too bad so we have to unload gts right now". This is just my personal
point of view. Besides, the caller of this function have token it into
consider. In gru_fault, it will try again and in gru_handle_user_call_os,
it will return -EAGAIN. In gru_set_context_option, it will be fine
because there won't be any operation on gts->ts_gru or gts->ts_tgid_owner

Best regards,

Zheng Wang
