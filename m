Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAB713894
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjE1H5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjE1H5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA47DC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9E5760C89
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F2AC433D2;
        Sun, 28 May 2023 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685260625;
        bh=UuZyK9hXvbOMSMv0+Ol5EZmZ0bFahKWss3TY5SSSesA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRpKjehmsVXpYGmBZOZRLP/dPWa+8wCRiRgFhGTtxssDaIJMUy2AOVsM98yFKX5W0
         n8MW0Dout/vGg5N2xvbBMhJJ90LfPZHrplvxUPWc5koDT4fvwX3ynJ7LxY+U9jcvbJ
         SmXOcP2eh4Ca3S5p3TazXa8XJoyPfB7/aw1Q6g58=
Date:   Sun, 28 May 2023 08:57:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mirimmad@outlook.com
Cc:     Immad Mir <mirimmad17@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix debugfs_create_dir error checking
Message-ID: <2023052835-oxidant-doily-404f@gregkh>
References: <CY5PR12MB64553EE96EBB3927311DB598C6459@CY5PR12MB6455.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB64553EE96EBB3927311DB598C6459@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 01:16:44PM +0530, mirimmad@outlook.com wrote:
> From: Immad Mir <mirimmad17@gmail.com>
> 
> The debugfs_create_dir returns ERR_PTR incase of an error and the
> correct way of checking it by using the IS_ERR inline function, and
> not the simple null comparision. This patch fixes this.
> 
> Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
>  arch/powerpc/platforms/powernv/opal-xscom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
> index 6b4eed2ef..262cd6fac 100644
> --- a/arch/powerpc/platforms/powernv/opal-xscom.c
> +++ b/arch/powerpc/platforms/powernv/opal-xscom.c
> @@ -168,7 +168,7 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
>  	ent->path.size = strlen((char *)ent->path.data);
> 
>  	dir = debugfs_create_dir(ent->name, root);
> -	if (!dir) {
> +	if (IS_ERR(dir)) {
>  		kfree(ent->path.data);
>  		kfree(ent);
>  		return -1;

Why is this driver caring if debugfs is working or not at all?  It
should just ignore the error and keep moving forward.

And -1 is not a valid error number :(

Have you hit this error on this driver?

thanks,

greg k-h
