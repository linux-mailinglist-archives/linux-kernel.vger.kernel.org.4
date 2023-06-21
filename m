Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB427388D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjFUPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjFUPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F5213B;
        Wed, 21 Jun 2023 08:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAAD61597;
        Wed, 21 Jun 2023 15:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD551C433C8;
        Wed, 21 Jun 2023 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687360977;
        bh=1myIkCNrGS9LjMUd1rt6ohpLBP7wjHK5DM7AyaPDCLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4NsEBbMaKKW3pbO+gVpbt0BLhgzmRAxMt40/S067cELpNYvZT9LPPpKoMLnPPNGg
         BmfNuqQDwhKNTrIuwc9IMuxSqIHr+CjbQ7vbNvPEDeS1vdBRg9TdxxDBdEarkQXoR6
         nFaW7MKeep+SvsTBiaGu/VxKWlD6DXfvHJN7XiUk=
Date:   Wed, 21 Jun 2023 17:22:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [RFC PATCH v5 2/4] driver core: Add dev_is_drv_state_synced()
Message-ID: <2023062103-chevron-sabotage-bf26@gregkh>
References: <20230621144019.3219858-1-abel.vesa@linaro.org>
 <20230621144019.3219858-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144019.3219858-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:40:17PM +0300, Abel Vesa wrote:
> This can be used by drivers to figure out if a different device
> driver has state synced or not for a specific device.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  include/linux/device.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index bae11928ef7e..8f042f04b5d9 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1007,6 +1007,20 @@ static inline int dev_set_drv_sync_state(struct device *dev,
>  	return 0;
>  }
>  
> +static inline bool dev_is_drv_state_synced(struct device *dev)
> +{
> +	bool ret = false;
> +
> +	if (!dev)
> +		return ret;
> +
> +	device_lock(dev);
> +	ret = dev->state_synced;
> +	device_unlock(dev);

This lock is "protecting" nothing, given that the value can instantly
change after it is read.

Because it can change, how will this function actually show anything
relevant?

thanks,

greg k-h
