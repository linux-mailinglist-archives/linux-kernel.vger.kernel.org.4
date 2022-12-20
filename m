Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122D651DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiLTJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiLTJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:49:17 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670CBF5;
        Tue, 20 Dec 2022 01:49:15 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NbsBd1rQLzHqXM;
        Tue, 20 Dec 2022 17:45:29 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 17:49:13 +0800
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
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <fe4ed9f7-4032-f1e2-d6c0-6a7bc99ec3b1@huawei.com>
Date:   Tue, 20 Dec 2022 17:49:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9b8da72d-f251-9c1b-0727-28254d7007c3@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/19 22:53, John Garry wrote:
> Are you sure you mean sas_abort_task()? That is for the LLDD to issue an 
> abort TMF. I assume that you mean sas_task_abort(). If so, I am not too 
> keen on the idea of libsas calling into the LLDD to inform of such an 
> event. Note that maybe a tagset iter function could be used by libsas to 
> abort each active IO, but I don't like libsas messing with such a thing; 
> in addition, there may be some conflict between libsas aborting the IO 
> and the IO completing with error in the LLDD.

Itering tagset in libsas is odd.

The question is, shall we implement the aborting from the driver side, 
such as what sas_ata_device_link_abort() do. Or shall we implement the 
aborting from the upper side(scsi middle layer or block layer), such as 
trigger block layer time out handler immediately after we found device 
is gone?

Thanks,
Jason
