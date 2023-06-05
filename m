Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB37224AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFELeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFELeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:34:23 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A02B9C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:34:22 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-786d74c317eso1026344241.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685964861; x=1688556861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJdL4VkR29ugHjJ0HNgiBAKMzVnr+Rqw/yJUI27DCh8=;
        b=ihefJeawzq1ba5J+Z+/a7Y64U3S0NsqLGOcE7NThRkDvJdvEYDj4FPxzesJ0tmifc8
         HJdYDm5j0huFTYjBXUmyav0pA0qUGlrQ+T4iV/imFQCkaOm3sxgVSuEngjweANjzErP0
         OHjjxg8O8cu3leRnxQ1749QLe72mwhyycBLuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964861; x=1688556861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJdL4VkR29ugHjJ0HNgiBAKMzVnr+Rqw/yJUI27DCh8=;
        b=jvbbhbK9m9lSwIPL3kQl9CSKVr3NmtH9UgCWy0uHHD8vDzqijdMgN6FCnzamJuVQy2
         Rk46PoDLLSB3+j9ZUj50u0WFwN2uSbdEnsGEGyTQyS8rJPCqbua1InF/v1o5QB+ev8cx
         Ploye5PuV3Ywvh5sFmZidBD3I4v/uUbA1Qn5erfeXiB6ldEJsWamfCN4wCE+PxBoij9o
         o8yFB2eK39IdpgnnqDe3PXGsLyQYEBcy2K+J2wH+NPRAuxCZf2VYdrRkbLb8ZzT7Y4qK
         xruFf4g+ZGq6XlEVqEVaE5iqHp8b78A7NPW4SnN/+gj38EN1H2ATMw2Maww9RqeOUrUd
         rtYA==
X-Gm-Message-State: AC+VfDxC9s5fypNvhPA62VWva8ISFmLMIgOfFsz/KVnvdSp4VwGuXrJy
        ciFz0GoOoLuLynIli3KyYjPWtGb0MdfzZFxiz9enKg==
X-Google-Smtp-Source: ACHHUZ49/IwlrFEfmpxaOyF8JC+0bPRmojnDSDJVaGgnrnvtesB7m1brUpWGPmailAmLhyP097J0bYC1CjDJkP3zHAY=
X-Received: by 2002:a1f:60d4:0:b0:463:c9b3:9e12 with SMTP id
 u203-20020a1f60d4000000b00463c9b39e12mr1025388vkb.6.1685964861559; Mon, 05
 Jun 2023 04:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230525113034.46880-1-tony@atomide.com> <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de> <20230603054139.GR14287@atomide.com>
 <20230603063533.GS14287@atomide.com> <20230605061511.GW14287@atomide.com>
