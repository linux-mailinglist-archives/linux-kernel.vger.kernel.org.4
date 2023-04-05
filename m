Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315666D7384
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjDEEtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjDEEtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:49:12 -0400
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D92127;
        Tue,  4 Apr 2023 21:49:10 -0700 (PDT)
Received: from [IPV6:240e:3b7:3279:cf80:2576:dc67:5a52:29c5] (unknown [IPV6:240e:3b7:3279:cf80:2576:dc67:5a52:29c5])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 40ABF202EE;
        Wed,  5 Apr 2023 12:49:07 +0800 (CST)
Message-ID: <4a8913e7-567f-2b88-6bb8-0305569f866f@sangfor.com.cn>
Date:   Wed, 5 Apr 2023 12:49:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] scsi: ses: Handle enclosure with just a primary
 component gracefully
To:     Jiri Kosina <jikos@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Kolar <mich.k@seznam.cz>
References: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm>
 <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com>
 <nycvar.YFH.7.76.2304042251560.29760@cbobk.fhfr.pm>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <nycvar.YFH.7.76.2304042251560.29760@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk9JVh8dTEJIGBlDThhCTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEJBGB1DS0FJTkxNQR8YTUxBThpOSUFJQhhOWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Aww5Sz0OQz4sHQwjNzwX
        HSMKCglVSlVKTUNLTUxLSk9MQ0NCVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxCQRgdQ0tBSU5MTUEfGE1MQU4aTklBSUIYTllXWQgBWUFDT05DNwY+
