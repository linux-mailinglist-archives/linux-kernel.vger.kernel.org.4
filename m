Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F36F9D39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjEHBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjEHBLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:11:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998F935AE;
        Sun,  7 May 2023 18:11:38 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QF38G757szLnbN;
        Mon,  8 May 2023 09:08:46 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 09:11:35 +0800
Message-ID: <938d6b5b-0271-977d-f046-5fd70d29b3ca@huawei.com>
Date:   Mon, 8 May 2023 09:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-CA
To:     Damien Le Moal <dlemoal@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
 <02d36ee9-cdad-454d-d822-95442d7bd67b@huawei.com>
 <f4ba7a92-1f00-c254-d196-7d21fe14dee2@kernel.org>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <f4ba7a92-1f00-c254-d196-7d21fe14dee2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500016.china.huawei.com (7.185.36.25) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/7 22:51, Damien Le Moal wrote:
> On 2023/05/05 18:06, yangxingui wrote:
>>
>>
>> On 2023/5/5 16:17, Damien Le Moal wrote:
>>> On 2023/05/05 11:57, Xingui Yang wrote:
>>>> The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
>>>> the ata_device structure of a scsi device. However, when the ata device is
>>>> managed by libsas, ata_scsi_find_dev() returns NULL, turning
>>>> ata_get_identity() into a nop and always returns -ENOMSG.
>>>
>>> What do you do to hit the issue ? A while back for me it was the queue depth
>>> setting causing problems. As Garry mentioned, this led to patch 141f3d6256e5
>>> ("ata: libata-sata: Fix device queue depth control").
>> Attempt to return the correct value at ata_scsi_find_dev() instead of
>> NULL, when the ata device is managed by libsas?
> 
> That I understand. My question is *what* user operation/command triggers this ?
> Because on my test setup, under normal use, I do not see this issue (beside what
> was already corrected with the queue depth control). Is the issue showing up
> when using passthrough commands only ?
Yeah, we found that command "hdparm -i /dev/sdc" always return faild for 
SATA HDD disk. as follows:
[root@localhost ~]# hdparm -i /dev/sdc

/dev/sdc:
  HDIO_GET_IDENTITY failed: Invalid argument

trace log：
execve("/usr/sbin/hdparm", ["hdparm", "-i", "/dev/sdc"], 0xffffea26f620 
/* 42 vars */) = 0
ioctl(3, HDIO_GET_IDENTITY, 0xffffeb435f28) = -1 ENOMSG (No message of 
desired type)

Thanks,
Xingui
.
