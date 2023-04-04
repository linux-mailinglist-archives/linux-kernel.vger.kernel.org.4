Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7986D6064
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjDDMbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjDDMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:31:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044810A;
        Tue,  4 Apr 2023 05:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSPkmzGlqt1XU1eZ1b0PRrbPWqC2rCztkrWEtxGct+QhoahLn8xr0d8+tvRm5eD2xtdheqKLUnYIdMa0IFmk24fIGqkiZJ2Vf46oX4L5QZ6YSh1PSUe0m2JQEmTX7yeuP34wz3EeLDPUV3VuAWqRTpLvokkZf8qEcr7/yZsKc2naf8xf49oRj8B384Pv91ifz7r4/UqGRiB62dSR90kgPYySyTI1ZbrKGkCL1VmokhryMr3TmO/TgnaOfJHFsPRsSDUEOXGpCXFdU6gTL+aI9oekVwDvcD0Md8gDOjs+3KmJdWwFIf4n2XBOnT1rXj9DP1SkQzpD472/AJ0uqZ2MiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9JItELoRpLy6qUHJKtH1JaluE/eA0TWvuhJqnnGnNA=;
 b=j7eecjv9OntmUAL5aT+KraWqz7qhvurN/eElE8JGvPR0BNVccDvuSoBnj+BITf2qnrZEhr2EdBOdZcua0L+GPCj5hR0bt5UUlNDrHjFaQA4Pkan8M5X28WavxrKdbdvuE1UXY6qZa/MhsXpKsDFHBSgoh5LQhboD1+rZ0c6JfRooXDDOY6mxj7nvgSJP6tOcKhJjZtMBX6wBMGaeU0rBg6kXeplyzXZHSxsof7ZUxS+kA9R7+dKmURBgJ6RWIJ9X8mO/I+4FPi/VDAquMHp7xZefG5iaNFpP9GGlGaqhbQfmoqHvyNcL+lr8uKkkUyAbK1BV3jDimRoF/Et4Uhy4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9JItELoRpLy6qUHJKtH1JaluE/eA0TWvuhJqnnGnNA=;
 b=Gzac0VtRS2Ffzaod9wGV2fXWW7G+iIwAdIj4x+O6kXvId7Xc/FSFrGnqCC+VETvHLc4IiPj33jF4MwQcerO3p+CvGmYph/EWOS7/kB+33XIxwvm4+gAxVBOsxDNv9Xp9obmeq4ZDhuaHWtoLLC5sKJ2alBYCkbweaecCkBpVGHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 12:30:29 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::d1cf:3d4a:4882:7fd3%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 12:30:29 +0000
Date:   Tue, 4 Apr 2023 18:00:15 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Tom Rix <trix@redhat.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd-pstate: set varaiable mode_state_machine
 storage-class-specifier to static
