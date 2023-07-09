Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86E74C462
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjGINfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGINfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:35:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C44E9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XtlMj/xZI5fxRI8QHsDdIuiDOXuudEspjl5+tacTkOM=; b=CrdEhIU6Mtm0sMlfLY7rr9daGa
        1hcv6fiqX2SoVpI/A0QU8TPKmTyhYsZctRnUX6sgustbVHxfWe2qzyy//LJ9vtUFWmiaQNFEobNGS
        7/x3ZA36rNmedykyIBQo9mrqJT+9Nnk7FoHzr4hpoKwPg7Kt8vMBYfpgP67sZ5tOv/reLdkHuy3fI
        8uZxLozMOUIOWE8kCdZd5JBWNYwPo+/+yKWXy8Jlq2wXryBD8BYkmY0GdLECjVg6gMZevqCMQmM/6
        2qVSKVLZ3i0qIr/cELTSA1TdgLRcglMRclY28x3WKJ8z0dHZeD1i0OlU6dL56zMm7d2N9fcaohuZd
        ybiU6bGA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIUYq-009AbJ-2d;
        Sun, 09 Jul 2023 13:34:48 +0000
Message-ID: <7f0b03e1-886f-5382-9b86-425b86006569@infradead.org>
Date:   Sun, 9 Jul 2023 06:34:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Content-Language: en-US
To:     Dong Zhihong <donmor3000@hotmail.com>, chenhuacai@kernel.org,
        kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/23 06:32, Dong Zhihong wrote:
> This patch tends to fix broken CONFIG_CMDLINE, which is not working with
> CONFIG_CMDLINE_EXTEND or CONFIG_CMDLINE_BOOTLOADER. Some code is absent in
> arch/loongarch/kernel/setup.c, which should handle built-in command lines
> in CONFIG_CMDLINE. The absence of such code causes CONFIG_CMDLINE not
> working if CONFIG_CMDLINE_EXTEND or CONFIG_CMDLINE_BOOTLOADER is set to Y.
> CONFIG_CMDLINE_FORCE is not affected.
> 
> Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
> ---
>  arch/loongarch/kernel/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 78a00359bde3..504218b94879 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -335,6 +335,22 @@ static void __init bootcmdline_init(char **cmdline_p)
>  	}
>  #endif
>  
> +#ifdef CONFIG_CMDLINE
> +	/*
> +	 * If CONFIG_CMDLINE_BOOTLOADER is enabled then we use thei built-in

	                                                       the

> +	 * command line if no command line given, or we append given command
> +	 * line to the built-in one if CONFIG_CMDLINE_EXTEND is enabled.
> +	 */
> +	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
> +		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +		strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0])
> +		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif
> +
>  out:
>  	*cmdline_p = boot_command_line;
>  }

-- 
~Randy
