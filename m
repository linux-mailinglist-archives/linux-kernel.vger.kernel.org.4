Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8D73286D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbjFPHJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbjFPHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:08:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC33C25;
        Fri, 16 Jun 2023 00:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goDrKolMvhndk3Tnq4qikrFNVP7jv1aTMXQHCTp2Kr69bKD1bmSBPc4KGl5I4+57eQlPeYkj3rFz4nQV0EBcjkWmgKWeEQ0NtTube18nOSp1sg8lc0IcnLTqWFEd+QF/9YUZ47uqgDds7Cmf5QRN33jmXg+SWQKZzZn6itQknk/2d54dEaj98ICKc62IRgWJkNi1Hwao129LsfxeufGjDmGf3ACYDj8UQ5yob5dVQ0dzyP4SC4yXyidjxdkVlfqFcwlarQRzScSgEaB8ldRHoJds2FvAsdI8oaUwkN6dI9Z7OUcOfa5bB9N+pwcBpGf5jwISvEwxGJbXbhEgsnDdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ75dtYu2Wg9oeqECdIS6IEnb+v7X8xo9+v8PE/j1TQ=;
 b=nkzWopkaStwPwgGkotNHeECc/0TJP67/pUE+qEHASdbFbCiz3W1iHJKlgkOFDajcvRYdj0b31Wwkl/a+EBPBt3q48XMoopNhMTZqJe4SbHvDy5E0QI/gFpdRi1CE35xmRSkcYhoM5o22k74DitZmDcn3WmA+u8vcH5+H6F4c2bkmC9C4flWmWPI52eSZ1Om+SSASm8z16bgJkRIBbtyeNjCvR9sZl9SFgGpUxTA+dazyhYSE+mj2oiCvN9V9kxEnx4ygJp8f9DrgtyE5q82pbNMYEZctXl6rvDA8hxpj5s3pxmggiF3eLUAiZXyv0/Zt9egWHdccrmnj1IxCokin3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ75dtYu2Wg9oeqECdIS6IEnb+v7X8xo9+v8PE/j1TQ=;
 b=dfFq0CilPtpErTzmW3EknxS2xq2OlONYrw76sbR7kxzwEjMETHvxxKolsoYYV/fsOGvcP0FJchNVkrCP5OfTvTY2dZi+dSY+k/KnREMaeHXbn00DHrSjG3m1cW/Wz5bzWkb2CnnzupSHWp2oPBuDI6xeC0cmEnys4oMRKDEQMXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27; Fri, 16 Jun 2023 07:07:58 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:07:58 +0000
Date:   Fri, 16 Jun 2023 15:07:32 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name
 hyphenated
