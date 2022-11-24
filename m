Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E676372AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKXHIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXHII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:08:08 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB6D1EED4;
        Wed, 23 Nov 2022 23:18:16 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id ho10so2233762ejc.1;
        Wed, 23 Nov 2022 23:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28w6O+pPmRjriUkq2iRz9DosEFHbVDYy9KC+KBujCX0=;
        b=woRmyZCoFop9l6EOYAU++3ojjnRhqTRlLNdDSUpa4kpo9Ub8Ptrmn1oYHuCy1l2u+t
         Z0v2rxOv8kVi4NwmQOTAauejKqIujjyhVdwpq6yvqprmSDWMIyeSTiteEqeuOI/B5it/
         Wfj45OcInMoUFFYz+zcFhoP7Qs2x7MkNVgsDbwHiuvcizkN8cSty/eIBoliUR8JqrLg1
         b1tOYOmnLPp3l38wXPBup/eo2UMglDsQWG28G9Oew4jdIl7RGN2/HUcb2mv6QwEEpTBW
         xM0hyXG+dzJOIGOh2E4kQtWYQCUkB647PV176pZ43068p6urTmUtw3NXkmtdpUGXzhkA
         kwFw==
X-Gm-Message-State: ANoB5plJmOc+BjgBnQjJF3I8vGNSnZw0KjRFc7Zh3BsklFj0nFVJU8wG
        Ik/5yH9df6PBfUlYoG/EbVo=
X-Google-Smtp-Source: AA0mqf4ltkb6fLqg0H2PwZpZGh9xj593lrm/XSM6cvcyR2Dbz6kMZMYaV+jw/MCnHQBqZVWonSmhMQ==
X-Received: by 2002:a17:906:38a:b0:7a7:1d4f:c7d9 with SMTP id b10-20020a170906038a00b007a71d4fc7d9mr15023752eja.402.1669274294885;
        Wed, 23 Nov 2022 23:18:14 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id o25-20020aa7c519000000b00467cc919072sm187692edq.17.2022.11.23.23.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 23:18:14 -0800 (PST)
Message-ID: <4f4b7e8b-8017-2a6f-f756-46c60fba8a3c@kernel.org>
Date:   Thu, 24 Nov 2022 08:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 08/13] tty: serial: qcom-geni-serial: refactor
 qcom_geni_serial_handle_tx()
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20221123110759.1836666-1-brgl@bgdev.pl>
 <20221123110759.1836666-9-brgl@bgdev.pl>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221123110759.1836666-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 11. 22, 12:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> qcom_geni_serial_handle_tx() is pretty big, let's move the code that
> handles the actual writing of data to a separate function which makes
> sense in preparation for introducing a dma variant of handle_tx().
> 
> Let's also shuffle the code a bit, drop unneeded variables and use
> uart_xmit_advance() instead of handling tail->xmit manually.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 54 +++++++++++++--------------
>   1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 68a1402fbe58..658b6d596f58 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -704,19 +704,42 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>   	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>   }

I know you just shuffle the code, but:

> +static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
> +					     unsigned int chunk)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +	u8 buf[BYTES_PER_FIFO_WORD];
> +	size_t remaining = chunk;

Why size_t when the others are uints? Well, BYTES_PER_FIFO_WORD should 
be defined as 4U.

> +	unsigned int tx_bytes;
> +	int c;
> +
> +	while (remaining) {
> +		memset(buf, 0, sizeof(buf));
> +		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);

Then, no need for min_t.

> +
> +		for (c = 0; c < tx_bytes ; c++) {
> +			buf[c] = xmit->buf[xmit->tail];
> +			uart_xmit_advance(uport, 1);
> +		}
> +
> +		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);

I wonder, why is _rep variant used to transfer a single word? Only to 
hide the cast?

thanks,
-- 
js
suse labs

