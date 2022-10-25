Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C360CCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiJYNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiJYNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F146F544
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47606191A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B7DC433C1;
        Tue, 25 Oct 2022 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666703039;
        bh=kfm8qo3Fgl8HUHXDJktvjOEaXfHCoDD7o4NPCEMl6C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5UR3ZF7k96jbSM92ps8ljplZMbzuJlqRI9E8pY6Y6WqUMZ1JeQGTVa6kSat14PT8
         j9SMlPf89gLlWKUJ2reoafO0EXEpMy9oH68Rmudl834UjID79YijA+JJIF9BlN5APy
         zSoUavYHvXTx2snKvlZcAP0Cj7qr4dqfUfxgzO2g=
Date:   Tue, 25 Oct 2022 15:03:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v9 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <Y1fevNkLmG3+5lWt@kroah.com>
References: <20221025123931.42161-1-yekai13@huawei.com>
 <20221025123931.42161-3-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025123931.42161-3-yekai13@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:39:30PM +0000, Kai Ye wrote:
> Update documentation describing sysfs node that could help to
> configure isolation strategy for users in the user space. And
> describing sysfs node that could read the device isolated state.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-uacce | 27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> index 08f2591138af..50737c897ba3 100644
> --- a/Documentation/ABI/testing/sysfs-driver-uacce
> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> @@ -19,6 +19,33 @@ Contact:        linux-accelerators@lists.ozlabs.org
>  Description:    Available instances left of the device
>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>  
> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> +Date:           Oct 2022
> +KernelVersion:  6.1
> +Contact:        linux-accelerators@lists.ozlabs.org
> +Description:    (RW) Configure the frequency size for the hardware error
> +                isolation strategy. This unit is the number of times. Number

Number of times what?

> +                of occurrences in a period, also means threshold. If the number
> +                of device pci AER error exceeds the threshold in a time window,

What is the time window?

> +                the device is isolated. This size is a configured integer value.
> +                The default is 0. The maximum value is 65535.
> +
> +                In the hisilicon accelerator engine, first we will
> +                time-stamp every slot AER error. Then check the AER error log
> +                when the device AER error occurred. if the device slot AER error
> +                count exceeds the preset the number of times in one hour, the
> +                isolated state will be set to true. So the device will be
> +                isolated. And the AER error log that exceed one hour will be
> +                cleared.

This seems like a very hardware-specific implementation here.  And this
is supposed to be a generic class?

I feel this is getting really messy :(

thanks,

greg k-h
