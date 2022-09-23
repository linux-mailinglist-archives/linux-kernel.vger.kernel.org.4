Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219175E7B74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiIWNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiIWNJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:09:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B513A3AE;
        Fri, 23 Sep 2022 06:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyaPiv5dBpcQzbw60QHF+iohovftM98K3L4mR7Ue1yhl7mAA9Kwdm63/mCL06Dsl3xy0ibj6UV04gKiHxsmDhaxoKZ1gNXCHbG+GRrrLa7d0nK0TzowIGifgH5VxEb/LvdrChjsl9yJKkRGG/IeyNlXcbaOBiSkhNf2ZvTrX20i+HX7xrzzLGaPh5eZWI4K2+G9Xc+0t/GXlsJaJj9Hd8vNkkWY9LJEhaY5sVUyM6xssSe5jKRUwiBj1avfu2eZVTFuEOiqnnqtSy9xVS6EVkPKJsptatgaHfWXPilinNnXu8exaT36emm0yvb+bBmZvhp0279xUm+Gc6LI7yjnR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivaQcTI4CleZXPdYOJR6OqkjyPtfKRBXpnIG/VW7M2k=;
 b=U7lOKuvYAnfh1KdVLDUh8sPXPwndT8kCTXrH7BZxmZWLUZr1J883TxbhLXZm9xlwO0I3dk1K766HdHVAczr3yFzXd+IYfousNJDXKz7nrjI2/hJTCsifUr3nA4458ld+GXw2Knoqd1Pa6Sxg7nvfEQfOl5/2uI0JIrjL/+SkkrQAVL33XL7mfKmSyAI5M9D8DpFdpjdIbksqYda6N9jfUWavw4vfVXkSAuhSbpOwXvhJoctVxTjhjcfVK0xKMS9Lg1jdCbaPOIz9V8T3lTRBMD4nrfO0KrAVkRJQnvWfpWw9Tav7KGmOSj6lB72Ev3GWMtWD2HnDjEp2YmP/3TmyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivaQcTI4CleZXPdYOJR6OqkjyPtfKRBXpnIG/VW7M2k=;
 b=y7k3Tn/7KQO0V56wyh8gfkZZFmrYi/exQ+r/Y6hi4Hi7lZo+4tkzz1yExZVuPqff2aqRaXULsAmbl+3hZSosUYhS5mw+zzMHllrlKz45lDTTYOc+84C32rWM/4TJCpt3HIFNYSfgVGdH1G70lmhPj3E2kBtoCk/XWmM2nrAUaN8=
Received: from MWH0EPF00056D13.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:16) by DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 13:09:01 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWH0EPF00056D13.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Fri, 23 Sep 2022 13:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 13:09:00 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 08:08:56 -0500
Message-ID: <479b13a3-08f6-c7c9-dce3-13831d69da3e@amd.com>
Date:   Fri, 23 Sep 2022 15:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From:   Michal Simek <michal.simek@amd.com>
Subject: USB companion HUB for usb5744
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Mehta, Piyush" <piyush.mehta@amd.com>, Marek Vasut <marex@denx.de>
CC:     Linux USB List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 88951ce4-c18d-457e-719d-08da9d64c871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AahqgyjWVU652GJL6HOqPEKqs7uZZK3nro8zDtM2WK/aYy5tndcMU/gUfFiOlx6BhysxSBQ9LPDQHhaD7HVWObJhIwyWThPwcDSUwNtkK/ZZJIJJKkD45mDdMOMatb256BSPnb9YoBLZltS6Y1U7cf3Kgum78ascsiI9RF0crCRQx+WlGOYdZ8+sUt0GjnL1FDKZb6cwhm+Ot3ZIBFp4fdIdma26lxm8Lbb69MH9edHqyw04sKdZpGbtPHa0SU16d61FuJQDM4kw9o7DSzl2We91pZosve6Vj4tMR2s3FpZfW2luqf6L9tZhfgQRZSljAIPFX8ul44RhwTuFadtRsiBKwcm+A/39OmNjUPdI4ErEq9eeZn1OCQ/IGLMsu0R7AkACrrbPIaZfb5ZdsPCIZdbu3HEZj4pdinRH05cxeH2RRq7/j516T5eZ6fpT/4BeOKWDb4nux04r6xfzgnnyNC9UjEGPrd4CaeXWwG/GhLs7Zli/GW4kWJvoTv79IXR+8Et+nwu/hcqH6f33ZkywWg+rVfhygyehaOZQJdaR4MmlTxfK3mm1XJvv4/7X7muQKXmwWFi4RYe793y9WCvsXjjW4ydU4XXvTiTwMmH4xLUxLnBPGaoMC4VbU6uv/K26QEyANDvNpEvWoZrmd9+auXxHzs4Hj+6pqRt4e1oPHOSM8UZHdb7ytqB0E295SszFXvA8wWzYtehAKt0mWxLxD3zs86HuKXVKp5c0w5Tpys6oGmYlNbKjL/P7LH8dU9KahWxlCYqijAwHJq/NbqPMIX0dwilLIErWAOajiPne3QiqWycFLzl3QOvN6nAmOd07pm8Fc5G1iMTYvdjgLjYSVL4wbOLM0b28YYjanB05o0E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(356005)(82740400003)(4326008)(8936002)(70586007)(70206006)(40460700003)(36756003)(86362001)(31696002)(44832011)(81166007)(2906002)(5660300002)(82310400005)(426003)(16526019)(2616005)(336012)(186003)(40480700001)(26005)(478600001)(8676002)(966005)(47076005)(41300700001)(36860700001)(110136005)(54906003)(316002)(16576012)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:09:00.9639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88951ce4-c18d-457e-719d-08da9d64c871
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

I want to follow up with you on discussion we had couple of months ago around 
usb companion HUB series which is finally merged to the tree.
We are using USB5744 hub(4 ports), it supports USB3.0 functionality backward 
compatible with USB2.0.

To generic driver support for regulator and gpio reset was added.
In our case usb hub has i2c interface connected and hub expects initialization 
via i2c to start to operate.

In past you mentioned to create new file just for handling hubs itself.

Anyway from DT perspective I discussed description with Rob some time ago
https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
where he wanted to use i2c-bus link.

It will end up with description like this.

	usbhub0_2_0: hub@1 { /* u43 */
		compatible = "usb424,2744";
		reg = <1>;
		i2c-bus = <&usbhub_i2c0>;
		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
		peer-hub = <&usbhub0_3_0>;
	};

	usbhub0_3_0: hub@2 { /* u43 */
		compatible = "usb424,5744";
		reg = <2>;
		i2c-bus = <&usbhub_i2c0>;
		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
		peer-hub = <&usbhub0_2_0>;
	};

In probe onboard_hub_power_on is called to toggle gpio line which we need and 
then we need to write 16 bits to basic initialization (or more for different one).
Marek also mentioned that he has another chip from Microchip where i2c address 
can be setup. I think it would be good to get any guidance how this should be 
integrated.

 From my perspective i2c address should be described in DT.

Can we use any description like?
i2c-bus = <&usbhub_i2c0 0x2d>;

And initialization sequence via any property with 
uint32-array/uint16-array/uint8-array types.

Thanks,
Michal
