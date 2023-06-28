Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9374105F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjF1LtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjF1LsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D962D73
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E49612B2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4825C433C8;
        Wed, 28 Jun 2023 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687952877;
        bh=sImKZRQnThRDSBwo5yMG7U+uBjSWyWMCahDeQrsizW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMO13tbBCiGGcMZ/FIcq2CinjqYPkh7nwiQjfaqCabxvx7rphx1UKwuIoULYgy2Y1
         uZjXCKNBHB/2Z0+N6Kkh+Cwcj+gotw5KPyyfJgc2Tfs3p+Rr9yLPDmhvou1kBVr89T
         pu164S7LStAgU/Qsz40HiDwrztVGGZYLW1E2IaR8=
Date:   Wed, 28 Jun 2023 13:47:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
Message-ID: <2023062838-precut-hacker-40bd@gregkh>
References: <20230628112958.45374-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628112958.45374-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:29:58AM +0000, Chengfeng Ye wrote:
> As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
> context, other process context code should disable irq or bottom-half
> before acquire the same lock, otherwise deadlock could happen if the
> timer preempt the execution while the lock is held in process context
> on the same CPU.
> 
> Possible deadlock scenario
> bcm_vk_open()
>     -> bcm_vk_get_ctx()
>     -> spin_lock(&vk->ctx_lock)
> 	<timer iterrupt>
> 	-> bcm_vk_hb_poll()
> 	-> bcm_vk_blk_drv_access()
> 	-> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock, which reported the following
> warning when analyzing the linux kernel 6.4-rc7 release.
> 
> [Deadlock]: &vk->ctx_lock
>   [Interrupt]: bcm_vk_hb_poll
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>   [Locking Unit]: bcm_vk_ioctl
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1181
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
> 
> [Deadlock]: &vk->ctx_lock
>   [Interrupt]: bcm_vk_hb_poll
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>   [Locking Unit]: bcm_vk_ioctl
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1169
> 
> [Deadlock]: &vk->ctx_lock
>   [Interrupt]: bcm_vk_hb_poll
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>   [Locking Unit]: bcm_vk_open
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:216
> 
> [Deadlock]: &vk->ctx_lock
>   [Interrupt]: bcm_vk_hb_poll
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
>   [Locking Unit]: bcm_vk_release
>     -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:306
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---

You do not mention how you tested to verify that your change is correct
:(

