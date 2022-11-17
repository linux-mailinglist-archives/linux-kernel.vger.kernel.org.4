Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963762D4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiKQIIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKQIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:08:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5E283;
        Thu, 17 Nov 2022 00:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuvE5PJJoA8sSbNlZbo7KisywFr8folID2QAVmOUpfqaLX6VbuhKLuVYHKXEsevBLG9jaZn088eev+vhlnJiU895FBubBsim9+4BZBqACpvZ3H74F09xaIALn0G/BW3zhyRh5QI8KNPgfhevbMYDJJ3ozwozmb2NRVgtumNYq2ukK6ProBJaTO1T+T4MxmsCxHSa1t37ChV7XN2jFPdsRSiVFHzzTnCdgIwjA5nHe3irDCL1O4Xvxd3FwvsVj8D7jVs8WRfhXCnc7D1zRAe6IWmXwMbMUO4R0xu6ssJ5w27bSfwwuYSg7DeKC8J/2vbyraNxWNciyNYyYNdviyTyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w2WGY06Nnb3CIUzSWFZt1B/scORXhuDWsm06yvvvDc=;
 b=JjPvGzb2u5YlSymS2iUMbaYEg0Rckv6IshpUy7Uy+VJ+GZ7NiviGGukg5RWL2rfXYfLBla+n8ES0B5JskaQ1Jnzy9ngb5yAkNz62FKeY9rId16FPm+PCy5u5LvaywrJVhagxP6+PMfGqwEnzT9JV75EvO/NVe6F3Edcm9uNcclIycrGtiMAMdEcN2/r+cl4OeNyE0h5WR5iyuMEyY0JDWSESSC7P3jFUwM3O/6NmAPv07MDcJNWahrdaGLyh+FSFmA8fsMFB+8ztTYs9w6U3hhzYkdWsXZ9p0c8W2ve3vHpRYsrLymIPl4QR8jCqynjIkcJrgsTheg1yPZNQjsYgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w2WGY06Nnb3CIUzSWFZt1B/scORXhuDWsm06yvvvDc=;
 b=H7VWnkTFlHrcV9xhtb56PCbHOtUtudH6v9zTHXCAsF1QPuh5GCRafly/FZZ6mAHQexyKmw0tgpRvup/V8B1gbHQ4TgsLRIRJPrFpXefviqgqzZQLAgCfN1tb3fzBIsvTG1yxhQC3RJ73Gq3waDUgZJd7+jcM+UY4At2rdAQnee2Y7M/up0OKRlMoyiymPEmFyxsUltoUQQWk0MhsZ/d5JzwXaxTQgktfhGkOIZJZan/9CyqgUNrCfTQAA4CgidzXyvrpUr60CDbmQbKHI4mhZh4Cf3LYLZRO6fb2GbNpI7m3vG5mrD0KFrkSM9qHjLFdZ2ZBc4auu3NpXbPptVtvlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.20; Thu, 17 Nov 2022 08:08:23 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 08:08:23 +0000
