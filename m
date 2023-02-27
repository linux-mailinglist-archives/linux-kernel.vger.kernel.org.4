Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E66A460C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjB0P2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0P2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:15 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921083DD;
        Mon, 27 Feb 2023 07:28:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXhjSnEYesvsi1v7QxHjwP/NKnsxND74xLw13Dx1XLhCDGmSRk9Gv4aeZuFZjTi0LlbStLWoq8HmBmW+DeXi53f0TjQlyXIplCyS98ArnnixSGJL18w6x6E8J36bDhuppZmcsWQ9Jiv+UlYqFVsqlyUBuiI3c0d9YuOjOxkBD/Z8Gky5zXNir7rF4TX/RVv7br1/Tk1iLpguxuTn92O50b7odXbeWp5zDFnfZlNiFls90PNKg19rWaVhBeAKsT+gfLrhdssjeYvPElVyc/fNPOrX3XUxmRjwemZTsRf+n5qUOl5w1dbbDs/qhL0VodFGWUOX9+G+GtPJSoWe0+jP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwzLqtGz8HwN/MdKeuKhconaJS3a+YckEG1MN8XUdhg=;
 b=oAvCfXnpkv4gKiNt6uLDBuMnKYaR6EIK2r5JGKj2hnohs8hZAWKBpvl3o0bFXiBC6istXeOt0/tFrBS5BofAQQm7k7QD1Sdwj3FAwvLgJFWj4IW7qGasZHKz8H7T3hZaodhxfnbrVbqFOOrURkJef5fbbeYkKKqRNqbF2w6TWPPCKkfgwHG1Oh86R6m8L9Wz/+XLHh8q68FjPxEs6CISw82Cxdz1EOxHwkxYmty7HU4UwDD2xrFLaIWijqyxUr0mVCiA+7f322cflm8u1MR532lJQphmPjCvLJi4ueh/GLjLxm+ihibGgRa+UjrFB+P4DU1KWOZkTqRHXawMjGVbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwzLqtGz8HwN/MdKeuKhconaJS3a+YckEG1MN8XUdhg=;
 b=Ge0vR5aWX5wehKyHko3BfHWozgexy8I/K1IFXvjpxA7R/l27I1wBs5kXitiAuZS9pqMZD5q2rM1ScF0J3Jr+2d0uFDZzX2VYj0256lIdbgLCNjgccenHGVDjsxhLTdLbIKzk6e1VY2n6HaG9/5LS83cNRwIDbPvx/3JZ8z6spIk=
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 15:28:10 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::54) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 15:28:09 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:28:05 -0600
Message-ID: <da678b73-c04c-2c14-87ae-5741b5999e28@amd.com>
Date:   Mon, 27 Feb 2023 16:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
Content-Language: en-US
To:     Tanmay Shah <tanmays@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
CC:     <andersson@kernel.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-2-tanmay.shah@amd.com> <20230222173448.GA909075@p14s>
 <b11cd9f2-3759-1df2-ea00-50c574668c28@amd.com>
 <130e75d3-034e-67a2-0c27-0599a996b20f@amd.com>
 <e2ef52ba-7633-3958-4b40-e047a7bba820@amd.com>
 <c89715cc-2c45-d921-9837-b0a59469d233@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <c89715cc-2c45-d921-9837-b0a59469d233@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cab382-9339-4a30-dbd0-08db18d73b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dkn+mgAuhEMTgXaBvq9k6Vmw5yM/Y5tkfzPls+imJOxbli1o+61++Nf6m2kWOiac34YLv6hHx7TuCLhg6Uv4mf/NEa2LBGBqVF5wVMM15gnzvONmtlFTUn87BsBjFhIfxRzljGOb8M1cVFgTq7RRu5LygdJPXjIufENpBmRVYtnDsn57kJLaL8jrQ6IUU5nrox2DxC0axBv8hdm2w2hHX8GekDWKtnPFpFGqlSiDgbY3rJmFrzcpQswSScie9JFANoQby6u1uo6bLvYSfdDfsl+V5Nve3muyzl9maYZnVTrk60G+BpDuQO14hqvVAuacDSuCmf6dWHPy7iYZ/ALtmx154ZTWEJWHfS6SWKsBJZhZzbxwqbIkPu0LYqS0SRX3invdMnJtMp/eLIls+92HpeP+sgM1T5bOQd4L/r6oZYlVrve8Xb64V9jnbpJ6NRFgB0GMFwcTYFY1bUpyKViUeJC1LEvrVZdvHSWi7OnDnT+QRJAbaWvVIHS63XNZ9AV99tAv368YTOOTGrH2FChzjS2PaYss2oEp15GXNz5h5eqbEhQ4Ssirq5/gHB9MiXAFit1DR2valdT/eASUUwr4Xy6a2sL/xv908EqewFdC71UAqMYe0N5+9SBjMQgSuM4FnXKKKoK5zfMQEtJl/gBogMYX2v27tc0vCrSfpg7s2cVZD3A+wv1ROhb/ew9k+2qGIMO78Rq23ICEvw5uWZUR+dmYj1YMp47VCln2TKaKVytt1w26CROpyIevG6fGdFLCXufSEiyC35wpVUacLWtwZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(4744005)(8936002)(5660300002)(31686004)(44832011)(8676002)(70206006)(70586007)(4326008)(15650500001)(2906002)(316002)(54906003)(16576012)(6636002)(478600001)(110136005)(41300700001)(36860700001)(47076005)(426003)(16526019)(53546011)(186003)(26005)(2616005)(336012)(40480700001)(82740400003)(86362001)(81166007)(36756003)(82310400005)(356005)(83380400001)(40460700003)(31696002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:28:09.7873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cab382-9339-4a30-dbd0-08db18d73b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 16:25, Tanmay Shah wrote:
> Thanks Michal for this calculation.
> 
> I will send separate patch after some more analysis to accommodate this 
> implementation of accessing message buffers from ipi-id.

thx.

> 
> However, for this series this isn't required. For this series, I will just split 
> this patch into three different patches. I hope it's okay.

yes that's fine.

M
