Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050DF72FC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjFNLQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjFNLJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0371BC3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C498F629BB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84C3C433C8;
        Wed, 14 Jun 2023 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686740988;
        bh=QlLA8ehxT/VDQBjkSwCszlwern9Sc5B23YkkiyOKqUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Dvsaip/e3rSwQLYF2uKMQQ0FhSwfibEEHJRzl1bxV8Kt8EBXlSKgt1vtjw5mqv6Y
         BYEDnJ7Pjke3cJO3da1vvqKZ8sO6ZG2MJY/VvBkR5xo3po463zmUG6p7ibGRUK54g0
         sxMVML4nymFhYW8j5jI2Wp1X1WfLKZxBP2SiFe4Y=
Date:   Wed, 14 Jun 2023 13:09:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/mm_init.c: remove spinlock in early_pfn_to_nid()
Message-ID: <2023061431-litigate-upchuck-7ed1@gregkh>
References: <20230614110324.3839354-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614110324.3839354-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 07:03:24PM +0800, Yajun Deng wrote:
> When the system boots, only one cpu is enabled before smp_init().
> So the spinlock is not needed in most cases, remove it.
> 
> Add spinlock in get_nid_for_pfn() because it is after smp_init().

So this is two different things at once in the same patch?

Or are they the same problem and both need to go in to solve it?

And if a spinlock is not needed at early boot, is it really causing any
problems?

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/base/node.c | 11 +++++++++--
>  mm/mm_init.c        | 18 +++---------------
>  2 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 9de524e56307..844102570ff2 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -748,8 +748,15 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  static int __ref get_nid_for_pfn(unsigned long pfn)
>  {
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> -	if (system_state < SYSTEM_RUNNING)
> -		return early_pfn_to_nid(pfn);
> +	static DEFINE_SPINLOCK(early_pfn_lock);
> +	int nid;
> +
> +	if (system_state < SYSTEM_RUNNING) {
> +		spin_lock(&early_pfn_lock);
> +		nid = early_pfn_to_nid(pfn);
> +		spin_unlock(&early_pfn_lock);

Adding an external lock for when you call a function is VERY dangerous
as you did not document this anywhere, and there's no way to enforce it
properly at all.

Does your change actually result in any boot time changes?  How was this
tested?

thanks,

greg k-h
