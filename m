Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DCE6B281F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjCIPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCIPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:02:26 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B332EFF5D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:58:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a7so1652131pfx.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678373935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saB/v6gZCwf7MkAV+X9hNtARD1bAir61j4EAXbQD6Fo=;
        b=faDp15KLTT2HWFT/LmYYy/vaedNWebhFaSCnEFjpanEO99KBFPbaI7k9YHXrd9TtIR
         38FSGlmfcGNrqO2M83aWeoZ/xXvYWsuhGE+YqjA1kOxvwF3nvTYTn4ZVRQY6UwXHZfop
         h284RN19Mi7Px3uSd4bxKzDSzdJimx1lxYdTeDF+hnKMtZMo3cZVGhXU3Hj+iOuOQrjG
         I+BtQ2C+mb5VuqCts2pmsvqn51c8uyV/VpmHlYapM/fHHr4S9YKc8hLM5peZuZzgrqYw
         dMAUfa4gB02ZY27IUT/346xod8JF3dO4AQ/+GwKKMqK/Qt0OWtZUIYcR108iJugxeqcq
         WFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saB/v6gZCwf7MkAV+X9hNtARD1bAir61j4EAXbQD6Fo=;
        b=4HK6wS9cJnMK5d/A6y7eHOj63tjrOtWzjERReKiGZmogVP3OA7lnkP2rnmeJUJH8GW
         la/sOeP2RIbtXoOJ7qVPm7mBfSFHII4YFAoBy1Pxts2LGXr4EL128ZO6A/JXEQ4T342f
         6DKP84tAY8tOprVf5zfIz2EZhwjrMJUeY5VsLmquuPb85rlFFlIxDqTkOTKMH6BG7HHb
         AqNSR5Aeki8aPiQlE1P5MpoJ4UkTE//1fiOZ25SJQv1f3bk82YQVP0yfds5LhRhNudWJ
         u2syg9jCyqY/FMVs7cOeZ4eg4rkzrhLtEOPDh7Eeh/BdY6172v3O5EybiJ4B+f7bZc7b
         6Jsw==
X-Gm-Message-State: AO0yUKU0h9BK8PZ/q9ly3ql1+IdPhkfmW5hwguPILyDBe2IhutLO3Uhg
        jE+DSBhuTE087fduzhIidqym3DZNB5P4zVAvvqu+Hw==
X-Google-Smtp-Source: AK7set/RraLPA2D1bIU1JMVsTQ9VSyR7QHluSEtoNjQ0NdnShHp1o/hystaOhadZCKbTSIj+BQkh79eMjJWsS/WgA/A=
X-Received: by 2002:a63:b21b:0:b0:503:a8:2792 with SMTP id x27-20020a63b21b000000b0050300a82792mr7826958pge.5.1678373935497;
 Thu, 09 Mar 2023 06:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com> <20230309082035.14880-9-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230309082035.14880-9-ilpo.jarvinen@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 15:58:18 +0100
Message-ID: <CAPDyKFo5fC-yG_f8-w+B6bL0zvG4zMUdg38T6c8zeaA+HJ=joQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] tty: Convert hw_stopped in tty_struct to bool
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 09:22, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> hw_stopped in tty_struct is used like bool, convert the variable type
> to bool.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe

> ---
>  drivers/char/pcmcia/synclink_cs.c |  6 +++---
>  drivers/mmc/core/sdio_uart.c      | 10 +++++-----
>  drivers/tty/amiserial.c           |  6 +++---
>  drivers/tty/mxser.c               |  6 +++---
>  drivers/tty/synclink_gt.c         |  6 +++---
>  include/linux/tty.h               |  2 +-
>  6 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/sync=
link_cs.c
> index 6ddfeb2fe98f..97c5bfb9d58a 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -1060,7 +1060,7 @@ static void cts_change(MGSLPC_INFO *info, struct tt=
y_struct *tty)
>                         if (info->serial_signals & SerialSignal_CTS) {
>                                 if (debug_level >=3D DEBUG_LEVEL_ISR)
>                                         printk("CTS tx start...");
> -                               tty->hw_stopped =3D 0;
> +                               tty->hw_stopped =3D false;
>                                 tx_start(info, tty);
>                                 info->pending_bh |=3D BH_TRANSMIT;
>                                 return;
> @@ -1069,7 +1069,7 @@ static void cts_change(MGSLPC_INFO *info, struct tt=
y_struct *tty)
>                         if (!(info->serial_signals & SerialSignal_CTS)) {
>                                 if (debug_level >=3D DEBUG_LEVEL_ISR)
>                                         printk("CTS tx stop...");
> -                               tty->hw_stopped =3D 1;
> +                               tty->hw_stopped =3D true;
>                                 tx_stop(info);
>                         }
>                 }
> @@ -2312,7 +2312,7 @@ static void mgslpc_set_termios(struct tty_struct *t=
ty,
>
>         /* Handle turning off CRTSCTS */
>         if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
> -               tty->hw_stopped =3D 0;
> +               tty->hw_stopped =3D false;
>                 tx_release(tty);
>         }
>  }
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 50536fe59f1a..aa659758563f 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -478,13 +478,13 @@ static void sdio_uart_check_modem_status(struct sdi=
o_uart_port *port)
>                         int cts =3D (status & UART_MSR_CTS);
>                         if (tty->hw_stopped) {
>                                 if (cts) {
> -                                       tty->hw_stopped =3D 0;
> +                                       tty->hw_stopped =3D false;
>                                         sdio_uart_start_tx(port);
>                                         tty_wakeup(tty);
>                                 }
>                         } else {
>                                 if (!cts) {
> -                                       tty->hw_stopped =3D 1;
> +                                       tty->hw_stopped =3D true;
>                                         sdio_uart_stop_tx(port);
>                                 }
>                         }
> @@ -633,7 +633,7 @@ static int sdio_uart_activate(struct tty_port *tport,=
 struct tty_struct *tty)
