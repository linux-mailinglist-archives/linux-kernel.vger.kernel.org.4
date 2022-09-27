Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C5C5EC927
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiI0QMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiI0QMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:12:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469B37F89;
        Tue, 27 Sep 2022 09:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQhNpuVJW8H0nX0kUFPMr9QihIX2rZVoaQmJhbbyaHxuOn+pUWsu1fnCwHF1M5MeQkHRuGeqI79N3hdptCqJSV3JMzQw/1XvYQSmPPoeVY1WTM77PmhvAqL2IAeDmKKvrh284DzN19MHZhBEOKV/7ttsyscTaJM3vW98aZNZrWucrf/j2+VtZyE03R+ZNoNYGY1faipbUGBrvmyha8Z6yYX/fqLvMIocymyDS1fStrkg723uVW9HpZp577odGsZHurNOL9X5yfGAxETDXDNuK4KF0L6+eFzLpmDltARldbB4OiGiDPX+yHXs2trZjOncTUC9KRLIh3r3i2Jg9IeHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlVyHvwchRYi7lQAOuNU3h0+o6Jf5tbB49HVgDrVfw8=;
 b=jJC9sY/HvFLmxmrnwyaq3KD6FfggmgYVH79WtpaClu8ka7eGu0WfeXkm9w3/hM7+uHFUNaqeZBtaNp92YjMc+3TmZyySINQyrzCr1i/jV33Ko2J3t/xc4xHqwQoTf4jjWP9nY1jI7hK/4coZhE01w/ef6i9Asu3yRlIsbr6g04JcmKnowroXpxWxpF6YDV97ak2vVOBXNFp6QsMg4gTbY6XzoFEMOA3hGU/l2+ZvOmkttg2RSQpntuFgkz4Vuy+r1ZecLi8gOdAFwyknwEgm45tFwJhI1YpK28hI12vdjow0t62UQDlUwW80yebl/KIRvTOG40TFp7/Mt0vInWmFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlVyHvwchRYi7lQAOuNU3h0+o6Jf5tbB49HVgDrVfw8=;
 b=TVjlx/VxZte/6QOm0L8NgCDs0gR9aMCpCldijSqozGCSWeUN6q4IywcnoObTFkD00kaaFG4/jBRfH7azSU5hig12brpdgwUA9a+zBw7iKHxndk8kyBotkhK+10QbgFKb+fdBSEBTPDOfKZwUUx4X0lpNlAl7s6Ve7RlMZjp4IuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 16:12:02 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::297f:558e:dba9:9564]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::297f:558e:dba9:9564%8]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 16:12:02 +0000
Message-ID: <dee9b106-cb0a-32d6-2795-da46912332b9@amd.com>
Date:   Tue, 27 Sep 2022 11:11:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] crypto: ccp: Add __init/__exit annotations to
 module init/exit funcs
