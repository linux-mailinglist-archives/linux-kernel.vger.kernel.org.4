Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A986BF87E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCRHk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCRHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:40:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6416AD8;
        Sat, 18 Mar 2023 00:40:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so150915plg.4;
        Sat, 18 Mar 2023 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679125222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBBLMRM/PZKumcexTVfMug0lCqZMyVFJGM72Wbie5Vw=;
        b=ed3ZmNhauAcltTAVY9zqxLIUYcqcP+w3gHuuSt3V+TfPS38ZxxMBULPTbSjRie53iN
         q2JsFF7OL3i1cvvLnslkCcd2xhJFJKYEBKDrorzLTiStyyujizLODrb0PcJpw5h7LNk4
         NEaoanDNIthgQN7JC3WI1Ce5jnQ/801YwmX4+UoPxsS+NEikSRQlXAifLWcJjIo2uLOF
         u6e41rXu858fCB4G/UVJaQNjYJVAQzLyYRN4paOWsJ5NN/wLe0KKCTcgZjfQqcVyRp6V
         W1M67ip/yo07GZgdFx5RhutJZ4GtRqsQEdeXmub+Y/kabb+WmI1nmY9gk5DG741fj3yH
         SkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679125222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBBLMRM/PZKumcexTVfMug0lCqZMyVFJGM72Wbie5Vw=;
        b=wLQF1zpYQ2/NRXDWYRPpfvccoJdUP/6vb6jI+t0BlIFRyPzp50tiGrIGCBaCKbjhGS
         +SN8Pl46v1vcbZjMVhj6F29j9W4Q5u5KNXOIMZWAco7Q4cnO+VMnW9L9YqiZuwUuxhEM
         ujO19/umUa1y8sqlaGEnXoJt0zO15umYeoznEoigO4egRWoqMafXc0Q2EiNOtWvAUd8A
         alW4ocHkTFkfUkLGLweAiRXWTcmxhE9HKV6dk8C+67iGWJxwTN8s4eyyBqIPY1kjExHo
         XVe+9X3GEvN+rtgdBUTz25O919ALCODVNSVMTsXB5d2VdOTarpfUnr9eOM2nKJ1H4JP5
         zWeg==
X-Gm-Message-State: AO0yUKXTAxt5WG1k5UhekHWcwFElPoeqIqjIg4V4G2jkRz7xmaunmzLq
        HsPnH7u4NeWto6XcYzPjXj0WrWJPAyHr7kGUJAM=
X-Google-Smtp-Source: AK7set+0cgUnCm6Awt1gdcBMJ7tls+kBw3GmeS7dTLtdp7tCX+CG8Me8WYHWs5whocczji2CSUsgj2wt0TOm8bC+qM0=
X-Received: by 2002:a17:903:32ce:b0:19f:3cc1:e3c3 with SMTP id
 i14-20020a17090332ce00b0019f3cc1e3c3mr4035463plr.12.1679125222320; Sat, 18
 Mar 2023 00:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230317095505.2599838-1-zyytlz.wz@163.com> <OSYPR01MB5334DA88B0881C50E819A19CD8BD9@OSYPR01MB5334.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5334DA88B0881C50E819A19CD8BD9@OSYPR01MB5334.jpnprd01.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 18 Mar 2023 15:40:10 +0800
Message-ID: <CAJedcCwG-e9i2-V=+iYYXPU7MtzEQoNESWdQ8wPaKLto2swZ6g@mail.gmail.com>
Subject: Re: [PATCH v9] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "phil.edworthy@renesas.com" <phil.edworthy@renesas.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
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

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> =E4=BA=8E2023=E5=B9=B4=
3=E6=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 20:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> > From: Zheng Wang <zyytlz.wz@163.com>, Sent: Friday, March 17, 2023 6:55=
 PM
> >
> > In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
> > renesas_usb3_start will be called to start the work.
> >
> > If we remove the driver which will call usbhs_remove, there may be
> > an unfinished work. The possible sequence is as follows:
> >
> > CPU0                                          CPU1
> >
> >                                        renesas_usb3_role_work
> > renesas_usb3_remove
> > usb_role_switch_unregister
> > device_unregister
> > kfree(sw)
> > //free usb3->role_sw
> >                                        usb_role_switch_set_role
> >                                        //use usb3->role_sw
> >
> > The usb3->role_sw could be freed under such circumstance and use in usb=
_role_switch_set_role.
>
> The checkpatch.pl said:
> ---
> ./scripts/checkpatch.pl this.patch
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars=
 per line)
> #75:
> The usb3->role_sw could be freed under such circumstance and use in usb_r=
ole_switch_set_role.
>
> total: 0 errors, 1 warnings, 7 lines checked
> ---
>
> > This bug was found by static analysis. And note that removing a driver =
is a root-only operation, and should never
> > happen in normal case. But the attacker can directly remove the device =
which will also triggering remove function.
>
> I think you should fix them about 75 chars per line) too.
>
> And, I don't know why "attacker" is related to this issue.
> I think "the root user" is better than "attacker".
>

Thanks for your detailed check and advice. I'll apply it in the next verion=
.

Best regards,
Zheng

> Best regards,
> Yoshihiro Shimoda
>
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove.
> >
> > Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of u=
sb role switch")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> > v9:
> > - append with more information suggested by Greg KH
> > v8:
> > - replace | with spaces to make line up suggested by Greg KH
> > v7:
> > - add more details about how the bug was found suggested by Shuah
> > v6:
> > - beautify the format and add note suggested by Greg KH
> > v5:
> > - fix typo
> > v4:
> > - add Reviewed-by label and resubmit v4 suggested by Greg KH
> > v3:
> > - modify the commit message to make it clearer suggested by Yoshihiro S=
himoda
> > v2:
> > - fix typo, use clearer commit message and only cancel the UAF-related =
work suggested by Yoshihiro Shimoda
> > ---
> >  drivers/usb/gadget/udc/renesas_usb3.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget=
/udc/renesas_usb3.c
> > index bee6bceafc4f..a301af66bd91 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2661,6 +2661,7 @@ static int renesas_usb3_remove(struct platform_de=
vice *pdev)
> >       debugfs_remove_recursive(usb3->dentry);
> >       device_remove_file(&pdev->dev, &dev_attr_role);
> >
> > +     cancel_work_sync(&usb3->role_work);
> >       usb_role_switch_unregister(usb3->role_sw);
> >
> >       usb_del_gadget_udc(&usb3->gadget);
> > --
> > 2.25.1
>
