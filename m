Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629C6B7E27
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCMQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:52:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740411654;
        Mon, 13 Mar 2023 09:52:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z11so8046062pfh.4;
        Mon, 13 Mar 2023 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678726330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOFdabu7opaTMWX08dN/r7zw8kqC2+tr0Pyf4B4k0fg=;
        b=J/osfsiLnFSAAdLwTXOK6VyRnLvCsT6BQDuBN41DWPmbr6hEZPzKP9hR1vNJ4f4sdf
         I1X+fxfmsrUOFEI9Y2EfhbyeNXRZi2lHiSTgBFrMREdKZpcwJTsgmI7TcVLSEHjh4LK0
         2Ym2S+kEGxQnlWahehWOnxzr550NHDPhKC8NyTHR/aVw4Dl3Lt9OF/xHt6gK/ldRrlKw
         k5+XCZcGsPOBCKF8TTRklOsFZ5DcGJKw+lOn1a1CiXim06UKLYTctY/nLwcVLcpliXC7
         +5vF+C3l9fK6Oi7mQsOoXMv8iaam1fZaCCHKQ5qkx1jETB7POBZmT6CcoFKbpdsqxxY2
         FsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOFdabu7opaTMWX08dN/r7zw8kqC2+tr0Pyf4B4k0fg=;
        b=CWVTX8YcEoKcAW0sSidVCioOv1VoU+Rp8jI/29v6IltfCBB/cmVPQu2iNq2edjfKho
         FD1Gp+OO5LvaiUD5CEYlh9HCk2XH0R1Irnl1acapZTpAkoU1MhQikjy/sFh53C+H1PcD
         ht/kS4N4adydjh8AhycTJy4Z6NdBKLiYZ7pz8TEYyr9XGYfZbIC/sIMWh+TM9tzMOto+
         wl97exejd2dGwOgkTTn9MctlQCxAaR6HdizZWoenjqvPrN7dg/0Rc8aKWo2Epyv0S+0B
         jjzIihwJq+8u8cte1Oryvvyb0zRoU+gmhutfFpPAA4OIQxBy6q9llU9TFnSPP5OQMBAI
         S/0Q==
X-Gm-Message-State: AO0yUKWvPcue+QTm9j41+G6XdDV6SdwRdWo1bofrSwZ1bJreR0UEbwiz
        XAk2usLYYlPwMyCBLlm1KGwBa59EFAwuEcLu6Cw=
X-Google-Smtp-Source: AK7set9X1oi857MQ6sv8BdmzrbebDEbxt5ITF4V+P0sArF3B6WommSTgyrgXe2XRYGmoJEBk4gylh4xmvhNX/1wXRVE=
X-Received: by 2002:a63:7d03:0:b0:503:4a2c:5f0 with SMTP id
 y3-20020a637d03000000b005034a2c05f0mr11421344pgc.9.1678726330094; Mon, 13 Mar
 2023 09:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230313094852.3344288-1-zyytlz.wz@163.com> <TYBPR01MB5341E00031218B3868145C58D8B99@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341E00031218B3868145C58D8B99@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 14 Mar 2023 00:51:58 +0800
Message-ID: <CAJedcCxw3Uqah_d0Uh_4CeT7-ajjspjixfWLvj0xNNOwBAxE9g@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> =E4=BA=8E2023=E5=B9=B4=
3=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 20:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> > From: Zheng Wang, Sent: Monday, March 13, 2023 6:49 PM
> >
> > In renesas_usb3_probe, &usb3->role_work is bound with
> > renesas_usb3_role_work. renesas_usb3_start will be called
> > to start the work.
> >
> > If we remove the driver which will call usbhs_remove, there may be
> > an unfinished work. The possible sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove
> >
> > CPU0                  CPU1
> >
> >                     |renesas_usb3_role_work
> > renesas_usb3_remove |
> > usb_role_switch_unregister  |
> > device_unregister   |
> > kfree(sw)          |
> > free usb3->role_sw  |
> >                     |   usb_role_switch_set_role
> >                     |   //use usb3->role_sw
> >
> > Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of u=
sb role switch")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>
> Thank you for the patch!
>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>
Thanks for the detailed review :)

Best regards,
Zheng
>
> > ---
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
