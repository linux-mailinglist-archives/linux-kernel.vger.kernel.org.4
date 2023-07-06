Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FFB74A45C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGFTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjGFTW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:22:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4F1BE9;
        Thu,  6 Jul 2023 12:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFXTRbOXVvGHytbiSD793ffRqp1YfhJbN9zyUpK6lwLGWQBmogLa5865Y/pIGjVEsxTyZPjb4nf4aQU3pylqku0gFz0BuAYzqZTiwlxLV+Y0VPE4BnuwR+UXop85dzUSA0rlq4PkEEctH7LTCH8yOkx9j43OtsDFVwJhA3pymcD9g6Wk6MUG6JpVX2zM+ApG5E+KfmgdukvNjkv1LVKCgPcUMcynNPWdmlsdObxKcz16eHU9zibQFecf3VCSWz9XTAv1ciWA9Lav+jRoJAP3jqHK9ITap7G3unxmvNEX5SLpo0+3bhEvoVU1rDF5a+Ll0Ut81g5+xJ0ZAmNdKnoOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7TGTztcXrWcKyiQ666rCMk8aJScEbmqQ8E3jDUZ1As=;
 b=HkJLKlFMWEhlPI/huZ1Me+7FkFVI6SNIl6A01BcBmYYPrU3LmdPNEaZwrNe6HCOMpzQuOzIe1vaT4D5/G52nqYbZxQkGmP0aylVQcTkqZ3/7cZLezB/LHNOGhWaZolQy1HEIuh+byvlvu65ZaIbjt5CU0EHFbOVkzmV9/ak8hOKaCveaeb/Vjp6IJd41kpGr5Z+pj4EIA1zsWGm7I5DwuXQM0jPSBGCH7wPxIxFWo9LQECSRWVLyceoX6V+UPWwp9RbYZNMs9OGWxZi6kuNSnqQ07JjPx2mKRLae/ZR9RgTshZau9i9fuIpo+LzZWrNjERV2RbQ9zBu/7W+517rhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7TGTztcXrWcKyiQ666rCMk8aJScEbmqQ8E3jDUZ1As=;
 b=q4Zr6BElB4rxz9LVJdtn9rn3ny1ZBaAcm/X+aKtBw4Awn6NcOXA/XPEha9061Ll7XmurtG/A19z7LLl/O3rF7NFnn0w0E4Gw6Hb0Mlb38AI0qulCKe2SteX+tlQxeEwArbJg+eAoeId1W9zFiN5PQ3EKNGLKdzM+EoAv1XEuxOwBG1mrrFFHzUrzCg5GAnbxq3RCc00TmLwxqX5baNuCpFYBBdJRwN3bZrBmQgZR1aw/PJnTpcP8xmwAUFUdtSDsPn2uzYgmAUfiWg4ctRDscGYkPrJruh5+9gi2jxgL09md88I91zCQlRBu6v0Nq7k8T+dMmLNBe4IUxs93Vsi1qQ==
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 19:22:25 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d8) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 19:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 19:22:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Jul 2023
 12:22:13 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Jul 2023
 12:22:11 -0700
Message-ID: <967e6d2b-776a-a25e-b71d-76814ce38a22@nvidia.com>
Date:   Fri, 7 Jul 2023 00:52:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] memory: tegra: Add dummy implementation on Tegra194
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629160132.768940-1-thierry.reding@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230629160132.768940-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b3131b-7fb6-412d-4ef3-08db7e565437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voIQLE83N23T4mACJT9/qAON5M7w7iA1XvBg9TGAM0JbR5KqV1c1yt1ljYs+PwfkhMOSSYWWg04t/Se3LrDDc3N3CEVEoMS2Enkc4V+0xJaFnyg5kLvWsnkOuqnLAS7leL+h+vATKXUGzcihAubNFoteEpdA1Xkc03g3eE5z9sIIqC+rIkuUJ4GlGkmjkCY0lyPaxPqyuTuR1j2w6fmsvqoh55tFG3xDwmISS0XF0ekCe9FyHcNXCr6B27XlV19UyCGX2XXKoYSpusm0kcq4GyXQATVynin7ci/e4Kb5scyESzt+W8ha4SYNOdIJhxAtSNboCMhXQegX3oSjeGu0/8An3rxKAFb6l2jBuZTlQqNjm2zTieb7oVHkJVMbBZm9HzEV14Bs04qsW4SM3A4C5GS6eefE4fyN9VbLNvp1prHGPXKEFmlbNIpxUZrkZkS01tb/SnbF1sfHK7P9sAppnR2Jx5ssv3NdAqCAp+c98d5U8IzEU1A2SK3fOmc8UZqecPVPvwZRYLaOngfzwf4jwSE/y2qcn0ojQo+uEf5Q/ebW2cMOBdO4jfY7SWDIbAiDnTT0hu7UO2lSKramz1Vpqnjg3K1yOhEYmb7JnUxmBF/UQyAyePHYPtoTRl9+9q91jCVnYNsrKGWQgHzvCqUYe4ZY0dYQ4KS7eWJyYkj/3sclTQKhszeNaiSDAQBsWPv2atwNScESv6wLvWdBmo4/mL5Lom71jueWR0DL/JR9K3+uLOvhTBXMGzX9OGgCInRMkXIedExCKHupGFhuiZnlfg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(4744005)(41300700001)(2906002)(5660300002)(40460700003)(8676002)(8936002)(36756003)(82310400005)(31696002)(40480700001)(86362001)(426003)(31686004)(186003)(2616005)(6666004)(478600001)(336012)(16526019)(54906003)(53546011)(26005)(82740400003)(6916009)(70586007)(70206006)(4326008)(36860700001)(83380400001)(356005)(316002)(7636003)(16576012)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 19:22:24.6224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b3131b-7fb6-412d-4ef3-08db7e565437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/23 21:31, Thierry Reding wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Thierry Reding <treding@nvidia.com>
> 
> With the introduction of commit 9365bf006f53 ("PCI: tegra194: Add
> interconnect support in Tegra234"), the PCI driver on Tegra194 and later
> requires an interconnect provider. However, a provider is currently only
> exposed on Tegra234 and this causes PCI on Tegra194 to defer probe
> indefinitely.
> 
> Fix this by adding a dummy implementation on Tegra194. This allows nodes
> to be provided to interconnect consumers, but doesn't do any bandwidth
> accounting or frequency scaling.
> 
> Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>

Thank you,
Sumit Gupta
