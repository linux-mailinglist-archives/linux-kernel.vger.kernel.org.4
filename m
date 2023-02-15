Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB606973AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjBOBej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOBei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:34:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE23251C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676424876; x=1707960876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=924sFE1g2peLp9NKsKxgM5DmB2kwoPIL6ZPhHqjTmPs=;
  b=iCexVlT3he91HXo0I/3TFyj9DVArvdlPinP1hmDNcRK5xQTwhtN0aX7q
   JHEBaT/sdNUDqIN12B0QYPSuq2+Ga04shfwTFgCAbZ6x3ShtBApu6cOpd
   7NaN2Bwj+Vir/vJ7LugRhSa+3pWbqjd66nZxqFW7pNHY3R0Qm9+ZMR2cG
   /XgxBtBAZ/mXn0+vWLm2b/WudVh6IJ4OtHzwq0DoySHAeUw4B9cMotHnF
   hKWxHQgiL3wTE5hoscNQ9iJu30JdL0u4zLlc4lwXuuYM9ymPGB+ksHsP9
   vfdZLPic0BS6rVtDRJ85jf/bqPsTbSO++miYlh185OIMIaE23e6CDy5Xv
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223343954"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 09:34:35 +0800
IronPort-SDR: 381Ls8PPGAD32pLPr3WTIhVCclREd7N4RMbYLZOjcCG2lBLwZ6LnwFSnWyf1UasangvUW97KB5
 UkBDCUhrGRfI4KQrnUEWMfMgZ4QJt8z2QEvJGn+0O7eDVux8xfsRC2HDM1Ck4s4Vf8xQhd4883
 w27DflbU4jqOnRZmAtAbymCRvYQWkwv/uabkOM4esKBeM8RGb7VM9mzml3lqs8w3aFsBCIKef2
 1+/YPyzLH+EBmFRY74VGzhHuaXthHHc9pCJKIupiTh41bYRcEd5q9swOar9/L+eRnj+LJPiVe5
 laQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 16:51:42 -0800
IronPort-SDR: NHEsMfgOqlLUcG3DrzK+IeYOVgXnFDyv9n5L5wzH2voZlk27dDMcdZDMUvTgcCkAKjOo2yINbC
 sp/Ks+iOMtRZQluVwI7Fd9iQ8bqT1928/9mymZO3ANxD+xa+7BNhaI87jCSsYBlgoE49bdc5xQ
 GefUfk4tWUm7y9jgOLKBoRUcqQaHC3UNWWPNvGY1oRTQ/yADmbcyR0qHuM5UWxroShbqfc6MoM
 K9LwTmmEeuEvmW5Tx891R9TMWkTbXPtzjYquQuq/+2atgzR36x3LMD5EoTNpMG2c59JU7538+L
 Zoc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 17:34:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGgbt3wh7z1RwtC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:34:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676424873; x=1679016874; bh=924sFE1g2peLp9NKsKxgM5DmB2kwoPIL6ZP
        hHqjTmPs=; b=ijswNdQtEpnSj3rZ7vW8jwqI2i0ajTwkqJ8RRkCo5E3CBgPoEwu
        44cpXVamtM19QJuNsgxKE4HyUh5WdOTFTVQHjGU29E5xifdfLdPciyzMQ6ijGDt7
        /VgzVJc+fKdETixifpMU2X7R7MhrJw74aTHjwtyMvPs9LYWtW/Ay84ROojq34DDl
        rCbkDXPwbvGfx9G40KYK4/IE5TCuvACfppMJns8SbnZv6qQZ/xjJTiVaTyUqplET
        9zpCYpaEShHr5D+zvqXhvujcAGurgcZz5fV/Slcyjgu5H+nalFrHki9Udmq4nXUY
        82Ct92oTgvFj7jP9EXnfuL9/+a9LudX+cOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W2SWes3ugvS3 for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 17:34:33 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGgbn6kStz1RvLy;
        Tue, 14 Feb 2023 17:34:29 -0800 (PST)
Message-ID: <0fa5cef4-7096-7f59-422a-98011d01437c@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 10:34:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 8/9] PCI: rockchip: Use u32 variable to access 32-bit
 registers
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        stable@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-9-rick.wertenbroek@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214140858.1133292-9-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 23:08, Rick Wertenbroek wrote:
> Previously u16 variables were used to access 32-bit registers, this
> resulted in not all of the data being read from the registers. Also
> the left shift of more than 16-bits would result in moving data out
> of the variable. Use u32 variables to access 32-bit registers
> 
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 10 +++++-----
>  drivers/pci/controller/pcie-rockchip.h    |  1 +
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index ca5b363ba..b7865a94e 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -292,15 +292,15 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u16 flags;
> +	u32 flags;
>  
>  	flags = rockchip_pcie_read(rockchip,
>  				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
>  				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
>  	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK;
>  	flags |=
> -	   ((multi_msg_cap << 1) <<  ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
> -	   PCI_MSI_FLAGS_64BIT;
> +	   (multi_msg_cap << ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |

ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET is 17 and multi_msg_cap is a u8...
Not nice.

Locally, I added the local variable:

u32 mmc = multi_msg_cap;

And use mmc instead of multi_msg_cap to avoid issues. Also,

> +	   (PCI_MSI_FLAGS_64BIT << ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET);
>  	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP;
>  	rockchip_pcie_write(rockchip, flags,
>  			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> @@ -312,7 +312,7 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
>  {
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u16 flags;
> +	u32 flags;
>  
>  	flags = rockchip_pcie_read(rockchip,
>  				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> @@ -374,7 +374,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
>  					 u8 interrupt_num)
>  {
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
> -	u16 flags, mme, data, data_mask;
> +	u32 flags, mme, data, data_mask;
>  	u8 msi_count;
>  	u64 pci_addr, pci_addr_mask = 0xff;
>  	u32 r;
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index e90c2a2b8..11dbf53cd 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -227,6 +227,7 @@
>  #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
>  #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
>  #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
> +#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET			16

You are not using this macro anywhere. The name is also not very
descriptive. Better have it as:

#define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME		BIT(16)

to match the TRM name and be clear that the bit indicates if MSI is
enabled or not.

>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20

-- 
Damien Le Moal
Western Digital Research

