Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF96E9FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjDTXVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDTXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:21:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2088.outbound.protection.outlook.com [40.92.74.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDBA44AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgO5zso9z0BOJEZPc1efqQhVnx60Z90SrYV4Sfou72qBzIhNzDcu6NF+V8dnfqbI4OL4mEcvWXWIyL5KCFFmQlMDVEGnIu/GwjiwkkQKWgBqoQpAaej2MwDrKArCq1LGf6WC9ERXlf6nrkOYmuJb0S/9+wQ2KqFQgKumInEXbvxvsZ8iysh5A8LfGRoTmP1jRDgoniGIPgiBiXs7E/ReGpeHrYW0rdmWVSnWFbHvq0aD2RgTI6pBiy04e0tRg+iF1+WaYTVNVk4gypfVrquOSwuU9YxNIC5eeueireE4rKLtn+LxfEZdXHou3orwCiquCII/y3NtQpAy9y+1FBL9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR84gEJtlxunNwcVqFHbMeaL0M4VKGR5uw6dTGbwtVw=;
 b=D/2NW0jBKe35W/MR+0W9hQARl1sjAJD6Ng5kJ46/5L+KsSNxK/XIz6zSaGi4pNmkPKkd2Is/xhLDFQyxqZcHoYEZMjc0DZDo5pd7281u9ETW8HBcblqdN61RoQ+zR+SvmbXGRKYxAgqpuyBxjROrFhcedGBjOIniKDwlrfOgv0rJeCVu1PtmpMU4vF7poJlQ6yTyJe/lh+VwgSEupZuZYQ2Lzr6eE6kcVL+J87zjXohZC8/TVK1iIq6xbbfH3Tntc980sZOgyXfLnveIAx7uOJtzD7Mo4ilWPrmhbcEhRuzQGfpSyAzcudaaO+L6TCfFuMO2YN8rWbcZWPl5NKfjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR84gEJtlxunNwcVqFHbMeaL0M4VKGR5uw6dTGbwtVw=;
 b=tbvglf3aCUkpUqUGJPRO/PDAxY1SLOuOj5H8Zt6xRagDXSRk89jo2lS4BiYp5FyXsAFtxPoYKenVNJih6xjQDRIHriY2UglwDVfDVCSqR5NOgVY8FAXvqvwxiPa+5un1TQXiVZL12AdKgq2jTm+fa/NSHQ3PVCT05RnKsQdt+yKNvHNvzVSXS3dlMKE8Cui2V97XQdil35Xw2846UINM7TYxW9dMNbHDgpXe5ggiHvG1vZCkz8CHCVmkWbcj5iqoOlR0lPxP9n1TuPxGGxwBeCXtqSBlddO6b/km3vLWP5bmvmyl+5MqbvW76a4F/oOMz3hMB2XWTMkxHt1Oyb2b6A==
Received: from AM6PR03MB5282.eurprd03.prod.outlook.com (2603:10a6:20b:c4::23)
 by AS8PR03MB8641.eurprd03.prod.outlook.com (2603:10a6:20b:54a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 23:21:01 +0000
Received: from AM6PR03MB5282.eurprd03.prod.outlook.com
 ([fe80::5368:6b00:2ea1:d1e5]) by AM6PR03MB5282.eurprd03.prod.outlook.com
 ([fe80::5368:6b00:2ea1:d1e5%6]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 23:21:01 +0000
Message-ID: <AM6PR03MB5282A3F802197E17BD55F5F993639@AM6PR03MB5282.eurprd03.prod.outlook.com>
Date:   Fri, 21 Apr 2023 00:21:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   =?UTF-8?Q?Andr=c3=a9_Albergaria_Coelho?= <andre1coelho@outlook.com>
Subject: c exceptions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [PJPSGJ+b4xOxK9xUTSf9j5peJRxqRdNCTbqmavyC1KvZoWzoU1FRUUKyQ1MerbSE]
X-ClientProxiedBy: PAYP264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::8) To AM6PR03MB5282.eurprd03.prod.outlook.com
 (2603:10a6:20b:c4::23)
X-Microsoft-Original-Message-ID: <70ca4071-0622-cbd4-31d3-6070b6d7e3c0@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5282:EE_|AS8PR03MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0f0517-143c-4aef-6ef0-08db41f5e7d8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L83ecUU0H8fEmLQgY35GVuPlIPAN1yRDlVmK3Z4v8XBO6QR9jwnf977Wnb+5qMXfpRomvqoVHUU0GtgIndlB/6Gv9nSSw2p/PG4UI8jAhj8rzY9fdoypTmK1w7pnwbmaksmUYpyHk0z/lx1RXQ11FJ1sUEKK1YdM2QCLlONE5rVeolSFqWeqTkGmyCWgV55kLm1aQovYp9Ojs41+w0QDMXaAi/plnAkKXlsaRMthJvkUms/Qp4KuFIdq6qHejW2dG6E8esKMcHdMwT+J8BwTSk/rL5+tYDsIsBxKXIF5pVhazh7eRoheNmPe4Kacv1Zod5CflNTqTwOwnSbrvXQXYLaG2HykjQPl555xRz9t275CTGUyIYdK26NlkvRDGqYYu9clWzgW0GQxq7kjoKtW26FRS1/wjsMKUEs3zQAIA6mlILPm9N6nvu7+1CkSZv+q1g1K8tTJxBH8uJ93daUe0359wB6n4fCuF6871QXWw/SfcJi63wURMvHu5dxBjhKc1VjyH734WCp8uOp5G1Dc2ifQGh3pV46zhVwD6s4tnsw4XvGXSQlR9zLc9eBMApXX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW9QNnFPbE5ON2taNXpzRk8yQy9tcEJxWSswbVV3MURGVnZQUGxHR1kzYXQ4?=
 =?utf-8?B?MFZFbE9lMURJRWhRUS9CVUtpR2dCNG9aQUxKc2JkOGFyeFZSTGxnc2Y5dEIx?=
 =?utf-8?B?S2VEVXhBZUJaTXcrWFJsdWJoN25hVWJIbmZCcUpDbGV0ZDhsN3dZZWhTVEY2?=
 =?utf-8?B?aGlDRFZBWU5LUzFjSU5GN1RpU3VFcUt4YjVRdzBjclZXS1BDRjJzU0pqM3lQ?=
 =?utf-8?B?eW1YME1wc1lzTGsyaUxXdnVYUUhiRU80eE5VM25qZlh4NTVlbEExNTNxUVZ4?=
 =?utf-8?B?VGE5NUhQTWRrbWsyZUFXd25oWjMyRU9sTkEreXVKWTJwM3Fpc3M5b2w0Zkly?=
 =?utf-8?B?ZjJqaEtPVURDb2hoS0JVR1ZWT2hpSEdIS05mY2ZoaVNYREU4VGZJUFBlUGp1?=
 =?utf-8?B?VGtaVFRvY3RZNVlPb1U2T3FJbmJ1dUY5VEcyQXFQWGlCb0RaTlZXNGp3TEZl?=
 =?utf-8?B?OXNzb0Rnb2piblkxMmhIcGNMK0IvVWJ4bm8ySHJod2hRVXB0SytZNHMvcTRZ?=
 =?utf-8?B?eCtuUjVUOXdMV005Q3RGV1dZaE82TlMrb3E2TWlLZFNTRWdhVDBuMno1N0Ex?=
 =?utf-8?B?bmF2Q1F1MzF5bXlld2VVUnhxN3ByNlRKTlo0TFd0VnVWU05oTjBYSEFYOFZE?=
 =?utf-8?B?TUprcDcxY3hReWcwaU1VWFJYZjNOckhjR0ZndlBYSHpEVGFLSVFLc2VSbGFQ?=
 =?utf-8?B?OWFnNkh6dmN6dVl2Y05hY05QUDgzZndUME1jY1hHUEZscnJKeXYxamNrSFYy?=
 =?utf-8?B?M2FDZmRZRGNBbmhNSzZtSkRsaFdqWVVoYmRFNFJZSjluVURDdW1icGI2YWF1?=
 =?utf-8?B?Mnh6TTdhUlRIQnh4NU15dlBGTmhvNFVQUWNVSHVEcDRvZVU5OVdEeDNQSWNp?=
 =?utf-8?B?a1gwNGlkVU5KN252eVZtTlNJUnNRNGEyL2VydWlodFE2WlRqWkFrVDBCeTFR?=
 =?utf-8?B?b3JORHNyT2dDem9BU1kzOW9QenZIMTJqb042ZWRsSjR2VFYxS29LcUNkbzN5?=
 =?utf-8?B?eXpQSVZlenAwVFVsYit1N1ZiNTJtWVF1OWhkUVB6NXQ4bGZOWGNmUkVSdGRL?=
 =?utf-8?B?ajMweUtycVZSNTA1dE5VcnpxWUpsZFAxZTBWZjJHMFdGbHlVYVB3WVFJcndC?=
 =?utf-8?B?dmhnK2tUeUtiSm1tV1BGZXBPa2VNdmJJTjh2UlJjTVFaUXh0RTk5NjhQaVAy?=
 =?utf-8?B?dlFsVXlEc3dHR2ZvVHlnbFUzOGNEbmtXYWMvekNrMms0N3JSUUNPNG1LVlJV?=
 =?utf-8?B?UndabUxQaUJ3TFNiZE1SK3Qza3BhZERMRnNOWFc0MW5OOUw3amFQVEJVbmdI?=
 =?utf-8?B?cDdFUlVEVzlJMVRvaE51c25HTTdud3h1TloybndOS1ZJdzNCU0VzaHNzWU1o?=
 =?utf-8?B?NGdUdk11MGNzVEp1ZC81Y3Q3dWJjcTVYVU9oa1drTElTaC9GYWdUajY0VGFY?=
 =?utf-8?B?aHpFSnVlcnZWVzdkUW1GUFhCeHBYSm5YcE5jTlZMWGdsQW1UV0toaTVzUVhU?=
 =?utf-8?B?M2luaFgrZlJhUnByNy9iaGNHS3NTTkJqV0hjV3QreEs4NkFuWnZQQ3RUUEdv?=
 =?utf-8?B?dU5tdXRGaTdmMUdGUHVESUdmS0FIVG9mZXcwZnl3MVVxTHlwU2RJUWhmQlht?=
 =?utf-8?B?UDhQSjRFSi9CUW1SelZVZEVPdkZqNzlxUys0a0xnQ1BvRGhKZjg5MllpZzlr?=
 =?utf-8?B?RDVlUmRud0hvWWlCZzlYRjZ3VWloRG1UU2FyWmtqR0FGdXR0bWtJcHYzTVBB?=
 =?utf-8?Q?7HbmRHUIYhiXH7H4ew=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0f0517-143c-4aef-6ef0-08db41f5e7d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5282.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:21:01.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8641
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

what about if we use, on the c language, exceptions?
use it on a compiler flag, like gcc -exceptions
use a pointer function , to handle the exception (as in Java, catch{})
use macro to define which function has exceptions
does the exception throws another exception?
what happens to the call stack? can we print it
what happens to the stack? (if a function is used as a catch statement
Is the exception executed on a {} block?

thanks for time,

andre


