Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5696EBE35
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDWJN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDWJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 05:13:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB31FCC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 02:13:22 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q42Wt2yv7zndg5;
        Sun, 23 Apr 2023 17:09:30 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 17:13:18 +0800
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
To:     Richard Weinberger <richard@nod.at>
CC:     Yu Hao <yhao016@ucr.edu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <687864524.118195.1681799447034.JavaMail.zimbra@nod.at>
 <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
 <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com>
 <977347543.226888.1682011999468.JavaMail.zimbra@nod.at>
 <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com>
 <412779912.228444.1682023015809.JavaMail.zimbra@nod.at>
 <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com>
 <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <951e4cf7-a0ea-b3ec-931d-e6a394ddc2ab@huawei.com>
Date:   Sun, 23 Apr 2023 17:13:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/4/23 16:02, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>>> root@syzkaller:~# cat /proc/mtd
>>>> dev:    size   erasesize  name
>>>> mtd0: 00020000 00001000 “mtdram test device”
>>>
>>> Hmm, mtdram should be fine, erasesize is not zero.
>>>
>>
>> I guess the zero-erasesize mtd device is dynamically generated in
>> runtime, after looking through the code, I find erasesize is
>> initiallized in specific flash driver and it won't be updated later(eg.
>> ioctl\sysctl). And some mtd devices may have zero erasesize, eg.
>> drivers/mtd/devices/mchp23k256.c[1]. Unfortunately, I don't know how to
>> load/simulate this mtd, maybe it requires a real device? If we load this
>> mtd device as ubi, it will trigger the problem?
> 
> Indeed. I guess qemu can emulate such chips.
> So better fix UBI to reject attaching of mtd's with erasesize being 0.
> (Please note, we cannot test for MTD_NO_ERASE, this one means there is no
> erase method).

Phram is an exception, it has erase function but is set flag 
'MTD_CAP_RAM'. May I interpret 'MTD_NO_ERASE' as erase function is not 
necessary?
