Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5D65D13C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjADLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:12:32 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC01A042;
        Wed,  4 Jan 2023 03:12:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk0ZLnfqn7Ywsc4QPmhluy3lzDojyho83yUBTopOFNCcb1wOTV7p9mrErV4aJi74+BreYEBQu5n/rqnwPGVYCHm+DnMEs7+iZaDwi/NfFOTGK2V6YAs7gzni58JlazwpXMRCyypn+muG3DS2YPPgKB5cCBKtyklTmGp3kKPUiZ7SYxqmTdHvZKVvZ/5QuLi64BnH2Hpc805Hft4RVbpk3j6M37SrS0PBP/2bTkO4FTpE15HrYYKNzq8aJQFQr8Trc4HRN+JqjYmixjmeqmFFulrMhgXIEOtntj+SzFxq1euAB1CesyUFdeYzzE/HbIFlLi/j6wtD9lhzBJPPvE7TEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwMY1ar/PJZFPZ4MvSYCh+vAOyXmxYRCYXfGfIaMO6Y=;
 b=Dz0O8ihx86MJLJB/D3DbWdIo0PNnbwiVXnaEmNJz9b0BufcUrge8EwlbM1pUzWj3tUWS8Wj1vkW8eGTG5dz73Jzd0qoV5DwS4jAHIlwBqPk3AxqnTvswNegxU7R6wrAt6ih3V4AhzhIspe7sRr8u/UVtP+MYenFrD1JrGrtkuMjkGwjE+Yp6wh785SW30Vr7McZ5ypRM1ibc7Q0hzyKpFW8dSeDxa2UFy+r1xiR69vGzXNBK6ceBMioD1nWWBDUREvq/c3y1cqwz+gTTIPzz47E+nGkEmNNH4WEOk/ExwweVjYs/tX4vI29cILk+iJLZ/+YUVcfslpADWfG+dMuj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwMY1ar/PJZFPZ4MvSYCh+vAOyXmxYRCYXfGfIaMO6Y=;
 b=klMN7cLch0z5hxfw1f8S+cAkYIf4TwiSHDvW6xCKo6RnEzGZ2WcDHs2WgBxiWXy4Itjgxo35ZqZ7Ur8Yy37ckEBnqKpkSeZmkqWeOUc4t2Uf8t/eOjciz6wwWG+NQDFRY8PS6JyB1Ewcw6T8YrxdHP3+HRUEm1yAZY11W+SdJWY=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 11:12:28 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::36) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 11:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Wed, 4 Jan 2023 11:12:27 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 05:12:23 -0600
Message-ID: <4ab597db-6eed-2dc8-1722-6b253bee9a07@amd.com>
Date:   Wed, 4 Jan 2023 12:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: xilinx: include linux/gpio/consumer.h
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Piyush Mehta <piyush.mehta@amd.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230103121755.956027-1-arnd@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230103121755.956027-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c66bdfe-d22b-46bf-d766-08daee4490b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luGGvEGDgoCUCkvLDunvU6HWFFfEiY4R9oySwVVrNj8C8x0xOd7G+OCIg7h8cJ2CpewSKSkAsxbcljojQkxUNMHHdDvqsG1/chvjXwi4Fqp+ZPHTz/Pz26Dka0pStlGK6SxeVM7Yzn5ONbD1K8LsHPGDU6iweuem9N7u9Bmc0eu3UHKN1aoHBfLhDkWdj8Ft66BoNvE0Ry/uiwbkZPIOqeu7YddslO9OdeTQxsIS7PKW3iiMo1v0ULEHsY5pfyuR4dit+8Jj2NS99TUyGeD9kMYGQrFV6edxdb5avlTGGNveS/akt1liHatYJF+Z+BJI9jxEFD9U8uw4U9rV9EQfGHP6LuMITwCjMG6V2vNBGTkMfS4SVnOYPP5k4QNgm3EIFtZh2Ja05naWmwBJWOYHIKx9hkFGTyMGQM1fQ9998bwvEM/5ms7XWZlhMS5zeZyzrpRaF3bR3wrwycVHdsR2EMEe2iDbEc0bFaNImALTorDJEkIwXQitWckzHvNBTUen2wRoWaWAjg3sGCJY1ezryAmJE/qepBHmbIcFkNTbuULjhMB24GCgu0gScDgPjm0JhS8B+In1ovMwnVEF8ds1AQxdGRKkHqYZWAQMNj2BJHWz3A4OTawAexPQD0yKzZbn0W/p+b0W5cxW0GaREIh8lMBybQiX3uPd8Wzfvhykkmx2lsaW5YzhIr3nh6QnMzMDGKtSdG4zjLjpTU9PFyXpV0oM/fTmc6eZ7m+9f/TqBOaOr0evhAPgwlkji7j1R7gAVISP8lu/gSxQUOx9pJmGBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(31686004)(5660300002)(44832011)(2906002)(16576012)(316002)(54906003)(41300700001)(70206006)(8676002)(4326008)(8936002)(110136005)(478600001)(36860700001)(36756003)(82310400005)(53546011)(83380400001)(26005)(186003)(47076005)(426003)(336012)(16526019)(2616005)(81166007)(82740400003)(86362001)(40460700003)(31696002)(40480700001)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 11:12:27.5292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c66bdfe-d22b-46bf-d766-08daee4490b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/23 13:17, Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added gpio consumer calls cause a build failure in configurations
> that fail to include the right header implicitly:

I think it would be better to say what you have done exactly to make sure that 
developers will run it before they send the patch.


> 
> drivers/usb/dwc3/dwc3-xilinx.c: In function 'dwc3_xlnx_init_zynqmp':
> drivers/usb/dwc3/dwc3-xilinx.c:207:22: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_clk_get_optional'? [-Werror=implicit-function-declaration]
>    207 |         reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~
>        |                      devm_clk_get_optional
> 
> Fixes: ca05b38252d7 ("usb: dwc3: xilinx: Add gpio-reset support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/usb/dwc3/dwc3-xilinx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index 8607d4c23283..0745e9f11b2e 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -13,6 +13,7 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/of_gpio.h>

Origin patch added this header and I think it should be also removed as the part 
of this patch.


>   #include <linux/of_platform.h>
>   #include <linux/pm_runtime.h>
> --
> 2.39.0
> 

Thanks,
Michal
