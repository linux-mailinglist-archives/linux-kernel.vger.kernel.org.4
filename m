Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61786837A9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjAaUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAaUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:42:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA930B23;
        Tue, 31 Jan 2023 12:42:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfoqulOMSFdzrccm1hymfNs0DP+AQPxfEKZT1GFyPKnPREELWbi+dTtLL6qYJgtCcNV73pX/8W880lBU/5ZI8pYB0DoofN9soM5ajpaRX//b37okCGSsJ0Vte0Ph8iE6YicFVRzXNb/d2Eh7W/NnXOfGW/p2/Rc49nj/gs47RgBuDWGm3T70Rw8cSrs93o8Oi1e1swot9MsZVEJQ8z/PK+VRc2Y7ymtagUm0f7K2yPFQGUZ7MDTzPFWZzoMhXoS7DTlnn+luCQeg0ADLFn7ZIIpjg4Dxc3Zg0zVJ/KtYMz0DcO2cp67IN6tEklox3No7pFa5HQX6D1GifzMmSAZ8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZACoz7kd0fmgb7L724A7FpD9jxsBnOjQtG1x3Rw41U=;
 b=jjg+83mE9P+KLPVFGTFWKhb0kXDHS1byyEaSVNfV9PNYaCnJQxhWkRShKcPPyxqRkVU3kQ6adduYf+ipA0Z/SVbSdnNnK0q4wPdr6v/3QYE+n6+E3/jyo1acB++qj4AwQmfvFduMkd7+EmkBeAyWsz+33kPBLYpS+ZnaKby1kpl9xl3uB1h+BlVRCVOcrlwDz6lNcbPBr9qTXss68eSbEBV142jMJEFx10G2id5fdTw6egzLhCse0XX4nbFRp5CC49iiQBoFw5vQR+iUEL2cYUfG3mqJkWEuiIaOL4KAzLpbyp4IUYQasSds99izZ3VqLkzML60rU/k1JvHL6fJ8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZACoz7kd0fmgb7L724A7FpD9jxsBnOjQtG1x3Rw41U=;
 b=fhL80jMnqMShx2Kv0bqeZbs+ursII4hc+RdqeR+gDNlmJqhYCI0VQ2vkvuHVDPld+uJjadr72HkZcJAR9aVuhGzJ1CJ8hp/AMnlTPWFOle5A69I9uB1whgIYPKV25U9uhKx1Jxc71CGTJM+BT3uCSNlXxKx0h5/wc6qeIHW6Zk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 20:42:37 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 20:42:37 +0000
