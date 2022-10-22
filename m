Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C6608BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJVKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiJVKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:49:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242CE31CB51;
        Sat, 22 Oct 2022 03:06:07 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mvbpz29nhzJn7x;
        Sat, 22 Oct 2022 17:37:47 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:40:22 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 17:40:21 +0800
Message-ID: <2adeb439-646b-ebb1-b266-c3ed4750eac2@huawei.com>
Date:   Sat, 22 Oct 2022 17:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Steffen Maier <maier@linux.ibm.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20221021235754.1968981-1-haowenchao@huawei.com>
 <daa60cf0-0dde-ea2d-211a-70a9e0efc1b8@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <daa60cf0-0dde-ea2d-211a-70a9e0efc1b8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml100008.china.huawei.com (7.185.36.48) To
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


On 2022/10/22 1:24, Mike Christie wrote:
> On 10/21/22 6:57 PM, Wenchao Hao wrote:
>> +
>>  int iscsi_session_chkready(struct iscsi_cls_session *session)
>>  {
>>  	int err;
>> @@ -1899,6 +1922,7 @@ static void __iscsi_unblock_session(struct work_struct *work)
>>  	cancel_delayed_work_sync(&session->recovery_work);
>>  	spin_lock_irqsave(&session->lock, flags);
>>  	session->state = ISCSI_SESSION_LOGGED_IN;
>> +	session->target_state = ISCSI_SESSION_TARGET_BOUND;
>>  	spin_unlock_irqrestore(&session->lock, flags);
>>  	/* start IO */
> 
> Hey,
> 
> Sorry for the late reply.
> 

It doesn't matter.

> For the initial login we have not scanned the session above, so there
> is no target yet. If iscsid is restarted at this time, then iscsid wants
> to sync the session and also do the initial scan.
> 
> To handle that case and also better match the state names with the
> session's target state we can:
> 
> 1. Move the above line to iscsi_user_scan_session after we have scanned
> the target.
> 2. Add a new state ISCSI_SESSION_TARGET_ALLOCATED to reflect we have
> allocated the target_id, but not yet scanned.
> .

I have some wonder about the target_id like be2iscsi which allocated from 
iscsi_sess_ida. Should not we get the target_id from iSCSI target?
If they allocate target_id with an random value, how to handle the
iscsi_user_scan_session which would check the session's target_id.

I have no environment which deployed these iSCSI drivers like be2iscsi, so I
can not valid my guess.
