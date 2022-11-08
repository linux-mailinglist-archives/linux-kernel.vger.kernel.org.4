Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E606217C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiKHPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiKHPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:13:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B452896
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B077CB81B2B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78CC433B5;
        Tue,  8 Nov 2022 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667920395;
        bh=yjUEyhaRIiHMqqO27oI8Zj9p/9BwETLNtnjjbRI3gdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnykQP2KcAzGAG/+CJJg8u7H4NN9PjTW3S24WLXdrw/LYKque3tsoHXiT/uT1NJB1
         +07FaD7LPaEt5y2Lp1nW6IVlWLQLOdqIFoURyuKEKAwO5/+oByVWgdECQuB+I4vpro
         z7ab5TdoPCnhUQetg4jz2Xthrnl1bdez0tJRFONM=
Date:   Tue, 8 Nov 2022 16:13:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: convert snprintf to scnprintf
Message-ID: <Y2pyCA/tRunNVRQt@kroah.com>
References: <Y2K2MD7+WBu4QouU@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2K2MD7+WBu4QouU@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:55:52PM +0530, Deepak R Varma wrote:
> It is recommended to use scnprintf instead of snprintf to accurately
> return the size of the encoded data. Following article [1] has details
> on the reason for this kernel level migration. This issue was identified
> using coccicheck.
> 
> [1] https://lwn.net/Articles/69419/
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/fieldbus/dev_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
> index 5aab734606ea..d51f2b02d5e6 100644
> --- a/drivers/staging/fieldbus/dev_core.c
> +++ b/drivers/staging/fieldbus/dev_core.c
> @@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
>  	 * card_name was provided by child driver, could potentially be long.
>  	 * protect against buffer overrun.
>  	 */
> -	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);

No, neither of these are correct.

Please use sysfs_emit() for sysfs show callbacks.

thanks,

greg k-h
