Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD42767F857
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjA1OCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjA1OCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:02:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F6DD51F;
        Sat, 28 Jan 2023 06:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B5EE60BF9;
        Sat, 28 Jan 2023 14:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86FEC433D2;
        Sat, 28 Jan 2023 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674914553;
        bh=L4wvjz3UbwofzXQ7BUhjliX8FNv1d6w9Db1n+XSkUBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg479vaWza68Dr32/6ScN1pwwklH2EshMa5zdX6dlslR0WLdn0jSEoaqJQbtGtCjc
         WQ0SbUgH0z99Gv3m+1sNOr9hCBewHVY45rYaS0u/Grp33+KO+o1npjGfwI7iNezQfM
         Qj+XnaViTPW2nMhNTO6wbIhneIv9jZO+dUNCovSfTcSISGu5YVrl5otRp0R1ThCbAB
         Cgoz+AYNLgr4NhnyU/8YeFt6ONA/9eJvEMJeStG9c7vWT/agXX9N98pPliL8qI+jBQ
         MiKwM1k51lJC7xsCBkhC2AsYVH3Fn0ziuRgsDcls5aTv8yaY/ykEb3Zum99DxBRr71
         sKYiUPvfIFyvg==
Received: by pali.im (Postfix)
        id 0BC18709; Sat, 28 Jan 2023 15:02:29 +0100 (CET)
Date:   Sat, 28 Jan 2023 15:02:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] platform/x86: dell-smo8800: Use min_t() for comparison
 and assignment
Message-ID: <20230128140229.s6rtdneag4oawhhk@pali>
References: <Y9P8debIztOZXazW@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9P8debIztOZXazW@ubun2204.myguest.virtualbox.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2023 22:01:49 Deepak R Varma wrote:
> Simplify code by using min_t helper macro for logical evaluation
> and value assignment. Use the _t variant of min macro since the
> variable types are not same.
> This issue is identified by coccicheck using the minmax.cocci file.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Looks good,

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/platform/x86/dell/dell-smo8800.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
> index 3385e852104c..8d6b7a83cf24 100644
> --- a/drivers/platform/x86/dell/dell-smo8800.c
> +++ b/drivers/platform/x86/dell/dell-smo8800.c
> @@ -67,10 +67,7 @@ static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
>  
>  	retval = 1;
>  
> -	if (data < 255)
> -		byte_data = data;
> -	else
> -		byte_data = 255;
> +	byte_data = min_t(u32, data, 255);
>  
>  	if (put_user(byte_data, buf))
>  		retval = -EFAULT;
> -- 
> 2.34.1
> 
> 
> 
