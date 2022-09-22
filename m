Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143F45E6110
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIVLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIVLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:30:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8E1CB11;
        Thu, 22 Sep 2022 04:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663846220; x=1695382220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQehm9/mvaB86nLSf3V97DpHWGDoVI9t2ENatdOSoX8=;
  b=jK+OEmkLWTZCuOrSpB0Bcu2h4qTrUpr9Ac4eQDSHGEme2sCx5Uh5CMk9
   d9tWA8u9AEsID96xaINFn5bgaN/z6LvVcLGKLjHXfjG++hPQoKsO7T4VH
   rN0DK9y58/G1HaA+pb7004aRRvq2gdqRsy/NZ6kYVvGlm+pj1vWXEepw4
   anL1h8ksZv5J9GvudMfzg4+OGTHIOQrxf0O9E5uGg8F6xVUyFKQw3DtL2
   CBIXotu8m9cJFFuCjzSIXQS4/3aFJ0k64rXT5/5/TtzBBemulH2EMFSpB
   lpXCBschBlLqe4ITGBMh/llZQObybAGLu/4St63b68VXtSBWD2HAaZWVn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297869489"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297869489"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:30:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="795049641"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Sep 2022 04:30:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0CEFE238; Thu, 22 Sep 2022 14:30:34 +0300 (EEST)
Date:   Thu, 22 Sep 2022 14:30:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>, sanju.mehta@amd.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Explicitly enable lane adapter hotplug
 events at startup
Message-ID: <YyxHWgVkHOlswe4r@black.fi.intel.com>
References: <20220921145434.21659-1-mario.limonciello@amd.com>
 <20220921145434.21659-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921145434.21659-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Wed, Sep 21, 2022 at 09:54:33AM -0500, Mario Limonciello wrote:
> Software that has run before the USB4 CM in Linux runs may have disabled
> hotplug events for a given lane adapter.
> 
> Other CMs such as that one distributed with Windows 11 will enable hotplug
> events. Do the same thing in the Linux CM which fixes hotplug events on
> "AMD Pink Sardine".
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/thunderbolt/switch.c  |  4 ++++
>  drivers/thunderbolt/tb.h      |  1 +
>  drivers/thunderbolt/tb_regs.h |  1 +
>  drivers/thunderbolt/usb4.c    | 19 +++++++++++++++++++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 77d7f07ca075..65f65cfe1101 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -792,6 +792,10 @@ static int tb_init_port(struct tb_port *port)
>  		(port->config.nfc_credits & ADP_CS_4_TOTAL_BUFFERS_MASK) >>
>  		ADP_CS_4_TOTAL_BUFFERS_SHIFT;
>  
> +	res = usb4_enable_hotplug(port);

Is this something that needs to be done only for the lane adapters? And
not say PCIe or USB adapter?

> +	if (res)
> +		return res;
> +
>  	tb_dump_port(port->sw->tb, port);
>  	return 0;
>  }
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 5db76de40cc1..b66781ae9c16 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -1174,6 +1174,7 @@ int usb4_switch_add_ports(struct tb_switch *sw);
>  void usb4_switch_remove_ports(struct tb_switch *sw);
>  
>  int usb4_port_unlock(struct tb_port *port);
> +int usb4_enable_hotplug(struct tb_port *port);
>  int usb4_port_configure(struct tb_port *port);
>  void usb4_port_unconfigure(struct tb_port *port);
>  int usb4_port_configure_xdomain(struct tb_port *port);
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 166054110388..bbe38b2d9057 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -308,6 +308,7 @@ struct tb_regs_port_header {
>  #define ADP_CS_5				0x05
>  #define ADP_CS_5_LCA_MASK			GENMASK(28, 22)
>  #define ADP_CS_5_LCA_SHIFT			22
> +#define ADP_CS_5_DHP				BIT(31)
>  
>  /* TMU adapter registers */
>  #define TMU_ADP_CS_3				0x03
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index 3a2e7126db9d..40ba14e8e227 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -1046,6 +1046,25 @@ int usb4_port_unlock(struct tb_port *port)
>  	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_4, 1);
>  }
>  
> +/**
> + * usb4_enable_hotplug() - Enables hotplug for a port
> + * @port: USB4 port to operate on
> + *
> + * Enables hot plug events on a given port.
> + */
> +int usb4_enable_hotplug(struct tb_port *port)

usb4_port_hotplug_enable()

> +{
> +	int ret;
> +	u32 val;
> +

And this one needs to check if this is suitable adapter or if not then
at least mention it in the documentation.

> +	ret = tb_port_read(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~ADP_CS_5_DHP;
> +	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
> +}
> +
>  static int usb4_port_set_configured(struct tb_port *port, bool configured)
>  {
>  	int ret;
> -- 
> 2.34.1
