Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC56F57A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjECMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:12:04 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 05:11:59 PDT
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4451BFC;
        Wed,  3 May 2023 05:11:59 -0700 (PDT)
Received: from [IPV6:2003:e9:d706:54a1:212b:c98b:d0c5:6c8c] (p200300e9d70654a1212bc98bd0c56c8c.dip0.t-ipconnect.de [IPv6:2003:e9:d706:54a1:212b:c98b:d0c5:6c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 82FFAC00AF;
        Wed,  3 May 2023 14:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1683115319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrY4np7MIEvKj3oth8g3qje83iXw5OFsZNJLsl8D7RQ=;
        b=uKEEkxzo4jZwwNqIjEPvwkWPHWvKHNyQL62sEHhuw8fTrst//3B4Jz7HPuLZ53cgZo8hzu
        kFT/KmpufWXNCH4OBKVSVBmBQ49Qt0/qnrmzQztaS0cVHrus38DsOwEkS87hsxtmyNtfdG
        rC03XUGSYEuo3/K+v8eMwq/i3AnFp0KnqeNsvEWkx0Y54BpS7SeltuaO3OyqIdCoh9wRFB
        pIx2GdUF2Ki/lnEcCfgOEwoXHdqHG472NOA0DccePOmMj7wshaWu4qMMavnYPVt84aAd4y
        m+qamR0+DUqmfDd2dAvYAAfLpj8uMGyepMzm6DNtwNX3r5ahAGzJKgzG71PkoQ==
Message-ID: <f5518a73-ebba-32a1-3c70-464c6d233760@datenfreihafen.org>
Date:   Wed, 3 May 2023 14:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ca8210: move to gpio descriptors
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-wpan@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20230126161737.2985704-1-arnd@kernel.org>
 <57e74219-d439-4d10-9bb5-53fe7b30b46f@app.fastmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <57e74219-d439-4d10-9bb5-53fe7b30b46f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd.

On 26.01.23 17:25, Arnd Bergmann wrote:
> On Thu, Jan 26, 2023, at 17:17, Arnd Bergmann wrote:
> 
>>   	if (ret) {
>> -		dev_crit(&spi->dev, "request_irq %d failed\n", pdata->irq_id);
>> -		gpiod_unexport(gpio_to_desc(pdata->gpio_irq));
>> -		gpio_free(pdata->gpio_irq);
>> +		dev_crit(&spi->dev, "request_irq %d failed\n", priv->irq_id);
>> +		gpiod_put(priv->gpio_irq);
>>   	}
> 
> I just realized that this bit depends on the "gpiolib: remove
> legacy gpio_export" patch I sent to the gpio mailing list earlier.
> 
> We can probably just defer this change until that is merged,
> or alternatively I can rebase this patch to avoid the
> dependency.

I think the gpiolib ependency should be merged now. Do you want to 
rebase this patch against latest? We had some other ca8210 changes 
coming in.

regards
Stefan Schmidt
