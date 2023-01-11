Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4712366595B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjAKKte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbjAKKsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:48:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217946338
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25E061BE6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8FCC433EF;
        Wed, 11 Jan 2023 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673434122;
        bh=RuV9fBNZjHNiqza2g2xyDPkt7NXWbVDPBi8lN3ZAXsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ax4cb6bRVXzvmjq8xKYdRvJzI0K84A1rTnNJ4JU6EGClIaOv/b1DNPVPdawrmy6C/
         tWKFMargIDe93C4Anns+XaazdS7cEb3EjYc7nNSCHUJhmGZP+QswR4pqydzy1f73rB
         L31eTCTolCUoewnWUHAypM23wdwYArRu1d2nprvY=
Date:   Wed, 11 Jan 2023 11:48:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <me@linux.beauty>
Cc:     "rafael j. wysocki" <rafael@kernel.org>,
        li chen <lchen@ambarella.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] debugfs: allow to use regmap for print regs
Message-ID: <Y76UBsukAz+yQ9bW@kroah.com>
References: <20230111072130.3885460-1-me@linux.beauty>
 <Y75odDyZXMzigoaL@kroah.com>
 <1859ff0ddb8.d9ed321d977156.553326609923116766@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1859ff0ddb8.d9ed321d977156.553326609923116766@linux.beauty>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:27:20PM +0800, Li Chen wrote:
> Hi Greg,
>  ---- On Wed, 11 Jan 2023 15:42:44 +0800  Greg Kroah-Hartman  wrote --- 
>  > On Wed, Jan 11, 2023 at 03:21:29PM +0800, Li Chen wrote:
>  > > From: Li Chen lchen@ambarella.com>
>  > > 
>  > > Currently, debugfs_regset32 only contains void __iomem *base,
>  > > and it is not friendly to regmap user.
>  > > 
>  > > Let's add regmap to debugfs_regset32, and add debugfs_print_regmap_reg32
>  > > to allow debugfs_regset32_show handle regmap.
>  > > 
>  > > Signed-off-by: Li Chen lchen@ambarella.com>
>  > 
>  > Do you have an actual in-kernel user for this new function?  We can't
>  > accept new apis without users for obvious reasaons.
> 
> Actually, both the old debugfs_print_regs32 and the new debugfs_regmap_print_regs32
> have only one user: debugfs_regset32_show located inside debugfs/file.c.

Yes, but that function is used by lots of drivers in the kernel today,
which is fine.

> The difference is currently all users(device drivers) only use debugfs_regset32->base,
> and none of them use debugfs_regset32->regmap, which is provided by this patch.
> 
> I'm not sure whether it violates the kernel's "no user, no new function" ruler or not.

Yes, you would have to have a user for this functionality for us to be
able to take the change.

> I use this regmap locally on our SoC driver, but it is still not ready to upstream, really sorry for it,
> and it is not a good idea to change existing non-regmap users to regmap haha.
>  
> If you think it does matter, please tell me and I will upload v3 with our SoC driver in the future.

Please add it to your SoC driver patch series instead and I will be glad
to review it at that point in time.  But for now, this shouldn't be
needed.

thanks,

greg k-h
