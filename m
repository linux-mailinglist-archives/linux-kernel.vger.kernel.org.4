Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0693E69DE12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjBUKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjBUKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:42:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871F25E3C;
        Tue, 21 Feb 2023 02:42:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF606B80D3D;
        Tue, 21 Feb 2023 10:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E2CC433D2;
        Tue, 21 Feb 2023 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676976117;
        bh=DE9vnL0xEn5r7bfoQLsZRvOmJKRI5E/mHSct16mDAnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8rF7UgWgkmhVA5wGzDMr7PGpcTH4OkVIr+E9ZzeQqwsQgVzSBO5O+6q6yGxzCQQd
         t1Kj/ogBnBQay25NYYiq5rThVm87CNnQ1+6v0a3awWk1gjx9K/jgM/3Ij4P/WtwJzO
         V0Sb6U3YEiT+HNL9URTGCEk9qex6mRhz3xdQBHIs=
Date:   Tue, 21 Feb 2023 11:41:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     hminas@synopsys.com, fabrice.gasnier@foss.st.com,
        amelie.delaunay@foss.st.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Message-ID: <Y/Sf8j5y+DJ9L4fY@kroah.com>
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 06:30:04PM +0800, Ziyang Huang wrote:
> Some boards might use USB-A female connector for USB ports, however,
> the port could be connected to a dual-mode USB controller, making it
> also behaves as a peripheral device if male-to-male cable is connected.
> 
> In this case, the dts looks like this:
> 
> 	&usb0 {
> 		status = "okay";
> 		dr_mode = "otg";
> 		usb-role-switch;
> 		role-switch-default-mode = "host";
> 	};
> 
> After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
> dwc2_force_mode() with parameter host=false, which causes inconsistent
> mode - The hardware is in peripheral mode while the kernel status is
> in host mode.
> 
> What we can do now is to call dwc2_drd_role_sw_set() to switch to
> device mode, and everything should work just fine now, even switching
> back to none(default) mode afterwards.
> 
> Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support")
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
> Changes since v1
> - Use corrent name in Signed-off-by

Nope, still incorrect, please use your synopsys address.

thanks,

greg k-h
