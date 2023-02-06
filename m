Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A763C68BC34
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBFMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBFMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:02:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16313531
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:02:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 993C7B80E8F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA48C433EF;
        Mon,  6 Feb 2023 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675684955;
        bh=hU9KtWEf3Qt3qg9VhEvrtyjRDwFqQYI+De36C/c8Wf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvKsTSrywSo09ZPCManvZbD5+3+UqQqeUpt2Ikd7FeMNRQlcAioVJlzULRnBkVWLG
         bzHamgwXC6WKwbT4faymPRMGP79JQMLiOWX8+IKVRQ1p+opSNVMey5TkqNftZMG806
         3R2s82XifcWqC4ND3HpvDIwBq0D6FEnzngWQ6ljw=
Date:   Mon, 6 Feb 2023 13:02:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [RESEND PATCH 23/37] nvmem: layouts: add sl28vpd layout
Message-ID: <Y+DsV3C1M0c/IZta@kroah.com>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
 <20230206102759.669838-24-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206102759.669838-24-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:27:45AM +0000, Srinivas Kandagatla wrote:
> From: Michael Walle <michael@walle.cc>
> 
> This layout applies to the VPD of the Kontron sl28 boards. The VPD only
> contains a base MAC address. Therefore, we have to add an individual
> offset to it. This is done by taking the second argument of the nvmem
> phandle into account. Also this let us checking the VPD version and the
> checksum.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/layouts/Kconfig   |   9 ++
>  drivers/nvmem/layouts/Makefile  |   2 +
>  drivers/nvmem/layouts/sl28vpd.c | 153 ++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+)
>  create mode 100644 drivers/nvmem/layouts/sl28vpd.c
> 
> diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
> index 9ad3911d1605..75082f6b471d 100644
> --- a/drivers/nvmem/layouts/Kconfig
> +++ b/drivers/nvmem/layouts/Kconfig
> @@ -2,4 +2,13 @@
>  
>  menu "Layout Types"
>  
> +config NVMEM_LAYOUT_SL28_VPD
> +	bool "Kontron sl28 VPD layout support"
> +	select CRC8
> +	help
> +	  Say Y here if you want to support the VPD layout of the Kontron
> +	  SMARC-sAL28 boards.
> +
> +	  If unsure, say N.

Why are we going back to "custom-built" kernel configurations?  Why can
this not be a loadable module?  Distros are now forced to enable these
layout and all kernels will have this dead code in the tree without any
choice in the matter?

That's not ok, these need to be auto-loaded based on the hardware
representation like any other kernel module.  You can't force them to be
always present, sorry.

So I'm not going to take this series, sorry.  Srinivas, can you
regenerate it without the layout code and resend?

thanks,

greg k-h
