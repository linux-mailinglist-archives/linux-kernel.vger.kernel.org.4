Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08930709FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjESTTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjESTTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:19:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5DED;
        Fri, 19 May 2023 12:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz2y/C3KEpr+pprEoDjs+e03OBLrlD3zu1173DotaXP1hpPxT6HDgpmZAcBsabVWJkFZuKsJF6mIwtxRYWz139hghCjTVP8lM8wiJk8knHIoUMxAKkDr8iSYRzfjr8tdUcpzOhw+MS3ylJ7guN/vaPCIOEtXMRAga/NAgsq4lAwH7HCrdTA14M4eFeF2V58CvlTZ/eewo4UrlQtL2gnZKu3QGfTQU/n9jQM3EqEO5iozs+yWcaao70wxnm925KObRJrnjGuXdrffBlXq9d0LbyTlAZ7qBi5At0z/eoksU6JnA/Q71TkTUC1hXldfFU08HS7AcwHQUVg4boxmi4PF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4OrkYlFkJ6O7FcGH9EZKiNZlB6Ae47orp5csS8Ee+Q=;
 b=iLJfde2e9aFq5oznYuLuBlS4UZNUIzqROJEQNEpolcW7wEvlSZXFa0A1yF1qPm4iiSFOO9A+fkJb7hkkrMnKfTYQ42DXH3YBZbS601aBb8tBLHJNnIdMKce6ThKR8sMjtQWst65mz0TAl2ojUJOYcatFank03QlHRJjqW/bgmOdgvoUyzKsIQsc0+q7yXWfIDZgPwdiN5t9PnZ/SseHyaSSmBazEXwKll9dasVh3Fm3oTi1Q9kBAgFYnqoZ42gtuhtG3YJa9STdA9SdT/WuVRvJf5VeJXDR6xKMf0VNWM6HmFzGZtOvERWDX+rT3k+ANzOsXjXfKw2/WkDFgvlFf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4OrkYlFkJ6O7FcGH9EZKiNZlB6Ae47orp5csS8Ee+Q=;
 b=AIRyIaWlMTJ89WKIJF7NoSIGS/CpVm+v5leTImyuO7jN5+6841RPUUBl15DKi4c5r74wzLiQeGO+D9C2/hwRj7PiWHSiSXZY7z1RDGIpVdcJttT6wToXkkXSCIWWdGmVmElytNr/pcH9zPZg499ZFTmdyw4S/zFAvMbs5JlstQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 19:19:20 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::38dc:9789:e0:aef6]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::38dc:9789:e0:aef6%5]) with mapi id 15.20.6387.030; Fri, 19 May 2023
 19:19:20 +0000
Date:   Fri, 19 May 2023 14:19:10 -0500
From:   John Allen <john.allen@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 3/3] crypto: ccp - Add support for PCI device 0x156E
Message-ID: <ZGfLrtmVOcCYiWFW@johallen-workstation>
References: <20230519032414.94247-1-mario.limonciello@amd.com>
 <20230519032414.94247-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519032414.94247-4-mario.limonciello@amd.com>
