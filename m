Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112864DDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLOPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLOPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:47:56 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B31706F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niA2bz9oaQXj4zneBgoL13SOeMsdOIZrcu2TwkT2Tem+f/Rwr8S430n3ypbNOgL23kmnsP2hExIHtUuhmz2CEu8y6Eh4q8IwR87AdBqoNur8/pxA/xIi3wiXoYs8UFA3X6s3szJh/T90BVvewlu81u9jY+bpkiutZy6dg4DqMoWWaFwtmlSulyE9Ccw/m3PaCa1NIVrkm4BiJf5QLvtVU93xRPnKkUi/5CxZaBGa8NMli2laZSBQH0ZVQ6HczQxPkoSf908EmrJ6o/bRdxEvnVKN6iG5Mi/knuv3mF3hfB9bUsfkjTAXf1UCjiBku7EqHRR7S/ikqWCHyMphZjW6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwqb8crrzs/joKAehvIcJV2770jp4VSSERO9eC4OZhU=;
 b=ICKkgqVjBbMxnZ6Axia+FN7DJY3rYa1CgmZF81FVj+7IwILQAGZ/+ftJv3nDCUfhhe4J7wkkl0GUM35yLlhiya5lqTM05OK7Af+sLtcyYRL6bA/9xXBBbZA9nFPhC/qBkdBMNV2ygMMuUExbI2JdqfawCS2BPummYR2uPpNGVi5fTE/LDV1png0O/HJI5/MZ+c+nj9k4PlXqunaA2Cu0dOQrDDbT7Inpkoow/pSD2ZDaQO7CUNyybGFNqzHQMHz1DY0o7aUNBeMMBlymW1tDMeErX/7DsNCDF72bKZ0VUtBHXCkbYAP3reabOreT63pgbnUUWLjuRCOHc0dpQ/SVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwqb8crrzs/joKAehvIcJV2770jp4VSSERO9eC4OZhU=;
 b=UQxk28531m6qxjssdpZrGGWvMkkUQJgRBLWJtwn5kpKrmiCXEVcGOnHOpO2/nVR6OHomOEWJdu5UH0e73oKDjXbdi/fbJF8FHeISziCvuRIQ4Rm+w4fKrJPl2TYvGfMKWQMELzSDiQm+nzU+zrYGcS1+TB7y5q3Blbg4mLFqbVw=
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 15:47:53 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::b3) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 15:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 15 Dec 2022 15:47:47 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 09:47:43 -0600
Message-ID: <df62e073-1b99-dac7-081e-cb957ef05d94@amd.com>
Date:   Thu, 15 Dec 2022 16:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] firmware: xilinx: Remove kernel-doc marking in the code
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>
References: <f4c61cd5e45fab345c366a15766101408fbc3bcd.1670502727.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <f4c61cd5e45fab345c366a15766101408fbc3bcd.1670502727.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1511bff0-4f78-4e65-aa48-08dadeb3b8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28SIt35F6U5gSea+cN9FLgGg3YV5S4qI6Aqq4MmKULbZGw591hjozAj+DF/AsAkJW3kt1/ySmC3R258wGuHkG9wH7P8qsZouk+dSdyv3vK2E1KFJmvGxLTnWBkOTPsiuWm5EqLDgcVKjL0ejP/H2UTkSgu37VRslybl3IkLtWVHmgpgmQOe2nWxOTu3f6vRY/mETL2xY+aioDeeWb6UXoccvpb2VbFPYar7h4XKphza+6LGo4EPKQYErgrQGUIne4kT67sZ5yGJzryDMHVbkpZEUHMjMI/IabS9pae8OHQIwRExyheFqsp2xRlsw/vlODWzGKRrvahaLHvzGEIsn4BbPD1BwbmqrPEE7xgOPVUhXoKCU+wufk5PVbTPPh2KebqFn0p5dVjcysgpGp+rk8iFe5pu3PISbBht8sJk1IalShG5OMhNMNGMxdeMH8n4zQangYIJpZ+llRWN2Orxn+69EbdKSomE0x3XYA7e+ZA2ij5OKDJb1QwW7DNYsZLqcm7vxEywANkAPRfhEQ2pNx3iZTEPyY9ytweN/2OL9jyppKMM135ifK6nhemlyYgHq7MloKaxcNWSIixIjw5p+47yo88TUQCyg+JeeGhIzOPITYpiWnDFjBpChJdTs6McAbXzJJO6VibxL8PLuURXNgOreNwcHX3GgkQVWQkzkBLc5mzLxzUgQjqeIA7zlzjNZpJc+I/Gaw1HrZmaOnJXKO8incniO/XQuGRHZI78aQ8aPP51nsJ0Yzf4kx7H0KsQ3rx5c5oSnimlgQoGpk4wHzbLgVGiKzX0BSzQH0dNAtKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(356005)(81166007)(82740400003)(44832011)(4744005)(5660300002)(8936002)(2906002)(186003)(53546011)(26005)(36756003)(83380400001)(70206006)(70586007)(4326008)(41300700001)(8676002)(36860700001)(40460700003)(336012)(16526019)(2616005)(82310400005)(40480700001)(31686004)(86362001)(16576012)(426003)(478600001)(110136005)(47076005)(31696002)(316002)(36900700001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 15:47:47.9043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1511bff0-4f78-4e65-aa48-08dadeb3b8bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/22 13:32, Michal Simek wrote:
> Trivial fix.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/soc/xilinx/zynqmp_pm_domains.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
> index fcce2433bd6d..69d03ad4cf1e 100644
> --- a/drivers/soc/xilinx/zynqmp_pm_domains.c
> +++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
> @@ -227,7 +227,7 @@ static struct generic_pm_domain *zynqmp_gpd_xlate
>   			goto done;
>   	}
>   
> -	/**
> +	/*
>   	 * Add index in empty node_id of power domain list as no existing
>   	 * power domain found for current index.
>   	 */

Applied.
M
