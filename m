Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFB26696D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjAMMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjAMMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:21:48 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37462D0;
        Fri, 13 Jan 2023 04:15:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3KScSNYuc7lOTJwpvaGyR/XbdVSwyzaximcbiHQ8IV7WIvxln0PniJZN83Jz/P5TKITsUfd07lJUfVV2vsghQG7s7sfADmYiShXSb6xDFtcVyyEVoa2EVcrZYyJ+mWLEGXOBjTwmkbybXelce8FHgC/CFs0s0sdJyWD0B0Dapzvk2DQcfT8KfgDsrvBmreKu0TaxBTicuD9L2+YxFz/MKUropX1mpSfz6zoPxBeN8g9y/djVCijeyDDiry1c22IM9iUvWqkyt7F3EVxwvbdOp2jkXBoJC7+4BNA9sZCXaOk+Z8b9lF5ioQIppB/1H4ElkxqamzuFO7MHlBjZ9keLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO2SLqaVsh23fZ4lVrjpDK4kNpIoi0H0Sr0D0GieLs8=;
 b=GIWQeDzi1caSne+eRb65Re2mZf+b+1SMpHxPIJI/8MYr/hBU+WPMaQWydljPT9PJRHp+9TeqxmBoA0d7pQSl/j38Cw+WdWKDf637v4bdXi6PdDfbTLP5pZK0Mvg44AHd0mbWWs3Kf9lPEXwb9YcniAHcU6My7wZpYjd8c2k7shClIcQCH6N+Ps+LKtGpCkpDDFaDNIIPANd4yC1fykhAQo3WmPxcB+AfQUBMze7fAvG+M+MRrd9ouNySsutS/72p02O9cSAGdR1GpJCNNaf/vjxwWMhn889Ol28onw9BPedeRdIAQooRrPxW13xvsFMq7EnRDKYzm2IM132+fDgYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO2SLqaVsh23fZ4lVrjpDK4kNpIoi0H0Sr0D0GieLs8=;
 b=pDuU+QI327ybGvhrkij6xTqaTaxJmvKamrB/pGb91gnl99WnWcyHl0tWyvGN5XzXHxVXLFeOsHl7Q5xzV1IQDDEW6cJZ/xoMTbViE1KUDa4GzQurgicPusJJaekOt7421m96Ip9Cs22r5+3N/Nfg7uJWOvlvoFY9Q3wr5Z8SOxeXvI2T5Lx6aNh1kU6YoWk8/W9AhwUkZ9ad6R20Pw5BWKPx6hKHxBm8GIUTjQl0FRnixCcEDCtyYhtij4TA5AapqV8dT4WehvcW9D9U3mH3Az3Jx5B+0aCR1VZWIY97WFFBLXflo4k5zEaFnFDvooWIBMXWphhpIgc7O+DTr116IA==
Received: from DM6PR02CA0117.namprd02.prod.outlook.com (2603:10b6:5:1b4::19)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 13 Jan
 2023 12:15:57 +0000
