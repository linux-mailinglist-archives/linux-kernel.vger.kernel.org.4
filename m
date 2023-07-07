Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566B74B51E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjGGQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjGGQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:29:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC82102
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LChojwX4u50Dyfn516yrxbsGqAx/BmGjJYWxnusz/lLcGX9xlwxNYVsepuAWR+bTHsnbvAEowIeA79d+rcxQwfx52H0ILpnuwvrSu0GDiF0vrVJe6mWL7rkv6iqDFLC61NxT58iZY3Gy7wjJQZpUJJdcDqVGaeMfdiH7oi3FE5HX30+paRaUQLMTm/07+esUgqH2T7Lq0Og4RRggiQvSDB1AxygduS0yN6QQaLnemtrC2wFxtaMNj47fn1tGLrEaEgWWyUE2pYY/D4zNEqdj7ur0obGwjNCm9AW0brtnXT+GARZbFgijJDoSJWnMKWFr0hCmRq7ZvIt9qspCwHX1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLDAdTBK62Bm/Uypc2Oxv+FKRF7p/UXWEzhDVEQz0RU=;
 b=Uk2cmXUi8qpDiAN0zvr/M/audc1hf+ZvDtsXzxFTWhsQztcfy5vaI2tkpyzR1EGAMJZky+jow/WQHdfqjiJisGzSgHAdnbwyuVMuQ3eTv+3EPGtcHk6/RwGC/QipkfiFEB2wiR6emZH5Q3xd32SH00A11p1izJ0p2AQugYh4awObtmT8EZrVHSS2kN/wvlUTXl+KIdcy3QVyujK6D0yTWUPJAUo1HZkVH+q2RIvpWNLyDuYOX8SZebXtlVsBre/Cor4xWbVn9Jn2fkWaXP0rFte3syXILhYuj9U/Wlr12IEv+1asEkSFiKT/BlNCtsDP0GbNQQ1+wAL+BeH2E0ASqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLDAdTBK62Bm/Uypc2Oxv+FKRF7p/UXWEzhDVEQz0RU=;
 b=cx/Az8CHG3wQ59086F8lcDlDXIO5Yx7dHVpcsA14PkdH98/TiADiTkZr7k5zfvEEBttCmwAWdbhau7uBRJYtq09zI6NKjWNHIMERQGQe0pVomXCxaeFdFvtI/oD2kYTEemM+JfA4YgekEd4r+hhsqnTVHv7UwbaerDFYdf+MnMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 16:28:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%7]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 16:28:57 +0000
