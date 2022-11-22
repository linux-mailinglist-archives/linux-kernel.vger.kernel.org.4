Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D5634346
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiKVSHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKVSHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:07:17 -0500
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679170A2E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:07:15 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id xXfroj0BLM75kxXfroW5jJ; Tue, 22 Nov 2022 19:07:14 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Nov 2022 19:07:14 +0100
X-ME-IP: 86.243.100.34
Message-ID: <68d4ef1d-ce51-133f-3974-613da458ea40@wanadoo.fr>
Date:   Tue, 22 Nov 2022 19:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] libnvdimm: Add check for nd_dax_alloc
Content-Language: fr
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221122023350.29128-1-jiasheng@iscas.ac.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221122023350.29128-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/11/2022 à 03:33, Jiasheng Jiang a écrit :
> As the nd_dax_alloc may return NULL pointer,
> it should be better to add check for the return
> value, as same as the one in nd_dax_create().
> 
> Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/nvdimm/dax_devs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
> index 7f4a9d28b670..9efe62b95dd8 100644
> --- a/drivers/nvdimm/dax_devs.c
> +++ b/drivers/nvdimm/dax_devs.c
> @@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
>   
>   	nvdimm_bus_lock(&ndns->dev);
>   	nd_dax = nd_dax_alloc(nd_region);
> +	if (!nd_dax)
> +		return -ENOMEM;
>   	nd_pfn = &nd_dax->nd_pfn;
>   	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
>   	nvdimm_bus_unlock(&ndns->dev);

Hi,

Based on 6.1-rc6 ([1]), the error handling is already in place just 
after the nvdimm_bus_unlock() call.

CJ

[1]: 
https://elixir.bootlin.com/linux/v6.1-rc6/source/drivers/nvdimm/dax_devs.c#L112
