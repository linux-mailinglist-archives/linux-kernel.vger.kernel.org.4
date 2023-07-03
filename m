Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FDB745D11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGCNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGCNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69986E64
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A7360DCF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39712C433C9;
        Mon,  3 Jul 2023 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688390649;
        bh=VZy2IJH5Zp0zLi0PzjAHnGOCdKj0aY+Y8o+P9lCkN1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8F8HmNdG9BW6Pn4dfstQ/++oGyIpGpnFDwBv6EyIJeOEdyYDkgIV5YWLJfCW0+tC
         o6mCKWnNKCf2IN6T7HZx9RGCl7mo5S7T9t2qvOoBcXxXlYC5buXgKjENv8PgmitGG9
         4npV7+PBamAUU6t68b1Z1l6Ci2FxPDe5d2TyfGDI=
Date:   Mon, 3 Jul 2023 15:23:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tuo Li <islituo@gmail.com>
Cc:     dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        BassCheck <bass@buaa.edu.cn>
Subject: Re: [PATCH] staging: greybus: fix a possible data-inconsistency due
 to data race in get_serial_info()
Message-ID: <2023070352-upscale-bankable-76a7@gregkh>
References: <20230626084339.998784-1-islituo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626084339.998784-1-islituo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 04:43:39PM +0800, Tuo Li wrote:
> The variables gb_tty->port.close_delay and gb_tty->port.closing_wait are
> ofter accessed together while holding the lock gb_tty->port.mutex. Here is 
> an example in set_serial_info():
> 
>   mutex_lock(&gb_tty->port.mutex);
>   ...
>   gb_tty->port.close_delay = close_delay;
>   gb_tty->port.closing_wait = closing_wait;
>   ...
>   mutex_unlock(&gb_tty->port.mutex);
> 
> However, they are accessed without holding the lock gb_tty->port.mutex when
> are accessed in get_serial_info():
> 
>   ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
>   ss->closing_wait =
>     gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
> 	ASYNC_CLOSING_WAIT_NONE :
> 	jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
> 
> In my opinion, this may be a harmful race, because ss->close_delay can be
> inconsistent with ss->closing_wait if gb_tty->port.close_delay and 
> gb_tty->port.closing_wait are updated by another thread after the 
> assignment to ss->close_delay.

And how can that happen?

Also you have trailing whitespace in your changelog text :(

> Besides, the select operator may return wrong value if 
> gb_tty->port.closing_wait is updated right after the condition is 
> calculated.
> 
> To fix this possible data-inconsistency caused by data race, a lock and 
> unlock pair is added when accessing different fields of gb_tty->port.
> 
> Reported-by: BassCheck <bass@buaa.edu.cn>

As per the documentation for research tools like this, you need to
explain how this was tested.

thanks,

greg k-h
