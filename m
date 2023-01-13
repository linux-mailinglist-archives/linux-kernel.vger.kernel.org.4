Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C7668F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjAMHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAMHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:44:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E88FD9;
        Thu, 12 Jan 2023 23:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h4SIO5Vhg+nTG28cL2ItMex6tptSMIIoaPuTXiy4QRY=; b=X9WRD1uFZ8GM08dcnkEzGBIUBN
        AlHf4sXA0RwDUqEtwvnIEV6F1JWlqzUuE9eq6hCfKdjLqHfK8uI7uidsA+LJIq93RXB89wFjqvDZe
        3thF2e7e67FcXGhav2n9feqEajMB6759/BzWPlkbPieZOSJyAM5pWP3s4oHvV5c4FGvtbZZSLWN8g
        lsLSLECcGl6NxtEK1WlWg0tw5PSHmjE1UymF9rL+c4rBFdQ0bspB32c0FDcU/vAM44QIde7sZ41lj
        e/mV1ccduLSmEJ9fyQlAdzUB74xIYAyfqAnrQ26CLwar4xW03t3FF/+XDz/p5HzzgBe7cBsEJKLTG
        xF1rLNmA==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGEjJ-0011YO-NV; Fri, 13 Jan 2023 07:44:01 +0000
Message-ID: <3311cea3-3a1f-3c2d-d167-6bfe85b2ae84@infradead.org>
Date:   Thu, 12 Jan 2023 23:44:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ata: Don't build PATA_CS5535 on UML
To:     Peter Foley <pefoley2@pefoley.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230112-umide-v1-1-78742026a3f1@pefoley.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/12/23 20:37, Peter Foley wrote:
> This driver uses MSR functions that aren't implemented under UML.
> Avoid building it to prevent tripping up allyesconfig.
> 
> e.g.
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3a3): undefined reference to `__tracepoint_read_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x3d2): undefined reference to `__tracepoint_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x457): undefined reference to `__tracepoint_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x481): undefined reference to `do_trace_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4d5): undefined reference to `do_trace_write_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x4f5): undefined reference to `do_trace_read_msr'
> /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../x86_64-pc-linux-gnu/bin/ld: pata_cs5535.c:(.text+0x51c): undefined reference to `do_trace_write_msr'
> 
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

I have a similar patch on my system that I have never sent.
I think that PATA_CS5536 needs the same treatment.

Anyway:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index eceaec33af65..9695c4404e26 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -640,6 +640,7 @@ config PATA_CS5530
>  config PATA_CS5535
>  	tristate "CS5535 PATA support (Experimental)"
>  	depends on PCI && (X86_32 || (X86_64 && COMPILE_TEST))
> +	depends on !UML
>  	help
>  	  This option enables support for the NatSemi/AMD CS5535
>  	  companion chip used with the Geode processor family.
> 
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230112-umide-18c116111232
> 
> Best regards,

-- 
~Randy
