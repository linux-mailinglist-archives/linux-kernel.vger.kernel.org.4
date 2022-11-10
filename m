Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C372623C48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiKJHC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKJHCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:02:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7842250A;
        Wed,  9 Nov 2022 23:02:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5160D61D7F;
        Thu, 10 Nov 2022 07:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EFC433C1;
        Thu, 10 Nov 2022 07:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668063773;
        bh=c67wxQgkF8UYfaGU9UNy+6DAoMPvP8sl9I7jtOccIh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heV0AzmQL9bI7hPyjVlD00ezQQvqmjQCP3ZS3MwciDI+ipZ/tZBD6/u3j2BljmVQx
         eJusoL9JoyI5QkhW8CEKG58gieAQHFYLnAF8+D/4S2f3JykMqYTOXPgX/JZMGI5kpc
         JFTL0IkJQkDo+GUGd34/MM3b164w8Ycd4LOngosrtlI5Zh+rbU8tT1PhGzlqjEXfPA
         6I3z+bpPAcxQWkuAIqWhMz6Tnq+bIxMPJn+Y4HgrNqt9/M5tdsjwolT8VbYKjqyuAD
         EL97KQ/UpP4ZjsW8O5K8u6u0trtvFH70MFi0U37ZENhDflXK0HQctuDRYl1rsVilvU
         9QN1Q66fpyyvg==
Date:   Thu, 10 Nov 2022 12:32:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vincent.sunplus@gmail.com, kishon@kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: usb: sunplus: Fix memleak in update_disc_vol()
Message-ID: <Y2yiGadmdSz/Ml3i@matsya>
References: <20221108073430.29172-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108073430.29172-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-22, 15:34, YueHaibing wrote:
> 'otp_v' is allocated in nvmem_cell_read(), it should be freed
> before return.

Right!

> 
> Fixes: 99d9ccd97385 ("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: free otp_v before return
> ---
>  drivers/phy/sunplus/phy-sunplus-usb2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
> index e827b79f6d49..62d5cb5c7c9d 100644
> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
> @@ -105,6 +105,9 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>  	val = (val & ~J_DISC) | set;
>  	writel(val, usbphy->phy_regs + CONFIG7);
>  
> +	if (!IS_ERR(otp_v))
> +		kfree(otp_v);

But that is not the case!

-- 
~Vinod