Content-Language: en-US
To:     ruanjinjie <ruanjinjie@huawei.com>, thomas.lendacky@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926092711.1192679-1-ruanjinjie@huawei.com>
From:   John Allen <john.allen@amd.com>
In-Reply-To: <20220926092711.1192679-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 22da57be-e3a6-43ab-ded5-08daa0a30379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKpvcp/ZB7FR3A8oPeQkAar9cpfBJyilCkTwg5NiDR0lg+fiinENfC3Vs5KVkeTfawZpQ4fn55SKlSpkLD2Rxc24rkF/9Z1o8zLlU/saI4i87mSkpy8AyoqWoMCzs32qCiDKU0nBBWG75zImLaAx9RAf340klOC3Rq/Qdf34lD0+JiF43vjI5M5bsgs6ta9oFma4wNI5yvKKNwhXYQsZKwQG+w5dV/VjxmUgOJ2uCloP20Is/67yD+WjW5LpknNcDDMMWShlQQPGZUfijrWiZULYJivAPulgsxebs5EtJUxoB04smL2blfu5fXD8rY83lxwtXU2OX7DJrIALJ8hXgt6928cMmV0fz/FLZjxbg639Dcxe9nhe3fGi9FQXR7Rn2iexLShNzTGh3QGls0a/clJiJlrOwTCVwS47YxWv4Bg654Lr35bKR1bGqUYYTMlHJxC/pC8eUNrLnrvGtQ9h2x+BogIAhh9i7ioABSw4FfKnjLXp2cIlTNTPSS9ALEZkxXEuaPhN2xxIyntijRd8PiLbNhFesNaPcu1vwOQewB9/QXVPtdU43Qnu/zt9ZzcClLIcazNF2Oyt1TODNJ8BuSPYNm3ykXGHI+GC6oMilhgGuIkR/nRuEBqjqRgWhYHwKfR1d/wfixXkNZ2bXfWnSWnQYkZvtKcOn3nNHS62ddZ+3yGbveZi+ddHCf5OYBdm+pTQrJf3HEuBKgcOncVbl18wFwCZjRJsX6Ron//7Bkf7fWmuLEARP2ph0Elp2Qj5TzpVpL5xta0RpMg/KhXhBOC66LSYcX6fI+lRTO3B7r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(478600001)(316002)(6486002)(66556008)(66476007)(66946007)(8676002)(53546011)(6666004)(5660300002)(31686004)(41300700001)(8936002)(26005)(6512007)(4744005)(6506007)(44832011)(2616005)(83380400001)(38100700002)(2906002)(186003)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9Qbmdod3dEbzFSblFTV1V1TitmMnEwQi93M1B6OEVjVGlWdGpBd2hwNG1q?=
 =?utf-8?B?d0gycmdJcStoSWRScU1qN3p1M3Jpam9BNWdLNFYrZEFVeHZVUjk0SDBLVjhW?=
 =?utf-8?B?NTNmY041YjFBWVVpcjh2NkFEQ0FyNVRxZUJ3WTY2WXRDNk5Fak0vcUZSZkNx?=
 =?utf-8?B?akVqZVRPZ01yRjlKZGVkc01BOEJHVGNtZExKWktXR3RtaUlrWVJrZGhxYjc2?=
 =?utf-8?B?VjZYWlZxZ1VDbW12cHhhMlp0RHJ3d1JwQllRMitqcVJUb3pnMTVDOHR4MDFI?=
 =?utf-8?B?UkRrdmsybE5RbmF4WHljVGdjMnpOWW5TVjhUaEZLWi9CQmdUa1hCYnFFQ3Fk?=
 =?utf-8?B?bXlXRnRYQS9lb3ZqUkJnbkZEOXIwQ3VwUXl3dFB1eHNEamlQYU44ZTFSWXZ1?=
 =?utf-8?B?MUNyK04zbXlWQm9CSW9maTlRY05maFlqd0dJWi9MNXBvZjBER2NHZU90RWpj?=
 =?utf-8?B?SW8rNDF1VkNzY2VweVlNVmxWcGNPZ1hsTnVidngxVitzQTlnbTJWYTdvSkZn?=
 =?utf-8?B?eHRsMWFEbHczcjJ4b3dRamp0UnFEL1QvS2QwQldEL3dtZlFsLzc3VXpoR1Nq?=
 =?utf-8?B?OG11cXV0OGNsWTdac1IreExZTHhGa2ErKzNkVnhDVVpoeVJkUEY3ZjRTSWhR?=
 =?utf-8?B?RlQxVnJpZ2NLK05ldE96VWN5azdSbnFtOEJWVjFhakVOOWYwbDhlUGdscEtv?=
 =?utf-8?B?N2puczdjR3NkSm9qM2xLT29CdkQrN2d6YU1OdzF5REwrdlFrNXlQazBKTDEz?=
 =?utf-8?B?S3VuZmxWRTlITHA0eEdvNnBTWGQ0OGVOYjUrT01WcGt3cUtlTDhzb1B3Q2JR?=
 =?utf-8?B?TENQbHBiNHZWVmRldHNYRGF1M2d2RVZGR09oZGxLbW9PRGVTT0FiNnp5Y09R?=
 =?utf-8?B?Rm44TDJ4TzVBeWwyZjg1K3ZTQ0JZaUNJU2lBWHNUL1NKaGdZVTlFaGtTRm1s?=
 =?utf-8?B?MkVycjZrOFk2NG9tVzgwNXh1NHFRNFNzN2xrTDlmeGNwYncyTUl6VjZvdW0r?=
 =?utf-8?B?VVhXSHBSMjNYblVKV09KY2hpamN3MTdpQWhyLzVPVGJnT0tqemNNZnNsQ1h2?=
 =?utf-8?B?MVRSaDFoemxjejJxY09vVU5ZOWpnK1M0NUVZZktmV1NWbGordEtsVXVFTTZk?=
 =?utf-8?B?dEhSUUhnV3I2Z2xMQm5EVDBHN3JpRk1vK2ZRUXZYZmhtdFVBUWkxSVNqbkdC?=
 =?utf-8?B?cHplQXBxWUNOd2s3YUU2VzZDSWtuakErelVRN3dMY2taL2JPR2ZoSERVZ2lq?=
 =?utf-8?B?aWhpeWtUWVNjOEVMdVg0UG1oNlY2QkRiMkRnY2wrSG1LMGtxYWJMZVNpRGV0?=
 =?utf-8?B?bUJFdlpyQUlaT0I5WnJ1S3NMWTFTTHlzYk9hTE51WkVTcTR2VGtDK2R1aFh2?=
 =?utf-8?B?Ly9TSGxTeXoyWVNvbHF6L2xIdGcxTGc1Sjl2VS9Pd3pWU3RaOFU3N1NMK2FM?=
 =?utf-8?B?dlg2K0xoMG1TNGlqQkZCMjl3eFVFT3lveUVhaFFwaHk1c0FZSk0vdlRYa2w3?=
 =?utf-8?B?SGFFZ2FYWHlTQWp2emw3Y245MVhlSU1LbWw5Rld1WnFCNE9SQ0ZFT1pwZ05v?=
 =?utf-8?B?b21TZ0UwWmR4OThnWHVmVWY5YzdHbGR6VjR5NzdHQ3o1bzUrcmtJenlaMFFZ?=
 =?utf-8?B?RU9tbi9teHM5SGMrcDIvYURRWW5YR1hQbEhOVTdLQWFYWnlQVHBiSFA3VmhZ?=
 =?utf-8?B?cHJLYytNbWNlZkJjejFldDJjWkV4TnZCREd6bnBNeUVrNzFXckVpRytPTkN3?=
 =?utf-8?B?U0NVd2cxR1plNExuN2NSUFVCY0ordndZYmVjL0FMMGFVNGlBcEhIeHJPOWky?=
 =?utf-8?B?cmlBcnhNZEs3cjg4M21tRG9SM0trVTMwcDJRYUx1ZTNLUzJSUVQwd3U2c09K?=
 =?utf-8?B?SUJSVHBscEh1d0c1Ui91YzN3NEpKSktQeXEwWE1SZkxxMmZ1OFhKRExOdGQ0?=
 =?utf-8?B?OWFTb0hqSWZ5eGZlb0U5eUhXYUFHTDFsUGhrYS8wZlBER29WUEl2VXhENzhH?=
 =?utf-8?B?MzY4RkpVbzJvbzllMEYyNUdMaFppSUhsL3h5VEtmRXdyRjNnOC9ETmE4YllZ?=
 =?utf-8?B?b2RnWG9YMkx3Kzd4WXk3VkpuSVN3VERxMnJZZHVtYnFKZHo3NkJPVUxONzVm?=
 =?utf-8?Q?ytz01kR9qD+x3mYmudxeWt9fF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22da57be-e3a6-43ab-ded5-08daa0a30379
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:12:02.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlWatDbevJLmXTFPtnExHyoQGkctHyq0D1QdpcxUpqZVxzlVy8d5uKk5SkP2GNAWv44nvM8qf/HeCuV+nCV0ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 4:27 AM, ruanjinjie wrote:
> Add missing __init/__exit annotations to module init/exit funcs
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Acked-by: John Allen <john.allen@amd.com>

> ---
>   drivers/crypto/ccp/ccp-crypto-main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-crypto-main.c b/drivers/crypto/ccp/ccp-crypto-main.c
> index 5976530c00a8..332181027305 100644
> --- a/drivers/crypto/ccp/ccp-crypto-main.c
> +++ b/drivers/crypto/ccp/ccp-crypto-main.c
> @@ -400,7 +400,7 @@ static void ccp_unregister_algs(void)
>   	}
>   }
>   
> -static int ccp_crypto_init(void)
> +static int __init ccp_crypto_init(void)
>   {
>   	int ret;
>   
> @@ -421,7 +421,7 @@ static int ccp_crypto_init(void)
>   	return ret;
>   }
>   
> -static void ccp_crypto_exit(void)
> +static void __exit ccp_crypto_exit(void)
>   {
>   	ccp_unregister_algs();
>   }

