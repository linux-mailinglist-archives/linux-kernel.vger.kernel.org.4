Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D16A020C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjBWEdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjBWEdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:33:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29532279B;
        Wed, 22 Feb 2023 20:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnCXK0GX2jMr3aGxS4NuRY1l/3/idvvwxeqdD2Zz7I5zvzEBDkfeSc9vbRAFZ2Y60s1Un27cOQRsZJgflMLmlItkeKyfed1GcBbZNQlBCR4zM9dFys3q86CMTYPxJlrtcs3GUnVmt2q3U/R0pE34B+PTMVkDuqmIGzevLn1yG3UBFp8LhzfNw3xxHBX+QAsbfJkC51Rki9G+5ZIsALiTh8zWDcsxmWYtXWrbaDXAWaCc4aV+jUqxIGeIdFFJsekEUhSUQRT4wNd1q5/2fL280RkCIp58d07Z6oEEVPSv07KnJTwlUyRd3VOTxT99rvEyHYWrOci5AXzpN9QT9oampA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUJRO+gRNk5wv/Ha21TVltvgi+XXx5WFk5QC25TmBhA=;
 b=h7WkHG7vR2DAbED1i/ReUhBev1Pvw0IVx4m79JWXGtGYv6/kE3Lv4Y8Fgo968BxKQUWmBHfZciQ56zD4iIgmpM3u8VBVkOmpccpFx77JkoxfEOj9eqZIvGzpD4yb8KQqtlBWyDz+DHbBgk4a5g1nDH9tO+QjeliFh2CktpsSm9sS+slkjvp3tgAF48ZDWDNzMyDB0riocXUgeE9HCw90SOBdC8PQ03F2X/SWgWamY6gF4rBXlcsahjhn1IQFfZS35hGZFBnHIodeZs4DZguHBJYc/EZT16gEjpeu35weqtd+A3jxK/t2++rYxMAWgYRqBanNw2Wg7TWq/4fPQ0g5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUJRO+gRNk5wv/Ha21TVltvgi+XXx5WFk5QC25TmBhA=;
 b=DutYB1ELXAs1vQcR1HG3aY35MhZ7i6c+6LLT06bgOxP6L3bfuNnoVpqqOvNF1gXNdr5bT1poR46hNaOn6PAzd5qhi/8jaTDzQg/h48NjmWk9O7HH/tPmCqxQWxlSI0nchNJJK9u5pPitPk9ffY60/eCHOR4vnLyOiCB5L1EeUT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 04:33:27 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 23 Feb 2023
 04:33:27 +0000
