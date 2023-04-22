Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39916EB99B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDVOP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDVOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:15:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC75D7;
        Sat, 22 Apr 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682172924;
  x=1713708924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YKxfAIXYbCuKVr9KUIAjXZk554UzEpZHgy9kJrobFc4=;
  b=XY7e5SWVmMzm1v/fGTvtk8GQ8Uis5tT9i6pdlOUyH7MwS1FsFKvE63kZ
   Q178iwR06Xf9g3lz8IIZRzPD/TM6tkG6Tyi6EQCQoetG1+X2wus9Hef53
   SrMpRj10BjYfmRpMt9KagL2OUtQZYaEIfqyHLs+ioL6PWlnGjk7NFEWiJ
   WyxPmaPSbwXDvlQEVpxi4DJr3HB6KQuKm9WfF7ezZdSyx5Hy9oddphqF2
   tEMJhWQ1kQm+Blmxkw0E7PXLQYv5xRYcOAdT793PbbULyA8u1psFrbinZ
   +KQn7t8/V2WlSR2Q5hwhQMQDJh1wYVh0/UNODPjXgOkwElf9kvzpBL1bw
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGTM03JqAaQX7g5fhmxBX49p9BvI/NldH4Bb7kCa8yoW1iHTKznUA1OdbtvrGCyJgL2b5ZpYMLMXtqJCK0FMcKcov1gAOxVLyZYhlZjwXo3GG98qUTG8R9LP0olYTj9wMXwT7wraKAiQt33X9dgM652GkRYu1a4BztkFpyJPFVXUQ1i3peGgMOOwN5JORiHCu36M/nAOn5oZBFxliBbNy2Kyc1g9qYoOE4WFdS1M7LDq2QE0UJdELzxj7OA19kNUo+aXa0ZC3X1F05aN5I3oSX06x5BgZOJyEfTMne6ldxqqykthe0qrRk5nKmKfvvEcJJsytV/eCEO5ytuUu8NCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKxfAIXYbCuKVr9KUIAjXZk554UzEpZHgy9kJrobFc4=;
 b=lSzNvFPnVRJG6hVH8ILyBcugZkUFBYEo2MXXJ1od9vSs6jcK7otnTvAokBLp5jtj+k5QMIcUsZGdwnhXyndjY+b+XujcR7Y+tXXDknEz21383NUXwF2U2EvgGmGRLPqvxPnCbW1tnoJPickei2e9e6wOuQj06xIOwTXNK0qHv6ADtv/nigMni1yBAFYChZwoQkBnsdDxcUgg81rwPHCuqUBosiH1G1LFBwH7KDyypjMKbOquU5eIzWcBke4nBd90Yvj9hnAoxZnlJKbjUtmJZvlbq/P1YukCbi7Py0FWpMVomgJpTpGCpZOI7R+r7UzinKrb4qaluoQWJ9qQYejKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKxfAIXYbCuKVr9KUIAjXZk554UzEpZHgy9kJrobFc4=;
 b=ieARTXK83WenBNS35DsWKNQZc8nL6KVsGfsa/vX0wWQhegdJA6YulVH8nvzKVYxi+UhotGmG/8E1UBfj0hvhGuWJSwjx7ss++6R37TMf7JjVN6l0kMhFWAiWZxOb9/XU5vveDxFxHkdAgpuQSFnbre7F6udo0cIPIt/0FSF3q7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <d92007ac-61e1-4328-f387-2b4e394977a8@axis.com>
Date:   Sat, 22 Apr 2023 14:14:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: mpu6050: Add icm20600 bindings
 to mpu6050
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>,
        "Jean-Baptiste Maneyrol" <jmaneyrol@invensense.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>
References: <20230421071630.524822-1-chenhuiz@axis.com>
 <20230421071630.524822-3-chenhuiz@axis.com>
 <b406dd13-fedb-0e6e-2f1b-ad3ebb617dc4@linaro.org>
