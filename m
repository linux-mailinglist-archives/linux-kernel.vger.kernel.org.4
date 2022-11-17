Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856BD62D23F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiKQERy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiKQERN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:17:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132865802B;
        Wed, 16 Nov 2022 20:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYxYODTPL/VBdo89wIHXtv/juUI9vCHKDaBQRO+xP3GJMp6eDhWrNs704iffxji9y997O/DVrH7oG7GuZaiwJLMjUajWfdQcXiSAB0QZOvUy4pN2KNepDpiH5NngrLxiynEtFcaHrYSasT60GO9lgfKZaZyvy+k9V98eyM48ScNYqC8md+qPqKxjeYmQOah2sm5JNbpPBtIcyabUtbGx7uAu2ARYWlyLFIUu6B9M7tyqKzg/lMiQxMmK1jpT7NkWSzyaCaZwZdVJ22WFuPjrvLDVKKsxECdxBL+aG0eQXi6PUPm5gqU+X/MImLVQsxKdean0xGsdfBhkzW1HfU2J1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9imppkGZ0pm50xnRSnMAZHSWeRsQpJicg84Qkw2Wa8=;
 b=CBIMdoVmfnbCR63/xcBgzUpGKEpYEmiatfrPvqKA+uGAgiUn37M/SED9QHDMOFBke3YkKQfPGdSGjVP9UHFUsNj10d8OO4wkpzMJbBFuby3vPI7w5nweB2Tj1uUqLSZLbyrXgP6w8vdpJx0Jvq59BJc5YEOpKpV4+LLwbJmNP4nE6C8qZi9Z8TFs4RqthmMUFIh8FT1wL2zQvJV19lMqK0kI4tPTzLAtO+A+WsslLsvp1jqoFu1WDZ2lDKCpUfDqEb3yL0cdHpFyVk3fxLG57cHcQ9QL/sUT06az3GDiAr6pDyq0I+e6Bmv2wOZlshSXvbYJAEeFiPAhLTZWNq+iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9imppkGZ0pm50xnRSnMAZHSWeRsQpJicg84Qkw2Wa8=;
 b=d7beRKQRQjwt+He3yVwNsr5HbjJd3QXwSdg/I5al/ZCMYV2G1kijgXBVB7pMEY4oxWQzcfv1V1f8UzoSla0gJoxzE7w/8a/FaH7+sfECswdhl5ayJK+mzFFSD/GMb/dd7D5lIL7qNfD/Ja6q85f6ehPd+nzEWWgVVpwtYn9Hi5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 04:17:08 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::b1df:1303:4c2:b96b%2]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 04:17:08 +0000
Date:   Thu, 17 Nov 2022 09:46:56 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, wyes.karny@amd.com, ananth.narayan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Documentation: add amd-pstate kernel command line
 options
