Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13074D272
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGJJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGJJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:59:11 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E3910C0;
        Mon, 10 Jul 2023 02:57:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vn1LFk9_1688983043;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vn1LFk9_1688983043)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 17:57:24 +0800
Message-ID: <fb86f01a-81b3-62c5-050f-f44e591bf272@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 17:57:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] serial: sprd: Assign sprd_port after initialized to
 avoid wrong access
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230710080348.4137875-1-chunyan.zhang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230710080348.4137875-1-chunyan.zhang@unisoc.com>
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
> The global pointer 'sprd_port' maybe not zero when sprd_probe returns
> fail, that is a risk for sprd_port to be accessed afterward, and will
> lead unexpected errors.
> 
> For example:
> 
> There're two UART ports, UART1 is used for console and configured in kernel
> command line, i.e. "console=";
> 
> The UART1 probe fail and the memory allocated to sprd_port[1] was released,
> but sprd_port[1] was not set to NULL;

IMO, we should just set sprd_port[1] to be NULL, which seems simpler?

> 
> In UART2 probe, the same virtual address was allocated to sprd_port[2],
> and UART2 probe process finally will go into sprd_console_setup() to
> register UART1 as console since it is configured as preferred console
> (filled to console_cmdline[]), but the console parameters (sprd_port[1])
> actually belongs to UART2.

I'm confusing why the console parameters belongs to UART2? Since the 
console_cmdline[] will specify the serial index, that belongs to UART1. 
Please correct me if I miss something.

> So move the sprd_port[] assignment to where the port already initialized
> can avoid the above issue.
> 
> Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>   drivers/tty/serial/sprd_serial.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index b58f51296ace..942808517393 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1106,7 +1106,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
>   static int sprd_clk_init(struct uart_port *uport)
>   {
>   	struct clk *clk_uart, *clk_parent;
> -	struct sprd_uart_port *u = sprd_port[uport->line];
> +	struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
>   
>   	clk_uart = devm_clk_get(uport->dev, "uart");
>   	if (IS_ERR(clk_uart)) {
> @@ -1149,22 +1149,22 @@ static int sprd_probe(struct platform_device *pdev)
>   {
>   	struct resource *res;
>   	struct uart_port *up;
> +	struct sprd_uart_port *sport;
>   	int irq;
>   	int index;
>   	int ret;
>   
>   	index = of_alias_get_id(pdev->dev.of_node, "serial");
> -	if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
> +	if (index < 0 || index >= UART_NR_MAX) {
>   		dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
>   		return -EINVAL;
>   	}
>   
> -	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
> -					GFP_KERNEL);
> -	if (!sprd_port[index])
> +	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> +	if (!sport)
>   		return -ENOMEM;
>   
> -	up = &sprd_port[index]->port;
> +	up = &sport->port;
>   	up->dev = &pdev->dev;
>   	up->line = index;
>   	up->type = PORT_SPRD;
> @@ -1195,7 +1195,7 @@ static int sprd_probe(struct platform_device *pdev)
>   	 * Allocate one dma buffer to prepare for receive transfer, in case
>   	 * memory allocation failure at runtime.
>   	 */
> -	ret = sprd_rx_alloc_buf(sprd_port[index]);
> +	ret = sprd_rx_alloc_buf(sport);
>   	if (ret)
>   		return ret;
>   
> @@ -1208,12 +1208,20 @@ static int sprd_probe(struct platform_device *pdev)
>   	}
>   	sprd_ports_num++;
>   
> +	sprd_port[index] = sport;
> +
>   	ret = uart_add_one_port(&sprd_uart_driver, up);
>   	if (ret)
> -		sprd_remove(pdev);
> +		goto clean_port;
>   
>   	platform_set_drvdata(pdev, up);
>   
> +	return 0;
> +
> +clean_port:
> +	sprd_port[index] = NULL;
> +	sprd_ports_num--;
> +	uart_unregister_driver(&sprd_uart_driver);
>   	return ret;
>   }
>   
