Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049786EF6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbjDZOn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbjDZOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:43:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D07280;
        Wed, 26 Apr 2023 07:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY2zhtSPEDjo+O60MV/oYDL27ZOKvm0QjJB8nk18vpo4/gIdIbka6jtM1N22H8u3T4t5ft5/nE0J0u1iDVE9VRR5gEpA2pq3g4DEXdyWUkGx1wNumC12F6sZzJOZdaVTeh24xvm5laer3fFv9q6xm4UE85gyuQTpO2byrmwE4vxEun6fxylE6teuTbmQrB2xmMlpyZiFI8XMpZY8UU9CqXnW/5bMm/PI8WWnmySebwYeOrIRjy5+2AQW97KXkmZquswn/oCrSjzdD8u2/Kh2Fwav21d9fdzHgSZGg9KGsKchHsM0bkdU5AC3A0g2+RuIfo2IPnvQSavACI0ziM+Kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NjjPvdUh/T+FZ9ka+45Eb7lAExVImrB3h5fK8H5lAo=;
 b=mJ/JPevQGchQ2H3YhQTJdxbhKYDxzR0Bt0W3rpZpKyF1ilgmevDjSx8LPRnW5cc9VjT6VWZvrxK9XXyqeFQg3Rm41y0TeCe/Pd10ca3ozc938MQpH7tLVXv7ETSqWZx09ZDzC2By+fgRqT6ge6JiNQFoMtnJXlGE6BHPrX0YNv24mF1l2+2eM/xXbv9LSaxBNu108m+b19J5wpYuOqqm9VvYedlIfLN4crw1dRqXpRxgXTZ+GfymNiqHcWVhEWYJ5GkMuP4Nlw5ZqczyxGTxFLan83j2ukrb9DLRdBxez1lxd4dir0AlDHSRHAytgPrwjO+v8DczKtxy76d4Hk4bJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NjjPvdUh/T+FZ9ka+45Eb7lAExVImrB3h5fK8H5lAo=;
 b=SjBhK7N9TyIwCr+VrVG1p1ttOLEROpKXYULZpUdCTU8r5Fq3Kr82vIjiV82HvZzEZmAgr931i6tAyQ+AhDbECLQhfxAdB5ZwQ5hgatMcKaim0NtVpp+uJiuB/kxg3bPuUcgO8jjRuLiGdtmhl69npXoQkHHwbJSBtS4kI+BnRUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 14:43:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 14:43:45 +0000