Received: from DS1PEPF0000E645.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::4d) by DM6PR02CA0117.outlook.office365.com
 (2603:10b6:5:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 12:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E645.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Fri, 13 Jan 2023 12:15:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:15:51 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:15:46 -0800
Message-ID: <a8134495-c8bf-8824-5fc4-9685a5c11640@nvidia.com>
Date:   Fri, 13 Jan 2023 17:45:44 +0530
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
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <4d562b75-854d-1997-8969-e7ef222e4e37@gmail.com>
 <298fcaca-c708-5d68-95d6-51673f7a2174@nvidia.com>
 <d2c4c6fc-c432-d122-1e90-3e3ef96eed72@gmail.com>
CC:     Sanjay Chandrashekara <sanjayc@nvidia.com>,
        Krishna Sitaraman <ksitaraman@nvidia.com>,
        Ishan Shah <ishah@nvidia.com>, Bibek Basu <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <d2c4c6fc-c432-d122-1e90-3e3ef96eed72@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E645:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb09693-595c-449b-9fa6-08daf55fed38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8c+lmvsTj55MNAg0fgR7mAASk2ZBowQNuK20VczB9RJX2egwgQRjBW7cipkMNFPdM092RGl+tIs/QBsjCmbQD2IUJ0VfKcS5z7X3i455PuoRL1dZcMOSGvJaLotKUM+CynhMUdzWm8fe5ulP5mMl/dO1CrmOVzyIPI5/ONa7M6GMqkB3cOp9PU3A6uW4HGIInfxEqRW7JiDwvn3BKn6tPJEGgKMQ8Lu5rdFNo3IRaHP8HnxgMUOL6lOPKgcZ+4Q7RJGp6bQfiFUaCH2h2qLm9UKXiEqo4zA1vE6MThaIQ3nDxLmh4GqvawAEIqm0pMOqfmW9yAgkznpeUQLESFv6lKzXEayoXwT/6WH7AFa5kE0JCDjeT6YqZ5CtcCLpPxhBAKE3x60O1fY3MgsPMSl7SWzeioP6UUsUp371wyWJukI/D58w39KHK3X/lleZAywijEp9Btdoas8nGrDo9b9j2gDCaHhvAxWYZdxb3PoVy4RjH1bmrKAyxI8692cgTjJqLQjhlr2O9V1CnjoXftBViQAa1cPGpdzhsT6A2p+hT5wQzk+m1IcW7cdM/bsUp/qDLI2cRcd2StnFdenNBGp7Jw8sUxt+lIqzlkvfCS0dg6C7WHvBw2pUZWGI+FRlVSiJG0a5B8lIfGWTTZojO87ygwUaSRvYyBk+c5k5Su7Ig+F2q2h6e6K8fjqRzaT6q60kX8QEouE6hCLIWvju2RdDzzfPwwildYGqxz3OPwRrfcgWIBcEp5kkvuMMhbtxuj0QZvz3qMEuIpHPGRNiZ8rYQupGkafl6uwl+1WnIXhgzoQqNcJYj38kq1xeLb0juEyS6rEkf/PYi5HYhemu+s99gh3lvl4CkG5+eDLpFhJ9Q4oj3+KO8XB0XRn7OSq1huI
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(36756003)(31696002)(41300700001)(2616005)(26005)(186003)(8676002)(16526019)(53546011)(4326008)(47076005)(70586007)(336012)(426003)(70206006)(966005)(316002)(16576012)(54906003)(478600001)(107886003)(7416002)(110136005)(356005)(921005)(7636003)(40460700003)(82740400003)(2906002)(83380400001)(36860700001)(5660300002)(8936002)(40480700001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 12:15:57.5393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb09693-595c-449b-9fa6-08daf55fed38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E645.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/22 22:13, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 21.12.2022 12:35, Sumit Gupta пишет:
>>
>>
>> On 20/12/22 23:40, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 20.12.2022 19:02, Sumit Gupta пишет:
>>>> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32
>>>> *avg, u32 *peak)
>>>> +{
>>>> +     *avg = 0;
>>>> +     *peak = 0;
>>>> +
>>>> +     return 0;
>>>> +}
>>>
>>> Looks wrong, you should add ICC support to all the drivers first and
>>> only then enable ICC. I think you added this init_bw() to work around
>>> the fact that ICC isn't supported by T234 drivers.
>>
>> If get_bw hook is not added then max freq is set due to 'INT_MAX' below.
>>
>>   void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>>   {
>>     ....
>>     /* get the initial bandwidth values and sync them with hardware */
>>     if (provider->get_bw) {
>>           provider->get_bw(node, &node->init_avg, &node->init_peak);
>>     } else {
>>           node->init_avg = INT_MAX;
>>           node->init_peak = INT_MAX;
>>   }
>>
>> So, will have to add the empty functions at least.
>>
>>   static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg,
>> u32 *peak)
>>   {
>> -       *avg = 0;
>> -       *peak = 0;
>> -
>>          return 0;
>>   }
>>
>> Support to all the client drivers can't be added at once as there are
>> many drivers all with different requirements and handling. This patch
>> series is the beginning to add the basic interconnect support in new
>> Tegra SoC's. Support for more clients will be added later one by one or
>> in batch.
> 
> This means that bandwidth management isn't working properly. You should
> leave the freq to INT_MAX and fix the missing integer overflows in the
> code if any, or read out the BW from FW.
> 
> Once you'll enable ICC for all drivers, it will start working.
> 

Referred the below patches and now understand what you mean.
 
https://patchwork.kernel.org/project/linux-arm-msm/cover/20200825170152.6434-1-georgi.djakov@linaro.org/
  https://lore.kernel.org/all/20210912183009.6400-1-digetx@gmail.com/

There is no MRQ currently in BPMP-FW to get the bandwidth for a client.
So, can't add that in get_bw(). As explained earlier, we are in process 
adding of adding support for all clients but that may take some time. We 
can remove the get_bw() calls initializing "*bw = 0" once we have the 
support added in all clients. Noticed that below drivers also do same.

  $ grep -rB3 "*peak = 0" drivers/interconnect/*
  drivers/interconnect/imx/imx.c-static int imx_icc_get_bw(struct 
icc_node *node, u32 *avg, u32 *peak)
  drivers/interconnect/imx/imx.c-{
  drivers/interconnect/imx/imx.c- *avg = 0;
  drivers/interconnect/imx/imx.c: *peak = 0;
  --
  drivers/interconnect/qcom/msm8974.c-static int msm8974_get_bw(struct 
icc_node *node, u32 *avg, u32 *peak)
  drivers/interconnect/qcom/msm8974.c-{
  drivers/interconnect/qcom/msm8974.c-    *avg = 0;
  drivers/interconnect/qcom/msm8974.c:    *peak = 0;
