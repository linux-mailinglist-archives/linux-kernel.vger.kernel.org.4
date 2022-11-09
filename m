Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8F622866
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKIKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKIKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:25:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3E12635;
        Wed,  9 Nov 2022 02:25:14 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6h183jKCz15MSf;
        Wed,  9 Nov 2022 18:25:00 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 18:25:12 +0800
Message-ID: <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
Date:   Wed, 9 Nov 2022 18:25:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
To:     Oleh Kravchenko <oleg@kaa.org.ua>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
 <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/9 17:39, Oleh Kravchenko 写道:
> Hello all!
>
>> 9 лист. 2022 р. о 10:48 Wang Yufen <wangyufen@huawei.com> написав(ла):
>>
>> When non-devm resources are allocated they mustn't be followed by devm
>> allocations, otherwise it will break the tear down ordering and might
>> lead to crashes or other bugs during ->remove() stage. Fix this by
>> wrapping mutex_destroy() call with devm_add_action_or_reset().
>>
>> Fixes: fc19967bcb8f ("leds: add LED driver for EL15203000 board")
>> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> ---
>> drivers/leds/leds-el15203000.c | 18 +++++++++++-------
>> 1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
>> index 7e7b617..9be934e 100644
>> --- a/drivers/leds/leds-el15203000.c
>> +++ b/drivers/leds/leds-el15203000.c
>> @@ -287,10 +287,16 @@ static int el15203000_probe_dt(struct el15203000 *priv)
>> return ret;
>> }
>>
>> +static void el15203000_mutex_destroy(void *lock)
>> +{
>> + mutex_destroy(lock);
>> +}
>> +
>> static int el15203000_probe(struct spi_device *spi)
>> {
>> struct el15203000 *priv;
>> size_t count;
>> + int ret;
>>
>> count = device_get_child_node_count(&spi->dev);
>> if (!count) {
>> @@ -312,15 +318,14 @@ static int el15203000_probe(struct spi_device *spi)
>>
>> spi_set_drvdata(spi, priv);
>>
>> + ret = devm_add_action_or_reset(&spi->dev, el15203000_mutex_destroy,
>> +       &priv->lock);
>> + if (ret)
>> + return ret;
>> +
>> return el15203000_probe_dt(priv);
>> }
>>
>> -static void el15203000_remove(struct spi_device *spi)
> Is remove() callback from struct spi_driver deprecated?

It is not that remove() callback is deprecated,
it's that after wrapping mutex_destroy() call with devm_add_action_or_reset(),
remove() callback is unnecessary here.

>
>> -{
>> - struct el15203000 *priv = spi_get_drvdata(spi);
>> -
>> - mutex_destroy(&priv->lock);
>> -}
>>
>> static const struct of_device_id el15203000_dt_ids[] = {
>> { .compatible = "crane,el15203000", },
>> @@ -331,7 +336,6 @@ static void el15203000_remove(struct spi_device *spi)
>>
>> static struct spi_driver el15203000_driver = {
>> .probe = el15203000_probe,
>> - .remove = el15203000_remove,
>> .driver = {
>> .name = KBUILD_MODNAME,
>> .of_match_table = el15203000_dt_ids,
>> -- 
>> 1.8.3.1
>>
>
