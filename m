Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE764EDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLPPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiLPPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:22:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C1532E1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:22:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so6900573ejm.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1M1Auh5G/AH8zrzqrUo78l1/L8UKrPHpkrS7qTWMoPQ=;
        b=eCAKBd2GEPcD9z3O/VbJsdTHBC/NWu5QjQR1loE+CJeaXnZ1LPp+rYIzdu6hAWHSnA
         QvQnm/xpuBMc3cU8TT4UxsqtqATr/tAlbtIYB8csAXVfbezmD6EpICkqfThcwzxVsOzE
         dzL6mBbYO2qFyuYKsd+SE7x7p+UFoGld9uBks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M1Auh5G/AH8zrzqrUo78l1/L8UKrPHpkrS7qTWMoPQ=;
        b=bX763ZdfndY3SBFHlamf2GM2Ovg3ZeXN1lF/okaDxkLjaCsNleKlIZOqN4mk2JiGKc
         qqsI+otgd3UtzzjjsBcx22/pzIJmyg1wx8aQ3TiN6jkogUF3dCJqaN9rMl0J9n21PYAy
         JNpW2lTLbicTWQSVqOMbzGf0cwEWGXytBnWD37QHzIy5+kkplB+OC/kCmrZca3NlMycJ
         EPyf/1B1cWOFbTZmZIwebY8X0hLEK4g1kjV3yvft0e8KKjqs++MGZDUifvJ+IJssdrCL
         RloPJEFbRk06Nxxya1XCXNURg4Q5MNLZpg3OI9ND1+qcDAdrbZKDpcLOdVemwSlJKvwi
         Xegg==
X-Gm-Message-State: ANoB5pn9ObB2jVgXwvXqxwTJLMyJIUDAypVODFqKc75j7664yzf9ZOBh
        gDudi4YSJW7wN98xTeQsIt9IJE0/9WPlkAutZqA=
X-Google-Smtp-Source: AA0mqf4C0EzV6m4at7GBSsMVpbNvh7gpIGIIk2rv8z6fS0qV5LEpirq5YKWe9CZL07wdDRoYhEA9fQ==
X-Received: by 2002:a17:907:20f2:b0:7c1:bb4:ea20 with SMTP id rh18-20020a17090720f200b007c10bb4ea20mr24993307ejb.71.1671204130054;
        Fri, 16 Dec 2022 07:22:10 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id ku10-20020a170907788a00b007c0d4d3a0c1sm951967ejc.32.2022.12.16.07.22.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:22:08 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id f18so2839167wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:22:08 -0800 (PST)
X-Received: by 2002:adf:fd89:0:b0:242:1f81:7034 with SMTP id
 d9-20020adffd89000000b002421f817034mr27601061wrr.617.1671204127894; Fri, 16
 Dec 2022 07:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20221215165453.1864836-1-arnd@kernel.org> <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
 <02b4b94c-aa0d-4878-906d-ecd947553f16@app.fastmail.com>
In-Reply-To: <02b4b94c-aa0d-4878-906d-ecd947553f16@app.fastmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Dec 2022 07:21:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VF9BBmq_+9HhN-1Wi=LjWsZv=Um6EzezswFestbD3bwA@mail.gmail.com>
Message-ID: <CAD=FV=VF9BBmq_+9HhN-1Wi=LjWsZv=Um6EzezswFestbD3bwA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni: avoid duplicate struct member init
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Aniket Randive <quic_arandive@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 16, 2022 at 2:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 15, 2022, at 21:46, Doug Anderson wrote:
> > On Thu, Dec 15, 2022 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> >> index b487823f0e61..03dda47184d9 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -1516,7 +1516,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
> >>         return 0;
> >>  }
> >>
> >> -static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
> >> +static int qcom_geni_serial_sys_suspend(struct device *dev)
> >
> > Officially the removal of "__maybe_unused" could be a totally
> > different patch, right? SET_SYSTEM_SLEEP_PM_OPS() already eventually
> > used pm_sleep_ptr() even without your change, so the removal of these
> > tags is unrelated to the rest of your change, right?
>
> It's a little more complicated: SYSTEM_SLEEP_PM_OPS() uses pm_sleep_ptr()
> to avoid the need for a __maybe_unused(). The depreacated
> SET_SYSTEM_SLEEP_PM_OPS() is based on SYSTEM_SLEEP_PM_OPS() these days,
> but still retains the old semantics of using an empty definition
> without CONFIG_PM_SLEEP, so it still leaves the function unused as
> far as gcc is concerned.
>
> There could be an intermediate step of open-coding the
> SET_SYSTEM_SLEEP_PM_OPS(), but that would result in the rather
> silly
>
>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> #ifdef CONFIG_PM_SLEEP
>        .suspend = qcom_geni_serial_sys_suspend,
>        .resume = qcom_geni_serial_sys_resume,
>        .freeze = qcom_geni_serial_sys_suspend,
>        .poweroff = qcom_geni_serial_sys_suspend,
> #endif
>        .restore = qcom_geni_serial_sys_hib_resume,
>        .thaw = qcom_geni_serial_sys_hib_resume,
> }
>
> which makes no sense to me, as I think you either want
> all the members or none of them.

Ah, I guess I didn't trace through all the similarly named macros
quite correctly. ;-) Thanks for explaining.


> >>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> >> -       SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
> >> -                                       qcom_geni_serial_sys_resume)
> >> -       .restore = qcom_geni_serial_sys_hib_resume,
> >> -       .thaw = qcom_geni_serial_sys_hib_resume,
> >> +       .suspend = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> >> +       .resume = pm_sleep_ptr(qcom_geni_serial_sys_resume),
> >> +       .freeze = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> >> +       .poweroff = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> >> +       .restore = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
> >> +       .thaw = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
> >
> > Personally, the order you listed them is less intuitive than the order
> > that SET_SYSTEM_SLEEP_PM_OPS() lists functions. IMO it's better to
> > consistently alternate matching suspend/resume functions. ;-)
>
> Makes sense. I kept the order that we already had here, but
> I could redo this patch if anyone cares.

I wouldn't worry about it.

-Doug
