Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37849707598
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:43:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86B40CD;
        Wed, 17 May 2023 15:43:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f64817809so203135a12.1;
        Wed, 17 May 2023 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684363433; x=1686955433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LieYOKCJXnWqNjni2ZgzrOlh3FdkTjA6itbHDewDbsg=;
        b=DthQcgs7xqOphPki8LXGhEqd9v3/PJKocQknnJWvLKfiJREajOAV/4qhyTS/gqSink
         y1UfBRmMHGayhCzRBtWLRxfY0qdUr2fZNIrCmV2XbpIXx2GMmXEsrgT9qlv+JjbYgEBA
         wRXSlFOvdxwc3Rb4psoQYuDBMxyysP6/EiuwDsmNKQYjGWsg35xOXCqk9UHNPD6fYpCV
         Ud9Cx3KJFoUc0Np4bknK7o4rdHyG3EPmwlNiaT7wKRza0PXd50ezM+Be2PgFldxJPZZT
         PAG6xoGgTaE2I+P1WNtPxskD3uylO7l1awrJX5ZT9ssXIcBo/ETuVQwzCxqwvCkI0sdO
         F8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684363433; x=1686955433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LieYOKCJXnWqNjni2ZgzrOlh3FdkTjA6itbHDewDbsg=;
        b=cQTXdoxv3wVoPdJhuGgOTcQFVkhOPCyQYcxszFEJanYKnOXuctB86ZLCHO3ZKFuwFE
         IUuVeBnvXMB8Rc8Be0XDenj+AYvghtrk52GoC+xculDiH8EGxOUi7HQDTwTIuNUpXyb9
         eFNhxoN4q38hzWWGwj21btUViOTXZLgSWi9BriukzTPrtI31EZnRdoDeDX1nbdQiBlAe
         +0MYhO98dkyxVLKRE7hKSisLDID5cFldZner9bmMaiuN/ESCkQlh1EGOKYrZeCmsGsZ9
         5yumk8LQU3QRLwo1FOqwvFXVQQP7jqtQllXOjo+4yWhffhMXzKuYP/D55fzIAH5EXKWV
         nXhQ==
X-Gm-Message-State: AC+VfDxFcAnP6vdHFYeVaxD75fIxTth6mhrKobBN/UzhNL61DFdJxflv
        lO5BuOYEMHKM5MYCUYkPnQ/oNd+Vi/MtCCyBa8k=
X-Google-Smtp-Source: ACHHUZ72iAtOsfRpS39tC7fKeXg00DkEi5PM5JbSOZ3BiQGjYSY+qngEvBlTl62EH8YIQgK/PkiLT3m+JvcgsooMp+0=
X-Received: by 2002:a17:902:ec84:b0:1ac:881b:494 with SMTP id
 x4-20020a170902ec8400b001ac881b0494mr5511269plg.0.1684363432701; Wed, 17 May
 2023 15:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230517223007.178432-1-boerge.struempfel@gmail.com>
In-Reply-To: <20230517223007.178432-1-boerge.struempfel@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 May 2023 19:43:41 -0300
Message-ID: <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 7:30=E2=80=AFPM Boerge Struempfel
<boerge.struempfel@gmail.com> wrote:
>
> Some spi controller switch the mosi line to high, whenever they are
> idle. This may not be desired in all use cases. For example neopixel
> leds can get confused and flicker due to misinterpreting the idle state.
> Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> can be overwritten on a per device basis.
>
> Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
>
>
> Link for versions:
>   v1 and v2: https://lore.kernel.org/linux-spi/20230511135632.78344-1-bst=
ruempfel@ultratronik.de/
>   v3: https://lore.kernel.org/linux-spi/20230517103007.26287-1-boerge.str=
uempfel@gmail.com/T/#t
>
> Changes from V3:
>   - Added missing paranthesis which caused builderrors
>
> Changes from V2:
>   - Removed the device-tree binding since this should not be managed by
>     the DT but by the device itself.
>   - Replaced all occurences of spi->chip_select with the corresponding
>     macro spi_get_chipselect(spi,0)
>
> Changes from V1:
>   - Added patch, introducing the new devicetree binding flag
>   - Split the generic spi part of the patch from the imx-spi specific
>     part
>   - Replaced SPI_CPOL and SPI_CPHA by the combined SPI_MODE_X_MASK bit
>     in the imx-spi.c modebits.
>   - Added the SPI_MOSI_IDLE_LOW bit to spidev

The change log should be placed below the --- line.

> ---
>  include/uapi/linux/spi/spi.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
> index 9d5f58059703..ca56e477d161 100644
> --- a/include/uapi/linux/spi/spi.h
> +++ b/include/uapi/linux/spi/spi.h
> @@ -28,6 +28,7 @@
>  #define        SPI_RX_OCTAL            _BITUL(14)      /* receive with 8=
 wires */
>  #define        SPI_3WIRE_HIZ           _BITUL(15)      /* high impedance=
 turnaround */
>  #define        SPI_RX_CPHA_FLIP        _BITUL(16)      /* flip CPHA on R=
x only xfer */
> +#define SPI_MOSI_IDLE_LOW      _BITUL(17)      /* leave mosi line low wh=
en idle */

Should tools/spi/spidev_test.c be changed to include this new
mosi-idle-low option?
