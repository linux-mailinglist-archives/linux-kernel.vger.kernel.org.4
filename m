Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C416663CB05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiK2WZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiK2WZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:25:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411976D964
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:25:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB02161959
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD4C433D6;
        Tue, 29 Nov 2022 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669760715;
        bh=MTi3eCesRlzQNLX++3E0N9zK19ByIHxrBbpWGeJzPsc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bcuwe4011W1EV7m7lqiLQCoubqhZSBuRQ4IFeHON2n+irELW9/XO4T1BNRrd3sFQG
         C8iloTFvWqOLLjrasPmVZmRvL21w4m6XgrxeaQN0n4oMWpI5BcMR7N1pRcEDfOKd6l
         qXAWhElGrrP2DeS840ArAoGgl089SvzMDKI7/ex75BkDHXInBDU4I0NddEENZLVRQv
         iicP73qxnn1g0HG4cOdXTIzzhHBtWPP3wYxFDpAREURYvnonHpJ2DMGLPlUgEZrEnZ
         1AFf1zpagYRmQrVpTa5kXCcEa1QdfAR0C2uN9O1uzX9dqGVrTqTYdfMPg4D8nRlPOF
         ycJ+Oe2l21X8A==
Date:   Tue, 29 Nov 2022 14:25:12 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Roger Pau Monne <roger.pau@citrix.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] hvc/xen: lock console list traversal
In-Reply-To: <20221129143145.4234-1-roger.pau@citrix.com>
Message-ID: <alpine.DEB.2.22.394.2211291416540.4039@ubuntu-linux-20-04-desktop>
References: <20221129143145.4234-1-roger.pau@citrix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-503985613-1669760387=:4039"
Content-ID: <alpine.DEB.2.22.394.2211291420410.4039@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-503985613-1669760387=:4039
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2211291420411.4039@ubuntu-linux-20-04-desktop>

On Tue, 29 Nov 2022, Roger Pau Monne wrote:
> The currently lockless access to the xen console list in
> vtermno_to_xencons() is incorrect, as additions and removals from the
> list can happen anytime, and as such the traversal of the list to get
> the private console data for a given termno needs to happen with the
> lock held.  Note users that modify the list already do so with the
> lock taken.
> 
> While there switch from using list_for_each_entry_safe to
> list_for_each_entry: the current entry cursor won't be removed as
> part of the code in the loop body, so using the _safe variant is
> pointless.
> 
> Fixes: 02e19f9c7cac ('hvc_xen: implement multiconsole support')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
>  drivers/tty/hvc/hvc_xen.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> index d65741983837..117dc48f980e 100644
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -53,17 +53,22 @@ static DEFINE_SPINLOCK(xencons_lock);
>  
>  static struct xencons_info *vtermno_to_xencons(int vtermno)
>  {
> -	struct xencons_info *entry, *n, *ret = NULL;
> +	struct xencons_info *entry, *ret = NULL;
> +	unsigned long flags;
>  
> -	if (list_empty(&xenconsoles))
> -			return NULL;
> +	spin_lock_irqsave(&xencons_lock, flags);

If xencons_lock requires irqsave then we need to change all the
xencons_lock spinlocks to call irqsave, including the ones in
xen_hvm_console_init if they can happen at runtime.


> +	if (list_empty(&xenconsoles)) {
> +		spin_unlock_irqrestore(&xencons_lock, flags);
> +		return NULL;
> +	}
>  
> -	list_for_each_entry_safe(entry, n, &xenconsoles, list) {
> +	list_for_each_entry(entry, &xenconsoles, list) {
>  		if (entry->vtermno == vtermno) {
>  			ret  = entry;
>  			break;
>  		}
>  	}
> +	spin_unlock_irqrestore(&xencons_lock, flags);
>  
>  	return ret;
>  }
> -- 
> 2.37.3
> 
--8323329-503985613-1669760387=:4039--
