Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EB063D5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiK3MoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiK3MoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:44:08 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429E58BC7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:44:08 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id g65so16738283vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 04:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MNA7eZi9VQf69CeBVlQwZ04/y+5gTO1SaFbD25OjShk=;
        b=uSk5JtGDkFtZkUVlSh2i3p7XW+BEpm0qle2Qeku5sBhEFvEtjxwJcJO/dKAIH6mtnM
         ihCM776HxUIm9bISIC0XuUG2ntUDh43aYrOMKAm8kyIKgsGhNiQWX3jWqJ7nrDkcrJux
         P6HiyheNg1ARMUwTofYkN+5TdwWAD+Ief4jrVs3kTBRmPfEJV+1Fj/Kobmxo1TAft8FS
         86v6pEod24fy4y15bRVI/fgHouGGWPW/5cHlox5WDNAg1oMIcSXrXjoxUuke9vjsCIUJ
         /Tk2xkrcwu9Rx5yVD7NwJ2YtxgrQifkgBuMZI59vLsuMVQHnRn7y6HHSroWm49Z+GqcQ
         dgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNA7eZi9VQf69CeBVlQwZ04/y+5gTO1SaFbD25OjShk=;
        b=F4D/dh9ieXwO1tZmtTLFl5walH2/PCK+Mq61vjXyahuxIrclqy6gG2q2+YkWz1vYY0
         NpTc8tqhPdr3j9oR+59HE17iHDsY3wbnJi0Q3l/6uucr64FQ0AZwy3h4cQSJshauIVoI
         /rBtZjwN7vJM1e+gbQr09cksQK4E+e1VVgbYVKxtJ1Dm3vHoIrqbUnP8i02dQwzChatK
         m0okkcFQ3Tm1i074bELOEiPGXcWwCj7/Gi13rV0rue5GDLXVfOR4gul0PgQH5cgnoTBb
         bKBcJ98OHhDvzDoJTANcozpy7z8iPspfsl4QlN8VfkpuJoJfkGMKAyT5bjyc2MvmrHni
         AwZw==
X-Gm-Message-State: ANoB5pnPzN3qH1wAFwDAQTbfXFr3x0L+4cWPD2WOJiUZcyOiPqBEqc7P
        3Exj/FatndZxqIc6adw7eMKVpYt94uPkZhdIp/RliQ==
X-Google-Smtp-Source: AA0mqf54Z2CrPKxSRMlbr73gv+438gnoVt/fuaLT9AfACCSJrTBHJXFmdawHwFRgJOYgsFogG3EQ+yCbag8p/gkY3HY=
X-Received: by 2002:a67:eb11:0:b0:3b0:c9bc:7abe with SMTP id
 a17-20020a67eb11000000b003b0c9bc7abemr3394360vso.61.1669812247176; Wed, 30
 Nov 2022 04:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20221129110012.224685-1-brgl@bgdev.pl> <20221129110012.224685-12-brgl@bgdev.pl>
 <22332676-9d3a-1e21-aa70-e9c367b19bd9@kernel.org>
In-Reply-To: <22332676-9d3a-1e21-aa70-e9c367b19bd9@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 30 Nov 2022 13:43:56 +0100
Message-ID: <CAMRc=MczfMKYEWfV_WOazXni9FbXX8x_iwjm4URD7-WWQQmUsA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] tty: serial: qcom-geni-serial: stop operations
 in progress at shutdown
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:37 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 29. 11. 22, 12:00, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We don't stop transmissions in progress at shutdown. This is fine with
> > FIFO SE mode but with DMA it causes trouble so fix it now.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >   drivers/tty/serial/qcom_geni_serial.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index fe15fc0e1345..c0270eec2a66 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -864,6 +864,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
> >
> >   static void qcom_geni_serial_shutdown(struct uart_port *uport)
> >   {
> > +     qcom_geni_serial_stop_tx(uport);
> > +     qcom_geni_serial_stop_rx(uport);
> > +
> >       disable_irq(uport->irq);
>
> I'm just asking without actually looking into the code: cannot the
> interrupt reschedule/restart the above?
>

It can actually, good catch, thanks.

Bart
