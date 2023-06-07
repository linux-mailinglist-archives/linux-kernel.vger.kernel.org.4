Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617DD725305
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjFGErJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjFGErF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:47:05 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3755E60
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:47:02 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43b87490a27so996164137.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 21:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686113222; x=1688705222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo4PkLfngXYHY6ja+unUd5R8bGmOlUuTUPgWhxoPbLc=;
        b=kyWP28qN8Jys8ZFdoulObIZ5HN99D2774We5lAq1N4NhWeKJpOyDBaA1fL/QwG5r9T
         +3HVez47RYtr0CFUkMYtD5KbpilQxz81OXdUv4lHqQp2EvPn4UUcIo4RkpjyIm/AQYst
         nGZxKi2mYvdsj4X0GO+TasNUe0729O/BU1Ay8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686113222; x=1688705222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fo4PkLfngXYHY6ja+unUd5R8bGmOlUuTUPgWhxoPbLc=;
        b=Nhefd2Q0/dmGmZ5QL4+HRS/CbU9kB+PUamU3eqWRvqS37Tj31gGoQrNQMgOkzXEqZC
         CCuN3Z+IiffdMSGmu68Rc5EKNvy/7upNuxoN4otJ/PElVZXOODGyoVS9oJILIRhSUmEv
         bVl5SQfdDTOflVsKPS4MBkycjaccZlVnLJqAVPOdoWfUnshue9YuwMzyXjLMN+MHgz/x
         P7QB27ihPgGZ8M5Eij0fcUCLn/1LnMEnZtR6LlC2KWuk6jpXryn0SNjq33AFdE/mbb9x
         BdITYJNwRZ+qujI/LXeSiaq8jD6C3NRywjcbq7oM0NajmBGKyZDykwT2sFuzOiJWzdU/
         lvvw==
X-Gm-Message-State: AC+VfDxIL2dwh0q1ds6OtZihNJAIcaLpZ5I2LpEZfEeK+Kz8fq/V9zVP
        f6jSQevcU+sB0UshydxlMiU87RjQkVvAOJ1Atv+W7A==
X-Google-Smtp-Source: ACHHUZ5G84yzb6PcZC4TA0uvD3i4O/JMOqyu3JqoOcMgDxGkqL//yhdqkr/hCqNBIzESrXBePe5kjXPkufKSEC3CNxA=
X-Received: by 2002:a05:6102:102:b0:43b:1b47:670 with SMTP id
 z2-20020a056102010200b0043b1b470670mr688543vsq.20.1686113222153; Tue, 06 Jun
 2023 21:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230602083335.GA181647@google.com> <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com> <20230603063533.GS14287@atomide.com>
 <20230605061511.GW14287@atomide.com> <CAGXv+5Fbx7eTxP0ep6DV+jyronAWxYvu2M-g=MjHGRhjSXUc=w@mail.gmail.com>
 <20230605122447.GY14287@atomide.com> <CAGXv+5HwL+R5QpO3pHGQd9qAxu2pCMDjYvdni1HjiC8eEE38mg@mail.gmail.com>
 <20230605131803.GA14287@atomide.com> <CAGXv+5GR9TEaNrj4B21H2iukS2kWW=rtoWkoVnWewVsrbcG0Hw@mail.gmail.com>
 <20230606122059.GC14287@atomide.com>
In-Reply-To: <20230606122059.GC14287@atomide.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 7 Jun 2023 12:46:51 +0800
Message-ID: <CAGXv+5ERwrFgpWBUBTkoawfyyTHU9w=Owiy-2BbCXHwEpZk1tA@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
To:     Tony Lindgren <tony@atomide.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 8:21=E2=80=AFPM Tony Lindgren <tony@atomide.com> wro=
te:
>
> * Chen-Yu Tsai <wenst@chromium.org> [230606 09:17]:
> > I ended up following 8250_dw's design, which seemed less convoluted.
> > The original code was waaay too convoluted.
>
> OK that looks good to me thanks. Good to hear you got it sorted out.
>
> The 8250_dw style runtime PM is a good solution for simple cases. Where
> it won't work are SoCs where runtime PM calls need to propagate up the
> bus hierarchy. For example, 8250_omap needs runtime PM calls for the
> interconnect and power domain to get register access working.

Good to know. On MediaTek platforms I don't think there are any power
domains covering the basic peripherals. (Or it's hidden from the kernel.)

> > BTW, the Bluetooth breakage seems like a different problem.
>
> OK seems like we're good to go then :)

Yup. After a bit more testing, it seems the Bluetooth problem is more like
an undervolt issue. If I have WiFi and BT probe at the same time, Bluetooth
fails. If they probe separately, everything works fine.

ChenYu
