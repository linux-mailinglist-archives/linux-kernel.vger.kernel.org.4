Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA94D698DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBPH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBPH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:28:50 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF07392BA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676532529; x=1708068529;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=/+KnIJGVAtqOq1Y5Tt7uoivGVLcBx2ntfW6kgLZW5DA=;
  b=d+9ZT9LcZ8uzmXdSFir8YOVidkHOgD/kyrNQtUIZWztVm1tFNCWpBPmP
   rRMNw8PcquLtvjjabVrBlz3wopIelc4rizppxypTppofR5avqLs0Ij2Ix
   ukAA9nDEQoIQ/zJr7kaPc5zsIuujo2IZrntJgWnPrdheINKFic4DxUOkg
   MMqMchhoTA7EBr5j44IUlkAtANzGVS0bVj2yly2V6w8ZnS+RhDRes1BJd
   5EpJ9T4RHfAoj21ILjw/i0wjhuh59WRjVXxey01DnHtFOSfeY7mny5emd
   X3t0SgNM66sdual3pVvNAhzE0eZocLx9huVw2OqdB/m0Ob7VHpCFubJRV
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,301,1669046400"; 
   d="scan'208";a="221733437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 15:28:46 +0800
IronPort-SDR: cLK9yLdE/J+fRZUFNmEqO+ZpQinsy3ahe/LneDXdg6TbWMHi8VnphjjpGjyvQOyca7HgcctDIf
 rmy1w7MLQrE08PPEHdt3qVZdtPPf+S1oHKDQbxrPIqIvIrmOLIrpvheZ21hsEIscqP+lOB7HBF
 eGXeoJymRgpusp6x52riw4YNmwWU78T6i/GapQROsiUq9R52MLDs0xadCSfYEqQvuFru+43ZyJ
 fyvUH8azHMxLMzfM24H6htkz81dJ6hxSWzYRNV8/5hSE13iYmwq89UuVIuTCtQRLq0ZEizWzT1
 FNo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 22:45:51 -0800
IronPort-SDR: grbqd4EuZDlRrBBIENbIy3TQ90ZbRcrOsPTwE6dYNMQdMe2gm4N1v6pQ1vuFsS4EtdeCDrdwar
 DySoN7kNrGO9hSM6WiX+/wEAnTYbHbj6pFcNbcS+VKLmE6xXyaWqNnGeS/11yAdXaM9mq6u6ea
 uuMrEYRT3jm08LkwUOLtiOwezhTLGratHwy0pVeD+Tr5aSEFGo4bVKm6G+Snp2CtHSY2zsE04i
 I7UoDbsTMC/MrH0AhDslwpBq+3jM0BwCLNrmFbeFw65k6n/feAKbVfbNhIQwsBaRjLn6Iba9Ku
 9b8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 23:28:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PHRQ55dz2z1RwtC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:28:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676532523; x=1679124524; bh=/+KnIJGVAtqOq1Y5Tt7uoivGVLcBx2ntfW6
        kgLZW5DA=; b=J2LH7sQxbsHptMcaledzG///pWJWAx5bwjrJ6nU5VVAXlJAhLtj
        YHfI2WNz4A1+uMCffqA0b2euMkzGrz0eUKvvz32N8+zKVxaLYuokqFMPLuzCS0rV
        KTuwLKAnX8ZKVCRR8noTK4NLHPviI13CbXT2tYebbqVRfvH5D3JdJNCb4bhzcEuO
        pKnN7W3P/jw7qaKrDJPG2mpU+OqTc0nHv8Bpa8hpStcwQGWDWFyl3WtwYghNwWrz
        1rmuXi12KNgZfhCHC51aM99dTMzq723P9TRRRz2s5X2UmLr1ijiKHsJfxunBuxuU
        Hmqz1T7APeu+br31+HqiIJcaeoQNqulk+UQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i8L_B_OZhTk5 for <linux-kernel@vger.kernel.org>;
        Wed, 15 Feb 2023 23:28:43 -0800 (PST)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PHRQ03dv3z1RvLy;
        Wed, 15 Feb 2023 23:28:40 -0800 (PST)
Message-ID: <5c15e1d1-c7e9-0b7c-9b14-f95543c70383@opensource.wdc.com>
Date:   Thu, 16 Feb 2023 16:28:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/9] PCI: rockchip: Remove writes to unused registers
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-2-rick.wertenbroek@gmail.com>
 <2ebd33e2-46ef-356d-ff4c-81b74950d02f@opensource.wdc.com>
 <CAAEEuhr273bKFBWiTVyTjhHhxjuTK=TVd+5K2B07WfWMD+N7mA@mail.gmail.com>
 <559bdd8c-9cc8-d7ae-a937-ffee9cfbb8a6@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <559bdd8c-9cc8-d7ae-a937-ffee9cfbb8a6@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 18:58, Damien Le Moal wrote:
