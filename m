Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA066E0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAQOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjAQOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:38:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33E7ED4;
        Tue, 17 Jan 2023 06:38:30 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF2E16602DAC;
        Tue, 17 Jan 2023 14:38:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673966309;
        bh=U1cq0bP5JsCDIk97Em9SgXM5KQV/SCClBx5b7O26txs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=MMPd0vtyDb0eRexb3459kmrFfAJLRHTImJPdAbCDHb6Xt3ii+TtPheLzthHXXjAc2
         chAGQPGd2mbgZKBs0JqP7rDhZ0btn5uDImXr0kxtyIZ0eaOE4YcknI3ME6uuJJVp7/
         sSd1z/pQNkuOEsaxHKKfGkLWvK0B1xvRIPEq0Z1Sa0YA7vh0Z09trrR/kRNuZbu+CO
         PAiogXOd1fSTKt89m4RzarARXWaY/EGp4jkgDuu4FdhpwCk4F/7UC1Lzeda6nTKEWo
         zXmdlcAOLc+B4tVVVUeCsKYiXdN8XBqPbAF27XRq8n3+XmDo3ODeeOtkQ1lsLA7kAR
         Ft+41n4nBg3bg==
Message-ID: <20549051-a468-45c4-316e-c1671a9a0034@collabora.com>
Date:   Tue, 17 Jan 2023 15:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 2/2] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230116155545.101391-1-jonathanh@nvidia.com>
 <20230116155545.101391-2-jonathanh@nvidia.com>
 <4553efe5-6c8a-4421-b125-ffa97d51b88e@collabora.com>
In-Reply-To: <4553efe5-6c8a-4421-b125-ffa97d51b88e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

W dniu 17.01.2023 o 15:13, Andrzej Pietrasiewicz pisze:
> Hi,
> 
> W dniu 16.01.2023 o 16:55, Jon Hunter pisze:
>> The function gether_setup_name_default() is called by various USB
>> ethernet gadget drivers. This function always generates the MAC address
>> for the ethernet gadget device and always prints a warning when
>> generating the MAC address. Given that these messages are expected, make
>> these debug prints instead of warnings.

Actually, I have second thoughts about this commit message.
If the messages were expected, why would you change them?

I think that just as in PATCH V2 1/1, there's an implicit context required
to understand your commit message: it answers the question "why don't we
just remove these messages altogether?" Answer: "because they might be expected
by some guys, so let's keep them".

IMO, what _is_ expected is random selection of addresses. So, something on
the lines of this would look better to me:

"Randomly selecting host and device MAC addresses is a proper and expected
default behavior. A properly working driver should be silent, so don't warn
the user about default MAC addresses selection happening and convert the
warnings into debug messages."

>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

With the above taken into account I uphold my R-b tag.

Andrzej

> 
>> ---
>> V1 -> V2: Changed print to debug instead of info.
>>
>>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_ether.c 
>> b/drivers/usb/gadget/function/u_ether.c
>> index be8e7b448933..8feb40e38137 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char 
>> *netname)
>>       snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>>       eth_random_addr(dev->dev_mac);
>> -    pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
>> +    pr_debug("using random self ethernet address %pM\n", dev->dev_mac);
>>       /* by default we always have a random MAC address */
>>       net->addr_assign_type = NET_ADDR_RANDOM;
>>       eth_random_addr(dev->host_mac);
>> -    pr_warn("using random host ethernet address %pM\n", dev->host_mac);
>> +    pr_debug("using random host ethernet address %pM\n", dev->host_mac);
>>       net->netdev_ops = &eth_netdev_ops;
> 

