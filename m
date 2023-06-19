Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE89273527B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjFSKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFSKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:35:04 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB310D0;
        Mon, 19 Jun 2023 03:34:54 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 79B7061E5FE04;
        Mon, 19 Jun 2023 12:34:08 +0200 (CEST)
Message-ID: <bc3e9167-cdea-1efb-6d5c-57df43564d37@molgen.mpg.de>
Date:   Mon, 19 Jun 2023 12:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH net] ice: ice_vsi_release cleanup
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
References: <20230619084948.360128-1-poros@redhat.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230619084948.360128-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Petr,


Thank you for your patch.

Am 19.06.23 um 10:49 schrieb Petr Oros:
> Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
> functions") ice_vsi_release does things twice. There is unregister
> netdev which is unregistered in ice_deinit_eth also.
> 
> It also unregisters the devlink_port twice which is also unregistered
> in ice_deinit_eth(). This double deregistration is hidden because
> devl_port_unregister ignores the return value of xa_erase.
> 
> [   68.642167] Call Trace:
> [   68.650385]  ice_devlink_destroy_pf_port+0xe/0x20 [ice]
> [   68.655656]  ice_vsi_release+0x445/0x690 [ice]
> [   68.660147]  ice_deinit+0x99/0x280 [ice]
> [   68.664117]  ice_remove+0x1b6/0x5c0 [ice]
> 
> [  171.103841] Call Trace:
> [  171.109607]  ice_devlink_destroy_pf_port+0xf/0x20 [ice]
> [  171.114841]  ice_remove+0x158/0x270 [ice]
> [  171.118854]  pci_device_remove+0x3b/0xc0
> [  171.122779]  device_release_driver_internal+0xc7/0x170
> [  171.127912]  driver_detach+0x54/0x8c
> [  171.131491]  bus_remove_driver+0x77/0xd1
> [  171.135406]  pci_unregister_driver+0x2d/0xb0
> [  171.139670]  ice_module_exit+0xc/0x55f [ice]

It’d be more specific in the commit message summary/title, and use 
imperative mood. Maybe:

ice: Unregister netdev and devlink_port only once


Kind regards,

Paul


> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 27 ------------------------
>   1 file changed, 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 11ae0e41f518a1..284a1f0bfdb545 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3272,39 +3272,12 @@ int ice_vsi_release(struct ice_vsi *vsi)
>   		return -ENODEV;
>   	pf = vsi->back;
>   
> -	/* do not unregister while driver is in the reset recovery pending
> -	 * state. Since reset/rebuild happens through PF service task workqueue,
> -	 * it's not a good idea to unregister netdev that is associated to the
> -	 * PF that is running the work queue items currently. This is done to
> -	 * avoid check_flush_dependency() warning on this wq
> -	 */
> -	if (vsi->netdev && !ice_is_reset_in_progress(pf->state) &&
> -	    (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state))) {
> -		unregister_netdev(vsi->netdev);
> -		clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
> -	}
> -
> -	if (vsi->type == ICE_VSI_PF)
> -		ice_devlink_destroy_pf_port(pf);
> -
>   	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>   		ice_rss_clean(vsi);
>   
>   	ice_vsi_close(vsi);
>   	ice_vsi_decfg(vsi);
>   
> -	if (vsi->netdev) {
> -		if (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state)) {
> -			unregister_netdev(vsi->netdev);
> -			clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
> -		}
> -		if (test_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state)) {
> -			free_netdev(vsi->netdev);
> -			vsi->netdev = NULL;
> -			clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
> -		}
> -	}
> -
>   	/* retain SW VSI data structure since it is needed to unregister and
>   	 * free VSI netdev when PF is not in reset recovery pending state,\
>   	 * for ex: during rmmod.
