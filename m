Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08C65441E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiLVPTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:19:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048D335;
        Thu, 22 Dec 2022 07:19:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B524EB81CB7;
        Thu, 22 Dec 2022 15:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A20AC433D2;
        Thu, 22 Dec 2022 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671722354;
        bh=unTLqCW294ZnziRAsuuEh/oxlIS4oUlm60//dw9SIC0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JHFTakD/nnQ1PpVS5ppaccSrB0w8EB04rF49hOcG0adJQrwwjnTPAQiPs47Hzn4Cn
         M1ek1myDBjkdK7fj7b8Sic/2IwZAJw5jcUOuF9EDfSxhRfzDnkSFE0igaDOAcPfjOx
         LXoBI+lxKPf/8pzRXD6WV6LK/SGO0CR8WwO3Cc+OUUCEaxrK40jSLxMjXqMYRznS8J
         qL8niByvNzeIHN+I56sXcs0KWt2IIcX/JTYAvFQI/rOmd3LxH/YxrJ+0/hCttk3kpC
         VFLgfkkLal7LOk5LJPkYxJ6lomlgH8xwEFlnb2D6RHYmCql8Jj5I4qcjvPIc7bQejy
         8WdXNj3xn4jlQ==
Message-ID: <f3ace6f0-12fb-8e97-5115-5511b4ffb223@kernel.org>
Date:   Thu, 22 Dec 2022 16:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 5/7] bus: stm32_sys_bus: add support for STM32MP15 and
 STM32MP13 system bus
Content-Language: en-US
To:     Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-6-gatien.chevallier@foss.st.com>
 <ed8aa4d3-9570-eb72-a7d4-3b690adc3a6d@kernel.org>
 <e2086a52-4db8-e247-43de-c78ffa479634@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e2086a52-4db8-e247-43de-c78ffa479634@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 15:30, Gatien CHEVALLIER wrote:
>>
>>> +	if (IS_ERR(mmio))
>>> +		return PTR_ERR(mmio);
>>> +
>>> +	pdata->sys_bus_base = mmio;
>>> +
>>> +	mdata = (struct stm32_sys_bus_match_data *)of_device_get_match_data(&pdev->dev);
>>
>> Why do you need the cast?
> 
> I do not :) TBH, mdata is not useful at all. Changing to directly assign 
> to pdata->pconf, that is now const there is no reason to modify it.

mdata should be const and then no need for cast.

> 
>>
>>> +	if (!mdata)
>>
>> Can you explain the case when this can actually happen? If it can, you
>> have bug in ID table.
> 
> No I cannot as the driver is probed. It is only a sanity check, I can 
> remove it for V3. However the function can return NULL... Would you 
> prefer an explicit check on NULL or a simple removal?

I propose to drop it. This simply cannot happen.

> 
>>
>>> +		return -EINVAL;
>>> +

Best regards,
Krzysztof

