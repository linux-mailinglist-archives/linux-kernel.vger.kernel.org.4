Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C3608C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJVLIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJVLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:08:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F52D37C5;
        Sat, 22 Oct 2022 03:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA302B8077D;
        Sat, 22 Oct 2022 10:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFC0C433C1;
        Sat, 22 Oct 2022 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666434411;
        bh=dTTyLGATFbJsGsPhwEJxmVPaeto9T/Tpgmku7JGHixs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4T17/U4PIMJuTG8DgpKQAMg3Dxqwz2xAgQI7I6TnrONxSufLduiKcLRiyKnP5tcy
         pGUECVdCnFjJT2zwjH8w4DQBsa0HYk7HalSZftIancT0o0ltV+BEbgEzCVqVOGO6xr
         dG7Pb4s7Xb6Cpk24Yg8qBQqrUGc9aQqIuWgkwLds=
Date:   Sat, 22 Oct 2022 12:26:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrice.chotard@foss.st.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Audu <jerome.audu@st.com>,
        Felipe Balbi <felipe@balbi.sh>
Subject: Re: [PATCH v3] usb: dwc3: st: Rely on child's compatible instead of
 name
Message-ID: <Y1PFaOEbPVDN7313@kroah.com>
References: <20220930142018.890535-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930142018.890535-1-patrice.chotard@foss.st.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:20:18PM +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> To ensure that child node is found, don't rely on child's node name
> which can take different value, but on child's compatible name.
> 
> Fixes: f5c5936d6b4d ("usb: dwc3: st: Fix node's child name")
> Cc: Jerome Audu <jerome.audu@st.com>
> Reported-by: Felipe Balbi <felipe@balbi.sh>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> v3: - rebase on correct branch
> v2: - add missing reported-by
>     - add Fixes
> ---
>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 6c14a79279f9..fea5290de83f 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	/* Manage SoftReset */
>  	reset_control_deassert(dwc3_data->rstc_rst);
>  
> -	child = of_get_child_by_name(node, "usb");
> +	child = of_get_compatible_child(node, "snps,dwc3");
>  	if (!child) {
>  		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
>  		ret = -ENODEV;
> -- 
> 2.25.1
> 

Is this still needed for 6.1-final?

thanks,

greg k-h