Message-ID: <e3e2d438-6d97-57c8-90e0-8fec874ad43d@amd.com>
Date:   Wed, 26 Apr 2023 09:43:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/10] Add dynamic boost control support
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>, linux-kernel@vger.kernel.org
References: <20230420163140.14940-1-mario.limonciello@amd.com>
 <ZEkrZ83fFwiweCTz@localhost>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZEkrZ83fFwiweCTz@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0050.namprd05.prod.outlook.com
 (2603:10b6:803:41::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e46a3a-7562-48a5-66c2-08db4664a357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qy2ccg+PEy2EChGayT6qnNeYILxONapYkagqCJULIzJmssieKOOJbbU2gJC+bd8cy4bxgD3ymBQSc4dME8zOosBR5v5un8hE9axYpCpfcCtTQ7KMyEJPpLp/oto2byrNud2qSQ1ouUwgXQLZii6JlhD551DxGkoEyeVfkvxXnLA4VaesrMa+bNv0BaRfJqM93D1+ps61xp72MD4Zc6IMaFdiA7Z2PxQloF+x+sFMp9G2LfBgC8lna2OHZiXN4FoSaRwAiaNMpgO0hIZlbo7UgzJGBQ0AUKguBsm19md9ydRlY9ZyaVm0dGAbw+pFTAhmBXGLmAAgPV93GNxaB65wI5lY9upH2ShMw1DvTZI7SL5FeS6o40++o6ynE/1WiOyEtg8LHr9VlTqeePUyFrmXBpexYlc9AbNUWNl93T0cGVPQH3KI3HL/9Q+NI/Qeqn5iqYw/PFgYzqK3f7EB9UgzA9pcgtqnjR7T8+8SJLU2F5YpztbyiM2VmsRQCJKhmk4e9dep9xS1QX5JavOGO9cLiQEAho8BnhXdlgrN6dzbUVL7SmXsHuvi5P8C4yxrPinVSaeFUPO+kdCVT9ZH4IY4A60oTBf3gBL7K3P0vpLZ+L3Te71vWs9807o+5yhw8yj/fYwrCrtA26hjFc48mR/aCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(6486002)(2906002)(6512007)(6506007)(2616005)(53546011)(4326008)(41300700001)(6916009)(66946007)(8936002)(66476007)(66556008)(186003)(316002)(478600001)(44832011)(54906003)(5660300002)(8676002)(38100700002)(86362001)(31696002)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkk1OHVtTmMycU95dzgxTTVsbGFUdUQvRkhVbXROa1NqVk1ONVVpbXZOdTRU?=
 =?utf-8?B?RkxiaHhXV1Z2ZW05ZTV6MEVtZUVzVlpDVjVRb1o4L2FhbHlPUUNacjNGMkxN?=
 =?utf-8?B?ME02SElZZkFtd05FUGN0MDJQWWtTRUErNXU3QTlDYmZXNVY2ekhvVFhscm4y?=
 =?utf-8?B?N3RoVEViNmhlMW1xd3h3YnkrR2xUV3N1dTV3WVl3S09xZkNsc1ROOEc1dHBz?=
 =?utf-8?B?UWJpSEhiQWZvU2RMSFJrRGVLL3VOQ2ZXUjJzbjhoZGRoTTQ5eGoySU1UVjFa?=
 =?utf-8?B?TXJWbVhsOTlxOU85WXdNeWJFWXUxWUJ4Vzdyd1BKM3JhTExGUFhJMTh0Wi96?=
 =?utf-8?B?eG5FU0cza2liNCtqU2xueUdFQ2Q0b3B1d3Z5d1BSQ2orTlFzaTFNMDRCZmla?=
 =?utf-8?B?c3ByZzZES3BLOTJ5dHR5Y294M2xsZGc4M245YW1rek1lUjgvbHFuYXp0UVht?=
 =?utf-8?B?Rk1wNXZRWTM3T1FuM1JWK0xlT2N6V2lPQ2NXdnR4T3loWHhEdEhzNWxUdDkz?=
 =?utf-8?B?M2crV2wrOGlzZDlkSytETVU5SkpYaWtqa3ZBaUZESlhiUEFyb2V6QWw5M1B1?=
 =?utf-8?B?MTRQNHNack80SDg4MnJ4cWtUa051TDhYR1NubFZmWkVSZTgweVhNdm00aFc3?=
 =?utf-8?B?K2lvSjZVUE9HNWJOUDlwRFVIQUNjTEx1b2ZuTWVhckw0eVp2d0xzL014L3h5?=
 =?utf-8?B?aTdlRWxobVVqNEJlS3FjeVQ3ZUErTE5ENi9QTjI0TWsyc2lyaWxrcXRyWEJ2?=
 =?utf-8?B?U25UblB6YVlndjRZR0ptM2tSaEtRU2xMRDBwODZIdHRPeUhreXZla0R2aGVV?=
 =?utf-8?B?OUdEeDVqOUJOeENRbjduZDc1eDlxdFhZVzhaaXhmbVVvM3FCbk5CVW1Va24w?=
 =?utf-8?B?UmNkTGxESTBJZzJiMUhqVUw3RWkyRGFEM2Y5bnNVU2psRHFvajNPUXA4RlVF?=
 =?utf-8?B?TnoyVnVJYjQxZ3dTTkVOVkJOSmYxSUJicWoySnRzYzRKM3FVSjNRSlMvenA5?=
 =?utf-8?B?YnJqVGlJb1ZiQTdpWlZDWUc3Uk1qNUFuT1hNUHNCRm9mWjR1NEJscDlzWXk4?=
 =?utf-8?B?ZWszSjFsZ0RBOEVCeFpmamJ3LzNDWHRMdDZPdW9HTXMvNHdlRi83M2drdE82?=
 =?utf-8?B?NDAyU3FVNkZQRWlXRkJMZktmM1gyQjEwem1OaVVwMzA0ME14MDNpN1JCZktr?=
 =?utf-8?B?Qm5kQjlBcVpQU1c1cG5Fcm1kOUFDa2NmdERuLzVlRHhSbW90U0JTZmxXOXUr?=
 =?utf-8?B?cGJQd0kyY3FBUTNydnVTWjVRQlp2Q1R2REhkdi9jbm1saExZUzVuckpaMjN2?=
 =?utf-8?B?bFNPQUVhaFZ4ZEJQTVVvRHhQbjRKMFNEazZaWlBMTVBQMzVDbUU5QmViYXVl?=
 =?utf-8?B?UXUraGIvK3hDRmFzQnVkVHpJYURrRGFUaTBoTE1NbndWdE9xMnltUnNrN2xO?=
 =?utf-8?B?YzgrRzlRWHJ5V0NDWTByak1lSFlqbWZDcDNLbHpmd1dGYUJERkdkNnZWbCtQ?=
 =?utf-8?B?ZDUrSlMxVjBMaEFlYXY5SXFFb1Q4eFI0cVRnZG9obzBMVnhQbXdYSTAyejky?=
 =?utf-8?B?ZnhsV29SZHRlaGdvVjdObmdxcUt2OVVhNzNCZ01QbmQvMTArZWlFb1dJTTFk?=
 =?utf-8?B?TzFaNjBWOTBzNCtKcVJhditBa080WWZCRjg0eVo0bGplWG52VmxveE51eXVa?=
 =?utf-8?B?T1JteC9ObVFtUGVmSVZxZDlwOUxqQVhhZHNKNHdiWTJURjdZQ2pTV2xhK0Iw?=
 =?utf-8?B?ZE1seUZZbUVjbHcyZW1Zcy8wRDlRNVVXWmxtOTgrV1hCSzVOMHRHejRYRkpo?=
 =?utf-8?B?VmJuejNoUzNibTZPTjU2T3QzZ3U5RHJxbXU0WHZ6d1pOcHZqcnFxQlpRVTVB?=
 =?utf-8?B?UEU2TW5kUlhsaHRaUy8vR0VtZDdNTk94Ri9iTkJDcVFuTXhhMTN1ZExFNjVi?=
 =?utf-8?B?R0M3d1N0K0E2TXNGa3paLzVQYjR3Q0tkLzh5M3R0Z0thLzRxR29qbG1PWm1v?=
 =?utf-8?B?VVRPNDM2VzZIb2xXZ1JRQ00yaTdrZkY1bGVIWi9BRTZiMSt3UjdpUXg4cWVL?=
 =?utf-8?B?QWV2VDZTUVVXQjdnd014M1NVbGVoYytxT25RUnU1cXVqeWorN2xsMThtMWlF?=
 =?utf-8?B?bEhlbTZSNUEzN3YyWWFzSmdoNW40ZDZEZFZ1ayt0MzZWQXlCTkNCKzV3NDA3?=
 =?utf-8?Q?9qV6AmAHhJZKqdZ+WaXLO9AGy6GvFhTuhdwJWJpyp6Bn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e46a3a-7562-48a5-66c2-08db4664a357
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:43:45.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ui4aKDxRrQSRdAUxr62nk0OOPLMD5f9+Skq9GRKNCNZRQCG4W22u5AC1RcWHnK/OVPNIFOQkeo8J0JfHBoMD0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/23 08:47, Pavel Machek wrote:
> Hi!
>
>> Dynamic boost control is a feature of some SoCs that allows
>> an authenticated entity to send commands to the security processor
>> to control certain SOC characteristics with the intention to improve
>> performance.
>>
>> This is implemented via a mechanism that a userspace application would
>> authenticate using a nonce and key exchange over an IOCTL interface.
>>
>> After authentication is complete an application can exchange signed
>> messages with the security processor and both ends can validate the
>> data transmitted.
> Why is this acceptable? This precludes cross-platform interfaces,
> right? Why would application want to validate data from PSP? That
> precludes virtualization, right?
>
> Just put the key in kernel. Users have right to control their own
> hardware.
> 							Pavel

This matches exactly how the interface works in Windows as well.

The reason for validating the data from the PSP is because the data
crosses multiple trust boundaries and this ensures that the application
can trust it to make informed decisions.