In-Reply-To: <20230605061511.GW14287@atomide.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 5 Jun 2023 19:34:10 +0800
Message-ID: <CAGXv+5Fbx7eTxP0ep6DV+jyronAWxYvu2M-g=MjHGRhjSXUc=w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 5, 2023 at 2:15=E2=80=AFPM Tony Lindgren <tony@atomide.com> wro=
te:
>
> * Tony Lindgren <tony@atomide.com> [230603 06:35]:
> > * Tony Lindgren <tony@atomide.com> [230603 05:41]:
> > > I don't think 8250_mtk needs to do register access before and after t=
he
> > > serial port registration, but if it does, then adding custom read/wri=
te
> > > functions can be done that do not rely on initialized port like
> > > serial_out().
> >
> > Oh but mtk8250_runtime_suspend() calls serial_in(up, MTK_UART_DEBUG0), =
so
> > yeah if that gets called before registration is complete it causes a NU=
LL
> > pointer exception. If the serial_ctrl and serial_port devices do runtim=
e
> > suspend before port registration completes, things will fail.
> >
> > Sounds like doing pm_runtime_resume_and_get() in mtk8250_probe() might
> > fix the issue. Still seems that adding a custom read function for
> > mtk8250_runtime_suspend() to use instead of calling serial_in() should
> > not be needed.
>
> Looking at this again, if serial8250_register_8250_port() fails, then
> mtk8250_runtime_suspend() would again try to access uninitialized port.
>
> Here's a better untested version of the patch to try.
>
> Regards,
>
> Tony
>
> 8< ---------------------------
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250=
/8250_mtk.c
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -57,6 +57,8 @@
>  #define MTK_UART_XON1          40      /* I/O: Xon character 1 */
>  #define MTK_UART_XOFF1         42      /* I/O: Xoff character 1 */
>
> +#define MTK_UART_REGSHIFT      2
> +
>  #ifdef CONFIG_SERIAL_8250_DMA
>  enum dma_rx_status {
>         DMA_RX_START =3D 0,
> @@ -69,6 +71,7 @@ struct mtk8250_data {
>         int                     line;
>         unsigned int            rx_pos;
>         unsigned int            clk_count;
> +       void __iomem            *membase;
>         struct clk              *uart_clk;
>         struct clk              *bus_clk;
>         struct uart_8250_dma    *dma;
> @@ -187,6 +190,17 @@ static void mtk8250_dma_enable(struct uart_8250_port=
 *up)
>  }
>  #endif
>
> +/* Read and write for register access before and after port registration=
 */
> +static u32 __maybe_unused mtk8250_read(struct mtk8250_data *data, u32 re=
g)
> +{
> +       return readl(data->membase + (reg << MTK_UART_REGSHIFT));
> +}
> +
> +static void mtk8250_write(struct mtk8250_data *data, u32 reg, u32 val)
> +{
> +       writel(val, data->membase + (reg << MTK_UART_REGSHIFT));
> +}
> +
>  static int mtk8250_startup(struct uart_port *port)
>  {
>  #ifdef CONFIG_SERIAL_8250_DMA
> @@ -425,11 +439,10 @@ mtk8250_set_termios(struct uart_port *port, struct =
ktermios *termios,
>  static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
>  {
>         struct mtk8250_data *data =3D dev_get_drvdata(dev);
> -       struct uart_8250_port *up =3D serial8250_get_port(data->line);
>
>         /* wait until UART in idle status */
>         while
> -               (serial_in(up, MTK_UART_DEBUG0));
> +               (mtk8250_read(data, MTK_UART_DEBUG0));

I believe it still gets stuck here sometimes.

With your earlier patch, it could get through registering the port, and
the console would show

    11002000.serial: ttyS0 at MMIO 0x11002000 (irq =3D 240, base_baud =3D
1625000) is a ST16650V2

for the console UART.

Angelo mentioned that we should be using SLEEP_REQ/SLEEP_ACK registers
in the MTK UART hardware.

I tried reworking it into your patch here, but it causes issues with the
UART-based Bluetooth on one of my devices. After the UART runtime suspends
and resumes, something is off and causes the transfers during Bluetooth
init to become corrupt.

I'll try some more stuff, but the existing code seems timing dependent.
If I add too many printk statements to the runtime suspend/resume
callbacks, things seem to work. One time I even ended up with broken
UARTs but otherwise booted up the system.

ChenYu

>
>         if (data->clk_count =3D=3D 0U) {
>                 dev_dbg(dev, "%s clock count is 0\n", __func__);
> @@ -553,6 +566,7 @@ static int mtk8250_probe(struct platform_device *pdev=
)
>         if (!data)
>                 return -ENOMEM;
>
> +       data->membase =3D uart.port.membase;
>         data->clk_count =3D 0;
>
>         if (pdev->dev.of_node) {
> @@ -570,7 +584,7 @@ static int mtk8250_probe(struct platform_device *pdev=
)
>         uart.port.flags =3D UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
>         uart.port.dev =3D &pdev->dev;
>         uart.port.iotype =3D UPIO_MEM32;
> -       uart.port.regshift =3D 2;
> +       uart.port.regshift =3D MTK_UART_REGSHIFT;
>         uart.port.private_data =3D data;
>         uart.port.shutdown =3D mtk8250_shutdown;
>         uart.port.startup =3D mtk8250_startup;
> @@ -581,27 +595,30 @@ static int mtk8250_probe(struct platform_device *pd=
ev)
>                 uart.dma =3D data->dma;
>  #endif
>
> -       /* Disable Rate Fix function */
> -       writel(0x0, uart.port.membase +
> -                       (MTK_UART_RATE_FIX << uart.port.regshift));
> -
>         platform_set_drvdata(pdev, data);
>
>         pm_runtime_enable(&pdev->dev);
> -       err =3D mtk8250_runtime_resume(&pdev->dev);
> +       err =3D pm_runtime_resume_and_get(&pdev->dev);
>         if (err)
>                 goto err_pm_disable;
>
> +       /* Disable Rate Fix function */
> +       mtk8250_write(data, 0, MTK_UART_RATE_FIX);
> +
>         data->line =3D serial8250_register_8250_port(&uart);
>         if (data->line < 0) {
>                 err =3D data->line;
> -               goto err_pm_disable;
> +               goto err_pm_put;
>         }
>
>         data->rx_wakeup_irq =3D platform_get_irq_optional(pdev, 1);
>
> +       pm_runtime_put_sync(&pdev->dev);
> +
>         return 0;
>
> +err_pm_put:
> +       pm_runtime_put_sync(&pdev->dev);
>  err_pm_disable:
>         pm_runtime_disable(&pdev->dev);
>
> @@ -694,7 +711,7 @@ static int __init early_mtk8250_setup(struct earlycon=
_device *device,
>                 return -ENODEV;
>
>         device->port.iotype =3D UPIO_MEM32;
> -       device->port.regshift =3D 2;
> +       device->port.regshift =3D MTK_UART_REGSHIFT;
>
>         return early_serial8250_setup(device, NULL);
>  }
