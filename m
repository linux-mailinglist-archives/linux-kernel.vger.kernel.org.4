Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002546BD700
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCPR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:26:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C131457EB;
        Thu, 16 Mar 2023 10:26:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ja10so2531640plb.5;
        Thu, 16 Mar 2023 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678987563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIpspfcq433YYpVyc2+2HNwIim7kmYWAvZxpFDodPGA=;
        b=qrbh179zGwz/tzTHa95r9xJ9wtKxnWpyRvaGAZPyYndo0+/bM6huYFuCX3qov63CZV
         Gi5j3eshxpud7rimNPKrxe01lXeNzoLkF3mSUJt3pnrTVoNektEsnRIp0wImQHc/0Szl
         L1z7gkRqJeIByTMk7NjEEuOqfEKJCDGn++anO+jmqB2xIiWJn8uVsFwlNqkJ0+mb9Vjz
         jB+Oa/FzR7Q1VzYI6XYObocI2NvsaXdRmJA816eFEqhEbA6tFEwYTjIgq6qgVkVNfpkA
         iVPBLYCyVjxV/1gXwcG0y0/6qgZiPO6U0J0L18VxvcpvKtLlLZPXIdQT/dopXLUsDSPL
         1rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678987563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIpspfcq433YYpVyc2+2HNwIim7kmYWAvZxpFDodPGA=;
        b=de1MxWRmkZMPbi5p8p5U+fTTs28w+t3uMbDt9cGKBDUpaVv/ao68yc2SWmdBZII4yJ
         Nl2xPe2O1BZdcAx4KxddrX7EeXDfE7vwfEuh3st6lGurr9ajY5vEKyZts6B5/hYU+45v
         nwvWhxIOJg+zT/1bxHPrEOhDhEnOJa110lm/JBAJzQyRVcsAueL81XpLJmYHyIhXJBEM
         h2wVyPZsH3IHyM9w6fxPNAw8a6dVnqaegt3DQ5mrgqx5thr7JOBfONgBy8qNBYxtjKHC
         qromBhwTD8U5LvwsEEpx5K1pRW38xy9L/qZH8LmM4Em4K7r+FDqFWR+CBuFsV/tDHY29
         MQrQ==
X-Gm-Message-State: AO0yUKVbVQk3WfZSF7RqbhPjZCR1qoIdb+JyQnGYj5vMERWCgcK9N9xT
        ZXvBhLTUbnbTNFHpw2SHK5XiXKHeIpEBWWuAdt0=
X-Google-Smtp-Source: AK7set+rzE43RchTLXIMDlJhy9z6qiZh7Nue+oPLlEN4GtLa4y+mD94wPRTtgXR1K0JhmUefOkaxW4VLIaKwvKgyzWA=
X-Received: by 2002:a17:903:32d1:b0:19f:3cc1:e3be with SMTP id
 i17-20020a17090332d100b0019f3cc1e3bemr1823624plr.12.1678987562995; Thu, 16
 Mar 2023 10:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230316155645.1565045-1-zyytlz.wz@163.com> <ZBNCam0XjWehrF3c@kroah.com>
In-Reply-To: <ZBNCam0XjWehrF3c@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 01:25:50 +0800
Message-ID: <CAJedcCw4DbpdiL8w+xQfGU87eV_yU-SSojX++-=GGrdKqHYxLA@mail.gmail.com>
Subject: Re: [PATCH v5] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, p.zabel@pengutronix.de,
        biju.das.jz@bp.renesas.com, phil.edworthy@renesas.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        yoshihiro.shimoda.uh@renesas.com
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 00:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 16, 2023 at 11:56:45PM +0800, Zheng Wang wrote:
> > In renesas_usb3_probe, &usb3->role_work is bound with
> > renesas_usb3_role_work. renesas_usb3_start will be called
> > to start the work.
>
> You have a full 72 columns to write in, please use them :)
>

Thanks for your kind reminder. I'll fix the format in the next version.

> >
> > If we remove the driver which will call usbhs_remove, there may be
> > an unfinished work. The possible sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove.
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
>
> Why can't this be written so it looks better:

Sorry, I'll beautify the format next time.

>
>  CPU0                         CPU1
>
>                             | renesas_usb3_role_work
>  renesas_usb3_remove        |
>  usb_role_switch_unregister |
>  device_unregister          |
>  kfree(sw)                  |
>  free usb3->role_sw         |
>                             |  usb_role_switch_set_role
>                             |  // use usb3->role_sw
>
> Note that removing a driver is a root-only operation, and should never
> happen so please also say that.
>
Get it.

Best regards,
Zheng

> thanks,
>
> greg k-h
