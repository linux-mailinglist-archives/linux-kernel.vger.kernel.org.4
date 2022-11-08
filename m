Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4686209DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiKHHGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiKHHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:06:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456D2ED67;
        Mon,  7 Nov 2022 23:06:03 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5zdH2HdtzHvk2;
        Tue,  8 Nov 2022 15:05:23 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:05:46 +0800
Subject: Re: [PATCH] phy: usb: sunplus: Fix memleak in update_disc_vol()
To:     Greg KH <greg@kroah.com>
CC:     <vincent.sunplus@gmail.com>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221108061113.35964-1-yuehaibing@huawei.com>
 <Y2n5fhFq4ozEzlBL@kroah.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <44ebb350-fb5b-38f6-8950-98bc80963994@huawei.com>
Date:   Tue, 8 Nov 2022 15:05:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <Y2n5fhFq4ozEzlBL@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/11/8 14:38, Greg KH wrote:

> On Tue, Nov 08, 2022 at 02:11:13PM +0800, YueHaibing wrote:
>> 'otp_v' is allocated in nvmem_cell_read(), it should be freed
>> before return.
>>
>> Fixes: 99d9ccd97385 ("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/phy/sunplus/phy-sunplus-usb2.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
>> index e827b79f6d49..450cf8e6d7fb 100644
>> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
>> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
>> @@ -96,6 +96,7 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>>  		set = *(otp_v + 1);
>>  		set = (set << (sizeof(char) * 8)) | *otp_v;
>>  		set = (set >> usbphy->disc_vol_addr_off) & J_DISC;
>> +		kfree(otp_v);
>>  	}
>>  
>>  	if (IS_ERR(otp_v) || set == 0)
> How did you test this?
>
> Just by looking at this tiny diff, this seems to be wrong, please fix
> your tools and your review process to catch errors like this.

sorry,  I misread the code, will be more careful next time.

>
> thanks,
>
> greg k-h
> .
