Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BD36F35EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjEASkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEASj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:39:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0E170B;
        Mon,  1 May 2023 11:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPwTojbKD6Zx2IWrM7y9K1ckfH0/LuwdoaU0zZ91h2k3TuGMGwEZisyhbbfKPU4/NSco4CA0qlR/1FHgS6quV3/csQ1xkYxee490Uvd9XScwgqShe8GNx04HLlGww7kSlvnCwYEGqLEFKnxkmXNP//qDdow2SR9ZlvvuhZ2uD0oERe6E9V4dbIErLoF1zg2AP0X+tM7EFWYdtyMcR8Ro4R3Uz+P9hmEcl9SXCqbdqWthYUQ0ZLKc57HiQBddqAvfT8ILUaLkejSewam3a6TYDpmS2QarIuhghBFhfD8/P8XP2ta1eafRaphg+mPf6mn11w5He096IPy6cja5VTgWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0iShuGPz5ciZ5KiTwMLt2inyLpKtUh+VAq1yyv+X7k=;
 b=UexFcgRRAcJFvznenC2vW02InYubhowlxbtO1aNPmvnyglv4UY1n8CjSyCz8cxDP59qXpS1wj6yFYQ3f9c60aUBGGJaJMiFf7cQTvTxiHo+iovzs9WKLl7vyZOjPyVo66Rey/h8xLXS2rNR4ce4/CmqVUsWNh2y9uASuvCaYz8542wA2bNpBxc4slRrXtLtD5uRS8EbdhjYVyLwOAfIVi410C3v/PAl8wX9qNlpT1fMgPA0ut2yjX0IZfzOkNfU1O8CFJ2bylrcDdDelNdLnniLEM4VWzTZRCs1SIHsZ+R6p9+DIm4chR/XTEJUoBKeS5GhVTHM1DonV0SgXPxdYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0iShuGPz5ciZ5KiTwMLt2inyLpKtUh+VAq1yyv+X7k=;
 b=Y0tXa+XawhtkSqtjD9c38uZIOKc6rJoFanzs0zrlK21iKCz7BBHvyrzMIXgqd11m7+DlyUYjK1lZVLrtEWuhYlqHkSBHaq1nBQ7KpTRmo2Nslyy9+e8NWivDiHB7xysyemzk7imrrE+SkUpWOwnWQEl1bBmifqiMcBfI5/i9nGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:39:52 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:39:52 +0000
