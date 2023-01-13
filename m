Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB8C669641
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbjAMLyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbjAMLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:52:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351861CB27
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q23-20020a17090a065700b002290913a521so4515058pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKHHRiPCduLazPfORkYrna9c3YjroQI7xhAR1rWpr8Q=;
        b=AM2tvterxHejv1jYT6L6eLND2qH9kcKxAsqzbv8afM3hTXO65NwQX3q1L9WZm8WVgz
         S9I5tJ/6I0v2IPB4MVO1LeXfhznPDYN1i4eXbNYa4G567SojuBAf4d3oZYwnDwEapgUd
         LJwrwEvXA6Fv1ZFqA7NR228pkLVxpPjURIXHOrNNJY0tY+nbY7lCOukJZgCcTrky3F5q
         i4Zepq9FCQbpQDXep+vQysWwAGkJv6wAvXc1g/pCxS/Ad9c4iiTO9C5WADZXySGVDq/m
         5sTexcqZbQ/WKHicOb01QjLhqq7jNZdxJ+86efn0qu2pqCXHeWbMh2rneoyphhdIVN7Y
         v9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKHHRiPCduLazPfORkYrna9c3YjroQI7xhAR1rWpr8Q=;
        b=zeVludMiP/tMEZi0nrDTvwxLjxFmDvRccVGTQ1apSf+dG+6UFHhk4hHu9PEK5mqI3Q
         qnmwRIpCAgxnJmI9v+YxHTH3cSLdhbcR2vC1sFpFnyu0+Qm9uAgmd7Jcou6fOD7V/C5y
         xk+CC9rBUgZCKb00cZueA+B26YX7561vsyB6BUCCIe0ac8dPAutXZt4l5ATBpONwKzxf
         WRDry8yNjy+ws0I+StKz08fJj5Uwov7kfJjFz+kxHYpPaPrWkkVIiF+8Pf+AyFRuxP95
         mB+gEL4JYkHJaVdo8aihdGf6huRyzBFw46Ttg92jJIPrBlhqiuuRBi56uawvqwEuDAvy
         YOeg==
X-Gm-Message-State: AFqh2kqOJ6aEi1ep0t8ae3jDLNm9Yc4b6MwUeRPuv4zeL2z/9uaPUJxc
        nEKcw7E3Hx1QciPBcmrGocPiVMuIUCHIzuDCpacpzw==
X-Google-Smtp-Source: AMrXdXvwJmHEZub45XbhWUljoJ622urkDTOFjcXiENVYG4NA3XlkbQFmeoDxxo9BkCRq9GtpBWKHMPF7AkvkQVnYPdI=
X-Received: by 2002:a17:902:e38c:b0:194:6253:d685 with SMTP id
 g12-20020a170902e38c00b001946253d685mr409514ple.3.1673610638327; Fri, 13 Jan
 2023 03:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com> <20230111142331.34518-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230111142331.34518-8-ilpo.jarvinen@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Jan 2023 12:50:02 +0100
Message-ID: <CAPDyKFo_oxt95N-4MwDqqmRAoSrsRw_CdH9q=Aky_WPLP+7Y8Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] tty: Convert ->dtr_rts() to take bool argument
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=C3=A1lvez?= <siglesias@igalia.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Arnd Bergmann <arnd@arndb.de>, David Lin <dtwlin@gmail.com>,
        Alex Elder <elder@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 at 15:24, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Convert the raise/on parameter in ->dtr_rts() to bool through the
> callchain. The parameter is used like bool. In USB serial, there
> remains a few implicit bool -> larger type conversions because some
> devices use u8 in their control messages.
>
> In moxa_tiocmget(), dtr variable was reused for line status which
> requires int so use a separate variable for status.
>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe


