Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6B69BD2B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBRVvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBRVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:51:20 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9F13D7D;
        Sat, 18 Feb 2023 13:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG7HfY/YYD+CYdbPxfhLo8jp0dPe8GXHSvTOXKv73QTH+VdRXEdIm6+zhRcSeEKUxNB4Z11btHplmhglvUmX0FOX3GgE6wi5D4AsEsR9sgh4+4+u9xSNoRtI49c0Hkm6sjyAeeuUsmvqhf7rqtE2lY3dVzs8zWf50U0M9flyZ4voUipEvQP7DbgRH4Gzl2dNZjpTp2YRUA3Exy4Knh68izxjNUBpifd49+EWOz2FwAD2pOLwjyN+2JNHM17qEX7iXRL69efP31mI93lhJ1Sm+cBs9U+kDlkEIJI92c0TMftZsGG6IpD34D9U0UyNbngh6zIcFpkOTWtiJ8ZUmj5/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peryarepKFryDGnyh2DTrrK874919CAzGO3W9iRyP20=;
 b=EKJ6yjlOxHdAmrf7mJs7A2Yww7HhBNbol3ThNk7cXrmSShtb+8GC9aWQU6Nil9lmfqZuevvfnicfcFTnGQlLjxoV2/g10owFEfPyXDqfFVvy8cY4i9gPUNgo4GCV+LnL6m164qdY1VEEXA+ZuRIxsDke6Rv5hQOi6OFEf8a+hNFTWMSkjYnKhlTq70oRHSymHoOkCVG1OE6ndY5dmLwzOnzkFJ4kPSGI1Vgihj+947l3/ZyoeSaYExt5MhGNYbiDaT0ltBxNVET5g+RW+da+9dLenUIiGfDYbIBqamcxKzQnlYvZl4CMqiIZGNpzETSITW3yLrYVLUECLwKp6C+xMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peryarepKFryDGnyh2DTrrK874919CAzGO3W9iRyP20=;
 b=YOqojtAi4OLq/lP3biyV5fdZmpu+vJ1YoScxE5AcFstP97pto9nbpF1/WipgsLeH5KRUgW2x+YDiSWQXFchM/p5z4kRJ4DaMWIR07yoPUSxWTnjC10ZcX/lygdyWfvqR0hywsQ6ckDoNKkvLl6Ceq6PNtlFqlXbnc7o8zP2N0qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 21:51:15 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0%3]) with mapi id 15.20.6111.013; Sat, 18 Feb 2023
 21:51:15 +0000
