Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC468BE48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjBFNcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBFNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:32:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9F9241FB;
        Mon,  6 Feb 2023 05:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GraAhwT5GdQcKprV5C35BGuD92dWGg7ZtCFMIppsInW82VTeIlwBh8AP7+sPMNpyE0cEXAT+dq1qzXs25pA7+BIzrGaXZo2kzX4I+v4G1vvITXzYjwiFkZEPBP0/0zHfYjwjGyKlSle2SdnP6LhL/02XoHG95UcOBEcRzuOMgMezNZU3vke7v+Q0s0HmQt89y81uGTOdcnt/4p+zRWSWaEKQ6HEoSIW9LBNx3e8MEjj8bHgnN1Sxib3N8Et6s9SataOIPpHvBymjy2Ts5zdQNj/JDl+8Fq67sdzMAkvYCXqbkN9DYa/FDxiqqVMQ1ljSQaCV9+HEjLaUoN9H6Q95Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZcM9UGrCj/YIWCxng+TT0oKNs9iMrKiFx6nMOJhrNw=;
 b=ecnD9xFYU9n4PUUvacxgpGMZRu22N6fjdekGqaOamXsfbGNoZC8LKh0ak365IPb7ZHm4RrIupjpsaUAlheH2s1/DLirZr+LnI2eRwUm6v8dQkiUGHJzEbVCk3hdDlwiNiwLfHAgQ8NFDzciiaUs6+S53JjQav6rUkf+drDd3TBpFg1V0B1AVb9joU34qEpYHPUhxyi8H+3v4UN2Gz2UvV6gRr/WJs/ON90jSne819IOusIDbnr+zzjipHro5SbIQOob0v7XvNhnO2xN9fIQZLW6d99hHy962wmwWO4SARHMBN46xxJpULwn947XDJjVJQ086GAkmD0Xz6kPAKer+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZcM9UGrCj/YIWCxng+TT0oKNs9iMrKiFx6nMOJhrNw=;
 b=pufOCDLTlQhNJ7Q8yLjatI93ztClm1v0wiuZdPfd0AeoQH0oKRAyJ1TcYbCRUzx21zv+855L0h+OsEIFBZjqAt8cYG9Siq7Go+9Pps91AlNPFGlzVshSsG0o6/Sjb5CTczMQYgFrFLQc+EYPkMu2kKM/YhouSGqlXmi+KiNL2CWlnZ+n/DnQx4i6CCCKGWEN2uA9uwc+WFNPO+47CksGyVKRXd+VqQ3odhPaWGlD65wc681SircAmgnzyoJEjz7hjIj0BfmEWxh9CEapvi8c+Se3+pzdLZXKx0gpDQq+KM5CmddLbCfhFUi9+dRCH95/7CqscirDsrvxoBs5IduZPQ==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 13:32:06 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::cb) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 13:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32 via Frontend Transport; Mon, 6 Feb 2023 13:32:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 05:31:58 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 05:31:53 -0800
