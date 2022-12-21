Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD16652D81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiLUHyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLUHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:53:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94F1AF08;
        Tue, 20 Dec 2022 23:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtWNyoRrqFy9UrqFdvxCYVPwaycH/fAqn8Bbz4owf+5sXlBWI3/S6olWlErcKoyHq58DiGlgXJhHwAegEo7GjtEzMBdBpNxF9pY1rIknseMkcxmx+mnKdpf+Zv0Gak3cz0Adxcdg6Qn5sIOzXdly8JFwgORb9ChwDB/hV5WKRXLMVR3ptyM4w78iRDjmzx5Bg11T+3daqBG2OELdRp5awz8TtQUddtWnftXC9J+oJqlRkl5ld3Dl8ZZWbwa35YcAl6QQjL9z5//rve90GEl7uCuVedtH0HBV4cqrP1JIbU1LRMNc0CTPZAJ+2k/IH3afM3brM3wbV/bRPaKd/UnDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udefmB4LIQT4WG7iLtbL1wQWJpKxFkNgYnah/UExfT0=;
 b=mUQ1QdNWU1Yxofx78MtL4K+dlEXu1PUosqKSh0WxWwe1HwKmYY4vWCbRpJD5DGzCpoHgXdmL+t941Kq529lw/Qg8bHyR8Z0nAISAf4TTB9jXn+Eu6T4jNqRZY0MG8Ar4H4fuKgmOduGX+fqL11v6RVBEYP4fLoEr0SPNaakkQWcb1ay0upw/4Tas9tU0YBEeMUG92tIX3QNZad2I6E/Z2HLGc3IOZyyCMSiCWBi9BxGJzlMijZi1Tvust1EDgHVY+SrbaP4rNG2sDYSAH1057xo3xLCEahqC/RdirDq/VO+zmprxGQTKkTQnr+yrZaqfFNdHsv2/yF9iEKYTFXUwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udefmB4LIQT4WG7iLtbL1wQWJpKxFkNgYnah/UExfT0=;
 b=iAkKq9Snmcrr3aEJBKkS+To/k0LEvqj7JoRPEwnLFIzYX01f9jDxRv8PFMPqCYZGWLO/tD/uMDUk+P3SrwqqlKv6gBLPRpt+JLZOeSgQnRlcZXOekpParj4aHC4aHahMxxJjyOA6Te8Yj8cLckoTzuByywLwPXc0FjZvEta1ak71u3cVs8hbS7pu6TVkVmtoik0lKo92Esnpmj95fa00qGRNTSl9sZvGWnhdhCW6PJEeQzDqTb/44Pvn6ZMMvUjiYUL6hZSpZfbW07yPYwgpITgoHimHupDPj+Zo2jqRCgTa4H+v/536Z/l2oqm9brZJoE38gFF7yAdSNMAUtEwmaA==
Received: from BN1PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:e0::29)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 07:53:54 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::2e) by BN1PR10CA0024.outlook.office365.com
 (2603:10b6:408:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 07:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 07:53:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 23:53:45 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 23:53:39 -0800
Message-ID: <f4ba0a2b-55c2-e142-b002-07a3bcab172f@nvidia.com>
Date:   Wed, 21 Dec 2022 13:23:37 +0530
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
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <8e7f0efb-dc90-9dc7-015e-a2d56630f495@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8e7f0efb-dc90-9dc7-015e-a2d56630f495@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 570f773f-bea4-41ce-82e4-08dae32881e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjPeoBK5XXjjXoCDQ8hcP97595ukrOBFt2DILZHE271bayBowDbcFsnbOEQxqujUp0GQxCJx8X8Q/8x6LqKYWt3qEPliYi1O5AlONHZh2g0R/CT/0Nu0YR+LGdPeg7v4mTjNHt2yIAQgrzAHUZJP5mJuks7QS8MEONn7BPiBB9lpX/TbNA+bNh+L+FcpYiQFrk2ZQxs9rMzwS9g7G/x8PIHadn1eXFJQWw2fWgyD1ZbQGj2R7YLoBWQYrf+7Tf/gmtJNagXL0IH/Auf84WGyRWNMETWW/2nZIRCg0lzQ0a5Qr/iWqB7u66r45ebbDZnL+Vm3LGYS+t7+qubjSdaZsO0qjm4xA/RvJWWbLSCQlXKHtJvmp+/Z9kkTrhUUMm/tHySKVtyGmRMzwcanL/IuFxzOBuWE5r19giKOUYVoqUXlMCo6d9+OqB3/CB3p6YU0OoxL+fHN2DEl1jmUGJWtZXX8YVLnY8FuQzfH7f28kWr4PH1jE3yAXtQeD9wjI6fP2SW2KU3qpQ3iA5ROmdpfSJB6S4qqgAqY+AS3T5sIBm+rScNCDvWS+yX0fme0PguVJsnq1UYuarBtghqIBaUweohUx+zerWQIQAp5CDqRIJtzQk+uWYHZGlyajSElTLiKOmmD3det3rUZWK4RQHq5KLrLglx1p9iTOkn8+D2eVZSPwnjaPsPlRCDJP+G6vOcyv+ruyDnezhDRcydDkG/f3v2HKBH7+TBPukSSMWvavwxOs12ZxmQpsEj8+eTTK658
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(110136005)(40480700001)(478600001)(7636003)(82740400003)(4744005)(7416002)(2906002)(31686004)(36756003)(316002)(5660300002)(8936002)(36860700001)(70206006)(86362001)(70586007)(16576012)(31696002)(8676002)(40460700003)(426003)(26005)(921005)(356005)(336012)(41300700001)(53546011)(47076005)(2616005)(186003)(16526019)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 07:53:54.1920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570f773f-bea4-41ce-82e4-08dae32881e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/22 23:35, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> @@ -779,6 +780,7 @@ const char *const tegra_mc_error_names[8] = {
>>    */
>>   static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>   {
>> +     struct tegra_icc_node *tnode;
>>        struct icc_node *node;
>>        unsigned int i;
>>        int err;
>> @@ -792,7 +794,11 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>        mc->provider.data = &mc->provider;
>>        mc->provider.set = mc->soc->icc_ops->set;
>>        mc->provider.aggregate = mc->soc->icc_ops->aggregate;
>> -     mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>> +     mc->provider.get_bw = mc->soc->icc_ops->get_bw;
>> +     if (mc->soc->icc_ops->xlate)
>> +             mc->provider.xlate = mc->soc->icc_ops->xlate;
>> +     if (mc->soc->icc_ops->xlate_extended)
>> +             mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
> 
> These IFs look pointless

Ok. Will remove.
