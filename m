Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E916CF96A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC3DEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC3DEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:04:30 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6395240;
        Wed, 29 Mar 2023 20:04:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U34NOL049681;
        Wed, 29 Mar 2023 22:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680145463;
        bh=rwgY+brqpxleHmcpDlVKMBclpHE9SNEizgk3yrgzpDo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QX6V0Cs+IC/t67bt0ySHYpoyuLEqHOM9duE1iM9Zk3Y3Uc+cpla4T9m615pQmfAN9
         2DunSTNclIXIBbUJbvvYKmrVJ0wETViQ/01X7XuSo5HsreQlqbn8+DV3cgzyV2xW2G
         3oYk8PEgGrG1MhHVdab3Is9XPUK1ZVoJ+5qYHGhs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U34NSG015551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 22:04:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 22:04:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 22:04:22 -0500
Received: from [172.24.156.204] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U34JQO012021;
        Wed, 29 Mar 2023 22:04:20 -0500
Message-ID: <48d7ba60-aa7b-8d93-fcf0-c7e64908e9f5@ti.com>
Date:   Thu, 30 Mar 2023 08:34:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/2] gpio: davinci: Do not clear the bank intr enable
 bit in save_context
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dhruva Gole <d-gole@ti.com>
CC:     Vibhore Vardhan <vibhore@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vignesh <vigneshr@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Devarsh Thakkar <devarsht@ti.com>
References: <20230323122910.991148-1-d-gole@ti.com>
 <CACRpkdY_rhe69Y4AbEp8iws1fpL0bUkP5iBMN68EB+wxhFyHTw@mail.gmail.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <CACRpkdY_rhe69Y4AbEp8iws1fpL0bUkP5iBMN68EB+wxhFyHTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2023 6:59 PM, Linus Walleij wrote:
> On Thu, Mar 23, 2023 at 1:29 PM Dhruva Gole <d-gole@ti.com> wrote:
> 
>> The interrupt enable bits might be set if we want to use the GPIO as
>> wakeup source. Clearing this will mean disabling of interrupts in the GPIO
>> banks that we may want to wakeup from.
>> Thus remove the line that was clearing this bit from the driver's save
>> context function.
>>
>> Fixes: 0651a730924b ("gpio: davinci: Add support for system suspend/resume PM")
>> Cc: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> 
> Looks like the right solution to me.
> I'm a bit surprised given how long we have had this driver.
> I suppose people have used out-of-tree patches for suspend/resume. :(
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Yours,
> Linus Walleij
