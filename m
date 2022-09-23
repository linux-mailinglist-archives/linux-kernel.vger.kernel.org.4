Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF295E7795
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiIWJqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiIWJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:45:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6267B5FDA;
        Fri, 23 Sep 2022 02:44:34 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYnGs5qj0zpVMc;
        Fri, 23 Sep 2022 17:41:41 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:44:32 +0800
Subject: Re: [PATCH 6/7] scsi: pm8001: use dev_and_phy_addr_same() instead of
 open coded
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>
References: <20220917104311.1878250-1-yanaijie@huawei.com>
 <20220917104311.1878250-7-yanaijie@huawei.com>
 <0034eff3-70a5-becb-0821-f9c36371e6d9@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3c1aa262-7e9b-cb6c-e8a1-a1a201050a10@huawei.com>
Date:   Fri, 23 Sep 2022 17:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0034eff3-70a5-becb-0821-f9c36371e6d9@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/22 22:24, John Garry wrote:
> On 17/09/2022 11:43, Jason Yan wrote:
>> The sas address comparation of domain device and expander phy is open
>> coded. Now we can replace it with dev_and_phy_addr_same().
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/scsi/pm8001/pm8001_sas.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c 
>> b/drivers/scsi/pm8001/pm8001_sas.c
>> index 8e3f2f9ddaac..bb1b1722f3ee 100644
>> --- a/drivers/scsi/pm8001/pm8001_sas.c
>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>> @@ -649,8 +649,7 @@ static int pm8001_dev_found_notify(struct 
>> domain_device *dev)
>>           for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
> 
> This code seems the same between many libsas LLDDs - could we factor it 
> out into libsas? If so, then maybe those new helpers could be put in 
> sas_internal.h

For the part of putting helpers in sas_internal.h, this needs to make 
the helpers exported. I think it's not worth to do this because they are 
very small. I'd still like to make them inline functions in libsas.h 
such as:


diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 2dbead74a2af..e9e76c898287 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -648,6 +648,22 @@ static inline bool sas_is_internal_abort(struct 
sas_task *task)
         return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
  }

+static inline int sas_find_attathed_phy(struct expander_device *ex_dev,
+                                       struct domain_device *dev)
+{
+       struct ex_phy *phy;
+       int phy_id;
+
+       for (phy_id = 0; phy_id < ex_dev->num_phys; phy_id++) {
+               phy = &ex_dev->ex_phy[phy_id];
+               if (SAS_ADDR(phy->attached_sas_addr)
+                       == SAS_ADDR(dev->sas_addr))
+                       return phy_id;
+       }
+
+       return ex_dev->num_phys;
+}
+
  struct sas_domain_function_template {
         /* The class calls these to notify the LLDD of an event. */
         void (*lldd_port_formed)(struct asd_sas_phy *);



And the LLDDs change like:


diff --git a/drivers/scsi/pm8001/pm8001_sas.c 
b/drivers/scsi/pm8001/pm8001_sas.c
index 8e3f2f9ddaac..4e7350609b3d 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -645,16 +645,8 @@ static int pm8001_dev_found_notify(struct 
domain_device *dev)
         pm8001_device->dcompletion = &completion;
         if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
                 int phy_id;
-               struct ex_phy *phy;
-               for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
-               phy_id++) {
-                       phy = &parent_dev->ex_dev.ex_phy[phy_id];
-                       if (SAS_ADDR(phy->attached_sas_addr)
-                               == SAS_ADDR(dev->sas_addr)) {
-                               pm8001_device->attached_phy = phy_id;
-                               break;
-                       }
-               }
+
+               phy_id = sas_find_attathed_phy(&parent_dev->ex_dev, dev);
                 if (phy_id == parent_dev->ex_dev.num_phys) {
                         pm8001_dbg(pm8001_ha, FAIL,
                                    "Error: no attached dev:%016llx at 
ex:%016llx.\n",
@@ -662,6 +654,7 @@ static int pm8001_dev_found_notify(struct 
domain_device *dev)
                                    SAS_ADDR(parent_dev->sas_addr));
                         res = -1;
                 }
+               pm8001_device->attached_phy = phy_id;
         } else {
                 if (dev->dev_type == SAS_SATA_DEV) {
                         pm8001_device->attached_phy =


So I wonder if you have any reasons to insist exporting the helper?

> 
> Thanks,
> John
> 
>>           phy_id++) {
>>               phy = &parent_dev->ex_dev.ex_phy[phy_id];
>> -            if (SAS_ADDR(phy->attached_sas_addr)
>> -                == SAS_ADDR(dev->sas_addr)) {
>> +            if (dev_and_phy_addr_same(dev, phy)) {
>>                   pm8001_device->attached_phy = phy_id;
>>                   break;
>>               }
> 
> .
