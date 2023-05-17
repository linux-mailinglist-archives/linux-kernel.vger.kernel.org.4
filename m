Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17570741C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjEQVWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEQVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:22:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8ABA275;
        Wed, 17 May 2023 14:22:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f27b65bbf9so1517144e87.0;
        Wed, 17 May 2023 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684358520; x=1686950520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/YR/+yOwMsBENGh4rsxAQLrQbfWWuZEEhQXghV/cIk=;
        b=R14xaXSmNaBpay6lMAScDB5PrJN+ujCHwPCouWTlb6TKcQPWZ37m81yZjyek6jPmyr
         7hR9vukaLuFAiv96gFCB2zpcaDV+EE3Zx+jGICCjnQ8erHvYPUk2IN+kEAZN7Z7XrMV2
         zHELyFBi/Z3/iSgUXK+Z9r/Ykc8oWloO+52VLIX/rE/gsONM89WMuoO8PssTI4H0IYdP
         FulSuF9PF43+O8IK/3baGPqih9Ra00fiV85eAJ1n5IhoKr49IXsiAHXBxhfEGX7gE4bf
         cLPuEzLHe2rf3hacdMPtk/FfMPd6jPuQZMQXU7r3xDPBqgIn0euz9oEGU0QNNJhRgvBH
         5CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358520; x=1686950520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/YR/+yOwMsBENGh4rsxAQLrQbfWWuZEEhQXghV/cIk=;
        b=NH7BsYHZkrtt7XHg+5D942jF5PPn2wgl3KBrXfUH6npWAJQreuTS8++EQzpBmXGMfW
         gx3r+V1VTtTo31n8TCmAOlupcy1klTu4r1DbfnQF7sXdSsI7HFyR6QIem4vzuafstosy
         srrPIrj9du2PmmHasGX2+bmf1JSkzU0m2bME6ruX37UZqCD0Bu7/2Crpm4jpcCeZ8xeF
         klr7zhDuTu0crSpCNP7G3PQAg0SE1KVqBqCUgeVybpuuIfYRO/2M4tNQ5nkA6cW98hNt
         h/upJSZCUBNYObH+waPFNDXc7f3yID0ZoRsWdSYTizwQOlZUqObUHQLaQ0Y0dL5fsAQw
         TnAQ==
X-Gm-Message-State: AC+VfDxRl7N7lPR4AhhDd/UbuwOChGjjfDftDK5aChwnPrbC6YC0z7sX
        gxa8U/fBcukGeirx83HE9kk=
X-Google-Smtp-Source: ACHHUZ7zH9nerpxu6Mpwwsdtgu1C64zHtHkipmpZEhiNU5jTRwFiA30FIkgGlxMn98hAG3l98p7zvA==
X-Received: by 2002:ac2:4904:0:b0:4f3:880b:285a with SMTP id n4-20020ac24904000000b004f3880b285amr594502lfi.29.1684358519426;
        Wed, 17 May 2023 14:21:59 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b004f1477cf8a7sm10022lfo.115.2023.05.17.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:21:58 -0700 (PDT)
Date:   Thu, 18 May 2023 00:21:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi-dw-core.c: Fix error checking for debugfs_create_dir
Message-ID: <20230517212156.zrngtiperj6phtmx@mobilestation>
References: <20230517173102.14096-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517173102.14096-1-osmtendev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Osama

On Wed, May 17, 2023 at 10:31:02PM +0500, Osama Muhammad wrote:
> This patch fixes the error checking in spi-dw-core.c in
> debugfs_create_dir. The correct way to check if an error occurred
> is 'IS_ERR' inline function.

AFAICS a correct way to fix this would be to drop the errors check
from the implementation and convert the dw_spi_debugfs_init() function
to returning void. DebugFS kernel API is designed in a way for the
kernel to safely ignore the errors happening during the DebugFS nodes
creation. See
Link: https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L574
for details.

-Serge(y)

> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>  drivers/spi/spi-dw-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index ae3108c70f50..c9cdf6bbcd0e 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -63,7 +63,7 @@ static int dw_spi_debugfs_init(struct dw_spi *dws)
>  
>  	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
>  	dws->debugfs = debugfs_create_dir(name, NULL);
> -	if (!dws->debugfs)
> +	if (IS_ERR(dws->debugfs))
>  		return -ENOMEM;
>  
>  	dws->regset.regs = dw_spi_dbgfs_regs;
> -- 
> 2.34.1
> 
