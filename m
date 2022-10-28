Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3814F610D98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ1Jpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ1Jpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:45:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0D5AC69;
        Fri, 28 Oct 2022 02:45:27 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MzHhl0JtKzHv2f;
        Fri, 28 Oct 2022 17:45:11 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 17:45:25 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 17:45:25 +0800
Message-ID: <79683c37-904e-562f-fc18-98ffda777d08@huawei.com>
Date:   Fri, 28 Oct 2022 17:45:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "Mike Christie" <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Steffen Maier <maier@linux.ibm.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20221028020026.2870104-1-haowenchao@huawei.com>
 <e6f03525-aad5-c20d-bd8c-a5647898bcf1@suse.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <e6f03525-aad5-c20d-bd8c-a5647898bcf1@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500019.china.huawei.com (7.185.36.137) To
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


On 2022/10/28 0:18, Lee Duncan wrote:
> On 10/27/22 19:00, Wenchao Hao wrote:
>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>> index cd3db9684e52..2e0d1cd6d4ea 100644
>> --- a/drivers/scsi/scsi_transport_iscsi.c
>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>> @@ -1676,6 +1676,30 @@ static const char *iscsi_session_state_name(int state)
>>       return name;
>>   }
>>   +static struct {
>> +    int value;
>> +    char *name;
>> +} iscsi_session_target_state_names[] = {
>> +    { ISCSI_SESSION_TARGET_UNBOUND,        "UNBOUND" },
>> +    { ISCSI_SESSION_TARGET_ALLOCATED,    "ALLOCATED" },
>> +    { ISCSI_SESSION_TARGET_BOUND,        "BOUND" },
>> +    { ISCSI_SESSION_TARGET_UNBINDING,    "UNBINDING" },
>> +};
>> +
>> +static const char *iscsi_session_target_state_name(int state)
>> +{
>> +    int i;
>> +    char *name = NULL;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(iscsi_session_target_state_names); i++) {
>> +        if (iscsi_session_target_state_names[i].value == state) {
>> +            name = iscsi_session_target_state_names[i].name;
>> +            break;
>> +        }
>> +    }
>> +    return name;
>> +}
> 
> It seems like it might be more efficient to use the target state as the array index, so you don't have to loop to find the name, e.g. something like:
> 
>> static char* iscsi_session_target_state_names[] = {
>>     .ISCSI_SESSION_TARGET_UNBOUND = "UNBOUND",
>>     .ISCSI_SESSION_TARGET_ALLOCATED = "ALLOCATED",
>>     .ISCSI_SESSION_TARGET_BOUND = "BOUND",
>>     .ISCSI_SESSION_TARGET_UNBINDING = "UNBINDING",
>> };
> 
> I know there are only 4 states, and it's only used for sysfs, so not sure it matters much.
> 

It's a better implement, I would update it.

>> @@ -1961,6 +1987,15 @@ static void __iscsi_unbind_session(struct work_struct *work)
>>       unsigned long flags;
>>       unsigned int target_id;
>>   +    spin_lock_irqsave(&session->lock, flags);
>> +    if (session->target_state != ISCSI_SESSION_TARGET_BOUND) {
>> +        spin_unlock_irqrestore(&session->lock, flags);
>> +        ISCSI_DBG_TRANS_SESSION(session, "Abort unbind sesison\n");
> 
> It'd be nice if this said more, since debugging "Abort unbind sessions" would require finding the sources. How about "Abort unbind session: not bound", for example?
> 

Of course, I would updated.

>> @@ -264,6 +271,7 @@ struct iscsi_cls_session {
>>        */
>>       pid_t creator;
>>       int state;
>> +    int target_state;            /* session target bind state */
>>       int sid;                /* session id */
>>       void *dd_data;                /* LLD private data */
>>       struct device dev;    /* sysfs transport/container device */
> 
> Thank you for sticking with this. It is very much appreciated.

I should apologize for taking this issue off for a long time because of my slow response.

What's more, should I add an acked-by or reviewed-by in my next patch?
