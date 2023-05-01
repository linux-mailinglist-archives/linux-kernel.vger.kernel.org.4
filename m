Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF86F362D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjEASr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEASrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:47:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3673F2D4C;
        Mon,  1 May 2023 11:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRlMH1AG++Sohn7Mimwoqg5CN7xWzZ4XjyE1NqyQtXENgonkSp6TEp0/ru0AMnD1c1ssHbSRbvPXbKIQioYuOKq2H6rzCXk8fwJM4mJtlYIXvjf29wepq56CidRaeDPVuGvEW8SDx4sFOBmoKmJqnmATqpBbTr4tsKM56qmn4xzgCS0LVg19KWfS3y8HrbLtJLYR3l1yV+TDcCWX/O9cjlCbRCOPbHich6/OCPTNvdyrkdYZGZEKzhYEsZ2yrR3Xt8MxtW84xZL3uCgeHHRwFq6G9Pb8G+77lef6OPINfAm1xa0de7JustIXWwRo1KJPEiFK26WezA/M8xyRmKA+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Scqa7tPOyQ4FSi1Vj5NW3tlk5z5GWV5iP/hg9VBlRyQ=;
 b=eOs2myVzVsbWQkV0biPE43IZwDk4fWLEYZ+t9hHs1qWmG4wqi6L6FARreMIbpqIhHrmhTMZeO07M4yekXstww3S2BOlrBJjV8uyNCpdwcT8AgoAQJwibG1Ck7KC4x4+i5MAO5Ez74w7hncdw0yEcJZAss+uYx2iVrNWf8u2OkgD2DZKj0EPPvFjgm7SuBKL8vyGTjPCBYl1OkpvEpZwmzXD+hMmDYZ8h41zulj4Y8MPLXdIq+nq3Y/CV5dUF+HXHIm3B21M0q4/cVSo+fivSUh1L6WqONjtK6c62jM5wyQdvW1hU2mV9ysmilbyARxp+jwho6WAHSDInh4ILaeGCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scqa7tPOyQ4FSi1Vj5NW3tlk5z5GWV5iP/hg9VBlRyQ=;
 b=D3OoIgV9/U2tahVCbr8xpXxbG4kgaYOYGPHIlK/poBrGAIuOSgI9faX9dzA0+IgBd6aWK3LQWpSwXrn70LUkR7JEor/40Lm7AK/KZX66mHAF9Zs5uqjrGYm/+y9HbrCC/6u72NUvcioY7RLAjmf9zB1KvSfKwyy0KttkwVuq40s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:47:11 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:47:11 +0000
