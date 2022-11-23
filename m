Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15F63533B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiKWIuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiKWIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:50:23 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8DCEC7BF;
        Wed, 23 Nov 2022 00:50:22 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7791B1D40;
        Wed, 23 Nov 2022 09:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669193420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ot1MQf8keHxTYnGi9OMHg5JoM8v/jBK7KR6S/bFtzt4=;
        b=mcP+L/NmRxw35qme0iE9W0Mfy43Bdvuo1FcB6BaVjQ8nDvP22m/ch3mGyMDmEJsp/Ihx+G
        taC3VvN1kd6lL29tZvzfcKAIEkJlWuzc88VERpr2k9LT3bBKlHZyVV2aZajTWaHBJSvOEf
        McHnPuX8lWq+hh7oBOOb/JQ+X/cxRftRvdxqPYFJG0sVXxaM0QzhZhMKoAtG5CcS1YAXVN
        RO2vtCPS5XxwjshFGnUEUWQN4MUtjKcKbkbaglsmXPp/K3S+XwoqxK0xYFGh23HN2D6qmz
        lC2knCRqeysPdPx21sgvdOq0GubZ+lg/HWUlZa8SsIXJqlr4U5muT6sRHrYobA==
MIME-Version: 1.0
Date:   Wed, 23 Nov 2022 09:50:20 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] serial: atmel: don't stop the transmitter when doing
 PIO
In-Reply-To: <20221123082736.24566-2-jirislaby@kernel.org>
References: <20221123082736.24566-1-jirislaby@kernel.org>
 <20221123082736.24566-2-jirislaby@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <df233ce37626fdb194b583808326d966@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-23 09:27, schrieb Jiri Slaby (SUSE):
> Writing ATMEL_US_TXDIS to ATMEL_US_CR makes the transmitter NOT to send
> the just queued character. This means when the character is last and
> uart calls ops->stop_tx(), the character is not sent at all.
> 
> The usart datasheet is not much specific on this, it just says the
> transmitter is stopped. But apparently, the character is dropped. So
> we should stop the transmitter only for DMA and PDC transfers to not
> send any more characters. For PIO, this is unexpected and deviates from
> other drivers. In particular, the below referenced commit broke TX as 
> it
> added a call to ->stop_tx() after the very last character written to 
> the
> transmitter.
> 
> So fix this by limiting the write of ATMEL_US_TXDIS to DMA transfers
> only.
> 
> Even there, I don't know if it is correctly implemented. Are all the
> queued characters sent once ->start_tx() is called? Anyone tested flow
> control -- be it hard (RTSCTS) or the soft (XOFF/XON) one?
> 
> Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Already merged, but:
Tested-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
