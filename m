Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A055712518
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbjEZKxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbjEZKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D219A;
        Fri, 26 May 2023 03:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4316764F35;
        Fri, 26 May 2023 10:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2C5C433D2;
        Fri, 26 May 2023 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685098425;
        bh=qxEreEgdFB/67cSSUEtbNpNaMchA0Q6fBbmN6orLRxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NIXFopWLXX9Si/3mFoQbKP4pMblKdx7jMC/Qw47olOG6aO5P0x+jRe1vBAzQwI8tj
         nkLG83Nnl4GQu/yD7Cz81/y7BzBRRjCJXHGsXflAHFqmlc5Ba3PaIFFw7LM8R/dLVH
         vljWNNrUI4nZh4QKBlktBeD6e2u1drrQDLriOBzl/KfS2ysT14Qv3XiXPOLuMXQT3O
         NGj+2hT+hFVARZw7JujMFn2YxRLk3SuswHvAkYO1CpaDCM2iAxrsePpEoJNQYk1xnD
         cAEfLMKI2kF90js6ShmUY/rzxa8iR2MuRXE7U6MsB66SbhwE+qcoCZzVCVwodwGgUS
         qn+7mgYK21Adg==
Date:   Fri, 26 May 2023 11:53:40 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smsdvb-debugfs.c: Fix error checking for
 debugfs_create_file
Message-ID: <20230526115340.295b1122@sal.lan>
In-Reply-To: <20230524164210.20567-1-osmtendev@gmail.com>
References: <20230524164210.20567-1-osmtendev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 24 May 2023 21:42:10 +0500
Osama Muhammad <osmtendev@gmail.com> escreveu:

> This patch fixes the error checking in smsdvb-debugfs.c in
> debugfs_create_file. The correct way to check if an error occurred
> is using 'IS_ERR_OR_NULL' inline function.
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>  drivers/media/common/siano/smsdvb-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
> index 8916bb644756..0f8750d7993c 100644
> --- a/drivers/media/common/siano/smsdvb-debugfs.c
> +++ b/drivers/media/common/siano/smsdvb-debugfs.c
> @@ -469,7 +469,7 @@ int smsdvb_debugfs_create(struct smsdvb_client_t *client)
>  
>  	d = debugfs_create_file("stats", S_IRUGO | S_IWUSR, client->debugfs,
>  				client, &debugfs_stats_ops);
> -	if (!d) {
> +	if (IS_ERR_OR_NULL(d)) {
>  		debugfs_remove(client->debugfs);
>  		return -ENOMEM;

if IS_ERR, it is probably better to return PTR_ERR(d).

So, please change it accordingly, returning -ENOMEM only on NULL, e. g.
something like (untested):

	if (IS_ERR_OR_NULL(d)) {
 		debugfs_remove(client->debugfs);
		if (!d)
	  		return -ENOMEM;
		return PTR_ERR(d);
	}

Regards,
Mauro
