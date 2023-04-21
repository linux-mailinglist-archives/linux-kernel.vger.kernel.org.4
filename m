Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F96EB46C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjDUWHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDUWHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F4172A;
        Fri, 21 Apr 2023 15:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48F216183D;
        Fri, 21 Apr 2023 22:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7B6C433D2;
        Fri, 21 Apr 2023 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682114863;
        bh=pDVibJhWt9LWG5jQ982Dyc+TkQMXFvLmet6bPhbcktY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gxZ0nicrjFY6j9AYM+POfkfJscGG0Y6W8XNTVuGvspBoH4cgv68pEXcvDlNCw8otO
         Hk/QhQ8L2jeiflF0k7ZW8yIWQBj4dP+s2sFbbV+jHg5qmRnGuj6j+BC3NBo23WjX5E
         JSECn+/0hSHjpUSAInyNoaXSOxJTUPs/RqHZNTIw5k5wvWgeU7u9l28Mkby1B6ZZGo
         hTcRqxYlRQsOyQYcNW15GdYKVQPoeDicdqGlugn1VW/b+TgJ75FIslyO7OZ7URsywb
         IxoUKpNxdWFxk0Z4d+lenNwXa90YBIuA92gE5OtxVaDNGP2Vh0aniz1jptqJVpd0er
         w9nd5/qYhRbIQ==
Message-ID: <c9348be9-7b9e-ebf8-b787-e6b3e0724b4a@kernel.org>
Date:   Sat, 22 Apr 2023 07:07:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers/ata: Improve performance and readability
To:     Yahu Gao <yahu.gao@outlook.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yahu Gao <gaoyh12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
References: <OS3P286MB06322266ED2913AF0F6172219E609@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <OS3P286MB06322266ED2913AF0F6172219E609@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 21:54, Yahu Gao wrote:
> From: Yahu Gao <gaoyh12@lenovo.com>
> 

The patch title should start with:

ata: libata-core: ...

And let's be honest here: this is not the hot path and you are optimizing a
single "if" condition for a series of commands that will take 10s of ms to
execute. So this is *not* about performance. So update the patch title please.

> Replace conditions of avoid issuing [P]IDENTIFY to PMP.
> 
> Reviewed-by: Jiwei Sun <sunjw10@lenovo.com>
> Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 14c17c3bda4e..53f65d751189 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>  		return -ENODEV;
>  
>  	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
> -	if (ata_class_enabled(new_class) &&
> -	    new_class != ATA_DEV_ATA &&
> -	    new_class != ATA_DEV_ATAPI &&
> -	    new_class != ATA_DEV_ZAC &&
> -	    new_class != ATA_DEV_SEMB) {
> +	if (new_class == ATA_DEV_PMP) {

Using a switch-case here may actually make things even more readable.

>  		ata_dev_info(dev, "class mismatch %u != %u\n",
>  			     dev->class, new_class);
>  		rc = -ENODEV;