From:   Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <b406dd13-fedb-0e6e-2f1b-ad3ebb617dc4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To DB6PR0201MB2440.eurprd02.prod.outlook.com (2603:10a6:4:35::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2440:EE_|GV1PR02MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 786c834a-9496-4368-9fd9-08db433bfe4b
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toACziT8jwh/PVW+yVI1cMZv/rTTo6tyYxXu5BxWGLCnLoehS7omEMp0zPl6w4J+j1QoALXE6e7jTc//SAz7NQDeq8Lt+J2YduqqtsFRUhropRUlTD2aye2+s4XahalbI0AT32woju371AGT9FFXcUq7mDw8AeuOr8GdVtISez6Bnkv23jANFeNuDTMcPwyfzOUnbkJX9vmSOSqtF55cQIRJH/B9Ra++rd9Zu4H9vVmjkjcHDapjefKdC5KfSma1ctaoZfNqDZOYWHMr0vd2tzz09wfl9Jb/KeGFtMPRPKVbP/OLUYNTE2RmwpGbXoB4S5INbdQPKK/EJllVU+dwJfeccJ5Td0Dtetr+nL2IDUvj0tBBlFqrTZXp/567NHPV0SBw0Ug5hAr4TT5bMpsakl7CzaXPtcbtRB1m7GF/Z/7Sc8bg8j11eq6+zn+EMy6nnwRiKWePpaFvlc/m6Ef0pWNt0pK95GAhmuGbmDWWgQeNQs1ePw5PT/fFM2W+8eAFCaRZG04CMD0oDR6SZAnAZr+xPPVQgNJwCBO/pm7d/9+LICB2wg837uDchtX3LvRP1rNj1GAU3vKKUdVaT4QoRMi9Z64C6C2CM+pGtx5n+GFctaiGoYTFHp9QxnrU1/s4g+dw7WRX9Ttj4eryq9VJ7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0201MB2440.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(346002)(136003)(396003)(366004)(451199021)(4326008)(110136005)(316002)(66476007)(66556008)(66946007)(478600001)(6666004)(6486002)(8676002)(41300700001)(8936002)(5660300002)(4744005)(2906002)(31696002)(36756003)(2616005)(186003)(38100700002)(6512007)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNFUHBzak8xeWFBTk92bVVWU3BBTFJiWHJucGFJZ1JOSEtiQWg3a20rTDlY?=
 =?utf-8?B?UllkaFdWTFYwNk5BWktpMUxYRUU4NWtSVXZNb2lHUU9DZWNMMXF0WngvbmlJ?=
 =?utf-8?B?UU5WNGVxdDRqVWxUMVFrUFczS2tFQWNOU2ZhVzNLQWd4ZUxwVnVnZXd2WGh3?=
 =?utf-8?B?SU8vWURuRkI3QW5IdjZqY3BweFZzV3RoWDZWaHlIOGVSUkpIaFRXZDJwOHp5?=
 =?utf-8?B?VG5RVEo1MTh0Yk4wWktyQ1dVaU82SHFjQ2piVnJBbEFBbjVGa21TTGNWbERu?=
 =?utf-8?B?Q3NMMHFBSGtIWTRPMjFINFlSYUVma3V2elZIZW1ZYjVXK0hlaFRHQjVIQjJ3?=
 =?utf-8?B?RnI4UUVMdmF2MGxWSmV4ZEdZUkFFUVJaeWk0QnJZSnZVb05CdHUyaGpTSHZs?=
 =?utf-8?B?L2Y1NTV5TlVjNWYveFNCUFI5MnZuYml0cE5XV1VxNHR4d2JNSnh5cDIxMG93?=
 =?utf-8?B?bGhnbmtKMVRvdmc2RHJ1RXpXM3hhcFhXbFlhcUpYTmlLUjRKZDRZa016VzQ3?=
 =?utf-8?B?a1h4ZFo3U05samt3aUc4aXRhbXpESWZGQ0pRWTFWUG9GZC9zRE5KSGI0Ujhh?=
 =?utf-8?B?UlpOcVRxaGVJc21ESDRxMTZWOERiZmNlREQ5azBkYi8yT0RxVy9OWVRnd09S?=
 =?utf-8?B?V3dBMFhMN1VCQW8yaFNmUU1SR1E5TUFwbEhRczNzOVdYWXpFSFBPalcvWWRr?=
 =?utf-8?B?MktabXRmNnZIZ3JpWDZVR0NETXQvT09oRXdoZFB6SUhkdzBkU3Q2QXZUY3Uz?=
 =?utf-8?B?dm9BaTFjTU5lVk5yOHQ2OXc4bGIxRVpJZnJKM1htdmdzNnliUDdXVlFSOGJ6?=
 =?utf-8?B?emtaUC9vQ3VBN0JrL1FEOVRSbDlGd09lNDBPUU9QcUU5dGF6cDNqUTBMSGJ0?=
 =?utf-8?B?UDFGU09XaEFmR0Qzc0taWlBuQXdvRGpXbERxLy9JZmcrbHFsc1FtZEFBY1Z3?=
 =?utf-8?B?YlNKK0pXKzdXN3ltOEpiNS81cWR2OW9OSVZ5aDFmRFBhWTZScUxQeHBvUm53?=
 =?utf-8?B?VE1VdDlmTkdsd3FBcG1DdXhvRCsxN0xQY0pPRGRDZ3lUSlJTSE04V0IraS9B?=
 =?utf-8?B?d3BKclh6L0hNYVk4YXdZVUtOdFk0Y0RHdFgvZVExdExrdzduVDRHWE5Ta2U5?=
 =?utf-8?B?WC9vL2t1Rlp3b3RWeDkzT08yT01ER1BMaG5LWXlDcHpySnN3S3pwaG5UZFdm?=
 =?utf-8?B?NFBKNjZvRXhld2x2QmI3aytWNWo4czdVZEhMQnpzL3VoYm9OemRYZzg2elEv?=
 =?utf-8?B?dTF3YmVKWll3VmFiOTNDSEduK1lKVW5nd0pEY2p3b0NTZ2ZnZUJFUFVrMGpW?=
 =?utf-8?B?T2NBVVluNWdZeExuTFA3ZXAvZW5kdnA2M3hNcTBOUndaNXFGaWhWeGJpT080?=
 =?utf-8?B?YzZnSTlyU2kwbElkODJxeVZocWNtcVlYaFdoaW9zVGlYN2VBemxBU1g3bGV3?=
 =?utf-8?B?bEhLUTJHdkI1aW9uNGtza3dnU280anJpek50bkVBUnhPa244YUNacDlGa1Rj?=
 =?utf-8?B?VWxTTkNMcU5pK01rT0lWNDRmVTVyU1dLSjZNVS9vNlROeHFaWCtLUExYTG5q?=
 =?utf-8?B?YzVyb2s5bnNqZzQ0b25rTm1KYjNTbjU4ZmdxSjkvY0YwWCtET0ZXM2ZKSXBy?=
 =?utf-8?B?NjFJcnlTVVpRYVNGN0hKRTJIS2Yzb2N5NzRPSldZem43c3g5bGRLNmY4cVRv?=
 =?utf-8?B?OERWci9LWG5xMVNLeUc5Q3VUNnU3OERyTmlJSjhpODhxVmJzWkI3NWllc01o?=
 =?utf-8?B?SFBuVG1wcTBOTFVzanRmcmZxSEV3UzVkS0VaUzRqcTZwd2Z4Z0IwZU4yMzZi?=
 =?utf-8?B?S1ZXRGcxSGlhcUFrZkI0L1M1bGtSdjl5UGRVMm1JV1JiaGIzcUtHd2E5QUhW?=
 =?utf-8?B?N3k2bnhEbFFmdUtGVzAwTG9ZOUgwTmpZVnoxQVB4amQ5WGJOYXcrYk5URXpV?=
 =?utf-8?B?YmV1ZEozK0dwNUl3SWJqK04xa2oxN0pnL1haNFVnQk9BOFM1OS84ZkpqZ0dp?=
 =?utf-8?B?OGdiR0J1S2pKQ0xjL3dLUCtsTXVOc2hSdk5SQTFicWU1WEVzUTlxMzZ4MDZ1?=
 =?utf-8?B?bUJoS1RMNGwyazV6RUsySlEydWtFTlFPZHdlTjI5d0tmRkNlaUY1TThZbjNq?=
 =?utf-8?B?WkhDTlpHNlZmYnM0OEoxM1p3bGtVaXhWYk5aRVRGNmlVejBkVjdEaHFqa0lB?=
 =?utf-8?Q?rAQ1D9G4DihYGivA1ROh0dfZhKpzTyvBSaYtOMK9h8RC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 786c834a-9496-4368-9fd9-08db433bfe4b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0201MB2440.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 14:15:15.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/LLj8N2zLU68QryMyw3xykX0usdDRtsy1qusNiRhZHcl0S9XcYMNEWJzB10/CQ+d0suNqkutCJOGpv16slhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8706
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/21 16:23, Krzysztof Kozlowski 写道:
> Didn't we start switching to compatible groups of devices? This looks
> compatible with 20602.

Hi Krzysztof,

Sorry, I may not aware of this. Could you give some more info about the 
compatible groups? Yes, the icm20602 is quite similar as icm20600.

Thanks & Best Regards,

Hermes

