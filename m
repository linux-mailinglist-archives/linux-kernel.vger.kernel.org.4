Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1083463D231
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiK3JjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiK3JiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:38:20 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E08BE16;
        Wed, 30 Nov 2022 01:37:40 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id b8so23209991edf.11;
        Wed, 30 Nov 2022 01:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8txsqYzOtikQ3QaXooOdL0rWxlI4WoMcJ9dMdxjlc34=;
        b=7ZCCqNVSneXdbHkjAp4CsZ+lZTRRdYdXHW4bZ+UwHz3REcf7I/a8pBBEs7VTe5Z+hU
         AFDGd9z1guEA5DCKPjazaVKmXhjDHuWJlXA0YYkT1v3Q/q4eyDaYTi4qsssudYUEXTEd
         skiXFPwzIZVrS9Q9H1x9eUiML2ISQ2wQhwnaA8uJHT9Qk+E8NmngvBaScmLVn5ZIuWqG
         +PBUWiEWMcHvw2c3t3EtCjvV7pBqVqskRpes3eycXvKaC/tw1rvaKSdZfllryn4bhYtL
         gGLrh0WK6OJuhXgO902FOZLKLoM2iSTBrm0KDaFnlOzIAJPVS69W1byOEPYnZFTvJF/7
         6vQQ==
X-Gm-Message-State: ANoB5pmK3uXQpZ6iUZ75W5zisbrkjn3fPaFeI47IyzDXePaLcnWOUBiU
        RDhQkA3pUYJLF087t/CfSy4=
X-Google-Smtp-Source: AA0mqf7Tiax9Np3qBwe098NPc6lmOwV81ou5iaihHaCbKsNigXw7NiBzNqUrh8Y/yYdg+pkrP3h30A==
X-Received: by 2002:a05:6402:5290:b0:461:af68:9bcd with SMTP id en16-20020a056402529000b00461af689bcdmr38837516edb.67.1669801058451;
        Wed, 30 Nov 2022 01:37:38 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm452553ejt.13.2022.11.30.01.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:37:37 -0800 (PST)
Message-ID: <22332676-9d3a-1e21-aa70-e9c367b19bd9@kernel.org>
Date:   Wed, 30 Nov 2022 10:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 11/13] tty: serial: qcom-geni-serial: stop operations
 in progress at shutdown
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221129110012.224685-1-brgl@bgdev.pl>
 <20221129110012.224685-12-brgl@bgdev.pl>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221129110012.224685-12-brgl@bgdev.pl>
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
> We don't stop transmissions in progress at shutdown. This is fine with
> FIFO SE mode but with DMA it causes trouble so fix it now.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index fe15fc0e1345..c0270eec2a66 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -864,6 +864,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
>   
>   static void qcom_geni_serial_shutdown(struct uart_port *uport)
>   {
> +	qcom_geni_serial_stop_tx(uport);
> +	qcom_geni_serial_stop_rx(uport);
> +
>   	disable_irq(uport->irq);

I'm just asking without actually looking into the code: cannot the 
interrupt reschedule/restart the above?

thanks,
-- 
js
suse labs

