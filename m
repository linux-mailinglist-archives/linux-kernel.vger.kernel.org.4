Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCAA73B89A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFWNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjFWNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:17:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC92944;
        Fri, 23 Jun 2023 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687526243; x=1719062243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dxzeWDMzY4Hn74R46d8Op9WFQlLjght93zTsTDis+rw=;
  b=gtnXuOOKJfxDIz1P6prmtBVVcbiwyLQ5ufw8054ssGwhfFnwKusU6U2C
   dlC96qrCd8TLi0o0iXo2vXDKFZF2HqTuRxuYieGgSPRUUv8Iw91D1+gLa
   9imUDYfN1dzYBQ5nj085qLAfKhCf1keQn1mBWLtuSR6yNpsnaV1fefqMW
   6AgdrTg9MaNAKoyjld/lJwT7q2P+Ub/lFzzEJbhUlCxwi/nofd9rJ1sSD
   BzZYDO5wlU0igW61H74c8dEGIEjPjJ+MYAz0eNv/IHQuhg3jzl6AQca5X
   5Fl70kXDa+RaNEfuYlT92k+kUDD6yJ8f3e9KFg/75ARS45yXORQAgsi1Y
   g==;
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="219484554"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 06:17:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 06:16:50 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 06:16:49 -0700
Message-ID: <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
Date:   Fri, 23 Jun 2023 15:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: net: macb: sparse warning fixes
Content-Language: en-US
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
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

Hi Ben,

On 22/06/2023 at 15:05, Ben Dooks wrote:
> These are 3 hopefully easy patches for fixing sparse errors due to
> endian-ness warnings. There are still some left, but there are not
> as easy as they mix host and network fields together.
> 
> For example, gem_prog_cmp_regs() has two u32 variables that it does
> bitfield manipulation on for the tcp ports and these are __be16 into
> u32, so not sure how these are meant to be changed. I've also no hardware
> to test on, so even if these did get changed then I can't check if it is
> working pre/post change.

Do you know if there could be any impact on performance (even if limited)?

Best regards,
   Nicolas

> Also gem_writel and gem_writel_n, it is not clear if both of these are
> meant to be host order or not.
> 
> Ben Dooks (3):
>    net: macb: check constant to define and fix __be32 warnings
>    net: macb: add port constant to fix __be16 warnings
>    net: macb: fix __be32 warnings in debug code
> 
>   drivers/net/ethernet/cadence/macb_main.c | 25 +++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)

-- 
Nicolas Ferre