Message-ID: <20230404123015.mj2ya5jhgsd6wjnq@BLR-5CG13462PL.amd.com>
References: <20230404003337.1912901-1-trix@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404003337.1912901-1-trix@redhat.com>
X-ClientProxiedBy: PN2PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::28) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3e0766-fa70-4e4a-fc42-08db35085fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyHw1HYnJfuPZHh+J11x31Z9sporDJAn2b2rXcqELdTaKyUcj6uWR++7woBkv/H/YrjzYdj2BX0UkkIAVLFJZfwx61/niKGAMhtXwP5v7jj+OIZfZsEFQ7sKU2ycWuDiaVVTFjqCBpoerol3KJurtdQHJ3Ys8Z8gc8C6Z+gPFZko5eXdtOdUhkUNBpSrCsGK9QUxWxRzMSz+f/ZtXJPdBuBqEFXJz9PrQct3oRIVDSi0PG9L0dOzH/Ldu8ahL7Z2XHSNdqXXfhFugk24l9GXqBZslXZnoD4QyGk9ncd9RqAb9ZX5iaZo151mkqNs96FKzNmvgWKi6PjFyLKO+WBFH/xu69INGKmPcGqi+gHQoJhRnt5wOQCGi5kXB9TDKiN+40UeUK0E6HV/l5d/Spat18goKSOH6M6mnyyooHABcpKq7ILgAYNt9KJbsbWufu50beM9PttN1cR69wzTFgc6zkPlfAjA79tiqjDxf5S9B0pQ2I5GtVKgWtwjYZvxQDk28167Djl86BP/9lj6nRjO3Xs1mgtM7F/iS7mA0ICpN98QBMx49YH5ovqC9X0kio8V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(6486002)(5660300002)(478600001)(6916009)(66476007)(86362001)(8676002)(66556008)(38100700002)(316002)(41300700001)(8936002)(4326008)(44832011)(186003)(66946007)(6506007)(26005)(6512007)(1076003)(2906002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUdevjeSTMdKyRPemmazfapw/SL/CQOA7I+mujgzfTdEvlWxxbaROrrudElT?=
 =?us-ascii?Q?JkVJW7/WBK+opJ7dRqRAAAKgL9FkXAx3xzRUNYaXGx1wXloFoquvJI66YbTE?=
 =?us-ascii?Q?5rken/RNgXq0gt8PxN0qd5fLJSk8ds6QldlFQ5CL3ng+zokvk9WkNTb7ieh7?=
 =?us-ascii?Q?A/lKXqbvoUjxxqt6PXis3pIML7GK2/S/7exUvhfC8jvjzxAAMbj9Me3iA9eN?=
 =?us-ascii?Q?1kGl9D96aV2jgsl2BxaIfqZtVKYdzFOIJzpnVfl1XN4tOhz+18NldMI2tbnB?=
 =?us-ascii?Q?pnzIicWO3lYz8noQcyKpEFDqu26ANbaXTpwbSdz9dcbu7jDo8sIwFJFNPNkH?=
 =?us-ascii?Q?gORyUC8wggK0Ve52Jf7FhXZnpwg5RnUk9Nb92/KWQeQ145nDAjTyQXJmbnHu?=
 =?us-ascii?Q?pOKecNn5wtXIvsm7pTUdaFq8ZikOp03JSBc0tLwGMt+2UnQh0iKeQ1eufH6B?=
 =?us-ascii?Q?a1HTky8lgrw3k4M0j3cZAKTQp9EiC3CKCC6abO+t994csegj92tXAt6QIcJI?=
 =?us-ascii?Q?wwHYS1eKjUTtM+Z5vZw+zDG/simf0lyJ8BeaIUK/VMUeHtVtFyMMr+MWQLXE?=
 =?us-ascii?Q?YsMYKHu9cJkyWctrMqp+V9aIZx3upxZ7/nMB0B+z09Aw1glqR+lTcPiP+BIE?=
 =?us-ascii?Q?Vo1CCmpkaSBWyQTbRvRCJ1uyLZiDCpUX+VZ8LwIeKlEhjgUod9VNqncUYxAb?=
 =?us-ascii?Q?8iuYzeDAGebZDgY4ogJS71cCM0yrz8EPqb6efeTqSvusmkLOew/keWvoy4ma?=
 =?us-ascii?Q?MgIvM+IdcM6vipa5c0Z+MCQ77NDZqdqbL5Ni2nCERNL/w8tJJ0l9A0X2svSL?=
 =?us-ascii?Q?j7/Ol458+AprhA5O1QxhoKWF80VkN6JeVXw76twGYdmuzKcE7OZeuMSX0hep?=
 =?us-ascii?Q?Fb9Bp9Vns/rBJAnOw+pQgf4cCyeIJO2skL7aEPfSaRL36vsy24Qd/Nv5iz2W?=
 =?us-ascii?Q?xBuJCMaqazZhZ5pTsRmvBzS95IEt8vC5UT82L57QZ6ptFI63bArQwkDeLpQc?=
 =?us-ascii?Q?J+5lMCF/Ylndk9X9+fPl7GqYuK784uz+cbLuf0toB5avT5c2xwMI4/ZNpnIR?=
 =?us-ascii?Q?jJZI8F12MhcEn3hosGEAu0GgFmC0fEs4yVpKVU6Z2ytpMuYLIZ31hM9GX08O?=
 =?us-ascii?Q?6NtWI6tsTP7DlC/bfR65Ml3fe9uL2kLA4phIXzG56noogXJHmJYIzl8RXHh7?=
 =?us-ascii?Q?W7mcKD090KEZLSUa9xLnh6ZIttKLXZykHT+HKceQu/l2mNkKi/XIpT8p2zDF?=
 =?us-ascii?Q?5f6p7SzM9uaRQ1QQvbEBRlo484yVEftpiPtyjndfCJdjti+eZIFV0THzL6cS?=
 =?us-ascii?Q?kHckaH2dbomhbn7pMspFPJOi1KaCKsT0xgw1RFIElw7ufeSWna5ts6bvl3N1?=
 =?us-ascii?Q?HpiZnmM2umJFp47/0lwP8zisJTV6vyh+e1lOPHtFiTMpGSK+H+tsgYagiig8?=
 =?us-ascii?Q?oxXQmagHlqaTzB1YZ1c2kz0q2J3rjgmPXOoimkhsGAPhJVGZIzT0bkVOeqXM?=
 =?us-ascii?Q?ir1zfQtGrBFzDg3BoimOESb7eDq6yTOOj9ih0wpYyMKq+r9Kc7UhuZsgMnie?=
 =?us-ascii?Q?yM2NLMOGBLsXUjPXTb73/zst/dr60FucmKEMv7ST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3e0766-fa70-4e4a-fc42-08db35085fd8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 12:30:29.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgjRUGG7LCiqcVVxYZ3aP/2em7saKvJZ4wRpznk0Dk4W2KdT/SKARuIhZy9Gm8jfWr6Ww2Ibwl1MyTOGuG6MQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Apr 20:33, Tom Rix wrote:
> smatch reports
> drivers/cpufreq/amd-pstate.c:907:25: warning: symbol
>   'mode_state_machine' was not declared. Should it be static?
> 
> This variable is only used in one file so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6f4b8040d46c..5a3d4aa0f45a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -904,7 +904,7 @@ static int amd_pstate_change_driver_mode(int mode)
>  	return 0;
>  }
>  
> -cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> +static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
>  	[AMD_PSTATE_DISABLE]         = {
>  		[AMD_PSTATE_DISABLE]     = NULL,
>  		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
> -- 
> 2.27.0
> 