Message-ID: <730be246-698d-cd77-99ce-835c85bfea90@nvidia.com>
Date:   Thu, 17 Nov 2022 08:08:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: tegra210-quad: Fix duplicate resource error
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org
References: <20221117070320.18720-1-kyarlagadda@nvidia.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221117070320.18720-1-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: d06df2d0-aa3b-4f94-c722-08dac872e5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYFNmYCZFcZreV/W0hPmkakxjmg66ZNpELn1TP3NNPWiEkrhjl+QHYwGHqq23gR+ROeZhl4xN6N2mFyY9vsHxLEfRF/bANai6HmGp/ULrk7/+EO8xL4md50JBphCxCdQ1r92B6y0a3bwxvrz2xd6Z2KQe4rnFpKoZRzitJepXypG1fGPre3Z/PaiISPRMpsj3pXgqRE9gXVKV+G0AnEdh+kaWAvDe4QCH2u3h4cCW9yfczSG9YUHPdNqvLIQnqdb2N5zuy6Yw2dkdL6Gn6AyKqcc7eQT8OJFTlTSiGKS1a34hSc1UzVbMsQ3/5S5ypLenvzY0xex+Xb1gl8b+iXJTvN6LALiMn3Sijgsb6/xCtdJv8ZiR7CTjceEwvbVr4wMpAg8mgGVRhnLodT3iJ/usg6AbYVpq8K05Ay4WdCI/RT4pcYUyVxEHFM6DAy2gsai+fqj9aG/nWucVSPC2qulChLrOAY9j4JntHasZ5XtR62/RPTaNF61x+S2jgUY970Ur5ikIbY3/HiJMQPLYK1oMidqENWSCPdWv7rlYMPB3HYgmjObJYjh3vMJV7Ty3nxD5tBrVYPoHBIzLdhX/8ceSm43VPnYsC1FpNEFL/OMp9JCAxmstLRfrXoXK3uU5Iit2UgClfTprQ2HxEzuCD1jAuxZWMENFTzJ2yfhXrQt/u2TEXWyvCPxLoIQvelCWNnYfFMd4Tkg4As321mRGSYbtZgEoTHtnQH52ul/LgZxAkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(6486002)(478600001)(4326008)(8936002)(5660300002)(316002)(41300700001)(36756003)(8676002)(66476007)(66556008)(66946007)(83380400001)(38100700002)(6666004)(86362001)(53546011)(31696002)(6506007)(186003)(2616005)(6512007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05CUHBlbEgvSzlaWlJkbU1kdEVuNTZCeGxtdlB4ZVAwcnhGM3BTWFZkTThy?=
 =?utf-8?B?U1Zhd0s2T0tTTjRudmMwK0hLa1g2Mll6eXJWeGMyZmFPTTFjcVJlY3JSd0hz?=
 =?utf-8?B?dUVBUW9BNmkwT3NRT3ArNlRRS2ZnK1lJbW9ScnNUTkxuWXF4bU5kdFY1aTh0?=
 =?utf-8?B?RUkxNTJLbGtZby9KeEREbGhlVGlwWGY0WkNSUHYxUUxpdk5nN01Na0s5R2Yv?=
 =?utf-8?B?YzJoWGd1NUwvR2YvSDFGUkg1WlUrR3lRTUZnN08xMFN2eU1CVDUrdW5yNlk4?=
 =?utf-8?B?VDhwT3RXQXlrNVd5RFhjc09McVhpUjVpblhqMjVBV3dUMCtGUFkrd2t2dFR2?=
 =?utf-8?B?UzA4ZE5kU0ptRVp1L2d0dG5zVDN2UUgya0h0MFlNeXphTVcyZDZwRXgrVjZ4?=
 =?utf-8?B?OTFXcllhc0dnbFdYSkt3d0M4UFFtSWRkenJBQ2x3eDlUTTYvYTM5b2NPOVFT?=
 =?utf-8?B?U0NBbGJ2RExnd045KzA3a1ZvNlV3Ulk3UktSMnNGRjJzL2NRa0s0Wnp4S0NZ?=
 =?utf-8?B?M1JUd1JFS0hoOGF0NG9PZ1ZkQlBEUTlPZlRoRVYyV2ZQeW4veDUyVlhISW9n?=
 =?utf-8?B?YkhRL2lyKzRRVlQxdG5KM0U5eXBlU0crcGtESUVRRDV6RElOaEZ6RmNHYjVx?=
 =?utf-8?B?bC9JOU5CMGNrNmhOcU5jdEtEVndHd292R2NLQzc0eVJHRnhrVFNHRHNqSTA2?=
 =?utf-8?B?RFhGa0FJaVhJUTdWVFhNY2JMSkJLdys5Sm01UFVFbkhEdWlRUjgwODNDMUMz?=
 =?utf-8?B?dFpHQ1prQjd4RE11NERBbngyb2x0dFpxRFIvd3ovMVJaYUpvTGd2VGtOS1ZC?=
 =?utf-8?B?N0lsN3RVbTJmYlpRaGhDRXlnU0MzdC9lVEdaZHFmVEdKSWlJcjFKVS9GVXk5?=
 =?utf-8?B?dStETmpLNEV4eXVMczBHWkVEemJLdjVMejlVVldLYTBxM2pBSlh6aEczOCtv?=
 =?utf-8?B?VVFiYUhXT0ZkVkRZWGpSS21qZG5UaXNmS3hGY041QStaZSt1cExlTHR2NzVu?=
 =?utf-8?B?TjdleXliSzlzZDViaUEzNzN4VXh6ZldGM09BcWpCc2Eyb1hlY2xWTEhnUE5Y?=
 =?utf-8?B?Q2tMcUtIOXFOcFptRlEyeDRLWE1LMlhyQm1EbHp0QSszK2U5NjFaRUl3RDEr?=
 =?utf-8?B?Q1FQV3lEaWpoaDFZZk1OT3BpMkQxc1BLY1phdExlYzRkRlhzcy9iaDFmc3VT?=
 =?utf-8?B?eVc1NmZzeE9XTU1McWJ4L3BhWEtqR3htWWhGa2dMZmJ2c1RNSC92YmhaZGNM?=
 =?utf-8?B?bk4zZ3FRbEYxSVJHWUNaelNaQ0RqSlZmaFY4RU5RaSsyZ01XVVNBNFlicFJi?=
 =?utf-8?B?ek81QnZnaVF1QnVldGlLTENraTVCaWxreEhmcG1nS0JXNENXbmZ6VXRqTlRK?=
 =?utf-8?B?aDBJT0pZR0l6d1hzOER1bkNrb3F6bDAzaVZET1c1WGtxUmxHZjc0WXFEVkpa?=
 =?utf-8?B?N0hBcWhPVHFEQzZOL28xMk5zbFNBbDdpMmVYZ2xqWlZOc0xwQTM5OFFEcWF2?=
 =?utf-8?B?VUJrVmZYN082ZlJaS1d0THhJR3FWUkQxeWNFMlRUT3Jlcm91WFYrekhDVVRO?=
 =?utf-8?B?SXR4a29OZEhORUI1QWlxUG1OM1I3ckU2RHJWZW9pSUErREowdEJ1NXdmZzBS?=
 =?utf-8?B?bWZiSmc1V3JiL2pScGp4OVpXNlBHOHYxdGlISW1QUzhUUDFRcTJJb250VzZo?=
 =?utf-8?B?YVZ1dzdZMFJXRXhaU3l5cnNYWGxTdGlQNDBnbzRNOUx6RHlKQ2NaSHlXV3di?=
 =?utf-8?B?YVppQ3NBY2NpTGNMN2N1WkRjY1VwWkZVTi9QbW9hbGlaVURIWm52YnFMMmdt?=
 =?utf-8?B?MUFVQjhyTDVPclNsRi81empFaG92ellMaWNPTXlFS2k4dHI5djNtN0g0WXJS?=
 =?utf-8?B?RE5iV3I0eHRKTEx5Tm1oV0drTnJ4dlplTzlaQUQrKy9rUk9mUE16ODJGTXBx?=
 =?utf-8?B?bDVPdDdUNlYrc2JYU3VxTFo4a0VkcXM1MllOS0I5SlFPVDBMdUZVS3oxOXZh?=
 =?utf-8?B?K1ZwTFI2elA3VmRpMis1RXhiK1R5R1ZML1hoU3psTTcrdVFsUGlEbHhXNWZ4?=
 =?utf-8?B?N1dNU1VKUFR6UDVQYUxMMDRXNzVpYTM0UWdHdW9kaGwzbG4zWFpmTEJTbmdX?=
 =?utf-8?B?bmM1bFRBckRmS3JsekRGVy83L3ZLL3lkRDlPNmRJL3h4TVZtWWNuNXczdGpr?=
 =?utf-8?Q?knHLKt07jIIdqCIUvMCuSUtlnDxqPdfOBdQ0vt5azbzW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06df2d0-aa3b-4f94-c722-08dac872e5d8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 08:08:23.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrUniQrU9K7C7VgXe0MQDihneOzlJdJ32BuHEgyNxbChxROtmjLLSTSqGnRKfBPFG/GKwdHzybeRSB9SZOm9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/11/2022 07:03, Krishna Yarlagadda wrote:
> controller data alloc is done with client device data causing duplicate
> resource error. Allocate memory using controller device when using devm
> 
> Fixes: f89d2cc3967a ("spi: tegra210-quad: use devm call for cdata memory")
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 10f0c5a6e0dc..9f356612ba7e 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -924,8 +924,9 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
>   static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
>   {
>   	struct tegra_qspi_client_data *cdata;
> +	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
>   
> -	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
> +	cdata = devm_kzalloc(tqspi->dev, sizeof(*cdata), GFP_KERNEL);
>   	if (!cdata)
>   		return NULL;
>   

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
