Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8867669BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjAMPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAMPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:14:42 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821987ECAE;
        Fri, 13 Jan 2023 07:05:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLlTxG/pbYmXFpcAM2L33wfmtgP5kfCWbsTeLXMgXGv8eBZXxK25nvXAMMtTsshS1foiOiQj3eZQpQfWkByDsa2vdUMiFBhbuwYWm/yJXQJk+lC4Tj8k9ld+Y3lffEcK64dQ2tw/vd+ghQB8b7fdGGdRVLVdM5wD3mTYMp8f6lU+SQI85bzf8aOt1u9VYUEOQh42doRtF9Z2M1b3ijZSzsZCdA/WZs0xLEAxU6LQtfDRaixAtsd6vHn5Jq4gyogZ9sh5ZGuStrnKqiED42OjkhRlRbBSwGTmlEfUa0WeTFwDOcx2dbDDmitNjRmLpuVDeAJgoCtM57IqG4tXOiq+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOczCdgN5DqUoAc95V+Hc9JYUbQDZT7xpQrj4scB61w=;
 b=genk86JN44tMmaPJwI1qFmlwcHjpjN6R8Lw/m0BT+TWKYbHr+JKnh++hSoRZe/2HUndwzFaNIpcKD8ZRWVZrfqcwIhzawQkYKovu83zsn8sjJF7NskjKyAWPh+phl5VOeN184dSJ2V+w7ag15oojvkuRdYiEZ4k0eLajCG0lQ8YJr9QDQQLGu+BSYRhoVz4S2M5F1JpmxMX3YKgxBjZn6sxIRCuZJFpXZmYEnTR+CmdEzKkPKkDyboVWd98GqZOzb9nWAD2qyhVp+895jIqy9blovh0UCZj9RRKpf6aTVwrUDk+xlzG8A21VC1hdRvhel2+LTeqtAYB0GEC21af29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOczCdgN5DqUoAc95V+Hc9JYUbQDZT7xpQrj4scB61w=;
 b=Xlw6klOwyKKtbdJUDt/DG3VKuS8AUQdsMCPE3kkQA2io+cG8XOW+ogpOUr9zdFaSvIuPsN3LqPD2eCsVPAIdaRZF0+mtxB813Wi+KyFGB/sIdwid6kd1t+8xil8SRe/htrepW1ZVtAg90kC4u2zGYmHgftdF1vE0UlkGnevvNmNCRYLyB2+7/xrdgNyIGLdLMfz+ykyqE0722Kp4cMQlmUCMa4pmXTrkLyKZowk+APyBK209OxFwDCN6lZBotCYtyL35V1e03BtFQtJCiK66AHefKOGJsCz6G4LuDUXwwBy+4Z9g5SNmDXygrk8XZbWtvvExJNdGxiDFJHrQUh5DJA==
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:04:39 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::1e) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:04:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 07:04:24 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 07:04:20 -0800
Message-ID: <86f94266-d88e-af82-0352-876bc369f6a2@nvidia.com>
Date:   Fri, 13 Jan 2023 20:34:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 09/10] memory: tegra: get number of enabled mc channels
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
 <20221220160240.27494-10-sumitg@nvidia.com>
 <db223161-a424-c4cf-09a8-ff2241fda71a@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <db223161-a424-c4cf-09a8-ff2241fda71a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: c8adc89d-257e-4c80-ca9f-08daf5777e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QhfWfkENqTSMABgDJEoZFdHZHFDHibV5KMgO5PMuJvY+BqC4cPKhfJIBO3KsM2oTsqeibrIUYGAtiOOiKIBmms9GMFvEGo2Qv83bCgfA9J7R/ldU7q5H8TftIUVpImvi/OI0s9/gDqG+XBSYhIzpEzqBFqKnriOVv2nNwrG8qvpqwPrSG540Lon9SaxB6G/EwsLK/BTCdk69s0JIcgVjq6y2Y7Etz3WkOzHz9FFNwPCHqhXe8kNKl12+B5okJ7m6Yodi09MDhn7l8tRE9JJXhcyCxVOSLZimhHuJCefR3T0ha1LT/45vEXi0FIBLjpLNh2RqfCw9F8r46oesa8uWmmBH2PHQuD0ZN8OZAV2W6zy+nHkU6vquJVhfX4WJpXmUnEx40YGbezYAR4nzEel9cF3QBJx2JsceVAGvBjFmY84h7FVdDuCnylhxyCRb9ZDzr3NvZBHHpp44QSY5phHJB6YAO10crOy7et6CGbuAUPV7DQ01VCYKRGIgh2NLd2mEcg2UbmIKb34BvT4WSVOOqxzQ/i7KZJpheuasURYo6sY08MaRGhwO4SD3cWUUhOzqod8CD0evI0RPxbkpfBy5CCsLTXgNRDObmuqrfmzaNhAYJPITsYEooSQM96V87esdaotsBzqbZoZHdTO8rRUmVPeij7wqnq8A9bOKIuntM3yccVLSTxVHhVPzzyqfDObLs4bfIj4h4+PMPc2KNJrPOT8hfTgsIIxQOAUErCT1byAf+xW/HRyAFLvDi1uUEQSrpGuXwgqioE39aomds4i0TVQ4dV4THwO7kFHdJX33GfQd66sohXxJ7yngukrWSR5CANIlTj4nELZZHEKecEveg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(16526019)(40480700001)(54906003)(186003)(2616005)(82310400005)(107886003)(336012)(47076005)(70206006)(86362001)(4326008)(31696002)(36756003)(4744005)(70586007)(5660300002)(921005)(426003)(478600001)(8676002)(31686004)(2906002)(110136005)(82740400003)(40460700003)(26005)(356005)(36860700001)(16576012)(316002)(8936002)(41300700001)(7636003)(83380400001)(966005)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:04:39.5484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8adc89d-257e-4c80-ca9f-08daf5777e6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 17:07, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20/12/2022 17:02, Sumit Gupta wrote:
>> Get number of MC channels which are actually enabled
>> in current boot configuration.
> 
> Why? You don't do anything with it. Commit msg should give the reason of
> changes.
> 
> 
> Best regards,
> Krzysztof
> 

CPU OPP tables have per channel bandwidth info. The "mc->num_channels" 
is used in [1] (Patch v1 10/10) to make the per MC channel bandwidth 
requested by the CPU cluster as a multiple of number of the enabled mc 
channels.

Will update the commit description with this info.

[1] 
https://lore.kernel.org/lkml/20221220160240.27494-1-sumitg@nvidia.com/T/#m3ac150a86977e89b97c5d19c60384f29d7a01d21