Message-ID: <9a6a152e-1c60-6300-88ce-85b835d3d198@amd.com>
Date:   Tue, 31 Jan 2023 14:42:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 7/8] crypto: ccp - Skip DMA coherency check for
 platform psp
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-8-jpiotrowski@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230123152250.26413-8-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:806:d0::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: c009de12-a127-4e83-831a-08db03cbb050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQgZf84a1B7wfxxVJAl+gwJ18lArfz3bh5ZSQPwtcenCjrznuygEOzlya3bfqgkv4W0FQK/1IbcF8yPO7KFewXzIJgVpUTJwcnu0qQ1lE5Y4cJ8CpShAnr7MmflZI+UpDXmxG2BcyeT41m+ZTo4oskwTgGsfyPzp84kix3fEfmn+ituQGmKJVx0SfWRUUOb2+hW8nK6C8XXcIsxRPdWXscm1slpy3R915kTDusrGaMFqxTw5NuFDdJYAJ7jJeuTPYw81gPN8SbieKrLnH1JzhP3hxcc3enp7C6vDxemIfp3SjMZ245yeWOo3D3bD0wb6YFK+XH6SjKX5RsUAZh71XKcTYR0nhowJon7NJ24hP54R+U7naHzx1WFvh1P/siacr9RWnxqOTRVAivYmrZTFU+g+LgD26t0BnvJHfq/enCFaPEHrtq2myH7EGfNuJYBCv6J2aRdCIZiTbIREhCrBcf27VM+ykK7PxqmH1h6uqcbI/ChwcHBq9QJJRTxSrEp6etFYZ0Yx9eX7swht4WOPxNWREaeZeK+9t99wlJaY4+ImzDIpVKYLRYjGxIg3OFENyqB5VdP5yWPEyxaYxafBakNiXM9Jj0O3KmNbBUkW5D1V1MwLyRFg+b5Fd9WmoUcZoUoRUOg8vpGdQmMzbIIE+XTd5uF4eHVqXu56B5yzXQZdfXK9F5IeE2KM/b8GgzT+xqqCZv0eaFKiKlRhqWxOnqIOOGz9zeXZRCIWc8w9htg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(66946007)(4326008)(41300700001)(31686004)(8676002)(66556008)(66476007)(8936002)(316002)(54906003)(5660300002)(6486002)(83380400001)(186003)(2906002)(36756003)(6512007)(478600001)(26005)(2616005)(53546011)(6506007)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJqQWpzRU9hWGF3TW9PQzlUWVRHVkRURUFUeTlwVlhZUHhRNXJEU0dKa1NE?=
 =?utf-8?B?NGxWMDVUa3RMaVhBRFhYRzlyMVlUN2RFd1ROai9zQ3F2SmtvQi9JNi80UmN5?=
 =?utf-8?B?d0trMjh1WnpIZWVwQTlnWnk5VmdPbE5wU0NFYWNqR1hPVU5tNWVvWVFFUmlZ?=
 =?utf-8?B?YnFjUkFJUktULy8yZVBQYnV3cjZwS0RlS1R3UHVhOUhudUdJU3JOaXRNbmd0?=
 =?utf-8?B?TDYvdTlMUzFleVpsTjRPQjFlQmJ2aXV2MnV1bkxWMmJzMzVCeW5zdkFjc2Zt?=
 =?utf-8?B?L2dpRW8ydzQ5MCsyTlBLYUxrMDdVWnBDakxEOElJOC8xK3BnYXJ5Vkl4cUVT?=
 =?utf-8?B?S3FkZzM5VERRTTRqTUVrckNkaWdJRStSRWtvQnVmNWEwcXNuaTQyYUNORmZM?=
 =?utf-8?B?MkdKaXBDMThuNmpFZ2d4KzlrUng0dnZ4RjErRFBLSTR1VE1zc1JnT2lSUVpL?=
 =?utf-8?B?NzJ0QWordTFaNUtQZlp5YWZSYkQrMmhwRy9oQlJGWlh1TXZsMnh5VXlvdnU3?=
 =?utf-8?B?Q1E0dmRuRnBBK0RBK2Y4Q3EzRU5SV2t0dmd2NTVvSjFhNWhuRXVmR2tlT3c5?=
 =?utf-8?B?bjhlcmsvclBGZVlnUXBNSHBMd0pEcFUxR21IdTBHTWR5bitDTEJLVW9tbEFk?=
 =?utf-8?B?SURQZnFNaFF2VE5YQzZMNENKOHdiVnZBSXBpSmJQYWp2bysxb2RLQ0xMdzd6?=
 =?utf-8?B?WnNxeG5ZT0JSRllwRy9WNnNYSFNGY0c2bHlxL2xHRWFWc3kxbUFZRkV4TWs0?=
 =?utf-8?B?OUZmZnM3cGNYMzZ4RHVmcCtwMGZGUWZwL1U5RXFWU29sbWRwOFIvd1RWMC9G?=
 =?utf-8?B?eFUzdEZSVkVTVWIxNXB1UGdGR0ZnME14aGdnbE1qYUJLd1lkbldJQmVhbjh5?=
 =?utf-8?B?N1M3dTJLVzkra3lNYnBNdGs1aStVVENRWXgxQjd4ZGZlWndtMVh3TmxaME1V?=
 =?utf-8?B?NnFMcFcrSERqdlJid0JVc3RESnpQSHNkMXJMandPQkVNd25OZnViV3VVcjV6?=
 =?utf-8?B?cnNaVnRzMlhuVU85NXIwbU4wSWU4elhWL0tRc1NveHhNQXVYemlOMXFVR1VS?=
 =?utf-8?B?U3BNVm9iOVQwTko2ZWlCbHVxSlpqVU5hUGZnYVFuU3Azb1lZeFdiK054OTB5?=
 =?utf-8?B?akZjeTFQeXNBQTI2YUY5QStvZzNOUTBlanhtcGtoUzEraGdKZHB3UmVWK3dM?=
 =?utf-8?B?bnVib0k0d1FJRmNEY1BMUHliK2laUFlydGF3U0xtUzhsbTRIRGNzdUtDclpy?=
 =?utf-8?B?N253Zk1HbHlYdnBHd0RjemRCbXphd0xWUTNzUHc1ZDViOEJ6RUlpd2tCeTZI?=
 =?utf-8?B?SGVzREk1b1ZjS1RJeW45NnZoM203RXYvK0JZN3V6eG9aKzB5U0VVbkhjWllh?=
 =?utf-8?B?TmN1ZnYwYU0yelNKN2RLTWdZbG9FSlZJNEFubURQU2FHanZUZzViSEVlbjdF?=
 =?utf-8?B?NTUyRzZWMGJMYUdiMVN1YmJuWXdSbmVpSjdMWkVQbUVNLzNQQng3Z09CR3lY?=
 =?utf-8?B?NTFBVDA0bVRxamVEbVhHRS9GSjE3RGVaMWNEeGRHSk5ZOE1rNHBEc0MyaDFm?=
 =?utf-8?B?REpsakljd1pVT1ZETGJsY2xCV1Q1UzlseHd3bGl3UGp3L2JTSFFHRVFRTHJs?=
 =?utf-8?B?NzVUR2M2bWJuSGVNamF1VU5pVi8yRjhvWmM3ZWVKQk00Z09GNUpWR3dsbUpC?=
 =?utf-8?B?ck11Q1ZNNnJUNXpyTFJ0dHZhVVZRbkQyVko3aFlSVytzQjNYSFVQV0t0OEkx?=
 =?utf-8?B?NHBhRkdlZzlkSkhqMW9GUnFhelprdkN2NU5WUUNEbTJZblo4SmVHcVFwakwz?=
 =?utf-8?B?RENXalJGMjBqVEY1VWRTMVhzZkZ5NU5EV1owUEoyYUdvdi8vRkU5Yyt0V2dP?=
 =?utf-8?B?N2ZjR1dJZG9WRDZ2TlExSkFjZlh4Y0d1QzQzbW85YzJQaVBla2k4eURVRVFq?=
 =?utf-8?B?ZThEem02T0tZd3c3OFR0YWUzLzBjSS9BQ3pOS3JEb0hpeTA1Q2s0VnNBUDdz?=
 =?utf-8?B?cDdQQ3hKQjFraXN2TzBodzhsMk1SM1J0UWs3VVRISXNvK3YyMGZRMkp5bFR0?=
 =?utf-8?B?NG95MG5mYWRQU25kb3NyVUdnTVFSV1Q2ejlZN1RxczRRYUFpRzAzQnhqTXJx?=
 =?utf-8?Q?JJvetzL1pVB78WQrW2nRa0nRR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c009de12-a127-4e83-831a-08db03cbb050
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 20:42:37.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2feargdDvTthAxxmErZh5Fz0gBAAMW6xSrGVC7oHdAg5NOpOTfJ2p9c0tYiDfMkYcycKNqhGhOGOAPSj1EdbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 09:22, Jeremi Piotrowski wrote:
> The value of device_get_dma_attr() is only relevenat for ARM64 and CCP
> devices to configure the value of the axcache attribute used to access
> memory by the coprocessor. None of this applies to the platform psp so
> skip it.
> 
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>   drivers/crypto/ccp/sp-platform.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> index 281dbf6b150c..b74f16e0e963 100644
> --- a/drivers/crypto/ccp/sp-platform.c
> +++ b/drivers/crypto/ccp/sp-platform.c
> @@ -29,6 +29,7 @@
>   struct sp_platform {
>   	int coherent;
>   	unsigned int irq_count;
> +	bool is_platform;

s/is_platform/is_platform_device/

>   };
>   
>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
> @@ -190,8 +191,10 @@ static int sp_platform_probe(struct platform_device *pdev)
>   	sp->dev_specific = sp_platform;
>   	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
>   					 : sp_get_acpi_version(pdev);
> -	if (!sp->dev_vdata && pdev->id_entry)
> +	if (!sp->dev_vdata && pdev->id_entry) {
> +		sp_platform->is_platform = true;

Move this into the sp_get_plat_version() function.

>   		sp->dev_vdata = sp_get_plat_version(pdev);

And I probably should have made this comment in the previous patch, but 
you should probably spell out platform here.

> +	}
>   	if (!sp->dev_vdata) {
>   		ret = -ENODEV;
>   		dev_err(dev, "missing driver data\n");
> @@ -205,7 +208,7 @@ static int sp_platform_probe(struct platform_device *pdev)
>   	}
>   
>   	attr = device_get_dma_attr(dev);
> -	if (attr == DEV_DMA_NOT_SUPPORTED) {
> +	if (!sp_platform->is_platform && attr == DEV_DMA_NOT_SUPPORTED) {

Just a nit but I'd prefer to see this as:

	if (attr == DEV_DMA_NOT_SUPPORTED && !sp_platform->is_platform) {

The diff is easier to see that way.

Thanks,
Tom

>   		dev_err(dev, "DMA is not supported");
>   		goto e_err;
>   	}
