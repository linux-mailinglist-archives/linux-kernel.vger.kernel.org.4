Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD76D4208
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjDCKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjDCKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:32:17 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ACB3A9B;
        Mon,  3 Apr 2023 03:32:16 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:2468:8ae7:d74c:db55] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 333AU1XC017671-333AU1XD017671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 3 Apr 2023 18:30:02 +0800
Message-ID: <055f3504-0d01-aaf1-1c0b-379c6be702b1@hust.edu.cn>
Date:   Mon, 3 Apr 2023 18:30:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] scsi: lpfc: fix ioremap issues in
 'lpfc_sli4_pci_mem_setup'
To:     Dan Carpenter <error27@gmail.com>
Cc:     lishuchang@hust.edu.cn, James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230403074821.5121-1-lishuchang@hust.edu.cn>
 <6df77fb0-6b3d-4e3b-9c5a-40e217e8dae9@kili.mountain>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <6df77fb0-6b3d-4e3b-9c5a-40e217e8dae9@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/3 17:16, Dan Carpenter wrote:
> On Mon, Apr 03, 2023 at 03:48:21PM +0800, lishuchang@hust.edu.cn wrote:
>> @@ -12069,9 +12069,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
>>   	return 0;
>>   
>>   out_iounmap_all:
>> -	iounmap(phba->sli4_hba.drbl_regs_memmap_p);
>> +	if (!phba->sli4_hba.drbl_regs_memmap_p)
>> +		iounmap(phba->sli4_hba.drbl_regs_memmap_p);
> The test is reversed still.

Thanks for your review, Dan. Sorry for my internal careless review. 
Shuchang is creating a v2 patch to fix all the mentioned issues.

Really sorry about this stupid mistake.

>
> If you make a mistake, you should write a static checker warning so that
> you never make the same mistake again.  ;)  See attached.
>
>
>>   out_iounmap_ctrl:
>> -	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
>> +	if (!phba->sli4_hba.ctrl_regs_memmap_p)
> Also reversed.
>
>> +		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
>>   out_iounmap_conf:
>>   	iounmap(phba->sli4_hba.conf_regs_memmap_p);
> regards,
> dan carpenter
>
>
