Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BB75E698D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiIVRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiIVRX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:23:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7D10197C;
        Thu, 22 Sep 2022 10:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEVC0E5JHPQ8XEM0NopTpKBmpkIRGk/2sUw3B82Y8VklIF2ouzugP6YChjjjii7qWm8h9e6FhDrNacrM+UGDC2ec601alzqeGbcA0e7iw/ZlvoIPd+ZQrSUOLKacsUtubVskyqMhPO4wZUU3MK1+r3GVqCSg6xxtkaNOJRDBlFqLFebP9RFKLKWDEXfpYL2wrBxhexLRkIZBoDMlOfWK4ugjbVV1XMzDClSk0vqoXEO9rJLUtK86kuROeZ8cuP0pzkX3a46mr+454fU0sSkjBqgxIhvDmwH/rZdLpL/KPtBOevo6xFgH+R85gtTIXsbtdpThHTZSPNMZfWWJgJIl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBLB8aNjWQPnDF57C0vyOusLyESTQ0by1Xi8mJyd0vw=;
 b=mmXUs/dj5Z88mdXEtbG/zam8Lm+elANqoCcdBofyWEAQjrDxIB1G6kSBAQAbJXHHYRzP076WEvm4Yuvs4cotTqnDQTO74uMobdTqQ1YCvO3HZm4Bx9eq8oDx85qQ2nymjuP0wbkLEBcvZaxZWK3eAjJXjlOMHRAu9/A+2nmQOYY0l3O2W2Gz+ByGqrkYFbHfh1lJ6ci37mf9sdlczikEybCf2Wss7e0Uav88CMyyDml48dmHq4fyQx8F6kQACgIHgJwJ8fJVSBUNc/F7U5dUZwm+Gb/U6fiaO3kSbmWu5PNR6zV0BCm+kQ47mSpf+izkdn9iKwfZR/WxUx3rWxRDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBLB8aNjWQPnDF57C0vyOusLyESTQ0by1Xi8mJyd0vw=;
 b=ED93GN3x5JdB/ehwypZ7dh7IzF+xkGAWwfvUqQD0SsxgbGz6k7QcKt9aytBEkfK8tREC1YNyIbeOY2wr7N8s15/mdlG6rhtt9P53JySp1+PL+HhJ3jQGlM8T1SY9T6wXGYTMtvPb+WwUaAcaqMipj6+gvQ3aV4BeDZCrUntG7ElFdh4U89UCI2/QOx9h+P9gB/SRT+n6rT24/PK/LVd8aq77BLQiRlBu3retqziyPl79SbJ4FMHLQwqGAqzOPCle2M84wsLaPHoOpUNezWBEdR3VPTUc9TikcRpu1ijP43/IEiWf1UhjG2hzdNrnad9B+gEZxnFM82nr9ZxROYE7pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 17:23:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:23:23 +0000
Date:   Thu, 22 Sep 2022 14:23:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, sricharan@codeaurora.org,
        kevin.tian@intel.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] iommu/msm: Fix error-out routine in
 msm_iommu_attach_dev()
