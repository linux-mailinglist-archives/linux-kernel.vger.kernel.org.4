Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE1624353
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiKJNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKJNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:35:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF50BD3;
        Thu, 10 Nov 2022 05:35:25 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7N6522QKzqSH4;
        Thu, 10 Nov 2022 21:31:41 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:35:22 +0800
Subject: Re: [PATCH v2] phy: usb: sunplus: Fix memleak in update_disc_vol()
To:     Vinod Koul <vkoul@kernel.org>
CC:     <vincent.sunplus@gmail.com>, <kishon@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221108073430.29172-1-yuehaibing@huawei.com>
 <Y2yiGadmdSz/Ml3i@matsya>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <36697610-8cea-cebe-9aa0-1da15cc658b6@huawei.com>
Date:   Thu, 10 Nov 2022 21:35:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <Y2yiGadmdSz/Ml3i@matsya>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/10 15:02, Vinod Koul wrote:
> On 08-11-22, 15:34, YueHaibing wrote:
>> 'otp_v' is allocated in nvmem_cell_read(), it should be freed
>> before return.
> 
> Right!
> 
>>
>> Fixes: 99d9ccd97385 ("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: free otp_v before return
>> ---
>>  drivers/phy/sunplus/phy-sunplus-usb2.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
>> index e827b79f6d49..62d5cb5c7c9d 100644
>> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
>> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
>> @@ -105,6 +105,9 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>>  	val = (val & ~J_DISC) | set;
>>  	writel(val, usbphy->phy_regs + CONFIG7);
>>  
>> +	if (!IS_ERR(otp_v))
>> +		kfree(otp_v);
> 
> But that is not the case!

Do you think I should changed the commit log like this:

'otp_v' is allocated by nvmem_cell_read(), it should be freed
after usage in update_disc_vol().


> 
