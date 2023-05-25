Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA071183F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbjEYUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbjEYUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:38:54 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BD119
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:38:52 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3382f81a110so32695ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685047130; x=1687639130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGJZr5W3x0BuCVWV8isCIdn4Eq16XXfkBNZbIkFZj74=;
        b=AgxW261fcXKa0vllpGg7fLeh5HvF5dwh/g8faM8m3DBtbtTF57FCXeqgi71H1ficqn
         aTQgBqFfQguxB/DyDO758ZrznIGT/iVX5d5/rVrXmCU4W3YDFRrZO8zDnsyOtsYqiLlb
         xIvP3XEA4/By5HLCMcr/nmasMXaGB52CXXcRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047130; x=1687639130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGJZr5W3x0BuCVWV8isCIdn4Eq16XXfkBNZbIkFZj74=;
        b=WExpdIjyTSZXu7aivXrCZuSlufXBQRV7FpG6MHfM4ccSwJ+lFEX9QjuMnzo9ik4PS4
         aTZcemHbbylQUnaRhIr0A/RRrh3qkn7gpRV/TWYa0MvroMkZDW7Bakdm/TvPN70vUyEv
         v7HQSoe4OrqUs+oUqGPmDvlT/4ZTQ2yA52NnaIzyPa2AeHDOt1G1j5lf+pgMat68o3iR
         GFX3ICLT8IKtEJXNI5MTmDUiEMdZ5AtQVSbBGpjA14xOt0cP1l3/4sZWvuCRsDychlK5
         dywTtN2QRE/u50DEZApiIgQiEUflTWTXbMRoE++e15qDcmJbxp0NfPHLoLW0b1bl1Vkt
         NWsw==
X-Gm-Message-State: AC+VfDxwiGAYiVbA46vg6iGxhEuTbwH4fP0HDz3r5MZmHd9ZuNC3wOGU
        qLAyiBvlrPbyNKbBiKiHpqza5JkqNIMscXHsivI=
X-Google-Smtp-Source: ACHHUZ41wjR3q7E03BZUHz78+Nyvhd5QpzbtDQ1/vV3KK0HxiHVz6afPRIyDqFfPnTF/fq+3r8Y5Wg==
X-Received: by 2002:a92:d3ce:0:b0:33a:8ebe:b818 with SMTP id c14-20020a92d3ce000000b0033a8ebeb818mr4199540ilh.32.1685047130407;
        Thu, 25 May 2023 13:38:50 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id l2-20020a026642000000b0041ab097fad4sm615802jaf.169.2023.05.25.13.38.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:38:49 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33828a86ee2so40745ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:38:49 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33a:e716:a76d with SMTP id
 a13-20020a92c54d000000b0033ae716a76dmr7771ilj.27.1685047129031; Thu, 25 May
 2023 13:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230525093159.223817-1-john.ogness@linutronix.de>
 <20230525093159.223817-5-john.ogness@linutronix.de> <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
In-Reply-To: <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 13:38:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSKaihdow4Bbr6SSuUXL3s1u3it-=0Gkh95q=bwZuqnA@mail.gmail.com>
Message-ID: <CAD=FV=WSKaihdow4Bbr6SSuUXL3s1u3it-=0Gkh95q=bwZuqnA@mail.gmail.com>
Subject: Re: [PATCH tty v1 4/8] serial: core: lock port for start_rx() in uart_resume_port()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 9:07=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, May 25, 2023 at 2:34=E2=80=AFAM John Ogness <john.ogness@linutron=
ix.de> wrote:
> >
> > The only user of the start_rx() callback (qcom_geni) directly calls
> > its own stop_rx() callback. Since stop_rx() requires that the
> > port->lock is taken and interrupts are disabled, the start_rx()
> > callback has the same requirement.
> >
> > Fixes: cfab87c2c271 ("serial: core: Introduce callback for start_rx and=
 do stop_rx in suspend only if this callback implementation is present.")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  drivers/tty/serial/serial_core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 37ad53616372..f856c7fae2fd 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2430,8 +2430,11 @@ int uart_resume_port(struct uart_driver *drv, st=
ruct uart_port *uport)
> >                 if (console_suspend_enabled)
> >                         uart_change_pm(state, UART_PM_STATE_ON);
> >                 uport->ops->set_termios(uport, &termios, NULL);
> > -               if (!console_suspend_enabled && uport->ops->start_rx)
> > +               if (!console_suspend_enabled && uport->ops->start_rx) {
> > +                       spin_lock_irq(&uport->lock);
> >                         uport->ops->start_rx(uport);
> > +                       spin_unlock_irq(&uport->lock);
> > +               }
>
> Seems right, but shouldn't you also fix the call to stop_rx() that the
> same commit cfab87c2c271 ("serial: core: Introduce callback for
> start_rx and do stop_rx in suspend only if this callback
> implementation is present.") added? That one is also missing the lock,
> right?

Ah, I see. You did that in a separate patch and I wasn't CCed. I guess
I would have just put the two in one patch, but I don't feel that
strongly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
