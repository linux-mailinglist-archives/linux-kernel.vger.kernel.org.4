Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6D74AB0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGGGWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGGGVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:21:42 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1BD211F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL2NNqIGoY4/tvKuDcCYsqyLZbqEC7G20tch8RCduKhVFp6XMf1kmrHjBJj+XH1klCpNibNBB/wwtqUMZLuRi7SBBbjPdq9J2wn4+1ivZGNP6j+0MAGNGrEx7bKCVEV0AnkAvd+sb4977TNGVweOyQnkMYOcFp/7I63Yr49GqvSn+xM5sy70sMnxDGWmn16BuXd15iQGI4peYmUvhZpi+0Ai8tTihpu7wy1RkRVDNGh4KtmlzVCByv7+BkoV9cMv0tOXSys294nB6fvw0prSKPsIpbWR5/GNYVtUt1TKD279/WPTkGPkjQFMY4+15kAJkPcWi2xql+2sgA7UmPpPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HffFudGGFknS+ujx1sbsfpCsykN6+fjX3CqBRvkxEzs=;
 b=nGnHx537lFmVoOKT2/goc5bqyk3HeDaNTouXup6IrpdWoCyM5I8fY7oicTQWQXpGF+5Oqu+NlIdWJ1PLxhTrr1/y8ARujQo757nX+u2r8mZuTrLLR8LipfJtLk4iGtgBoX92OnOh2M/HnzZdLpwSAsCMXqUUSzWBWsfyXWNA96TJ8Umgvx0qWhCfRcNJvCt21/UAlHwLPNP58MoS0LKVIZ9GT6EJUHlEHf+TmCw4ljCa+a9WEP0iS82SEFWuGXRGS/9+8yCGFRVEZ23chmqqx4ptT19fBE2kozXOs6P9TE1/SdjGbs131PIGAXO+qgyiIXbjzK82XhMb6RcWJeHQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HffFudGGFknS+ujx1sbsfpCsykN6+fjX3CqBRvkxEzs=;
 b=Q7zMO4TS4IzI7+6jF9bn6kWSHjayuTjPp4/PpU8NNYM+UU+c7pKi0WEx5S9T6gBrmFNMB5ub4q+aPmmZKE7R3l48qJZi8clx4o9QFPoidpbK5RCFGczmFzweC59Gm2e4RagiAsLzJoGMTngzCs5/RKeYP7opmiZ6YuT2iSiLq5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 06:21:38 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 06:21:38 +0000
