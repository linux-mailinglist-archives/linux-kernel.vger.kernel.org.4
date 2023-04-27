Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C86F0C31
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbjD0S6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjD0S6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8740C4;
        Thu, 27 Apr 2023 11:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68EB63EEB;
        Thu, 27 Apr 2023 18:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833B6C433EF;
        Thu, 27 Apr 2023 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682621930;
        bh=SVsj2YP3hE7lt1kgMPLknB0++p0vIzw5HpKUgiTODzk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cScbz/eRiBMpqKqFxaAvJvqmx5L/N4qkJIeM7wOPnP6GP5hT7jh7FCVez20ehZmNB
         mQIwInBOiEk8YBJc22sWm3/EqKpaqceG9ah7UvFbVBAwbmHlrDNQ5hzxE/OcdT/5Iw
         BRrFc15iVsaqUnobe/cQSKl7Pb8Fto0d+8hiZoE4PNOdT5IxzQzAoZlfE6zTB8J7xg
         qimPzSSGrrColVxmB7IBMqkpr1t9YQ7AxnId53iZCFXNOZK5qUn8GiqjVcRBYOiqf6
         ak4+j7ZK7expzvbPww6mii4vW0e045l4Gv+Vjl8peI1u4rE9kwgqU/G+aI21oLQNUf
         WSNRYI4EM34Gg==
Message-ID: <1fd47550-ba39-9755-e0ce-8c377cecb2c4@kernel.org>
Date:   Thu, 27 Apr 2023 13:58:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in
 probe
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Richard Gong <richard.gong@intel.com>
Cc:     Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <5f9a8cb4-5a4f-460b-9cdc-2fae6c5b7922@kili.mountain>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <5f9a8cb4-5a4f-460b-9cdc-2fae6c5b7922@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 09:27, Dan Carpenter wrote:
> The svc_create_memory_pool() function returns error pointers.  It never
> returns NULL.  Fix the check.
> 
> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/firmware/stratix10-svc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index bde1f543f529..80f4e2d14e04 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1133,8 +1133,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	genpool = svc_create_memory_pool(pdev, sh_memory);
> -	if (!genpool)
> -		return -ENOMEM;
> +	if (IS_ERR(genpool))
> +		return PTR_ERR(genpool);
>   
>   	/* allocate service controller and supporting channel */
>   	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
