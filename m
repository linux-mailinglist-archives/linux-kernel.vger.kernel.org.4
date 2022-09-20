Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E765BDD03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiITGUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiITGUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:20:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E7615A27
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F133AB81AA4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04DC433D6;
        Tue, 20 Sep 2022 06:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663654849;
        bh=7lUksc1PTJ6jAkhklaSNvSyTxCIJk9ZS22S6ygdZpAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oapCdtEu0jDjcxZ+5cUcJYLImty9sp3r6eaoOSSp06CkFTozUDs+NbP64DkucDm7I
         F22VPt/CZ4KwQ07+ErU7TjuPyJRIGkDHvMP8GiXRXla8M9unV82LPlEigqqbBs48Ig
         V9cpf5D8bBHTOQduf8kISVvkqxegn/f5TZsFMs056xspxzxPVw80UxYvV4akhsM2Db
         6BtTcvyVn90ZseYpIwW6gWr+TiPFD7R1bwJrm6Ag1sb1g8EMPzMK9NgrL2fEqHkePk
         nd8p5uz+qRj38Rx4B+36esOraOT9PzzU4vV8wQeylQyY9q9RH201NKycWFTjjizcH+
         8UbTTGmsjjFCg==
Date:   Tue, 20 Sep 2022 11:50:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] phy: broadcom: use function devm_kcalloc()
 instead of devm_kzalloc()
Message-ID: <YylbvcFX+LHgszaS@matsya>
References: <20220916062150.153104-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916062150.153104-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-22, 06:21, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Where is this report?

> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/phy/broadcom/phy-bcm-sr-usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> index 0002da3b5b5d..0d393e0cc7bb 100644
> --- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
> +++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> @@ -236,7 +236,7 @@ static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
>  	int idx;
>  
>  	if (version == BCM_SR_USB_COMBO_PHY) {
> -		phy_cfg = devm_kzalloc(dev, NUM_BCM_SR_USB_COMBO_PHYS *
> +		phy_cfg = devm_kcalloc(dev, NUM_BCM_SR_USB_COMBO_PHYS,
>  				       sizeof(struct bcm_usb_phy_cfg),
>  				       GFP_KERNEL);
>  		if (!phy_cfg)
> -- 
> 2.25.1

-- 
~Vinod
