Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2563359A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKVHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:02:08 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39F23BF0;
        Mon, 21 Nov 2022 23:02:07 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id f27so33722478eje.1;
        Mon, 21 Nov 2022 23:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obhyf6FbeDYJ4EzUmao9xEvzmssDDgcxntsnLOZ5F7g=;
        b=ZgQzUOvf1AG4XRU9QvCfO/xuBT0LzT8i9dqulbVwlbeSvr/oyg53SSDEpHRO7NkaUe
         +X6qF0eceb33pRteladirlW+QNZAOiEjN0BfaAcr+yXxGQltSRB7cUExmmUHYBWadI6+
         JqhHvkpC/QbOoZudGzre1BIheWOC+l15RIfrdohHoAeeHvdvuzOx8VoLkZHPX5GvcuRi
         mAMOiPWa78P7kZtRPSwui55xBDK1wahWRrM1jvR3NQghapkbck5Zh3KqBeyB98/lryjC
         0EahdalbLMUW7IyW8QoeKbzPIqIe1WWioHrck2pCwaIzGJUCmx/Zu/7VX2AI+As0/Uem
         gEJA==
X-Gm-Message-State: ANoB5pn5cDU1cbokLHDIrkOllXbOB5u/f14R3saCPeD4qt/t7G4dfr2q
        NMN7n9tWODXchD/DnWfXeeX4NPqKYYrSsA==
X-Google-Smtp-Source: AA0mqf6K+SNMjIbRwN8XBuKJx8oR6/cRUUp23vgQyzgzvpU6h2PPnNCsBeh2ys7OQ9298Isleb1DzA==
X-Received: by 2002:a17:907:c208:b0:7ad:79c0:547a with SMTP id ti8-20020a170907c20800b007ad79c0547amr8621315ejc.41.1669100526244;
        Mon, 21 Nov 2022 23:02:06 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090636ce00b007a8de84ce36sm5751620ejc.206.2022.11.21.23.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:02:05 -0800 (PST)
Message-ID: <f95ef7b7-cc23-9fed-5d05-1aa66aaeb86a@kernel.org>
Date:   Tue, 22 Nov 2022 08:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 2/3] tty: serial: use uart_port_tx() helper
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     afaerber@suse.de, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, mani@kernel.org,
        nicolas.ferre@microchip.com, richard.genoud@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, sudeep.holla@arm.com,
        tklauser@distanz.ch, vz@mleia.com
References: <20221004104927.14361-3-jirislaby@kernel.org>
 <20221121202724.1708460-1-michael@walle.cc>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221121202724.1708460-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21. 11. 22, 21:27, Michael Walle wrote:
> This will break serial output for the userspace on my board
> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt*dts). The uart_port_tx()
> helper will call __port->ops->stop_tx(__port) if uart_circ_chars_pending()
> returns 0. But the code above, doesn't do that. In fact, removing the
> stop_tx() call in the helper macro, will fix the console output.
> 
> Any ideas how to fix that?

Hm, so ATMEL_US_TXRDY is removed from tx_done_mask in stop_tx, but not 
added back in start_tx. So the tx interrupt is never handled (the tx 
tasklet is not scheduled to send the queue chars) in 
atmel_handle_transmit().

Any chance, the below fixes it?

diff --git a/drivers/tty/serial/atmel_serial.c 
b/drivers/tty/serial/atmel_serial.c
index 11bf2466390e..395370e0c77b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -596,6 +596,8 @@ static void atmel_start_tx(struct uart_port *port)
                 /* re-enable PDC transmit */
                 atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);

+       atmel_port->tx_done_mask |= ATMEL_US_TXRDY;
+
         /* Enable interrupts */
         atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);


thanks,
-- 
js

