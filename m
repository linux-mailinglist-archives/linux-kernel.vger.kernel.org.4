Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02883603829
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSCja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJSCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:39:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E991710AD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:39:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a24so10901993qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN2EWrILiQrRJslD3AmqjjvOaJTVo7kUmhNOMbgSNik=;
        b=m8d0b3sCNHD0rU0TTR2jchLoq7ZhaPBAAcwrQp4245VPWxIiIY/wp/sPJadO4magha
         mJDYwJ26qfgFE2985oVaT2SoiCvjBxNf3bJwH2bA8wAb5jf+630oZ5b/I81G6XYDflNs
         MWxDgcJsqhcghreVT2QCuZuS1jrn+GCpiDjPbOs+ioTol8u2LLpv5BsdSFi7uTV5n7nm
         4RoO8sU7Yb1iCiT7uJ033UKiFUNb2RZ31uczhRAH88qeXUQ21duWKDmpXo3fREsvpyqz
         eZvirF0j91CK/cENlRkpKzL9d9bkbK2BFZKRGz8Z3vyz4CbvPON3Sa36eB9hDZvEWRKp
         2lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN2EWrILiQrRJslD3AmqjjvOaJTVo7kUmhNOMbgSNik=;
        b=WUDMZe6lb6tJJCLn141BHyboWe8Pqu5SJHj5PQg8edia71XtWnMpYk0AKsyDZkVH4q
         1nlYjHidSZTmrC8Ew5GSSo67TWOeES06ko8F0I/xp7qWlM6tpSx8JG1/RARXSXdVJJXL
         ZUDHVwAkAaei8HIfgzcDNHxRhINxnJqhAUEuTs4yLd3ukT38+iH8iXmjkKYi77yM55WH
         kKR+0uNpbJLp4H1xFKXbD2vs0PbyEF3bzMUgTshsDcJa08guUNHJImudLhIKlSCIwFyo
         zda+TGiUJ8YhVoiQWAftJISAmV/BB+/8PyHood0g6j00H9hArhsrmwK2jYus+SFRK0kV
         Y6Cg==
X-Gm-Message-State: ACrzQf3wKoOLOGj/VNUN3wBT4ppxo/lCnUzwZd+xjYjxlLso89SHl/7O
        JryVFU+y7JeKTMaT4T2R9IZILVAmbhkk2mIrOTmkf9NHeD8=
X-Google-Smtp-Source: AMsMyM6vOPd78ff97OUhCBf1FX2F8Vl5yI9JPuSXme6UlztoI6xw8Cj6rIHwmJ3wKOR47AsVAs40UNTWpZ7P2d4N/Y0=
X-Received: by 2002:ac8:5fc7:0:b0:39a:a3c7:4341 with SMTP id
 k7-20020ac85fc7000000b0039aa3c74341mr4777455qta.567.1666147164037; Tue, 18
 Oct 2022 19:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221018165259.693958-1-zyytlz.wz@163.com> <20221019095556.3465031-1-zhengyejian1@huawei.com>
In-Reply-To: <20221019095556.3465031-1-zhengyejian1@huawei.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 19 Oct 2022 10:39:11 +0800
Message-ID: <CAJedcCzTfjeeoRzdMZHHtYhpcx+1TiM-cf7UKwwrDw83OtWAUA@mail.gmail.com>
Subject: Re: [PATCH v3] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     zyytlz.wz@163.com, alex000young@gmail.com, arnd@arndb.de,
        dimitri.sivanich@hpe.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, security@kernel.org
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

Zheng Yejian <zhengyejian1@huawei.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=89 09:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 19 Oct 2022 00:52:59 +0800, Zheng Wang <zyytlz.wz@163.com> wrote:
> > Gts may be freed in gru_check_chiplet_assignment.
> > The caller still use it after that, UAF happens.
> >
> > Fix it by introducing a return value to see if it's in error path or no=
t.
> > Free the gts in caller if gru_check_chiplet_assignment check failed.
> >
> > Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v3:
> > - add preempt_enable and use VM_FAULT_NOPAGE as failure code by Yejian
>
> Sorry, maybe I didn't make it clearly enough in
> https://lore.kernel.org/lkml/20221009201418.509417-1-zhengyejian1@huawei.=
com/
>
> What I suggested was that return value of gru_fault() should be some VM_F=
AULT_XXX,
> because this return value would be specially handled in pagefault flow li=
ke:
>     __do_fault() {
>         ......
>         ret =3D vma->vm_ops->fault(vmf);
>         ......
>     }
>
> But in other functions that are not in pagefault flow, common error code
> like -EINVAL is ok. Meanings of every error code can be found in:
> https://man7.org/linux/man-pages/man3/errno.3.html
>
> By the way, these are all personal suggestions. You need Reviewed-by Main=
tainer :)

Hi Zheng Yejian,

Thanks for your suggestion! Sorry for my late patch, I was a little
bit busy last week. I think the trigger path of this issue is divise.
So yes, -EINVAL may be a better choice.

I'll update the patch soon after.

Best Regards,
Zheng Wang