Message-ID: <b9408c8d-04bb-f108-0c3f-913fcc8de8d7@nvidia.com>
Date:   Mon, 6 Feb 2023 19:01:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set
 bandwidth
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Dmitry Osipenko <digetx@gmail.com>, <treding@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Rajkumar Kasirajan <rkasirajan@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-9-sumitg@nvidia.com>
 <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
 <8e6d7dd3-1bdc-ee4b-0c1e-1ae9cd8e4f29@nvidia.com>
 <8bd5cf36-e1fb-305c-08c5-3bbc80204866@collabora.com> <Y8kay0/AmjqhU2jO@orome>
 <65e596c9-a472-d0b8-ec2f-6935d647ddb2@collabora.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <65e596c9-a472-d0b8-ec2f-6935d647ddb2@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: fc27a1e4-5fd1-4321-a928-08db084689e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLEeMsXN4u72Zwk5y32P81NvReWUyu1EPcw0vxO4p0F4gXjbcP76ID9xFP0QN3cgqCtdYv/3hjaiPltLV88QqYUvEcc6KN7xyVlzeBtHiBsGQxUj3BpLh4vdvovd13uQ31fE4/bD1Wr7MIPgYG8vBI9fNJjQsLuwC4Z3dc8/Nrr+4G/eV9J1Z93BAKSCLDcE5w6zNvFv/W8EcSgZEy3VlPlM80RozGFDSyu6o40H+J1/8vd6EUXU4hda3ugVmZVdADP1vZgwMQNIbv38DaWGksuBd/ViTJpwkeza5VXvqriN2pZ7P+BEJOQ642oacGpnHOohGyas3jQdGVOGSwxgVR6hwc1lPO4fo+59rGk6ORkYHYAORmR8F54s/N+EMU5heVMt8JTPsyqW/fLZlU5NgrcuLXdB7bxv0rOIHOafOZssEt7KUB9PBl1+MINl3RX1zqLxugBhH+hI8X1XxwBgBGK5NHEhCjJkFuPaKHe3KB7sfPUNZmbR/FH05r36ZxZCw+VabUGgSqlm3TpVibk5q/MdIzKZDLfXiiDAYK7Ihh4X1dcjIeBJ1sOwhVWuHK8kpOT1nMhR/m6abwq/b7PvcwrV5BXu/JwxexnnXzwqy52il45HIgMtVEOxYfsjaO5h4ddV5uXhbBfLYn5uD9HtRB+uJmkvUkDcgTDx7/4+5451WHnm7VxZEUlpWJL7pFIZkO0mt4YIGTrHAObli210K3NR9Ttw4TIL5v4kXhWeo6WvYwGQv+/4B8dfjuqzv4SSvUdOZarTIb0Zxk0G0CoDGpO+7YCyvLnIFyPMpuat2FCSV8xcoiZq1rNI38xUhzNq
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(82310400005)(54906003)(40480700001)(53546011)(107886003)(2616005)(478600001)(966005)(70206006)(186003)(26005)(4326008)(8676002)(110136005)(70586007)(16526019)(316002)(7636003)(36756003)(86362001)(82740400003)(356005)(16576012)(31696002)(426003)(83380400001)(336012)(36860700001)(5660300002)(7416002)(41300700001)(8936002)(2906002)(47076005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:32:05.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc27a1e4-5fd1-4321-a928-08db084689e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/23 18:31, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 1/19/23 13:26, Thierry Reding wrote:
>> On Mon, Jan 16, 2023 at 03:16:48PM +0300, Dmitry Osipenko wrote:
>>> On 1/13/23 16:50, Sumit Gupta wrote:
>>>>
>>>>
>>>> On 22/12/22 21:16, Dmitry Osipenko wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> 20.12.2022 19:02, Sumit Gupta пишет:
>>>>>> Add support to use OPP table from DT in Tegra194 cpufreq driver.
>>>>>> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
>>>>>> Cross check the OPP's present in DT against the LUT from BPMP-FW
>>>>>> and enable only those DT OPP's which are present in LUT also.
>>>>>>
>>>>>> The OPP table in DT has CPU Frequency to bandwidth mapping where
>>>>>> the bandwidth value is per MC channel. DRAM bandwidth depends on the
>>>>>> number of MC channels which can vary as per the boot configuration.
>>>>>> This per channel bandwidth from OPP table will be later converted by
>>>>>> MC driver to final bandwidth value by multiplying with number of
>>>>>> channels before sending the request to BPMP-FW.
>>>>>>
>>>>>> If OPP table is not present in DT, then use the LUT from BPMP-FW directy
>>>>>> as the frequency table and not do the DRAM frequency scaling which is
>>>>>> same as the current behavior.
>>>>>>
>>>>>> Now, as the CPU Frequency table is being controlling through OPP table
>>>>>> in DT. Keeping fewer entries in the table will create less frequency
>>>>>> steps and scale fast to high frequencies if required.
>>>>>
>>>>> It's not exactly clear what you're doing here. Are you going to scale
>>>>> memory BW based on CPU freq? If yes, then this is wrong because CPU freq
>>>>> is independent from the memory subsystem.
>>>>>
>>>>> All Tegra30+ SoCs have ACTMON hardware unit that monitors CPU memory
>>>>> activity and CPU memory BW should be scaled based on CPU memory events
>>>>> counter. We have ACTMON devfreq driver for older SoCs. I have no clue
>>>>> how ACTMON can be accessed on T186+, perhaps there should be a BPMP FW
>>>>> API for that.
>>>>>
>>>>
>>>> Yes, scaling the memory BW based on CPU freq.
>>>> Referred below patch set for previous generation of Tegra Soc's which
>>>> you mentioned and tried to trace the history.
>>>>
>>>> https://patchwork.ozlabs.org/project/linux-tegra/patch/1418719298-25314-3-git-send-email-tomeu.vizoso@collabora.com/
>>>>
>>>> In new Tegra Soc's, actmon counter control and usage has been moved to
>>>> BPMP-FW where only 'MCALL' counter is used and 'MCCPU is not being used.
>>>> Using the actmon counter was a reactive way to scale the frequency which
>>>> is less effective due to averaging over a time period.
>>>> We are now using the proactive way where clients tell their bandwidth
>>>> needs to help achieve better performance.
>>>
>>> You don't know what bandwidth CPU needs, you trying to guess it.
>>>
>>> It should be a bad decision to use cpufreq for memory bandwidth scaling.
>>> You'll be wasting memory power 90% of time because cpufreq doesn't have
>>> relation to the DRAM, your heuristics will be wrong and won't do
>>> anything good compared to using ACTMON. The L2 CPU cache + memory
>>> prefetching hides memory from CPU. And cpufreq should be less reactive
>>> than ACTMON in general.
>>>
>>> Scaling memory freq based on cpufreq is what downstream NV kernel did
>>> 10+ years ago for the oldest Tegra generations. Today upstream has all
>>> the necessary infrastructure for doing memory bandwidth scaling properly
>>> and we even using h/w memory counters on T20. It's strange that you want
>>> to bring the downstream archaity to the modern upstream for the latest
>>> Tegra generations.
>>>
>>> If you can skip the BPMP-FW and use ACTMON directly from kernel, then
>>> that's what I suggest to do.
>>
>> After talking to a few people, it turns out that BPMP is already using
>> ACTMON internally to do the actual scaling of the EMC frequency (or the
>> CPUs contribution to that). So BPMP will use ACTMON counters to monitor
>> the effective memory load of the CPU and adjust the EMC frequency. The
>> bandwidth request that we generate from the cpufreq driver is more of a
>> guideline for the maximum bandwidth we might consume.
> 
> Our kernel ACTMON driver uses cpufreq for guiding the EMC freq. Driving
> EMC rate solely based on cpufreq would be a not good decision. So does
> it mean you're now going to extend the ACTMON driver with the BPMP support?
> 
> --
> Best regards,
> Dmitry
> 

As we are using the ACTMON in BPMP-FW now and there is no plan to move 
it back to kernel for future SoC's. The ACTMON kernel driver won't be 
used in T234 and later SoC's.
The current patches to scale DRAM_FREQ with CPU_FREQ is used in T234.
In future SoC's, we are planning to use a new solution for this in
BPMP-FW which will provide better metric in addition to ACTMON's for 
scaling DRAM FREQ for CPU Clusters.

Thanks,
Sumit
