Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37CF68EC78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBHKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBHKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:12:17 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC4E31E02;
        Wed,  8 Feb 2023 02:12:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlhQB/5ESikmEBv/5DWc0CSq9AqXj+CoJPirsvKQ9hFrhFgkPb9N3iQFDzvffeFq6Pe3pYnKiG4Z+0WXAYxxbzMn0/Z5TPyyhdfaQ26h6rKgXO0p4w3rjnGXZj3dg0Sm84nzdvR6UM9DEne6xGdFk3LY78en1zO0Lf0rRgYJOssgBmEIeBy/Jv3YkACOM6q12rmT+nr6+Xvrh6QwztPO9U0kHp0l5Mtf2Sq2UMKGybikRcpGMIOjuzzBAeXoKoCaHt4kXpxIlj/0gklPr1MTS3pXVG/paE2VCfIaiCun0YPO7BDyiVmxtxhhTb7OCuFslR2SLADAOGZEeQmxhYJOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrbTE+iX2LaBOPGFz4155YxbeYn1wUCvThi6SAWb9w8=;
 b=ej0Er1TVietGKgW/Ftc1+m30KJroXGTZdR9Vq/OlogOOPp+Rt8lJ1bwwSoU6jamEQeJz9IdL8vIosHcvC8D91gDiwB9TKZe7jpGyoxDUBu5FOg786lwBq7aGJYHiEAFFT9ARv/xmiHJldc5b3RLsbpmdhaccZruOTI0YhFCvLY9mezx6SOBeGe2u38nf/FHDEjq4nUqdevpPlJv0C05A5VB6ht5Etq/9Ql6rn8/vmTkpiBIWGLeb1nYyPzq3shtzCEuW6P1USL3ty8myRbfXK/r+L1dfhiy/7JyaVMWEa81NI08jMSh54UgaYCzBzLKjBHJAb9QP0/qtvwx+2NbUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrbTE+iX2LaBOPGFz4155YxbeYn1wUCvThi6SAWb9w8=;
 b=ZhuSRT8cYnPLD2NCQThzyoakrU41C9W8nos5PMrLaEHDQaZSCpMKJgMXuwE7ySXWKdxrC605uuEtwlSfb7TFBkbXsWiiDkyiIlSVfK/dpuWHLlRzQJBJOfQTWaUJg/vWKCUDRlaKAojSS+Gb+85tJpyeYzzJKo35ezh0ENaG3gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8703.eurprd04.prod.outlook.com (2603:10a6:102:21e::22)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 10:12:11 +0000
