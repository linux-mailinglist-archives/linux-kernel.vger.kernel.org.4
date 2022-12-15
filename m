Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11064E286
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLOUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLOUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:47:12 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397414D5D4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:47:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t17so1521697eju.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VxVyPZKSysf+HLi7nhh+VUixxCogFeRsVo86ZrnztgQ=;
        b=hxzxmAZbiyk38wc8gz9+Ee2T8BOYtvW5SiTPnrxwx4lOkojFHNVaj0lvh5AJI9zjSp
         z1LbbrCXSyJnMlxM2SWfndRjFiopwVhc7pMCfEsmD2JaOTOxR8rXZmrwBoHCKySl7Hvg
         dTFJBmC7oIU/73t9a6PjJcbym1vMucF0MPJdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxVyPZKSysf+HLi7nhh+VUixxCogFeRsVo86ZrnztgQ=;
        b=g1GdkBl7yGNxEQHQdX4C5++byoNbZUlqutqpS1UJFUYFqpeW2G+XliJbmvWiwi0QyE
         Rw2voEQGHbkmTlL7G1t9cCLAgnl3p6QG5BLz2LkwrkOBL+O1EXZ7vdEuahZ9RUOX/mYC
         mFT8SSBzVrPHluGrfmDXoE/bzSCZqFnW6ILh//YOgK2cFaEYU5EJZ6nYgFCNkGHSeq3J
         tlxrFiIEnkAVZRdt6M0eHlbCjDyJb0xCAfMNrnDoHeuUSacup1XVy2FDf6Z9orTlIqUB
         mFc3cpgVFHcwRQw21sKer0ThUxE85p3OQB05xiAmgt7iJwUKt0NWN1gv3di5F7NSFg3N
         rqFA==
X-Gm-Message-State: ANoB5pnvCYjt0PX/5CnrTh24s7GJ5p+1JSu1SiNPilox1hkBGUlQ8meB
        Wfpa9KKj1Yv7rLWTuJ4q6F5P5m5ELmT25suGuzM=
X-Google-Smtp-Source: AA0mqf4Cs3lUtPRGHT/nhpKGAJL3UzNoIaJQEzpIhQBTXA4MNeXwAOmEfZ6A8ZnOejdRiOqJWz8kow==
X-Received: by 2002:a17:907:c295:b0:78d:f455:c398 with SMTP id tk21-20020a170907c29500b0078df455c398mr14447612ejc.62.1671137225623;
        Thu, 15 Dec 2022 12:47:05 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090614c200b007c4f32726c4sm57851ejc.133.2022.12.15.12.47.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 12:47:03 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso2742728wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:47:03 -0800 (PST)
X-Received: by 2002:a05:600c:4153:b0:3d2:191d:2427 with SMTP id
 h19-20020a05600c415300b003d2191d2427mr176059wmm.188.1671137223155; Thu, 15
 Dec 2022 12:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20221215165453.1864836-1-arnd@kernel.org>
In-Reply-To: <20221215165453.1864836-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Dec 2022 12:46:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
Message-ID: <CAD=FV=U6pfSk0nY+s-p4f43Gq6-arfr8hQe8d9NC0nS0ckMYKw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni: avoid duplicate struct member init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Dec 15, 2022 at 8:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Woverride-init is enabled in a build, gcc points out that
> qcom_geni_serial_pm_ops contains conflicting initializers:
>
> drivers/tty/serial/qcom_geni_serial.c:1586:20: error: initialized field overwritten [-Werror=override-init]
>  1586 |         .restore = qcom_geni_serial_sys_hib_resume,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/qcom_geni_serial.c:1586:20: note: (near initialization for 'qcom_geni_serial_pm_ops.restore')
> drivers/tty/serial/qcom_geni_serial.c:1587:17: error: initialized field overwritten [-Werror=override-init]
>  1587 |         .thaw = qcom_geni_serial_sys_hib_resume,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Open-code the initializers with the version that was already used,
> and use the pm_sleep_ptr() method to deal with unused ones,
> in place of the __maybe_unused annotation.
>
> Fixes: 35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibernation feature")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index b487823f0e61..03dda47184d9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1516,7 +1516,7 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
> +static int qcom_geni_serial_sys_suspend(struct device *dev)

Officially the removal of "__maybe_unused" could be a totally
different patch, right? SET_SYSTEM_SLEEP_PM_OPS() already eventually
used pm_sleep_ptr() even without your change, so the removal of these
tags is unrelated to the rest of your change, right?


>  {
>         struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>         struct uart_port *uport = &port->uport;
> @@ -1533,7 +1533,7 @@ static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
>         return uart_suspend_port(private_data->drv, uport);
>  }
>
> -static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
> +static int qcom_geni_serial_sys_resume(struct device *dev)
>  {
>         int ret;
>         struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
> @@ -1581,10 +1581,12 @@ static int qcom_geni_serial_sys_hib_resume(struct device *dev)
>  }
>
>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
> -                                       qcom_geni_serial_sys_resume)
> -       .restore = qcom_geni_serial_sys_hib_resume,
> -       .thaw = qcom_geni_serial_sys_hib_resume,
> +       .suspend = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> +       .resume = pm_sleep_ptr(qcom_geni_serial_sys_resume),
> +       .freeze = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> +       .poweroff = pm_sleep_ptr(qcom_geni_serial_sys_suspend),
> +       .restore = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),
> +       .thaw = pm_sleep_ptr(qcom_geni_serial_sys_hib_resume),

Personally, the order you listed them is less intuitive than the order
that SET_SYSTEM_SLEEP_PM_OPS() lists functions. IMO it's better to
consistently alternate matching suspend/resume functions. ;-)

Both of those are nits, so I'm also fine with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