> ---
>  drivers/char/pcmcia/synclink_cs.c    |  4 +--
>  drivers/mmc/core/sdio_uart.c         |  4 +--
>  drivers/staging/greybus/uart.c       |  2 +-
>  drivers/tty/amiserial.c              |  2 +-
>  drivers/tty/hvc/hvc_console.c        |  4 +--
>  drivers/tty/hvc/hvc_console.h        |  2 +-
>  drivers/tty/hvc/hvc_iucv.c           |  4 +--
>  drivers/tty/moxa.c                   | 54 ++++++++++++++--------------
>  drivers/tty/mxser.c                  |  2 +-
>  drivers/tty/n_gsm.c                  |  2 +-
>  drivers/tty/serial/serial_core.c     |  8 ++---
>  drivers/tty/synclink_gt.c            |  2 +-
>  drivers/tty/tty_port.c               |  4 +--
>  drivers/usb/class/cdc-acm.c          |  2 +-
>  drivers/usb/serial/ch341.c           |  2 +-
>  drivers/usb/serial/cp210x.c          |  4 +--
>  drivers/usb/serial/cypress_m8.c      |  6 ++--
>  drivers/usb/serial/digi_acceleport.c |  6 ++--
>  drivers/usb/serial/f81232.c          |  2 +-
>  drivers/usb/serial/f81534.c          |  2 +-
>  drivers/usb/serial/ftdi_sio.c        |  2 +-
>  drivers/usb/serial/ipw.c             |  2 +-
>  drivers/usb/serial/keyspan.c         |  2 +-
>  drivers/usb/serial/keyspan_pda.c     |  2 +-
>  drivers/usb/serial/mct_u232.c        |  4 +--
>  drivers/usb/serial/mxuport.c         |  2 +-
>  drivers/usb/serial/pl2303.c          |  2 +-
>  drivers/usb/serial/quatech2.c        |  2 +-
>  drivers/usb/serial/sierra.c          |  2 +-
>  drivers/usb/serial/spcp8x5.c         |  2 +-
>  drivers/usb/serial/ssu100.c          |  2 +-
>  drivers/usb/serial/upd78f0730.c      |  6 ++--
>  drivers/usb/serial/usb-serial.c      |  2 +-
>  drivers/usb/serial/usb-wwan.h        |  2 +-
>  drivers/usb/serial/usb_wwan.c        |  2 +-
>  drivers/usb/serial/xr_serial.c       |  6 ++--
>  include/linux/tty_port.h             |  4 +--
>  include/linux/usb/serial.h           |  2 +-
>  38 files changed, 84 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/sync=
link_cs.c
> index 4391138e1b8a..46a0b586d234 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -378,7 +378,7 @@ static void async_mode(MGSLPC_INFO *info);
>  static void tx_timeout(struct timer_list *t);
>
>  static bool carrier_raised(struct tty_port *port);
> -static void dtr_rts(struct tty_port *port, int onoff);
> +static void dtr_rts(struct tty_port *port, bool onoff);
>
>  #if SYNCLINK_GENERIC_HDLC
>  #define dev_to_port(D) (dev_to_hdlc(D)->priv)
> @@ -2442,7 +2442,7 @@ static bool carrier_raised(struct tty_port *port)
>         return info->serial_signals & SerialSignal_DCD;
>  }
>
> -static void dtr_rts(struct tty_port *port, int onoff)
> +static void dtr_rts(struct tty_port *port, bool onoff)
>  {
>         MGSLPC_INFO *info =3D container_of(port, MGSLPC_INFO, port);
>         unsigned long flags;
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 47f58258d8ff..c6b4b2b2a4b2 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -548,14 +548,14 @@ static bool uart_carrier_raised(struct tty_port *tp=
ort)
>   *     adjusted during an open, close and hangup.
>   */
>
> -static void uart_dtr_rts(struct tty_port *tport, int onoff)
> +static void uart_dtr_rts(struct tty_port *tport, bool onoff)
>  {
>         struct sdio_uart_port *port =3D
>                         container_of(tport, struct sdio_uart_port, port);
>         int ret =3D sdio_uart_claim_func(port);
>         if (ret)
>                 return;
> -       if (onoff =3D=3D 0)
> +       if (!onoff)
>                 sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
>         else
>                 sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uar=
t.c
> index 90ff07f2cbf7..92d49740d5a4 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -701,7 +701,7 @@ static int gb_tty_ioctl(struct tty_struct *tty, unsig=
ned int cmd,
>         return -ENOIOCTLCMD;
>  }
>
> -static void gb_tty_dtr_rts(struct tty_port *port, int on)
> +static void gb_tty_dtr_rts(struct tty_port *port, bool on)
>  {
>         struct gb_tty *gb_tty;
>         u8 newctrl;
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index 01c4fd3ce7c8..29d4c554f6b8 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -1459,7 +1459,7 @@ static bool amiga_carrier_raised(struct tty_port *p=
ort)
>         return !(ciab.pra & SER_DCD);
>  }
>
> -static void amiga_dtr_rts(struct tty_port *port, int raise)
> +static void amiga_dtr_rts(struct tty_port *port, bool raise)
>  {
>         struct serial_state *info =3D container_of(port, struct serial_st=
ate,
>                         tport);
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.=
c
> index a683e21df19c..10c10cfdf92a 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -376,7 +376,7 @@ static int hvc_open(struct tty_struct *tty, struct fi=
le * filp)
>                 /* We are ready... raise DTR/RTS */
>                 if (C_BAUD(tty))
>                         if (hp->ops->dtr_rts)
> -                               hp->ops->dtr_rts(hp, 1);
> +                               hp->ops->dtr_rts(hp, true);
>                 tty_port_set_initialized(&hp->port, true);
>         }
>
> @@ -406,7 +406,7 @@ static void hvc_close(struct tty_struct *tty, struct =
file * filp)
>
>                 if (C_HUPCL(tty))
>                         if (hp->ops->dtr_rts)
> -                               hp->ops->dtr_rts(hp, 0);
> +                               hp->ops->dtr_rts(hp, false);
>
>                 if (hp->ops->notifier_del)
>                         hp->ops->notifier_del(hp, hp->data);
> diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.=
h
> index 18d005814e4b..6d3428bf868f 100644
> --- a/drivers/tty/hvc/hvc_console.h
> +++ b/drivers/tty/hvc/hvc_console.h
> @@ -66,7 +66,7 @@ struct hv_ops {
>         int (*tiocmset)(struct hvc_struct *hp, unsigned int set, unsigned=
 int clear);
>
>         /* Callbacks to handle tty ports */
> -       void (*dtr_rts)(struct hvc_struct *hp, int raise);
> +       void (*dtr_rts)(struct hvc_struct *hp, bool raise);
>  };
>
>  /* Register a vterm and a slot index for use as a console (console_init)=
 */
> diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
> index 7d49a872de48..fe862a6882d6 100644
> --- a/drivers/tty/hvc/hvc_iucv.c
> +++ b/drivers/tty/hvc/hvc_iucv.c
> @@ -658,13 +658,13 @@ static void hvc_iucv_notifier_hangup(struct hvc_str=
uct *hp, int id)
>  /**
>   * hvc_iucv_dtr_rts() - HVC notifier for handling DTR/RTS
>   * @hp:                Pointer the HVC device (struct hvc_struct)
> - * @raise:     Non-zero to raise or zero to lower DTR/RTS lines
> + * @raise:     True to raise or false to lower DTR/RTS lines
>   *
>   * This routine notifies the HVC back-end to raise or lower DTR/RTS
>   * lines.  Raising DTR/RTS is ignored.  Lowering DTR/RTS indicates to
>   * drop the IUCV connection (similar to hang up the modem).
>   */
> -static void hvc_iucv_dtr_rts(struct hvc_struct *hp, int raise)
> +static void hvc_iucv_dtr_rts(struct hvc_struct *hp, bool raise)
>  {
>         struct hvc_iucv_private *priv;
>         struct iucv_path        *path;
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index 6a1e78e33a2c..9be3d585d5a9 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -502,15 +502,15 @@ static void moxa_poll(struct timer_list *);
>  static void moxa_set_tty_param(struct tty_struct *, const struct ktermio=
s *);
>  static void moxa_shutdown(struct tty_port *);
>  static bool moxa_carrier_raised(struct tty_port *);
> -static void moxa_dtr_rts(struct tty_port *, int);
> +static void moxa_dtr_rts(struct tty_port *, bool);
>  /*
>   * moxa board interface functions:
>   */
>  static void MoxaPortEnable(struct moxa_port *);
>  static void MoxaPortDisable(struct moxa_port *);
>  static int MoxaPortSetTermio(struct moxa_port *, struct ktermios *, spee=
d_t);
> -static int MoxaPortGetLineOut(struct moxa_port *, int *, int *);
> -static void MoxaPortLineCtrl(struct moxa_port *, int, int);
> +static int MoxaPortGetLineOut(struct moxa_port *, bool *, bool *);
> +static void MoxaPortLineCtrl(struct moxa_port *, bool, bool);
>  static void MoxaPortFlowCtrl(struct moxa_port *, int, int, int, int, int=
);
>  static int MoxaPortLineStatus(struct moxa_port *);
>  static void MoxaPortFlushData(struct moxa_port *, int);
> @@ -1443,7 +1443,7 @@ static bool moxa_carrier_raised(struct tty_port *po=
rt)
>         return dcd;
>  }
>
> -static void moxa_dtr_rts(struct tty_port *port, int onoff)
> +static void moxa_dtr_rts(struct tty_port *port, bool onoff)
>  {
>         struct moxa_port *ch =3D container_of(port, struct moxa_port, por=
t);
>         MoxaPortLineCtrl(ch, onoff, onoff);
> @@ -1481,7 +1481,7 @@ static int moxa_open(struct tty_struct *tty, struct=
 file *filp)
>         if (!tty_port_initialized(&ch->port)) {
>                 ch->statusflags =3D 0;
>                 moxa_set_tty_param(tty, &tty->termios);
> -               MoxaPortLineCtrl(ch, 1, 1);
> +               MoxaPortLineCtrl(ch, true, true);
>                 MoxaPortEnable(ch);
>                 MoxaSetFifo(ch, ch->type =3D=3D PORT_16550A);
>                 tty_port_set_initialized(&ch->port, true);
> @@ -1557,19 +1557,21 @@ static unsigned int moxa_chars_in_buffer(struct t=
ty_struct *tty)
>  static int moxa_tiocmget(struct tty_struct *tty)
>  {
>         struct moxa_port *ch =3D tty->driver_data;
> -       int flag =3D 0, dtr, rts;
> +       bool dtr, rts;
> +       int flag =3D 0;
> +       int status;
>
>         MoxaPortGetLineOut(ch, &dtr, &rts);
>         if (dtr)
>                 flag |=3D TIOCM_DTR;
>         if (rts)
>                 flag |=3D TIOCM_RTS;
> -       dtr =3D MoxaPortLineStatus(ch);
> -       if (dtr & 1)
> +       status =3D MoxaPortLineStatus(ch);
> +       if (status & 1)
>                 flag |=3D TIOCM_CTS;
> -       if (dtr & 2)
> +       if (status & 2)
>                 flag |=3D TIOCM_DSR;
> -       if (dtr & 4)
> +       if (status & 4)
>                 flag |=3D TIOCM_CD;
>         return flag;
>  }
> @@ -1578,7 +1580,7 @@ static int moxa_tiocmset(struct tty_struct *tty,
>                          unsigned int set, unsigned int clear)
>  {
>         struct moxa_port *ch;
> -       int dtr, rts;
> +       bool dtr, rts;
>
>         mutex_lock(&moxa_openlock);
>         ch =3D tty->driver_data;
> @@ -1589,13 +1591,13 @@ static int moxa_tiocmset(struct tty_struct *tty,
>
>         MoxaPortGetLineOut(ch, &dtr, &rts);
>         if (set & TIOCM_RTS)
> -               rts =3D 1;
> +               rts =3D true;
>         if (set & TIOCM_DTR)
> -               dtr =3D 1;
> +               dtr =3D true;
>         if (clear & TIOCM_RTS)
> -               rts =3D 0;
> +               rts =3D false;
>         if (clear & TIOCM_DTR)
> -               dtr =3D 0;
> +               dtr =3D false;
>         MoxaPortLineCtrl(ch, dtr, rts);
>         mutex_unlock(&moxa_openlock);
>         return 0;
> @@ -1877,12 +1879,12 @@ static void MoxaPortFlushData(struct moxa_port *p=
ort, int mode)
>   *
>   *      Function 13:    Get the DTR/RTS state of this port.
>   *      Syntax:
> - *      int  MoxaPortGetLineOut(int port, int *dtrState, int *rtsState);
> + *      int  MoxaPortGetLineOut(int port, bool *dtrState, bool *rtsState=
);
>   *           int port           : port number (0 - 127)
> - *           int * dtrState     : pointer to INT to receive the current =
DTR
> + *           bool * dtrState    : pointer to bool to receive the current=
 DTR
>   *                                state. (if NULL, this function will no=
t
>   *                                write to this address)
> - *           int * rtsState     : pointer to INT to receive the current =
RTS
> + *           bool * rtsState    : pointer to bool to receive the current=
 RTS
>   *                                state. (if NULL, this function will no=
t
>   *                                write to this address)
>   *
> @@ -1892,10 +1894,10 @@ static void MoxaPortFlushData(struct moxa_port *p=
ort, int mode)
>   *
>   *      Function 14:    Setting the DTR/RTS output state of this port.
>   *      Syntax:
> - *      void MoxaPortLineCtrl(int port, int dtrState, int rtsState);
> + *      void MoxaPortLineCtrl(int port, bool dtrState, bool rtsState);
>   *           int port           : port number (0 - 127)
> - *           int dtrState       : DTR output state (0: off, 1: on)
> - *           int rtsState       : RTS output state (0: off, 1: on)
> + *           bool dtrState      : DTR output state
> + *           bool rtsState      : RTS output state
>   *
>   *
>   *      Function 15:    Setting the flow control of this port.
> @@ -2103,18 +2105,18 @@ static int MoxaPortSetTermio(struct moxa_port *po=
rt, struct ktermios *termio,
>         return baud;
>  }
>
> -static int MoxaPortGetLineOut(struct moxa_port *port, int *dtrState,
> -               int *rtsState)
> +static int MoxaPortGetLineOut(struct moxa_port *port, bool *dtrState,
> +               bool *rtsState)
>  {
>         if (dtrState)
> -               *dtrState =3D !!(port->lineCtrl & DTR_ON);
> +               *dtrState =3D port->lineCtrl & DTR_ON;
>         if (rtsState)
> -               *rtsState =3D !!(port->lineCtrl & RTS_ON);
> +               *rtsState =3D port->lineCtrl & RTS_ON;
>
>         return 0;
>  }
>
> -static void MoxaPortLineCtrl(struct moxa_port *port, int dtr, int rts)
> +static void MoxaPortLineCtrl(struct moxa_port *port, bool dtr, bool rts)
>  {
>         u8 mode =3D 0;
>
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 96c72e691cd7..d4fb11e39bb1 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -465,7 +465,7 @@ static bool mxser_carrier_raised(struct tty_port *por=
t)
>         return inb(mp->ioaddr + UART_MSR) & UART_MSR_DCD;
>  }
>
> -static void mxser_dtr_rts(struct tty_port *port, int on)
> +static void mxser_dtr_rts(struct tty_port *port, bool on)
>  {
>         struct mxser_port *mp =3D container_of(port, struct mxser_port, p=
ort);
>         unsigned long flags;
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 81fc2ec3693f..8dd0d6441c42 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3792,7 +3792,7 @@ static bool gsm_carrier_raised(struct tty_port *por=
t)
>         return dlci->modem_rx & TIOCM_CD;
>  }
>
> -static void gsm_dtr_rts(struct tty_port *port, int onoff)
> +static void gsm_dtr_rts(struct tty_port *port, bool onoff)
>  {
>         struct gsm_dlci *dlci =3D container_of(port, struct gsm_dlci, por=
t);
>         unsigned int modem_tx =3D dlci->modem_tx;
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 20ed8a088b2d..053535846ba2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -169,7 +169,7 @@ uart_update_mctrl(struct uart_port *port, unsigned in=
t set, unsigned int clear)
>  #define uart_set_mctrl(port, set)      uart_update_mctrl(port, set, 0)
>  #define uart_clear_mctrl(port, clear)  uart_update_mctrl(port, 0, clear)
>
> -static void uart_port_dtr_rts(struct uart_port *uport, int raise)
> +static void uart_port_dtr_rts(struct uart_port *uport, bool raise)
>  {
>         if (raise)
>                 uart_set_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
> @@ -239,7 +239,7 @@ static int uart_port_startup(struct tty_struct *tty, =
struct uart_state *state,
>                  * port is open and ready to respond.
>                  */
>                 if (init_hw && C_BAUD(tty))
> -                       uart_port_dtr_rts(uport, 1);
> +                       uart_port_dtr_rts(uport, true);
>         }
>
>         /*
> @@ -302,7 +302,7 @@ static void uart_shutdown(struct tty_struct *tty, str=
uct uart_state *state)
>                 }
>
>                 if (!tty || C_HUPCL(tty))
> -                       uart_port_dtr_rts(uport, 0);
> +                       uart_port_dtr_rts(uport, false);
>
>                 uart_port_shutdown(port);
>         }
> @@ -1885,7 +1885,7 @@ static bool uart_carrier_raised(struct tty_port *po=
rt)
>         return mctrl & TIOCM_CAR;
>  }
>
> -static void uart_dtr_rts(struct tty_port *port, int raise)
> +static void uart_dtr_rts(struct tty_port *port, bool raise)
>  {
>         struct uart_state *state =3D container_of(port, struct uart_state=
, port);
>         struct uart_port *uport;
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 4ba71ec764f7..2b786265ce7b 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -3138,7 +3138,7 @@ static bool carrier_raised(struct tty_port *port)
>         return info->signals & SerialSignal_DCD;
>  }
>
> -static void dtr_rts(struct tty_port *port, int on)
> +static void dtr_rts(struct tty_port *port, bool on)
>  {
>         unsigned long flags;
>         struct slgt_info *info =3D container_of(port, struct slgt_info, p=
ort);
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index a573c500f95b..a788a6bf487d 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -463,7 +463,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
>  void tty_port_raise_dtr_rts(struct tty_port *port)
>  {
>         if (port->ops->dtr_rts)
> -               port->ops->dtr_rts(port, 1);
> +               port->ops->dtr_rts(port, true);
>  }
>  EXPORT_SYMBOL(tty_port_raise_dtr_rts);
>
> @@ -478,7 +478,7 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
>  void tty_port_lower_dtr_rts(struct tty_port *port)
>  {
>         if (port->ops->dtr_rts)
> -               port->ops->dtr_rts(port, 0);
> +               port->ops->dtr_rts(port, false);
>  }
>  EXPORT_SYMBOL(tty_port_lower_dtr_rts);
>
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 36bf051b345b..d4f9220b8162 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -651,7 +651,7 @@ static int acm_tty_open(struct tty_struct *tty, struc=
t file *filp)
>         return tty_port_open(&acm->port, tty, filp);
>  }
>
> -static void acm_port_dtr_rts(struct tty_port *port, int raise)
> +static void acm_port_dtr_rts(struct tty_port *port, bool raise)
>  {
>         struct acm *acm =3D container_of(port, struct acm, port);
>         int val;
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index 792f01a4ed22..98ec4fe46914 100644
> --- a/drivers/usb/serial/ch341.c
> +++ b/drivers/usb/serial/ch341.c
> @@ -420,7 +420,7 @@ static bool ch341_carrier_raised(struct usb_serial_po=
rt *port)
>         return priv->msr & CH341_BIT_DCD;
>  }
>
> -static void ch341_dtr_rts(struct usb_serial_port *port, int on)
> +static void ch341_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct ch341_private *priv =3D usb_get_serial_port_data(port);
>         unsigned long flags;
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 67372acc2352..fe2cdc477fb9 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -45,7 +45,7 @@ static void cp210x_disconnect(struct usb_serial *);
>  static void cp210x_release(struct usb_serial *);
>  static int cp210x_port_probe(struct usb_serial_port *);
>  static void cp210x_port_remove(struct usb_serial_port *);
> -static void cp210x_dtr_rts(struct usb_serial_port *port, int on);
> +static void cp210x_dtr_rts(struct usb_serial_port *port, bool on);
>  static void cp210x_process_read_urb(struct urb *urb);
>  static void cp210x_enable_event_mode(struct usb_serial_port *port);
>  static void cp210x_disable_event_mode(struct usb_serial_port *port);
> @@ -1402,7 +1402,7 @@ static int cp210x_tiocmset_port(struct usb_serial_p=
ort *port,
>         return ret;
>  }
>
> -static void cp210x_dtr_rts(struct usb_serial_port *port, int on)
> +static void cp210x_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         if (on)
>                 cp210x_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
> diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress=
_m8.c
> index 1e0c028c5ec9..7c6060c17ee0 100644
> --- a/drivers/usb/serial/cypress_m8.c
> +++ b/drivers/usb/serial/cypress_m8.c
> @@ -118,7 +118,7 @@ static int  cypress_ca42v2_port_probe(struct usb_seri=
al_port *port);
>  static void cypress_port_remove(struct usb_serial_port *port);
>  static int  cypress_open(struct tty_struct *tty, struct usb_serial_port =
*port);
>  static void cypress_close(struct usb_serial_port *port);
> -static void cypress_dtr_rts(struct usb_serial_port *port, int on);
> +static void cypress_dtr_rts(struct usb_serial_port *port, bool on);
>  static int  cypress_write(struct tty_struct *tty, struct usb_serial_port=
 *port,
>                         const unsigned char *buf, int count);
>  static void cypress_send(struct usb_serial_port *port);
> @@ -621,12 +621,12 @@ static int cypress_open(struct tty_struct *tty, str=
uct usb_serial_port *port)
>         return result;
>  } /* cypress_open */
>
> -static void cypress_dtr_rts(struct usb_serial_port *port, int on)
> +static void cypress_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct cypress_private *priv =3D usb_get_serial_port_data(port);
>         /* drop dtr and rts */
>         spin_lock_irq(&priv->lock);
> -       if (on =3D=3D 0)
> +       if (!on)
>                 priv->line_control =3D 0;
>         else
>                 priv->line_control =3D CONTROL_DTR | CONTROL_RTS;
> diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/di=
gi_acceleport.c
> index 45d688e9b93f..890e446273d7 100644
> --- a/drivers/usb/serial/digi_acceleport.c
> +++ b/drivers/usb/serial/digi_acceleport.c
> @@ -228,7 +228,7 @@ static unsigned int digi_write_room(struct tty_struct=
 *tty);
>  static unsigned int digi_chars_in_buffer(struct tty_struct *tty);
>  static int digi_open(struct tty_struct *tty, struct usb_serial_port *por=
t);
>  static void digi_close(struct usb_serial_port *port);
> -static void digi_dtr_rts(struct usb_serial_port *port, int on);
> +static void digi_dtr_rts(struct usb_serial_port *port, bool on);
>  static int digi_startup_device(struct usb_serial *serial);
>  static int digi_startup(struct usb_serial *serial);
>  static void digi_disconnect(struct usb_serial *serial);
> @@ -1060,10 +1060,10 @@ static unsigned int digi_chars_in_buffer(struct t=
ty_struct *tty)
>         return chars;
>  }
>
> -static void digi_dtr_rts(struct usb_serial_port *port, int on)
> +static void digi_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         /* Adjust DTR and RTS */
> -       digi_set_modem_signals(port, on * (TIOCM_DTR | TIOCM_RTS), 1);
> +       digi_set_modem_signals(port, on ? (TIOCM_DTR | TIOCM_RTS) : 0, 1)=
;
>  }
>
>  static int digi_open(struct tty_struct *tty, struct usb_serial_port *por=
t)
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 1a8c2925c26f..1656be847460 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -752,7 +752,7 @@ static void f81232_close(struct usb_serial_port *port=
)
>         flush_work(&port_priv->lsr_work);
>  }
>
> -static void f81232_dtr_rts(struct usb_serial_port *port, int on)
> +static void f81232_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         if (on)
>                 f81232_set_mctrl(port, TIOCM_DTR | TIOCM_RTS, 0);
> diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
> index 4083ae961be4..8b44b08752d6 100644
> --- a/drivers/usb/serial/f81534.c
> +++ b/drivers/usb/serial/f81534.c
> @@ -1456,7 +1456,7 @@ static int f81534_tiocmset(struct tty_struct *tty, =
unsigned int set,
>         return f81534_update_mctrl(port, set, clear);
>  }
>
> -static void f81534_dtr_rts(struct usb_serial_port *port, int on)
> +static void f81534_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         if (on)
>                 f81534_update_mctrl(port, TIOCM_DTR | TIOCM_RTS, 0);
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.=
c
> index 05e28a5ce42b..09bdf623e94e 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -2366,7 +2366,7 @@ static int ftdi_open(struct tty_struct *tty, struct=
 usb_serial_port *port)
>         return usb_serial_generic_open(tty, port);
>  }
>
> -static void ftdi_dtr_rts(struct usb_serial_port *port, int on)
> +static void ftdi_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct ftdi_private *priv =3D usb_get_serial_port_data(port);
>
> diff --git a/drivers/usb/serial/ipw.c b/drivers/usb/serial/ipw.c
> index d04c7cc5c1c2..b1b7a033cc75 100644
> --- a/drivers/usb/serial/ipw.c
> +++ b/drivers/usb/serial/ipw.c
> @@ -215,7 +215,7 @@ static void ipw_release(struct usb_serial *serial)
>         kfree(data);
>  }
>
> -static void ipw_dtr_rts(struct usb_serial_port *port, int on)
> +static void ipw_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct usb_device *udev =3D port->serial->dev;
>         struct device *dev =3D &port->dev;
> diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
> index 2966e0c4941e..7e375367354b 100644
> --- a/drivers/usb/serial/keyspan.c
> +++ b/drivers/usb/serial/keyspan.c
> @@ -1564,7 +1564,7 @@ static int keyspan_open(struct tty_struct *tty, str=
uct usb_serial_port *port)
>         return 0;
>  }
>
> -static void keyspan_dtr_rts(struct usb_serial_port *port, int on)
> +static void keyspan_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct keyspan_port_private *p_priv =3D usb_get_serial_port_data(=
port);
>
> diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspa=
n_pda.c
> index 6fd15cd9e1eb..cb16c4bc8555 100644
> --- a/drivers/usb/serial/keyspan_pda.c
> +++ b/drivers/usb/serial/keyspan_pda.c
> @@ -551,7 +551,7 @@ static int keyspan_pda_write(struct tty_struct *tty, =
struct usb_serial_port *por
>         return count;
>  }
>
> -static void keyspan_pda_dtr_rts(struct usb_serial_port *port, int on)
> +static void keyspan_pda_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct usb_serial *serial =3D port->serial;
>
> diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.=
c
> index d3852feb81a4..eb3520490dd2 100644
> --- a/drivers/usb/serial/mct_u232.c
> +++ b/drivers/usb/serial/mct_u232.c
> @@ -42,7 +42,7 @@ static int  mct_u232_port_probe(struct usb_serial_port =
*port);
>  static void mct_u232_port_remove(struct usb_serial_port *remove);
>  static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port=
 *port);
>  static void mct_u232_close(struct usb_serial_port *port);
> -static void mct_u232_dtr_rts(struct usb_serial_port *port, int on);
> +static void mct_u232_dtr_rts(struct usb_serial_port *port, bool on);
>  static void mct_u232_read_int_callback(struct urb *urb);
>  static void mct_u232_set_termios(struct tty_struct *tty,
>                                  struct usb_serial_port *port,
> @@ -477,7 +477,7 @@ static int  mct_u232_open(struct tty_struct *tty, str=
uct usb_serial_port *port)
>         return retval;
>  } /* mct_u232_open */
>
> -static void mct_u232_dtr_rts(struct usb_serial_port *port, int on)
> +static void mct_u232_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         unsigned int control_state;
>         struct mct_u232_private *priv =3D usb_get_serial_port_data(port);
> diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
> index faa0eedfe245..ac7594635719 100644
> --- a/drivers/usb/serial/mxuport.c
> +++ b/drivers/usb/serial/mxuport.c
> @@ -674,7 +674,7 @@ static int mxuport_set_rts(struct usb_serial_port *po=
rt, u8 state)
>         return err;
>  }
>
> -static void mxuport_dtr_rts(struct usb_serial_port *port, int on)
> +static void mxuport_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct mxuport_port *mxport =3D usb_get_serial_port_data(port);
>         u8 mcr_state;
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index 4cb81746a149..cb20911f35bb 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -931,7 +931,7 @@ static void pl2303_set_termios(struct tty_struct *tty=
,
>         kfree(buf);
>  }
>
> -static void pl2303_dtr_rts(struct usb_serial_port *port, int on)
> +static void pl2303_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct pl2303_private *priv =3D usb_get_serial_port_data(port);
>         unsigned long flags;
> diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.=
c
> index 6fca40ace83a..6fd329ffec7e 100644
> --- a/drivers/usb/serial/quatech2.c
> +++ b/drivers/usb/serial/quatech2.c
> @@ -770,7 +770,7 @@ static void qt2_break_ctl(struct tty_struct *tty, int=
 break_state)
