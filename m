Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D076932E7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBKRsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBKRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:48:05 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D22D6A;
        Sat, 11 Feb 2023 09:48:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qb15so20859596ejc.1;
        Sat, 11 Feb 2023 09:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqZpcJTsklSiULHfQDNb4M6GcqQWAHU3VWlyLhQ2cGQ=;
        b=KCT45l2QDp4vt0O1iKnoLZsjwgDPt9mV5OfNnEIlg29yuWeMZ+80kjkwhUs03gs3DJ
         +UyYISTMDd9uq9tVFDAoj9JY2s96/FKcqCAxFDwY51IdzVD9atTP6xygMFW7Jg0qWvS4
         wnBT5lKavFm1jtqCXQlR0ED+VqUS0DlOAgZwyH7WrRk2QH3ySEzjQHvlDh0Cvdry+O8v
         sBjzjG87yRprxVDugHuJ+7+MUkMGpukkuDLZueUKo/nIgrD01vY58Qf1UK12jtM6GU2o
         V7wRBp+1q0awMak5DJMuZQPpExrWIGYFKDbq0QAD6d5I+Lv5Nwps4uHouWaDOdoo+KXW
         Kuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqZpcJTsklSiULHfQDNb4M6GcqQWAHU3VWlyLhQ2cGQ=;
        b=f2LU6ip/of/xjJpw8oltldcKaQjjBPTOOf+SnHaenwjY1zYvkvOvHBu/WG1MSl9zEZ
         XNzc377SE+bOcmJaIbIll8nl1wNYtgnrC9QNaEWM8SVWAo0NrFa2tPDpagD74Zyowase
         xecYsXlfgIo4HxrykyP2AA0Ru1skCrK4czARap7PqX9oYweWeDf78oWICJrl4SqMCxfg
         kT5UuF9QviTZ6ZXuAuEUa+HJ4+OHrV91EejV8AcZeUi6k52JB8QoAF7e4Bx4J+GZUkXD
         C3GL9krWV9XZQcVSLUITNp/Ze/qdhmAPwc8JoCTFNJPUzVpWdFrzcMSFeCYONCq7kQ4A
         WXLA==
X-Gm-Message-State: AO0yUKU/gJpHN9om58s/tefk350hSyh1kyPky8NKILF5VbPQRYb0m3l3
        MlJFcLHmWMKs3yu4Th12SlAqx+vw7wE=
X-Google-Smtp-Source: AK7set9REfwzmTKsnkCuna++nHdNbLo+oKu97w3imaI7tg2DZcgX+hs0MhnXjuSH33yuOsaoaJE3lQ==
X-Received: by 2002:a17:907:8e88:b0:8aa:f74:3263 with SMTP id tx8-20020a1709078e8800b008aa0f743263mr19167752ejc.51.1676137682347;
        Sat, 11 Feb 2023 09:48:02 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906040600b008838b040454sm4135967eja.95.2023.02.11.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 09:48:01 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: remove a redundant check
References: <20230211154550.2130670-1-trix@redhat.com>
Date:   Sat, 11 Feb 2023 20:48:00 +0300
In-Reply-To: <20230211154550.2130670-1-trix@redhat.com> (Tom Rix's message of
        "Sat, 11 Feb 2023 07:45:50 -0800")
Message-ID: <87lel4hz5b.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rix <trix@redhat.com> writes:

> cpp_check reports
> drivers/tty/serial/imx.c:1207:15: style: Condition 'r_bytes>0' is always true [knownConditionTrueFalse]
>   if (r_bytes > 0) {
>
> r_byte is set to
>   r_bytes = rx_ring->head - rx_ring->tail;
>
> The head - tail calculation is also done by the earlier check
>   if (rx_ring->head <= sg_dma_len(sgl) &&
>       rx_ring->head > rx_ring->tail) {
>
> so r_bytes will always be > 0, so the second check is not needed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/tty/serial/imx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 363c77a140f0..523f296d5747 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1204,11 +1204,9 @@ static void imx_uart_dma_rx_callback(void *data)
>  		r_bytes = rx_ring->head - rx_ring->tail;
>  
>  		/* If we received something, check for 0xff flood */
> -		if (r_bytes > 0) {
> -			spin_lock(&sport->port.lock);
> -			imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
> -			spin_unlock(&sport->port.lock);
> -		}
> +		spin_lock(&sport->port.lock);
> +		imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
> +		spin_unlock(&sport->port.lock);
>  
>  		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ))
>  		{

Nice catch. Didn't notice this when wrote the check-flood patch, sorry!

Thanks,
-- Sergey Organov

