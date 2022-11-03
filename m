Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF426174AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKCC7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKCC7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:59:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB313F81;
        Wed,  2 Nov 2022 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pk3w6SZMsRN6aHMzBaFyAO49guYyOVrTibppLnxxDjc=; b=b6H1NDh/DSP4sjeyIf6an/0Khq
        HZA4u4E9fMZKjNAgfmPxzeJmkU04kec57kC7V09l2Cu1bwifXuejWj2LE6z+hgd7n2kBjLFXlr6yE
        CVzYswBmxofVReGR8IF+pIBe9RQeahQhGHxH52t/Kt83eLf5I0an5XOA/hecllCNAaW0K2ZwopROx
        8KjFgiJJ3QWxm9FYLrisQ0ktwW5jXvt3KM2oEea+yCGd1zd+rvfxJWRxYlmgaCbh3DiJOuMhG2RX1
        ghBgDdHrUSmG9193iQLLGyiaGaOewmi5hs/wJ1ldtRy7kyQj7Z/7LmQ0Kijwyazo3WVjlYnYfZupu
        GwDrK7Lg==;
Received: from [2601:1c2:d80:3110:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqQRe-00FiCE-Qx; Thu, 03 Nov 2022 02:59:06 +0000
Message-ID: <f699bbba-69e6-2e62-98ed-0482f4c9a900@infradead.org>
Date:   Wed, 2 Nov 2022 19:59:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] hwmon: (amc6821) Fix unsigned expression compared with
 zero
Content-Language: en-US
To:     wangkailong@jari.cn, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1872639a.89.1843b5106aa.Coremail.wangkailong@jari.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1872639a.89.1843b5106aa.Coremail.wangkailong@jari.cn>
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



On 11/2/22 19:27, wangkailong@jari.cn wrote:
> Fix the following coccicheck warning:
> 
> drivers/hwmon/amc6821.c:215: WARNING: Unsigned expression compared
> with zero: reg > 0
> drivers/hwmon/amc6821.c:228: WARNING: Unsigned expression compared
> with zero: reg > 0
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Hm. IDGI. What's wrong with comparing an unsigned value to > 0?
I mean, it could be == 0 or > 0.
Please explain.

> ---
>  drivers/hwmon/amc6821.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 3bfd12ff4b3c..1f5382f8d52b 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -166,7 +166,7 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
>  	struct amc6821_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	int timeout = HZ;
> -	u8 reg;
> +	int reg;
>  	int i;
>  
>  	mutex_lock(&data->update_lock);

-- 
~Randy
