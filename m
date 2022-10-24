Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8366C609AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJXGh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJXGhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:37:25 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094453039;
        Sun, 23 Oct 2022 23:37:10 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id e18so27504476edj.3;
        Sun, 23 Oct 2022 23:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNOlpRDz3PRWt2SLP7TWTsSG8DwAhs18CtKmfXpDPX8=;
        b=CV4bsx+87Oz8CTcBtchXph5pjkTYPmTmaenXtoljMoBcxQ1bwwWGKZJnH1XCxiDejj
         lLJrFruXE4smaXxfJ4BVY/yzrCnBd6O8SZivoaA8WVLg03E9siGIN/kdUUJwsBUZlNMF
         0efcFRt5J3mVQHj+nJvn0riasV3DqwQs0MyOH9ZWACsJf8YEeBZNpyk8mpeSzP7VDi4/
         4fzPJLLUph0ORbpo/fKlRjx0gh2srLZfsd0n+/aTGGkKUgDQUohy5hagRsveOF4DxDGD
         EOG2ga/9KIE1KJo8eIxmsHDRMMA8mGU5uvfpezE3E6XPg9dnXIy1Qpl6lBs/Ahk5qJvJ
         g0Yw==
X-Gm-Message-State: ACrzQf11i0wMQOSbdGG1OVdIU7Z5shdvjv/EUsZoq2Ng0EqfiHckU4Cv
        dZC8RCVdqUsq4kyXuJXc14NqaE/lNkld/g==
X-Google-Smtp-Source: AMsMyM706iOH7eofX+Z3ICsllq08MNRHvZtNgzRhuuuAIBnAyBuFDIBnHyBDTZeMEAqUN4Aaclx8QA==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr29103392edc.203.1666593428760;
        Sun, 23 Oct 2022 23:37:08 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b007415f8ffcbbsm15194521ejz.98.2022.10.23.23.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 23:37:07 -0700 (PDT)
Message-ID: <0ac3dc40-080a-f843-f616-7a9fdd78afaf@kernel.org>
Date:   Mon, 24 Oct 2022 08:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        lukas@wunner.de, ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20221020131938.32454-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH V3] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
In-Reply-To: <20221020131938.32454-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 10. 22, 15:19, Sherry Sun wrote:
> @@ -2636,6 +2610,54 @@ static const struct serial_rs485 lpuart_rs485_supported = {
>   	/* delay_rts_* and RX_DURING_TX are not supported */
>   };
>   
> +static int lpuart_global_reset(struct lpuart_port *sport)
> +{
> +	struct uart_port *port = &sport->port;
> +	void __iomem *global_addr;
> +	unsigned long ctrl, bd;
> +	unsigned int val = 0;
> +	int ret;
> +
> +	ret = clk_prepare_enable(sport->ipg_clk);
> +	if (ret) {
> +		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
> +		/*
> +		 * If the transmitter is used by earlycon, wait for transmit engine to
> +		 * complete and then reset.
> +		 */
> +		ctrl = lpuart32_read(port, UARTCTRL);
> +		if (ctrl & UARTCTRL_TE) {
> +			bd = lpuart32_read(&sport->port, UARTBAUD);
> +			if (read_poll_timeout_atomic(lpuart32_tx_empty, val, val, 1, 100000,
> +						     false, port)) {

Ah, this is not atomic context (clk_prepare_enable() above and 
usleep_range() below), so no need for _atomic here too.

thanks,
-- 
js
suse labs