Message-ID: <95b67bc9-75ca-1675-7add-dde3c41fb084@oss.nxp.com>
Date:   Sat, 18 Feb 2023 23:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] media: v4l2-jpeg: ignore the unknown APP14 marker
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221216090844.27262-1-ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <20221216090844.27262-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: de68bea4-65c3-4ed7-344d-08db11fa4257
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xwx2VMfe81ptFglXmLt7BS2xdiQb7q6bv1tTms2vzJJoafAJ5BVup+aQNL2fg9deQBocDs+oTZjx0lJnZfcUJYBaOhVS2k9+B9qz+plMX+PSIOXdxAYmcz8yCM2WKUQrZ2OaU9yqLXXdSarTWcrOEAIefBjaizlfqYeRTFJ6uD3xjSlIOrU/bHe0DUkEXmxRBd3Orx8NhAk90lpEtmggpPGZ3qaimLwJmvmo1shpBw7rpQTU+q/ki1ECx8DRPVsqAW25Ala3XF+b19QMkK1d3tytmznPY+9SW0PuD4zZiHJMHodWbePdTpKjh+tu7zyqb44KSClgYbB99UpjAbiRbGegM5NdTlTqNQxAYXs1QdhLgT/LcOXCopRx0Ov8nwZo40UwbqLj2sIcwC9Bh8V4x0Is/XqN2qvRoq3p/KrQS7R21my4xhQ2YynXYMFBmWdGt5MEIfr+ZbigvT9uQzgn484a5lCFkQCWBZKYzYyvUz7JBNmFWhqSJXHl2ERTFiatYtbRIiD8fFYmm9qP5Ezzm0iyujjunvU1hfgtt9ro/QSSyaxXPHQt7KvFXCs/kuqCRLXb4yWiTaus22HeKzKl5robDRUWkvcx+OXDPDuc1E7QCLcrdDm9GKy4M6SlBOev/JGLLvEySRNLuZ9UJqMJvQvXyS1Pnqv7auONpuctC0+rGkNYaCT53wWf4DiTC2EKCoPX7JCmzsqTZy7v7QId6l2Skbb8gpcvunKcgazXTBlytozk/PmFW2f/TusetQ4ITLBHnIY0+KFHJy/cTcFAag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(52116002)(31686004)(31696002)(6486002)(86362001)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(6512007)(6506007)(186003)(26005)(478600001)(53546011)(41300700001)(8936002)(7416002)(5660300002)(2906002)(38100700002)(2616005)(83380400001)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUN5WVFFaG1ucTlwd0QyczB0MTRwZU9hMy8yQjdoNW5IMXdRZjk5V1lidEVD?=
 =?utf-8?B?YkdCS0dWdkFGVm4vWlRUb2lsajVBbVRaSjFHQlFTY1g4UHkzcDlVWDdGbGtB?=
 =?utf-8?B?NlNFY3Z3UVVUMHkwVGVOOExFL1NPS05qT0pJdVFEV0lxZ2ZOUmlIcm1WT2Vq?=
 =?utf-8?B?RUtuUVgxSnQ0YlJUb28yWXhpYzh1N3NPWWE4VkRYaE5NNW5UWDRLWnVxbzFo?=
 =?utf-8?B?SUV4ZWZCSXdvZzUxSWtvM3JqZUhYY0tzVFdqUjZZRHpESnBCOThjNzBONjQ0?=
 =?utf-8?B?czFqOVU4bTRpZVJVQy8yY3ZSMmNBL3c0UjZ1Z1hOLzlpMnNoZ0JJYTM4aHBI?=
 =?utf-8?B?NFVsWGJJWE9PbUtYZVVnV3ZaOVNyc1Mzbm9qRW9nSlptWHl1cG1NcU5SWEFs?=
 =?utf-8?B?MmUxWnEzbzhISkxYSWxxa0ZHNmg0aFBqeFJDa2swc3k1N0tSMUZvWjRqbFdC?=
 =?utf-8?B?bnpWQ2VaYWhFamVTOHdSaGl2enBnb1BDSEdWeGg3aVdxampqQnQrUmpIZTE0?=
 =?utf-8?B?WFYwMzM2UlluaWY3TlhSUnFwaDlxSkFXaldrd09JRjRHbTlDSVJvaXJ3bkdP?=
 =?utf-8?B?NFVRSHBLZVBnTUNIcnlHUEYvaFVDL2FDNEwrNWFwaEZOYVBxY1g3R0VPR1Zx?=
 =?utf-8?B?azVDZG5HNE1ZMGJ2bEZmVkNON0NsMG9HSHdJZG4zaFBLLzNZcU9zNXY0eUlU?=
 =?utf-8?B?UndndHRpZ1pBWHpqa1Vwc1ZWdVBncVZ1eTIrQlFySG5aejhhNjhUNS9kM2p2?=
 =?utf-8?B?ZmZNaU1zdTlKT0h0dTNYQWtRWWl1V0c4Tis1WmhUNG41VHd1T2JhTXNIQU5y?=
 =?utf-8?B?dzVjZ2l4Y2paQWovRFRLWERJM0xjUzVmOVI3Z28xNzhXSHNpektCYXNRd1Rs?=
 =?utf-8?B?OVJXTnRaZDhOQWI3SG93bHhmTGZDZEhpOXZHMzlLOHNyajQ5ditJUDN5clUw?=
 =?utf-8?B?NTkrcHVITE5zaHFBMkNjWTlncnNZbjBJdVlRN3dyaFlBUy9zSGlWOFloZHRk?=
 =?utf-8?B?clpPSFVISUZuQ2lKSndrakR1VTIxMjVFTmFKMlVmUGZHZFhHR3kvQ0RIY3FX?=
 =?utf-8?B?N2FkakNXaDFoT3NGcWZUc3FaL1FUaE5zQmhPc2ZwZkkzY0JBdXVKaDlKVjFW?=
 =?utf-8?B?ZWc4d3FYdy9rd2tXVGs3QWtPV0NiTHUweEsvRHE5Y3UrK0JUUklFRWpuYlp1?=
 =?utf-8?B?dGIxVVdxSjgrdVcyeElsak9sdERSQUIwNHZaQnNnREd4eC9Wb200YVNlTy9W?=
 =?utf-8?B?ZUhmTmJLVGVpc1hmNkozQ2JNY1c2dlFBZ1NTOGtVci9SWFJnVzZUMi96WThO?=
 =?utf-8?B?YWdka2ZxU01SbTV5S0lkazl2allsUHFCNXI0bVg0Mk5rSnc1RGorOHYwbnZI?=
 =?utf-8?B?ZzNzTko5TEJUZ0lOeUJLSVdNT0JNZzBUZTBTcU9RZENxUzQ2Q1lBbGdQWmZH?=
 =?utf-8?B?L0R2UHBGYzVQOWZqN0hrWHEyK1YzZVBwZU8wSUQrV1MvaHZDWWVMdFhCNkxI?=
 =?utf-8?B?NFh3Ym1XN0FETXJHZjFmbm1YZTFIRktMS1R4MSswY29PbWFwYWhSMDlJNzli?=
 =?utf-8?B?cU5nNmpEVU42VFdCcnlwZFhWRlVaN0YrL3hiT21XYjdvaHh2S3Z6b1NoMHFX?=
 =?utf-8?B?a3loQ2Y3anp3V1loVmpQOWpscUtDR1ZscVlyWHdVM094YW5xTGs3SlpaQ25U?=
 =?utf-8?B?S2czNTZXMjdlS2dZdjZpbzcvN1dnamRuckZpQVN3NHIvdGZFRlRGeG55YTNt?=
 =?utf-8?B?TjUzOTFaTmNxYWY0TGtISjRTR3dmejlra25sVWRKSXlQYnJrelNVYWlKcWZ1?=
 =?utf-8?B?UGJub2lLS2hROU9XVUgvOEF0ZXhQWVJrTVZ1cGozK2xxM1NUakV2M1JFUTN5?=
 =?utf-8?B?RCs5bVg0cG1PQUQ2N0ZJOVNaOTB1T0V2RkxQTDBQbWtKaHFpMEVTTm1LTmwz?=
 =?utf-8?B?OEJ0R3BIc1c0ZVdHU1N6WGFaQ2VUVnJMMTZzOUY0Qk9zZU5VbzFKVkYvVG1u?=
 =?utf-8?B?MWxSMC93SjZyeEthNnkybkJYWE9iN0FlMHJlUUNQaEQ4bjhPek0wNlFlUTRC?=
 =?utf-8?B?WnJHM2svRTg0WnQ2THdNb2ExNmVlb3dtN1h4cUZiOFJnTWhEbVB6Z2pmbjBX?=
 =?utf-8?B?SEVPLzF0N3hvcDN1MExaNXdFbVhXWVdzU1VxU2FwblU2RUVGQjlNanRwZXB3?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de68bea4-65c3-4ed7-344d-08db11fa4257
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 21:51:15.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+fYK5jCka067vQ7CTQsrSEplPQVDBdk/LDlWAaXdA3VgXu4NK8MNCied5qP0zk3ELqAoh2f+EtqvyDstdRizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.12.2022 11:08, Ming Qian wrote:
> The legal identifier of APP14 is "Adobe\0",
> but sometimes it may be
> "This is an unknown APP marker . Compliant decoders must ignore it."
> In this case, just ignore it.
> It won't affect the decode result.
> 
> Fixes: b8035f7988a8 ("media: Add parsing for APP14 data segment in jpeg helpers")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>

Thanks,
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> ---
>   drivers/media/v4l2-core/v4l2-jpeg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-jpeg.c b/drivers/media/v4l2-core/v4l2-jpeg.c
> index 75c2af763d55..94435a7b6816 100644
> --- a/drivers/media/v4l2-core/v4l2-jpeg.c
> +++ b/drivers/media/v4l2-core/v4l2-jpeg.c
> @@ -460,7 +460,7 @@ static int jpeg_parse_app14_data(struct jpeg_stream *stream,
>   	/* Check for "Adobe\0" in Ap1..6 */
>   	if (stream->curr + 6 > stream->end ||
>   	    strncmp(stream->curr, "Adobe\0", 6))
> -		return -EINVAL;
> +		return jpeg_skip(stream, lp - 2);
>   
>   	/* get to Ap12 */
>   	ret = jpeg_skip(stream, 11);
