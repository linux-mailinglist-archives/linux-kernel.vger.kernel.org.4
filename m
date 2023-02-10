Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315B76918CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjBJGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjBJGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:55:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519A35242;
        Thu,  9 Feb 2023 22:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8FF9B823F2;
        Fri, 10 Feb 2023 06:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5E8C433D2;
        Fri, 10 Feb 2023 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676012115;
        bh=LFkUV8fHq0P/xykC0A1l4YWNRaeM4NlQSLGmoTNh4O4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qAt69rXVc6uPzcNcMfIWe5PFMfsrUmoww3LfkaHZDvvwXBAaSK71vyllpPOXgYqpI
         cKpSwf0DwwjAy/nvOqA+6mE0zEG/lfyRsY8fzzCCwJCDk2JEHpeg7DI3TO0S1Frc6L
         u0WdPKRizixGeOXcTJJb/ie0YgNiRXmRTK3hBN2+kvwR+jRiyjHmO06KyBfS79tdWO
         fTUXYxiEszomXP0BUBw0QLHgbizlVYPvX59R6PmXMDBQbK4ACitgi5UDlRuzRV+NH0
         68HdyWDAnQv0aJzDDz5KnHMQsLo5rIibfAp206ODt6bKwjQ4h0iCQPrSBYDyaXWl18
         LDlDv9R4iCnEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3072F5C1B2E; Thu,  9 Feb 2023 22:55:15 -0800 (PST)
Date:   Thu, 9 Feb 2023 22:55:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the rcu
 tree
Message-ID: <20230210065515.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230210124818.2caaa77f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210124818.2caaa77f@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:48:18PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   drivers/base/core.c
> 
> between commit:
> 
>   dc7c31b07ade ("drivers/base: Remove CONFIG_SRCU")
> 
> from the rcu tree and commit:
> 
>   3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
> 
> from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I have added this to my list of conflicts, thank you!

							Thanx, Paul

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/base/core.c
> index bb36aca8d1b7,2712a1a1e959..000000000000
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@@ -181,6 -202,52 +202,51 @@@ void fw_devlink_purge_absent_suppliers(
>   }
>   EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
>   
> + /**
> +  * __fwnode_links_move_consumers - Move consumer from @from to @to fwnode_handle
> +  * @from: move consumers away from this fwnode
> +  * @to: move consumers to this fwnode
> +  *
> +  * Move all consumer links from @from fwnode to @to fwnode.
> +  */
> + static void __fwnode_links_move_consumers(struct fwnode_handle *from,
> + 					  struct fwnode_handle *to)
> + {
> + 	struct fwnode_link *link, *tmp;
> + 
> + 	list_for_each_entry_safe(link, tmp, &from->consumers, s_hook) {
> + 		__fwnode_link_add(link->consumer, to, link->flags);
> + 		__fwnode_link_del(link);
> + 	}
> + }
> + 
> + /**
> +  * __fw_devlink_pickup_dangling_consumers - Pick up dangling consumers
> +  * @fwnode: fwnode from which to pick up dangling consumers
> +  * @new_sup: fwnode of new supplier
> +  *
> +  * If the @fwnode has a corresponding struct device and the device supports
> +  * probing (that is, added to a bus), then we want to let fw_devlink create
> +  * MANAGED device links to this device, so leave @fwnode and its descendant's
> +  * fwnode links alone.
> +  *
> +  * Otherwise, move its consumers to the new supplier @new_sup.
> +  */
> + static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
> + 						   struct fwnode_handle *new_sup)
> + {
> + 	struct fwnode_handle *child;
> + 
> + 	if (fwnode->dev && fwnode->dev->bus)
> + 		return;
> + 
> + 	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
> + 	__fwnode_links_move_consumers(fwnode, new_sup);
> + 
> + 	fwnode_for_each_available_child_node(fwnode, child)
> + 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
> + }
> + 
>  -#ifdef CONFIG_SRCU
>   static DEFINE_MUTEX(device_links_lock);
>   DEFINE_STATIC_SRCU(device_links_srcu);
>   


