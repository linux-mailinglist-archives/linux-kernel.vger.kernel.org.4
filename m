Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE45BAF73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiIPOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:35:14 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9E13A48E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338911; x=1694874911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQmowXYSqfWbx6tOz5B0DjjiQiWzPuRxrCsV4TcaO2E=;
  b=CjDlgY5hKj8+72oA1v6b4hPeZg/fBweZSaRcnPD+57zy2xKI7RkJyC4P
   qMv2+svw6/Ye6qWL4G4glw/hOZ0PAibPoXoziDpWuF9BnjcGj/1UZtaTG
   nequMaJct36MWe6Aqr/f3Zm+iLORWRJd2uY/D/NEH2HXNJqOiNwz9nE9j
   k7nqd/NTx/60HW/0I9uNRJOrfoaw7JPtJjh9DXOXHodM9kiiWtsisZwGK
   +QrOzKACekdBamIzJOzypbWkK0hWCW3gTmOiXhfBi9oeAzAn8kbGrJPRw
   Kzr0hBz/zF08TG0Ffw0EfNuWmyKjd+ys+Sce7e88M/fzHkTgddyhL89hH
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216708398"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:35:10 +0800
IronPort-SDR: 9XlF6KIl6blxa9dYcjuhOx1TLrFKWBG3CGPTau/aaSOwxS2qJ07PvSPffR7cLXE0BUD9kTAYgE
 lYwdHMuiK4Su6b0Ea8NWUSA8nRSnglY1j+24u9bNLy/10ghhI4ybeXMuHyG1HOPGPDIlze7UDL
 VL2scDjC/+dgFINsxvL5vrTibGnV7MebvmTe4GmQGBxaPIPbSclltzOrG2bNHi3ZZBDEHGzUL0
 rOyed728LtCyc5OH1Ag02O3wrcLG79S3XUKmbkRIWam/rJbpHGY/j9vOAeRADW1DgAb9Dz/AB5
 GJPinlxVHruF98nSY2uSupcP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:49:49 -0700
IronPort-SDR: qDTlEOKnUXSEOXQO+JsF1Vmyc5pgEzgI6B35z3BasU3lXKBPyyYWOxiMRO+1zsEZPDqt+E+/2q
 uSg5yJsJgvgyNgV33i0fuO5j9lggV4bi7jR8HDse2kbTkDWscCeHcCG78CdFW5dPmc1kc+tetl
 jG16153j2fXIbTPtWhkOS8zD+ABJxF8VI+idPbBVRxzIFZDPAoeBrakdL8n7USPUuU0uKyUEC+
 uqNRg1aUNlj45yIQwpTYtoW9fzm/0hxXT21fut8AFt8ndQ0LHRxSG98jSoG+53zrdEO13/Db9U
 dyk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:35:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTc6f74vvz1Rwrq
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:35:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338905; x=1665930906; bh=zQmowXYSqfWbx6tOz5B0DjjiQiWzPuRxrCs
        V4TcaO2E=; b=f3KsCnrRvJhqK9TSc2CVwA16RKiXI35/sBLaAjQcN6OmOVDoeaL
        VOFRGJJajkAH9p7ztw7JrOLwrrjZiPai7UbmTLa38P+ADr487JWxxJ//D+7hre6O
        wBv2xaDeh9RHmKme3B75QDOxzSwkpkY8CujbtO94m2X70yiqk46YWzLBpF1YONBi
        k9D/GsqOFas0DovUyU3G32wPO5hkys8l3ZvEKO2XFfQ2renqDbgZ+i7uOnHr/JV7
        9/NOAOigNk0Fzf+yinEexB/ERoLx6O6rEPhjINTTo1REHepGNRarYVxr4aefrrSK
        acx2Ap24pS445+NxbB/8gm/DujFfKXSmeJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5GTsxpUgKm6j for <linux-kernel@vger.kernel.org>;
        Fri, 16 Sep 2022 07:35:05 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTc6Z0PwKz1RvLy;
        Fri, 16 Sep 2022 07:35:01 -0700 (PDT)