X-ClientProxiedBy: YQZPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::15) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf14d23-f2b4-4d36-d340-08db589df21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRw++EcJnF6wzWaizMXBuqZgFfqprivaSlHAgb14vUA4KmWOVBNj5v/RO0WV3t9eLZzCP6CnTSIzOisiodKjzE99st7fP1prJj87PuDLLbiUqH1j6EWwSYLqb8b2QaSKU+0llUGhetgtzP5WiqiM/Yx5Ri8ctjgeKgVsDZ3sDgie8A78Z7hYMCj8jSVhnWsM/fCHhOv0VTm5+HC/K8xslp0DS74O6c4dqmjcehxmPu/i+TAhs7mqMLtRi3gPzbL4h6o0A0xDUZxzECrphGLdVSN40YPu4mz27R4i66f7lgplGeK+lEfDiTGYbirKFbdvS7kw/Ltk+kg4YrzSV4Lzs87Vmul2GbPHaNcBHoIUNMof+e2bCZ5Ju4Aj47UxUIRDEHflbVI5d0Jbw1OqTKFd0/2SwkV6vxXaHkXcMVxg4ImRA0o7MkYdbnpmX0OBfQWw+nrPrknu/nr7nTDs5rMfkXmS/coLhGidfn1kmUs7SYYc/mvtinY/hTm2b8aunBEclB5D+9ZtqS0W45ctQ7lw3ELAZwtfT9VZMM3It8jrDLXe8WeaiiAv0uZFKPKkclB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(316002)(54906003)(478600001)(41300700001)(6666004)(86362001)(2906002)(9686003)(6506007)(26005)(6512007)(6486002)(44832011)(33716001)(38100700002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rxv8GyDZBxzis5rONnwt9bwXXtp8lFuNKGb00UqcQbF7Qvb54rFiet8DeLbS?=
 =?us-ascii?Q?+F2QBPQrCUyxcViV6AsNdGBCMpkVHke3rv/F7P2RQ26kCaTXnhBlAB/z/aSz?=
 =?us-ascii?Q?0glHNgg8No4rTOk3SmN2IsfB/9Z/GVFcF9m3Q56G8iKKBF0ZUN5VER9bh+vP?=
 =?us-ascii?Q?Ly4UEHh4DBf49+zOFhB9VfsnOFGDDNqTV1IDevU7HiJUvSIoP1a+Xt4t8/vS?=
 =?us-ascii?Q?waLDY7IBJT2w9uGBYPDwFkBUAhlA9myNzf7nPYXGrnrKVzgZXEbAMpFg5Aor?=
 =?us-ascii?Q?nKICPoOK2SuErb9AEvUL4rN2HhqFGY7U3bbmePwpX6lXEv7MZshnDoAMN0kE?=
 =?us-ascii?Q?asfQZZB9tpGb4MEG8vqxS1tUCiHZvujO1nScZUWFXWei1Ptf2prfU+WhUkYC?=
 =?us-ascii?Q?g0YE6OrQ4QIG2dqLljTq13803Yqx3564PV9zaj4VIEJte96WZ660B+mwaRE3?=
 =?us-ascii?Q?V0zFpMObZ1amXKxq1tKhiHAnFmjih56EFrGEVeruvnu9CYRmAeBdmZAiMC8b?=
 =?us-ascii?Q?xFlUMSBzdsBENBslmxc99zx4B71k7jCRczchCZopjH29d7QDqXOP7DZ/MKkl?=
 =?us-ascii?Q?m35Sirp5xPEVxXAyAllgFotFrpo+2Y9eS0CVe6JaBix0tu/H8NqwW0AC4HHj?=
 =?us-ascii?Q?98SLGErV89UQhSLLxQwbsx+TvA9jS6Yx1nNcBPTYDFHxWga1El+5lKqdEpCm?=
 =?us-ascii?Q?6vZSoMDB9nOG+UdwW8SinijT7u62PK+3CmiwpdNj66s/tNR33JE1pdC1/jjN?=
 =?us-ascii?Q?+cRypHoA/TDlG1GpQTzwdZchUCIWOSZgWq0YKcuxOT529NZhpnDspRAAt3PZ?=
 =?us-ascii?Q?0MsigAIXk3Q0fAIGRgLvfrorbaDk+uQW4dDKy8Vc6I/ncUY5rVfbRn+0i0Wx?=
 =?us-ascii?Q?iTVwbIyk8LSFOZzpLNZ1frLW8cjYYVzB+Pa1N7uw3zuddU1hNKswR4jK+gp2?=
 =?us-ascii?Q?9tlQxRuCgQ1c99Acw10xjSypjNBjGEAZhgS0ROvtQ6ubuvPopyP1kuNpTZyJ?=
 =?us-ascii?Q?cqpYUc966zBxEY/gnB6PiM6aQQzdeuJuYxrM2hgtFiEO3VnynEkzANpFXdYB?=
 =?us-ascii?Q?qyx+bEv63nnMbSBIPuWwti1ERJ26d5g6Q+o38UUgmqisjqCjA04BDwJm1DZ2?=
 =?us-ascii?Q?g6A3DzFZBetR+bxi57VilLyMKk3AwQ4FNGejpIZc+cGKEhXRCCnfeG1r6YKl?=
 =?us-ascii?Q?3g/CqETQgAimDUfDqFWGbYeE9t6JpfoOZ66tU1A+7q2OWPq8aioslPB8ZCBm?=
 =?us-ascii?Q?KN2X9ceY/daaXyMCbjRDXJslhsGGWweMR4XYv9Dgi2tJq9kHXDNg9riGd5Se?=
 =?us-ascii?Q?g0AqpA2A/XN7NIi4e/RvIc5ps6kuV+xnlJD3BAj06zwKd3clsaA6bC38AIEM?=
 =?us-ascii?Q?VoAKcrxCHDs4TtB3gtsQZdti7vMS20vDZjmUHTmU2/Yy4FE8mpSXPPcJeKgU?=
 =?us-ascii?Q?iUO9rSNEeeGBhPxM0m6YLxf7meYLkiSpbUMUCHRG1i2YLNEXv2qd+wF8LLU0?=
 =?us-ascii?Q?srGIgFcJXRUk7JeNB9WKppiacETqXz/uUMlFplkoJ8R7jV0iznJ2Y3CYAHjZ?=
 =?us-ascii?Q?xcPaX45RcydSRzoBa7+DKcOsZZ31HjxycHTeAVaE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf14d23-f2b4-4d36-d340-08db589df21d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 19:19:20.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+tjXWwK8M3XCOQLEVeGSvR8souhi8WT5LndWMpp7Mvvb3Gv/nJJs9WJvIia7/CzQrMRJ3PLnmpxZ2zwprXBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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

On Thu, May 18, 2023 at 10:24:14PM -0500, Mario Limonciello wrote:
> From: John Allen <john.allen@amd.com>
> 
> Add a new CCP/PSP PCI device ID and new PSP register offsets.
> 
> Signed-off-by: John Allen <john.allen@amd.com>

Hi Herbert,

Please hold off on applying this patch for now. I need to do a little
bit more testing.

Thanks,
John

> ---
>  drivers/crypto/ccp/sp-pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index d0d70af0c4c0..b603ad9b8341 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -420,6 +420,14 @@ static const struct psp_vdata pspv5 = {
>  	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
>  };
>  
> +static const struct psp_vdata pspv6 = {
> +	.sev                    = &sevv2,
> +	.tee                    = &teev2,
> +	.feature_reg            = 0x109fc,	/* C2PMSG_63 */
> +	.inten_reg              = 0x10510,	/* P2CMSG_INTEN */
> +	.intsts_reg             = 0x10514,	/* P2CMSG_INTSTS */
> +};
> +
>  #endif
>  
>  static const struct sp_dev_vdata dev_vdata[] = {
> @@ -478,6 +486,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
>  		.bar = 2,
>  #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>  		.psp_vdata = &pspv5,
> +#endif
> +	},
> +	{	/* 8 */
> +		.bar = 2,
> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> +		.psp_vdata = &pspv6,
>  #endif
>  	},
>  };
> @@ -491,6 +505,7 @@ static const struct pci_device_id sp_pci_table[] = {
>  	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
>  	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
>  	{ PCI_VDEVICE(AMD, 0x17E0), (kernel_ulong_t)&dev_vdata[7] },
> +	{ PCI_VDEVICE(AMD, 0x156E), (kernel_ulong_t)&dev_vdata[8] },
>  	/* Last entry must be zero */
>  	{ 0, }
>  };
> -- 
> 2.34.1
> 
