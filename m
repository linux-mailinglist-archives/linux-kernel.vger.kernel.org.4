Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEEE65C7AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbjACTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjACTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:46:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C4FCF;
        Tue,  3 Jan 2023 11:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8sffLzfOV4kHh/h1AtFY2k34nc54HLsJyegXDN3RKdaAH6NR1rekzF2GrNqpwhVRkfzczfe2p0os2VSKh81ENop3EsBEE4VmUIG9PjdGNOozs/y22CmVDFszJ+c9sTQ+Nvp0jVNReRcwfcT03Obwd+IXaJR/ihWg0zGXcSsnHTYbY9BpUeXrvZwZhkdZF/ROYlJHCd/bINjD0SC1JFvCoVRguecDWZRpah8i4yZ2a6hkDmEhHZbEfwBlMcBQnI30nGVFqiBqibOl0sEmwdZAMFipoAQKfwyWlKKkmt7KN8BAL4FUNI9BCKd7XiHnkBNAg94cS+tdTsiZ+IBGqOJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PfBB7wK5pZoJnSbE/qrv4P2QuU7z2msqFvpJyUNyos=;
 b=YEapBRC8cj0An61smX0UaXJJGExdcn8zevqk+tdxBx9PLECzqBThSdxNK5istAtXLr+mk7/M5lSqQVCo40/WQxw4/nHRfMrBArx/ZwSCSpQKh5ApjoOXHfTl4yFD5IWNpxm7hrQzFaqKNsY3hRXyBtL38JiE8A4R1/LT8kcV/3ltJCG1SXGYYYIhJf0nwUwHjnWD7wVJgi81thmTP1A8N6GfgCUfdOz54r/FcNyu30wnJieeiX9qQJ+j8vIq14ZLzeHwVRjs1EpSfFMQm8hZLsAFdWDoH8Ix+8ANzSuBbfN5o/4uNhUeTA9Esel/EZ4jbWW8SpJM3h/ybHWw9voWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PfBB7wK5pZoJnSbE/qrv4P2QuU7z2msqFvpJyUNyos=;
 b=cBAiXnkgI8RzEEuiMy4y1kko2I+3uAxsecq1LKAfBwT+YuzZ2jUTpA478Isjtnz+C9ovv9j1DfgWl9qKJgt2xVzxZOCjeskgHr3gAySwfiyn7ozI20+yN6NtinTGvx5YYM9zZX4vVyLiYcMS2MwRzRtT0UXQo7fN30SmpLBxlZI=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:46:00 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::49) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 19:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Tue, 3 Jan 2023 19:46:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 13:45:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 11:45:59 -0800
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Jan 2023 13:45:58 -0600
Message-ID: <b33c232b-851b-0f38-bbf0-7dfb35467ef2@amd.com>
Date:   Tue, 3 Jan 2023 11:45:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected devices
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
 <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
 <20230102181611.0e6023f2@fixe.home>
