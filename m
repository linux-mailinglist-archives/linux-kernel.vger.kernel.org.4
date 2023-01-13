Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF666992E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAMNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbjAMNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:53:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED510FDF;
        Fri, 13 Jan 2023 05:51:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuMKyVMxn86jwo2PcYfJ7PpLC1UCrJtqeKY3+4W1wRbgcm6C2j47w/I4JmQEbah19cXDUpL96ODYU5At+21Xx4yEGveb94uxLWFvPE/YCE/mwAFTEue6e3rn+rNzvTshTw3LLlCTb8pDRkvROeJ5861jTqrjKewpG9MmSath/GShMujPfZBbPxTDmoh/3+csJO9HFSJvgEEdTP6JxgB8gKsRO18IblmRD5sKvE/jd+95Ie+OqdJE5TA9RiNzYmQv8pZpBFm8cDb28GhkkV00mUj65xWA5Eh0Qn6sF8WzPvSfLBdtLqshStat3EEwbc7YryTR7nPnQdkSwRrJyy5+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whdklx2dLe8lOr40B674jgnQbLrq9TvhbZRAe/Z1fL8=;
 b=E0LsQH0ojBZALvWhyZHXc08rTtwNlbnmqXrG34vlns+UjY/QkfexVoUE2619RSFJhW+dXENl3I6+YVTtQR3aivqOjlE6E1qawnBtJEliygs5yanCdvSFWli/LD9Y+B3EQtZ1xd/2fuPpO5IdLLmeGWgJLYHVorRcV7DbvYLwou3P4O2XLr8OQVCEGA6VTyCjNzODUkgCzbFVvBind91uCTK+Wlu65VNE11rUeIqP9Knav7Drn9FuYeGMpZxnQGtmuRCf0J5sVx4YAnk0u737Rnc+BiPd1ZhsIgEOJ7kLLenyY0ORTS1oPgezd+GXL6bq+spnGE2cGdkQbWw8jIKMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whdklx2dLe8lOr40B674jgnQbLrq9TvhbZRAe/Z1fL8=;
 b=M8ENaMW5WWQkDMzs9w/YlEgW5Hqr+kX1TizL/bnNkZn+Oc8h7S+40QGrWqXovttYGUOhk+/A8LNekjkwj5rG1K7Fc6FfUquTX1aGqecrSiWCxK+3cnO+Rt5POzJBbETgkxSHXLFVRbXXjecANla1rZw/SiBZgxvLf1F+t4sV1br26GD/NoJ8StSlE9wXAgatUtmCABV74KrEE7uCOMeIagpWdQjcb1C0elaEodI9vzNSxM0F8CtFncipAa9/k937NlDKPCCJ+x1IBq1dvzS42pPDgekNmJEeFjnojx662mxQs0cK8cigcXVpWiT/CDZ6OeslDoaJmfzzMbDmWI1hdw==
