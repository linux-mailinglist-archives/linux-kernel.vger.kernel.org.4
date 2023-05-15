Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784FB702CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbjEOMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbjEOMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F491FC8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E94E61840
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554A3C433EF;
        Mon, 15 May 2023 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684154037;
        bh=qqX8d2wK3vFURfdGP9ysmWSt8Exw39GGjmtr/lUXmqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xN4pKYQhQ358AXen5Gr18fkSiyfXSYJ2Uyz8jLxCB7P9fMKUwppG0iN3egcGwlEN0
         l800LbS3SZbR8D0dWMAhpKCpkwjPZLUCbQoKvoBdVfKGzTNAh/MA24k+VrNOXUkHcS
         ru8R+Qci5m2gRC4jIEV4vnwY1MtkmvAcyCGcbzUQ=
Date:   Mon, 15 May 2023 14:33:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Esina Ekaterina <eesina@astralinux.ru>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] staging: gasket: interrupt: Clean interrupt_data
 after free
Message-ID: <2023051542-attendee-subsidize-349f@gregkh>
References: <20230515122950.100564-1-eesina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515122950.100564-1-eesina@astralinux.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:29:50PM +0300, Esina Ekaterina wrote:
> Add interrupt_data = NULL after kfree(interrupt_data) in
> gasket_interrupt_init. It is needed to avoid double free
> in gasket_interrupt_cleanup, there is a check for NULL
> before kfree(interrupt_data).
> 
> Found by Astra Linux on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
> Signed-off-by: Esina Ekaterina <eesina@astralinux.ru>
> ---
>  drivers/staging/gasket/gasket_interrupt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
> index 864342acfd86..48b664b9134a 100644
> --- a/drivers/staging/gasket/gasket_interrupt.c
> +++ b/drivers/staging/gasket/gasket_interrupt.c
> @@ -337,6 +337,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>  			sizeof(*interrupt_data->eventfd_ctxs), GFP_KERNEL);
>  	if (!interrupt_data->eventfd_ctxs) {
>  		kfree(interrupt_data);
> +		interrupt_data = NULL;
>  		return -ENOMEM;
>  	}
>  
> @@ -346,6 +347,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>  	if (!interrupt_data->interrupt_counts) {
>  		kfree(interrupt_data->eventfd_ctxs);
>  		kfree(interrupt_data);
> +		interrupt_data = NULL;
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.40.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
