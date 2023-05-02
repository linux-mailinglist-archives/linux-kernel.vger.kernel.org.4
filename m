Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC16F4435
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjEBMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjEBMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:49:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3D5252;
        Tue,  2 May 2023 05:49:52 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 837F46602121;
        Tue,  2 May 2023 13:49:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683031791;
        bh=1SBHvxpiiP3vO8FDcUxSdgWcAeK19kTJhEfXoSg3Bz8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lVX3TX5nOP8T7DAc8DnTniZmRwQkSATanSOambI0L6/HJZCEogsIFtChW2g8t24bU
         8KHdn8iVUlYv9kBuDsz0gI1UzjMBwHtUsvO+mhG5O+5g+aZnJNXJssb6WiPYtN47Rm
         f0jJjslUabz66qmeaGQgvzakgmbGyIq+tRd2BTaaaV2Pb/jynGbtfzOQm7bCV9mZMh
         /sDwpb07Ht05krpJVuU8BW4Jyk4Pey1OoFD/dDTVyefXM+0xA3Ehq4FG484w3MlLxj
         cGWVHbZh+SvUHODfwkwJbGf2nvOORl6R+nVjv54/gBNzHRTDpawHaL6KKRponweb6J
         Sm9+7MvfEGnAg==
Message-ID: <70d71afc-5191-2995-9975-7a2871c226aa@collabora.com>
Date:   Tue, 2 May 2023 15:49:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/8] nvmem: rockchip-otp: Add clocks and reg_read to
 rockchip_data
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-4-cristian.ciocaltea@collabora.com>
 <6064284.AJdgDx1Vlc@diego>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <6064284.AJdgDx1Vlc@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 11:47, Heiko Stübner wrote:
> Am Montag, 1. Mai 2023, 10:43:55 CEST schrieb Cristian Ciocaltea:
>> In preparation to support new Rockchip OTP memory devices with different
>> clock configurations and register layout, extend rockchip_data struct
>> with the related members: clocks, num_clks, reg_read.
>>
>> Additionally, to avoid managing redundant driver data, drop num_clks
>> member from rockchip_otp struct and update all references to point to
>> the equivalent member in rockchip_data.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/nvmem/rockchip-otp.c | 79 ++++++++++++++++++++++--------------
>>  1 file changed, 49 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
>> index 9f53bcce2f87..a5b234e60735 100644
>> --- a/drivers/nvmem/rockchip-otp.c
>> +++ b/drivers/nvmem/rockchip-otp.c
>> @@ -54,21 +54,19 @@
>>  
>>  #define OTPC_TIMEOUT			10000
>>  
>> +struct rockchip_data {
>> +	int size;
>> +	const char * const *clocks;
>> +	int num_clks;
> 
> nit: might be nice to use either "clocks" or "clks" as part for both names

Indeed, will handle this in v2.

> other than that
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks,
Cristian