>
>         if (C_CRTSCTS(tty))
>                 if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
> -                       tty->hw_stopped =3D 1;
> +                       tty->hw_stopped =3D true;
>
>         clear_bit(TTY_IO_ERROR, &tty->flags);
>
> @@ -882,14 +882,14 @@ static void sdio_uart_set_termios(struct tty_struct=
 *tty,
>
>         /* Handle turning off CRTSCTS */
>         if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
> -               tty->hw_stopped =3D 0;
> +               tty->hw_stopped =3D false;
>                 sdio_uart_start_tx(port);
>         }
>
>         /* Handle turning on CRTSCTS */
>         if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
>                 if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS)) {
> -                       tty->hw_stopped =3D 1;
> +                       tty->hw_stopped =3D true;
>                         sdio_uart_stop_tx(port);
>                 }
>         }
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index d7515d61659e..c06ad0a0744b 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -347,7 +347,7 @@ static void check_modem_status(struct serial_state *i=
nfo)
>  #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
>                                 printk("CTS tx start...");
>  #endif
> -                               port->tty->hw_stopped =3D 0;
> +                               port->tty->hw_stopped =3D false;
>                                 info->IER |=3D UART_IER_THRI;
>                                 amiga_custom.intena =3D IF_SETCLR | IF_TB=
E;
>                                 mb();
> @@ -362,7 +362,7 @@ static void check_modem_status(struct serial_state *i=
nfo)
>  #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
>                                 printk("CTS tx stop...");
>  #endif
> -                               port->tty->hw_stopped =3D 1;
> +                               port->tty->hw_stopped =3D true;
>                                 info->IER &=3D ~UART_IER_THRI;
>                                 /* disable Tx interrupt and remove any pe=
nding interrupts */
>                                 amiga_custom.intena =3D IF_TBE;
> @@ -1197,7 +1197,7 @@ static void rs_set_termios(struct tty_struct *tty, =
const struct ktermios *old_te
>
>         /* Handle turning off CRTSCTS */
>         if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
> -               tty->hw_stopped =3D 0;
> +               tty->hw_stopped =3D false;
>                 rs_start(tty);
>         }
>
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index ef3116e87975..10855e66fda1 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -553,7 +553,7 @@ static void mxser_handle_cts(struct tty_struct *tty, =
struct mxser_port *info,
>
>         if (tty->hw_stopped) {
>                 if (cts) {
> -                       tty->hw_stopped =3D 0;
> +                       tty->hw_stopped =3D false;
>
>                         if (!mxser_16550A_or_MUST(info))
>                                 __mxser_start_tx(info);
> @@ -563,7 +563,7 @@ static void mxser_handle_cts(struct tty_struct *tty, =
struct mxser_port *info,
>         } else if (cts)
>                 return;
>
> -       tty->hw_stopped =3D 1;
> +       tty->hw_stopped =3D true;
>         if (!mxser_16550A_or_MUST(info))
>                 __mxser_stop_tx(info);
>  }
> @@ -1361,7 +1361,7 @@ static void mxser_set_termios(struct tty_struct *tt=
y,
>         spin_unlock_irqrestore(&info->slock, flags);
>
>         if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
> -               tty->hw_stopped =3D 0;
> +               tty->hw_stopped =3D false;
>                 mxser_start(tty);
>         }
>
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 33f258d6fef9..543b3224dce9 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -730,7 +730,7 @@ static void set_termios(struct tty_struct *tty,
>
>         /* Handle turning off CRTSCTS */
>         if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
> -               tty->hw_stopped =3D 0;
> +               tty->hw_stopped =3D false;
>                 tx_release(tty);
>         }
>  }
> @@ -1953,13 +1953,13 @@ static void cts_change(struct slgt_info *info, un=
signed short status)
>                 if (info->port.tty) {
>                         if (info->port.tty->hw_stopped) {
>                                 if (info->signals & SerialSignal_CTS) {
> -                                       info->port.tty->hw_stopped =3D 0;
> +                                       info->port.tty->hw_stopped =3D fa=
lse;
>                                         info->pending_bh |=3D BH_TRANSMIT=
;
>                                         return;
>                                 }
>                         } else {
>                                 if (!(info->signals & SerialSignal_CTS))
> -                                       info->port.tty->hw_stopped =3D 1;
> +                                       info->port.tty->hw_stopped =3D tr=
ue;
>                         }
>                 }
>         }
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 093935e97f42..60871a9d3212 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -227,7 +227,7 @@ struct tty_struct {
>                 unsigned long unused[0];
>         } __aligned(sizeof(unsigned long)) ctrl;
>
> -       int hw_stopped;
> +       bool hw_stopped;
>         unsigned int receive_room;
>         int flow_change;
>
> --
> 2.30.2
>
