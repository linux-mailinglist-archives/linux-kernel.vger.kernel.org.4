Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99566BD89E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCPTHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjCPTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F7E5010;
        Thu, 16 Mar 2023 12:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07854620E6;
        Thu, 16 Mar 2023 19:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8071C433AF;
        Thu, 16 Mar 2023 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678993640;
        bh=uGo+TNuGlndNHFiLhi6grsFhe7Ry4dYw5sGomV6rZ3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPRqiGVYWCtEHD9QVOIPOizybJyksvCs+yCSxL1l+3Rr2DRU/OWrJ4f/KHtC2SmYu
         ptQVV70EbN++xUilEWfVgD+LacIACvOqdssMm4QPL+k5FtODTP5WCn+H8rlC9P3oT2
         vownkfjQ0didOEWNEDqQ86ZlZ7uQQRmfR1rN2e8s=
Date:   Thu, 16 Mar 2023 20:07:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     skhan@linuxfoundation.org, p.zabel@pengutronix.de,
        biju.das.jz@bp.renesas.com, phil.edworthy@renesas.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, yoshihiro.shimoda.uh@renesas.com
Subject: Re: [PATCH v7] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Message-ID: <ZBNo5gr1ILs5mR5z@kroah.com>
References: <20230316180850.1600867-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316180850.1600867-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:08:50AM +0800, Zheng Wang wrote:
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

This still isn't working :(

