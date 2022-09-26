Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1A65E980A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiIZCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiIZCmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:42:01 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B0DC5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 19:42:00 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id mi14so3560944qvb.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=dIhWaTLw53VBMM7BkjSiOqJQIDHqJKwewIkv4Us74eY=;
        b=W0RBpGI4SPbk0bfSYrBcyLQ25lsMpcl7GixgeZJ+NViPtE21yu/e7j7JUlewpmIQg5
         frVS6FoU1sF9FTFmg59ls5feV5yoWjuGuuHBUal7zOVoUW+Qo4Og6c8GbaPzz3z6o2fE
         J2s1PtjICYpEu1BOkXDZXLZIRMRgHf2d7u0+duDC2o33Rgq5pGT9ysyn6B0PJlG8iJBf
         LpBij80oi1/KoRUpwOTH10lMFHC80jp7AZu+W5t3wDRHAJw/Habmskj/fxcoEqP5jYdm
         GAJPpemTvEWOdZzKkO9T4vVgimUzNRzTJGHjfh3y1foOoO+3mI8SowSl7eOJ+TtEL4+2
         rLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dIhWaTLw53VBMM7BkjSiOqJQIDHqJKwewIkv4Us74eY=;
        b=UQp88Aak/qfn+r/QBQ/t2keiw/vhcCur7RSS1x0UhJymFDTsTOi+keTlwaGtmdmp4E
         ukiVaslM/+qSzy4a7+H8XsOK0IPi61VSFFv0yHecibcbq7Xo7Mnci4He/+KO01YAgUH+
         VmSKQ5B0NMqK0QciIk7ff+PPmecijbFStoY4tFZtY6HqLQRBJK/6AsitCbvsfinunbrU
         ENzqukUsSUD51Mpc8EqP4DJ67EuW6OX8MEF1pPjKhGR5X+mViTcjG/zypawm1lNeLYtL
         SziTU2a7Wr16gkakCphOu8xQULPNvhH/L4WDJ7JeeMv2FFh8BqDTlBAJlrj2BW9nNXIH
         PKpw==
X-Gm-Message-State: ACrzQf2vCygGqkOrHfe3XRjii3Yxu6jBR1cOBQzOyhirD7ARh4tHJyfG
        uNSK3jNW3phbbpKzkjnDVIz+gp6k3C3SvaiUL6Y=
X-Google-Smtp-Source: AMsMyM4AZ3j7OtQy9iBFEkLuCYZJbt2oTI2gVnS1x3rFc2DIdzxR1bjg6LPhLmg/ORMmpxyP1+D7OL2RGs0pO6IRtlw=
X-Received: by 2002:a05:6214:d4f:b0:4ab:20:87c5 with SMTP id
 15-20020a0562140d4f00b004ab002087c5mr15787540qvr.55.1664160120105; Sun, 25
 Sep 2022 19:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143205.207353-1-zyytlz.wz@163.com> <Yy7+BCQnGaQiNlyF@kroah.com>
In-Reply-To: <Yy7+BCQnGaQiNlyF@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 26 Sep 2022 10:41:47 +0800
Message-ID: <CAJedcCyLN1xEndJ6K0Dr8hux2kS2KFCtvcCcFAdFX7gSBKTmrg@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
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

Hi Greg,

Very happy to receive your email. I was outgoing in the weekend and
sorry for my late reply. I'll fix the patch and resend it to you.

Best regards,
Zheng Wang

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=85=AD 20:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 19, 2022 at 10:32:05PM +0800, Zheng Wang wrote:
> > In grufile.c, gru_file_unlocked_ioctl function can be called by user.
> >
> > If the req is GRU_SET_CONTEXT_OPTION, it will call gru_set_context_opti=
on.
> >
> > In gru_set_context_option, as req can be controlled by user,
> >
> > We can reach gru_check_context_placement function call.
> >
> > In gru_check_context_placement function, if the error path was steped,
> >
> > say gru_check_chiplet_assignment return 0,
> >
> > Then it will fall into gru_unload_context function.
> >
> > And it will finnaly call kfree gts in gts_drop function.
> >
> > Then gru_unlock_gts will be called in gru_set_context_option function.
> >
> > This is a typical Use after free.
> >
> > The same problem exists in gru_handle_user_call_os and gru_fault.
> >
> > Fix it by introduce the return value to see if gts is in good case or n=
ot.
> >
> > Free the gts in caller when gru_check_chiplet_assignment check failed.
>
> Your text formatting is a bit odd, don't you think?
>
> >
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com> Zhuorao Yang <alex00=
0young@gmail.com>
>
> Why twice?
>
> Should be two different reported-by lines, right?
>
> Otherwise looks good, can you fix that up and resend?
>
> thanks,
>
> greg k-h
