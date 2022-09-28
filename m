Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1915EE88D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiI1Vpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiI1Vpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:45:32 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0AB67469;
        Wed, 28 Sep 2022 14:45:26 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id BEEAAE16B4;
        Wed, 28 Sep 2022 21:45:24 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id B4DD48DDA6;
        Wed, 28 Sep 2022 21:45:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id QcOqa6ItpgDk; Wed, 28 Sep 2022 21:45:24 +0000 (UTC)
Received: from [10.60.2.196] (unknown [213.52.86.138])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id B59658DDA3;
        Wed, 28 Sep 2022 21:45:22 +0000 (UTC)
Message-ID: <af3d2628-bf00-d897-d140-415985c29bfd@interlog.com>
Date:   Wed, 28 Sep 2022 23:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: dgilbert@interlog.com
Subject: Re: KASAN: use-after-free Read in sg_release
Content-Language: en-CA
To:     Rondreis <linhaoguo86@gmail.com>,
        Tony Battersby <tonyb@cybernetics.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com>
 <404508f8-37bb-a3bd-4319-6b6d7a7e076e@cybernetics.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <404508f8-37bb-a3bd-4319-6b6d7a7e076e@cybernetics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-22 17:29, Tony Battersby wrote:
> On 9/20/22 10:46, Rondreis wrote:
>> Hello,
>>
>> When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
>> triggered.
>>
>> HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
>> git tree: upstream
>>
>> kernel config: https://pastebin.com/raw/hekxU61F
>> console output: https://pastebin.com/raw/73a8RzBY
>>
>> Sorry for failing to extract the reproducer. But on other versions of
>> Linux, I also triggered this crash.
>>
>> I would appreciate it if you have any idea how to solve this bug.
>>
> sg_release() calls "kref_put(&sfp->f_ref, sg_remove_sfp)" which
> eventually does "kref_put(&sdp->d_ref, sg_device_destroy)" which does
> "kfree(sdp)", but sg_release() continues to access sdp afterward.  Try
> the following patch.
> 
>>From 82ca6785c40eded6229183a53752fc5e43db4a94 Mon Sep 17 00:00:00 2001
> From: Tony Battersby <tonyb@cybernetics.com>
> Date: Thu, 22 Sep 2022 11:05:30 -0400
> Subject: [PATCH] scsi: sg: fix memory-use-after-free on device removal
> 
> Fix memory-use-after-free race when closing a sg fd to a removed device.
> 
> Link: https://lore.kernel.org/linux-scsi/CAB7eexK_jr1LWOO9RWrBF9as7gAS9kpHjrZFRuRrRJF=1H4W6A@mail.gmail.com/
> Reported-by: Rondreis <linhaoguo86@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   drivers/scsi/sg.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 340b050ad28d..f44cbe42dba9 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -388,6 +388,7 @@ sg_release(struct inode *inode, struct file *filp)
>   		return -ENXIO;
>   	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
>   
> +	kref_get(&sdp->d_ref);
>   	mutex_lock(&sdp->open_rel_lock);
>   	scsi_autopm_put_device(sdp->device);
>   	kref_put(&sfp->f_ref, sg_remove_sfp);
> @@ -402,6 +403,7 @@ sg_release(struct inode *inode, struct file *filp)
>   		wake_up_interruptible(&sdp->open_wait);
>   	}
>   	mutex_unlock(&sdp->open_rel_lock);
> +	kref_put(&sdp->d_ref, sg_device_destroy);
>   	return 0;
>   }
>  


Hi Rondreis,
Have you been able to test the above patch from Tony?

Doug Gilbert

