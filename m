Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE57635A99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiKWKxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiKWKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:53:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE73EA101
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669200057; x=1700736057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DK+WPftXBrx+r25mWGDlmADzJFlk9VgO71LC1Vr139U=;
  b=Ow2Mif1ZhfL6CLCO8r0UOussZKoCwvEqLFFTL1F/IzbZAn7f5WczGfww
   esvCeya0m02rkldiAhLHAD3lF3C4oVJuy2mUp7ReCSd3WaAo2/V6gZt7A
   RqfhyHKx3wKDtp8BI3pH6klj4R+GKrKRIyXkw7RD2u07Z9cFGuzGtj80l
   iHMloDW9N1g/wrBw8YfJzJmFWGXmNVeg+bdEcwVvc4GvMfV2A9TfvzEDc
   lJsA5HlZ8cDQDJ1L6+RRghmrhCZsk8/580iQREGQN0AwDs0uoBTFkSGxm
   xCEiNN9/e0/8RDDg+iqusPabBYAojJBM9fmJfhiJIODulYmNQS/2rnVd/
   w==;
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="201087559"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 03:40:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 03:40:56 -0700
Received: from [10.12.67.44] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 03:40:54 -0700
Message-ID: <83198642-2ef7-a12a-2ad4-5839b465c085@microchip.com>
Date:   Wed, 23 Nov 2022 11:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
To:     Peter Rosin <peda@axentia.se>, <Claudiu.Beznea@microchip.com>,
        <clement.leger@bootlin.com>, <regressions@leemhuis.info>
CC:     <alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
References: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
 <075d8c0f-5448-73aa-bd3f-0d4e1216e87f@leemhuis.info>
 <20221122181452.6a386296@fixe.home>
 <a961e0a1-5373-e2e0-3acb-7ef3cc32d846@microchip.com>
 <f3ee38ad-61b0-1069-9000-4d125d3bfa25@axentia.se>
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <f3ee38ad-61b0-1069-9000-4d125d3bfa25@axentia.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 at 09:38, Peter Rosin wrote:
> Hi!
> 
> 2022-11-23 at 08:19, Claudiu.Beznea@microchip.com wrote:
>> On 22.11.2022 19:14, Clément Léger wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Le Tue, 22 Nov 2022 16:13:40 +0100,
>>> Thorsten Leemhuis <regressions@leemhuis.info> a écrit :
>>>
>>>> Hi, this is your Linux kernel regression tracker.
>>>>
>>>> On 12.11.22 16:40, Peter Rosin wrote:
>>>>> The L2 cache is present on the newer SAMA5D2 and SAMA5D4 families, but
>>>>> apparently not for the older SAMA5D3. At least not always.
>>
>> Peter, what do you mean by "at least not always" here? Are you talking
>> about the OUTER_CACHE flag?
> 
> I'm not familiar with all options for L2 caching. I was just being cautious
> to not exclude the possibility that there could be some variation within
> the SAMA5D3 series (I'm on SAMA5D31) or with an external L2 cache or
> something such. If there's simply no possible way to have an L2 cache on
> any SAMA5D3, feel free to edit that "At least not always" out while you
> commit.

I confirm that there is no L2 cache in any variant of SAMA5D3.

[..]

Thanks, best regards,
   Nicolas
-- 
Nicolas Ferre

