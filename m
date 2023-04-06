Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0EE6DA22F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjDFUGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbjDFUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB578A245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6839664B4F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A76C4339C;
        Thu,  6 Apr 2023 20:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680811594;
        bh=X/qAhGx90u1TS6QAXF/fVAceMyuEhsw6EnQLbQ8YU7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1UWAmMsHJkGtHy0W20TC4T5RREAioQ2+I61odfTO1UBuKU2IdhJEILsCVbJg1tOg
         H3fkG9GCiLMCUHviMsqVhu7xezduSSkXVdX12GzZ2Rnqi7NqJUcRZzj4GSmSU9lH6l
         jwqTUtfRNe6fMQPthbezGJqywoU0TSxZwJaO5zz4=
Date:   Thu, 6 Apr 2023 22:06:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: rtl8192e: Remove unused local variable
 irq_line
Message-ID: <ZC8mR9OjVlEdDMV-@kroah.com>
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
 <6ec702e12cb30501fc81693a71a96b238bf09ea0.1680729716.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec702e12cb30501fc81693a71a96b238bf09ea0.1680729716.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:48:20PM +0200, Philipp Hortmann wrote:
> Remove unused local variable irq_line.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> index 0bc3e013001e..1c3ccd2aabc3 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> @@ -33,11 +33,9 @@ bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
>  	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
>  	u16 device_id;
>  	u8  revision_id;
> -	u16 irq_line;
>  
>  	device_id = pdev->device;
>  	revision_id = pdev->revision;
> -	pci_read_config_word(pdev, 0x3C, &irq_line);

As was pointed out, that might not be "unused".

When doing a PCI write, the only way to know it has completed is to
issue a read.  Are you sure this isn't a read that is flushing out a
pending write?  Look at who calls this function and verify that this
read really is safe to remove and then document that really really well
in the changelog text when doing so.

Be careful about removing seemingly-unused PCI read/writes, they often
times are actually needed.

thanks,

greg k-h