Message-ID: <348157d8-f3dc-6894-2bad-6d2a85cf879e@amd.com>
Date:   Mon, 1 May 2023 13:47:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 04/10] crypto: ccp: move setting PSP master to earlier
 in the init
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Cc:     David S Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230428185543.8381-1-mario.limonciello@amd.com>
 <20230428185543.8381-5-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230428185543.8381-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 92684161-38b9-442d-dbe5-08db4a747913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNjsHu6gwllx/tVdsr8euuDLWt5G+hCK02qniYeksCLaaya1IBx6vqDfR4AttxP2LmVP5iD13tEieK+gWy7oknxZH2BO4tInftmdcA5qSV291/f54q7BeSt7dlGS4HfO4eLuIzRGlSgrYyo78/3cMKG3gm/L9l6+iIAMLYR17njcyO4nj7lqTMsdvcjWQnu8QyqicmLODFT6r2WzkAboJDydcB9hY8TLcsA9M8BxUS7IMlu6CtAbd7yaNLq01gQb0K1hjgxTJF+ReUVpi5RqOtK008CM/GmSN0SEa40euy/djbtfusSq1+1AqM+Swuaxm9iBFTIDPFSgqQb1TpKs/qlC0MOaQ5z2iwNxMr8tmGfDx5KI71IJvQ+5DcmaAP+2hTlixEGb2pnO8n1dBr9SQgjw/lLCj9cowJ3sWxUoNJnAAh6j2aRp7FZWT8lG3lbmcj7TwX2U2tvYwGaPmmwzJ8PldZZHe82iQlSYjBqzbrPbmZGnMlQadEJni5AEbI2AQHmNl8j5xwzEmfoHIlOZHQr1X9YbI9BYLTX1P91FlndiMxAqluBANb6cO5s+a4S8i83RUvOUcM3bLR77wFOHFQkMs0NTGz2JSJlUW5Gqf5CX6cMAOpFZ/+ao21hHmXYgm80fC/B5WdO6He+yYEl4Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(53546011)(316002)(6512007)(6506007)(26005)(2616005)(41300700001)(83380400001)(110136005)(186003)(478600001)(66476007)(66946007)(66556008)(6636002)(6486002)(4326008)(6666004)(38100700002)(2906002)(36756003)(31696002)(86362001)(5660300002)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVhXMmJjb0FNUlF3b2RWbjE2bjFrY1JEYk4rbGlFYUp3NjNZNWVxNkpkMCt5?=
 =?utf-8?B?RXRZRnh2eU0wOWNBZ0F4eVlIR0RIUncwT1U0Q1kwa0NvNlNMYkFjL2hBYWd2?=
 =?utf-8?B?VEJManVlTC94V3hnUzVDcUN0eFZhYWd0azdpWkpMUnk4U3Y1KzM5eDd5MENo?=
 =?utf-8?B?dlBnZi9hMXlJZWRYcGwwaVFUME5hd09KTUJzOG1mU053c1k1TDYvcEtrSlQ4?=
 =?utf-8?B?M01tRS9UeTFmb3A4VjliaXRNZmhTSUZaWlBFYWdROHRJRGw3TktxMlFLNk43?=
 =?utf-8?B?NXFnTGZ4NU9qTFVUZkJFZ3ltTnlZa2lRNG1Jb3NRUGpuazdIODZaVHFwenVi?=
 =?utf-8?B?RmxzeHJnRGdvS2FNc3NmS3A1eFVINXQ5QnpOWDJldGlXRDJ2YTA4RUM4WWtD?=
 =?utf-8?B?Z0UweEM3UHhoMjJBZjh1OStMdVdDSmRhMVR5by9Ja3BKTjAzN1BRb3d1UFZm?=
 =?utf-8?B?R2FUVGhTWThwVUM2SmFsMXNDeEVQM08xVWJ5ZHNMSEVWbVVyWllSWHg0Z2lH?=
 =?utf-8?B?TGFCR0YxcGg0TXgyNGJxbVVIZ0FxOWNlT0tSSWdYeEpmeURoS2g1ZmpYOExI?=
 =?utf-8?B?VUtrRk1qMC9nTlR2TGgzSWhZVXJzVC9rVGp5bU9BeFhmejhYOUFxSGhBRHlo?=
 =?utf-8?B?K0dITEJJUGtlRFJJbTlvWkZNOUVEM1dOY1VzMmp3WldEWHBLMDBuTXMvVGx5?=
 =?utf-8?B?TUtNZWV0ZXZUWFo1K20rMmtaeUYwVURzZTRqalArdnZJRUQ0RjI4TE1hNTBJ?=
 =?utf-8?B?amtwbGVTSGQxUzhEckFtajlnY3lWQjYvRkZpaW9EbjBjdWxmdTFncDQwNXNa?=
 =?utf-8?B?aC9RcnVPSEh4Q3FsbDU0OE5BYVBBNlcrcmVDZHBmM0NxaTllbWlUWVV1TGJJ?=
 =?utf-8?B?dG9JSmJZeWZZaU5iUmRuUE1uQmUwZVhmbkNzWjBmc2E2MXN2emhHU0t5UVN2?=
 =?utf-8?B?dHBhckhDWmg2eHFQcG5uZTR0NVZ6WHk2M09mOCtZSjlQdXFlTURiL3BHOEN6?=
 =?utf-8?B?UHA4MlVlaGwxaU5Ub3ZBQ2dndWtVZDdwK29NNWpVQ0dPK1BqNjZ0SjlBSVdi?=
 =?utf-8?B?dGZXOVFPTkE2OU9VWFBnanVKY2tOMGxYWjNmYnZMMDhqNER3TUJUNEwrS1B5?=
 =?utf-8?B?QXVNZlZWTUtnbDFubjRpR1BXNzFGL3RMMEN0UnJVQW1OSEltd2NTK0hROXF4?=
 =?utf-8?B?cGFUcWxyQVRkekY2VmxSeVVJNGIrcDVUZTNtd3FUNjkramdYQnloMEZYMm8x?=
 =?utf-8?B?ckNzK1lhdW9PaCtUQWRaT29SNGs4R0FuZnZsbStSZ0U0b0JYdmhUeDVDS3BG?=
 =?utf-8?B?ZjZGcGo0TG5nQk51TGo4aU9rK1JxbWc1QXZUZ3l3NHpXeWphZHNJVThKTU9S?=
 =?utf-8?B?amJSUzYzSTN3R0E3cDJoaGRoRlNZNHlxK3BUWk5EMDJZTFB1TlVtZ1Vpd3Jy?=
 =?utf-8?B?RjhlVmE3ZEJQMzJUWXRwOFBwMFVJRkRmZXBFRHVjUXkyMEpETk84RDFlT1My?=
 =?utf-8?B?S1FReE1wY0RBTXdlc0g3UzFTdDlhZmt4a3Z3QzVHeExoaVdzd3hJemN6dHNY?=
 =?utf-8?B?UHVPMFZTcDJ2ZGlrRzdNN1h2LzI0amJaMHc4WXY3cFRyMUcxbUF0Rmorb2kr?=
 =?utf-8?B?OVVBcmtnd212eEdHNWREL2xjdGhHdW92RldWajhyV1VMOTA5cTVRandpR240?=
 =?utf-8?B?WE5PLysxRWJUclBGbVQvRkpJajJyaXN5RmdsZC9lSkI2V1FhVVpVN1hCU25s?=
 =?utf-8?B?QU1zYU5UYlhmY1NLc05lL0R2MWtrdmNRRHFYZTJXVSswc2duV1JiV3pNZ2c0?=
 =?utf-8?B?KytYY1JvZ3k1ODgyUkJnL3pibEh2STlOQzlIVWl1a0NQY0c4U3JhYU1seStn?=
 =?utf-8?B?NnF2ZHF1L0JWQURrcVBJOXhKZnVxa3hYMXdUNWxnVG9kS1YycmlqNUZlSFVZ?=
 =?utf-8?B?M0k1TTJGLzVPYStxZHEzOFYzdGcvVk9XR1h1cUVxQ2wySjhJZW9LVWVucktx?=
 =?utf-8?B?ajV1NlpNdkVPS2tkV3ZnMFQzVTFWa3c4ak9zWXdnWEN0WlpTWi9mUit3ekxZ?=
 =?utf-8?B?OWdsV1RWbHpRYnFHNE9jd1FGdnlFU3hUWnp5ZzJDMG1rOVV6eVY0YzdSd0Vl?=
 =?utf-8?Q?CTHEIUv5B+UyBs7Ku1D7UpgOl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92684161-38b9-442d-dbe5-08db4a747913
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:47:11.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AadhE6yTZzXqsQEWg4Tl9ncpgXP/7OB+w/oUQ7MoxzsQh/v1uui1h8Fhk8aW/NsSNpQXYmWbueqdcnH1Rd4XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
> Dynamic boost control needs to use platform access symbols
> that look for the PSP master as part of initialization.
> 
> So move the PSP master before psp_init() so that dynamic boost
> control can be initialized properly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/crypto/ccp/psp-dev.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index e3d6955d3265..e9136e398174 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
>   		goto e_err;
>   	}
>   
> +	/* master device must be set for platform access */
> +	if (psp->sp->set_psp_master_device)
> +		psp->sp->set_psp_master_device(psp->sp);
> +
>   	ret = psp_init(psp);
>   	if (ret)
>   		goto e_irq;

If psp_init() fails, should we check for and call clear_psp_master_device now?

Thanks,
Tom

>   
> -	if (sp->set_psp_master_device)
> -		sp->set_psp_master_device(sp);
> -
>   	/* Enable interrupt */
>   	iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);
>   
