Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C660ADF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiJXOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiJXOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:40:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BCE3DBFD;
        Mon, 24 Oct 2022 06:17:32 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mwvzz6c3mzHtcr;
        Mon, 24 Oct 2022 20:50:07 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 20:50:19 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 20:50:18 +0800
Message-ID: <f4e4c09b-9426-eede-a83c-8c55f6dc7d2d@huawei.com>
Date:   Mon, 24 Oct 2022 20:50:17 +0800
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
 <2adeb439-646b-ebb1-b266-c3ed4750eac2@huawei.com>
 <64689ca9-62eb-27e1-63df-e2e8c1a59cbb@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <64689ca9-62eb-27e1-63df-e2e8c1a59cbb@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500026.china.huawei.com (7.185.36.106) To
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


On 2022/10/23 11:21, Mike Christie wrote:
>> I have some wonder about the target_id like be2iscsi which allocated from 
>> iscsi_sess_ida. Should not we get the target_id from iSCSI target?
>> If they allocate target_id with an random value, how to handle the
>> iscsi_user_scan_session which would check the session's target_id.
>>
> For iscsi, that target id is only a number that's used on the initiator side
> to track the target. The target has no idea what it is and it's never
> sent/used/passed to the target.
> 
> For example, the qla4xxx driver uses it to lookup persistent target info it
> has stored on it's flash. The other use is that we need a unique name for
> the target in sysfs and that target id is used as part of that name.
> .

Thanks for your answer, I would update this patch and open-iscsi's PR.
