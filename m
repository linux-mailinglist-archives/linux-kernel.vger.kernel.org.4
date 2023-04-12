Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538EA6E023B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDLXCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 19:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 19:02:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABDB2729
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7SUfrFz0mc3pOskqmrn/fGJLZuselv7ZYfDdXsz1X2k=; b=WSxEmda1mOC6IT98ttfquXmPfA
        Y3EiFwuyY+gDAtHbi2h5Og13puWcjWcKthv6KQwoPIcyyUdw/bDPFNAfkaRZoPRQO7fX4Du9CNAug
        fSNZWuoX5Y2F0LZE8GwVMwaCrzaiPidVafzL/BZgiz32k57LindXtt2ztsVd/bGBo53hr3L6h+Be0
        upaJATSS0qrH1FLAtTUpUWYEVZbrX/V5kQGGSPXrPBFJ1W4XyKEv/NUly+dqTvkvESp9b83c5R4mC
        IPhfYWXWMuswJjaYpRhuXlvM53Wai2GMylajVUKr5s/Vnc314yYYLmUeYtJgXWKTwaP6s7x9hd4Cc
        0RW0HUcw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmjTl-004b1z-06;
        Wed, 12 Apr 2023 23:02:17 +0000
Message-ID: <ff3f7382-e741-e28f-80b7-bedc5fff81ba@infradead.org>
Date:   Wed, 12 Apr 2023 16:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] driver core: Don't require dynamic_debug for
 initcall_debug probe timing
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Brian Norris <briannorris@chromium.org>
References: <20230412225842.3196599-1-swboyd@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230412225842.3196599-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/23 15:58, Stephen Boyd wrote:
> Don't require the use of dynamic debug (or modification of the kernel to
> add a #define DEBUG to the top of this file) to get the printk message
> about driver probe timing. This printk is only emitted when
> initcall_debug is enabled on the kernel commandline, and it isn't
> immediately obvious that you have to do something else to debug boot
> timing issues related to driver probe. Add a comment too so it doesn't
> get converted back to pr_debug().
> 
> Fixes: eb7fbc9fb118 ("driver core: Add missing '\n' in log messages")
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Good one. Thanks for catching this.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/base/dd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8def2ba08a82..1b16e0fb7658 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -708,7 +708,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>  	calltime = ktime_get();
>  	ret = really_probe(dev, drv);
>  	rettime = ktime_get();
> -	pr_debug("probe of %s returned %d after %lld usecs\n",
> +	/*
> +	 * Don't change this to pr_debug() because that requires
> +	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
> +	 * kernel commandline to print this all the time at the debug level.
> +	 */
> +	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
>  		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
>  	return ret;
>  }
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

-- 
~Randy
