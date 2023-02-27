Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214366A412E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjB0Lv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0LvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:51:22 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06FFB478;
        Mon, 27 Feb 2023 03:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeYnzvaRSJrtSRrEQQtcYXgAhMZCwwRU53M+G4jN7jQT+ULKEUPTYvJJiIAeWASNkIMtIih3xNEcjTHg5F1e9fhMZkE9nfaWvHqjk8o/fZ8CXO3zL7SZg/3SB4PShsIxVOBO33Db19GGtOAo8I2yhS2NCEOsprWMs7yFDnLuz2bjsO9auUsFcRnnBZweIdv3LytrzkVJnleXX0y8gmMbIl9OKlyXVR6i6cSMnWpBUFZ30fEa+4kir0cEPIB7JlXVLtXVT4NaytwulWXhz7oO4RQL8ODvgVpgpb2DiET+NmAKQswEiek/c1OijWCzIDWajVHYoKHI/TOqhPDk2kOa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz9d4GHIyl/2e/+kDSNyFWm2K9Eir6xd8a74AAXVUSE=;
 b=UhigetlSdaUwqTPriHTekgcDN8DJ00GREMH61lLB8PPyeMgBpUJrRVoMhq+Gcio7mWl7AwsPzc5xAwVIgvrcCl4DLGjwFctMAVd4Pcex8RglGhsnQDM5+b7ciks2Q493RVVUQLawnZXXhoPAk1YhR0zBNyWQNBVoQnXRL93MmS3Kro2+ebVDPUjX/dvo810pWq/TG14g2uzielNJYzyTSk9cWE9Y4AfaRN6h5QzY8mIVP1VC7vPskN4kYWkGu4RZ3DMf31SXLGOQnDcNgOH5W8C7AaHR9iY+k/fmO9EpsjorvI8lFMkmDBvQ3lgIMuF1qdzOvW9v0XFh3XJAniTorw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz9d4GHIyl/2e/+kDSNyFWm2K9Eir6xd8a74AAXVUSE=;
 b=JMrzB3h3vmFCZhRrgAWAQTbaYAQMitCq7xKiR4c+gw+Q0DJ3hgZd3sHksBvKqwgSi6CCMFkeKV5tI2IYmcIxATsaDD8xSPt3BkBouUwFfQXmKo4oK0448fJoDdvEie17CKRPgNLD2IQJvss5vSf//d2ecHF3kShpf3HY9peD8lc=
Received: from DM6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:5:14c::18)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Mon, 27 Feb
 2023 11:51:19 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::16) by DM6PR11CA0041.outlook.office365.com
 (2603:10b6:5:14c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28 via Frontend
 Transport; Mon, 27 Feb 2023 11:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 11:51:18 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 05:51:16 -0600
Message-ID: <63a98249-3c6d-dd50-b523-64c69173d447@amd.com>
Date:   Mon, 27 Feb 2023 12:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 24/27] firmware: xilinx: remove MODULE_LICENSE in
 non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, <mcgrof@kernel.org>
CC:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-25-nick.alcock@oracle.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230224150811.80316-25-nick.alcock@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d5f333-ce41-45a1-110f-08db18b8f072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuw6dbjsSTzLEZ1YuyEstJkYvcX+BjCgBzwYhlLltXNSnAk5JRudGbwBxjFQIXUSjYDCPzMWXxB7nsG1LmVgg70QiY37kvpzfmEdgzpkcGeKOniKNBUATI7+fhteMeutLnm60p6iFwkC/uq4Y8mbRHUhPqxKL0Yjnn264mOCGdvbKwDuuWnC8VneGl3bjO92+ccFHH9ai1ypJIST/jAQxj3aOwlETVkM3T5oklX8yC6zJmg7geU5asEQOKG//piiztNHwdK/KSkMbC4z8aUb/mIhvmAFEY6+NrwrxLObxGwLDudjrPtNzKw5QRc2YEicizDcSSuKyLkG7lZCZkB7zS3sHlAnFUdCcj+aJ5L7F0f7LlFTkJTqjB0LRgI0dEQAHIum4ZyPq6kc4p1jVQ6K6+3/DHW9BnA1GmUgfhEAbYZoPJH/kyFs5+zus3IbaLQ2Bst8mWPk9MnoQgOE9nXM1Y+UGxq6EBHsllmd6bja9PmxdfDH4lfYM5Ei/mIq9eQS4Vyowc4xIXvi0hYg5Agl7s9/thtjW+fy/Z50xvyOHcG2vXzQYaTHaOzB2gmYfiqDOW66rC8JqgUfxx5/TX1A0D/Rl2X6WIuqiyhmgWEB4N2a1BtImQi1cFvAK6aoR4zAy9Dv5UlhChM/49i2Rj+Bd46ntxbsJOtkGB5xOcluTJ26Dw26Kk4PnRRIuDhzPijIMQzpPVdrg6iPwxhxWe2+0AwvLoLK2+vsxK2LaZP8HEbC500SBEvfz0Pp99wGr/HaIE6v2Gnc97PJYBAdF85h0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(426003)(70586007)(47076005)(40480700001)(4326008)(6666004)(70206006)(26005)(478600001)(16526019)(36756003)(186003)(53546011)(40460700003)(2616005)(110136005)(86362001)(81166007)(316002)(336012)(82740400003)(82310400005)(8936002)(31696002)(54906003)(16576012)(8676002)(356005)(44832011)(31686004)(5660300002)(41300700001)(2906002)(83380400001)(36860700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 11:51:18.9488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d5f333-ce41-45a1-110f-08db18b8f072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 16:08, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/nvmem/zynqmp_nvmem.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> index e28d7b133e11..844c1d861dea 100644
> --- a/drivers/nvmem/zynqmp_nvmem.c
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -78,4 +78,3 @@ module_platform_driver(zynqmp_nvmem_driver);
> 
>   MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
>   MODULE_DESCRIPTION("ZynqMP NVMEM driver");
> -MODULE_LICENSE("GPL");
> --
> 2.39.1.268.g9de2f9a303
> 

I would prefer to fix this by changing Kconfig symbol from bool to tristate.

Thanks,
Michal