X-HM-Tid: 0a874fbf43742eb6kusn40abf202ee
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/5 5:41, Jiri Kosina wrote:
> On Tue, 4 Apr 2023, James Bottomley wrote:
> 
>>> This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has
>>> no components") and introduces proper handling of case where there
>>> are no detected secondary components, but primary component
>>> (enumerated in num_enclosures) does exist. That fix was originally
>>> proposed by Ding Hui <dinghui@sangfor.com.cn>.
>>
>> I think everything in here looks fine except this:
>>
>>> --- a/drivers/scsi/ses.c
>>> +++ b/drivers/scsi/ses.c
>>> @@ -509,9 +509,6 @@ static int ses_enclosure_find_by_addr(struct
>>> enclosure_device *edev,
>>>          int i;
>>>          struct ses_component *scomp;
>>>   
>>> -       if (!edev->component[0].scratch)
>>> -               return 0;
>>> -
>>>          for (i = 0; i < edev->components; i++) {
>>>                  scomp = edev->component[i].scratch;
>>>                  if (scomp->addr != efd->addr)
>>
>> If you remove the check, then scomp could be NULL here and we'll oops
>> on scomp->addr.
> 
> This hunk was taken from the original 2020 fix, but you are right, thanks
> for spotting this.
> 

I think we should remove the check, because the edev->components
represented the effectiveness of array pointers, so we need check
edev->components firstly instead of checking edev->component[0].scratch.

If edev->components is 0, we won't enter the for loop, so don't worry 
about dereference scomp.

> Please find v2 below, with this hunk removed, and Tested-by: added.
> 
> 
> 
> 
> 
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] scsi: ses: Handle enclosure with just a primary component gracefully
> 
> This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has no
> components") and introduces proper handling of case where there are no detected
> secondary components, but primary component (enumerated in num_enclosures)
> does exist. That fix was originally proposed by Ding Hui <dinghui@sangfor.com.cn>.
> 
> Completely ignoring devices that have one primary enclosure and no secondary one
> results in ses_intf_add() bailing completely
> 
> 	scsi 2:0:0:254: enclosure has no enumerated components
>          scsi 2:0:0:254: Failed to bind enclosure -12ven in valid configurations such
> 
> even on valid configurations with 1 primary and 0 secondary enclosures as below:
> 
> 	# sg_ses /dev/sg0
> 	  3PARdata  SES               3321
> 	Supported diagnostic pages:
> 	  Supported Diagnostic Pages [sdp] [0x0]
> 	  Configuration (SES) [cf] [0x1]
> 	  Short Enclosure Status (SES) [ses] [0x8]
> 	# sg_ses -p cf /dev/sg0
> 	  3PARdata  SES               3321
> 	Configuration diagnostic page:
> 	  number of secondary subenclosures: 0
> 	  generation code: 0x0
> 	  enclosure descriptor list
> 	    Subenclosure identifier: 0 [primary]
> 	      relative ES process id: 0, number of ES processes: 1
> 	      number of type descriptor headers: 1
> 	      enclosure logical identifier (hex): 20000002ac02068d
> 	      enclosure vendor: 3PARdata  product: VV                rev: 3321
> 	  type descriptor header and text list
> 	    Element type: Unspecified, subenclosure id: 0
> 	      number of possible elements: 1
> 
> The changelog for the original fix follows
> 
> =====
> We can get a crash when disconnecting the iSCSI session,
> the call trace like this:
> 
>    [ffff00002a00fb70] kfree at ffff00000830e224
>    [ffff00002a00fba0] ses_intf_remove at ffff000001f200e4
>    [ffff00002a00fbd0] device_del at ffff0000086b6a98
>    [ffff00002a00fc50] device_unregister at ffff0000086b6d58
>    [ffff00002a00fc70] __scsi_remove_device at ffff00000870608c
>    [ffff00002a00fca0] scsi_remove_device at ffff000008706134
>    [ffff00002a00fcc0] __scsi_remove_target at ffff0000087062e4
>    [ffff00002a00fd10] scsi_remove_target at ffff0000087064c0
>    [ffff00002a00fd70] __iscsi_unbind_session at ffff000001c872c4
>    [ffff00002a00fdb0] process_one_work at ffff00000810f35c
>    [ffff00002a00fe00] worker_thread at ffff00000810f648
>    [ffff00002a00fe70] kthread at ffff000008116e98
> 
> In ses_intf_add, components count could be 0, and kcalloc 0 size scomp,
> but not saved in edev->component[i].scratch
> 
> In this situation, edev->component[0].scratch is an invalid pointer,
> when kfree it in ses_intf_remove_enclosure, a crash like above would happen
> The call trace also could be other random cases when kfree cannot catch
> the invalid pointer
> 
> We should not use edev->component[] array when the components count is 0
> We also need check index when use edev->component[] array in
> ses_enclosure_data_process
> =====
> 
> Reported-by: Michal Kolar <mich.k@seznam.cz>
> Tested-by: Michal Kolar <mich.k@seznam.cz>
> Originally-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: stable@vger.kernel.org
> Fixes: 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has no components")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
> v1 -> v2:
> 
> 	- fix potential oops in ses_enclosure_find_by_addr() spotted by
> 	  James
> 	- add Tested-by:
> 
>   drivers/scsi/ses.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index b11a9162e73a..f3fa92f493ec 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -602,8 +602,10 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
>   						components++,
>   						type_ptr[0],
>   						name);
> -				else
> +				else if (components < edev->components)
>   					ecomp = &edev->component[components++];
> +				else
> +					ecomp = ERR_PTR(-EINVAL);
>   
>   				if (!IS_ERR(ecomp)) {
>   					if (addl_desc_ptr) {
> @@ -734,11 +736,6 @@ static int ses_intf_add(struct device *cdev,
>   			components += type_ptr[1];
>   	}
>   
> -	if (components == 0) {
> -		sdev_printk(KERN_WARNING, sdev, "enclosure has no enumerated components\n");
> -		goto err_free;
> -	}
> -
>   	ses_dev->page1 = buf;
>   	ses_dev->page1_len = len;
>   	buf = NULL;
> @@ -780,9 +777,11 @@ static int ses_intf_add(struct device *cdev,
>   		buf = NULL;
>   	}
>   page2_not_supported:
> -	scomp = kcalloc(components, sizeof(struct ses_component), GFP_KERNEL);
> -	if (!scomp)
> -		goto err_free;
> +	if (components > 0) {
> +		scomp = kcalloc(components, sizeof(struct ses_component), GFP_KERNEL);
> +		if (!scomp)
> +			goto err_free;
> +	}
>   
>   	edev = enclosure_register(cdev->parent, dev_name(&sdev->sdev_gendev),
>   				  components, &ses_enclosure_callbacks);

-- 
Thanks,
-dinghui

