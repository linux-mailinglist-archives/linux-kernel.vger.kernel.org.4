Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927366BD0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCPN2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCPN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:28:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615A32CEB;
        Thu, 16 Mar 2023 06:28:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id le6so1712976plb.12;
        Thu, 16 Mar 2023 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678973311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujpNXR2pIagHVWjxanwK9eWKfuJtXusyhgfh4aG4oiw=;
        b=Z52QNhAQUwhV6Reeil0TjKBKAciMdTVU0FWXb276PgxEEt8K4V3gK9p2fymSgaZ2b7
         Aa3SWcEw1NoxbooBQKWAFCbz3sqxNiRbgh02wYSicQE2sxTV4YJPyNad8vgtpZtVWdqX
         DJfInSOcsX9wpM8wuRwFnbfn1YFWZLxdupundFNS9W3oK60wYe15wM3VVmuH59eUpstg
         hNE1nBNWaxj08glQf38rofzT/kugbP0sMFWwtUS5HIZC+1d7E/0bLXwknoCZm85nMY/g
         VmlTxeDOJjD0gPVZ7YwwTTdkZr939FPD9fkdQ3sCbd+pPXPh1HkA21rV+/q9KWUJklZu
         EVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678973311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujpNXR2pIagHVWjxanwK9eWKfuJtXusyhgfh4aG4oiw=;
        b=dIZQxpBy4OfQb+hEHEytsLpFKft2VPPkNAoltft4UT+YXw4SPWYIoJ5TIU4NieUDGx
         DvSCJrQtX30zFHy3MqKZ/EURrgN63isJko/d30hIZz1fR0JjwH7NPpnt5YP7zRvXfR+S
         Y1DETcLjAWKh1tpFGd/a0Amb7tT2/bJumWDSGjlLXMvDanVbk5t/QsKu/2WrD3hVxvIX
         U8BjrSHEIIie4TWLUroWDEmR+7dPsDUM1/d9MPzDzI4YNzRWfrgLMTE9r/NdNRmq07Kw
         0a6zSIVWR3FKOaWhM8DnkBsHMSBDNNXBFtLKLJpCTUKMdCJ4J5+cFGxQ4ZvBkc2ow69s
         lx7Q==
X-Gm-Message-State: AO0yUKWEOYlJcamMltnRyR4kxkesr665cm7DUwRFmrgOwcwHs28puXPv
        DjRlSbgJ96eNwBCa1aXH4Nv2M/uwzPrHv7xdFt0B6D3boBIIvahz
X-Google-Smtp-Source: AK7set+Gwo2iohfylEc1rLBtY3ty1Dsf4/HjSNhiX+H1FGurFlZpcoGc/L97juUXBFPvMsZobdCEti3zjsKmlBuhriI=
X-Received: by 2002:a17:90b:8d3:b0:23d:360:8771 with SMTP id
 ds19-20020a17090b08d300b0023d03608771mr1125541pjb.9.1678973311169; Thu, 16
 Mar 2023 06:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230313165128.3763626-1-zyytlz.wz@163.com> <ZBL1jyAQJ2YPsKUe@kroah.com>
In-Reply-To: <ZBL1jyAQJ2YPsKUe@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 16 Mar 2023 21:28:19 +0800
Message-ID: <CAJedcCxxuRjzaAyUk2qKkT6e-mFsgEhL_fmg+MJ9546rV4TYrQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free bug
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 18:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 14, 2023 at 12:51:28AM +0800, Zheng Wang wrote:
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
> > Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v3:
> > - modify the commit message to make it clearer suggested by Yoshihiro S=
himoda
>
> I see 2 v3 patches in the mailing list, which is obviously not correct.
>
> Please resubmit a v4 properly.
>

Hi Greg,

Thanks for your kind reminder. I'll resubmit a v4 patch later.

Best regards,
Zheng

> thanks,
>
> greg k-h
