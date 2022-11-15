Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB362A18D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiKOSsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiKOSsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:48:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C42F00F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:48:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA0A6195B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E733C433D6;
        Tue, 15 Nov 2022 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668538097;
        bh=4h2pLemwieK+6X9ajdqA8ftjo1wxmsuup5HG2B6pxco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z83pzcQOuZqb2h3fNAbU18Y+hZu25jBrKl096793e+BmmFYSXzL46HyV0yhCzAkri
         FLhhAx+oUevjwyuD9v/wO0gsUZXaEFyXn+VvALoboJJOjQtukSsVuSjVoRWyt+VuXO
         8dKgEPCJqAI9mgl3V3aaKtCHbLfsfYQyFNtxaIxo=
Date:   Tue, 15 Nov 2022 19:48:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        akpm@linux-foundation.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH] tty: synclink_gt: unwind actions in error path of net
 device open
Message-ID: <Y3Pe7/OSZ95ziQUf@kroah.com>
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
 <2b501d50-6777-a34f-7373-6648ed418794@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b501d50-6777-a34f-7373-6648ed418794@microgate.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:21:14AM -0800, Paul Fulghum wrote:
> hdlcdev_open() in synclink_gt.c did not fully unwind actions
> in the error path. The use of try_module_get()/module_put() is unnecessary,
> potentially hazardous and is removed. The synclink_gt driver is already
> pinned any point the net device is registered, a requirement for calling
> this entry point.
> 
> The call hdlc_open() to init the generic HDLC layer is moved to
> after driver level init/checks and proper rollback of previous
> actions is added. This is a more sensible ordering as the
> most common error paths are at the driver level and the driver
> level rollbacks require less processing than
> hdlc_open()/hdlc_close().
> 
> This has been tested with supported hardware.
> 
> Suggested-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 25e9befdda3a..72b76cdde534 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -1433,16 +1433,8 @@ static int hdlcdev_open(struct net_device *dev)
>      int rc;
>      unsigned long flags;
> 
> -    if (!try_module_get(THIS_MODULE))
> -        return -EBUSY;
> -
>      DBGINFO(("%s hdlcdev_open\n", dev->name));
> 
> -    /* generic HDLC layer open processing */
> -    rc = hdlc_open(dev);
> -    if (rc)
> -        return rc;
> -
>      /* arbitrate between network and tty opens */
>      spin_lock_irqsave(&info->netlock, flags);
>      if (info->port.count != 0 || info->netcount != 0) {
> @@ -1461,6 +1453,16 @@ static int hdlcdev_open(struct net_device *dev)
>          return rc;
>      }
> 
> +    /* generic HDLC layer open processing */
> +    rc = hdlc_open(dev);
> +    if (rc) {
> +        shutdown(info);
> +        spin_lock_irqsave(&info->netlock, flags);
> +        info->netcount = 0;
> +        spin_unlock_irqrestore(&info->netlock, flags);
> +        return rc;
> +    }
> +
>      /* assert RTS and DTR, apply hardware settings */
>      info->signals |= SerialSignal_RTS | SerialSignal_DTR;
>      program_hw(info);
> @@ -1506,7 +1508,6 @@ static int hdlcdev_close(struct net_device *dev)
>      info->netcount=0;
>      spin_unlock_irqrestore(&info->netlock, flags);
> 
> -    module_put(THIS_MODULE);
>      return 0;
>  }
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
