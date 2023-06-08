Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4BD728610
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjFHROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjFHROe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DEE59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7030964F81
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C1AC433D2;
        Thu,  8 Jun 2023 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686244472;
        bh=R1L6b3wgbiK874cLJ3MogGauggBNR+aYC0k6slCiep0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwuELfVCtQW00XSO3oJ3XcVCV5ox+/2z8vUhaiNl81TKhQuZE+PMEORvkviZ4n4mS
         gC6Lhy3XyugFnER6NKGbV1FNAEkopXMWFHawmR9+W1t/kdHsvttMWCh4HgskqrKD5m
         J5dkpV8DY70/GNEgVRtRsYUyU6znpXEGpqblJTsT2XN3VDRxryQwO1W6Vb78vkNGix
         ovGkh77TUHpgliwWHhd7tJuAVs+XXXuEbPkoWeQso6xv08lz2e1xx+dCpr0wwc+z9q
         Pj4Xu5/NOXcR/1Ae2OjhZODxEanNyrMXv2rN+InBkTkIY2IsCRBeltq/QGZrQ3ScI4
         vrI0Jd94teIlQ==
Date:   Thu, 8 Jun 2023 18:14:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Add missing check for
 platform_get_resource
Message-ID: <20230608171429.GF3572061@google.com>
References: <20230531100257.17769-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531100257.17769-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Jiasheng Jiang wrote:

> Add the missing check for platform_get_resource and return error
> if it fails.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
> index a143c8dca2d9..1a6ebd3d9795 100644
> --- a/drivers/mfd/intel-lpss-acpi.c
> +++ b/drivers/mfd/intel-lpss-acpi.c
> @@ -183,6 +183,9 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!info->mem)
> +		return -ENOMEM;

This does not mean we're out of memory.

Please use either -EINVAL or -ENODEV.

> +
>  	info->irq = platform_get_irq(pdev, 0);
>  
>  	ret = intel_lpss_probe(&pdev->dev, info);
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
