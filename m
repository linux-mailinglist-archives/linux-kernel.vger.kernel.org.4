Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0941E60CA74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiJYK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJYK5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:57:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179E38E466;
        Tue, 25 Oct 2022 03:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldSiCOhBb4ysVQQypNorkVmYy0ECdSq6OAwtKuyRkswgD8j0iEJdPyliQI1C2RztnJaDsFS7sbpmwBHzjsCmHnjF0zQ3Kox+5MkW0o7jDZYpfcLHH83Y/OH7UyzZuMbuzUbygzJf1ugJyWj1Gt8TFBZUfbi0KzGLiUD41dBy36Nf6i9AvPIMCacsnITt2CIxKriNcGc2zDeid9q/TRjfAz6CsAgfflAi5zh6j9guP3kSQF5ObU+PlT6+fPbPOM4jTZEKGCMJoF+G9mP3ja4CTkd7Kw7dl4XxMg7bv3CtCl2YcLi3H5jsiS5YvdwqUCp9tLTyj5pRYZ0V1UGX2NR97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2HoZJ95f79/Ti7l/IRjiWScnRcOovQ7e7ZQ4jCNxuo=;
 b=E2CRr7G4AiK0d3PoFHN7+PbrsfxLg3c8NOC24T+glLSDtQOW4hecWe6oXxe1oDwp2Tsmq4vzDS4gN+czrExfGEFZ8Y308lZs3b7hhCnZkB41o/cYzU692VxRoXJkAvbmXvpvgNkdUti+Fc50Z6HEwj5WRBpjLjZM1+AvW5gED8bwUmCNX5mdpM3gjCe4NFbb+kAR8Wx9kc579rXqcm0SP7aA6w2QT8PvgLogj70vgYe/a8j+8ja0mYmaP69oIdG8CiNRv2/eInk/5hiTKzB5WfYgDTuDOJuSDyVol7CL/e5f/d/1zIv9D3+h4cHlKQ2rg3+cJx1Nz8JEeJTIB6bFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2HoZJ95f79/Ti7l/IRjiWScnRcOovQ7e7ZQ4jCNxuo=;
 b=haxdK2frd6v2gcxAqW/AaVbyxXEaHOaOJ98Pxu/VlMJ9JYyGK4d3xFPBS1pUs8vvCzPvtOU7ZwOkrEId5AoOhoOfsLvnj26fE048BdRv8zEa6zIwcAwzXtXEv7D0lcGPimDdImaacUKeF03MQ8RMUoRujgO9hkkPksrb+yqwiFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 10:56:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::580c:51f2:b715:17cf]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::580c:51f2:b715:17cf%5]) with mapi id 15.20.5723.034; Tue, 25 Oct 2022
 10:56:59 +0000