Date:   Thu, 23 Feb 2023 12:33:04 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: amd-pstate: Let user know amd-pstate is disabled
Message-ID: <Y/bsgIipfVLXXvhw@amd.com>
References: <20230223013032.2011601-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223013032.2011601-1-kai.heng.feng@canonical.com>
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e984f3-3cb5-41a4-c624-08db15571b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkcJ5QNgUzlWJjOT4jB6VZT6L9STNE0Ylu6tYumdT32381YlLUWYZItVedFf240Ny5DRARlYVIdk9KvQ4YKK/3ohdhyIZRPZ9XtLipvTrYWdrB6nMJOseZPbPVlkUU2VotKFop0iDZga1q5lGlkNlgFuGOXSuaFS50/cUApsMfpUutnDJ33shIClGt7p/kSPjO+joKEnN6/xotk+M23o3C2ZpRz0Ciwfpfsuy7ZVORXe5tMKIZTwaxq1uCLa01IUdcjG1kk9cqoW5PAlYLuZaIn4xnq93ww5SS5bkQEtyCAT/Ym7FmHV/XHUK9t10KHsvhhEzI7IU41mtG/qBlhf9C3eROlLVQUf1XftXTp/xMF70mYDRkcQ3cETyCNapYeaXWkCZ2Z/axjBTqjoXg3cawS6G0sPFg6tqrU+GMEc3lnaM83HnIZ63sKLHdHTqDkyznFoCHMmWVgilW5paaF8jU7LFBu1mvn+CvfGwIZM+0kLnfjLFetsIegiYDbYuBd2II7pu5bSDG7R1lwPbwuAtHN5hm/oecIPCLjgFe2fqfW23esWnoJVnv2FYzbW+nsDi5cOPLcbePgcgmWtKOF849W1ABcXocJIbpzx/1QXSitI2zbAHsxPXnJ5Bgv0HYKq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(2906002)(5660300002)(36756003)(83380400001)(26005)(2616005)(186003)(6506007)(54906003)(38100700002)(4326008)(66556008)(316002)(6916009)(8676002)(66476007)(66946007)(8936002)(86362001)(966005)(6666004)(6512007)(41300700001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a+B/CBF11r1AQHxB4FXY926iW+2zZBPpOut7esCkjb3QyURYcL5wjDtYqsuf?=
 =?us-ascii?Q?hmXnFyEwU9kRGuRvatsUobUaKgld2hI6Z1ui2eouc6nDcHMENn24cZvWtWAy?=
 =?us-ascii?Q?W9r4tLEzSKzUFZoYWAhtnlQMNKqqssxq3veim7teJGHvF1OVxMuctTE1l2DC?=
 =?us-ascii?Q?lgAOMog5M+JeOrKWrI2Z+MmCkiNhb0qJd+Fjc+dzpOKxOwp59WC3WxwmB9TP?=
 =?us-ascii?Q?G7ahnWrCFgeMsTPQ3Gv5EN5NAPFqJyLcxaSWLvlGG4sTLoi3vhcsx/TlwbF4?=
 =?us-ascii?Q?AtM3N71omzJUilwn1FALTI+h4QxtqWmmbMK5MCq7o7FovTliLUDOLQm98wyz?=
 =?us-ascii?Q?c20Hp5Sq5o1FdWhHv1r3do1w2VgrWiWzN5U5rsplTk6piJAz3PxzCOeIWoBs?=
 =?us-ascii?Q?1Zz+Sstjpkf1nydy0Ug4s/lKmqPII/gSkB//PxUSi9MEm8+zOJxwJaIWHm1G?=
 =?us-ascii?Q?C2zPJLNaXeFIpC8AyRq409BDxSPFab8yN8/31b2iPqOZx+uZz2fRi2V/UPVJ?=
 =?us-ascii?Q?1RmW30Ny8vaPWI2yI5tE9BBxWnB8mE2pYVA6o12oC4/kZD4wSc3V83meCVuo?=
 =?us-ascii?Q?zYz4eSjjcJQBGvHgXKDxeoI6SQmqV8/h/dISpX3PuMYDB60S604ER8G7LGpg?=
 =?us-ascii?Q?eBEdu9ITRtep/rYWZ7dYQ3rrptmY39YBiACj/dBT/UXKjZ8Ki/4CBdJ5Tttb?=
 =?us-ascii?Q?C9xrdkyTh2u9XYgik43RbvXOlA/u84tA+sKRrXjVnZZ/wfkP+BNEzN5L1PE9?=
 =?us-ascii?Q?5CcU9l4iaF6c+P/BsEGPjplLGrNYPI0pSqSA+Pb6ntSCJ/0XfltrNiRCUO1F?=
 =?us-ascii?Q?VcXTFeye0rMLue76erHt1crBkrhPAVkT//c4SxXYwABR7FUz8a14A8ZcJ5WB?=
 =?us-ascii?Q?PvokDBCJfeLmjK0XQ3Siyihq6MF15YbIF/Nbf03VOuXJP1mTXmWiF1CusT8F?=
 =?us-ascii?Q?dTPdZwQ8Gw4Zi04wE3dn/yUc7Cr3T+IR7M5s2MLQu9hVz4liyiJNKadYz2bQ?=
 =?us-ascii?Q?ooiC5hWL4aoGasF+IsGlWLNn/kakc57DkXob8aK/7yipeR6TvzRsdgg3reZ3?=
 =?us-ascii?Q?38oeZ8IGadZOGRaztIfqDoHxaruv6Vi+U08EapCXLJI1qXXSM1ee260yccRT?=
 =?us-ascii?Q?yXGLy7vxUM76ZGQlfw7DHhgBJdStO9m2TBFbpDx2aKVa9ZW4njUpUjH2ADMI?=
 =?us-ascii?Q?QjqNDM5vmkv6wbJLpLOtDu3JzsdouqNTNMEhGwF7iK3xMx7zEM+2w7G9I50s?=
 =?us-ascii?Q?VE5hQkA7iSUaLpbDpZQG1oT5ZEBoEjvm690eSsSAtZEuwnqOyuals+g5PGDQ?=
 =?us-ascii?Q?TzTTJYNOvzGq58cxc1afkhRG+XJIzqb0HKWSumRsf+LgQq1+XigHXfBW4XIj?=
 =?us-ascii?Q?WaotBIN8RSawWOr35h6SqXkUAqF5VkNqyYQeTiTxH8v1Dbcmc+sGqcVBEu4J?=
 =?us-ascii?Q?RdIHCXtZtNbOnvnsmKSzI0rqdFULZJYs+B7xVAqZiLdkNST9/zKesZ6/I875?=
 =?us-ascii?Q?Kpj6Cy63vz/fycC/XNEQAjCKYGBwS3Gg0X+xxMT9ylmt+YLXJjyJxaL+xzvB?=
 =?us-ascii?Q?vNpO6ol6MmJrY0U/a791Y3DneI+/GjWisz3ZfhyS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e984f3-3cb5-41a4-c624-08db15571b73
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 04:33:27.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc3UpU3qB8ajhlMtOMEDrHPJZy21XoR4aZsZYCTGXIswzU8RUsVxarXI7cafLjVA1qOVpOrXUXMU/z2NNsaLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:30:32AM +0800, Kai-Heng Feng wrote:
> Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver
> parameter for mode selection") changed the driver to be disabled by
> default, and this can suprise users.
> 
> Let users know what happened so they can decide what to do next.
> 
> BugLink: https://bugs.launchpad.net/bugs/2006942
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 45c88894fd8e..305f73f657ed 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
>  	 * with amd_pstate=passive or other modes in kernel command line
>  	 */
>  	if (cppc_state == AMD_PSTATE_DISABLE) {
> -		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
> +		pr_info("amd_pstate is disabled, boot with specific mode to enable this\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.34.1
> 
