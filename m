Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA336B3EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCJMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCJMNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:13:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55353B237;
        Fri, 10 Mar 2023 04:13:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86A3BB8228D;
        Fri, 10 Mar 2023 12:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D07DC433EF;
        Fri, 10 Mar 2023 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678450411;
        bh=oU5OEZvXKEFLgb8KBH5P7/3BY/Zj7SlC5INYNHEWOaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fcqr27r3ochfS0LGW5/4bCEkaWZNVzxH3nj3+K59MhV5jCdydLHXILP7xPzhHFUqd
         5TmDBbHpNAIahof79gfIFYn/h+RxXB+Ce5onZorhaHpifvQgc2tuMNEvakipHoRmjQ
         /YP0qB3tJiVKhSxdKfHh8VwnzuS9GSiV76jp3W+3KEXcdfWEbDbc5nlCa7lAIweVDg
         j8vp9H4FQEleUQAh/y852RNfzi0sS/Ezg5ZaNuyhbyvZ0uW71Z/GVfq2idimQ/UdAS
         /NHYRL0UU5PZoMOl6RDw/eG9esW3rpVBjESSKOkHNr7FD67zBNG+J1JrdOxTtkeH6f
         B3loXSYpyWlwQ==
Date:   Fri, 10 Mar 2023 17:43:25 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     loic.poulain@linaro.org, fabio.porcedda@gmail.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Revert "Add a secondary AT
 port to Telit FN990"
Message-ID: <20230310121325.GC6838@thinkpad>
References: <20230310101715.69209-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310101715.69209-1-slark_xiao@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 06:17:15PM +0800, Slark Xiao wrote:
> This reverts commit 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
> There are 2 commits with commit message "Add a secondary AT
> port to Telit FN990". But the last one 2d5253a096 was added
> on Foxconn devices. Actually the second AT port of Foxconn
> devices doesn't work in PCIe mode. And the commit message
> mismatch with the changes. So we need to remove it.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next after ammending the commit message to reflect the bad
merge.

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 6e13c43a84d1..91d02f84ba21 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -343,8 +343,6 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> -	MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
> -	MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
>  };
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