From:   Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20230102181611.0e6023f2@fixe.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf82b4e-7c68-411c-7786-08daedc32400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZ8yygJI9lSVxIYdt48DjZ9x4uY3CsB2kDpdnAtUynLgLVAMpeC2vEUjHePiNksyjBS3QvZoLfCDVwJlfZX18P79DrU9tzmx5afZu89ohsoa17HBlIq7W3Tshl8LfYb9lv3biHEF76B+DJ8WJMdRZ98XnJLgVln2eWjvpuBoayN56VBL6Xwif9LpNVQR/hzzFoOJIbfjmL1sGn9oQhdIYePpvvPAuMRAwX7fx4VDeALbHd5ZePVraYJknVClhtn9itVmCYcAallCYYBP5iBKqAJn9kp/hd3jrtWnYn16GXJoQSLpWq9izPiy0b3fEDtfZybNVlOxD3JCYHxavB+hgTGQG6viUtbvhTQMsFn5dFmLF8dYTC2/HFvXCcWdve8w2qmT10BGlSLD9YfcMUSf2LUgTDY9Pdn5/5wl7bt9qh9vxP4pO7GexZfEsffm020ISo1VAqWhfEFkEEBtrWPSjiyB2A/LNv4rZWmqlXthqFcL8VSMOMJboUNEOEf+gtvPzc8mYZ+7HkoVjmsLD2Zp4fLcdwVdtHcq5oajvg89cOZYzqBx5Kpu0Qeipe7au1zvQlPa7H55yx8u82AvSh55BMV4QsmNPQBZl/fM7h1707jAtmY7A30TnyRwgME5PRC9yN5VqTRzr0IauZ5vdsHPpY6vAhb99P4CDI4YR+CREFACvy5A8zogPBjVbUtBp9/O545z6VGVMW6O7lD5vlKqpsTxqFqxYFh5juEFE58kSVUoDleZ87yN3TNUNPXrXZD+/nydBhJw+kQN+0luH52tcUFHRo3lvRzbn4HJO8qfTpM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(7416002)(5660300002)(41300700001)(316002)(4326008)(8936002)(70586007)(8676002)(54906003)(6916009)(2906002)(44832011)(70206006)(16576012)(478600001)(186003)(53546011)(26005)(31686004)(40480700001)(31696002)(86362001)(2616005)(66574015)(426003)(36860700001)(83380400001)(47076005)(336012)(36756003)(82740400003)(356005)(81166007)(82310400005)(30864003)(40460700003)(22166006)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:46:00.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf82b4e-7c68-411c-7786-08daedc32400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/2/23 09:16, Clément Léger wrote:
> Le Thu, 15 Dec 2022 09:30:45 -0800,
> Lizhi Hou <lizhi.hou@amd.com> a écrit :
>
>> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
>> spaces from multiple hardware peripherals to its PCI BAR. Normally,
>> the PCI core discovers devices and BARs using the PCI enumeration process.
>> There is no infrastructure to discover the hardware peripherals that are
>> present in a PCI device, and which can be accessed through the PCI BARs.
>>
>> For Alveo PCI card, the card firmware provides a flattened device tree to
>> describe the hardware peripherals on its BARs. The Alveo card driver can
>> load this flattened device tree and leverage device tree framework to
>> generate platform devices for the hardware peripherals eventually.
>>
>> Apparently, the device tree framework requires a device tree node for the
>> PCI device. Thus, it can generate the device tree nodes for hardware
>> peripherals underneath. Because PCI is self discoverable bus, there might
>> not be a device tree node created for PCI devices. This patch is to add
>> support to generate device tree node for PCI devices.
>>
>> Added a kernel option. When the option is turned on, the kernel will
>> generate device tree nodes for PCI bridges unconditionally.
>>
>> Initially, the basic properties are added for the dynamically generated
>> device tree nodes.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Reviewed-by: Brian Xu <brian.xu@amd.com>
>> ---
>>   drivers/pci/Kconfig         |  12 ++
>>   drivers/pci/Makefile        |   1 +
>>   drivers/pci/bus.c           |   2 +
>>   drivers/pci/msi/irqdomain.c |   6 +-
>>   drivers/pci/of.c            |  71 ++++++++++++
>>   drivers/pci/of_property.c   | 222 ++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-driver.c    |   3 +-
>>   drivers/pci/pci.h           |  19 +++
>>   drivers/pci/remove.c        |   1 +
>>   9 files changed, 334 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/pci/of_property.c
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 55c028af4bd9..1b2347aa1e5b 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -198,6 +198,18 @@ config PCI_HYPERV
>>   	  The PCI device frontend driver allows the kernel to import arbitrary
>>   	  PCI devices from a PCI backend to support PCI driver domains.
>>   
>> +config PCI_DYNAMIC_OF_NODES
>> +	bool "Create Devicetree nodes for PCI devices"
>> +	depends on OF
>> +	select OF_DYNAMIC
>> +	help
>> +	  This option enables support for generating device tree nodes for some
>> +	  PCI devices. Thus, the driver of this kind can load and overlay
>> +	  flattened device tree for its downstream devices.
>> +
>> +	  Once this option is selected, the device tree nodes will be generated
>> +	  for all PCI bridges.
>> +
>>   choice
>>   	prompt "PCI Express hierarchy optimization setting"
>>   	default PCIE_BUS_DEFAULT
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 2680e4c92f0a..cc8b4e01e29d 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>> +obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>>   
>>   # Endpoint library must be initialized before its users
>>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 3cef835b375f..8507cc32b61d 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -316,6 +316,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>>   	 */
>>   	pcibios_bus_add_device(dev);
>>   	pci_fixup_device(pci_fixup_final, dev);
>> +	if (pci_is_bridge(dev))
>> +		of_pci_make_dev_node(dev);
>>   	pci_create_sysfs_dev_files(dev);
>>   	pci_proc_attach_device(dev);
>>   	pci_bridge_d3_update(dev);
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index e9cf318e6670..eeaf44169bfd 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -230,8 +230,10 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>>   	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>>   
>>   	of_node = irq_domain_get_of_node(domain);
>> -	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
>> -			iort_msi_map_id(&pdev->dev, rid);
>> +	if (of_node && !of_node_check_flag(of_node, OF_DYNAMIC))
>> +		rid = of_msi_map_id(&pdev->dev, of_node, rid);
>> +	else
>> +		rid = iort_msi_map_id(&pdev->dev, rid);
>>   
>>   	return rid;
>>   }
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 196834ed44fe..cb34a73ac8a3 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -469,6 +469,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>   		} else {
>>   			/* We found a P2P bridge, check if it has a node */
>>   			ppnode = pci_device_to_OF_node(ppdev);
>> +			if (ppnode && of_node_check_flag(ppnode, OF_DYNAMIC))
>> +				ppnode = NULL;
>>   		}
>>   
>>   		/*
>> @@ -599,6 +601,75 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>   	return pci_parse_request_of_pci_ranges(dev, bridge);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_PCI_DYNAMIC_OF_NODES)
>> +
>> +void of_pci_remove_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = pci_device_to_OF_node(pdev);
>> +	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>> +		return;
>> +	pdev->dev.of_node = NULL;
>> +
>> +	of_destroy_node(np);
>> +}
>> +
>> +void of_pci_make_dev_node(struct pci_dev *pdev)
>> +{
>> +	struct device_node *ppnode, *np = NULL;
>> +	const char *pci_type = "dev";
>> +	struct of_changeset *cset;
>> +	const char *name;
>> +	int ret;
>> +
>> +	/*
>> +	 * If there is already a device tree node linked to this device,
>> +	 * return immediately.
>> +	 */
>> +	if (pci_device_to_OF_node(pdev))
>> +		return;
>> +
>> +	/* Check if there is device tree node for parent device */
>> +	if (!pdev->bus->self)
>> +		ppnode = pdev->bus->dev.of_node;
>> +	else
>> +		ppnode = pdev->bus->self->dev.of_node;
>> +	if (!ppnode)
>> +		return;
>> +
>> +	if (pci_is_bridge(pdev))
>> +		pci_type = "pci";
>> +
>> +	name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
>> +			 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +	if (!name)
>> +		goto failed;
>> +
>> +	np = of_create_node(ppnode, name, &cset);
>> +	if (!np)
>> +		goto failed;
>> +
>> +	ret = of_pci_add_properties(pdev, cset, np);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	ret = of_changeset_apply(cset);
>> +	if (ret)
>> +		goto failed;
>> +
>> +	pdev->dev.of_node = np;
>> +	kfree(name);
>> +
>> +	return;
>> +
>> +failed:
>> +	if (np)
>> +		of_destroy_node(np);
>> +	kfree(name);
>> +}
>> +#endif
>> +
>>   #endif /* CONFIG_PCI */
>>   
>>   /**
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> new file mode 100644
>> index 000000000000..05c8ca05a71b
>> --- /dev/null
>> +++ b/drivers/pci/of_property.c
>> @@ -0,0 +1,222 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/of.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <asm/unaligned.h>
>> +#include "pci.h"
>> +
>> +#define OF_PCI_ADDRESS_CELLS		3
>> +#define OF_PCI_SIZE_CELLS		2
>> +
>> +struct of_pci_addr_pair {
>> +	u32		phys_addr[OF_PCI_ADDRESS_CELLS];
>> +	u32		size[OF_PCI_SIZE_CELLS];
>> +};
>> +
>> +struct of_pci_range {
>> +	u32		child_addr[OF_PCI_ADDRESS_CELLS];
>> +	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
>> +	u32		size[OF_PCI_SIZE_CELLS];
>> +};
>> +
>> +#define OF_PCI_ADDR_SPACE_CONFIG	0x0
>> +#define OF_PCI_ADDR_SPACE_IO		0x1
>> +#define OF_PCI_ADDR_SPACE_MEM32		0x2
>> +#define OF_PCI_ADDR_SPACE_MEM64		0x3
>> +
>> +#define OF_PCI_ADDR_FIELD_NONRELOC	BIT(31)
>> +#define OF_PCI_ADDR_FIELD_SS		GENMASK(25, 24)
>> +#define OF_PCI_ADDR_FIELD_PREFETCH	BIT(30)
>> +#define OF_PCI_ADDR_FIELD_BUS		GENMASK(23, 16)
>> +#define OF_PCI_ADDR_FIELD_DEV		GENMASK(15, 11)
>> +#define OF_PCI_ADDR_FIELD_FUNC		GENMASK(10, 8)
>> +#define OF_PCI_ADDR_FIELD_REG		GENMASK(7, 0)
>> +
>> +#define OF_PCI_ADDR_HI			GENMASK_ULL(63, 32)
>> +#define OF_PCI_ADDR_LO			GENMASK_ULL(31, 0)
>> +#define OF_PCI_SIZE_HI			GENMASK_ULL(63, 32)
>> +#define OF_PCI_SIZE_LO			GENMASK_ULL(31, 0)
>> +
>> +enum of_pci_prop_compatible {
>> +	PROP_COMPAT_PCI_VVVV_DDDD,
>> +	PROP_COMPAT_PCICLASS_CCSSPP,
>> +	PROP_COMPAT_PCICLASS_CCSS,
>> +	PROP_COMPAT_NUM,
>> +};
>> +
>> +static int of_pci_prop_device_type(struct pci_dev *pdev,
>> +				   struct of_changeset *ocs,
>> +				   struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
>> +}
>> +
>> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
>> +				     struct of_changeset *ocs,
>> +				     struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
>> +					 OF_PCI_ADDRESS_CELLS);
>> +}
>> +
>> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
>> +				  struct of_changeset *ocs,
>> +				  struct device_node *np)
>> +{
>> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
>> +					 OF_PCI_SIZE_CELLS);
>> +}
>> +
>> +static void of_pci_set_address(u32 *prop, u64 addr, u32 flags)
>> +{
>> +	prop[0] = flags;
>> +	put_unaligned(addr, &prop[1]);
>> +}
> Here, the put_unaligned() call will assume you want to store a 32bits
> value since prop is pointing to a u32 array. This can't work.
>
> Moreover, when storing a 64bits address in device-tree properties, they
> are stored starting with their 32 MSB in the first cell and the
> 32 LSB in the next cells.
>
> This should probably be something like this:
>
> static void of_pci_set_address(u32 *prop, u64 addr, u32 flags)
> {
> 	prop[0] = flags;
> 	prop[1] = addr >> 32;
> 	prop[2] = addr;
> }
>
> [snip]

Thanks for pointing this out. And I should add (__be64 *) as below.

  put_unaligned(addr, (__be64 *)&prop[1]);

>
>> +
>> +static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			      struct device_node *np)
>> +{
>> +	struct of_pci_range rp[PCI_BRIDGE_RESOURCE_NUM];
>> +	struct resource *res;
>> +	int i = 0, j, ret;
>> +	u64 val64;
>> +	u32 flags;
>> +
>> +	res = &pdev->resource[PCI_BRIDGE_RESOURCES];
>> +	for (j = 0; j < PCI_BRIDGE_RESOURCE_NUM; j++) {
>> +		if (!resource_size(&res[j]))
>> +			continue;
>> +
>> +		flags = OF_PCI_ADDR_FIELD_NONRELOC;
>> +		if (of_pci_get_addr_flags(&res[j], &flags))
>> +			continue;
>> +
>> +		val64 = res[j].start;
>> +		of_pci_set_address(rp[i].parent_addr, val64, flags);
>> +		of_pci_set_address(rp[i].child_addr, val64, flags);
>> +
>> +		val64 = resource_size(&res[j]);
>> +		put_unaligned(val64, rp[i].size);
> Same problem here, the size is meant to be a 64 bits values but will
> assume you want to store it using a 32bits pointer.
Will change to: put_unaligned(val64, (__be64 *)rp[i].size);
>
>> +
>> +		i++;
>> +	}
>> +
>> +	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
>> +					      i * sizeof(*rp) / sizeof(u32));
>> +
>> +	return ret;
>> +}
>> +
>> +static int of_pci_prop_reg(struct pci_dev *pdev, struct of_changeset *ocs,
>> +			   struct device_node *np)
>> +{
>> +	struct of_pci_addr_pair *reg;
>> +	int i = 1, resno, ret = 0;
>> +	u32 reg_val, base_addr;
>> +	resource_size_t sz;
>> +
>> +	reg = kzalloc(sizeof(*reg) * (PCI_STD_NUM_BARS + 1), GFP_KERNEL);
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	reg_val = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, OF_PCI_ADDR_SPACE_CONFIG) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
>> +		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
>> +	of_pci_set_address(reg[0].phys_addr, 0, reg_val);
>> +
>> +	base_addr = PCI_BASE_ADDRESS_0;
>> +	for (resno = PCI_STD_RESOURCES; resno <= PCI_STD_RESOURCE_END;
>> +	     resno++, base_addr += 4) {
>> +		sz = pci_resource_len(pdev, resno);
>> +		if (!sz)
>> +			continue;
>> +
>> +		ret = of_pci_get_addr_flags(&pdev->resource[resno], &reg_val);
>> +		if (!ret)
>> +			continue;
>> +
>> +		reg_val &= ~OF_PCI_ADDR_FIELD_REG;
>> +		reg_val |= FIELD_PREP(OF_PCI_ADDR_FIELD_REG, base_addr);
>> +		of_pci_set_address(reg[i].phys_addr, 0, reg_val);
>> +		put_unaligned((u64)sz, reg[i].size);
> And same here. Something like this should probably be used (untested):

will change to: put_unaligned((u64)sz, (__be64 *)reg[i].size);


Thanks,

Lizhi

>
> static void of_pci_set_size(u32 *prop, u64 size)
> {
> 	prop[0] = size >> 32;
> 	prop[1] = size;
> }

>
