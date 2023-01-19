Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09719674C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjATFhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjATFgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EAF6A321;
        Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9151B81FA3;
        Thu, 19 Jan 2023 15:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AAFC433EF;
        Thu, 19 Jan 2023 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674142014;
        bh=useU+uANukMgpidI0uVpvCQvU70XlFR37MZovPoK+Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3GsC2omAofoWLQLlGR0sdipno0JMDjcRNwAIugS62ibq7Xb/46rxGtnDBVpQUCst
         YkyUNd9sSM3a7j1EN7wA+EWIANWbQtaOO1XpwbCMnaw2OJGpWMnOZX3YoCche8bkKU
         cPe9g73+HifAjk8p04a/nM2Ni+UmX8sEXHUbuQYs=
Date:   Thu, 19 Jan 2023 16:26:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH V3 2/2] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Message-ID: <Y8lhOxIwz6dZlNnz@kroah.com>
References: <20230119102547.26698-1-jonathanh@nvidia.com>
 <20230119102547.26698-2-jonathanh@nvidia.com>
 <Y8kfdm9juBi58bnj@kroah.com>
 <e0e3fb48-1c7a-f012-5308-4897bab01dfc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e3fb48-1c7a-f012-5308-4897bab01dfc@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:38:15PM +0000, Jon Hunter wrote:
> 
> On 19/01/2023 10:46, Greg Kroah-Hartman wrote:
> 
> ...
> 
> > In looking at this further, you are right, the structures are not
> > initialized properly yet.
> > 
> > So move these to a different function entirely, they should be in
> > gether_register_netdev() instead, after the device is registered with
> > the system.
> 
> 
> I wonder if this is even necessary. Looking at gether_register_netdev() it
> already has ...
> 
>  status = register_netdev(net);
>  if (status < 0) {
>          dev_dbg(&g->dev, "register_netdev failed, %d\n", status);
>          return status;
>  } else {
>          INFO(dev, "HOST MAC %pM\n", dev->host_mac);
>          INFO(dev, "MAC %pM\n", dev->dev_mac);

Those need to be moved to be dev_info() and then I'll stop complaining :)
Or dev_dbg() if you want to make it debug only.

>          ...
>  }
> 
> 
> Any objection to just removing completely from gether_setup_name_default()?

Nope!

Remove them and change the above lines and then all should be good.

thanks,

greg k-h
