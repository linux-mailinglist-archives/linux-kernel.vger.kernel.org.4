Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF09652F82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLUKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiLUKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:30:36 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABED11A2D;
        Wed, 21 Dec 2022 02:29:07 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NcV277063zJpDN;
        Wed, 21 Dec 2022 18:25:19 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 18:29:04 +0800
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     John Garry <john.g.garry@oracle.com>,
        yangxingui <yangxingui@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <f15c142c-669d-6bc7-f9b9-c05cc3df1542@huawei.com>
 <9b8da72d-f251-9c1b-0727-28254d7007c3@oracle.com>
 <fe4ed9f7-4032-f1e2-d6c0-6a7bc99ec3b1@huawei.com>
 <ad3804e6-37f8-aa43-19f6-2ef30c0ccca1@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <0ec55896-a690-9aca-a85a-4e6584e27967@huawei.com>
Date:   Wed, 21 Dec 2022 18:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ad3804e6-37f8-aa43-19f6-2ef30c0ccca1@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 17:40, John Garry wrote:
> On 20/12/2022 09:49, Jason Yan wrote:
>>
>> Itering tagset in libsas is odd.
> 
> Itering with block layer APIs is just a method to deal with each active 
> IO. However, libsas should not be aborting IO directly. It may provide 
> helper routines, but the LLDD should be dealing with aborting IO.
> 
>  >
>  > The question is, shall we implement the aborting from the driver side,
>  > such as what sas_ata_device_link_abort() do. Or shall we implement the
>  > aborting from the upper side(scsi middle layer or block layer), such as
>  > trigger block layer time out handler immediately after we found device
>  > is gone?
> 
> As mentioned, aborting each IO should be the job of the LLDD. However, 
> just making the IO timeout will lead to EH kicking in earlier, and EH 
> will do usual per-IO handling in sas_eh_handle_sas_errors() that would 
> happen when the IO timesout normally - so what are we really gaining 
> here? Just EH kicks in earlier. But we still have the problem of all 
> other per-host IO being blocked while EH is active.

This is not the same issue as I replied yesterday.
https://lkml.org/lkml/2022/12/19/1034

Thanks,
Jason
