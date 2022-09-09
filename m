Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B885B3E93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiIISIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiIISIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF39B0892;
        Fri,  9 Sep 2022 11:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B96C8B82346;
        Fri,  9 Sep 2022 18:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E65FC433D6;
        Fri,  9 Sep 2022 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662746922;
        bh=UqFrMUS7uVyZgt5ZJ3WvaAiqSxliO2m0t8Iqh7aq+Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUbs+oYDKtHXOLJvcVeMB32yxacBCpjnvG86SCQJcUaaZWESt4OEcAFvilvH0GH99
         bUx2/EmhdIPCK2tVzwmuKFyp9+t6c6G0VJGZn1ztwJACo/MAEaxHAjQdn3S7BLjnsC
         jNdbl84a1zMOBZjdf1Yw3G8EaA+szIVNb5gizDlE=
Date:   Fri, 9 Sep 2022 20:08:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>, x86@kernel.org
Subject: Re: [tip: sched/psi] class: use IS_ERR_OR_NULL() helper in
 class_unregister()
Message-ID: <YxuBKKe1CVw7RWlc@kroah.com>
References: <20220822061922.3884113-1-yangyingliang@huawei.com>
 <166273202287.401.13504362798914698931.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166273202287.401.13504362798914698931.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:00:22PM -0000, tip-bot2 for Yang Yingliang wrote:
> The following commit has been merged into the sched/psi branch of tip:
> 
> Commit-ID:     e9628e015fe205f10766f031f17e217f85650570
> Gitweb:        https://git.kernel.org/tip/e9628e015fe205f10766f031f17e217f85650570
> Author:        Yang Yingliang <yangyingliang@huawei.com>
> AuthorDate:    Mon, 22 Aug 2022 14:19:22 +08:00
> Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitterDate: Thu, 01 Sep 2022 18:15:40 +02:00
> 
> class: use IS_ERR_OR_NULL() helper in class_unregister()
> 
> Use IS_ERR_OR_NULL() helper in class_unregister() to simplify code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Link: https://lore.kernel.org/r/20220822061922.3884113-1-yangyingliang@huawei.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 8feb85e..64f7b9a 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(__class_create);
>   */
>  void class_destroy(struct class *cls)
>  {
> -	if ((cls == NULL) || (IS_ERR(cls)))
> +	if (IS_ERR_OR_NULL(cls))
>  		return;
>  
>  	class_unregister(cls);

Any specific reason you pulled in my driver-core branch into tip?

confused,

greg k-h
