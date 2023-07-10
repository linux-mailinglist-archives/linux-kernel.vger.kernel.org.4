Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F574D2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjGJKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGJKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:06:56 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3F4215;
        Mon, 10 Jul 2023 03:03:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vn109gM_1688983371;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vn109gM_1688983371)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 18:02:53 +0800
Message-ID: <6f5ca23d-4f23-4030-2196-35026e936145@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 18:03:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] serial: sprd: Fix DMA buffer leak issue
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230710080348.4137875-1-chunyan.zhang@unisoc.com>
 <20230710080348.4137875-2-chunyan.zhang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230710080348.4137875-2-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 4:03 PM, Chunyan Zhang wrote:
> Release DMA buffer when _probe() returns fail to avoid memory leak.
> 
> Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/tty/serial/sprd_serial.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 942808517393..e1f11382fc39 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1203,7 +1203,7 @@ static int sprd_probe(struct platform_device *pdev)
>   		ret = uart_register_driver(&sprd_uart_driver);
>   		if (ret < 0) {
>   			pr_err("Failed to register SPRD-UART driver\n");
> -			return ret;
> +			goto free_rx_buf;
>   		}
>   	}
>   	sprd_ports_num++;
> @@ -1222,6 +1222,8 @@ static int sprd_probe(struct platform_device *pdev)
>   	sprd_port[index] = NULL;
>   	sprd_ports_num--;
>   	uart_unregister_driver(&sprd_uart_driver); > +free_rx_buf:
> +	sprd_rx_free_buf(sport);
>   	return ret;
>   }
>   
