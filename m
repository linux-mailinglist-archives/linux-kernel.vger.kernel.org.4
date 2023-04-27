Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768266F0E29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbjD0WAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjD0WAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1ED30EA;
        Thu, 27 Apr 2023 15:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6567E63F9F;
        Thu, 27 Apr 2023 22:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD92C433EF;
        Thu, 27 Apr 2023 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682632806;
        bh=XAJcs9Tq27uSYzyxKqynry6iOShK22+/4P+2nWhnVG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nmduOKFPBzQZKl9iACWKsy1r+NBRkDCvE/gjaOt5trThiFnAgRb8ApVPqQ0ai4ZPg
         HQjeNRXos8H2zB0tzul+TrvMaJLKJPFD7Arn6gxSppALgIY6tZoA+FdQNyafXACfCn
         GnqJ8rHXfVt0zO6R94Olgc+uj2Gz7pXBzJLqX7Pu4NTScksSQ+2PGAGKNnc/igsH5P
         oYlklycCDK4Mz1CbFvMdZ51p84cmb1Knv6tjca3gxDes3I/9V/noC1AxlX7m4uwL+O
         gtKlVxu8YvXn5/Jg4l7aEhtCPvgGQbJA9+lz5Ka8i1Gk93fRyhIm7ijtbHE3ehJs75
         KL12Joi/HBsvw==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso2563593276.2;
        Thu, 27 Apr 2023 15:00:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDxRyNsJ+gdR87FpJ8y7wA8HZ/h8J8BkoD76Hqg3RV+SYm3f6t2n
        wv+WBrvhibigoDf3KtUoJL6DcXROh2HCxjfyYw==
X-Google-Smtp-Source: ACHHUZ7mW/EfaNcdgWrWRr2AEvbTi7Q+LlVB+H74Yy1MlvvgiGwV1CSsI0Flt3OOunhIdUkchExT6Rm/BmnFgYyRSHM=
X-Received: by 2002:a05:6902:18c8:b0:b8f:3781:248e with SMTP id
 ck8-20020a05690218c800b00b8f3781248emr2890576ybb.51.1682632805841; Thu, 27
 Apr 2023 15:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230426012721.6856-1-m202171830@hust.edu.cn>
In-Reply-To: <20230426012721.6856-1-m202171830@hust.edu.cn>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Apr 2023 16:59:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLR_REJWVn_dO8R4ngkrqL=E_ksNr=jS0qRmdpmAaD8hQ@mail.gmail.com>
Message-ID: <CAL_JsqLR_REJWVn_dO8R4ngkrqL=E_ksNr=jS0qRmdpmAaD8hQ@mail.gmail.com>
Subject: Re: [PATCH] serial: arc_uart: fix of_iomap leak in `arc_serial_probe`
To:     Ke Zhang <m202171830@hust.edu.cn>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 8:27=E2=80=AFPM Ke Zhang <m202171830@hust.edu.cn> w=
rote:
>
> Smatch reports:
>
> drivers/tty/serial/arc_uart.c:631 arc_serial_probe() warn:
> 'port->membase' from of_iomap() not released on lines: 631.
>
> In arc_serial_probe(), if uart_add_one_port() fails,
> port->membase is not released, which would cause a resource leak.
>
> To fix this, I replace of_iomap with devm_of_iomap.

How about use devm_platform_ioremap_resource() instead (or any ioremap
variant) as that is preferred over of_iomap().

Rob

>
> Fixes: 8dbe1d5e09a7 ("serial/arc: inline the probe helper")
> Signed-off-by: Ke Zhang <m202171830@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> This issue is found by static analysis and remains untested.
> ---
>  drivers/tty/serial/arc_uart.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.=
c
> index 59e25f2b6632..be1f3c379382 100644
> --- a/drivers/tty/serial/arc_uart.c
> +++ b/drivers/tty/serial/arc_uart.c
> @@ -606,10 +606,11 @@ static int arc_serial_probe(struct platform_device =
*pdev)
>         }
>         uart->baud =3D val;
>
> -       port->membase =3D of_iomap(np, 0);
> -       if (!port->membase)
> +       port->membase =3D devm_of_iomap(&pdev->dev, np, 0, NULL);
> +       if (IS_ERR(port->membase)) {
>                 /* No point of dev_err since UART itself is hosed here */
>                 return -ENXIO;

If an errno was returned, you should return that errno and not a different =
one.

Rob