Message-ID: <YyyaCoHC95yyJpOK@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <23e009bba72c3e46320c59acefbbdd976111cc8a.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e009bba72c3e46320c59acefbbdd976111cc8a.1663836372.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8080aa-2622-4a46-0230-08da9cbf2732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmwXIrU6aJ4ZG7pr4hZR2y47huNgGtgnRrOByb5WbAQ73gXsj2cfLNq9RjjAuyoQKKddzaKhZ/Tas25yKbX4rwX/G9XGKzYOVh9+UD6Q0yParu0dDacaTxeb/QD5vqGpHYtizpjkCEEulBmWB1SSTDx+ax3i6iY57NECVWJI13cFkVTK3iBGIHcdMvVfwF9v3bV1qjl5FmU0+tr+V2YHpdxJPRvkpCBSKxDEpG/+coRCzj5EuThF5knbowDpuk2KZdO5o5jE/earxEoduagrI56ZQvfYfTVvD5/8bvGFD1r3Jy7MbFgW45sM3fLCVXwPKiiQzrVklOOeOt4nwsw2OKgtzmooJOQFEBIeuygE0TypbagWMk0Bohz9Po+QrpU3IRScEBSsUyP6DcREfikDw3l3M48+u3vcuOd8pnCP31Gub0ZPF2aE5Va4BZK+WDNxPxSO8gvil6en9hj1BJ4dMor05FIXaFY/Ks4ZXGQEcC9jGohFXwqWEtpulXJVbgcfOMO0x32q3RU9S0CHLD2zLDHUMYvBQDdKvrmX8ae/dhIJCnEP21Ygg0drNflvs/O9+AObsYVWwG35PBHoOTvxs45anozsH9nilWO76KBgquys4OWdd1OKW397COYuGWgTa6/abuATudMVqZ/YXUpcq74XEttsTTjcLSTXNGeTr8Pvu2TUHMZ7ZbtfUOGulaNRbd4UKiCuwDD0/zRkaNPLrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(66899012)(83380400001)(86362001)(41300700001)(186003)(2616005)(38100700002)(5660300002)(2906002)(8676002)(8936002)(316002)(66946007)(37006003)(7416002)(6636002)(66556008)(66476007)(4326008)(6506007)(6512007)(6862004)(26005)(478600001)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NguzxU8cBBsv9c2hTfVIXSCsRDaJ2gw1ZMq+yGd35ChUYSEJLjOPW74mXlo1?=
 =?us-ascii?Q?n/r6Zz+5WL1r1260aW8WyKCwIpTaWeUopSiPGBbKxRG5/aDhaB7+93DCX+Oy?=
 =?us-ascii?Q?uXqHQ/o7uHSxjqag6AehOWGLvYzX8RCmG+/7N3UV+nxzVm3DjpyHds0BhAbN?=
 =?us-ascii?Q?sDJLVPyQCNaNRbZOOm+CDopec1Z+2EpXt/i+bc9r8BPVK0wiyz4Vk5spa/w9?=
 =?us-ascii?Q?5QjVu+fFftSejvl6iz96BC+rRrR/kh4gy5m8Iig5bB9IS7J0k9qH0jozOn9b?=
 =?us-ascii?Q?PB/T+oxFexDb1UBJIsav6h7GKXXkDVDcrk2IIdqrfT3Ke1lrjfgwmklCDpUA?=
 =?us-ascii?Q?8wh1SgsXX427YCBs3/eHlhg2rNUhs4rrwH5Rtb8bQiN7Fe2k/1cti+tSfY1x?=
 =?us-ascii?Q?DjjjQN30QN1f+tzkO0/yF8Wy91L8b2LGiBh8GCGqlB7CgQzUdiY7sH9MkXqq?=
 =?us-ascii?Q?4FxNyZ8Y9GE9cJITXp5XD/dkQ1/P0G1OaPejYEg6jxZ+q0fLtLsW73u3v4Nv?=
 =?us-ascii?Q?E+0GKqMGIfHZOL/fAESIPB1IfqPj3L4VTbxPHXsRu3mMD2AzmNSdk834oZjR?=
 =?us-ascii?Q?R9fWUVc8+yDK1YsGYEKDAhjDWkQhXoUKjShMJ3EyK25Z4GuwVrIA+1hvaoYI?=
 =?us-ascii?Q?p66Awpy40CxFEkdg8QHGDraATAm0AQ5z9LqgFredVOO6dFHHIYjLdqRsyxsq?=
 =?us-ascii?Q?OHCw5hhYpJNX/kbKa6KvXrnvc0LDUNuECPZTLEh7mIQAc/f3xt+rMHV/basC?=
 =?us-ascii?Q?yBuoKGeVcnyxM3YJccuT+8Ku1q9EteeFFSjACEZXYLMc5wIqr68EjpUot64j?=
 =?us-ascii?Q?IHoUXyTsFZ5UZk0s4lb+S0eAh5XL0m2hTfC3agp+keX4L6rIMinXo/ZmVQ1r?=
 =?us-ascii?Q?ifxVNGnv2j/DQhp//7cGo5gcVK3oxI/fORad6hthKUky+KsSjVPydSz+MzZx?=
 =?us-ascii?Q?Yxd9n8nbksBXg33gcSWfh/AozxmJAqz/T1IH/wTtOJnU8hdil5k/o0Guc5us?=
 =?us-ascii?Q?tkmbHqx+X6zBOn3Up1NmWh3H/dKc0PBib4dOQUlhoc2e7NozBi4sTMQns3K1?=
 =?us-ascii?Q?TyW85U2Ezx9P89WKylPluUxXE8oQ9765LZVl126qkfOXsk8tP9lfB4RCdzM/?=
 =?us-ascii?Q?cPQYT9Yb0z4i/XKbGq8VI17Wtgja+W24KJ97QlJ7PVdvxWxDJwTdCZ4I0dNA?=
 =?us-ascii?Q?ugj0R1kaa3XHHJ2eK//OD70k7Ln7dlS5DGAEcow2+I7jbhU3nr5AuPDrcLvo?=
 =?us-ascii?Q?xg33t1jEVNeWeagi0MnCcA2LU7rrkGOReA1mfQ76AXsRyP3qYFK+37RlYy5T?=
 =?us-ascii?Q?jrb5wzJvn2OR5UUyjd/+bTlLccFigAFslT8tB99tVXJWP7oNVlKw9SqTsqAm?=
 =?us-ascii?Q?yJHo8RkQda0FgEr1GMHVGXvfVFtgyiUa297/HdnVxjKTZPCQSonII4+n8KZz?=
 =?us-ascii?Q?fwu3PhoRtCVseO/HjwWqykox/LHpUfZy5cb3RYIwW/ZPMTgZbdrmZwkOsAnT?=
 =?us-ascii?Q?pQbcSK9rqy+fT0svlkaaW9cNH2ChtLx4cGR03MX7DP61T5pm/FApvGMdkjWv?=
 =?us-ascii?Q?J2sY7rS7CrTpd9ksMGi/gvN04d+kqciZOayqTKoj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8080aa-2622-4a46-0230-08da9cbf2732
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:23:23.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYJvcZqLiTt2BmlfxOzg1IMmXDGaQMcTWEcydga7EeYn42Tqws+F8NYTEqh8ksMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:53:44AM -0700, Nicolin Chen wrote:

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 6a24aa804ea3..14df722f0060 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -394,6 +394,34 @@ static struct iommu_device *msm_iommu_probe_device(struct device *dev)
>  	return &iommu->iommu;
>  }
>  
> +static void msm_iommu_detach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct msm_priv *priv = to_msm_priv(domain);
> +	unsigned long flags;
> +	struct msm_iommu_dev *iommu;
> +	struct msm_iommu_ctx_dev *master;
> +	int ret;
> +
> +	free_io_pgtable_ops(priv->iop);
> +
> +	spin_lock_irqsave(&msm_iommu_lock, flags);
> +	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
> +		ret = __enable_clocks(iommu);
> +		if (ret)
> +			goto fail;
> +
> +		list_for_each_entry(master, &iommu->ctx_list, list) {
> +			msm_iommu_free_ctx(iommu->context_map, master->num);
> +			__reset_context(iommu->base, master->num);

This isn't safe if the loop in msm_iommu_attach_dev() exits
early. 

Firstly the it leaves master->num set to -ERRNO so clear_bit will
corrupt memory

Secondly if the attach loop gets half way through the remaining
entries have master->num == 0 and so the clear_bit() will corrupt an
otherwise valid entry.

Fixing all of this properly looks like a big deal, I think we should
drop this patch from the series.

Jason