Message-ID: <58614969-46e3-cb76-6f5e-139c555dcca1@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:35:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] ata: ahci: Add initialization quirk for JMicron
 JMB585/JMB582 controllers
Content-Language: en-US
To:     MD Lin <mdlin@jmicron.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kevinliu@jmicron.com, charonchen@jmicron.com,
        corahuang@jmicron.com, mhchen@jmicron.com, georgechao@jmicron.com,
        banks@jmicron.com, tzuwei@jmicron.com
References: <20220915001149.24241-1-mdlin@jmicron.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220915001149.24241-1-mdlin@jmicron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/15 1:11, MD Lin wrote:
> JMicron JMB585/JMB582 does not enable specific error bit handling functions
> by default so this patch enable these functions for better compatibility.
> Besides, these patches also adjust SATA RX/TX_GEN1/TX_GEN2 parameters for
> better compatibility. These patches had been tested in JMicron Test
> Laboratory and been implemented to our customers.
> 
> Signed-off-by: MD Lin <mdlin@jmicron.com>
> ---
>  drivers/ata/ahci.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/ahci.h | 23 +++++++++++++++
>  2 files changed, 94 insertions(+)
>  mode change 100755 => 100644 drivers/ata/ahci.h
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 505920d45..3e9e3b8f8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1657,6 +1657,75 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
>  	}
>  }
>  
> +static void ahci_jmb58x_write_sata(void __iomem *mmio, u32 addr, u32 data)
> +{
> +	writel((addr & 0x01FFFUL) + (1UL << 18UL), mmio + 0xC0);
> +	writel(data, mmio + 0xC8);
> +}
> +
> +static void ahci_jmb58x_quirk(void __iomem *mmio)
> +{
> +	u32 pi = readl(mmio + HOST_PORTS_IMPL);
> +	u32 b8_data;
> +
> +	/*
> +	 * JMB582: PI is 0x03
> +	 * JMB585: PI is 0x1f
> +	 */

What is this comment for ?

> +
> +	/*
> +	 * enable error bit handling functions, these might overwrite
> +	 * the setting which loads from external SPI flash.
> +	 * the address and value are defined in adapter specs.
> +	 */
> +	b8_data = (pi > 3) ? 0x13 : 0x92;

This looks strange. If pi is fixed depending on the controller type, why not use
a switch-case here with the values in the comments above defined as macros ?
Something like:

	switch (pi) {
	case JMB582:
		b8_data = 0x92;
	case JMB585:
	default:
		b8_data = 0x13;
	}

This is a lot more readable.

> +	writel(JMB58X_EH_MODIFY_ON + b8_data,  mmio + 0xB8);
> +	writel(JMB58X_EH_GENERAL,              mmio + 0x30);
> +	writel(JMB58X_EH_CFIS_RETRY,           mmio + 0x34);
> +	writel(JMB58X_EH_DROP_D2H,             mmio + 0x38);
> +	writel(JMB58X_EH_MODIFY_OFF + b8_data, mmio + 0xB8);
> +	writel(JMB58X_EH_TX_LOCK,              mmio + 0xB0);

Why not define all these magic values as macros using the register names ?
Anyone comparing the code to the controller specs will more easily understand.

> +
> +	/*
> +	 * set SATA configuration, these might overwrite
> +	 * the setting which loads from external SPI flash.
> +	 * the address and value are defined in adapter specs.
> +	 */
> +	ahci_jmb58x_write_sata(mmio, 0x06, JMB58X_SATA0_RX);
> +	ahci_jmb58x_write_sata(mmio, 0x13, JMB58X_SATA1_RX);
> +	ahci_jmb58x_write_sata(mmio, 0x73, JMB58X_SATA0_TX_GEN2);
> +	ahci_jmb58x_write_sata(mmio, 0x75, JMB58X_SATA1_TX_GEN2);
> +	ahci_jmb58x_write_sata(mmio, 0x74, JMB58X_SATA0_TX_GEN1);
> +	ahci_jmb58x_write_sata(mmio, 0x80, JMB58X_SATA1_TX_GEN1);
> +	if (pi > 3) {
> +		ahci_jmb58x_write_sata(mmio, 0x20, JMB58X_SATA2_RX);
> +		ahci_jmb58x_write_sata(mmio, 0x2D, JMB58X_SATA3_RX);
> +		ahci_jmb58x_write_sata(mmio, 0x3A, JMB58X_SATA4_RX);
> +		ahci_jmb58x_write_sata(mmio, 0x79, JMB58X_SATA3_TX_GEN2);
> +		ahci_jmb58x_write_sata(mmio, 0x83, JMB58X_SATA3_TX_GEN2_EXT);
> +		ahci_jmb58x_write_sata(mmio, 0x7A, JMB58X_SATA3_TX_GEN1);
> +		ahci_jmb58x_write_sata(mmio, 0x84, JMB58X_SATA3_TX_GEN1_EXT);
> +	}

Same comment here.

> +}
> +
> +static void ahci_jmicron_quirk(struct pci_dev *pdev,
> +			struct ahci_host_priv *hpriv)
> +{
> +	void __iomem *mmio = hpriv->mmio;
> +	u8 tmp8;
> +
> +	if (pdev->vendor != PCI_VENDOR_ID_JMICRON)
> +		return;
> +
> +	switch (pdev->device) {
> +	case 0x585:
> +		tmp8 = readb(mmio + 0x44);
> +		if (tmp8)  /* check controller version */
> +			ahci_jmb58x_quirk(mmio);

The tmp8 variable is not needed:

		if (readb(mmio + 0x44))
			ahci_jmb58x_quirk(mmio);

is fine, with the magic value 0x44 defined as a macro with a descriptive name.

> +		break;
> +	}
> +}
> +
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	unsigned int board_id = ent->driver_data;
> @@ -1775,6 +1844,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 */
>  	ahci_intel_pcs_quirk(pdev, hpriv);
>  
> +	ahci_jmicron_quirk(pdev, hpriv);
> +
>  	/* prepare host */
>  	if (hpriv->cap & HOST_CAP_NCQ) {
>  		pi.flags |= ATA_FLAG_NCQ;
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> old mode 100755
> new mode 100644
> index 9290e787a..82ecc6f2c
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -52,6 +52,29 @@
>  #define EM_MSG_LED_VALUE_OFF          0xfff80000
>  #define EM_MSG_LED_VALUE_ON           0x00010000
>  
> +/* JMicron JMB585/JMB582 Error Bit Handling Register Value */
> +#define JMB58X_EH_MODIFY_ON           0x03060004
> +#define JMB58X_EH_MODIFY_OFF          0x03060000
> +#define JMB58X_EH_GENERAL             0x00FF0B01
> +#define JMB58X_EH_CFIS_RETRY          0x0000003F
> +#define JMB58X_EH_DROP_D2H            0x0000001F
> +#define JMB58X_EH_TX_LOCK             0xF9E4EFBF
> +
> +/* JMicron JMB585/JMB582 SATA PHY Register Value */
> +#define JMB58X_SATA0_RX               0x70005BE3
> +#define JMB58X_SATA1_RX               0x70005BE3
> +#define JMB58X_SATA2_RX               0x70005BE3
> +#define JMB58X_SATA3_RX               0x70005BE3
> +#define JMB58X_SATA4_RX               0x70005BE3
> +#define JMB58X_SATA0_TX_GEN1          0x00000024
> +#define JMB58X_SATA1_TX_GEN1          0x250B0003
> +#define JMB58X_SATA3_TX_GEN1          0x00000024
> +#define JMB58X_SATA3_TX_GEN1_EXT      0x250B0003
> +#define JMB58X_SATA0_TX_GEN2          0x000001E5
> +#define JMB58X_SATA1_TX_GEN2          0x000001E5
> +#define JMB58X_SATA3_TX_GEN2          0x000001E5
> +#define JMB58X_SATA3_TX_GEN2_EXT      0x250B0003
> +
>  enum {
>  	AHCI_MAX_PORTS		= 32,
>  	AHCI_MAX_CLKS		= 5,

-- 
Damien Le Moal
Western Digital Research