Message-ID: <ZIwKNI6OvhZles5F@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113615.205353-2-wyes.karny@amd.com>
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: c4274686-20f1-4041-74e3-08db6e386a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: secWXcePXS17dmhhIEusLZFZFheQbMjRHMC7UwKAh3Onxajm+i/HfsYu68QX6j2rzraX2fpqr7HgV7SASbYS8V+nAvKVtnlV7ST85RmsiiBL/zLhqL5NVyWfZgi3BTO/+2n2woTnahu5JWFs2FZ+rlI2+vjYIICi10xxMcF/QX3bUTs+5hJ90lh7KSIVBCyE2QO7QDctgo5JNYUfD404r7FXaxwDjWTlsXtLwQsnK7fYIjUIEQ+sliLEXW+Wubohw/9xHmN7yJGUmLN87tsU5sSIa6QLxLhxYrR2Lq/XCsyZVqaMJg+2xGNZyUUwvVv2wMctpFJUgzB3ecITi+uMcwIyU/2ElHmWrAep80KwxVAKUzWN3c+QKJZVn35dTXwCL+rS7pMGNhAlt3Ew/8LBC1UX5OLbcyKYgHSAAA2bRBdDmj33hthWfUrqc3e3lXcAppXGkU97JolQRnNiULgr/baZoHS3rw9EpEIqx0jGMxoN/muj+kDbapucXRFr6sR2+jJjp4thqt6BOQc4/cIZbGwq+J6oR5qOvlNlyslWOtIl7Y2NU8rEVdF+q37zBpnv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(5660300002)(8936002)(41300700001)(6862004)(8676002)(2906002)(66476007)(66556008)(66946007)(4326008)(316002)(6636002)(37006003)(54906003)(86362001)(38100700002)(478600001)(6486002)(6666004)(83380400001)(6512007)(26005)(186003)(36756003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWAihQUS4nJVYCxPIAaqSzyxQqVCd36C1J91JyojzrZQ2xiHM0e+PPMMvdZ6?=
 =?us-ascii?Q?sxSvoFZjlA0mcBIT/xq2Adja/XeA+7mQGms9q66VRjeuxWGOUTi5lx4SqN2J?=
 =?us-ascii?Q?eaiiPv4ug7CO4uLhkMRKRMX8yFzn40XvWq1jqCNdutgYgTbWheSbE1Qe7DK8?=
 =?us-ascii?Q?T9cUbtiNyXl9ryM5wDZvF0tTdc1x0ojsVFSvNpJ1oqlLRpqzHS6Vs1u70djP?=
 =?us-ascii?Q?8lYCmOJqPRd3vQcOfoGNnXG90MJ3SORLrIIbNwYSkU36vPDa2ht2Dnu9R30d?=
 =?us-ascii?Q?T3h7ZibgW33uWA+SX+KiVETvOG7lfflT6fkLHmmj76sAD2vUbFRWGxmvN/vD?=
 =?us-ascii?Q?t7i8YDgYyWiSWwhI6qjzUQsJy+CUpswOTmxj85+GwWdgGkRbQulbMFBj3e2G?=
 =?us-ascii?Q?LWVQFjJXK5glt4RI+S0svDGwqeH86Mp31+ywD/nnUYq5HRR9HlG7qp2BrHvY?=
 =?us-ascii?Q?yim2edXU3G64wGPVmlKnrYoVinZOp0M6eIUhH2YMMW9MJ9pUT9WHG1dXV4Qh?=
 =?us-ascii?Q?YzN6NUTsBoKS1FrUMuV/gf7oNoSTHPE1/nxCe5F8MXXdJznksD55upm/RrAw?=
 =?us-ascii?Q?De8xRBEvKjkgyRgSU2jhy6x7tsugMbjF+DLF1hH+OJH0B2D7kdLOSEkQsHCN?=
 =?us-ascii?Q?dM7GP8eLWxzFfDRiMKOi15MOhfZ9rM7lM/MaUG4E15fHDcSihB/jXeXVY7S4?=
 =?us-ascii?Q?FNeJ6OfzfJ6s5CJ0bY3tIn9dH5ZWv1U29p3eIns3LFJoilhY637Kjfzus+rj?=
 =?us-ascii?Q?xxDGCgTTjgXcRJvIQOVMVFASLvm/yoMETxJIqBysXEdLAwjimZMSa+qT4bY2?=
 =?us-ascii?Q?kaAtON39m/pYkA8DRFulRwc1hKNfQ+NrLvRKfVIDcV2z9Qfn/h+/cX9S1p7t?=
 =?us-ascii?Q?jS2l3OQXWcBcyRPgrQNuW3DvWhfu0E+i/jL4zx+IK6HfxE5K4FR4i5BAHmUE?=
 =?us-ascii?Q?Pj4XaGm2qhXphskesoBCkZFO7SpeitO+miyDY0ibl1hQX3jqvhICCtgXbHS2?=
 =?us-ascii?Q?DhfEyVJiVtzEOdr/8mMsBPMdMUNqeZKbkSNuB+JzlJv8GiqE2nS0GHVhpltM?=
 =?us-ascii?Q?HogMR7W9HNRE/HTtnN5hOjsb8mJRkRBrgzcF3GUPnF9nBDTqZQRF1ZQE7Fhy?=
 =?us-ascii?Q?42PZPeL76UmV7mokzA+zDvj26HPGuZSAipaAOPfp9wWXHtUX4nqa/rBVvks9?=
 =?us-ascii?Q?B9Lrx8fEYErb4v5nB+l5RQZIZ26IyCYI8VnHG9ndjjHYWOjOfbDKgIEAn2Es?=
 =?us-ascii?Q?MyB5BhCzyTf/2WvFXjEydAXDXMH7a2hsIDLZ74GyPPg/xq8cTws8s7+xPpz1?=
 =?us-ascii?Q?82V74JcE+/XD/ZS6Ts8IlB2RYmQ5P9lfuC6vhMXjnyMsXQgeczElXA0Rq89b?=
 =?us-ascii?Q?405il/9oVhlDL7cbgzhQFjXhYISy1H0k6aLZufb6f/Bi9mC7NOsziTsveH4Q?=
 =?us-ascii?Q?Yr5SzZkXUHnioXFvKngUFjm5SOBl0rmWiPnrCgsix+m2mpHLZdmOx5BfflXv?=
 =?us-ascii?Q?hXkaYy7gilkvEqNwe5ll8HVlbl0h+pUX8Fv+Tdbt3ihW/S/l8Df1dmvmyh5K?=
 =?us-ascii?Q?wum3Y4rGXw797sztzszngyWrwzcrB/jr10WtLepa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4274686-20f1-4041-74e3-08db6e386a44
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:07:58.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KsdnPVXMT2KLF2TaKGbKdu062gQbwG4O7DYQ5BF8RoVCYOmD8NV/xUKEPf3DE7IoFLWsT1PnN9QOdwCQssypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

On Mon, Jun 12, 2023 at 07:36:10PM +0800, Karny, Wyes wrote:
> amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> mode driver consistent with that rename "amd_pstate_epp" to
> "amd-pstate-epp".
> 
> Cc: stable@vger.kernel.org
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

And yes, we should seprate it from cpupower as Rafael mentioned. cpupower
tool may go to another repo.

Thanks,
Ray

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ddd346a239e0..a5764946434c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1356,7 +1356,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.online		= amd_pstate_epp_cpu_online,
>  	.suspend	= amd_pstate_epp_suspend,
>  	.resume		= amd_pstate_epp_resume,
> -	.name		= "amd_pstate_epp",
> +	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
>  
> -- 
> 2.34.1
> 
