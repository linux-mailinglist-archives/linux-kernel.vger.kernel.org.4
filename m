Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA473BBED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjFWPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjFWPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:43:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676CD2116;
        Fri, 23 Jun 2023 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687534982; x=1719070982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KO0h77PuTchO9uCFqgrPpHPzCVS5dircgtswxrlN9yY=;
  b=IuCUALZTmOCzFNk8h7jLg/sb0vWTvFG6JWSrIETq9euqOWxHxAcAEBne
   ZHQ8hM77xu3uqiTipv/5xGKAKTAXYQDHJIV+g3HuIf+wZPLPDPHd5eetf
   p8Mev3hUrFK9w/K+HfhgLbBb6jI8anSaSaEVRr8XBSgz8/5iW7O57a3IH
   Hj1lOoCXKAdOnL0ibFnIRHBxhecuQ1Gom0k3GBSC51rbQuOXlVYClADf2
   gQZ9OsO/ZoaukntYl0e9cfkebJM7jVDMZyaPF/wljU7yKQXaMm3oWZ82d
   nJ1Rmk8pQGnT0hnhK5H5lanJYKLWWnBVzJg7T0Ta+frKoeiXJZIJzmcgu
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="220173939"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 08:43:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 08:43:01 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 08:42:59 -0700
Message-ID: <2825f1ab-5d53-6912-f5ba-0bff9709e387@microchip.com>
Date:   Fri, 23 Jun 2023 17:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: net: macb: sparse warning fixes
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Ben Dooks <ben.dooks@codethink.co.uk>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
 <fe335672-6b8d-4fb0-81ce-34f029891d39@lunn.ch>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <fe335672-6b8d-4fb0-81ce-34f029891d39@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 at 17:38, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Jun 23, 2023 at 03:16:23PM +0200, Nicolas Ferre wrote:
>> Hi Ben,
>>
>> On 22/06/2023 at 15:05, Ben Dooks wrote:
>>> These are 3 hopefully easy patches for fixing sparse errors due to
>>> endian-ness warnings. There are still some left, but there are not
>>> as easy as they mix host and network fields together.
>>>
>>> For example, gem_prog_cmp_regs() has two u32 variables that it does
>>> bitfield manipulation on for the tcp ports and these are __be16 into
>>> u32, so not sure how these are meant to be changed. I've also no hardware
>>> to test on, so even if these did get changed then I can't check if it is
>>> working pre/post change.
>>
>> Do you know if there could be any impact on performance (even if limited)?
> 
> Hi Nicolas
> 
> This is inside a netdev_dbg(). So 99% of the time it is compiled
> out. The other 1% of the time, your 115200 baud serial port is
> probably the bottleneck, not an endianness swap.

Yeah, sure thing: I was not talking about the 3/3 patch where, yes, 
indeed it doesn't have an importance.

Others in gem_enable_flow_filters() and gem_prog_cmp_regs() look like 
they are away from hot path anyway, so here again probably no impact.

Regards,
   Nicolas

-- 
Nicolas Ferre

