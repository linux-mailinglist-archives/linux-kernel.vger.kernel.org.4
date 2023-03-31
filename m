Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41786D1914
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCaHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjCaHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:53:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86232EB63
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C7BEB82CAC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B79FC433EF;
        Fri, 31 Mar 2023 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680249203;
        bh=8FH7mQ2u8+g8iflRXHsu0r4l7PSoNLbMnI2avjCa0Cw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FB/Lnnk6X8luI2tmvT8OyUFvyvISzOtCnXXbzJCegdjPVDnknHhKAc0Iek8rmnskJ
         wsH8OIk83JcnRxIfEuWN+5F9YHfId1hcp2022hznAQGqmsliC1w+CE/aXMQ7eW6g9Z
         BshtmaZEn1z7Ug/bB7Xuor+vZst9wBP1bS3HQkPhLzhGzfdAOZJTWI1oL7LEcphpwc
         ePtQgP+Twia+u2xX8127gnMAZA6wxtikAc/KqwLKPEaEfzTb4QN7oU79eWet17XvhN
         NSvt/33lrTN22G3mN2bxRyMRsZbjICKGAVvEy734zEqpEe685N6RAkp+hejr38xkq/
         7QbBjknPNW2qw==
Message-ID: <10ad789e-3dcc-0c74-5426-87f4a53d6fd0@kernel.org>
Date:   Fri, 31 Mar 2023 10:53:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in
 J784S4
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
References: <20230331062521.529005-1-s-vadapalli@ti.com>
 <20230331062521.529005-2-s-vadapalli@ti.com>
 <cfcdb25b-5426-2532-ab8c-224a5e33baf3@kernel.org>
 <b5e426fb-8af9-c372-1076-63194e4de781@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <b5e426fb-8af9-c372-1076-63194e4de781@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2023 10:49, Siddharth Vadapalli wrote:
> Hello Roger,
> 
> On 31/03/23 13:15, Roger Quadros wrote:
>>
>>
>> On 31/03/2023 09:25, Siddharth Vadapalli wrote:
>>> Each of the CPSW9G ports in TI's J784S4 SoC support modes such as QSGMII.
>>>
>>> Add a new compatible for it and allow the usage of "ti,qsgmii-main-ports"
>>> property for J784S4.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>  drivers/phy/ti/phy-gmii-sel.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
>>> index c87118cb2af9..fba5c0c0771c 100644
>>> --- a/drivers/phy/ti/phy-gmii-sel.c
>>> +++ b/drivers/phy/ti/phy-gmii-sel.c
>>> @@ -235,6 +235,15 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
>>>  	.num_qsgmii_main_ports = 2,
>>>  };
>>>  
>>> +static const
>>> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j784s4 = {
>>
>> Please make it into one line
> 
> I was simply following the convention used for other SoC data structs in the
> same file. Please let me know why this has to be an exception and I will post
> the v2 series with the change accordingly.

Not that much of a deal. ;)

Reviewed-by: Roger Quadros <rogerq@kernel.org>