Message-ID: <7daa5081-7239-3494-e7a4-07c48f308f1f@amd.com>
Date:   Mon, 1 May 2023 13:39:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 03/10] crypto: ccp: Add bootloader and TEE version
 offsets
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Cc:     David S Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230428185543.8381-1-mario.limonciello@amd.com>
 <20230428185543.8381-4-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230428185543.8381-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: e67808e9-3d12-46dc-dc82-08db4a7373b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYZM2OmNXL/l0a+NrjO6VepLKDNgS4hDdAOR3kvyH2wWeuVBvykmpA+vwM2WDCW/mmbR0O6eryxpCxtA09+DWMwjnc5MJy5zjYrAZUZCeAn84+JRfpdGja98IxBXbPhviyu+W1frVrOIX46b0v60UJDBPgWGuPvv+9Dvj5n+c7AVXNScNr83HWGiGpFiA5XwmpUNcuYdlqpD1BL1agd9wv8auKqlSp49VhN6xCLjFlOUIcwr3aueicavG1JytTJt7lIZFg2sRQDkSchuhAUFIrZdooko7iTJcBCCe+pGuGdIOpc/j2/v9J2AUUhhzKH3H/2S+yFjjlLqCwUdSetRded4eWFXcxdkH0InB5ShLctSrfTFklCnVcGWGqqCCeRp0drvUH8RtLHf0J1PhrSGH/FSlfiH4AmqeB5umw2P7JA1wq02bGpJ0KrpyVy+4Ji/LEW0Leo2xnOtVx799jO+cwzw0N92QXQXXN7KYX6cNfzC0NbFasCoS9G7ebamF37QT3CSG7FURoP4H6yqcootv/k/ezxUhL0RBDjRJkZGvCHFQs4MIvcIw7nTcZSHX9bSaFl6bPky+oosN0srRWDRPx+ECrCJsj0egyoNqRxXSeFq7sM3daU+6ddgTd6Cgcm2QjCy6EcAQzrrM/pEnKAZBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(83380400001)(26005)(6512007)(6506007)(6666004)(186003)(53546011)(6486002)(86362001)(6636002)(110136005)(31696002)(2616005)(36756003)(31686004)(478600001)(66946007)(316002)(38100700002)(41300700001)(66556008)(4326008)(66476007)(8936002)(8676002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFhT3RnOGFaOWJveUtQSWZiazFoSVNEaGNCT05qRmMyb3pwaUxDbzF1d3hx?=
 =?utf-8?B?TUdpQjZ1TWhNRU1qZGhIUlBTclIybkFnRVJkem5SZ0hoV210RFFIV21DaWhy?=
 =?utf-8?B?aUFtUEFEcXJycmM3OGszdFlNZlFvTWFWY0k4Nms1ZWt1VUNPZ3VUUGFwQ1Zy?=
 =?utf-8?B?MkVFOHkwRFp3UFNCSEtLUjJIeFpNczYrWlRlOU1lNGF5bEllMWFHSnp5ai9C?=
 =?utf-8?B?aTFrZklWQjZnd2ZOVytSaFI0TnRVUEdWaS9DYkxXMm1vSWRWNG5KaVJ0Tktx?=
 =?utf-8?B?WEVsZzJ4eUIzY2lYbHI5dVlpdjZ4WVJoTENIcU5qYjFWZlRGMFBlRGRzeFVI?=
 =?utf-8?B?VGx3Ylk4SkZyc29SS3pYVTk3cXFwQTVHY3NXUmVHT0gwNzF6Uy8zSkRCUGkw?=
 =?utf-8?B?bjlOak91RS9BN2FQbEU4dWFvMEFHcVFCd210VHFRQ3QySzQvajZWbVl4QUEx?=
 =?utf-8?B?MW00cUtna3BiUzBSTXdMOHZTZzhUNkQ4Mm1DOXJSV3Y3U2tTb0p1WmhmazlY?=
 =?utf-8?B?cE9ZY3VxekxGeks4UElIVmpoUlpPY1FiTmkvczkwK2VMWU9JQU00ZklYcDhM?=
 =?utf-8?B?b3orckRpWWUwaDM2ekg5MWV3aTlSMzZlL011TndpZGR0VHpvMWRsK3hJWDht?=
 =?utf-8?B?Vmo3TkZlQUV0WXlCaEphaVFYc01CWnFRQjNkUm1mY2tuVTBDUjUxT2toa1pw?=
 =?utf-8?B?RlhUbjlKMnFYQnorM1VkYUcxNEVtTEc2aVZ5aEFveThSV0R1U3hTam1OYmhz?=
 =?utf-8?B?Q3YxR2NyWWRKT3V6VkxFUnR5R0NrTmE1UDdVU2ZtSUUzUk9yc0lVQmo2NHhw?=
 =?utf-8?B?VjRFYm1mc01XNXM5c0d4ZnZQd1h6ZUQ3bCtNMW9ON3lyVTg4ODcrbDhRL1Nz?=
 =?utf-8?B?dXFNeXQvVE1lM2ppLzg2aU8zMVhBalBMSWRNUG5DdHlzNWt6QjNBVWdyTFFP?=
 =?utf-8?B?NzVacjY0NGZzTEgvWHdEaWg4WGRoei8xQzNONUJIU2lJNjllbnZGM2Y3RTAw?=
 =?utf-8?B?MWpzbHphOVY4N3QvNG1lS0wyVzlpZmFjck9vdTNENHUwS1U1ZDFoN09ZRzE4?=
 =?utf-8?B?dG05cGFYYU1iSElSakFSZjNqM0RrRm5qUytOMHVzczlRUjU5bVNlVVZyakFw?=
 =?utf-8?B?UVI2eVNsb3dQMTVWdzhwQ3g1TktWQ1FBUGtDL2pJOHNiS21aZ3JISFVnbGpZ?=
 =?utf-8?B?UmxHOGZySkplTFVKSWp3VHAzd2g2NFNEeHFnSVZoUU5zeXB6QXJKZytrMmpm?=
 =?utf-8?B?UTl4djFadUg3WTlNdENkUisrVHQ5eWxTS0p0WjdxMVZDbkJYemFTMTNrYjFX?=
 =?utf-8?B?aG9KYWJPWFZZWDJCR3JmT2pUTzFqY1c3ZFpyQlRtMVVmRnY2QVZhY01aL2lT?=
 =?utf-8?B?enVRazQzSXpJM293L0ZCQ2lNYllwNWtwelFvWmxPK3FlMU9ZbUszTlpxK1hJ?=
 =?utf-8?B?TTcvZk10K1dIMEJQSjIzUjl3ME10V25paW5QRjRvakNNTUF1OEZsQVBHMHZL?=
 =?utf-8?B?VnN1MUFXTVQ5Zk5qU1ZKclVjajlGT0h3UVJvLzhlRGxNVFYzTWR2d28weHlG?=
 =?utf-8?B?bVlrTEhnNllyQ3VYRWw2NjdKMU01NmZiVDIrYlh3ZENXU3VYT05UQ09QS0Zq?=
 =?utf-8?B?OGpiL0pTeXlMUktYYjRqZVlERGtFeStzRjBveEVlWFNIOWNQMHNqYy9PRFlw?=
 =?utf-8?B?UzZJYmh3K3dvTVo3MityMFZsSklkTys1dC8yVENCUDBySUYzSHNmdGxvZjlI?=
 =?utf-8?B?MERSVkowcURpZ2lZUWxrSzFKQnN3c2NYejdYamtzNnVZSGdZRlhRYVI1WnI1?=
 =?utf-8?B?WnorTml4cjRuTkE4MFNzaVZQYmpSQzBNclEwZWtVZmc3VlovVHZRd1JMeXZ0?=
 =?utf-8?B?SXdVdFF1clR3QzJmcDR3ek55RHBvbDN3QTN4UGI1eXZ5SEpMOXBzN1ZRU05y?=
 =?utf-8?B?d1ZlUDNaYnBOVjNLK3llbEpBMDRQV20yNWcwbDRxZkRpL2xlZzFOOWh6VFpy?=
 =?utf-8?B?UDkyUkQ3ZG9acmErU2pNUTA0SmN3WGxqcmE3dVAyK1MwMXhkc3N0S1VDQ0sy?=
 =?utf-8?B?dnFjcElxYnRjVW5DcEQzWWtVUzFCNHREbmc2TTBWMzZlT28razdkMi9oVjUv?=
 =?utf-8?Q?HxrL71dtYlwdltgy3LehVeXVt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67808e9-3d12-46dc-dc82-08db4a7373b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:39:52.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvopQs/dogU1dVNgCRkFW1FNwTIh69t3uZbgWGVkbqnRyadPsfVLPU6o5G2v7Qe0D6nFXJJ2gmfCglWP47h6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 13:55, Mario Limonciello wrote:
> The bootloader and TEE versions are stored in registers that can be
> accessed from sysfs.  This exports the information for recent client
> and datacenter parts.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sp-pci.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> index 7ef7c09b4a2f..46dd7a2ade18 100644
> --- a/drivers/crypto/ccp/sp-pci.c
> +++ b/drivers/crypto/ccp/sp-pci.c
> @@ -423,6 +423,7 @@ static const struct tee_vdata teev1 = {
>   	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
>   	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
>   	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
> +	.info_reg		= 0x109e8,	/* C2PMSG_58 */
>   };
>   
>   static const struct platform_access_vdata pa_v1 = {
> @@ -435,6 +436,7 @@ static const struct platform_access_vdata pa_v1 = {
>   
>   static const struct psp_vdata pspv1 = {
>   	.sev			= &sevv1,
> +	.bootloader_info_reg	= 0x105ec,	/* C2PMSG_59 */
>   	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
>   	.inten_reg		= 0x10610,	/* P2CMSG_INTEN */
>   	.intsts_reg		= 0x10614,	/* P2CMSG_INTSTS */
> @@ -442,6 +444,7 @@ static const struct psp_vdata pspv1 = {
>   
>   static const struct psp_vdata pspv2 = {
>   	.sev			= &sevv2,
> +	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
>   	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
>   	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
>   	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
> @@ -450,6 +453,7 @@ static const struct psp_vdata pspv2 = {
>   static const struct psp_vdata pspv3 = {
>   	.tee			= &teev1,
>   	.platform_access	= &pa_v1,
> +	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
>   	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
>   	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
>   	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
> @@ -458,6 +462,7 @@ static const struct psp_vdata pspv3 = {
>   static const struct psp_vdata pspv4 = {
>   	.sev			= &sevv2,
>   	.tee			= &teev1,
> +	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
>   	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
>   	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
>   	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
