Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C101C6E09FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDMJTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E59753;
        Thu, 13 Apr 2023 02:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C43563C90;
        Thu, 13 Apr 2023 09:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3618C433D2;
        Thu, 13 Apr 2023 09:18:29 +0000 (UTC)
Message-ID: <078e3a48-acdb-e6e4-8963-84ecf1c1429d@xs4all.nl>
Date:   Thu, 13 Apr 2023 11:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] media: bttv: fix use after free error due to
 btv->timeout timer
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, hackerzheng666@gmail.com,
        security@kernel.org, hdanton@sina.com, mchehab@kernel.org
References: <20230413034942.40831-1-zyytlz.wz@163.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230413034942.40831-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

Deb Brouwer is working on converting bttv to the vb2 framework, so I want to
wait for that to finish before taking other bttv patches.

I suspect this is still valid post-vb2 conversion, but I'm not certain.

Regards,

	Hans

On 13/04/2023 05:49, Zheng Wang wrote:
> There may be some a race condition between timer function
> bttv_irq_timeout and bttv_remove. The timer is setup in
> probe and there is no timer_delete operation in remove
> function. When it hit kfree btv, the function might still be
> invoked, which will cause use after free bug.
> 
> This bug is found by static analysis, it may be false positive.
> 
> Fix it by adding del_timer_sync invoking to the remove function.
> 
> cpu0                cpu1
>                   bttv_probe
>                     ->timer_setup
>                       ->bttv_set_dma
>                         ->mod_timer;
> bttv_remove
>   ->kfree(btv);
>                   ->bttv_irq_timeout
>                     ->USE btv
> 
> Fixes: 162e6376ac58 ("media: pci: Convert timers to use timer_setup()")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v3:
> - Add Fix label
> v2:
> - stop replacing del_timer with del_timer_sync suggested by Hillf Danton
> ---
>  drivers/media/pci/bt8xx/bttv-driver.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
> index d40b537f4e98..24ba5729969d 100644
> --- a/drivers/media/pci/bt8xx/bttv-driver.c
> +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> @@ -4248,6 +4248,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
>  
>  	/* free resources */
>  	free_irq(btv->c.pci->irq,btv);
> +	del_timer_sync(&btv->timeout);
>  	iounmap(btv->bt848_mmio);
>  	release_mem_region(pci_resource_start(btv->c.pci,0),
>  			   pci_resource_len(btv->c.pci,0));

