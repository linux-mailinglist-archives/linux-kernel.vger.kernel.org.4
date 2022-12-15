Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FFA64D84B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLOJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:09:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF320F59;
        Thu, 15 Dec 2022 01:09:34 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXmcJ17bmzmWbT;
        Thu, 15 Dec 2022 17:08:32 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 17:09:31 +0800
Message-ID: <57c12317-c229-8cbe-b3d2-d799ea5f554c@huawei.com>
Date:   Thu, 15 Dec 2022 17:09:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] scsi:donot skip lun if inquiry returns PQ=1 for all
 hosts
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <Y5rHX95Vvl1aLhbp@infradead.org>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <Y5rHX95Vvl1aLhbp@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100019.china.huawei.com (7.185.36.175) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/15 15:06, Christoph Hellwig wrote:
> On Wed, Dec 14, 2022 at 03:08:44PM +0800, Wenchao Hao wrote:
>> When iSCSI initiator logged in target, the target attached none valid
>> lun but lun0. lun0 is not an valid disk, while it would response
>> inquiry command with PQ=1 and other general scsi commands like probe lun.
>> The others luns of target is added/removed dynamicly.
> 
> I can't find any special casing of LUN0 in RFC7144, can you clarify
> where you think that treats LUN0 any differently than other transports?
> .
This is not described in RFC7144. The sense described above
aims to tell that a dummy lun is useful.

In my opinion, if the addressed lun still response the
inquiry and other commands, we should not skip it,
maybe let the scsi drivers like sd/st/sg to determine
how to handle this lun accordint to the PQ value.

As discussed in following mail, another drivers would
be broken too.

https://lore.kernel.org/linux-scsi/CA+PODjqrRzyJnOKoabMOV4EPByNnL1LgTi+QAKENP3NwUq5YCw@mail.gmail.com/

The key point of my patch is to add one way to map
dummy lun to an sg device. 
