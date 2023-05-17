Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930AB706FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEQRqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEQRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:46:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E66AAD20
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:45:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so13449756b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684345543; x=1686937543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6t1O8Ge4sibN6Oo2CFfxYT5m02Ej6oOF686FxriN3A=;
        b=PE6EqVB6f8nrEcBWaQ9bOlwoSGAG4ra5+3oOh/weCqL7LrMCf5WGDvxywnwB7Ha8MR
         cMX0ukwpMUD8cY3QcgXX6keWbB7NC4UFCdr/MeH+jiXAa5wNDeOr8uhZZ4Vi6ok0RA60
         pOH10vr4wCJLWpUo3uwcG5pRmPU4FTjSNb+vRK0hRlsJYy35pX9myd2VE9fsAqFqlg3/
         x3r9RLc43vDF8SXbnaBQd10zPWKszWXLsP99MJkHX6puhQ8poolPUpyeBQ4bdVFIHq0B
         +beLpxxt/KFUjlVmjX/VLpuOWqj0YPtKE5++tbQvdKc99K6GZIuZD8oWdEwS+AvW/8Bt
         a2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345543; x=1686937543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6t1O8Ge4sibN6Oo2CFfxYT5m02Ej6oOF686FxriN3A=;
        b=Oh0a/MLArujIY0gOCLrs/e95x6oUHOkoqhOVb8qHz5SnCt9Imtk0930ZT34DdHHF7d
         IuWfmuH7Z+aE1xlQn6W+tUwit+XVYv7c2H1Yf08TE+k6XpvbS7HgtY3hIjMQXVOGMKrT
         Mp44Bz8nvJbmjxpRjB9wCvU8zk9Ajlym+hzyzywxYQSHurVRKX4yLUD89pokGxUQE6xO
         ThHD3OYbq+qNWyvpMvHjkZ4PL8tkWzOt+rV0wHQSX/1muH91qpkK4h8s3hw8nChY6S0h
         dmnWvwFjBFQ3+cQDf6ziYkHGk63HNgg1WYQ2cd9xKgrphZ4f0YHiSSvWh9zbEo53adFj
         mS9w==
X-Gm-Message-State: AC+VfDxeca4Losq+G11MmlfFscKGt5MzeZZKgmaARnGDxJZVCieL2+/q
        lGlPbJ5xvz3vO6iY3kBRkHjTn8dfd4FI2XGa37j86w==
X-Google-Smtp-Source: ACHHUZ7dh+OBAPnnwoktCQLcizNptNITN5YboO3JA60SskvZO7hlTaDLimXkSYt7nL1Wnr8TX5q2opoFdK6N0SJSJ/I=
X-Received: by 2002:a05:6a20:5d87:b0:105:888d:d593 with SMTP id
 km7-20020a056a205d8700b00105888dd593mr2720386pzb.18.1684345543354; Wed, 17
 May 2023 10:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230407030741.3163220-1-badhri@google.com> <0cf8c588b701d7cf25ffe1a9217b81716e6a5c51.camel@alistair23.me>
 <1ac16f0a-3cca-40ca-c444-82719f85a24c@leemhuis.info> <ZGStr1oZvmJ0XzSu@francesco-nb.int.toradex.com>
 <53213ba8-be58-0f97-8a06-3c9380bdff53@leemhuis.info>
In-Reply-To: <53213ba8-be58-0f97-8a06-3c9380bdff53@leemhuis.info>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 17 May 2023 10:45:05 -0700
Message-ID: <CAPTae5Lz=efNKhCnoy6Hp78HFqCLqxtWdZQ7zSDx2omeYf2KDw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Alistair <alistair@alistair23.me>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the thread updated. I sent out
https://www.spinics.net/lists/kernel/msg4792009.html few hours earlier
and have requested help from Francesco, Alistair and others who
reported the issue.
Discussing with Alan stern on the feedback he had left.

Thanks for the support,
Badhri

On Wed, May 17, 2023 at 3:57=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 17.05.23 12:35, Francesco Dolcini wrote:
> > On Wed, May 17, 2023 at 12:23:39PM +0200, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> >> [CCing Francesco Dolcini; and the regression list too, as it should be
> >> in the loop for regressions:
> >> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >>
> >> On 16.05.23 14:53, Alistair wrote:
> >>> On Fri, 2023-04-07 at 03:07 +0000, Badhri Jagan Sridharan wrote:
> >>>> usb_udc_connect_control does not check to see if the udc has already
> >>>> been started. This causes gadget->ops->pullup to be called through
> >>>> usb_gadget_connect when invoked from usb_udc_vbus_handler even befor=
e
> >>>> usb_gadget_udc_start is called. Guard this by checking for udc-
> >>>>> started
> >>>> in usb_udc_connect_control before invoking usb_gadget_connect.
> >>> [...]
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
> >>>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> >>>
> >>> This patch causes a kernel hang when trying to boot with the
> >>> usb/chipidea/udc.c driver.
> >>>
> >>> The call stack below causes the hang:
> >>>
> >>>  - gadget_bind_driver(struct device *dev)
> >>>     - mutex_lock(&udc->connect_lock);
> >>>     - usb_gadget_udc_start_locked(struct usb_udc *udc)
> >>>         - udc->gadget->ops->udc_start(udc->gadget, udc->driver)
> >>>
> >>> At which point we are calling ci_udc_start(..), but with the
> >>> connect_lock mutex locked.
> >>>
> >>> ci_udc_start() then calls usb_udc_vbus_handler() which tries to lock
> >>> the connect_lock while it's already locked. Resulting in a kernel han=
g.
> >>>
> >>> Reverting this patch fixes the hang.
> >>
> >> Not my area of expertise, but I guess it might be the same error as th=
is
> >> one:
> >>
> >> https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.=
com/
> >>
> >> Francesco sent a revert on Friday, but no reaction from Badhri Jagan
> >> Sridharan or Greg yet afaics.
> >>
> >> https://lore.kernel.org/all/20230512131435.205464-1-francesco@dolcini.=
it/
> >
> > Revert patches were applied and are in linux-next. I expect those to
> > land in Linus tree with the next pull request from Greg.
>
> Ha, sorry, I missed that, as I only looked at lore. Should have looked
> in my own regression tracking, there it's marked as "fix incoming", as
> regzbot noticed the fix in next...
>
> Ciao, Thorsten
