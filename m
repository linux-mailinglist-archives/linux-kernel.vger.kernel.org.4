Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63575669B20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjAMO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAMO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:57:52 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E479748C;
        Fri, 13 Jan 2023 06:45:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHcY2kjcRud3KrfEAoIoL8tFaz3oadS2vZ2yoxEEL86EZx08gtsz61FgtesLbKUGpyhLEhAS+E+OYDWV1ZNn08FBVOE3X4D43Gz3ctDH38qDQpmVzjDHNEjUo4Ert/Tbs2L0/loGx00MPdaojqEdXCUPmBP9MgLNumSCYxoPly6HjokoYDqOwVyYVs/xKDA6TKmuoxcyiC0Dg6TfVNAqRlnuLQHJbg68aTGSbKf3H/R/Wj0qb7PwzGnkp5kPoHqRTP3AN8lMqGpNZGHHFGuNH8q6OzPw63Y4NqlfntuBlq1UH+JVLeA2WAov5IVgGl90yrDnNWnDL41Ed1xORW/zdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otvOgZoHbfEa2hMjxLRHjQCUE4W/uL/GAVYGgd8JQtM=;
 b=EHmwq44gv6n7MfjuXXCdPRwHX5QbVDTSXvCj+gJyCZkklTAMNHMLf7AsqzTNfyi97ZT+eNXCMsMkLdRQ9/gPomYusSer2CUMBSAniBhAuTh60Pu+6LauU/PsdMwlabXBUTLLb+U1opJOxk2M83jZnUHHJFRaqkEtJGfLqRKK8J8vhpeyGZMfVfUWWVyKwbI3xTaLBaF/x9K4MR4SjEMMJBHBXo/xtQUYNZ1gfqUcl98mUO588fTGW2RZEvFhYUvmsO3SPNx2lTkaBzm8QwGQ1nbQtRTVMY7xy4JKKkB0dz44eF370wuOX2q6KvBq23VL/4vW8c5cug2oK8JRT2ROag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otvOgZoHbfEa2hMjxLRHjQCUE4W/uL/GAVYGgd8JQtM=;
 b=iPD/RcKgsFAUxmY3FpfDvcKbNZymMSw7fFbI1jl07QlLJcBwdJzLOmaq8uNsXVncZ7ovxFxy9wmRso7PcuhE07QOdrJzmeTjSCXp5cJR0MFwIt0IX3DA3FKYRMfO3QlMsIhRViofzT0NTt+Rqb6AnLBp28eZl3jzKxS14JrE8hhvc/f6FAaS0CXGFpqu7/inD3CuulNQkbZjUDvqsYCHstt904sy1i0qnsIznpSVRmNaWY7py/MsUfKNJjyCYErYL4UErIUBRLlCc0P/zQTY2Te8Xyq5K5iXJRgpmMZnCOJ1yncqSBR+hkhk2NspLHaIkvGAvaZcrPxsgSxKUNu1Gg==
