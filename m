Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB86C52AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCVRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCVRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:40:19 -0400
X-Greylist: delayed 1669 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 10:40:18 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCED310;
        Wed, 22 Mar 2023 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=j4kDtes5yQEhSaRkdjJ6fUBQBcvH3mVXdZYGKrFGxjk=; b=Um6Hi4/teqDwXcPpVqXZfqL9wl
        rh9z89rWSr1ADTHi6PGRDt/QxiPhbq7Iq8QI9A2wBV8PFwp42Io8KM42i52LXmGiOwXbuZ6iIFLDt
        M9n2s3vJvqLDUVMhvctvvzqw04J8y8PpWQsnuSVQjsYjdQ43HTNd+K9Ii/PfSBRLnYuctDrXyCuTt
        oNhxRsPJMyYDKKv5m6r9ONErfTbEWJiF4+It3HJ/sEYr+oxhnoBylIDGVDD65Iei9iZCX4quZXRwO
        6eAvWcHmPUAHoL1b5h033pm/YwiF9dOWu5WdmPNLGh/GErdDP0sMHJv1KlbMhn+RVnrObJLIJC3S1
        Q6AtSM0g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pf1jJ-000O2z-6W; Wed, 22 Mar 2023 17:54:29 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pf1jI-000RWx-Qu; Wed, 22 Mar 2023 17:54:28 +0100
Message-ID: <997596d9-dc80-4aff-2875-869a54442e36@metafoo.de>
Date:   Wed, 22 Mar 2023 09:54:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mmc: jz4740: Use dev_err_probe()
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        ye.xingchen@zte.com.cn, ulf.hansson@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303221707010277273@zte.com.cn>
 <d91d6e3c-da8c-0601-0cd7-45bfe7c4ad50@gmail.com>
 <6aa6d80cb587c98dba5c04b47cd78f93bb3bafec.camel@crapouillou.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <6aa6d80cb587c98dba5c04b47cd78f93bb3bafec.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26851/Wed Mar 22 08:22:49 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 02:25, Paul Cercueil wrote:
> Le mercredi 22 mars 2023 à 12:18 +0300, Sergei Shtylyov a écrit :
>> On 3/22/23 12:07 PM, ye.xingchen@zte.com.cn wrote:
>>
>>> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>>>
>>> Replace the open-code with dev_err_probe() to simplify the code.
>>>
>>> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
>>> ---
>>>   drivers/mmc/host/jz4740_mmc.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/jz4740_mmc.c
>>> b/drivers/mmc/host/jz4740_mmc.c
>>> index 698450afa7bb..a6ad03b24add 100644
>>> --- a/drivers/mmc/host/jz4740_mmc.c
>>> +++ b/drivers/mmc/host/jz4740_mmc.c
>>> @@ -232,10 +232,7 @@ static int
>>> jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
>>>          if (!IS_ERR(host->dma_tx))
>>>                  return 0;
>>>
>>> -       if (PTR_ERR(host->dma_tx) != -ENODEV) {
>>> -               dev_err(dev, "Failed to get dma tx-rx channel\n");
>>> -               return PTR_ERR(host->dma_tx);
>>> -       }
>>> +       return dev_err_probe(dev, PTR_ERR(host->dma_tx), "Failed to
>>> get dma tx-rx channel\n");
>>     I'm afraid this makes the following code unreachable...
> Also, this is not a probe(), so I don't see a point of using
> dev_err_probe() here.
The function is only called from probe(), I think it makes sense to use 
dev_err_probe() here.


