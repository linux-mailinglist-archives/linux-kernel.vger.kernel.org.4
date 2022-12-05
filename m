Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F160F642888
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLEMbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLEMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:31:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341C17593
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:31:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D541B8103C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780FCC433C1;
        Mon,  5 Dec 2022 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670243505;
        bh=t8lFf17v6/TznDBxy5oeG8Qrl6TA0jB7CwLFWTMheoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fos8mYEuQBpLvHY81tfph3ytPpCiKWx2Kneum7qJHH3sjtTQoTAt6c6v1yeH2aZOo
         ZTWSPasKkJGpJt8MirYBWl9nw7uMoznd+tFcu7re9vv7MIEfol3XahIwCe3qphQRE+
         Dwd1mQh2o89wUUb0vDOxhuxdQmPum8kavRUJetZ8=
Date:   Mon, 5 Dec 2022 13:31:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martyn@welchs.me.uk, manohar.vanga@gmail.com, arnd@arndb.de
Subject: Re: [PATCH] vme: Fix error not catched in fake_init()
Message-ID: <Y43kr/73sorrMWA0@kroah.com>
References: <20221205084805.147436-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205084805.147436-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:48:05PM +0800, Chen Zhongjin wrote:
> In fake_init(), __root_device_register() is possible to fail but it's
> ignored, which can cause unregistering vme_root fail when exit.
> 
>  general protection fault,
>  probably for non-canonical address 0xdffffc000000008c
>  KASAN: null-ptr-deref in range [0x0000000000000460-0x0000000000000467]
>  RIP: 0010:root_device_unregister+0x26/0x60
>  Call Trace:
>   <TASK>
>   __x64_sys_delete_module+0x34f/0x540
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Return error when __root_device_register() fails.
> 
> Fixes: 658bcdae9c67 ("vme: Adding Fake VME driver")
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  drivers/staging/vme_user/vme_fake.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index dd646b0c531d..1ee432c223e2 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1073,6 +1073,8 @@ static int __init fake_init(void)
>  
>  	/* We need a fake parent device */
>  	vme_root = __root_device_register("vme", THIS_MODULE);

This should be calling root_device_register() as well, not this version
of the call.

thanks,

greg k-h