Received: from PAXPR04MB8703.eurprd04.prod.outlook.com
 ([fe80::d15f:2b68:1967:91a7]) by PAXPR04MB8703.eurprd04.prod.outlook.com
 ([fe80::d15f:2b68:1967:91a7%9]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 10:12:11 +0000
Message-ID: <a13acbeb-e545-9e8e-40f9-b02526b867b8@oss.nxp.com>
Date:   Wed, 8 Feb 2023 11:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] media: dw100: use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202302081635445002151@zte.com.cn>
From:   "Xavier Roumegue (OSS)" <xavier.roumegue@oss.nxp.com>
In-Reply-To: <202302081635445002151@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0037.eurprd03.prod.outlook.com (2603:10a6:208::14)
 To PAXPR04MB8703.eurprd04.prod.outlook.com (2603:10a6:102:21e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8703:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: b8796475-cab9-41e5-40bd-08db09bcf107
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du0i5HGUf2K77Mn72fZr7DOaZKY+XZFyDjVT8BBeAIN4xel+tX8oJK8r3Xyy+rO3X5JD485QMoycogbXm4Aa8L1PLXfd2q9gD03pAhwT2IB4KsbgBjNryv193ITrteRPMJDNqFp8xALmRT/3cF3XsawezkHdpoQab5tLuHmoZrXt22QYsU9BYWB4RvJD6l4d27XNIJ0kXzHTx5GkKhJmCO5LCeKKLasu84LjqDjEGzAFOmOdA+1vvUnFsA+s6p1/aU9OjsxbwziZK8BxlJgsJZ3D2jPRgr17AQCPrbT+GEoZAs/Ph0He2ZLaWtZzYSmnvsw4yOGWtlLy+GAzHndRt3DywlsifSwUuNhfZLzU90yY8+yrOhaH5tQRa7nyZZ6MORLPPAE/Olo3CKGoF9+to5qoK7Uoe/nvZ+NVMIxgeesiL63FC7Wa4087fi1WCea+IQG+a20Ae4zaSsFYembdJa3mgZ3l21jkn7B9ZE9qNQXO9xYKGiMhwDLfLGnv9xgwdAkslrZm1loo6A0AI0z/g9gl3UJAUSGRkR8MSPUocNSLfsG0ll99i7nFMvFg0WNZR5C0QKYjztSxb4XoUbBFx97d6ZssEvEXMohdIk+yG/uJg58RwDWP3n+4vN7oV9qmumIdOEsjaoeEMndHVkVXmqQkMSS1S+OQ+VqqhJNipjERvA2eeXEbntyhITqitu9/kxuGDxkZtEIlmL3p4sCbmlhaWKpOvfyCi1O1Ew2gbsSPYLTvLEQVeR+G0z8a23WcGEn/jS9GRWc7PUYEf+HNNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8703.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(31686004)(316002)(83380400001)(2616005)(2906002)(26005)(41300700001)(38350700002)(478600001)(38100700002)(6512007)(6486002)(186003)(86362001)(6506007)(6666004)(53546011)(8936002)(5660300002)(6916009)(8676002)(4326008)(66556008)(31696002)(66946007)(66476007)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHhvdGZFQnFyYzJWWlRETEV3MFZkRlg0c2hRbkM3V0ZCL3B6ZDZ5cmEvYVVO?=
 =?utf-8?B?aHFvQTQvUXk3T1o5S20rYm81WndhNElSSUpXWm15aHNQOGZ5cE9OaHpLTnVm?=
 =?utf-8?B?NFpWYks2OVFWUWlpNVZaWTdXMlpScUVFM1FOQWhnWTVCd1MvUmZhVWt3UHhT?=
 =?utf-8?B?bzhaNDdRS1ZkYnRULzN4MzBFU3JCUEZhSjNjOTVzR0NWeGtYMlpMa2dlbitQ?=
 =?utf-8?B?L3VYVjR1dGV6RzJSZjY5UWttdlFzVTZjNi80TmJyVGh0L1RCSUJFdVZKRkxj?=
 =?utf-8?B?WE45bFRPditTa05zREUrZDFvYmlnVVU1WGFFSHM0elF4WWdmT1RTUE5kNmhE?=
 =?utf-8?B?TCtvaEUyUVIxdWhsZTh4emhVdU5HMHFiUVcyM3dFeUV4cFE3NVBPMTZBV2dt?=
 =?utf-8?B?SkNiNzRFalpHVEFXTTdwQlBUOURMWVRuTjZBVWlpdWRQNnk5RE1icW9WRWhE?=
 =?utf-8?B?dzJ0b1NGK21yZDVpRThORlgrY0Z2aGIxeWFKcVB6THZUcmhwcEQ3c2xUMzdJ?=
 =?utf-8?B?bllGMTI5T01LMEh3bEhrRVBFTlY1dTZ2Y2J4RVgzM3d6WGc5OEx1TXRNTHZj?=
 =?utf-8?B?Z0M0MThoZ2J4WkxaZXpZRkcwT0dTNk1PSHZhWjNvSWc1Mnp0aFo2WU4reHE3?=
 =?utf-8?B?VndpelNESG5QVS8rT0hoNm5BeXNEdWtQVlB0VTFZVWxETkpmTHhEakNqODJa?=
 =?utf-8?B?TGV0NU9yZ3pKalhlQ1YyQjBEZ2w2djZLK3RQRXZUNzgxK0FZTmhxMElsWWMr?=
 =?utf-8?B?WEU4UEhSaUFtTTlQWlFGTE1TNDE2VVdtdWtZelZxVVJnMmNQN1pVWHNkUUJU?=
 =?utf-8?B?cVJVMEJJN3o5WkJmWHN6NTI1UDRFYUlyZTA1Um1KNFJWcDBKQXpoQldXVHpH?=
 =?utf-8?B?OU9RVUppZkNiV1g3YUhuY3RQSllwa25xZnJOeFVyYzNpMFBLSzI4TTFNZWVN?=
 =?utf-8?B?QTJDV2syZk91bE04WnR3dUhFQnpRcGF1NlpDUEdhTURmdENlSkV0SVZ3d3BN?=
 =?utf-8?B?T0RVMEd0VEZ2dVRRd2NKeis0VkpzTW9PV3RJOHVvUmJxSXJPejc5Q29oV1pk?=
 =?utf-8?B?NkdYb2h5Y3NJUXpMc0o4ZjRjSitpdlRGRDJxTmR6ejhsa25qVjBNUk94MCtK?=
 =?utf-8?B?NXBaY0J4SEVjU1U0YkkxMVprb3FIdzVDZXhLcDI1dCtjeGZKY0E5Y014M29r?=
 =?utf-8?B?U1ZQU0hadWdkcWc4UlppbjNJd0lRUkd0VVJxZ0FwVDVpWlRhWlh6Wk9xbmE2?=
 =?utf-8?B?RnhDNG50NTRzcVN3WmFrNmJVOG5TUi9zTWcxWDBITC8yRWRhd3ByekMxRnRQ?=
 =?utf-8?B?SWJ1U3lSdUMydXBQVGFuWjRTRFY1M0ZOMXNObnJvb25FRjVVYklMUkdVbG1x?=
 =?utf-8?B?cEw1UHpyVXlVbkkvVExLOWhuVUNFQzhEc1JBZlZpelhqcmpMaVp0Nk5ocnNZ?=
 =?utf-8?B?dVY0dlhmUmhPbC9xdTU0c2ltYzRnL2FEZVRxNWZaUGxNekVLbHVTOFl3dmow?=
 =?utf-8?B?UTJ5VmNYVlRLemliOVdrYW5qbWxSQWpNWUFTeDVMYXhDVCswRk1CRlFPTGow?=
 =?utf-8?B?WC9zWjhNUkFzNFhuS1ZBQ2paME1tcWw5REZBbHl6VWhmUzBSekJua1NkbTZr?=
 =?utf-8?B?MGlPMWVRUWlpbzV0T1ZxWlVURVRIb09lYm84QnlaYkh6eWpEejFoeEtwZWhq?=
 =?utf-8?B?cWdzdldtUFNtVDh6cDk0Tmd6QTJUcUsrMlNpVWhtQityd1J3amJUallMV3h5?=
 =?utf-8?B?alh6R0l3aWl2NDdhMWw4cHhKamhNaHFZd1dhbC83b2JMcmZaWTZPMlBoRTFI?=
 =?utf-8?B?UVpHWWNBaEV2VHEveVhxNHF2ZVpXaWR6azNzYmc2TWl0cUM3Y2dJeE5oelN3?=
 =?utf-8?B?cDlnWDVBWld3MU9wOS9PUmROTm9DWUc4OXZNVnh1TEpWS29jb2NmM0pJVFF0?=
 =?utf-8?B?blkwVjRTdkt3NGl2Q2tkU000ZkdNRzc4Nkk4TnpNK3k1bkl4TFZoVE1Ubk52?=
 =?utf-8?B?dURsRjVlYXZxZWJWa1o2ZyszMExVa2hmSHByUFNYTFZmcFo2UE5uMVFwbU53?=
 =?utf-8?B?eXNBVHhublFFbEFNZ2JOc05Cakt4Z3JGREYrYUFsTFo2QkdpQ2U1Z2grNlJy?=
 =?utf-8?B?Q1NURGE4ZTJCdEpQeTNYdktaekt3NkVhd0dMaWR1MG9aeUJnTU5ZSEpSRGUy?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8796475-cab9-41e5-40bd-08db09bcf107
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8703.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 10:12:11.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dzGrl5ZjV52PbApsm7rD7sp8CgYxI3GCex9dgAab2UpEojEzfoyLxcKshNc2SrzjSdeCaOEYYBBE8DjzZI/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye Xingchen,

Thanks for your patch.

On 2/8/23 09:35, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Xavier Roumegue <xavier.roumegue@oss.nxp.com>

Regards,
  Xavier

> ---
>   drivers/media/platform/nxp/dw100/dw100.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
> index 189d60cd5ed1..0771a88122c0 100644
> --- a/drivers/media/platform/nxp/dw100/dw100.c
> +++ b/drivers/media/platform/nxp/dw100/dw100.c
> @@ -1532,7 +1532,6 @@ static int dw100_probe(struct platform_device *pdev)
>   {
>   	struct dw100_device *dw_dev;
>   	struct video_device *vfd;
> -	struct resource *res;
>   	int ret, irq;
> 
>   	dw_dev = devm_kzalloc(&pdev->dev, sizeof(*dw_dev), GFP_KERNEL);
> @@ -1547,8 +1546,7 @@ static int dw100_probe(struct platform_device *pdev)
>   	}
>   	dw_dev->num_clks = ret;
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dw_dev->mmio = devm_ioremap_resource(&pdev->dev, res);
> +	dw_dev->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>   	if (IS_ERR(dw_dev->mmio))
>   		return PTR_ERR(dw_dev->mmio);
> 
