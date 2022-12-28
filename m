Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB906574B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiL1JgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiL1Jfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:35:55 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D931D2D2;
        Wed, 28 Dec 2022 01:35:54 -0800 (PST)
Received: from dggpemm500017.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NhmWM3whyz9t29;
        Wed, 28 Dec 2022 17:31:59 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 17:35:51 +0800
Message-ID: <25b89f97-0cac-7611-c20f-3140565219c4@huawei.com>
Date:   Wed, 28 Dec 2022 17:35:51 +0800
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
        "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>,
        Andrey Melnikov <temnota.am@gmail.com>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <Y5rHX95Vvl1aLhbp@infradead.org>
 <57c12317-c229-8cbe-b3d2-d799ea5f554c@huawei.com>
 <Y5waet8RoXKQHDR7@infradead.org>
 <5129c84b-38e5-8be4-6411-fcc003776d70@huawei.com>
 <Y6XPRfgLSUShN+mY@infradead.org>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <Y6XPRfgLSUShN+mY@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500003.china.huawei.com (7.185.36.200) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/23 23:54, Christoph Hellwig wrote:
> On Fri, Dec 16, 2022 at 07:41:26PM +0800, Wenchao Hao wrote:
>> For nothing, I want the iscsi_tcp transport do not skip PQ=1 default
>> as what it did before commit 948e922fc4461 ("scsi: core: map PQ=1,
>> PDT=other values to SCSI_SCAN_TARGET_PRESENT").
> 
> Well, that commit was very much intentional and is now three an a half
> years old, so we've not just going to partially revert it on a
> per-transport basis when it is in no way transport related.
> 
> If you can come up with a good enough rationale we could do the
> sysfs override, but so far the reason mostly seems to be "I want"
> and not anctual explanation of why it is useful.
> .


Sorry, I did not describe in detail.

Here is the reason of my patches.

1. The SPC did not tell PQ=1 means the addressed lun is invalid explicitly.
2. scsi_bus_match() would prevent luns with PQ=1 be handled by any scsi
   drivers, so the only influence if we do not skip luns with PQ=1 is we
   would add an scsi_device and an sg device.

The reason I force a specific behavior for iSCSI:

1. This issue is occurred with iSCSI, it means there are scenarios where
   targets would return PQ=1 for an valid LUN which should not be skipped.
2. The changes for iSCSI could be tested

I did not change other transports' behavior is because I do not know if PQ=1
would be returned, and I do not have the related environment. If other
transports like adaptec raid also needs these changes, they can override
the default value by other patches.

Thanks.

