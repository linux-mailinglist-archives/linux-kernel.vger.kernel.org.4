Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA86D7362
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjDEE1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjDEE1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:27:39 -0400
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E601990;
        Tue,  4 Apr 2023 21:27:35 -0700 (PDT)
Received: from [IPV6:240e:3b7:3279:cf80:7d5f:ad4:6d39:def4] (unknown [IPV6:240e:3b7:3279:cf80:7d5f:ad4:6d39:def4])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 5F10320368;
        Wed,  5 Apr 2023 12:27:32 +0800 (CST)
Message-ID: <b71bca20-401f-c877-168c-c26ca1c282d1@sangfor.com.cn>
Date:   Wed, 5 Apr 2023 12:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   Ding Hui <dinghui@sangfor.com.cn>
Subject: Re: [PATCH] scsi: ses: Handle enclosure with just a primary component
 gracefully
To:     jejb@linux.ibm.com, Jiri Kosina <jikos@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Kolar <mich.k@seznam.cz>
References: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm>
 <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx4dVh9NHUsdHk5OTxlKGFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEJBGB1DS0FMH04dQRofT0FNH0hCQR8eHU9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6OTo6Mz0RDj4qDRE#PwsY
        Vk0aFC1VSlVKTUNLTU1DQ05JQk9DVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxCQRgdQ0tBTB9OHUEaH09BTR9IQkEfHh1PWVdZCAFZQUhKTkk3Bg++
X-HM-Tid: 0a874fab81702eb6kusn5f10320368
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/5 4:26, James Bottomley wrote:
> On Tue, 2023-04-04 at 21:23 +0200, Jiri Kosina wrote:
>> From: Jiri Kosina <jkosina@suse.cz>
>>
>> This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has
>> no components") and introduces proper handling of case where there
>> are no detected secondary components, but primary component
>> (enumerated in num_enclosures) does exist. That fix was originally
>> proposed by Ding Hui <dinghui@sangfor.com.cn>.
> 
> I think everything in here looks fine except this:
> 
>> --- a/drivers/scsi/ses.c
>> +++ b/drivers/scsi/ses.c
>> @@ -509,9 +509,6 @@ static int ses_enclosure_find_by_addr(struct
>> enclosure_device *edev,
>>          int i;
>>          struct ses_component *scomp;
>>   
>> -       if (!edev->component[0].scratch)
>> -               return 0;
>> -
>>          for (i = 0; i < edev->components; i++) {
>>                  scomp = edev->component[i].scratch;
>>                  if (scomp->addr != efd->addr)
> 
> If you remove the check, then scomp could be NULL here and we'll oops
> on scomp->addr.

I think we should remove the check, because the edev->components 
represented the effectiveness of array pointers, so we need check 
edev->components firstly instead of checking edev->component[0].scratch, 
if edev->components is 0, we won't enter the for loop, don't worry about 
dereference scomp.

> 
> Regards,
> 
> James
> 
> 

-- 
Thanks,
-dinghui



