Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C05E9C27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiIZIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiIZIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D721801
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6841618BC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA809C433C1;
        Mon, 26 Sep 2022 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664181376;
        bh=OQG5qDdXqyfqrCnb2aKHQ18w2I1CQolaz1GplFQGCYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vd2Sq4F1NVL+Q4o07xq7d5sN/B/AdljC70kqf+PEqHiqkmGdSwq7EK0lbPdiG7MJ4
         OBzpzsDgLLUpKg3vurC2n+9VLTWjModyf2ZrByMQzHPiDZ5fTR22+M+33cviJw61Dr
         sOxrwmXvBFu19sRRTO78SdbLOati7SoGVMjzxLtQ=
Date:   Mon, 26 Sep 2022 10:36:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
        rafael@kernel.org
Subject: Re: [PATCH V10] devcoredump: add context check in dev_coredumpm
Message-ID: <YzFkfX0gOsOdtcGf@kroah.com>
References: <20220926065126.46080-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926065126.46080-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:51:26PM +0800, Duoming Zhou wrote:
> The dev_coredumpm(), dev_coredumpv() and dev_coredumpsg() could not
> be used in atomic context, because they call kvasprintf_const() and
> kstrdup() with GFP_KERNEL parameter. The process is shown below:
> 
> dev_coredumpv(.., gfp_t gfp)
>   dev_coredumpm(.., gfp_t gfp)
>     dev_set_name
>       kobject_set_name_vargs
>         kvasprintf_const(GFP_KERNEL, ...); //may sleep
>           kstrdup(s, GFP_KERNEL); //may sleep
> 
> This patch adds context check in dev_coredumpm() in order to show
> dev_coredumpm() and its callers could not be used in atomic context.
> 
> What's more, this change can allow the api to evolve and will not
> influence the users that call this api.
> 
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes since v9:
>   - v9: Add context check in dev_coredumpm().
>   - v10: Remove the "Fixes" tag.
> 
>  drivers/base/devcoredump.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f4d794d6bb8..806ee872f5f 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -255,6 +255,9 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	struct devcd_entry *devcd;
>  	struct device *existing;
>  
> +	if (!gfpflags_normal_context(gfp))
> +		goto free;

I still do not know why this is needed at all as there are no in-kernel
abusers of this api.

We do not add code to the kernel for out-of-tree users, or "future
users" at all, otherwise it would be unmaintable.

thanks,

greg k-h
