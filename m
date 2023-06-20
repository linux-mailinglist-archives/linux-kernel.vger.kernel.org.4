Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D423D736C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFTM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFTM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:59:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C121712;
        Tue, 20 Jun 2023 05:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOadKu4PcKcfIB0zlQDUk2j5DvcvFmQ8zPIuvldzunZzMhLzerJKV8CTszNCJJIPiKdm9k0dCAWCv6voXaXWQ5++xlLPBELD+PZ4Vt1hXvjt3bqtJWsZSE3CSoJdB425vkJlBpyIpMZsEHFufs4boj20FracjsIKAcNFkw3HwNU6HBe3OKzGRJ19cf4Gkg/MsY7RQkyOLQzX2pc2BheRXoCb7/6n7v4xAWfHvpOZyYPiD6CKPrBLrecfWnBbAvTuOkOBwtDBnCkexmAZQSY4SbXt/qAK5/ZAAJVc0gOEUfVRyLJTTWyt1GUYt3yD2WwDu8viSZBwdz/MDSKngfer5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8g22M0pwTgX9u6yIsenaSPHO+xsSc5RvzmFurykE48=;
 b=nBLM4dqZD1XjSJicBLkdK+6aNpcpP+WyItWfeBzzuEjGBWmyw1f4QKNv+arduu/c6Hoa+v4TZHPPVlHKu2Zw8hY9CZ/0LYMWjJDFG9NaOsQ7YUlCJZioyD8R1PiHTasx7Kk3dGwIvG75UWY7O9LnGCfypFXs/dGVLqL3eRPwiokb9YVtGDPY1Nzp2swUMZvQRGRgCbmOElVRCqrTnMAEkpJZ3d//1WVRzVGU3UohZ++lkwhuCnJGq+pBAEKIe2VFmbK8rEwGmQ1ygwo722MoadwiYBMlrcSDJ2k4OD9gRgJ0MPyazDeqFJfVzJT0erzA5dQcwwq8NmhGSjiCKBWmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8g22M0pwTgX9u6yIsenaSPHO+xsSc5RvzmFurykE48=;
 b=CjUB9evWO/H+8mHG/j1AAfuIuH2Ikb4NVifOsXGhjJ98o1B/cxVG5+DwRB44u2Ij0xGiQIoErFeXIdq0V9XdG2J9BbJJokY+9t9n4FVxm63w/sy9fHGj/qLcYjT2tW/J81cg3l87H03xEABgV7izyIcp/xEDhiVoTCUPsTgbOLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 12:59:23 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:59:22 +0000
