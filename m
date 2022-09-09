Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FFF5B327F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiIII57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIII5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:57:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B539BE02;
        Fri,  9 Sep 2022 01:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6MSS2bHoccIkeOyUFq4W6bUIzKlxOYaCCrBbVmaMo+Dxzvd+gsZJutKWIjgp2/btDS4HofKBLOgYtWbIZx6x9R0eIXPmSBp2f4jxblxjNDB7Y7xuenBUn9aXG1B0BGGUd1FXZxSGGWwyIYBzTntpbrvmhthkVY1frIQLEn4TrXj83HJph5iYZeenPrYYNJuUuU1fBErVXCkaBLFd1K7zopdlv/+hgngGrSPvskAuhZ4k81GrWPLWEDGROGUEy8lG/crYPPQIFMq4Eikw7EpzWb70CPgm+z/NwSvxS/2IVMg8j2R2f8h2pyr1PPTrpWQ+z+Bxmpt3xRYU8/ssg8gAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT7sQjFZyXwjDITFf1uI8NshPXPaGahTPlfd9VvSZyY=;
 b=DGbJZKLRxu16oH52jsy7MLun3hvVC5ppIY9ZM8kS7PoD653pQiO7CWY0mqa04QyctnZspf5BHlCqSYfsQp/fOexryxdQP7QHVIVn6Fqm1b8w7jTp6LpxpOS6G+7e7kVFh2buKWcdnV/RnixFndgu36vp9J2XR1eU9mQHT+EmXH9sKP4aVdYaBZQ9JWeccAJtCVCaSTEUUR9MxyIhTn3lYuRVQlsvmN76D74jwkM+OYswEG7gZC2l+SkIwixInOJoBz5syUM0GXDt/RCGXBbLgOIKU+9DHn595m2IhrET1ddR/VHldWwL6gKg8z74Xz9K+2QPvvXbzbts8hPa2IzdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT7sQjFZyXwjDITFf1uI8NshPXPaGahTPlfd9VvSZyY=;
 b=dTB3l/kAb63RqJU0DQxeAbFJ3OFWA/eQmlNrLh99JR0QwjNXUutLpkYyiY7goHIDSDnD2UBjppQe+e7+/EcYSKCgc4lnzhxGNWNW3F9Blj2ch4D5hliMgNwla7Zhd9WQovPuIAPZYPuwb2Vi6oCy67eamHQmLcfmoIikGOOc92A=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Fri, 9 Sep
 2022 08:56:24 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::3d) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Fri, 9 Sep 2022 08:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 08:56:24 +0000
Received: from [10.143.120.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 03:56:17 -0500
Message-ID: <f62e5be8-a2ab-13f5-8b01-572bf193a1b2@amd.com>
Date:   Fri, 9 Sep 2022 14:26:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/4] drivers: misc: Add Support for TMR Manager
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
References: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
 <20220909061916.2935431-3-appana.durga.kedareswara.rao@amd.com>
 <Yxr77l3UGbphuJkM@kroah.com>
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
In-Reply-To: <Yxr77l3UGbphuJkM@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: f868c33a-fb37-4c86-c9a1-08da92412c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aWr49FP+9HyxxgqI5IxSb9L6dJMQ8d9HBxBURRT3hlY5qxJmkFvBgY6cdeoEI80WoOCQKcr3gF6yeVu/iACRSuD82xBVMxdyHTKnLPXMOhb2IOw2nUbX5Bh4OhQxfPOQSBUqG1h9e8Zedf1Z24W/USL7nGMVKKziyjSouM9+suZ26uZiBTpAUs5Qb17yasquewBldvKDOT9yCtI86st3IURQvT5TWICBVnUC6SZwoXEVFXOBh63g2WNaP6sIAnfTwvjMupx7pwsZ/SerY33KgNbtITAPHtnmzxH9bgkNplSGk3jfziHJlCntk2XwLBSZQsQiLUGMzdseQlV3D2Tl0lWcelUdrbxqGlU6K/RTiTtt4cEcuXjN6wIL+T+FrDJJOCtj46DOw6Qb5EJhlnfML4eZ7MZlb5hWe2wahZnBEtM+T10Wc82xcaGR7uhCtx5uQsZs6WI1c8IL6YZ3h+qzrWhpZhi1JJKJ6wBq5qLlwzNJwLwqxO7kTVmJ3aOSE0eka+OrSYh1hjluvcIPBS4iiNVtCgeSbskBQGeYFwi4D6lb+biAEyMKoVaLTec32V00GHqWDg5iRmGd/86PReZmqQL8rdQZ9YcOdHhe0I3liwemhFCgRwpPblTa2f1XzMeaEgjL0S8zfti1+4i0W9WxOSC29wL4KxbBSYAA6mRnPfUPZSrSxqh0L5rr55TOTwnRnMn/JrRl+Q0oD4ifbdPQHr+0jSj5cwArtvYTyLLFCyUXQsvLIjsgtp3mS5fQL4jHi/ZQy1wVodPAD/pzPa9UUzA5lyWQwvZNGSz/BVlsD4gvty8aSY5SSo0nmpObkYkO5DibMZwOcg7hRtMk0J1P2/q8IQzFLwxP4FmKr/fDLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(47076005)(186003)(8936002)(81166007)(16526019)(2616005)(70206006)(356005)(36756003)(70586007)(426003)(4326008)(8676002)(40480700001)(336012)(31686004)(2906002)(6636002)(16576012)(82310400005)(478600001)(5660300002)(26005)(110136005)(54906003)(41300700001)(6666004)(53546011)(966005)(82740400003)(36860700001)(40460700003)(31696002)(83380400001)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 08:56:24.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f868c33a-fb37-4c86-c9a1-08da92412c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the review.