Received: from DM6PR06CA0077.namprd06.prod.outlook.com (2603:10b6:5:336::10)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 14:45:11 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::61) by DM6PR06CA0077.outlook.office365.com
 (2603:10b6:5:336::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 14:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 14:45:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 06:45:03 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 06:44:59 -0800
Message-ID: <4fd333a2-c0b2-301c-01ef-0c1629dcbfb3@nvidia.com>
Date:   Fri, 13 Jan 2023 20:14:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 05/10] dt-bindings: tegra: add icc ids for dummy MC
 clients
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
 <20221220160240.27494-6-sumitg@nvidia.com>
 <61ff6ca0-4e7e-1a88-05b0-dee462e7b098@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <61ff6ca0-4e7e-1a88-05b0-dee462e7b098@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaf144f-6383-49ea-e279-08daf574c635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eW6bD3B7rhHNjzuS4sdXaWDxbzpMgh3URqDlEdNnjR3n9NFC1Dl9on44KaWQ02AhYEqiYFPAdx0VSZ/Lc6oeLlpAnu1mzpJ8npqSYkXq6pLYgXnaPMG/DRwS3uMkSMaSNSykjGvebkKzYFdOYE+tKMHK3bsBKHXVf7QKpciFi3RkblZmc3WTnH0i5qy1D5y3SrS0CyTaBGPSTxIH1Ux+TMrB4d0fyawg/2R1fX2ouY06BCHqDljcLpW9hOFLnPH5rz1FW03reJ2L45b9xXTSr721IgngK9qso1L7kLZm2vEvYHhqq4NuroUpo3bU0+nuHOVQV6eEbDYOagZCrxZ7Jhf84Qkvpkh2cxOyA5lTFyNjQL9EGv/H86pZRsbBN82fUjzWM7iFqrY/Y/Ys+7mBieJvoivOlpv7n5dOwVCpvpg9IYfoGUSArBYx/c6iZf0TrlgqLHnO3OUX9s0e5wtFLKIsgEH5Qk466Hws0+bjHnCWTBO1UYqmirU4L069/A2WZA+oQ5rIJuZJ/ob3uSQxUQ4heSOvS9IRFHLq8FG+RdI8yPqTycI0yKvlWofqRfCwgbQeWDZEwwy0lsa5q6kLFh4K6CXBhMrjXaJVc14QnSorRF6pJmdS903gZd2WGl/XzkEMn20Exyqk6aJVuZjK488/RCFLo/rFovtwwAQklKtsLdSNlC9OvGj7/NHjqyxvKchqHgJjp0TxKChXZf0ShGKTa5pIWrdp/UeINsUlky7MHSWTwakRHD0S0tzgbgk5
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(6666004)(82310400005)(26005)(107886003)(186003)(16526019)(53546011)(478600001)(82740400003)(356005)(921005)(7636003)(31696002)(40460700003)(86362001)(40480700001)(2616005)(426003)(47076005)(36860700001)(336012)(8936002)(5660300002)(31686004)(2906002)(316002)(4326008)(70206006)(70586007)(16576012)(8676002)(110136005)(54906003)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:45:11.5371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaf144f-6383-49ea-e279-08daf574c635
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 16:59, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20/12/2022 17:02, Sumit Gupta wrote:
>> Adding ICC id's for dummy software clients representing CCPLEX clusters.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   include/dt-bindings/memory/tegra234-mc.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
>> index 347e55e89a2a..6e60d55491b3 100644
>> --- a/include/dt-bindings/memory/tegra234-mc.h
>> +++ b/include/dt-bindings/memory/tegra234-mc.h
>> @@ -536,4 +536,9 @@
>>   #define TEGRA234_MEMORY_CLIENT_NVJPG1SRD 0x123
>>   #define TEGRA234_MEMORY_CLIENT_NVJPG1SWR 0x124
>>
>> +/* ICC ID's for dummy MC clients used to represent CPU Clusters */
>> +#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
> 
> Why the IDs do not start from 0?
> 
> Best regards,
> Krzysztof
> 

MC client ID's are starting from zero. These ID's are used as 
"icc_node->id" while creating the icc_node. So, can't use the duplicate 
numbers.

  $ grep TEGRA234_MEMORY_ "include/dt-bindings/memory/tegra234- mc.h"
  #define TEGRA234_MEMORY_CLIENT_PTCR 0x00
  #define TEGRA234_MEMORY_CLIENT_MIU7R 0x01
  #define TEGRA234_MEMORY_CLIENT_MIU7W 0x02
  #define TEGRA234_MEMORY_CLIENT_MIU8R 0x03
  ....

Dummy ID's which are already being used are starting from '1000'. So, 
added to that number as the ID's used for creating "icc_node" for CPU 
clusters are also dummy and they are not part of HW MC client's list.

  $ grep "100[0-9]" ./drivers/memory/tegra/mc.h
  #define TEGRA_ICC_MC            1000
  #define TEGRA_ICC_EMC           1001
  #define TEGRA_ICC_EMEM          1002



