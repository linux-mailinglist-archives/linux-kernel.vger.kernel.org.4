Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7266DE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjAQNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbjAQNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:04:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BB30EB2;
        Tue, 17 Jan 2023 05:04:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhRb9zRxxMxrHIKl8h6kbthNeVQY0VR5fhPjYrTZlLgNxA4Jy9HTTa22FINDP+8teCn3FGQBRkLGMltlCN/2Ve/jXI1KKteQOWH5H9S0kEaSyPFy/yJOMZW9MkJxOycyeESyw7aUWMbB6RG9zhhTuMM6Ro5TL984K+JXqckFmQis2KovkhUq046YOnqJ4Y0XZsecivzN4laATx+i9jlsP03hymqxAeYpYkEOrYrdcyeWsHRlRK6MJuFdwPaq7Sfr6/rvec55nA9byOZ8TwicqviHoMo2LZa0HtbHl+kFDhpLGoZdP7Yl1SwvyY6SF83EMezRCCdFPOh+J+FRwA1/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Tb2rj8ATSr20Iy615KcmAnCYkh39k/9f0jxTvQmznI=;
 b=csrEcZ+0Il+SkPr77BLmIXLCr58IFs82Ez8V1AF/6grYh4OQrXma5qrlCsxIWvUZzpxP+d0Zv+k/AkQG1JbwiFC2nbXNyOJf0G5O5V7JHCFrIckL9X+qXabmwqXEdQVzCijAikgFk/oagjF9YqnZgzWsPxGq7EmCkqADGaf0Zey8RgqUaOjuTLfkV4PzgbWexXMblji93YqMTyu39gHV/D9/914W2V2IPN229lpsO9I3RVC8a4eTU5IARv4sV+5qkmYkhslx0HPwRmTzl0Wf8qBto0YfG9qpG0KkoyOK50oZhufBMBD02Ucwr7ygqCVUjz1jXjWwTPuOowdGqJKjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tb2rj8ATSr20Iy615KcmAnCYkh39k/9f0jxTvQmznI=;
 b=XB6yMotCBRpJW71OP8SPeos4VfsMISo7L5Xo3qIWF5c3bjzTNcGQTNTeyhPmlUdZ3d/Vu/DTGER2w6bYUZ7RTmVXz6m3UpbX6N0FzroNr3X6H5N9IT3R/qdilVm8aie1RhTiiIa8iRNs+r6jJadtcnwOuwBTqpZDv9LLMbRLpBzvd8HbT7gCTx/OW+MKaCKoWuYgJL9RRv/wmVZneNKGSq6gexWtGFBn5SOO+sVUk2pfING5hDpGHGlic84q+BvAKS1EUCyjXv9OVd2wINL/U2t/VAGyiN6jLWdjnQyZaTs+DLsmv56JcQmEvGkLnapMcFcOTC3hEuU4HSOG7x2/hw==
Received: from CY5PR19CA0063.namprd19.prod.outlook.com (2603:10b6:930:69::6)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:04:19 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::4a) by CY5PR19CA0063.outlook.office365.com
 (2603:10b6:930:69::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Tue, 17 Jan 2023 13:04:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 05:04:00 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 05:03:56 -0800
Message-ID: <6f4dc52f-934e-283f-ac0d-917794c896a8@nvidia.com>
Date:   Tue, 17 Jan 2023 18:33:53 +0530
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
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <f4e05666-d094-18cf-2641-ebf92da85dc8@gmail.com>
 <221c1bab-8f4d-9dbb-bb12-4f7ab5dc5d90@nvidia.com>
 <98b5a73d-be59-457f-e7ce-71cfbbdd025f@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <98b5a73d-be59-457f-e7ce-71cfbbdd025f@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9696b56a-6bad-47b6-ced6-08daf88b580d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArPgJh/s/mNXAYqkmaqmGqUI0rDTXXvPhC8J+HmWjseX2IrIG/wxLOfhF59enqYdezSejCekd8MV4PM/liKH6iuboHkcfLAvFiWT+B/Fjc/Ab9+nVoCOW3TpceN85i1G2q+U2UvvcBDSaYG0XpxVEp+SRkJoK10j5CQulC7AEhcAV5dU4KBoTbRCp9//IQVKEsFSyMzF0psqC5pSbs+gT7b58s0osN1FxitDtc9vgXdYVBgp3rTITiOMySzIhAKt/7JDTaENywfC7repIFYsmHgkPlOVETfw0iYaqR+vpkMxqa6a80IK/DQN/LBA0qYXlbG60mHc8g+n8gQhuqp9y0sqDtFPpccSHeSnmUpWQmb9z6EPSDDHW8qyir8pZcO55N+AGcam93SMriYtnB9QM3t4koIa6/Un6JvOSD/NtnSpHYZHITDa8mpM22P3HL7V3Jt901PQ56RXW8of/fUiarhtrtJ9PxW3MivaTUtDR8w1W99jgY82adcuZCuLaFoFWFZ3Tl/psHJXn7mup7N+BLolmdqeIWDwwYiM59RxWJFqqa4Klp4sCxXtjoYq0mL/ltP5guVUtQxqFE2h/72op24KuDLSVirqQtPKld0D9kZZBrRTTEXkxltIY0IP2vPHhnD8MwRLyaFeE7R/zsNELfG/Rh0DgeltlXgOAQJO+P8D5Xcy8s2Wr9b1QFxelg+UTAZ8rgTZmRG0X3RPT4dv+Fs4g9cuFyDAPIhtnQto3ICt3GX7Z4PxIAWke1esGjIt
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(40460700003)(921005)(40480700001)(82740400003)(7636003)(356005)(82310400005)(86362001)(16526019)(26005)(186003)(478600001)(36756003)(31696002)(2616005)(336012)(110136005)(70586007)(316002)(16576012)(31686004)(70206006)(54906003)(53546011)(7416002)(5660300002)(36860700001)(2906002)(41300700001)(426003)(6666004)(107886003)(47076005)(8676002)(4326008)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:04:18.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9696b56a-6bad-47b6-ced6-08daf88b580d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/22 22:14, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 21.12.2022 11:05, Sumit Gupta пишет:
>> On 20/12/22 23:37, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 20.12.2022 19:02, Sumit Gupta пишет:
>>>> +#ifndef MEMORY_TEGRA_ICC_H
>>>> +#define MEMORY_TEGRA_ICC_H
>>>> +
>>>> +enum tegra_icc_client_type {
>>>> +     TEGRA_ICC_NONE,
>>>> +     TEGRA_ICC_NISO,
>>>> +     TEGRA_ICC_ISO_DISPLAY,
>>>> +     TEGRA_ICC_ISO_VI,
>>>> +     TEGRA_ICC_ISO_AUDIO,
>>>> +     TEGRA_ICC_ISO_VIFAL,
>>>> +};
>>>
>>> You using only TEGRA_ICC_NISO and !TEGRA_ICC_NISO in the code.
>>>
>>> include/soc/tegra/mc.h defines TAG_DEFAULT/ISO, please drop all these
>>> duplicated and unused "types" unless there is a good reason to keep them
>>>
>>
>> These type are used while defining clients in "tegra234_mc_clients[]"
>> and its passed to BPMP-FW which has handling for each client type.
> 
> The type should be based on the ICC tag, IMO. AFAICS, type isn't fixed
> in FW and you can set both ISO and NISO BW, hence it's up to a device
> driver to select the appropriate tag.
> 

Type for a MC client is fixed. So, adding the tag and giving option to 
client driver won't have impact.
Also, we need to pass the type to BPMP from bw set api. But the tag info 
is available to aggregate api and not set.
