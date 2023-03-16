Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D7D6BD7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCPSJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCPSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:09:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4B6286E;
        Thu, 16 Mar 2023 11:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFF68B822BB;
        Thu, 16 Mar 2023 18:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9700C433D2;
        Thu, 16 Mar 2023 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678990153;
        bh=dgZk1mYEbSTJIB6AL9Tpf7EyORYTvBcziphL6t30Lws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxZrpAC5ItcirZYzJFCyK4PsQaXny/d8XRpdyFDMeeYiZURWG/faYro27XhPksWQP
         z4Uy0GiCgzvMsj+PjCYtLveQgOSvSGVTz+1OVjnQpDRMcte+/T93MFJ6ueY81ouqMo
         XbrCbBmMFSm5MoJRarxH6nvV8QVbsg5Yh/xadec0=
Date:   Thu, 16 Mar 2023 19:09:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        yoshihiro.shimoda.uh@renesas.com
Subject: Re: [PATCH v6] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Message-ID: <ZBNbRrKaNomV4nyJ@kroah.com>
References: <20230316175457.1595921-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316175457.1595921-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:54:57AM +0800, Zheng Wang wrote:
> In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
> renesas_usb3_start will be called to start the work.
> 
> If we remove the driver which will call usbhs_remove, there may be
> an unfinished work. The possible sequence is as follows:
> 
> Fix it by canceling the work before cleanup in the renesas_usb3_remove.
> 
> Note that removing a driver is a root-only operation, and should never
> happen.
> 
> CPU0                  			CPU1
> 
>                     			| renesas_usb3_role_work
> renesas_usb3_remove 			|
> usb_role_switch_unregister|
> device_unregister   			|
> kfree(sw)  	     					|
> free usb3->role_sw  			|
>                     			| usb_role_switch_set_role
>                     			| //use usb3->role_sw

Please use spaces for this, as something went wrong and it does not line
up :(

