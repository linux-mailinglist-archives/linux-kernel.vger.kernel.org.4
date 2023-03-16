Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449D6BCD52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCPKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F4132F4;
        Thu, 16 Mar 2023 03:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E675461FD7;
        Thu, 16 Mar 2023 10:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04473C433D2;
        Thu, 16 Mar 2023 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678964114;
        bh=GNoAw3ikEh3W3g980B7rf3JVGouCAtGTNiSXFrXueUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1t/5teFHT0tvX5yBfh9t5A7gKcH7wIa2orfTLyyxoBVcGVIUCvU8HBFGy4lSStIp
         /bGfYV7OlsWQVIcZawNigSIoaWBQoku4gextrgClqSC2ERpasAYyxUo845fAdrAqUV
         ylPrvGngQlieh/pEHCYi0W+Ly7LA6+3MJHC//qxw=
Date:   Thu, 16 Mar 2023 11:55:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        yoshihiro.shimoda.uh@renesas.com
Subject: Re: [PATCH v3] usb: gadget: udc: renesas_usb3: Fix use after free
 bug in  renesas_usb3_remove due to race condition
Message-ID: <ZBL1jyAQJ2YPsKUe@kroah.com>
References: <20230313165128.3763626-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313165128.3763626-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:51:28AM +0800, Zheng Wang wrote:
> In renesas_usb3_probe, &usb3->role_work is bound with
> renesas_usb3_role_work. renesas_usb3_start will be called
> to start the work.
> 
> If we remove the driver which will call usbhs_remove, there may be
> an unfinished work. The possible sequence is as follows:
> 
> Fix it by canceling the work before cleanup in the renesas_usb3_remove
> 
> CPU0                  CPU1
> 
>                     |renesas_usb3_role_work
> renesas_usb3_remove |
> usb_role_switch_unregister  |
> device_unregister   |
> kfree(sw)  	     |
> free usb3->role_sw  |
>                     |   usb_role_switch_set_role
>                     |   //use usb3->role_sw
> 
> Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v3:
> - modify the commit message to make it clearer suggested by Yoshihiro Shimoda

I see 2 v3 patches in the mailing list, which is obviously not correct.

Please resubmit a v4 properly.

thanks,

greg k-h
