Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEF6D4E38
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjDCQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDCQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:42:53 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E751A8;
        Mon,  3 Apr 2023 09:42:51 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 4F173102395;
        Mon,  3 Apr 2023 19:42:48 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 4A1FE102391;
        Mon,  3 Apr 2023 19:42:03 +0300 (MSK)
Received: from [172.16.7.18] (gang [172.16.7.18])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 333Gg2gE021372;
        Mon, 3 Apr 2023 19:42:02 +0300
Message-ID: <174a1911-6a12-a184-5a08-d18b1b7ab296@mcst.ru>
Date:   Mon, 3 Apr 2023 19:47:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi: megaraid: Fix null dereference
Content-Language: en-US
To:     jejb@linux.ibm.com, Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230403143440.1923323-1-Igor.A.Artemiev@mcst.ru>
 <84d55c1032a98de8b2118715d3ec435c409ca0a2.camel@linux.ibm.com>
From:   "Igor A. Artemiev" <Igor.A.Artemiev@mcst.ru>
In-Reply-To: <84d55c1032a98de8b2118715d3ec435c409ca0a2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230403 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.3 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 18:19, James Bottomley wrote:
> On Mon, 2023-04-03 at 17:34 +0300, Igor Artemiev wrote:
>> When cmdid == CMDID_INT_CMDS, the 'mbox' pointer is NULL but is
>> dereferenced below.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 0f2bb84d2a68 ("[SCSI] megaraid: simplify internal command
>> handling")
>> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
>> ---
>>   drivers/scsi/megaraid.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
>> index bf491af9f0d6..4fbf92dc717e 100644
>> --- a/drivers/scsi/megaraid.c
>> +++ b/drivers/scsi/megaraid.c
>> @@ -1441,6 +1441,7 @@ mega_cmd_done(adapter_t *adapter, u8
>> completed[], int nstatus, int status)
>>                   */
>>                  if (cmdid == CMDID_INT_CMDS) {
>>                          scb = &adapter->int_scb;
>> +                       mbox = (mbox_t *)scb->raw_mbox;
> Have you actually seen this and if so which firmware?  I thought
> megaraid internal commands only ever returned success or fail (0 or 1)
> meaning they can never get into the sense processing case that is the
> only consumer of the mbox.
>
> James
>
No, I haven't seen this. A null dereference can be if the 'status'  is 
0x02. But if 'status' cannot be equal to 0x02, assignment isn't required.

Thanks,
Igor

