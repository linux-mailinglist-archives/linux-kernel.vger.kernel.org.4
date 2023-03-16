Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6634A6BD8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCPTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCPTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41ACE4DAC;
        Thu, 16 Mar 2023 12:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11874620ED;
        Thu, 16 Mar 2023 19:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED8AC433EF;
        Thu, 16 Mar 2023 19:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678993667;
        bh=7hugjXrg2VqTQxVzgi491yd1edNHLELY0M2HYSUgOHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Y28+lF1y/zmVTHGA/93wYPcrFuZxDCa+wk6MJhYay716frdpTlowrfkdP0D8iqdM
         Nr+g8E/hke62WbC85vVZLJN0vRRimymYsLiHY3gTwJb/w1GMPeLxW0fuzGtdilcb4Z
         Vf1vSAPcDZcVBmUyXjljSdCx3Cg90Vn0f2D0tmco=
Date:   Thu, 16 Mar 2023 20:07:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     skhan@linuxfoundation.org, p.zabel@pengutronix.de,
        biju.das.jz@bp.renesas.com, phil.edworthy@renesas.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, yoshihiro.shimoda.uh@renesas.com
Subject: Re: [PATCH v8] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Message-ID: <ZBNpAJOqeoqc23Y2@kroah.com>
References: <20230316181623.1603914-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316181623.1603914-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:16:23AM +0800, Zheng Wang wrote:
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
>                     			 renesas_usb3_role_work
> renesas_usb3_remove
> usb_role_switch_unregister
> device_unregister
> kfree(sw)
> free usb3->role_sw
>                     			 usb_role_switch_set_role
>                     			 //use usb3->role_sw

No line at all?