On 09/09/22 2:10 pm, Greg KH wrote:
> On Fri, Sep 09, 2022 at 11:49:14AM +0530, Appana Durga Kedareswara rao wrote:
>> Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
>> subsystem is fault-tolerant and continues to operate nominally after
>> encountering an error. Together with the capability to detect and recover
>> from errors, the implementation ensures the reliability of the entire
>> subsystem.  TMR Manager is responsible for performing recovery of the
>> subsystem detects the fault via a break signal it invokes microblaze
>> software break handler which calls the tmr manager driver api to
>> update the error count and status, added support for fault detection
>> feature via sysfs interface.
>>
>> Usage:
>> To know the break handler count(Error count):
>> cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> ---
>> Changes for v4:
>> --> None.
>> Changes for v3:
>> --> Corrected month in the sysfs-driver-xilinx-tmr-manager file
>> --> Updated the Kconfig to compile the driver as a module
>> --> Removed unneeded status sysfs attribute
>> Changes for v2:
>> --> Fixed Month in the sysfs description.
>> --> Fixed line over 80 char in driver.
>> --> Replaced kstrtol with kstrtoul as suggested by Michal.
>> --> Added error check for xlnx,magic1 value.
>>
>>   .../testing/sysfs-driver-xilinx-tmr-manager   |  16 ++
>>   MAINTAINERS                                   |   7 +
>>   drivers/misc/Kconfig                          |  10 +
>>   drivers/misc/Makefile                         |   3 +-
>>   drivers/misc/xilinx_tmr_manager.c             | 222 ++++++++++++++++++
>>   5 files changed, 257 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>>   create mode 100644 drivers/misc/xilinx_tmr_manager.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>> new file mode 100644
>> index 000000000000..2a97be6ae849
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>> @@ -0,0 +1,16 @@
>> +What:		/sys/devices/platform/amba_pl/<dev>/errcnt
>> +Date:		Sep 2022
>> +Contact:	appana.durga.kedareswara.rao@amd.com
>> +Description:	This control file provides the fault detection count.
>> +		This file cannot be written.
>> +		Example:
>> +		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
>> +		  1
>> +
>> +What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
>> +Date:		Sep 2022
>> +Contact:	appana.durga.kedareswara.rao@amd.com
>> +Description:	Write any value to it, This control file enables the break signal.
>> +		This file is write only.
>> +		Example:
>> +		# echo <any value> > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f1390b8270b2..5fc5ec13985e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13277,6 +13277,13 @@ W:	http://www.monstr.eu/fdt/
>>   T:	git git://git.monstr.eu/linux-2.6-microblaze.git
>>   F:	arch/microblaze/
>>   
>> +MICROBLAZE TMR MANAGER
>> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> +S:	Supported
>> +F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>> +F:	drivers/misc/xilinx_tmr_manager.c
>> +
>>   MICROCHIP AT91 DMA DRIVERS
>>   M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>>   M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 94e9fb4cdd76..1508cc29b05a 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -496,6 +496,16 @@ config VCPU_STALL_DETECTOR
>>   
>>   	  If you do not intend to run this kernel as a guest, say N.
>>   
>> +config TMR_MANAGER
>> +	tristate "Select TMR Manager"
>> +	depends on MICROBLAZE && MB_MANAGER
>> +	help
>> +	  This option enables the driver developed for TMR Manager. The Triple
>> +	  Modular Redundancy(TMR) manager provides support for fault detection
>> +	  via sysfs interface.
> 
> What is the module name?
> 
> And the fault detection api is in debugfs, not sysfs, right?

Fault injection happens via debugfs in the tmr-inject driver (4/4 patch 
- xilinx_tmr_inject.c) patch, Fault detection is tracked using tmr 
manager errcnt sysfs entry (/sys/devices/platform/amba_pl/<dev>/errcnt).
TMR Manager is responsible for performing recovery of the subsystem 
detects the fault via a break signal it invokes microblaze
software break handler which calls the tmr manager driver api to
update the error count.


Regards,
Kedar.
> 
> thanks,
> 
> greg k-h