Message-ID: <ca0e6dcd-7853-06a9-11b7-0deeb21e42e6@amd.com>
Date:   Tue, 25 Oct 2022 16:26:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: remove variable cnt
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024134301.2158939-1-colin.i.king@gmail.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20221024134301.2158939-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f13fce6-4496-4d6f-8e1c-08dab677a38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNn6ma24OWdyYN8vM3xu+4tZl1CExXsNXAf+terGBTvuu1hDtTgRKgeGHcx+mnKUTOU61O3ruKaP350fceD+JGab50uadulSIULHN/oocWCEYXwR+sb4HEF+6fmPwO/DenCjq/dOorj7UqUlxRvu0Rzd3pgOJjBU+XrH8L2yBqBm8OT2cy/EqbK46EGBiDjm/pcFrfTsq0ppKDwedpBsF47ceMaPVXXTuuUhlopM9tBq/os8tUPg4tVYlr5jTn7udaFUET2sLK4gRPFHfW3puo5hjvHoRYXR5oEQk7q7LiVSU2yFFxTrtoWXVyBYsfCB+6Q82wNFAtzD5ERC8CEELl9oXZwKYb/2A5cIkGPJPFAFCLzYJpDZBQxwo/CMRAc61sleIV6jE+VySndbi8CKjLU5mLWWcf/bD30ayL8a2eZh7PoTG8iwf8S+1suWxHYJu50/KOG6CDI5Fu8pvN/MGxjRxHI2XDh6bPEZE2wNGkGlWBw95cJcKcWDwltqdQryEJHWTVMDLO9PBbt77gbe4GOdSFUM26a68j7xTa+BYmH1R8vaL/qHKPFpwkbMOBk7NjMljh6amzfwZjsvXaTUsknXmUkXKcbKAHKsW9TjlmW01qdY2TRbbiYXKlsQv1Ttj3BJhhGTUFlPvL0WRt/B8PE4HdYFnaRJmczXr8rWcVd5bm7ND5+7WN35+oGIHzigcqz4FpazK996LDs4dgsKZdQaZyio2Xht/jNZeovym4krngxiWVm66lTACRpqEZxJJo0RD/ZSoChC6mNykjMdXbjcrZ99x8WnNIdRiroLuiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(36756003)(558084003)(31686004)(38100700002)(86362001)(44832011)(2906002)(31696002)(2616005)(186003)(53546011)(6666004)(316002)(5660300002)(6506007)(6512007)(8676002)(26005)(110136005)(8936002)(66476007)(66946007)(66556008)(4326008)(41300700001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpHTWs2UkdjVnFwOEVhZWE3TjByNHNxVGFDQjkrUjlydnF2enIvRlptc3lV?=
 =?utf-8?B?Yi9SSjRVVTFIeG43YXkxd3UzOGVUdUtMTk1VMm95Rm1CTjFscnpmenlTd3ZO?=
 =?utf-8?B?V1V2SDZtMTZDUGpxVFQyZGV5YkVmdWgxZFY1ZkhyOE8xeW5jUFlhME0wNzBu?=
 =?utf-8?B?ZndnQXZHaVplUnY1VXgzOTlFZDVMbjdwU3FlR2VFdUMyRVN3SzJhS3hyRlZK?=
 =?utf-8?B?WG1vOTRWM1pSY0lVdCtHWkV6YmcvSTh2YmViMTFwYmJncnV3RTBEdW4zUUt4?=
 =?utf-8?B?NktXWFpTamRlWFNTR0JSWWM3bTJPQ0N5NkVzdmR6Z3F0aVczc0pZS0lZRjdL?=
 =?utf-8?B?K1gzQVU5ZkhrTVhYQnZ6MVJDb2gxVkhhOGN0dnFPZ0RLa0FUSkpaRVpGZU12?=
 =?utf-8?B?dDNoaEF4RmN0bndpSG5iSHpMdGoyTlBUajNjWmlwZDJUK1BMNGFseVZCbDIw?=
 =?utf-8?B?dkxwaEJtNWlrY1I5U1VlZjh4NVRCVWJiZktBekRiL2hhSHNPNzJvclh5UWxN?=
 =?utf-8?B?Ym1EcTZkZktPVTJxNE14ZXZ2M0t6VUplTDlWSTB1N1k2V2hLYkIxb3lKYW5S?=
 =?utf-8?B?N0tvUnZHalJGcittTUZSVWNtTXBhblVSU2lmeWRVbFR2Y3l3ckxEenZkUlN6?=
 =?utf-8?B?U2V1UzAybXIwQTA2azJUaTk2NkJnN3phaVRJOEFkVE5ac0FhK1VWYmdyKyt2?=
 =?utf-8?B?MmZ2YTZSRms4d0pBdnlKZUI2OFRFRkRGZWpZUGd5VlZJVEZ1em43dUUyZG93?=
 =?utf-8?B?VDJGcjV4ZklWdTRSZG5aSzlwSHpCekRKWGl2V281WWI1dzY1ay82NGpybTNG?=
 =?utf-8?B?RWZybXhITnpZd0kzNzVYVjhmNFlZUitkUSt3eERmZHRBaWdSNVVxVGpaWDll?=
 =?utf-8?B?TiswZHA2Y1JhbnRycGxPd2JEWEtrQ3dvdG5UUTkyRXQrRGo1UVVoS0dSQWty?=
 =?utf-8?B?b1o1UVpDam1XUlJ2bXU4ZU1BOUY1T2hwRjhVZWNRVWZGMnNMdGRTTDlkWWxC?=
 =?utf-8?B?UmMvOUhhUW1nZDJJd1p4N2RTMm9oemFwY1ZtN2VtZFVqdWFDQmNoRVVSNVM2?=
 =?utf-8?B?RVIyb0djOVNhUUNUL3lhdGE2djJtNUxIZjVhekhBcjNsTjRvcjRZWHB6SFR4?=
 =?utf-8?B?dU9zVGVCM1JFaVl6TEtJYmcyTU5oQzh6SHJwYWl4WUxScWVjajJYSWtEUnEz?=
 =?utf-8?B?elZvMW1WUGZaVXZkTGpqVHUrNEVYRzR0TW9HUmgxaTNIUnNXT3Y5WG1LdStM?=
 =?utf-8?B?T2I2Q3gybVFiQTlwSXc2aVZ3YmJnMWhoc3JZQmp6eGZ3a1laM3ljR1N0QjJC?=
 =?utf-8?B?eTg4NHdrbHEya0YyQWxSMUlFL2k5ZENUK0ZsVkE3ZzRqRlhBaUNYM2FLQXJs?=
 =?utf-8?B?OU5mTVk0dDh2K0w0OGlEYkl2ODlSTHpLMDZHRmpqOWd3VVZjcWp6a242ZHEy?=
 =?utf-8?B?MVlLQSsvM3NMSE5JZUVsTko3QXpiSTRxMC90YVdRVmNMazc4aFg5dHVSVEhN?=
 =?utf-8?B?Nll2UlB3aFhiRWJWaE0zRlZJeVJFV3FwS0dSVUR2Tmx2VWg1ZHNpNWhHWFNL?=
 =?utf-8?B?WnNHWG5hQzJlUUFzdmRKek9SRVNWTmtxa0tjUWJScjVpREFGTXEzR0tDVzBh?=
 =?utf-8?B?bVNaeDdJMkpWamJZU21kM2hCcWZCY2tqemNRelFRNUJPaFU0UjZNeXdtVmw0?=
 =?utf-8?B?SVZ3enZHTTJVanAycHo0M0s2OUdGcFd4TkJhQ1ZlaHF3MUwreWNSWGtnRjNN?=
 =?utf-8?B?Yi9DeVNSekI1NU02TGc4UHVQeXBMam5SakhVcUdsUWwwc29pWGNpNERUd05X?=
 =?utf-8?B?TDBveXFpRXVrbEsrQW1vaXByMVExL0JGSkFNY090L003Y0hxYitDY2pUMWwz?=
 =?utf-8?B?VjU5T0crdWcyY3N6Z3dzWnVoSkV2YkI3ZjRmN005VmFKUndFK1lPaHkza2M3?=
 =?utf-8?B?bTJQaUlBeTc1NTk3blRpZG5JcjhzUTZVVmdEOEU4bUFrWlJJSE8yWkFrSGVI?=
 =?utf-8?B?bnkzZFZ4cy9aeFQ0VWM2b0p4Y3MwazRaQUJacllpeHEzbkNLdjg1OXcwYkto?=
 =?utf-8?B?dXMxd01mWDZheEk4MjlkZHFPRkZJNVc5bTF3ZjFKbnJRV2RVeHkzNk50Z0pj?=
 =?utf-8?Q?9imwATxtMFYqvv/VbyPieNGE+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f13fce6-4496-4d6f-8e1c-08dab677a38b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 10:56:59.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmJVCPV7b7FxTA5feiB77bmC/AZBwArmZK2tV/+rXJhHIwiqtCKruSc61/83kPiSoKUgOlck1EAsh2BCR0plJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2022 7:13 PM, Colin Ian King wrote:
> Variable cnt is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

