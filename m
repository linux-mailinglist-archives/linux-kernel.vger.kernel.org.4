Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78166E65FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjDRNcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDRNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:32:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0E167C9;
        Tue, 18 Apr 2023 06:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igv+x7Sj1sii8b6MPO6hESqJyE8y5+1gyrJusoyIVkj7JdyJ3nXBbxwbeLfR/jOYJ9lfPOp5NcGdzNmqFsx7kHZJ2Tvl7OHdKAU4AZ3kLo2RSBzjdOxm93r4i4EUECcLbQDsFgQyRcPMGLsNfifCRXI2VrekcCrFctDbqm6TMVGbMLqJLTQX5fUUJxstB+UNgt16AEri6C3uymby7WJk/ZUJaVyCVtCeH22niesKuG060z1yeVoNOfyk7+riWy9lChELqCXfLCSbJ1Im4+ntiX7MWC9hN0aqofVLXDEMUCqg/oFcmmMUVdizZ5VNuxln8jcUgC6pX9y1dwTOE44Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g/59mYXRlxY8qfHLn5Pd7vjovJaCFtvITeFgn0zTfE=;
 b=UQ/LuygYoZxqBXzd/4snLbtxG70ZnO1zos0jNwgh2zyZFNnk5e50LMgF7ZNUf4cuzylZuCVIH9hudPKc1Jy8dw9ujXkmHvLxRFgtuOmz/DmOKT1aRq01Qr0YMNgz+quf3ckqNksKhs/6JMpMOvuWW5CbKmz6AZ12jKulB/EMrv3J6Y5F3Tt7MSTn97YMK1PBBJXc4dZNYEjPTinZTzcUuntAGaQn5a21RsJuEmPqiDWB9WNFaBvbq+Jeg+Q0/Opcz8+I/NSPdF767vn9ExMhJQRFT1uNimIMk/r7wfoU1YSJHDgnxeSv5teJxQMtYquNxH9j7jg5lzquga1bNW2ZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g/59mYXRlxY8qfHLn5Pd7vjovJaCFtvITeFgn0zTfE=;
 b=owoMNDq7T+p/qFUpw7Cq/A446xSenT4B/cixkW03JR9yZG7/IxxdHZBVi1LDnTqvKnJROu6KFO3Wqr392SZnhrZ4hMRHRKfAEF8VRlP8FrjkVwRho2qzLq/XkhrLTK6lMZRmk1TkqJ2bPVtwXSKd/RAQeLnQMT4kA3zchrXWlUF/VvAL5x3QnOIi8DJBWntDSedbnmQQVSkCyzS+lUrGYr6Y2J5aKQxvADl5it6m98RAKRAHJrGqypqa5EHw6d40jsMZzMhMJdD7SkBeZGEFzzQJXMJykOkJ9kHN2daFdsDIsgZwGxKaOCwjYHRCTGIJWYrS3MIo92eCHfA9ZTFgNg==
