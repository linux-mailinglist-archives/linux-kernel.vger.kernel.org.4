Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696CB706551
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjEQKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjEQKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:33:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A6449C9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:33:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5341737d7aeso493373a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684319583; x=1686911583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+yMSRIvro+oycNAw5kvcuepkix/lZDUJXF17xDJqQs=;
        b=r79UGOC27PdAxNjuhydpx7NpMnekSB4YkiixqH6+hR3Gn3K6V4tG7PdEPzQUuu3VwZ
         RagVi1Ho5iB5GIKbC7A3u5cjAh+JUIpRyh/8EapJzQ2Cejk0drmRiq4NM+BIWMBLyS7Z
         9PNyLcuQ4rDCtpC2LVUP5eejvj276UFY+yZk8cXHMXCyB07zS0DOX2bsuKDDJeUpvQBs
         t1Lb+Eytf9VfC/Ck2ak8USU5L6Kd+Igx6iEEn4UChj5bx0AKMnm3UMgkgGEH2KSQP19A
         iUXJeK81eLwgmFs5xr+cuhWT4MI0mjsrxyhv6H8OsvGXoBB8rRojw13sA3ac0knI8MZH
         3hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319583; x=1686911583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+yMSRIvro+oycNAw5kvcuepkix/lZDUJXF17xDJqQs=;
        b=bSKavCeB+gxYrTpHRV5EzMAxlFpEPHTRCDo5OlG8/wfOA1njXe27UgwxEZr1cOyduJ
         CDuEv6K87TyKtLaOZ8qMnT/iet+asbDFgXEi1Seq/vovfb2iarfzbcnyGS6eE1pz+mqS
         0B9uYjnCs05IFBlLp6BWG/ETnfL3/3Csy3XGvFnfXBZY/qXgrugHJCv+trg8ydWS+7UL
         Mk05dDlQZC7FRZ4Fc39v8URJcYwGOb+CFV0ygSmK3L3zJZkBItmdfLhKhXb8JKD0CwZx
         mT2f1f9Ej4lCU8/QVqIjCUiwrj0n7d3jIL044Pn49hcb1+sg8r6b8sGw4Iw+vlQYc4gn
         Gfbw==
X-Gm-Message-State: AC+VfDwvtJMojrcD1UAj/vryGYEpnm3eo7gQXt255RSiwlxxaWxgXJEN
        1wboenBHt58WtCAMxiT8MBiJD01spzOXAYwmowI1eA==
X-Google-Smtp-Source: ACHHUZ5bej71Yrq9WYwKrmyFW3dhsSue92Dc+g42m5WumdLoNEzoGk9RNULOlBkJyOzvQxp9xBZQAMMICk3ItIE6ubM=
X-Received: by 2002:a17:902:b593:b0:1ad:ea13:1918 with SMTP id
 a19-20020a170902b59300b001adea131918mr16342513pls.69.1684319582817; Wed, 17
 May 2023 03:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230407030741.3163220-1-badhri@google.com> <0cf8c588b701d7cf25ffe1a9217b81716e6a5c51.camel@alistair23.me>
 <1ac16f0a-3cca-40ca-c444-82719f85a24c@leemhuis.info>
In-Reply-To: <1ac16f0a-3cca-40ca-c444-82719f85a24c@leemhuis.info>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 17 May 2023 03:32:26 -0700
Message-ID: <CAPTae5Kdd8kYdiFhGys9jrJnTQj30_ibJ1AGmBw1xwsXpDkqPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Alistair <alistair@alistair23.me>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Francesco Dolcini <francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

Francesso  had shared the stack dump as well at
https://lore.kernel.org/all/ZGMm2sxN6wW%2FEWrR@francesco-nb.int.toradex.com=
/.
I am working on a fix based on that. Going to share it in the next
hour and would be requesting Franceso and others help to see if the
regression goes away.

Thanks,
Badhri


On Wed, May 17, 2023 at 3:23=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing Francesco Dolcini; and the regression list too, as it should be
> in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>
> On 16.05.23 14:53, Alistair wrote:
> > On Fri, 2023-04-07 at 03:07 +0000, Badhri Jagan Sridharan wrote:
> >> usb_udc_connect_control does not check to see if the udc has already
> >> been started. This causes gadget->ops->pullup to be called through
> >> usb_gadget_connect when invoked from usb_udc_vbus_handler even before
> >> usb_gadget_udc_start is called. Guard this by checking for udc-
> >>> started
> >> in usb_udc_connect_control before invoking usb_gadget_connect.
> > [...]
> >> Cc: stable@vger.kernel.org
> >> Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
> >> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> >
> > This patch causes a kernel hang when trying to boot with the
> > usb/chipidea/udc.c driver.
> >
> > The call stack below causes the hang:
> >
> >  - gadget_bind_driver(struct device *dev)
> >     - mutex_lock(&udc->connect_lock);
> >     - usb_gadget_udc_start_locked(struct usb_udc *udc)
> >         - udc->gadget->ops->udc_start(udc->gadget, udc->driver)
> >
> > At which point we are calling ci_udc_start(..), but with the
> > connect_lock mutex locked.
> >
> > ci_udc_start() then calls usb_udc_vbus_handler() which tries to lock
> > the connect_lock while it's already locked. Resulting in a kernel hang.
> >
> > Reverting this patch fixes the hang.
>
> Not my area of expertise, but I guess it might be the same error as this
> one:
>
> https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com=
/
>
> Francesco sent a revert on Friday, but no reaction from Badhri Jagan
> Sridharan or Greg yet afaics.
>
> https://lore.kernel.org/all/20230512131435.205464-1-francesco@dolcini.it/
>
> Ciao, Thorsten
