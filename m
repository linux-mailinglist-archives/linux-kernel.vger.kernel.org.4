Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A3687762
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBBIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjBBIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:30:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B668A6F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:30:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A620CB82272
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9CAC433EF;
        Thu,  2 Feb 2023 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675326633;
        bh=LCXuWsDdc9vTBEm/T0S/TKzXhbPd8atKxOeq6WosyWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETI9joJFd+kAcZtxjuNryfCmXq2ydkUCE6LJ1+dDimjNhjq0PAA3Vk3HsgN0zRseF
         GgLWIxpiCceDVEwSGv6kQFAer3DF4fVIGThfUvYOSBtf0z9Hcrzd64OBi79L/OFAKX
         ypu8GHFXVkJEK3Eci4ac5HxqRxQN5MPIyB/VIuBc=
Date:   Thu, 2 Feb 2023 09:30:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH -next 2/3] devtmpfs: add debug info to handle()
Message-ID: <Y9t0pqN/1PaUlKoT@kroah.com>
References: <20230202033203.1239239-1-xialonglong1@huawei.com>
 <20230202033203.1239239-3-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202033203.1239239-3-xialonglong1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:32:02AM +0000, Longlong Xia wrote:
> The devtmpfs_*_node() are used to mount/unmount devices to /dev, but their
> callers don't check their return value, so we don't know the reason for
> the failure. Let's add some debug info in handle() to help users know
> why failed.
> 
> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
> ---
>  drivers/base/devtmpfs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index ae72d4ba8547..77ca64f708ce 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -389,10 +389,18 @@ static __initdata DECLARE_COMPLETION(setup_done);
>  static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
>  		  struct device *dev)
>  {
> +	int ret;
> +
>  	if (mode)
> -		return handle_create(name, mode, uid, gid, dev);
> +		ret = handle_create(name, mode, uid, gid, dev);
>  	else
> -		return handle_remove(name, dev);
> +		ret = handle_remove(name, dev);
> +
> +	if (ret)
> +		pr_err_ratelimited("failed to %s %s, ret = %d\n",
> +				   mode ? "create" : "remove", name, ret);

As you have a struct device * here, why not use dev_err() instead?

And why rate limited?  What is going to cause this to be spammed with
lots and lots of failures?  What were you doing that caused a failure
here, how is it triggered?

thanks,

greg k-h