Received: from DM6PR10CA0027.namprd10.prod.outlook.com (2603:10b6:5:60::40) by
 DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 13:32:03 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::1a) by DM6PR10CA0027.outlook.office365.com
 (2603:10b6:5:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 13:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.16 via Frontend Transport; Tue, 18 Apr 2023 13:32:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 06:31:56 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 18 Apr
 2023 06:31:48 -0700
Message-ID: <05feec0c-c94a-a0e7-3636-1927f6621cb9@nvidia.com>
Date:   Tue, 18 Apr 2023 19:01:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch 1/6] cpufreq: use correct unit when verify cur freq
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <lpieralisi@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <sdonthineni@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
 <20230418113459.12860-2-sumitg@nvidia.com>
 <CAJZ5v0iMcVZMd3YpEC++BZzCwOM2ocYQuK98tm9gQq0fjO41gg@mail.gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0iMcVZMd3YpEC++BZzCwOM2ocYQuK98tm9gQq0fjO41gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: aa01709c-82ee-44b4-101d-08db40114b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtVVBbzVhQa/MY8XPlcuIr4k/b2e3clMz13E5pPE5fS93tHvMXrIpKbVknMCHWCz2tKavP3v0r8Y+JAIEduTHD4AWIwXfj96+LMEtymY7a4RR+V8mCKEWap27xoccJRQSnnwPbxAdA4ItA1qUQKIvv2htpR36DcmKHJhYKyW9GJGj30+HOmjgG9f4JfOpDkvz0RO9ZfZSVXFs9nQoUYdJqov52NmBhxxIKle/iUwEtPgTuX8LuQnlKrpJVNp9nw62YPz0sRT77mWZVKhHVeZhUhXDKpYOEnCiljOK+JIJyyXAMpMS/xHV2234IDnPqlrF8jOVs1/zMwn2WJA2qZudTao8Jk1HhCvNYCL74zLuXKU0CFAjM9sZhjSaCdSPSkgdIR+NDY3GaU+R9PU+QvcAkllsPT32naMSgiZAeKm0fz3u+2Lo1xeUi7u2DeYYRctYXpPQt96bpeqLc11h9Mxx7HwkDuVXreC9vCw4vfgkPrC2ZiCaGxEgtjdYt9UtETvd4Gt2rybFx+IcfSVc2LVtj7hcxz+OqewWw2XXM9e5Vl5YVJZzTB1I77jyOXCKl2Rwwlt233SmMZQnj83dvROEl955u6afWM1aTssC03LDE/xbz2pMWUs9vyFJQNIwRZ1w4vWWAVay52utlfnZ3dwF4JblkuTxeVC7AYo5MjzgjZ0AWzkEg4PxDvF2OC1CNrxNfrxHy/58WFztvUms9FQ+t6jD9gpGX+oHbmaQe2mbPA8ZYFZRyhFKHRoo7N3mZkPrp5aF4rlp/s4szlEIt3WogeucRMgNeORzinLwvTAJIU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(4326008)(6916009)(54906003)(316002)(16576012)(70586007)(70206006)(478600001)(6666004)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(15650500001)(40480700001)(2906002)(7416002)(82740400003)(31696002)(86362001)(356005)(426003)(2616005)(336012)(107886003)(40460700003)(26005)(186003)(53546011)(36860700001)(16526019)(47076005)(83380400001)(7636003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 13:32:02.7521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa01709c-82ee-44b4-101d-08db40114b8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/23 18:27, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Apr 18, 2023 at 1:35 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> From: Sanjay Chandrashekara <sanjayc@nvidia.com>
>>
>> cpufreq_verify_current_freq checks if the frequency returned by
>> the hardware has a slight delta with the valid frequency value
>> last set and returns "policy->cur" if the delta is within "1 MHz".
>> In the comparison, "policy->cur" is in "kHz" but it's compared
>> against HZ_PER_MHZ. So, the comparison range becomes "1 GHz".
>> Fix this by comparing against KHZ_PER_MHZ instead of HZ_PER_MHZ.
>>
>> Fixes: f55ae08c8987 ("cpufreq: Avoid unnecessary frequency updates due to mismatch")
>> Signed-off-by: Sanjay Chandrashekara <sanjayc@nvidia.com>
>> [ sumit gupta: Commit message update ]
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 8b0509f89f1b..6b52ebe5a890 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1732,7 +1732,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>                   * MHz. In such cases it is better to avoid getting into
>>                   * unnecessary frequency updates.
>>                   */
>> -               if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
>> +               if (abs(policy->cur - new_freq) < KHZ_PER_MHZ)
>>                          return policy->cur;
>>
>>                  cpufreq_out_of_sync(policy, new_freq);
>> --
> 
> So this is a fix that can be applied separately from the rest of the
> series, isn't it?

Yes.

Thank you,
Sumit Gupta
