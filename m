Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14A63A114
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiK1GKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiK1GKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:10:46 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FF13F45;
        Sun, 27 Nov 2022 22:10:45 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id g12so15057687wrs.10;
        Sun, 27 Nov 2022 22:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNcHyBDLc5jdtnLBN8748IdlIq3jeqAUsM7MsspQYq8=;
        b=hhrDcGj3lcmGsh7XLPOKXYX647Wme5iMWJzRP1QfHzffnXnI86JLKbsI2uCYrPpJCH
         K1yVDRq+0oWBwmnL5KJyOVTrlqMEVGetd+s5oB1Vw5H4ifxqG8F7plTQt5Xu5pHguQqF
         hYEp+ZSTUsw74T2CFnCkc6NqEGVwtQWMXLlQ0ZTJKtbET+tiayugwXytFVGvk1TJnusn
         +YpmRSrTomDxHhwq5aGiFP1l/OaGqhTncqspGC3ucO5JqXPyGN9gPX7To2OGsXz4C0MM
         Xh1O+7rJHtchnT5Zbj6RA/QAH9cCm0o/Qgf3kikMeidNkEmKIFTxN3gNOgG2DTLjz8O8
         lCtw==
X-Gm-Message-State: ANoB5pl//OZcWPQ2DBj0wVES3hrTjqcGuCsae792LVpZJp/b4z1CFv6w
        fOti4JExh/dUiVp8Sdujy1w=
X-Google-Smtp-Source: AA0mqf4U7mqwsR/kHM0iUuatuXazzkLjLDSblw4PHIluzbs1vltm1jgpwfhnnsZFOTu0BmvEDK3Osw==
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id c12-20020adffb4c000000b002365270735emr18959992wrs.659.1669615844299;
        Sun, 27 Nov 2022 22:10:44 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b003cfd64b6be1sm21801135wmq.27.2022.11.27.22.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 22:10:43 -0800 (PST)
Message-ID: <c0406076-04e1-6b81-1bba-ac684516d898@kernel.org>
Date:   Mon, 28 Nov 2022 07:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/9] serial: bflb_uart: add Bouffalolab UART Driver
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-3-jszhang@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221127132448.4034-3-jszhang@kernel.org>
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

On 27. 11. 22, 14:24, Jisheng Zhang wrote:
> +static void bflb_uart_tx_chars(struct uart_port *port)

Again:

Are you unable to use the TX helper? If so:
* why?
* use uart_advance_xmit() at least.

> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +	unsigned int count;
> +
> +	if (port->x_char) {
> +		/* Send special char - probably flow control */
> +		wrl(port, UART_FIFO_WDATA, port->x_char);
> +		port->x_char = 0;
> +		port->icount.tx++;
> +		return;
> +	}
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +		bflb_uart_stop_tx(port);
> +		return;
> +	}
> +
> +	count = BFLB_UART_TX_FIFO_TH;
> +	do {
> +		wrl(port, UART_FIFO_WDATA, xmit->buf[xmit->tail]);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;
> +		if (uart_circ_empty(xmit))
> +			break;
> +	} while (--count > 0);
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (uart_circ_empty(xmit))
> +		bflb_uart_stop_tx(port);
> +}

-- 
js
suse labs