>
>
>
> -static void qt2_dtr_rts(struct usb_serial_port *port, int on)
> +static void qt2_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct usb_device *dev =3D port->serial->dev;
>         struct qt2_port_private *port_priv =3D usb_get_serial_port_data(p=
ort);
> diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
> index 353b2549eaa8..f2c3a7af1a4a 100644
> --- a/drivers/usb/serial/sierra.c
> +++ b/drivers/usb/serial/sierra.c
> @@ -813,7 +813,7 @@ static int sierra_open(struct tty_struct *tty, struct=
 usb_serial_port *port)
>  }
>
>
> -static void sierra_dtr_rts(struct usb_serial_port *port, int on)
> +static void sierra_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct sierra_port_private *portdata;
>
> diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
> index 8175db6c4554..02402ea3bd1b 100644
> --- a/drivers/usb/serial/spcp8x5.c
> +++ b/drivers/usb/serial/spcp8x5.c
> @@ -256,7 +256,7 @@ static bool spcp8x5_carrier_raised(struct usb_serial_=
port *port)
>         return ret || msr & MSR_STATUS_LINE_DCD;
>  }
>
> -static void spcp8x5_dtr_rts(struct usb_serial_port *port, int on)
> +static void spcp8x5_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct spcp8x5_private *priv =3D usb_get_serial_port_data(port);
>         unsigned long flags;
> diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
> index 1e1888b66305..4cff39895804 100644
> --- a/drivers/usb/serial/ssu100.c
> +++ b/drivers/usb/serial/ssu100.c
> @@ -385,7 +385,7 @@ static int ssu100_tiocmset(struct tty_struct *tty,
>         return update_mctrl(dev, set, clear);
>  }
>
> -static void ssu100_dtr_rts(struct usb_serial_port *port, int on)
> +static void ssu100_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct usb_device *dev =3D port->serial->dev;
>
> diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0=
730.c
> index c47439bd90fa..206749fe3263 100644
> --- a/drivers/usb/serial/upd78f0730.c
> +++ b/drivers/usb/serial/upd78f0730.c
> @@ -262,7 +262,7 @@ static void upd78f0730_break_ctl(struct tty_struct *t=
ty, int break_state)
>         mutex_unlock(&private->lock);
>  }
>
> -static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
> +static void upd78f0730_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct tty_struct *tty =3D port->port.tty;
>         unsigned int set =3D 0;
> @@ -307,9 +307,9 @@ static void upd78f0730_set_termios(struct tty_struct =
*tty,
>                 return;
>
>         if (C_BAUD(tty) =3D=3D B0)
> -               upd78f0730_dtr_rts(port, 0);
> +               upd78f0730_dtr_rts(port, false);
>         else if (old_termios && (old_termios->c_cflag & CBAUD) =3D=3D B0)
> -               upd78f0730_dtr_rts(port, 1);
> +               upd78f0730_dtr_rts(port, true);
>
>         baud_rate =3D upd78f0730_get_baud_rate(tty);
>         request.opcode =3D UPD78F0730_CMD_LINE_CONTROL;
> diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-ser=
ial.c
> index 019720a63fac..f8404073558b 100644
> --- a/drivers/usb/serial/usb-serial.c
> +++ b/drivers/usb/serial/usb-serial.c
> @@ -765,7 +765,7 @@ static bool serial_port_carrier_raised(struct tty_por=
t *port)
>         return true;
>  }
>
> -static void serial_port_dtr_rts(struct tty_port *port, int on)
> +static void serial_port_dtr_rts(struct tty_port *port, bool on)
>  {
>         struct usb_serial_port *p =3D container_of(port, struct usb_seria=
l_port, port);
>         struct usb_serial_driver *drv =3D p->serial->type;
> diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.=
h
> index 519101945769..b2a07dd44225 100644
> --- a/drivers/usb/serial/usb-wwan.h
> +++ b/drivers/usb/serial/usb-wwan.h
> @@ -6,7 +6,7 @@
>  #ifndef __LINUX_USB_USB_WWAN
>  #define __LINUX_USB_USB_WWAN
>
> -extern void usb_wwan_dtr_rts(struct usb_serial_port *port, int on);
> +extern void usb_wwan_dtr_rts(struct usb_serial_port *port, bool on);
>  extern int usb_wwan_open(struct tty_struct *tty, struct usb_serial_port =
*port);
>  extern void usb_wwan_close(struct usb_serial_port *port);
>  extern int usb_wwan_port_probe(struct usb_serial_port *port);
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.=
c
> index 0017f6e969e1..168b11cc02b6 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -69,7 +69,7 @@ static int usb_wwan_send_setup(struct usb_serial_port *=
port)
>         return res;
>  }
>
> -void usb_wwan_dtr_rts(struct usb_serial_port *port, int on)
> +void usb_wwan_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         struct usb_wwan_port_private *portdata;
>         struct usb_wwan_intf_private *intfdata;
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_seria=
l.c
> index fdb0aae546c3..9aaed09d45e4 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -495,7 +495,7 @@ static int xr_tiocmset(struct tty_struct *tty,
>         return xr_tiocmset_port(port, set, clear);
>  }
>
> -static void xr_dtr_rts(struct usb_serial_port *port, int on)
> +static void xr_dtr_rts(struct usb_serial_port *port, bool on)
>  {
>         if (on)
>                 xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
> @@ -669,9 +669,9 @@ static void xr_set_flow_mode(struct tty_struct *tty,
>         xr_uart_enable(port);
>
>         if (C_BAUD(tty) =3D=3D B0)
> -               xr_dtr_rts(port, 0);
> +               xr_dtr_rts(port, false);
>         else if (old_termios && (old_termios->c_cflag & CBAUD) =3D=3D B0)
> -               xr_dtr_rts(port, 1);
> +               xr_dtr_rts(port, true);
>  }
>
>  static void xr21v141x_set_line_settings(struct tty_struct *tty,
> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index cf098459cb01..c44e489de0ff 100644
> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -16,7 +16,7 @@ struct tty_struct;
>  /**
>   * struct tty_port_operations -- operations on tty_port
>   * @carrier_raised: return true if the carrier is raised on @port
> - * @dtr_rts: raise the DTR line if @raise is nonzero, otherwise lower DT=
R
> + * @dtr_rts: raise the DTR line if @raise is true, otherwise lower DTR
>   * @shutdown: called when the last close completes or a hangup finishes =
IFF the
>   *     port was initialized. Do not use to free resources. Turn off the =
device
>   *     only. Called under the port mutex to serialize against @activate =
and
> @@ -32,7 +32,7 @@ struct tty_struct;
>   */
>  struct tty_port_operations {
>         bool (*carrier_raised)(struct tty_port *port);
> -       void (*dtr_rts)(struct tty_port *port, int raise);
> +       void (*dtr_rts)(struct tty_port *port, bool raise);
>         void (*shutdown)(struct tty_port *port);
>         int (*activate)(struct tty_port *port, struct tty_struct *tty);
>         void (*destruct)(struct tty_port *port);
> diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
> index dc7f90522b42..c597357853d9 100644
> --- a/include/linux/usb/serial.h
> +++ b/include/linux/usb/serial.h
> @@ -292,7 +292,7 @@ struct usb_serial_driver {
>                         struct serial_icounter_struct *icount);
>         /* Called by the tty layer for port level work. There may or may =
not
>            be an attached tty at this point */
> -       void (*dtr_rts)(struct usb_serial_port *port, int on);
> +       void (*dtr_rts)(struct usb_serial_port *port, bool on);
>         bool (*carrier_raised)(struct usb_serial_port *port);
>         /* Called by the usb serial hooks to allow the user to rework the
>            termios state */
> --
> 2.30.2
>