Message-ID: <1250788a-bae0-adea-0b5e-ce7cc39ff79a@amd.com>
Date:   Fri, 7 Jul 2023 08:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] misc/xilinx_sdfec: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707024224.78907-1-frank.li@vivo.com>
 <20230707024224.78907-2-frank.li@vivo.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230707024224.78907-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa1dec9-2bc0-49fd-a8b7-08db7eb26bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKPa7nVRiDuCxPXUlxQrBcoy0zC8t0ek+kxGuecPKRSDD6EQefgZbZYROyX1dbpi5v57xRfQuGfGi0tSQPSaBIdsZA+FeSG5zOlg00MprWJRjtNgKpt+8Ds90CCr4YcwswmQqiHjWn4uWkAeSHEe5C2lei2zlgsyR4nYUKgmguhDL2a5gBV28109Ihnv8FbVPgMnAjYnlFS8AtuUX6zd8v0yCYlMsL/miPDbcUNbH6whvIPKbIvVacTp94wd5w2WYxx2ctY+8YRF0AkuDkhYeVf/pShz1TCiA1v1XMZ4/N+lLdk5AGT2Whl+H2jiqW5hwx5hjMr5zKi7EQCrsSpL+K/7M+mTuZvwHOkjcpyC3ODuZcho0GM/wCVXPTv/SqoLgCNVpoGAwWN9xJ2HHXnqim7fdIwJ3tIsDEgOe0vpsWognXbpa5ZDGM0P8a1pRxSafvxH5KyJGkqWRnYDKBBj2je8OnHYJ6BwGu2NeDFjPZ5WZ++aWo0d/SersNa0WCJvbsigxs7xLIDEu740lg9MP3bAdH6Rek87bYgS2EH5lgB0t5EpM8VX+87G7WAn9YsZOjH2wgROF6s1l2t+qGg5D0jWTEWl0P3ETiHylJGCRT1cysD59VexDdeLzwIoNLpkS4L2a0XOFx5sll7VJJsoyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(6486002)(478600001)(110136005)(6666004)(2616005)(26005)(186003)(6512007)(53546011)(2906002)(66556008)(41300700001)(316002)(66946007)(44832011)(8676002)(5660300002)(8936002)(38100700002)(4326008)(66476007)(36756003)(31696002)(83380400001)(6506007)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJnTXA0all3UERLYWZNbUNScXdCSmJlNkJQL2VQdlVkQm8rKzFtZjRUelc3?=
 =?utf-8?B?Z2dsK1k3ZWRjZWRBQXF3b24zZ295VmEyME1zVkFrd2QveW1aNEloQTlRSVFx?=
 =?utf-8?B?UGdDVkRUNFd1dlJ1VURuTzFYeVlDaGlBdG44bzdid0RLRFlqUTJibUJIdGpR?=
 =?utf-8?B?QThDWmwzQlFWa3dzeExaNm52dE9RWnY3R0FXS0dvYVdvTC9QQmYvaURuUUJ1?=
 =?utf-8?B?VzMzSVl4OUo4WXd0TnR0VDFpKzlrQkhFNTFrMitHa2FmRVV3Y1AraFUyM3Uy?=
 =?utf-8?B?anFwbElVcllIY3lyRGdneDRuN1FWalFNQmR1ejZtUVRtRFZPdnowclZiOXdY?=
 =?utf-8?B?UU5ZaGI0OENqTUllUXVXMEtBa0xiMGJzY0t4YUh2enhYR201cVRpVCs4V3NK?=
 =?utf-8?B?MnpYMmpUVmFOVmpQai9URXNQZzhiZ3N1eUNIL3djd0FFczdnRms4R1d6d3VP?=
 =?utf-8?B?MjJmREYzczFJODQ5Wmp3RG95d2lvaDNaTVlLMVZUeXZFWmhGREVTcmZ5a0Ez?=
 =?utf-8?B?S1Flck5xZk16SDRvWk9BbXUweHVUK3kxeTlUNjlXRGhxMEw5SFp0LzZkK1Ex?=
 =?utf-8?B?R2VkY0JONFh6MHlGZVZQUXM3YmFaSHNzVXprTVlFbTB6QXZ5NmhrVkxIajJE?=
 =?utf-8?B?WUh2NCtmTTc2UnFnQWhISU1sK2NIU243Z0lTMndmRU15cGMyUGpJU3N4S3Mw?=
 =?utf-8?B?WVNJVFhMSXN3dFhsWUtaZFRyNG9LNWx1dC9Fd1F0dWphQzlkSVE3QzQwZC92?=
 =?utf-8?B?bmsxaVRDS2lRK0psN2ZOZXBXN1ZPQmhNa0JRbXM3YUowNU0vU3JGMTkxWkl2?=
 =?utf-8?B?MXFmT21XWjBDanZnUEI3cHBTMWZWblhkTG1Ob1g1eWxMSElRUTN3ZW5IZXZK?=
 =?utf-8?B?am1zTUtxVHprZDBxc21obXlmaWRXNVhLZkJnNzRsSzZUOU5mdXkrYWxCdGo2?=
 =?utf-8?B?THVOZlp6a0RzTCt2WWx2T0UxU3NyOTFnRjNSd0RtN2VTSm5Uczd6eUZKRWFh?=
 =?utf-8?B?MFVsZXMrbWNDMzBrMUdvTFhzdG02ZEtNT2RTZVc4TFIzc0VTR3FJN3VvQnpD?=
 =?utf-8?B?emg4R1B3SktDRXhCTkZKdUE4UDhDRXN1dityQmMwd0FRcnltbVJBNTJkbGUy?=
 =?utf-8?B?cGU0aFl1QlJLSDJNL3dmWmZaa2dPVEZTaHJOZm9tcXhwdUhVU1VUa2NtaURa?=
 =?utf-8?B?WU84c09KTll4OXZXbHN4SHRJRVhEZ1Rrb0l6azBTMVJWU0VETGtEMnFNNHR3?=
 =?utf-8?B?RGhSSThPK3NrZTErTGlFZlY0UjMxSVBRNVcrbW1jZDVDSHVOQVBxbXJCZUln?=
 =?utf-8?B?a1c3ZncxZDRVOFVSRE5GMmxRYTdMSDZmSU40VENwZStFRy91YWFQbithN1FE?=
 =?utf-8?B?V2pzaGdxL2N5S00zMEJHUTBuYTNoNU9rRFlGNkhRZWFrSlVqZzdRL0c5K1RT?=
 =?utf-8?B?VE5qYmFicDhyUDVQcWk3YVdHRnBrS0tkWkVqZWNBbFR6TDd0bGIxRDRTWkIx?=
 =?utf-8?B?MTBRbEdZc29qZnJOS2hPSUpDeGd5UTFqWjh0VTVDWUJaTXhmNHdKb2FvcVJF?=
 =?utf-8?B?NHhUTFFoa2tINy9sQi9UQ1BmQUF5cDhCSEFKNzVIam9UYzhFOGNNdC9hWDM5?=
 =?utf-8?B?VEZvcWJCOVJhOWord2E0cC9uallEMEpRcWFjYU9KendTM2dHQjhkbTNhcC9G?=
 =?utf-8?B?NklPUWdsWXFrQzJtRFc0ZUIwQVlmTHcwN2hPbUpZbWhXRHdCbDBEQW9Dbmt0?=
 =?utf-8?B?Z2padGd6cU9zam5LbVJYZEdoeTBCSjdYRzBOcno1bjNzbVhUSnc3VHZsWjVh?=
 =?utf-8?B?ZHUzSUdlWVhoTzFzTUZnQzBXTTBYcjFFUVB1d2g5cE11M0ZDNnJna2R4T0hU?=
 =?utf-8?B?UVV3YnF0bVJnV3M4MDBiY3pTbW9HckxsWGZMV1RnaTZ6U3M3Mi9KMWNYZDBX?=
 =?utf-8?B?M0JTNG1KazRiOVU5aHBxVW1ZTHV4ckc0YVZsRVNIK2s4ZStmK0F3VXh0cUZ4?=
 =?utf-8?B?cGZsamZkMHFJMndSM2Nab0tsMHo3ckxPZy83SGxoejQyWWtGd3Y3M2tNa2lk?=
 =?utf-8?B?blV2dnArNHJpb21IbHlTMlczUHdjWVp2VVdWL0kxd2JDTGU3bktzYlVqT1ZB?=
 =?utf-8?Q?pfPhg6DKKXzdZN9Gkku2wdhE5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1dec9-2bc0-49fd-a8b7-08db7eb26bbb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 06:21:38.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz6twp3fBZwIP0BWKRXeAgdclbbX1hDCCYJJta0PZvx7Pa0SLi3WIkG5IlfRvRXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 04:42, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/misc/xilinx_sdfec.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 270ff4c5971a..0877c42fb8e7 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -1347,7 +1347,6 @@ static int xsdfec_probe(struct platform_device *pdev)
>   {
>   	struct xsdfec_dev *xsdfec;
>   	struct device *dev;
> -	struct resource *res;
>   	int err;
>   	bool irq_enabled = true;
>   
> @@ -1363,8 +1362,7 @@ static int xsdfec_probe(struct platform_device *pdev)
>   		return err;
>   
>   	dev = xsdfec->dev;
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	xsdfec->regs = devm_ioremap_resource(dev, res);
> +	xsdfec->regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(xsdfec->regs)) {
>   		err = PTR_ERR(xsdfec->regs);
>   		goto err_xsdfec_dev;

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
M
