Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2594652D86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiLUHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiLUHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:54:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2931DA50;
        Tue, 20 Dec 2022 23:54:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf9oufEiPiNt4UaySpm3RIUF8UCu0X/KvY7byh+YOPaohzH3Jer1dHSD/748xFRoi7mapzJcLrroYZw4Za/xPIsSYEgt9jcycKPPJAp0vvLo+ij7hRC9vX7MC8KLuPaXyIQxijnx/4GtKjXgsDZ8GpdyA0GrCbti0cEPE6A7JTM6N+qAKOhgGAJ8gb/UiXqVjor6zU0e9xWFJpCsu5oJa2x8PsJ0EY4KuS/YWDOp6h60rP5bTMd5cUEh59iGKXvtljUAZNP3Zq/KZnpJOd0ov0LOM0Il20+x4KpSiUTQN3hDmf2Gn6Qm63pITJptLFsv1D95XSqKEeM3O+qdtLN5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HanrB0D3W0UTRUSO9+rCQjbLYtLbXJheXlrxme8HGYg=;
 b=NjbsXn23oqwny1v4IGyCKnn1wVGGonqmkG+mstZ6r8j5Fdu/emvF0FHHWnoHqZ9+ulKvHxFKsU3Rprbvazm9AhVJ4NUfa4cNYzLHF0+2Ab8LgNeuuNv1aunf0Biuj7kLoscZ1gpDs6ZwCg247qQSIh6wjKq5IsJfKitSBU+IxcOu/cKUOyx0R9Vz08xw5Ltu5l4HhHs4f8RTv3B/7LoQvheTCQ1x1awyrHiTpp+SMetaqBFyXbcm04MXRhfDhnexKz71+5lSxNRCfe57jx48BM0OfqAtwxi3kWgp4s6FvlMQTWgvhA5bOf4oo2H6FgUumF22k4YAT+qAKkItlvQrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HanrB0D3W0UTRUSO9+rCQjbLYtLbXJheXlrxme8HGYg=;
 b=oIHYNxXId5jveuUA4UQWb5Anc/du/HWIesCCHdHRBYFhQMQJJLBJzbkZT0VkQ1gNazQWLt+0QbPBBdmnFjE6KPaPad/axOeG8mwa4jabDFT0fLCNV68jf0o75D28vfq+PUAjCXgZWpyqMGfxhk7nV44fEYNgAzw2g1zLMPFDMFlG0PfS8dkE4ZuoBHP/oqzt/C/dUPFvdNu2BGbNkJkF13jtBqZB7I5kXeOuFtaNtkSssPqJigdHwXVNqaMJ4mNKzNI6xKCPIzu5V+YU3uZCL0SdKT3txtV8YRiN92OlmX3mbulUXd5gQsTAzwqqyo+TeJ3hHlj+9LgxNG04jLwtxw==
Received: from BN9PR03CA0493.namprd03.prod.outlook.com (2603:10b6:408:130::18)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 07:54:50 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::7f) by BN9PR03CA0493.outlook.office365.com
 (2603:10b6:408:130::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 07:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 07:54:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 23:54:38 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 23:54:34 -0800
Message-ID: <a2b0ebd0-f9cd-5bd2-4d45-57b91e280f34@nvidia.com>
Date:   Wed, 21 Dec 2022 13:24:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <treding@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <23afd0ac-dc3e-3a62-915f-d1af1218e5a1@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <23afd0ac-dc3e-3a62-915f-d1af1218e5a1@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 804c658d-b6fc-484e-2b86-08dae328a30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/Y5iQKy3cpf4/7mpT6MeYNkN6HY2f+R6n+wD9+xbuMQTjchKdUzOqtHhwPDs2O+kDbKe7i9cL4x9VhY+ICHI8T0QzO9T9/0vv+9agM7To4IGlbMjZka/lxkezCJ+8mzOspMAib3DwnnyG6//hmIIovJtXTkknpGVc12pkq9TSmRaDJJyVY2oqs79/laoaGeymLzGsAO/qa8KJcS2ti0Wj6G9L/oVYI+lJJJxQlWIcxRrjHkKDNGJ0RSSWcBo+sDGiiX58kZtUrT+X5zmb9PGizbAi2ySel39VDXBfV8SqMHel8nzCI/su7f4xLA3aljzXtiGfUjCb+H8a4muN+RNraIRIv5nIyeeuFc7QuJ5agoCM8DCmjCPxHVKv5tGAMz1JOPfIlRwNK1xseq1s48SWn3uwcMmj0d6erAyKg9Qdj3vo8HvnFUIiRQEaEwM0F6YiocH5ONYQofgYQSa1xKYE0qAw8XxE4Ww6xICCgdfxAS22RX87DDvBglC7BQZFd7JhWrq2P5rZkEXXAzPoV3fTtcI/c/6eUXGlafdbbG6dM+uXzWPKRSKBaYYwVDh0klxO02Bbp1Sn4Jlp1KpaIFfd0zmmdFxYYZMk1CT9jfUIAykfWCfJY176E40GLo1qC+MKbeq9k2khUwNzJe2S6asF97CTNi6Nct/ud4KCAoB0+VqNnvnwkWmZaq8bcwD4pMQcXdSddxwSm++4rkmGzMZvlTfuFyMuojtu0mfsBSztrg+CfFvZkjYgPoENbWSjRt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(31686004)(5660300002)(7416002)(2616005)(107886003)(6666004)(110136005)(478600001)(16526019)(83380400001)(316002)(336012)(426003)(54906003)(4326008)(70206006)(186003)(8676002)(8936002)(47076005)(41300700001)(53546011)(70586007)(16576012)(26005)(4744005)(82740400003)(31696002)(2906002)(36860700001)(921005)(86362001)(40480700001)(36756003)(40460700003)(356005)(7636003)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 07:54:49.8192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804c658d-b6fc-484e-2b86-08dae328a30f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/22 23:36, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>> +                     err = tegra_emc_interconnect_init(emc);
>> +                     if (!err)
>> +                             return err;
> 
> "return err" doesn't sound good
> 
>> +                     dev_err(&pdev->dev, "tegra_emc_interconnect_init failed:%d\n", err);
>> +                     goto put_bpmp;
> 
> Move error message to tegra_emc_interconnect_init()
Ok, will change.