Message-ID: <14a13f71-1deb-ad69-ddea-03d85a69c513@amd.com>
Date:   Fri, 7 Jul 2023 11:28:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] virt/coco/sev-guest: Convert to use time_after macro
Content-Language: en-US
To:     Zehao Zhang <zhangzehao@vivo.com>, bp@alien8.de,
        dionnaglaze@google.com, rafaelmendsr@gmail.com, pgonda@google.com,
        crobinso@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230707030635.67881-1-zhangzehao@vivo.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230707030635.67881-1-zhangzehao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b65ee2-e3fd-4ac3-4f86-08db7f074304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bb2nT/py3Kb0Bzg+i/Asf/ly+V6ZIK0HYj6NJop6AnxbLkaPGTh+OUw2M0WsrchRsVuFpGAmKvbBAg0/Bs/R1f4nOhYCXeeapas+G/11NDXHqAHtbAEHoSn6LeZavxmia0MwhTOttWcTbQMzCghHuSwq24ltWrKyQblWZYhxht9qXkDosaBbCXiwKNjXZbwIALF4bG7RUBaw2/tVcpwDirM3cZJhQC32k4va8NmnLoUeV3Stdf8kEQDsxcuZuKRfAK4YU012juY/OciU2JkTqwxXKs2az/V9AL84FvLzVSE7KjKr0v9wC2RcmW8kHoVk3lbU1iuzm1YGazBS8xl8SjjheuFNl5QGkFO3sS7XGlvAEujvu6Nocww80tRMWhkFdN2eymi6v+WxxFmo/UsCzygNLqe/xUS37v7QTKMPSTQ46dsRHiYmxZEQpdb5jKVVtD2AJ3ZAYHpBaOZmbrOXGfkinpHz+lPot4e2JLFE01Bo2Heh3z76NVh/Sy9ubIt6Mt0buoQ+ph9nLdiY1zmsCByvMEeuHWhpPYrnTMcbgBE+vjrdomcVQAvcZHBu83NV5+KhVOVZWN9e9SmQ+xxsxAswF3N6GOrYVua610S51CqSjFaf3+8rdPWpw8mfGw1hHSdxZ91r8UdruH7UUzSwUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(6666004)(6486002)(186003)(53546011)(6512007)(2906002)(4326008)(316002)(41300700001)(66946007)(38100700002)(5660300002)(8676002)(8936002)(2616005)(66556008)(66476007)(31696002)(86362001)(36756003)(83380400001)(6506007)(26005)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0E3MmVyb0NDM2hncVpGbjdJZGtkWHFOTDRENTlDUTJ0WnFMdkdUcXF4U3N5?=
 =?utf-8?B?NFYydnlIZW9VdkxVSEZsZUFJUGdJZm1qUy96MnpvajBFUGRlK2p4UitiVW1H?=
 =?utf-8?B?SmNDUW54QVQxdEswbFZYeDR4TzB5b0FKTnNpRlZDUmZhSTVSdThTMTRDT3Jn?=
 =?utf-8?B?T21lNTc5eEIxSFNZUTZGTWlUL0RiYmZCaFdyR3lnbEF1cGIwMzY1L0hQbkU2?=
 =?utf-8?B?aS9nOXNtSldjZXZsbjRvY3QxS0grMnBBUjJnbGx1eE5QdVdLNDFZbCsrQkls?=
 =?utf-8?B?NmgzSGhFbHh4dUE1blNsdUZ4c3ZmN0k1Wiswb1ZIQVYwaHp1SnpwZU1BU2ZV?=
 =?utf-8?B?ZGNUdCttR1labEUzUjJzUXZRTWQ3bFBqb2l0TC9uVmdCeXkxMDF6VEkxNTZI?=
 =?utf-8?B?N0diVUlqNTlXVlp0WHFFZ1hBbFVVdkc2dHZwallUbVhlZkdGU2VUa0ttUzgx?=
 =?utf-8?B?d2kyYm5FRDVxVlpwSFk5VkptR2RHWEs2Q2tDaHZCK2VUVXRFWU4xWURLaFo0?=
 =?utf-8?B?OURORkdBWHNXcFFVbUpaQ3Zrd2M2MEtGTUNXV2VqdTlMb3Nqbi9FdzdtMzJr?=
 =?utf-8?B?blNOY3I5VGtvY3R5RkZJN0lQRkpCSTF4ZnhEZ2JJTzRKVzNoaHdsMkl5aEdK?=
 =?utf-8?B?US9mRUxBSVhKS29salExQ2I0TWNneXhQdlU2anpGQmVEOWdoK3M1YTZ3SHM3?=
 =?utf-8?B?Z1ZXdnFmbTkvZjRWL1Qzb1I0bFJjOElOemxaMWtHQTViaGlhL0VZZWtkQ3Zq?=
 =?utf-8?B?Y2htSW9qTFowb3d0NG95QnBXMEY3OUpsd0xQMEx6MU1maS9WSWd3WElBelc2?=
 =?utf-8?B?cCtZZE45NHFYWTlGb2pJb2pnZDRFNUpiVVJ1NGp0UHNSTE1GV1hBQ0NpVTd5?=
 =?utf-8?B?TFF0T0FqZXgzTmNSdFFEM1VITWU1YXNYWmZDK3M5YWM3cHl3WjJSbXByejNa?=
 =?utf-8?B?SzNWMzdXV2JxOUZmeWhNcUxXOEIremExNnI0dmxQMnRQeHlSc2F3aDhKekZG?=
 =?utf-8?B?aksrbWtUTkFTMU5ZdG9jS1VlN3draVZmakthc1FhZ1VRdzVxTHg1K3cxRjNT?=
 =?utf-8?B?L0RMVVEyTWE0VkozZ0tZVERzditiSVF1SDFpQ2FsSHNwbndSZFRaSTRZLzBp?=
 =?utf-8?B?eHN0OHozaFpoazBUL2ZEdEFwNmdscTA4eUFiR0s5d01tSnRScllkclJ2OVhH?=
 =?utf-8?B?d2t6bDFYYVpNSTIzNWtDc1NIaDhJck8rM3BZUFVGTWZDb0t2eUE1ekVDekkw?=
 =?utf-8?B?blFnYnB1NzhRQXgrWmoxOE40ZUdDZDJHT2ZCVEJoUktaWWpHckhwbE1HcEcz?=
 =?utf-8?B?MHJJT3F2VnBvRWplQnJWR3BiMkpxRHZ4Vk9pRVErL1VxdDFBY1JrV2Y0Q25C?=
 =?utf-8?B?R2pRelV1VzRJMkNad2VhYkVaL2NoQUNjaXM2RTlCMEFuMGU5SG9ncU5pVnVx?=
 =?utf-8?B?UEx6WjVERlh4TXpaOTVhaDlFSXBVcTM4VmFpVStialY4RFZOcG5iTy9UNE04?=
 =?utf-8?B?VXN2RzVFWnA3azU4bHN6YVZ4N2FweWlXYm53QjRSZ2JqTEhUbVQyUnhKMUlG?=
 =?utf-8?B?MTBUZEdMdlk0YWRSeE1MbW5aeUo5ZjlhUWlFeUttUXovTElSak0zQ1BTS3Zk?=
 =?utf-8?B?cjEvTktXT2FGcSs3SDFmQ2MveDVDV0NWb0RGVHNvUUg0bnI2c1ZkQzlvdEJS?=
 =?utf-8?B?cEhZUkQzQlJPOUtuYlQyYnJRMDVhbFhNaWpUMTNvQnlaQ2Iwc1FaSU5URHNY?=
 =?utf-8?B?SFdiYVZNL2pFYW1rM1BnQ0x1SEhvVmNWNHBoNjYrVHRlS0JWckJVZWMxUG9K?=
 =?utf-8?B?cjQvdHhwWGduOFNuY2tTb2YyM2wwekp1clhkRHZmRjVncWhaVTVtMjJEYVFK?=
 =?utf-8?B?dWhJckpKRm5tdUxmbXRPTXJvOUdCaURmNGNhZDZvQnpxa1k5Zm9jaUl3TzZz?=
 =?utf-8?B?aS83bUZPVUpQQTArbCs2NlYvc1VSU3djUG9QNklPczFHZkFuUjhXaFAxNVpC?=
 =?utf-8?B?WUJQS204aDkyb084bmZpTVQ4b1Z2cTh1cUYra0lSeXI4SXIzb0pCU3RueFIv?=
 =?utf-8?B?TzhaZGJpa3hmNCtiVXlNVXBaUjNzT0Z1TVo4RTYyWG9rRXhhMk80UWtmNWt4?=
 =?utf-8?Q?dTueth5Vup1aU/fyg2ki5fUdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b65ee2-e3fd-4ac3-4f86-08db7f074304
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:28:57.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4s/t5O3NN2NPo8nvdS/YIiBJrEEPhEjgXafLlSK/Pz3iu41jywnGlBHDnYOtkpd8habrfSkmggnfLVI12PNbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173
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

On 7/6/23 22:06, Zehao Zhang wrote:
> Use time_after macro instead of opening it for readability.
> 
> time_after(a,b) returns true if the time a is after time b.
> 
> The macro deals with the time wrapper correctly. If the timer wrap
> changes in future, there will be no need to alter the driver code.
> 
> Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 97dbe715e96a..f17302117c18 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -21,6 +21,7 @@
>   #include <linux/psp-sev.h>
>   #include <uapi/linux/sev-guest.h>
>   #include <uapi/linux/psp-sev.h>
> +#include <linux/jiffies.h>
>   
>   #include <asm/svm.h>
>   #include <asm/sev.h>
> @@ -383,7 +384,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	 * message sequence number on a different message.
>   	 */
>   	case -EAGAIN:
> -		if (jiffies - req_start > SNP_REQ_MAX_RETRY_DURATION) {
> +		if (time_after(jiffies, req_start + SNP_REQ_MAX_RETRY_DURATION)) {
>   			rc = -ETIMEDOUT;
>   			break;
>   		}