[...]
> WRITE ( 131072 bytes):		OKAY
> WRITE (1024000 bytes):		OKAY
> 
> Then stops here doing the 1024001 B case. The host waits for a completion that
> does not come. On the EP side, I see:
> 
> [   94.307215] pci_epf_test pci_epf_test.0: READ src addr 0xffd00000, 1024001 B
> [   94.307960] pci_epc fd000000.pcie-ep: Map region 1 phys addr 0xfa100000 to
> pci addr 0xffd00000, 1024001 B
> [   94.308924] rockchip-pcie-ep fd000000.pcie-ep: Set atu: region 1, cpu addr
> 0xfa100000, pci addr 0xffd00000, 1024001 B
> [  132.309645] dma-pl330 ff6e0000.dma-controller: Reset Channel-2
> CS-20000e FTC-40000
> 
>                                                   ^^^^^^^^^^^^^^^
> The DMA engine does not like something at all. Back to where I was when I tried
> your series initially, which is why I tried removing patch 1 to see what happens...
> 
> [  132.370479] pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES,
> Time: 38.059623935 s, Rate: 26 KB/s
> [  132.372152] pci_epc fd000000.pcie-ep: Unmap region 1
> [  132.372780] pci_epf_test pci_epf_test.0: RAISE MSI IRQ 1
> [  132.373312] rockchip-pcie-ep fd000000.pcie-ep: Send MSI IRQ 1
> [  132.373844] rockchip-pcie-ep fd000000.pcie-ep: MSI disabled
> [  132.374388] pci_epf_test pci_epf_test.0: Raise IRQ failed -22
> 
> And it looks like the PCI core crashed or something because MSI does not work
> anymore as well (note that this is wheat I see with my nvme epf driver too, but
> I do not have that DMA channel reset message...)
> 
> If I run the tests without DMA (mmio only), everything seems fine:
> 
> ## Read Tests (No DMA)
> READ (      1 bytes):		OKAY
> READ (   1024 bytes):		OKAY
> READ (   1025 bytes):		OKAY
> READ (1024000 bytes):		OKAY
> READ (1024001 bytes):		OKAY
> 
> ## Write Tests (No DMA)
> WRITE (      1 bytes):		OKAY
> WRITE (   1024 bytes):		OKAY
> WRITE (   1025 bytes):		OKAY
> WRITE (1024000 bytes):		OKAY
> WRITE (1024001 bytes):		OKAY
> 
> ## Copy Tests (No DMA)
> COPY (      1 bytes):		OKAY
> COPY (   1024 bytes):		OKAY
> COPY (   1025 bytes):		OKAY
> COPY (1024000 bytes):		OKAY
> COPY (1024001 bytes):		OKAY
> 
> So it looks like translation is working with your patch, but that the driver is
> still missing something for DMA to work correctly...

I kept testing this and realized that I was not getting a consistent behavior.
Sometimes all tests passed, but would not repeat (running again would fail
everything), sometimes NMIs from bad accesses, and other times "hang" (test not
completing but no real machine hang/crash). So it started to hint at something
randomly initialized...

Re-reading the TRM, particularly section 17.5.5.1.1, I realized that the lower
16 bits of the desc2 register are used for the translation, but we never set
them with the current code. Only desc0 and desc1... So I added a write(0) to
desc2 and now it is finally working well. Running the tests in a loop, they all
pass and no bad behavior is observed.

My cleaned-up rockchip_pcie_prog_ep_ob_atu() function now looks like this:

static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
                                         u32 r, u32 type, u64 phys_addr,
                                         u64 pci_addr, size_t size)
{
        u64 sz = 1ULL << fls64(size - 1);
        int num_pass_bits = ilog2(sz);
        u32 addr0, addr1, desc0;

        /* Sanity checks */
        if (WARN_ON_ONCE(type == AXI_WRAPPER_NOR_MSG))
                return;
        if (WARN_ON_ONCE(ALIGN_DOWN(phys_addr, SZ_1M) != phys_addr))
                return;
        if (WARN_ON_ONCE(rockchip_ob_region(phys_addr + size - 1) != r))
                return;

        /* We must pass at least 8 bits of PCI bus address */
        if (num_pass_bits < 8)
                num_pass_bits = 8;

        /* PCI bus address region */
        addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
                (lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
        addr1 = upper_32_bits(pci_addr);
        desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | type;

        rockchip_pcie_write(rockchip, addr0,
                            ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
        rockchip_pcie_write(rockchip, addr1,
                            ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
        rockchip_pcie_write(rockchip, desc0,
                            ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_DESC2(r));
}

And the function rockchip_pcie_clear_ep_ob_atu() also clears desc2:

static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
                                          u32 region)
{
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(region));
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(region));
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_DESC0(region));
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
        rockchip_pcie_write(rockchip, 0,
                            ROCKCHIP_PCIE_AT_OB_REGION_DESC2(region));
}

Thoughts ?

-- 
Damien Le Moal
Western Digital Research