Received: from BN8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:ac::42)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 13:51:15 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::13) by BN8PR07CA0029.outlook.office365.com
 (2603:10b6:408:ac::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 13:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 13:51:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:50:48 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:50:43 -0800
Message-ID: <8e6d7dd3-1bdc-ee4b-0c1e-1ae9cd8e4f29@nvidia.com>
Date:   Fri, 13 Jan 2023 19:20:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set
 bandwidth
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <treding@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        Rajkumar Kasirajan <rkasirajan@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-9-sumitg@nvidia.com>
 <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9bd4bc-63cb-43b6-ac0b-08daf56d3cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU56m77Y4qxU45SZbRtWeB5nD3+GkJgBqbaXJTKD1pFf0NLPdU8Vm/w/ukjAkyJSj9d+rcWGHv/ym0P5jQfAFWotLRdsrNUG0EzLFx0ihYyPan5qYp+1+f2QDWZIzfHevpMOQXIMWT+73D5mqeeICAhFPUad4EuQ5akhpsX0cLgE7F8OjPZp39iuvX2qe0afmPpt99I12jCa1nifUa+W40FW5N9B1k4VvP+fqNukuRRsSn/KCSYayb7/m00sTtwTmhWKRP/w1whp+0CloNLO/oMd1WIVxsB+mxBTRJEcfE77JkXO9gPPbaoK9vFoGBMwMsyivZEXoaTbv7p2FV5vUqcRXPEmLwN5wqMDZYbhF1Tz1xekDikm+pLhshVqpEICLgdBxRym6jgYma39J8z50dUR+Oq+3OSqdEp5zFXgMdn2vC0S/AMUpNpxrxk7osTCbDO0YYzhwVpY/MDIbu+CWpQLX0DQXl5uRxE5mTGSjDy7hYCcNG/vUUvNo9McBSzXrRA9X3VaaLvg89/vRrPYP2kZKY5tWKDWPSZLx8fnb5m4urv4ebHX/jyzOxOYVdnJ8NXrb0NsDH0o0/feVaS50Ldeo1zuwZicv7A4qOh9KVp4dfnczrka1X2Mo8+wviTeQe0WIPKMEhcGaa2e0Ak8aDwjGiCFDpSSjuNpq9vqpccuHdDvgoidF4kAz/+aYaJi5+0oy6w7x2RfoxKtVngBOWBStV5a6XlGAm9grqjTDpy58baAHFIyLM3FKbq8Sftm5WQunIPyAR35t135zR950JhKt7PaLOvtSCA4prx94S+z9zMvFoSA+IZQmrE41WoCeyzU5dknMW0Cq5ejrVIsrQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(47076005)(8936002)(82740400003)(26005)(2906002)(5660300002)(41300700001)(7636003)(7416002)(426003)(16576012)(921005)(4326008)(316002)(8676002)(70586007)(110136005)(356005)(54906003)(70206006)(16526019)(2616005)(40480700001)(336012)(31686004)(86362001)(40460700003)(186003)(107886003)(966005)(31696002)(36756003)(83380400001)(36860700001)(53546011)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:51:14.7289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9bd4bc-63cb-43b6-ac0b-08daf56d3cf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 21:16, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> Add support to use OPP table from DT in Tegra194 cpufreq driver.
>> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
>> Cross check the OPP's present in DT against the LUT from BPMP-FW
>> and enable only those DT OPP's which are present in LUT also.
>>
>> The OPP table in DT has CPU Frequency to bandwidth mapping where
>> the bandwidth value is per MC channel. DRAM bandwidth depends on the
>> number of MC channels which can vary as per the boot configuration.
>> This per channel bandwidth from OPP table will be later converted by
>> MC driver to final bandwidth value by multiplying with number of
>> channels before sending the request to BPMP-FW.
>>
>> If OPP table is not present in DT, then use the LUT from BPMP-FW directy
>> as the frequency table and not do the DRAM frequency scaling which is
>> same as the current behavior.
>>
>> Now, as the CPU Frequency table is being controlling through OPP table
>> in DT. Keeping fewer entries in the table will create less frequency
>> steps and scale fast to high frequencies if required.
> 
> It's not exactly clear what you're doing here. Are you going to scale
> memory BW based on CPU freq? If yes, then this is wrong because CPU freq
> is independent from the memory subsystem.
> 
> All Tegra30+ SoCs have ACTMON hardware unit that monitors CPU memory
> activity and CPU memory BW should be scaled based on CPU memory events
> counter. We have ACTMON devfreq driver for older SoCs. I have no clue
> how ACTMON can be accessed on T186+, perhaps there should be a BPMP FW
> API for that.
> 

Yes, scaling the memory BW based on CPU freq.
Referred below patch set for previous generation of Tegra Soc's which 
you mentioned and tried to trace the history.
 
https://patchwork.ozlabs.org/project/linux-tegra/patch/1418719298-25314-3-git-send-email-tomeu.vizoso@collabora.com/

In new Tegra Soc's, actmon counter control and usage has been moved to 
BPMP-FW where only 'MCALL' counter is used and 'MCCPU is not being used.
Using the actmon counter was a reactive way to scale the frequency which 
is less effective due to averaging over a time period.
We are now using the proactive way where clients tell their bandwidth
needs to help achieve better performance.
