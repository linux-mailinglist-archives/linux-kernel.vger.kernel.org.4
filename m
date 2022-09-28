Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9485ED565
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiI1Gvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiI1GvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956A01F5A27;
        Tue, 27 Sep 2022 23:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9FE61C2C;
        Wed, 28 Sep 2022 06:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85997C433D6;
        Wed, 28 Sep 2022 06:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664347756;
        bh=Nk3ynkusqGap+x1MJ8tX+7TIQxb2yUJieA0dMDPZhZ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MpowEj9ilTx3o+TQ1A4iv3yMuus1l3BClYGalYJ95fNJkA/gOqcnPeg7lXTGNEQtT
         /LC/q/QbSarTrSQQuTRBG6gxXRNe0dIfNadWf+6Vlb6MuyqBm5zy4ALIpfYotK4a4Z
         RDNz3vOkKcGUSuzUaMLGQQmwGGYFXlYo+D3VeIwA2/OiDkxS4WJUSwHkl7kcoYDONj
         cR6V82LEaFE/IRTNXYxFFuXYd4SCh5YEkAfmuQiEgfaCSzeYoi+3jEZAnrP9ghx6yD
         27YdwS7z282avzIXwQGCXd3YFaY2tvBRrbX5IicI3PQcnPiJfSQcqM8L02bBP6g/3x
         6vBFLMBK+1KkQ==
Message-ID: <cd5455e9-b9ea-9376-1440-3dbf790d4c24@kernel.org>
Date:   Wed, 28 Sep 2022 09:49:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: cdns3: remove dead code
Content-Language: en-US
To:     Pawel Laszczak <pawell@cadence.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Peter Chen <peter.chen@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220926135922.24541-1-dzm91@hust.edu.cn>
 <BYAPR07MB5381FCC10ABD4F92E47CF6D9DD549@BYAPR07MB5381.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <BYAPR07MB5381FCC10ABD4F92E47CF6D9DD549@BYAPR07MB5381.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pawel,

On 28/09/2022 09:40, Pawel Laszczak wrote:
>>
>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>
>> Smatch reports the following error:
>>
>> drivers/usb/cdns3/cdns3-plat.c:113 cdns3_plat_probe() warn:
>> platform_get_irq() does not return zero
>>
>>From the document, platform_get_irq_byname_optional only returns
>> non-zero value, and negative value on failure.
>>
>> Fix this by removing the zero value checking.
>>
>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>> ---
>> drivers/usb/cdns3/cdns3-plat.c | 2 --
>> 1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
>> index dc068e940ed5..2bc5d094548b 100644
>> --- a/drivers/usb/cdns3/cdns3-plat.c
>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>> @@ -110,8 +110,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>> 	cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
>> 	if (cdns->wakeup_irq == -EPROBE_DEFER)
>> 		return cdns->wakeup_irq;
>> -	else if (cdns->wakeup_irq == 0)
>> -		return -EINVAL;
>>
> I think that here we should have:
> 	else if (cdns->wakeup_irq == -ENXIO)
> 		return -EINVAL;
>  because of function: 
> platform_get_irq_byname_optional -> __platform_get_irq_byname returns
> irq number (>0),  -EPROBE_DEFFER or -ENXIO

But this is changing functionality and should come as a new patch.

The original patch is correct as it doesn't change existing code
functionality.

> 
> 
> thanks
> Pawel
> 
>> 	if (cdns->wakeup_irq < 0) {
>> 		dev_dbg(dev, "couldn't get wakeup irq\n");
>> --
>> 2.35.1
> 

cheers,
-roger
