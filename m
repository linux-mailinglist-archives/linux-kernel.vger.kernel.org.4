Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2206A44AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjB0OiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjB0OiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:38:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792961BE;
        Mon, 27 Feb 2023 06:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPByUsdmGj6MOhXk9e35akPdOEhMYcvBbeQ0A62JMQBTAk363RiCYh7g6fkFEWpIDeqtmHEjDIKrOTzaOQuK+KUYXBx1gWX0U8WMDuIK5dvfK5I+TR2Cx8i7BFT+rBo5E/mKsorKrU8ZIrHwARvY+xdmdiHiruCB5kcyHu7ul4I2Maoin3cZ/KWVZDeCjS5zJAkUoxsbUJtuyf/ex5lkeUW984ML4/ZRLo/1QfJAq0xuS/+vNeFnhytLPCfygftOBxIPgfqz9rFnM3+l3WWi/iKBgWftv4N15B2s6BX2MZ9ijaEd44EQ4zcdACWP3nSwbYCQ0u64wImQCM10I68TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dG1dUqhRZr/AfxEjuULFBBCHcpe2VVE2H5k4iqCJmM=;
 b=goInBmK0FYXj34y90wqRZCEZOW7dEHwe2zI9FI+Gy2nXZjjXVAOrTfnmR+hfIOCgXo8tjIGFLUsdmWw2wHTeA6UxJjII5SCEm8jYnuIuobKlMpzwUA5Slf1c7zaR8eGjYIzVOXJmUMUazYowm4XV09v4q69sRecVf+7RTOJiHPgyGx/0EM8nGsTUnmzP2ozgHayH7xESHkIkurubQseY1+6NpxUHd5PT6NO3q0/Q8kcOUYUdg1FysGF0OIYOrtxPvkME4PhhOEzkXSdIu/sFeZTrZdLDlZL7+z7ncnyy3WU3dfPCW1tLSsst5ZH+JJ0vFcz1lBmhx00ETUy6ObYunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nfschina.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dG1dUqhRZr/AfxEjuULFBBCHcpe2VVE2H5k4iqCJmM=;
 b=VpDEEhT3h4fbi0ezguPV3AJBXG7f9YE2XRcxqdiMUms1xiLyCV19kiSFKr+iIwHTGENtFCjigPla4548LwPxNCjy30iciE/VuLgXQj7eEgRKLGkJ3PM+XsHpAjMcm/RSPNYbj6R80UrBMhCRBMvmRDfMKFpi/mcg52lFumQOLJk=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Mon, 27 Feb 2023 14:38:06 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::56) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 14:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 14:38:06 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 08:38:03 -0600
Message-ID: <1dcfd6e7-fd9d-d091-0eee-87fa71218396@amd.com>
Date:   Mon, 27 Feb 2023 15:38:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] zynq: clkc: Add kmalloc allocation flag
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <mturquette@baylibre.com>
References: <1e05156120fdfd79ed267f44fe7f3491.sboyd@kernel.org>
 <20230223183312.2759-1-zeming@nfschina.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230223183312.2759-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e61f2cd-2be0-4c0d-59b4-08db18d03d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l5UMrEePpc4+Mb/B0wmGPqB2tz0Ztu7byCra0aiNW5zQqz1ajUhqvMGI8yM/QEu0KgwCBRb5jtgYIpTxEsSUJk9kvUriSfvVjZ1SJtG5BFRuf1cCGmViaSWVzIGNabryYgFGGhTXiojgyRkWLhF3GO144dncLVLXNO5PD+V+dZouMmIxxyjoMBltQjDu65YC4dh9o08zuEpEZDThItlJZcD7XPaLJon0vvsxSLRDKpaPYeTDfEzxmiCgO2GnS9ghpFP8r5xoGlV9xuxPzW280qzCw77eH+84RcSfvqMstp9GDZZpBoPaB0URCUjboWSkfNtXLWq4yK10Ap5e2xYL1TvxMZJ6GOYNVai/6Pm0IrnrAdRtSeMi3Uqrshd16y82Fkua6G8knn8WXBqB8IpB0ugZJ4addGbCtqE5GW7XBeua94dvRC89BpI199S2SX1rZIjiFv4++f0EsK5+vY70NzyhO6Pz+OTkUwErWbLewEtOsMXcusvLeew6v9fgeZky22es6y/Eg6a32q5xmKHsvSsQtX4dYgHr8xcYggGINyMY1dfi59Z1dFNqVcO+H9O1hMI/AEtg1GqRggv4OqBsMewGgUFLnKSGz18zifmkkkd3SgO5SHzCbQ+/8x1nmj18Lu24Kw+uag+8ULtWS70EU0zTuY799FQx0iDPOrTvmh+/w0neHwJ4nH5yfSB2bjUNcP3vY1vrqmL60TNqvHfbJbMbrwIzu79p+h8TQUIZ/RFz+tIVy/cKPZRdEPDhbCO7rcWDKAD7XgdTUSZZhBDIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(31686004)(478600001)(110136005)(8676002)(70586007)(70206006)(82310400005)(356005)(41300700001)(2616005)(8936002)(4326008)(40460700003)(86362001)(36756003)(40480700001)(31696002)(26005)(47076005)(16526019)(53546011)(82740400003)(81166007)(336012)(426003)(186003)(2906002)(44832011)(5660300002)(54906003)(316002)(16576012)(4744005)(36860700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 14:38:06.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e61f2cd-2be0-4c0d-59b4-08db18d03d2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/23/23 19:33, Li zeming wrote:
> 
> hello senior:
>    I observed that some other variable assignments in this function are basically judged by the if statement, while clk_name does not make an if branch statement, and I think clk_name is also relatively important, increasing __GFP_NOFAIL flag ensures that the assignment can succeed under any circumstances.
> 

I think that solution with array on stack would be better choice.
It will be faster and you can completely skip the whole allocation code for it.

Thanks,
Michal