Message-ID: <Y3W1uHu/GMHu5LUY@BLR-5CG11610CF.amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-6-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117024955.3319484-6-Perry.Yuan@amd.com>
X-ClientProxiedBy: PN2PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::23) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 01eceabb-d3e6-47c6-aa48-08dac85297c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jih4LasC9TohrpHT9drDXkn8k+THQ1+X201+xz0/gXkVdfvkaoBj+gRRDTuRZm8wdK0KOORSn+HFIV6QjZCgT0/eKfXXotKFxGFIIqYaHuLuvJOI/NAsofYAbjO1+SlPGRyzbXNJPhQvet6wF4qTkoA3bPSRUMK1x6mJTSUasFc/56xgQlOyGlFerP4l/AlXP/t9vacObsF0ChtYBMuHJ8c4YwAyPwl08cdjOPB0cJwQwJFxCi2ZZx5b9AKTB4fqzfMQLnBZeTc3glSZ4dd9ff1kQ1/WLKBglKI/jvWhlyYye4khen8Ktw7zve0SQdmD6wnW8VAEOPEUqcSWzHqQTOpXuzsgLPpYn0HTSHYQfaJ1DBlhw90awHoTMeK6H8jte0lB6aMCnHX9Jtti+fVEskerquYyfOEDYroU8tr9LsLsoi8IRumbjLvj6LeBylhuLdU85GD44NVTU8Go87iPpev0DUYNtlurMi1cAB86bEr7JcVXr8wzeF69TGfMQEgSQNMyqQpKh/1cor33f7a44TO+UkhZJ/k7fBsIb/5p9KGad91241dP7ImVyOG+BrJPwN1ZF3b2m9pLMlqGZiWZlOWnYrA1GN7khNpyOU/1SDctNL2P5l9DwcU4PQo707EnFAYeKjbtiS2UvznM/iUgSD0DquOJudHR77YAkYOM2FttEeBeEStS6WKq1OPiF/k3HafolCxB36+yzi+0vl4yvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(6636002)(6486002)(478600001)(4326008)(8936002)(5660300002)(6862004)(316002)(41300700001)(8676002)(66476007)(66556008)(66946007)(83380400001)(38100700002)(6666004)(86362001)(6506007)(186003)(26005)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hfL/OnwvGadkiFGLkFSMDQyTPlVL/vLspt7T8ASyY7Xsx5e7qMhWQi6QrEWH?=
 =?us-ascii?Q?bPqFb98rKhFoK3xMC71VRML6i+MyKQPyZbNO7H/1q0kSYvgnV6/mbLcyPhOC?=
 =?us-ascii?Q?kb5UZrM/nvl19FHJcDwpVvif8MR6LuIiSwZDlNuk9mcArMMZs1cijCS+oHTH?=
 =?us-ascii?Q?+wFARle4Ren6xM6VDUVMNxykcU/+WmciOKgsVy+fT5sbf/7zk69u+Ck3NBWn?=
 =?us-ascii?Q?T1Vos3bjkowgN6DZvw6Am79E2YfedvcJj/vh3Ra/pMJzt104wQfoafCsGY9/?=
 =?us-ascii?Q?W0hjRb0fpQL56gMa2l9m+3eDus4maBo9qcYCMsNqSeo6EaHocogn0MdXsZdV?=
 =?us-ascii?Q?5VMs4Pr1i7z5fF7q9yrJOP3UVgULqUdM/b2As0LdW/2MBIH0npmIXmMWBpiu?=
 =?us-ascii?Q?TcWefx07yQDNuqkb3Gzr57ZUkApO4nRLdNdvUI7nxtM6inAXtlpQpwGSr4mp?=
 =?us-ascii?Q?S4WTOXBJQL+qNHC5MydgUU0m8UnQCg+dL9/zNfbimqTpFcZ8rz7EqUF2eqB2?=
 =?us-ascii?Q?cIf/CVhJMWTrLk55+Q32ahEaH8NM0fw8/G8kZ7kevqWXl7VjWZClQVRP2R7E?=
 =?us-ascii?Q?JvXOkcEP3zIHEri8gCZNPoAurYl5BRTO96UUlpB/V1FNlO7Sdr6kfDtphX1Y?=
 =?us-ascii?Q?fFFYzAlC1gzXVoLuDBDfz1TnI7Ll5K4H1T1Kj+wzQwgDCDWLeRW6PDT7y/nP?=
 =?us-ascii?Q?vtEStpk+fpKX/IG87oHJbQgLtKi870r50Ixt5/GOjSMi8QYuE4HQxG+pGe26?=
 =?us-ascii?Q?SCUAYkEbRUmzZWWVl021H2iCsp6tmQBQTjDcY10B+Jj4oIkDecsuEEDQebOg?=
 =?us-ascii?Q?n3acBwPsFDMnOz/FONRGskHyZAcUmncNmnxT8K3+bN71qH+cnfyTo0UnhMv0?=
 =?us-ascii?Q?i0js/2fD/9ch7hSz/1H2jKme6PANrBM1F92XyngaCIeE36My0E+ley94O99J?=
 =?us-ascii?Q?OrewiPBNDV8AobGGJxjIp0lpcNUs9OKskGRfMc+rrit9KoDmHgTAEMkgcUV3?=
 =?us-ascii?Q?O4pxj1czYIXUIWWv128Hkd5rihu80V8Bks95ozOqK0wASu/ULXwY+bY9RD2b?=
 =?us-ascii?Q?CSPt+TauX36bb2Vv/de1/yCYsrwo/4/vmg2CZ1HPWJlau8ZYvter4lE9bGoR?=
 =?us-ascii?Q?0eg+cdCBEvjkoLwtNVQPFlvhaQDPkvGsm4gxjEltKLzfjyVjs1E8wKfdYo3N?=
 =?us-ascii?Q?lmtFTtBqd5XCK6rPJ+mietvmLgY50ujQR+S4Uml/66xumIGnVqwFgn6f7uaw?=
 =?us-ascii?Q?Oxbjyi7GLjqyp5qmLnZLJ31HUYwmwgZp1Mys2gB2/WSBx7/HyQioo8I4aQzu?=
 =?us-ascii?Q?DLLkX0BB9yPJMOx5DkJ0dmkFTHIlPW0rl5LogAOJDf6VkKONqbdKwGHT+KdQ?=
 =?us-ascii?Q?pxyCoULUpLMKoUztpIdnid/HN6efsbQWOQDQ/r/MfTpiy8Ammko88+r5FeVZ?=
 =?us-ascii?Q?HGe+gsVrPw3oJ4Ox+8PwRMIPXHmoW1O1U0hdxtNEcFNjuIXck07tj4yy1nIo?=
 =?us-ascii?Q?XOQZSV2u8GeSMqsS045KMLxGW6vCofLP1mfvnCL/Q4IMm1PHYNP+VfE9MDd6?=
 =?us-ascii?Q?qT8FvWT1Z0wJEXaZtHkLz6gRVPHdJC/csLaO3rZT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eceabb-d3e6-47c6-aa48-08dac85297c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 04:17:08.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5m/q6/zsGVmSsaJonksPERb7ioIDSxkTHwy0T95H4rMbJp23dDbx27c/CFLeGJh7wo9BOijnx6h0yegXOMFu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:49:55AM +0800, Perry Yuan wrote:
> Add a new amd pstate driver command line option to enable driver passive
> working mode via MSR and shared memory interface to request desired
> performance within abstract scale and the power management firmware
> (SMU) convert the perf requests into actual hardware pstates.
> 
> Also the `disable` parameter can disable the pstate driver loading by
> adding `amd_pstate=disable` to kernel command line.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..42af9ca0127e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6959,3 +6959,14 @@
>  				memory, and other data can't be written using
>  				xmon commands.
>  			off	xmon is disabled.
> +
> +	amd_pstate=	[X86]
> +			disable
> +			  Do not enable amd_pstate as the default
> +			  scaling driver for the supported processors
> +			passive
> +			  Use amd_pstate as a scaling driver, driver requests a
> +			  desired performance on this abstract scale and the power
> +			  management firmware translates the requests into actual
> +			  hardware states (core frequency, data fabric and memory
> +			  clocks etc.)
> -- 
> 2.25.1
> 
