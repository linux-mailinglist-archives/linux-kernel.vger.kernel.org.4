Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199A6FB1EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjEHNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:44:56 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB95C25276;
        Mon,  8 May 2023 06:44:54 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5122:23cb:1d84:8ee4:cdb3] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 348DheMI007261-348DheMJ007261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 8 May 2023 21:43:40 +0800
Message-ID: <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
Date:   Mon, 8 May 2023 21:40:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of
 `mpt3sas_debugfs_root`
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Tomas Henzl <thenzl@redhat.com>
Cc:     Jing Xu <U202112064@hust.edu.cn>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
 <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
 <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/23 01:06, Dan Carpenter wrote:
> On Tue, May 02, 2023 at 05:53:10PM +0200, Tomas Henzl wrote:
>> On 4/23/23 14:25, Jing Xu wrote:
>>> Smatch complains that:
>>> mpt3sas_init_debugfs() warn: 'mpt3sas_debugfs_root' is an error
>>> pointer or valid
>>>
>>> There is no need to check the return value of the debugfs_create_dir()
>>> function, just delete the dead code.
>>>
>>> Fixes: 2b01b293f359 ("scsi: mpt3sas: Capture IOC data for debugging purposes")
>>> Signed-off-by: Jing Xu <U202112064@hust.edu.cn>
>>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> ---
>>>   drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>> index a6ab1db81167..c92e08c130b9 100644
>>> --- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>> +++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
>>> @@ -99,8 +99,6 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
>>>   void mpt3sas_init_debugfs(void)
>>>   {
>>>   	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
>>> -	if (!mpt3sas_debugfs_root)
>>> -		pr_info("mpt3sas: Cannot create debugfs root\n");
>> Hi Jing,
>> most drivers just ignore the return value but here the author wanted to
>> have the information logged.
>> Can you instead of removing the message modify the 'if' condition so it
>> suits the author's intention?
> 
> This code was always just wrong.
> 
> The history of this is slightly complicated and boring.  These days it's
> harmless dead code so I guess it's less bad than before.

Hi Dan and Tomas,

Any conclusion about this patch? The student Jing Xu is not sure about 
how to revise this patch.

> 
> 
> regards,
> dan carpenter
