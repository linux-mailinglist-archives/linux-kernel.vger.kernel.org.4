Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E084669B49
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjAMPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAMPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:00:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4365F4A1;
        Fri, 13 Jan 2023 06:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qbwo9Ei90lcT9wUWWmBVG3gATP3x/fDy3BDeX3Ouz3OMkN04dxILP/u9AbeN3sBL+k9YgBxjh5qNWptGGri/QPc6d5hQE9uvheRuXbGiGBM0vX+25VrJhp0KAyKxQ4HkCi9AFsw7rIwJw0qazYG0S66MYIf6xkqIN/Lu5GLKnM5HW5T9py1MM7AX7USC/VBmZyjfQuRmgQ3S8x/93m9Oi5j0+QK/xCul7cglPhKncro97loKBFOnckDB0Pne7vu591m3rEK2k5KYQEbIo4AChmJv9Xpk6rN66XAZnZpBvNkbpY9LnVQvdrzcBUf08Lod1dwH4SWyAoR0rIddq8uWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjoBLY1J/s8V1+s7wcebQfq6NnPMWHCqnUeZIHd1lQ4=;
 b=il6pqP+1AY2fvJGOp3lLMwDbLSan3n3pnl5WobKHcvdZ6GdYEYjR8f5WDednO8gov1Dkz670gwHljdiYz2Q/EQMnvfekkfJmrOUJLh7w8XFWoBBIjN/DC8/0zFBOIuozc7/k+7JjdfcpZ9r51JEcw6Wn0qRJZ6osMPeTVQiPIq/QDy2VzL4O3wBtv983v9yXF9uApQSLQvpxXKW+P2ck6RmjGxpAUZohD0oqmvRlStq3AIsDvdnreDsJu5PGnk+cuqJnHPDl2Co+IkisCp6t335uSQrhhBmuKqTBrdwexTIJkLejCeHzqQ2PMfKpp9YKKjYJHeenCz7IdlWtuct0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjoBLY1J/s8V1+s7wcebQfq6NnPMWHCqnUeZIHd1lQ4=;
 b=K3PW+ajqb7iVtqm9ufmZhdzBKVlFfQEZ3wtE8A4UWWfbOBuE/LUwkThEsVUc0Ni1WTOqkRSw72L1/JHngZBi4KWvUNZfV27Sk6KpHRqJy3XgeoJmqMhz8htQs4Nhc+rvvTCGk5EqUnjMYHGp4dtCqrdHfiO4u8fnVm48TLwSfpoZnmXE+6oQP1X7ZAaw9hIN//UQ3Qulh3kE1BHBedYImAwuGCO3aR//W+onSwfhdPHDQ3W0YvEctSTGdQ660AFYQ13qGUX7wrdP0ziXabKMDCoFeIYcldXQn12z7xSQan09/hnRxS5TdL89vBRJ4vh0O3Wm6QNKgTfbQAJ0rfdRcQ==
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.21; Fri, 13 Jan
 2023 14:51:27 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::3f) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 14:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 14:51:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 06:51:21 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 06:51:17 -0800
Message-ID: <062a2dd1-29cb-1b5d-6be2-0225d3029a83@nvidia.com>
Date:   Fri, 13 Jan 2023 20:21:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 03/10] memory: tegra: add pcie mc clients for Tegra234
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-4-sumitg@nvidia.com>
 <e7324811-070d-999d-89a8-8e291caa92f1@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <e7324811-070d-999d-89a8-8e291caa92f1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|DM4PR12MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 954802b6-1e6e-4e14-0d35-08daf575a5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qmz4IKo420q2CtsZAnrQQs+CefeS+c0FBZ6XO1VIXTJqMnFz//SQ5zfR1hI/DaYOmqWoEs/LQYalU45cl3tYiaYg3EVetq6j4GMvWNlvv470C3nW1vIoHU17XFQ/ZrBdIz89D3DONetLgQindmKh2TabqZULJ1R93xZ9rr0FFeqYudCHjkJchM4lkyrhMTp9mKdqrybJ3JQL6/snuyADoFh3v72rjVKcPursDl+Ae+vvN36tfYOCVAuVp4P4o0TkBPgL51hi7JAYmHE8nXNgJZ1OfRnjgh2H5PnXJPYP/QRjKIX2BnBdMOo59LD6Afkjss7HlK85rY1IKuKM23tTEp0hVAkAg+qwe2LKqqfwQL1CToezwSDACkxLbdNRxv+iJWpJ4Gv4v+xcssEJ4PGXxO+0Z1t+rtHiak08XP1gkHnQx5kN7hSjCO779U58Wz9Eq5WBoX1Nm64Wup4OLkXK8WSklZleHGDrRFE8n21M7lR3OqkaYvVFT6c/fBbPXT9gPAjvhfQzEHyW5axJUj78L4jFtQ63A/UQUU/F0j2HBLLB4JPpx5OVHbESUJwbExS0gzGJcsCjD1Xyql+Lrh5Jhh7wX0wfSPu3A+hYlstJVGhqa+qk3T27BmIIAvGaz2888ZrVicxId4zdLCeVQ+NeUKp/9CwZFjlPx6AVrFx71juDEdj9YtSPvXJXpKFCzNsymfnoSAzClsYlyk/jeKSOieWOCw2Pgxoz66YRCuLv6up9pIpt3bx4Lq53pP1SL4mf
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(5660300002)(110136005)(54906003)(16576012)(316002)(36756003)(2616005)(82310400005)(36860700001)(336012)(83380400001)(47076005)(426003)(26005)(86362001)(186003)(31696002)(40480700001)(16526019)(53546011)(921005)(7636003)(356005)(82740400003)(478600001)(6666004)(107886003)(31686004)(8936002)(4326008)(8676002)(70586007)(41300700001)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:51:26.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954802b6-1e6e-4e14-0d35-08daf575a5e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 17:03, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20/12/2022 17:02, Sumit Gupta wrote:
>> Adding PCIE clients representing each controller to the
>> mc_clients table for Tegra234.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/memory/tegra/tegra234.c | 314 +++++++++++++++++++++++++++++++-
>>   1 file changed, 313 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
>> index 2e37b37da9be..420546270c8b 100644
>> --- a/drivers/memory/tegra/tegra234.c
>> +++ b/drivers/memory/tegra/tegra234.c
>> @@ -465,7 +465,319 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
>>                                .security = 0x37c,
>>                        },
>>                },
>> -     },
>> +     }, {
> 
> Didn't you change the same structure in previous patch?
> 
> Best regards,
> Krzysztof
> 

Yes, kept the Iso-chronous (ISO) MC clients and PCIE (NISO) client 
entries in separate patches.
Will merge them together in a single patch.
