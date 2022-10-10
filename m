Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE05FA662
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJJUfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJJUfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:35:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3D7F0B9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:34:17 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id hzSKonKgNBDYDhzSKobsgK; Mon, 10 Oct 2022 22:32:58 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 10 Oct 2022 22:32:58 +0200
X-ME-IP: 86.243.100.34
Message-ID: <8b12359f-0a70-34aa-e9fd-dc98c1075140@wanadoo.fr>
Date:   Mon, 10 Oct 2022 22:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] scsi: vmw_pvscsi: Fix an error handling path in
 pvscsi_probe()
Content-Language: fr
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vishal Bhakta <vbhakta@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        linux-scsi@vger.kernel.org
References: <ed31652626b0d8133e90f6888ef2b56cbc46ee57.1665297058.git.christophe.jaillet@wanadoo.fr>
 <Y0QO3RLY+gD5i/jY@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y0QO3RLY+gD5i/jY@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/10/2022 à 14:23, Dan Carpenter a écrit :
> On Sun, Oct 09, 2022 at 08:31:24AM +0200, Christophe JAILLET wrote:
>> In all paths that end to "out_release_resources_and_disable", neither
>> pci_alloc_irq_vectors() nor request_irq() have been called yet. So, there
>> is no point in calling pvscsi_shutdown_intr() which undoes these calls.
>>
>> Remove this erroneous call.
>>
>> This should fix the bug report in [1].
>>
>> [1]: https://lore.kernel.org/all/CAMhUBjnDdk7_bBzqgFhZ=xf-obJYMbsJf10wC_bsUeTzxXLK6A@mail.gmail.com/
>>
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Fixes: 02f425f811ce ("scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> The Fixes: tag is maybe not optimal, the issue was there even before.
>> But I think that this commit reference should help in case of backport
>> (and it makes git-mail add Dan automagically in copy :) )
> 
> What a wonderful privilege it is to be CC'd on this...  #LOL

Hi Dan,

You are my idol. You deserve it. :)

> 
> It's still not right...  The pvscsi_shutdown_intr() function undoes
> pci_alloc_irq_vectors() and request_irq().  Those things need to be
> done separately because they can fail separately.
> 
> The error handling in this function is not written in mirror order
> format so that's part of the complication.  There isn't any reason
> for the weird out_release_resources_and_disable label if we just did
> the error handling in mirror format.
> 
> 1) Move the scsi_host_put() so it mirrors the order how the host is
>     allocated.
> 2) Split the pvscsi_shutdown_intr() function into free_irq() and
>     pci_free_irq_vectors().
> 3) Do the ll_adapter_reset() after freeing the IRQs.  The reset is just
>     writing to some registers.  It doesn't require any complicated
>     resources to work.  Which is good because it sometimes happens before
>     those resources were allocated.
> 
> This next is not something I changed, but just a comment and explanation,
> the pvscsi_release_resources() is a magical free tons of stuff function.
> I do not like those kinds of functions because they are prone to bugs and
> difficult to read.  However in this case it seems to work so I have not
> done anything to it.  If you're wondering where the pci_iomap() gets
> unmapped it happens inside the pvscsi_release_resources() function.
> 
> I know it sucks to re-write patches.  If you want I can send this or if
> you want you can send this with a Co-developed-by tag or whatever...  (I
> don't really care).

I'll have a busy week and won't have time to look at it in the coming 
days. So please, send your updated patch.

Keep the Reported-by:.
A Co-developed-by: for me is not a must have. You did 99% of the job ;-) 
(and thanks for doing it).

CJ

> 
> regards,
> dan carpenter
> 
> diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
> index f88ecdb93a8a..f495c24fdeac 100644
> --- a/drivers/scsi/vmw_pvscsi.c
> +++ b/drivers/scsi/vmw_pvscsi.c
> @@ -1396,7 +1396,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (i == DEVICE_COUNT_RESOURCE) {
>   		printk(KERN_ERR
>   		       "vmw_pvscsi: adapter has no suitable MMIO region\n");
> -		goto out_release_resources_and_disable;
> +		goto out_release_resources;
>   	}
>   
>   	adapter->mmioBase = pci_iomap(pdev, i, PVSCSI_MEM_SPACE_SIZE);
> @@ -1405,7 +1405,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		printk(KERN_ERR
>   		       "vmw_pvscsi: can't iomap for BAR %d memsize %lu\n",
>   		       i, PVSCSI_MEM_SPACE_SIZE);
> -		goto out_release_resources_and_disable;
> +		goto out_release_resources;
>   	}
>   
>   	pci_set_master(pdev);
> @@ -1437,7 +1437,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	host = scsi_host_alloc(&pvscsi_template, sizeof(struct pvscsi_adapter));
>   	if (!host) {
>   		printk(KERN_ERR "vmw_pvscsi: failed to allocate host\n");
> -		goto out_release_resources_and_disable;
> +		goto out_release_resources;
>   	}
>   
>   	/*
> @@ -1468,7 +1468,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	error = pvscsi_allocate_rings(adapter);
>   	if (error) {
>   		printk(KERN_ERR "vmw_pvscsi: unable to allocate ring memory\n");
> -		goto out_release_resources;
> +		goto out_put_host;
>   	}
>   
>   	/*
> @@ -1524,14 +1524,14 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (error) {
>   		printk(KERN_ERR
>   		       "vmw_pvscsi: unable to request IRQ: %d\n", error);
> -		goto out_reset_adapter;
> +		goto out_free_irq_vectors;
>   	}
>   
>   	error = scsi_add_host(host, &pdev->dev);
>   	if (error) {
>   		printk(KERN_ERR
>   		       "vmw_pvscsi: scsi_add_host failed: %d\n", error);
> -		goto out_reset_adapter;
> +		goto out_free_irqs;
>   	}
>   
>   	dev_info(&pdev->dev, "VMware PVSCSI rev %d host #%u\n",
> @@ -1543,21 +1543,20 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	return 0;
>   
> +out_free_irqs:
> +	free_irq(pci_irq_vector(adapter->dev, 0), adapter);
> +out_free_irq_vectors:
> +	pci_free_irq_vectors(adapter->dev);
>   out_reset_adapter:
>   	ll_adapter_reset(adapter);
> +out_put_host:
> +	scsi_host_put(host);
>   out_release_resources:
> -	pvscsi_shutdown_intr(adapter);
>   	pvscsi_release_resources(adapter);
> -	scsi_host_put(host);
>   out_disable_device:
>   	pci_disable_device(pdev);
>   
>   	return error;
> -
> -out_release_resources_and_disable:
> -	pvscsi_shutdown_intr(adapter);
> -	pvscsi_release_resources(adapter);
> -	goto out_disable_device;
>   }
>   
>   static void __pvscsi_shutdown(struct pvscsi_adapter *adapter)
> 

