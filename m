Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9BA72B118
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjFKJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjFKJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A453173B;
        Sun, 11 Jun 2023 02:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 932DE60DB4;
        Sun, 11 Jun 2023 09:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D07DC433D2;
        Sun, 11 Jun 2023 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686475060;
        bh=3SpJa0wEuM4DqYfKRvFSbCsku+l47Q/G9TnUQ9payQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrBrpQBBpGfKZU1sgq0SnkLHZBe+tLk9orV4App7/aY8sCXYnfERFk6vxyakecPIl
         TtiH00RYsRQ+ZXuinClirAjzlBnXrCWifSC/G6SEvSsBSDFJ6mhh5hDKyyc2EgkEv3
         YS+o6cEVDvTfygDg/Fn+oWOioLMyCQCe+A7wAlSDsfN/ZiAjOJdBJa97zR2QEz1jAr
         9UZGisJPROyHmGFTH96craL8sEBQ3sAXEzvU7gHMGsy6LzPl3QCX5pLLj5fIhH0V1A
         r8FI06QnMo9/WoUPPKseRMxqV0RQAMWJCJg6M5d3fOxqAJUbByTtUZ9tNHLBdEaiwM
         XEbfJF64DqhwA==
Date:   Sun, 11 Jun 2023 11:17:36 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 2/2] serial: sh-sci: Switch to use dev_err_probe_ptr()
Message-ID: <20230611091736.ezwj4ap5mlza42vp@intel.intel>
References: <20220214143248.502-1-andriy.shevchenko@linux.intel.com>
 <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Feb 14, 2022 at 04:32:48PM +0200, Andy Shevchenko wrote:
> Instead of
> 	return ERR_PTR(dev_err_probe(...));
> call
> 	return dev_err_probe_ptr(...);
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/sh-sci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index b610b27893a8..0fce09c13847 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3199,8 +3199,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
>  
>  	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>  	if (IS_ERR(rstc))
> -		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
> -					     "failed to get reset ctrl\n"));
> +		return dev_err_probe_ptr(&pdev->dev, PTR_ERR(rstc), "failed to get reset ctrl\n");

I think this is a great idea. Like Geert, however, I believe that
this could be more effective as a vararg function. Furthermore,
wouldn't it be easier if the PTR_ERR conversion was carried out
directly within dev_err_probe_ptr?

Wouldn't this approach be more compact and convenient?

	return dev_err_probe_ptr(&pdev->dev, rstc,
				 "failed to get reset ctrl\n");


Now, things start to get a bit more complicated as we will have
four different combinations of dev_err_probes. They could either
take a pointer with an error or an error integer, and they could
either return an error or a pointer with an error. All four cases
are utilized.

Please include me in your next batch of patches as I am also
working on something similar in the background.

Thanks,
Andi

>  
>  	ret = reset_control_deassert(rstc);
>  	if (ret) {
> -- 
> 2.34.1
> 
