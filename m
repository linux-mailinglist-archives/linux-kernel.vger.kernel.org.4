Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C063D22C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbiK3JjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiK3Jhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:51 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA82DC6;
        Wed, 30 Nov 2022 01:36:00 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id b2so23610849eja.7;
        Wed, 30 Nov 2022 01:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gHQW8SyXSe6rKcgrvLGPWcV+UXXK+imKI75/1Y5r28=;
        b=EOqOoQtzpP+4xsZNr+UNZrB2+8PCQB8bLCzlHwE0ZrENCY0CTOeL+2UMsgtpMUabGf
         Vy+bzc4CoYMAI+b3109IKrVFFQ5xqoQtdGDMIvouGJhJtqq0FUpmtW20Vvoeg0jZHIcM
         bgTBY6sE2EHM9zkqP6g/d3RksiYjni+m3S83+CNJe6fKnpxYd61+QiTJ2tirPixz2mQK
         yOM6Oq2q7VUMBB34CN5ZHnZb2Bl8DJdIDCLKx/gBvJGnECpxXbL6b/UAeGhhZg0vQjqh
         DkLacJ3wtfZQI6NbQPL5gFAj5QuB9RRPN9Z2ZFyRJfv4uw+Pl6CWQay7CxyCkuiK42Pw
         qOHw==
X-Gm-Message-State: ANoB5pmEwTpyGJgy3fgJI7EAwoosg1HZ9evvdmLajPHnPPpcBu/YWRny
        cYkvqsHH2UlJscn/Lz+YD197PnU3yVI=
X-Google-Smtp-Source: AA0mqf6pI5+t84xJmE6eWdCj4L2XxRU9nrk+O7PsWaUl00TOuMmh+3xBifqZoNoB0N8zFADx/4Cg7w==
X-Received: by 2002:a17:906:1e55:b0:7ad:a0cb:f79e with SMTP id i21-20020a1709061e5500b007ada0cbf79emr33730590ejj.458.1669800958794;
        Wed, 30 Nov 2022 01:35:58 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id d18-20020a05640208d200b0046150ee13besm411706edz.65.2022.11.30.01.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:35:58 -0800 (PST)
Message-ID: <a149f187-5928-9d8e-8aa7-91bb4138921e@kernel.org>
Date:   Wed, 30 Nov 2022 10:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 08/13] tty: serial: qcom-geni-serial: refactor
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
References: <20221129110012.224685-1-brgl@bgdev.pl>
 <20221129110012.224685-9-brgl@bgdev.pl>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221129110012.224685-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 11. 22, 12:00, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> qcom_geni_serial_handle_tx() is pretty big, let's move the code that
> handles the actual writing of data to a separate function which makes
> sense in preparation for introducing a dma variant of handle_tx().

I think you should split this patch into two. One to extract the code 
^^^. And one to clean it up:

> Let's also shuffle the code a bit, drop unneeded variables and use
> uart_xmit_advance() instead of handling tail->xmit manually.

As it is, it's hard to follow what is being changed.


...
> @@ -704,19 +704,41 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>   	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>   }
>   
> +static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
> +					     unsigned int chunk)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +	unsigned int tx_bytes, remaining = chunk;
> +	u8 buf[BYTES_PER_FIFO_WORD];
> +	int c;

c can/should be uint too.

> +
> +	while (remaining) {
> +		memset(buf, 0, sizeof(buf));
> +		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
> +
> +		for (c = 0; c < tx_bytes ; c++) {
> +			buf[c] = xmit->buf[xmit->tail];
> +			uart_xmit_advance(uport, 1);
> +		}
> +
> +		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
> +
> +		remaining -= tx_bytes;
> +		port->tx_remaining -= tx_bytes;
> +	}
> +}

thanks,
-- 
-- 
js
suse labs