Date:   Tue, 20 Jun 2023 20:59:00 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH v3 2/5] cpupower: Add is_valid_path API
Message-ID: <ZJGilObVcAMhPNF4@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-3-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619190503.4061-3-wyes.karny@amd.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fae876-3964-4ed6-ca6f-08db718e2afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOLifHAvnWVe6p81v3HOrCDzfAmJ4OgLelcW2EwQQpwxLZnlkpp492vz0knFpAaa4zs72Ho9ij6m4Be7eCO0bWeGnb7K79+c+OCXXd7ZILqANNWA0aWtkT5fBWfDuFmP73gYwww84n1TzjvbCP5CzKMwPKIWZoLGvwrc6wWSjC161gdOhI9/xWjhtqLgT5p/tPUkxmQFL1dUwevYRXO1804Uu5g/7x6a6gl4oakB/MH0I6h962j7R0z0djxYFfOQ0nTdEr85hSsrRatiWj1pmrgqvBfOgVc9T8L0IMkaQVVKR0SzcVZ5IiPrFg2DQotdnO6oBThpP0NNFdMxJLYuK7VoM5J5+a1375mie6xg6fl2cu82sCUAXeExW88mNLLKh+SZ/IB8O8iq4a2sRW8LGeCEUaaDAaXZGG2qu/201q7khrnsh7q2cijU9/FhwuT3+u7VM2n5S9Zcmd39s11tq3y/Wv0a/5epQKDusdLU32EWmGLJRSto6QOvxORvk3s3fBpmEVBiPtQLcDQw1ibq81tOv4/3el9HK+VlgAr70mlugMI4sutFfDS3Fmjqqk7A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(6512007)(186003)(6506007)(2616005)(26005)(6486002)(36756003)(6666004)(478600001)(83380400001)(54906003)(37006003)(66476007)(66556008)(66946007)(4326008)(6636002)(38100700002)(316002)(41300700001)(8676002)(8936002)(6862004)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwqz0O2e6ew7JoEt8urQamPuoNHioDL38VuSL0wS0xx27Yvjnm434SwMC47F?=
 =?us-ascii?Q?G8e78gb6hVYYotsFSa2rkfG9+bFetHJF1nkVZo/tkmgpfQxvNXrg5NvCZEeu?=
 =?us-ascii?Q?du6HWyuLfdG0ZNAdoS/yGq+1uV7kpz2ZJ/i6UxiT07YxCGSVrKvTL/I/SQ86?=
 =?us-ascii?Q?l1AuRBUwS7qfiT0qGsvwU+FrE8SO05sEwyheHkCRrAhZoJ7gnbq5JiqmcviZ?=
 =?us-ascii?Q?jTjyQPkjyNsRXq2IK6qn/MBmpAvdXziciWrNneGV4IWzSEOzbCnF0nt7QVFX?=
 =?us-ascii?Q?8OouB1uo/f8r7iNj6ePDTF5RZa7APkTcbs61zYVtL7CR8ZeXR6NhCdlHeMi6?=
 =?us-ascii?Q?fCamLuiIcn+KqW8lBwi0T8hUt3/q4nNSW0frHKTLHuRvxZMGW8WUmCgFkKex?=
 =?us-ascii?Q?3kFx7O/aJmDeQIIqdCbQsPH0WouR2epnhfVTcjmZCkOh+97dNdT4eDj9s6kz?=
 =?us-ascii?Q?OsZM4vFxXBD2+gaA9JHQa7ZuayJY5oaaZ9hrpHThWA2MEpZfIK9qOUAF3Yg0?=
 =?us-ascii?Q?3ciCDyg/zB3aIqgGI/7akhofESxt6WE8yw+7Q4AFsxFHl0lF7kdLpn803ZY8?=
 =?us-ascii?Q?+H2xBx4OxuaPMN1Hts7OblmawFYVaIK/3Pa7eMXEQgi1hUGhKmMrgXMAvxzN?=
 =?us-ascii?Q?oRdN8RoTH0ydkbQawUc4lIvUG2dIOMm4FN+pjY3WPnHooGPHW9hI5SuwAkiI?=
 =?us-ascii?Q?AkFHHb77mGDG2E0I4MBTKeM4HVVFgND3fACpDQA7f8eaGCMZq7zAv453uEv/?=
 =?us-ascii?Q?OkpU1iHH1BVcBRvrfje6CYJ8OrkNLTjBKCZtdJGPGvlqhCrjhXH+FXjPngJr?=
 =?us-ascii?Q?mxRdU05WGu6lBTIqhJfKPS3fPzaa/xc2Yv6TbZ9QwX6Mrd/9ugKwo8fQNr9Q?=
 =?us-ascii?Q?LgObLGtqDvyhUzYmyqEGvzfXmh2t9siATMlKpaaTqfSVToHyqWOrGdu0fzoz?=
 =?us-ascii?Q?D3wanGnJaIsev2nOh/Ymp37YVjwgBbzZEGD/SkmveLLMJahSrp6ffV9Yhj7k?=
 =?us-ascii?Q?e/oz0D6ji4QllB52C83mo2SKrWZcailnxIU19h8DusoIfF0GmEWwGHp6Fuec?=
 =?us-ascii?Q?uA2Jusanas9SSOFeEqVbNaJQre6lKv31gNrM8hwKa6KXhDAYYsZcr4KtpF2z?=
 =?us-ascii?Q?9Ffi34V6bdTSZV5jrgOfIx0BQ7VaREbsa9gcVaJim4wDTz5AWAFBA+gbpg7O?=
 =?us-ascii?Q?CL87dIqirCi1t9iFA8yVzO69ljjo+pPQfPQi5LAmi5mjNI7Yd3TILycpJVvR?=
 =?us-ascii?Q?HBdDBf/KjdcGbotWXB3r1/5/8KccAJWIRMZYBZvhdyNT9uHQ+KmhIWT1nk3S?=
 =?us-ascii?Q?o+FLVojcogOlOo0FsS1i3OprA/iZraa9LtGKGPjoJ0gRUtuhUxeR8rAAkwKa?=
 =?us-ascii?Q?daV4UtpImRYg0gkyVxGcK3te7LH9N8QrjxK9Y/rN1rC9V1QW5OQ7pIhmN1cA?=
 =?us-ascii?Q?2T9qWR2nkmg4DRPtJBFIGQHqtPNSMO/EQSx4lxgsvsGEpF7lZ9jw55gib7yE?=
 =?us-ascii?Q?DlRNP+nYD7f8fZ95T+p6jSIGK80ynSoxI/bD13cmgxfJLU5dVF2BvZRcAfdr?=
 =?us-ascii?Q?/SaWNjHuGm164nEdZGHCnitas3ij5CGB4hCVIhZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fae876-3964-4ed6-ca6f-08db718e2afe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:59:22.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqsIkCucl+FkrCKSFu74wHNVWFcNIzC6TxuNZz4ZfXcfAhlIXVes0sckoUSRbrTVvbEh9Aixw2Mr7IBaQJjDNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:05:00AM +0800, Karny, Wyes wrote:
> Add is_valid_path API to check whether the sysfs file is present or not.
> 
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/power/cpupower/lib/cpupower.c        | 7 +++++++
>  tools/power/cpupower/lib/cpupower_intern.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
> index 3f7d0c0c5067..7a2ef691b20e 100644
> --- a/tools/power/cpupower/lib/cpupower.c
> +++ b/tools/power/cpupower/lib/cpupower.c
> @@ -14,6 +14,13 @@
>  #include "cpupower.h"
>  #include "cpupower_intern.h"
>  
> +int is_valid_path(const char *path)
> +{
> +	if (access(path, F_OK) == -1)
> +		return 0;
> +	return 1;
> +}
> +
>  unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen)
>  {
>  	ssize_t numread;
> diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
> index ac1112b956ec..5fdb8620d41b 100644
> --- a/tools/power/cpupower/lib/cpupower_intern.h
> +++ b/tools/power/cpupower/lib/cpupower_intern.h
> @@ -7,5 +7,6 @@
>  
>  #define SYSFS_PATH_MAX 255
>  
> +int is_valid_path(const char *path);
>  unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buflen);
>  unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buflen);
> -- 
> 2.34.1
> 
