Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A97735ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFSPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFSPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:07:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862410E3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:07:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8fa2cf847so33263055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687187243; x=1689779243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bF1I6NOSdp0boAf3cXOANw0nNn9CysmZuzWnMKWJE0I=;
        b=SrPWQcAEv7ZEoYcC8y8MMQNNWLHc1GpyA6auFe7qqTmoSTdAG4zGOFlWJMGDKWtS5x
         xWIbPEYVAOeIYpHIyQgMD7aS+RTuzuorwpbw3bHVG1HuI4QbMzrEII71nS/fm1lD2Z+g
         bxLOHKnGz+27eJo0cqJ+Fd3oJ8PTB1syga2KiQeUNG6x9NxpEYYIyPtdW76Gw/dQQn4y
         QyqD/x7KbePA1kfEMKvXitvWgcGsKC+TlB3t+1alItQJ7/liWQERVcVdeVSktrnN2v1H
         Xq97jb7GQjKCqvLSkclRKhfuH4EwWVrgsRPZ7SObpFy02wRLUxgK8sSj7F5N+4NrSWZ5
         7aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187243; x=1689779243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF1I6NOSdp0boAf3cXOANw0nNn9CysmZuzWnMKWJE0I=;
        b=NeWakUGCIMIDQxYtsuHAkfZACWr/V5F4cbrllRJnFtHABAEK4llVuzkcUM0RA3WtIm
         zoKbITj4Ed3NszwM4Kg9VUeyYxbkyNvkJxhtSwQRZs3o/dnlz3P900+u0EMe2vhX3Oj7
         JVDPRW1PhXt67i8T/a6dN6S0tj6h2iore0UPhMRdePa4ok+AdC4yGjGTEvZwG3P6AGVO
         Ao2GY634ONHXcEN+auMjJ3DTWmPFXnXCheR6/lZ1DKUk9qW/9c8n2Mx1QHFdw2b6JnHs
         BME07R0PlTcQ26Q6zee9zAFZgXojqaiH72TqM1weCyLOkB3eetvgDc/2odGVL7oaD+pq
         hRYQ==
X-Gm-Message-State: AC+VfDxAZqnj9I43AOPJ5bX79b/TgAHPH1manlBmqUD7UpG3+1KQux8/
        6L9j9wiYMHGDaQQVgpQhM1Xq4Q==
X-Google-Smtp-Source: ACHHUZ4QpXrVdOPChzthrRJNQWsZ8TKLv4ekV8Mc6yMvkXImHSiDzCzJNSGfU3pYEHGWIyzBS27jMQ==
X-Received: by 2002:a05:600c:ad9:b0:3f6:2ee:6993 with SMTP id c25-20020a05600c0ad900b003f602ee6993mr8284670wmr.4.1687187242946;
        Mon, 19 Jun 2023 08:07:22 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h22-20020a1ccc16000000b003f7ed463954sm11023934wmb.25.2023.06.19.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:07:22 -0700 (PDT)
Date:   Mon, 19 Jun 2023 17:07:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de
Subject: Re: [PATCH net v2] ice: Unregister netdev and devlink_port only once
Message-ID: <ZJBvKVf7Yfh6WpsO@nanopsycho>
References: <20230619105813.369912-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619105813.369912-1-poros@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jun 19, 2023 at 12:58:13PM CEST, poros@redhat.com wrote:
>Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
>functions") ice_vsi_release does things twice. There is unregister
>netdev which is unregistered in ice_deinit_eth also.

You need to describe more relationship between ice_vsi_release() and
ice_deinit_eth(). From a quick look, I don't see that ice_deinit_eth()
is always called before/afeter ice_vsi_release().

Ice init/release flows are very hard to follow :/


>
>It also unregisters the devlink_port twice which is also unregistered
>in ice_deinit_eth(). This double deregistration is hidden because
>devl_port_unregister ignores the return value of xa_erase.

This call for another patch, doesn't it? :)


>
>[   68.642167] Call Trace:
>[   68.650385]  ice_devlink_destroy_pf_port+0xe/0x20 [ice]
>[   68.655656]  ice_vsi_release+0x445/0x690 [ice]
>[   68.660147]  ice_deinit+0x99/0x280 [ice]
>[   68.664117]  ice_remove+0x1b6/0x5c0 [ice]
>
>[  171.103841] Call Trace:
>[  171.109607]  ice_devlink_destroy_pf_port+0xf/0x20 [ice]
>[  171.114841]  ice_remove+0x158/0x270 [ice]
>[  171.118854]  pci_device_remove+0x3b/0xc0
>[  171.122779]  device_release_driver_internal+0xc7/0x170
>[  171.127912]  driver_detach+0x54/0x8c
>[  171.131491]  bus_remove_driver+0x77/0xd1
>[  171.135406]  pci_unregister_driver+0x2d/0xb0
>[  171.139670]  ice_module_exit+0xc/0x55f [ice]
>
>Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
>v2: reword subject
>
>v1: https://lore.kernel.org/netdev/20230619084948.360128-1-poros@redhat.com/
>---
> drivers/net/ethernet/intel/ice/ice_lib.c | 27 ------------------------
> 1 file changed, 27 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>index 11ae0e41f518a1..284a1f0bfdb545 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lib.c
>+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>@@ -3272,39 +3272,12 @@ int ice_vsi_release(struct ice_vsi *vsi)
> 		return -ENODEV;
> 	pf = vsi->back;
> 
>-	/* do not unregister while driver is in the reset recovery pending
>-	 * state. Since reset/rebuild happens through PF service task workqueue,
>-	 * it's not a good idea to unregister netdev that is associated to the
>-	 * PF that is running the work queue items currently. This is done to
>-	 * avoid check_flush_dependency() warning on this wq
>-	 */
>-	if (vsi->netdev && !ice_is_reset_in_progress(pf->state) &&
>-	    (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state))) {
>-		unregister_netdev(vsi->netdev);
>-		clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
>-	}
>-
>-	if (vsi->type == ICE_VSI_PF)
>-		ice_devlink_destroy_pf_port(pf);
>-
> 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
> 		ice_rss_clean(vsi);
> 
> 	ice_vsi_close(vsi);
> 	ice_vsi_decfg(vsi);
> 
>-	if (vsi->netdev) {
>-		if (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state)) {
>-			unregister_netdev(vsi->netdev);
>-			clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
>-		}
>-		if (test_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state)) {
>-			free_netdev(vsi->netdev);
>-			vsi->netdev = NULL;
>-			clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
>-		}
>-	}
>-
> 	/* retain SW VSI data structure since it is needed to unregister and
> 	 * free VSI netdev when PF is not in reset recovery pending state,\
> 	 * for ex: during rmmod.
>-- 
>2.41.0
>
>
