Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AB860472B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiJSNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJSNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:32:29 -0400
X-Greylist: delayed 3278 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 06:20:13 PDT
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30BC169CE9;
        Wed, 19 Oct 2022 06:20:11 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 2C3DF4405F3;
        Wed, 19 Oct 2022 14:33:29 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1666179209;
        bh=ooaBlWbe5BcZsvcnQ+dv/mblh3tcKd5KddrxqCXz3KU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=JZ9JJhnUc4iGBEbErU9+6FWc8In32oTPsUWUiL6K8VCaeboHtYJCVy/zFeGe0dZKo
         xtOBZACMqlXoeSc7aofFlgrePrxrjQSDup04FdpPxx5wuc8rPfSS0RqbhLpDYCOu+7
         IR6QfRm6Ttq+cfXPiAK+yHjw4WH9QmSDqFEQOvDrpbwEm3LD/3EZVPNVNfS6GqELqp
         FzqaTS+q1q8GaMGD77v5jN0yq/N9Ln76ffcSHSAYiwZZEkDdVovZ4RS4Oh79/V8ouZ
         urJDMHZeRR59SBMN2/tI4Iw8veCDtljJqT9xE/3CAxssMIQE7PtTcXhUUJT1DSzd8l
         hNFpkzPfswIKg==
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-15-ilpo.jarvinen@linux.intel.com>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 14/44] serial: digicolor: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 14:30:51 +0300
In-reply-to: <20221019091151.6692-15-ilpo.jarvinen@linux.intel.com>
Message-ID: <87ilkgdp17.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On Wed, Oct 19 2022, Ilpo J=C3=A4rvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/tty/serial/digicolor-usart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/di=
gicolor-usart.c
> index 0c0a62346f23..ed197705f7ee 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -202,8 +202,7 @@ static void digicolor_uart_tx(struct uart_port *port)
>=20=20
>  	while (!uart_circ_empty(xmit)) {
>  		writeb(xmit->buf[xmit->tail], port->membase + UA_EMI_REC);
> -		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> +		uart_xmit_advance(port, 1);
>=20=20
>  		if (digicolor_uart_tx_full(port))
>  			break;

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
