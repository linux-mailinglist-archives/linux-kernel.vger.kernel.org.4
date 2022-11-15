Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723C62A0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiKORyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiKORy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:54:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F112D779
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E94B81A58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0CFC433C1;
        Tue, 15 Nov 2022 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668534865;
        bh=6QXetUZ9NuynZots00MOoho0DAnY080leHb3dJe2z0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXyx/Sxt0DO1qzZJdASD5NW/Uy2jBjGnEhmsvsO5Lyx94tBqhPEdhQNgXEl/b2XeY
         flIobGWj35uhPOdzshhjTlHvwCTkDANWMA1YF4OEY4s/yRjvn1y0673SH5pUtCL49k
         XKO2qb+UsANF22XvRZS/L2pmvAKl9u21ba800UH8=
Date:   Tue, 15 Nov 2022 18:54:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        akpm@linux-foundation.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH] tty: synclink_gt: unwind actions in error path of net
 device open
Message-ID: <Y3PSTmUD37e0hsyr@kroah.com>
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
 <4DFE07D7-B041-4C1C-8182-020066D4A5C2@microgate.com>
 <387F9F7B-C3AF-45BF-94ED-59348990B407@microgate.com>
 <Y3PIA04FCxqv3eKn@kroah.com>
 <7599F007-8985-4469-BE00-52BD1530210E@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7599F007-8985-4469-BE00-52BD1530210E@microgate.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:38:32AM -0800, Paul Fulghum wrote:
> Resent again, last attempt still altered the plain text.
> 

Please send a v2 patch, and this is not needed as it would show up in
the commit log if we were to apply it, right?

> 
> Zhengchao Shao <shaozhengchao@huawei.com> identified by inspection bugs in the error path of hdlcdev_open() in synclink_gt.c

Properly wrap your lines at 72 columns please.

> 
> The function did not fully unwind actions in the error path. The use of try_module_get()/module_put() is unnecessary, potentially hazardous and is removed. The synclink_gt driver is already pinned any point the net device is registered, a requirement for calling this entry point.
> 
> The call hdlc_open() to init the generic HDLC layer is moved to after driver level init/checks and proper rollback of previous actions is added. This is a more sensible ordering as the most common error paths are at the driver level and the driver level rollbacks require less processing than hdlc_open()/hdlc_close().
> 
> This has been tested with supported hardware.
> 
> Signed-off-by:Paul Fulghum <paulkf@microgate.com>

You need a Suggested-by: tag here.

And a space after the ':' character.

> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 25e9befdda3a..72b76cdde534 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -1433,16 +1433,8 @@ static int hdlcdev_open(struct net_device *dev)
>  	int rc;
>  	unsigned long flags;
>  
> -	if (!try_module_get(THIS_MODULE))
> -		return -EBUSY;

Thank you for removing this, this code pattern is always wrong :)

thanks,

greg k-h
