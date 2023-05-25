Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0B7117C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjEYUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjEYUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:00:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E722B95
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:00:37 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2H8UqmnigZO7A2H8UqejSu; Thu, 25 May 2023 22:00:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685044836;
        bh=Nn++8Gtv+O3RQJEDu5H3rgKwGw3s8JlnntA9IjlyTMI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KRMcaq3eKxGPDnANHauSBiLaw1EsdjNG32425HNmPXaWwYupyiGT8nkgmIZTIwR3L
         ZjZYywM2TvTPEvm4oXOgi55tmcGCX8UUJtOoiY6Yuma6kXfyinQucit7AtC5RXpRPV
         pOyzkHzu5OmsY0a5wuduCD6+yDNAj4dv/jOlUFtm5XfRugeRTaYHRoRmfiVt6pjUSr
         nQNEghRoLZiHOBrBHUBl4QkXWzmIdejBNADt4ZRlO3aRC6j1cuq43gJUCl8NpMFI0c
         YJ7P/ELhrJVqoKm+/EGmOzfWoU6CLHFHkVtr5CVdcox2XxZZ+QoTSfrGPiG9OUbA5Q
         JC86PF81cfjGg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 May 2023 22:00:36 +0200
X-ME-IP: 86.243.2.178
Message-ID: <381c7339-685c-8973-ecf2-5a34cd18cda3@wanadoo.fr>
Date:   Thu, 25 May 2023 22:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pinctrl:sunplus: Add check for kmalloc
Content-Language: fr, en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     andy.shevchenko@gmail.com,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
 <9f937bde-c908-4941-b65c-e4c303d3acae@kili.mountain>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9f937bde-c908-4941-b65c-e4c303d3acae@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/05/2023 à 21:19, Dan Carpenter a écrit :
> On Tue, May 23, 2023 at 10:05:49PM +0200, Christophe JAILLET wrote:
>> Should be looked at more carefully, but
>>    dt_to_map_one_config		(in /drivers/pinctrl/devicetree.c)
>>      .dt_node_to_map
>>        --> sppctl_dt_node_to_map
>>
>> Should dt_to_map_one_config() fail, pinctrl_dt_free_maps() is called
>> (see https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/pinctrl/devicetree.c#L281)
> 
> Thanks for this call tree, I don't have this file enabled in my build
> so it's not easy for me to find how sppctl_dt_node_to_map() was called.
> 
> drivers/pinctrl/devicetree.c
>     160                  dev_err(p->dev, "pctldev %s doesn't support DT\n",
>     161                          dev_name(pctldev->dev));
>     162                  return -ENODEV;
>     163          }
>     164          ret = ops->dt_node_to_map(pctldev, np_config, &map, &num_maps);
>                                                                ^^^^
> "map" isn't stored anywhere so it will be leaked.  I guess kmemleak
> already figured this out.
> 
>     165          if (ret < 0)
>     166                  return ret;
>     167          else if (num_maps == 0) {
>     168                  /*
> 

Hi, thanks Dan for sharing your PoV on this.

CJ

