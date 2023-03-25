Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB56C89C6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCYBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCYBDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:03:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F6816AF0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:03:18 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk15026PVzrX4f;
        Sat, 25 Mar 2023 09:02:12 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 09:02:41 +0800
Subject: Re: [PATCH -next v3] ubi: Fix failure attaching when vid_hdr offset
 equals to (sub)page size
To:     Nicolas Schichan <nschichan@freebox.fr>
CC:     <george.kennedy@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
References: <20230306013308.3884777-1-chengzhihao1@huawei.com>
 <20230324161923.1456371-1-nschichan@freebox.fr>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2c2c2ce9-795b-4f76-cde9-db4a4066dcc1@huawei.com>
Date:   Sat, 25 Mar 2023 09:02:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230324161923.1456371-1-nschichan@freebox.fr>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> 
>> Following process will make ubi attaching failed since commit
>> 1b42b1a36fc946 ("ubi: ensure that VID header offset ... size"):
>>
>> ID="0xec,0xa1,0x00,0x15" # 128M 128KB 2KB
>> modprobe nandsim id_bytes=$ID
>> flash_eraseall /dev/mtd0
>> modprobe ubi mtd="0,2048"  # set vid_hdr offset as 2048 (one page)
>> (dmesg):
>>    ubi0 error: ubi_attach_mtd_dev [ubi]: VID header offset 2048 too large.
>>    UBI error: cannot attach mtd0
>>    UBI error: cannot initialize UBI, error -22
>>
>> Rework original solution, the key point is making sure
>> 'vid_hdr_shift + UBI_VID_HDR_SIZE < ubi->vid_hdr_alsize',
>> so we should check vid_hdr_shift rather not vid_hdr_offset.
>> Then, ubi still support (sub)page aligined VID header offset.
>>
>> Fixes: 1b42b1a36fc946 ("ubi: ensure that VID header offset ... size")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>   v2->v3: Use printing format '%zu' for UBI_VID_HDR_SIZE.
>>   drivers/mtd/ubi/build.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> [...]
> 
> Hello,
> 
> Having had the problem, and found this patch as a fix, feel free to
> add my:
> 

Thanks for testing.

> Tested-by: Nicolas Schichan <nschichan@freebox.fr>
> 

