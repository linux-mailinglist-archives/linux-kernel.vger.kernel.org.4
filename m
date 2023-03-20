Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AD6C0D25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCTJXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCTJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415061A48A;
        Mon, 20 Mar 2023 02:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBE4612A0;
        Mon, 20 Mar 2023 09:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3355EC433D2;
        Mon, 20 Mar 2023 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679304159;
        bh=U8AB7ReyQRria3g0yu5nhLIgRqDZBiolVk9UdFIGSAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XepiwevBXcLgifpSOXRQiCKV27Iw91a7WaNG5lagQDavUQxJicwLYvmvvgz5ApgOu
         t9jmVzyMQ0TSHLn3JtjOlcM6mVf+FyDs9nmK2HnuShPBIO3usbWV021No5h3iHGlPF
         5EsjZoXGD8mTsqA5nlP87JZnnZO05enQbZxXtj4lGaSS1HV1CqslslapPVa3Ma0ZER
         T/14Be0KEogzdOqQ4gvw3pKQ53uWCt4SxS3o1OlYopfhZAwgQwuJ/GjjjR1MaX6LfG
         KGj1CENrubfnDkdAR7TukzykjPFrVkfOA8kiewHMs2npvBIVv8GjsrZjAet8Te3d1q
         Ao0ShQfTRqdBA==
Date:   Mon, 20 Mar 2023 14:52:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx290: fix conditional function defintions
Message-ID: <20230320092231.GC4564@thinkpad>
References: <20230207161316.293923-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207161316.293923-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:13:12PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The runtime suspend/resume functions are only referenced from the
> dev_pm_ops, but they use the old SET_RUNTIME_PM_OPS() helper
> that requires a __maybe_unused annotation to avoid a warning:
> 
> drivers/media/i2c/imx290.c:1082:12: error: unused function 'imx290_runtime_resume' [-Werror,-Wunused-function]
> static int imx290_runtime_resume(struct device *dev)
>            ^
> drivers/media/i2c/imx290.c:1090:12: error: unused function 'imx290_runtime_suspend' [-Werror,-Wunused-function]
> static int imx290_runtime_suspend(struct device *dev)
>            ^
> 
> Convert this to the new RUNTIME_PM_OPS() helper that so this
> is not required. To improve this further, also use the pm_ptr()
> helper that lets the dev_pm_ops get dropped entirely when
> CONFIG_PM is disabled.
> 
> A related mistake happened in the of_match_ptr() macro here, which
> like SET_RUNTIME_PM_OPS() requires the match table to be marked
> as __maybe_unused, though I could not reproduce building this without
> CONFIG_OF. Remove the of_match_ptr() here as there is no point in
> dropping the match table in configurations without CONFIG_OF.
> 
> Fixes: 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/media/i2c/imx290.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 49d6c8bdec41..48ae2e0adf9e 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -1098,7 +1098,7 @@ static int imx290_runtime_suspend(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops imx290_pm_ops = {
> -	SET_RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
> +	RUNTIME_PM_OPS(imx290_runtime_suspend, imx290_runtime_resume, NULL)
>  };
>  
>  /* ----------------------------------------------------------------------------
> @@ -1362,8 +1362,8 @@ static struct i2c_driver imx290_i2c_driver = {
>  	.remove = imx290_remove,
>  	.driver = {
>  		.name  = "imx290",
> -		.pm = &imx290_pm_ops,
> -		.of_match_table = of_match_ptr(imx290_of_match),
> +		.pm = pm_ptr(&imx290_pm_ops),
> +		.of_match_table = imx290_of_match,
>  	},
>  };
>  
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
