Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFED6ED170
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjDXPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDXPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:34:31 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8B11FC8;
        Mon, 24 Apr 2023 08:34:30 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OBlWBl000939;
        Mon, 24 Apr 2023 13:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=dG0dTcZQpdP7NmFCOdomZqoPPhxqExLOtXbWg4vrESM=;
 b=THTdyvFhmzsFihYPBfoWCOxmm9LKhL9NifSPodmhH8zwlCz7Y1l/lwg94G1QzIy5+u9T
 l7VYnR2G/z8IlqhzzrP5hV0iatvg5WLbCQnHAi+VNP2nAQKaOXWoe9K+gId69sgouTfg
 2K59jtt8vscIrIjR3P/tBpAazu8sCjz406R0qbDLWdO9tf3mZGgkZUJJeOQzDemUKbit
 XwCTTo6LejzgKEQW7bnw7AgXH6L2LJWxdkwf6JLqOMLVGxtqs7D7c70YtMdhDn1mqQPh
 7P+zlRHMqDbEMHu3B361YkLr84O0aes5XvcJoiYEEU1biYXSYpF2VwSOf4m3uhV5ruZn YQ== 
Received: from eur01-he1-obe.outbound.protection.outlook.com (mail-he1eur01lp2056.outbound.protection.outlook.com [104.47.0.56])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3q46869snp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 13:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDGP5xE0TERZH4thbPu+LTYrZxNdHRL0OgxQWX32FwCBRb8DP9EaWjX5CRiYkC3dBZMH/temI+VG95Iab6AA6NTO3wHpkZWATmA5yrBdYX/ejeXzA77SqJ2w5ICHFQNYzgR/009jDlvPOTep2PLDXllHAlCNfbS2jN69JYaLzkYSKF/LVZnOGONgybtlAGru0v9UbQnCwYGtS3keXYEB0EDMrf367TrIr9WRZJydR9MlgMul+FuJW/o0nji7Mmqaw4VG69GWj5dk9C+FIjLSiAX5wWuVUtbS2VxLyUDt1whlmPchIIffLsFuA2C8TZh63tgsMQzAL2H5m/U7V/W3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JZz8sqyVEX21IFYe46WJvDY4uHD/VecMpxCBK7bEH4=;
 b=lp18nn4I9CClXR/O5mzOhxOoVMigTYPf8OzFAsCsnU14cb8ROec9Yxkq5n5eLwShfytbQqa7GRYuUPavoPtuzvcLovztoMAwLoPBBxdeIatfppXBHfc5lXCTAzqJzhtsk7X993fOPrEs6+k/V6aqVlJ3NBIkhJoL+/JpQcUKsk/VMBferu6+v/Kbv7SfB0A6/axDCVIqDyL9XbRRLuzyb5TSA5zt8ov/hJD1tj/+QvadO4n5/CL1Fui3MpgaxJJBTQbsgkamLKLE2YthW3hEaHPTx6qtL8lZhrllhMaU5oqunH0u8lnRv8LpVYScFZ1bG4eUcKEm6X7FpG4NlPXHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fb::21)
 by PR3P193MB0847.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:54:18 +0000
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::957b:7571:77a6:c86a]) by AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::957b:7571:77a6:c86a%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 13:54:18 +0000
Message-ID: <f58c04d3-df1d-1dad-03fa-50457f39d9dc@sony.com>
Date:   Mon, 24 Apr 2023 15:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
 <3164e897-a423-3948-d50a-f2bdd4ad05e9@sony.com>
 <2023042431-crook-stable-5749@gregkh>
From:   Peter Enderborg <Peter.Enderborg@sony.com>
In-Reply-To: <2023042431-crook-stable-5749@gregkh>
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3fb::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1687:EE_|PR3P193MB0847:EE_
X-MS-Office365-Filtering-Correlation-Id: e752be2c-28c5-4938-cc94-08db44cb65c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3lRuqUsZMKOie6cn63K5y6foIcudGBJePD7UfzObrm9vhzO5vFANo4sSnYK6pObnNI9ItJaAtAca1NdANu+8jpM9Ja8YRePqLP3Tvn1GaOFtJbHDEb/UDlrvMgE/K+RVTTbqE9O1NWardRWMg+9FE4OYAOcnBF3bbdUg1x0GoG/AhvwX7Ngzm5E2YKMBxVjVaszh8alm2yFGCk07LcM684J0UtvnsBtYjgIzIeTgDDTb0WskMYRMTb024VNpnII3TNTk+MMX/9z5tfjNHbKZtRWjOMortNM/SsJdnen8jNRF/EOX1nbbG4vHHE4EjjdFA0hQcmEpU9C5dOYCzl7q+iiLpAVDTAikBs41oinT1faI4BLryH1Hiz1qBboQyNK1L84+JO1ltLMdl+57q3NUTDlt/rY8SvDBdzDW8aYw0yaiW0kKB69fa756iuhBDAkEGKyOK9sX0hilB17xCEYi/Mio536DSrCN8+B0g87CgwSqZlPYZq62I7jbpN1b8f3VzjxljsS5V6dy+HSQoqp9ayC+6JmdNwiALmosjxKSNaJIo9j/Q8Df6dpCYrLFESQYepC61vVli6r9hsBXVRQ6lIjjDFDtfK6uH04tQfVg5R6XRQxuCuN9ctTv8yXGGCyU6WL6kZ8Nj7KXr2x6xAjIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB1687.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8676002)(8936002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(6512007)(186003)(53546011)(38100700002)(478600001)(52116002)(6486002)(6666004)(966005)(83380400001)(31686004)(2616005)(6506007)(82960400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlU0akltR2lzN1dmV2NPU3Y1a0NycEhhTUR4SnFTOW9qR3hMalRhN1NXMmN6?=
 =?utf-8?B?WWdpWWdmMlRHemtVZk9ha2ZIWjNEdm44cEdkc3ZSbTNUS2xSdXN0dnZ0Z1dj?=
 =?utf-8?B?THFqcnh1YXgwZmlWa2NETHNyNW4wc3c2ejZSdExMSW5ZbGUwR0gyei9jUW1U?=
 =?utf-8?B?N3VLdGplSHFobzFscnBoa3dqUnA5UkUwYXdxQk8yeC9ZNnZJTkdSNjB2amQ1?=
 =?utf-8?B?ZUxVcEp1bU9sS2ZSWHROL0RETEcrcU9hbXVwOVhFNG0xaUhDL28rRUFreXRF?=
 =?utf-8?B?NUZoTk1EQmJvb1pwZ0Y5U0I5b2NlRjJLWmd4UVRuMkhXak1GT01VcVJNRGVZ?=
 =?utf-8?B?eVdEdU9ReVVmNjRST1M2aUxSYXBSM2Vvak9BcHBYOTkrbjdIV0hXTlJhcTN4?=
 =?utf-8?B?OVk5dXF5T0Y4VTJBNXlnRElUZHJiV0tBajgzUks1R1dFSHJQYS9LTHZMK3RE?=
 =?utf-8?B?Z09XVHRITXJ0ODRkZDRlSndpUU1rcnVRMXJHZ3VtN0M1NjAzN1dmekNITWtJ?=
 =?utf-8?B?SzlUNTFmVmRTVE5HRVNwWEdSTDVKTG5BUkxBTk1BSU5HdVUyM0EzVHVzbXA4?=
 =?utf-8?B?amtQeU5SWkM3Q2VWVW5KSkN0OFp0U2NNVHFHY0ZESGN6OG1QbTM4KzlkNjg5?=
 =?utf-8?B?MFNNd2VtSmltMVpFZDlCdWhRUWFKRGQrc3k0eFM5VlBCdlR6dGY5Z1NqQ0Zp?=
 =?utf-8?B?VjdjTnBnQ1BJL3VaTVlTdU1kbVFmOERBSnNLUTIxV1E0NWtnUU5iSVJsR1hl?=
 =?utf-8?B?SXZWV1ROY1ZyWmhFb09nU1J6SU9zSUNYWGtPeUxSVVQrSndJNnF2WEtSSFdQ?=
 =?utf-8?B?S0VaUmpWVks5SlErbXA0OVg5OWFmdThOeWdTQ0pXNDU1V2xpcnQvbzNaaWZT?=
 =?utf-8?B?NzlWR01xUlN6M2llUzBuRWVzYkNTM1BZOVhTRTZZM2NsZ0hmQXpiRW1NaHR5?=
 =?utf-8?B?bnU3OE8xWUN2ek5PejBoMGFYUTNJdkZURnNDd1dOWFlEaS9uQk1XUjk5cUFn?=
 =?utf-8?B?d1k2R0taTzRPK1RCWGVRdExHVStVZ0xiRFRLdllOVTc1bVZ6Ym41OHY5WXBy?=
 =?utf-8?B?UFE0Y1dEMlpGLzBnYUg2d0J0UzltSVFKdU1rOHFjVEVjeUVMeTVSWWgrQU54?=
 =?utf-8?B?ZmJiVDFLMlUxZFNHT0dFYzh0TEdSK05zVW5xZ1JDQnV6b1d5SkowbytYNHo2?=
 =?utf-8?B?S0h6S3NHd3hCSXMyS1ZNM25FOXd3emRycHBkV2V3VW1ON1Y5OTdiU24xQ0hN?=
 =?utf-8?B?UDdSZHg0TnR5ZXZsMC9TZGFpc3B4UnRMdXRXSnlOTzBTVS9QNUgzeTd2TVRs?=
 =?utf-8?B?M3U5ZTcwZ0xoUEJ1QkJjcnp1K0hiN3FOTkhsNmg3RmtYRGJubzVEdytJTGtF?=
 =?utf-8?B?RXlrQWFZc3B6MXRkZGc0REcyci83WXU5cHgrK1dXaFhmRWxxZ3pQVGNqMk5T?=
 =?utf-8?B?b0FzRTRJa2NNUTh6YlIveXhGQXB2eUhERTBZM09sVloyMGQxYUpPUGdyblR3?=
 =?utf-8?B?WUhMWkt0bnhzVDc0YUY5UGFzb2E0cXZKVzlLek9ZeWV6dHJ5Tjh6TjFEK1Bp?=
 =?utf-8?B?MG9leWxibG1xWmZXVXFJVFRHYmxSK29YZE9MM1BXWXc1NHhFY1M0VFEySDcx?=
 =?utf-8?B?LzhYcHIxSkpDQ2xaZG44d2w4WE1JODRZOU1jdG9USGN5d0RKZUtEUGhlL205?=
 =?utf-8?B?cW1VckhHMHZHYmNublZkeUpPVlhkRGkvK1c2MVhPUHZTUW8wa0xkMHRRdHhr?=
 =?utf-8?B?WE4yTFBFbzVIK2djL3luQUo2ckFVVVE4RzVGTlNGNTY0eTVwaEhlMHpoZFlm?=
 =?utf-8?B?TTBPSUIwNENxcEdyTlRRSlNhZDVWMlFYcG5jMmZhblZoeXcxL1pNNkZLNkQ1?=
 =?utf-8?B?OVB5b0ZyY2VYMmdTNGFsSlVWaXVNZ3dHZ3lhMXFzOGM4VGV5aHJjYTFkYy9T?=
 =?utf-8?B?bCtyQjNSRGxZWWhIeWhzQiswcFJoWmc4YUkrc25xZHlRQmRlUFJIa2pOUlFT?=
 =?utf-8?B?eFgvcHRZNE9iZ3ZaM1BuNXZseG83WUczRFZIMWdodnpPVXYyU2NoZjYvb2FJ?=
 =?utf-8?B?eVpnZllzSytHU2lQYU1mTmZGeThmaGhxS3lQWjhkSHZsYytydkJGQktqU2RQ?=
 =?utf-8?B?Qmx0OFpwcHhHRE1DcjZROEI2YjF5K0lveWorajhsaGx6b0ZNOEdzOWJhQ3dr?=
 =?utf-8?Q?+gNFtbYo963Fx3ExucWnSUVmYdwRCPcdo3kEFabeDFzU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IRy6jqpD2X1eyzZJ2gIzr9geNi6Y/DPLST8AC26Eo8eC6rjcXVqEf0oSbOk96cqs60lzmE97Jh14krhl3xAImzmSb2Jx31T/rDhodWrGFLeBp84bVTSC22WZYUmUWrBaRDD2/uzpJYAYglWzkcXa16N+bo4y2mQgsYWze294bQYQ3dwe/C1mpmx/5zBPwx2GTi4G05+p0T/ucuymFDtXLcl6xxjUXSPWUqMb0J3JW9iFNdBk60qWRomEi00Qst7tHFBgc1cRG6jNsC17XMu0/gN3r+PJO3J2pJSzHEeSodObOEnp3Df4HFwn5K5pqu+Eeo75daTBE0ILG7AAx2vLeNBz5XtQFdY0ehSxlRv5GsTgUt7rMA2rBgdIFpQd2GfPO6Gw/8TdovNuUf7VOj8ICQqc6FnGZH5ZR59xdIDxFCnJcSuX0dF/fIKKCnKDkvghrnuaHDpTRN4I3hv842jU4NMX9SwIZObUdXsawO0Qb37tdMu3tK7mRVxiHH6udJ9ajIw8CfHz9uyIDec0Yvl9IOpe/VcvFsFYi80yXe6NdKwVG9Zt/IGDrB9CTVdtwqOqanN0PGd/wnllY6vSyzlQ6Fyr6j3LTmZIZvNx7TcpCSc+eXxaA13b0ji3q6hduI4uSqhglWfMkJ4tuo3V7khTDgmDgV3UU1d6irsxZbatPhCJQIlzXzES9sFjUOP+YIMGNF6OOXVash05l5UFs5uI6JLITXCJIRUrRVcAn6/ejAhMyuizclfXCJMNozmlGYTiLG7P/rJF3jQ8icYV5NqwR6YHAYDRrP+I9Gl7/ba5xHOQU7fJuHcATLxKImxbf7RoQIQ0wx59GufxTl1BBke/BeCrT0Utsn4+mXQCNgp7VEyVuS/tFKi+vR7Ou0HxXqR/CNNnGiYtaEXBc/R9tT1GxDy8fGwuJNDxnYC4Zrfg37I=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e752be2c-28c5-4938-cc94-08db44cb65c4
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:54:18.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgWFutLb99aOZvh25Nd3SYv8mTjSuVZL/8N1OHizTaDQBChgsdrwqYV4x3cjoAaQWHJb9aKqWb/uqat6wrsrrVITHQOo+CVEaYGqiXV/OYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0847
X-Proofpoint-GUID: ekpbIw5zv4-S6zP08L8B-17U828CTbbd
X-Proofpoint-ORIG-GUID: ekpbIw5zv4-S6zP08L8B-17U828CTbbd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: ekpbIw5zv4-S6zP08L8B-17U828CTbbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 15:22, Greg Kroah-Hartman wrote:
> On Mon, Apr 24, 2023 at 03:17:09PM +0200, Peter Enderborg wrote:
>> On 4/24/23 14:53, Greg Kroah-Hartman wrote:
>>>>> We can do things with the debug information without filesystem enabled.
>>> What exactly do you mean by this?
>>>
>>>
>> We can read out data from kernel with a ramdumper and analyse with crash.
>>
>> See https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide 
>>
>> If it is useful or not I can not say, but the dws->regset. is lost and can not be read with a post mortem debugger.
> What is "dws"?  What is "regset"?

That is from the patch. It is used as an example.


> What is the root problem here?

That it is a mater of taste.  It should not be a mater of taste.

      if (!dws->debugfs)
                return -ENOMEM;

        dws->regset.regs = dw_spi_dbgfs_regs;
        dws->regset.nregs = ARRAY_SIZE(dw_spi_dbgfs_regs);
        dws->regset.base = dws->regs;
        debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);

Even if it does not have a impact on the function of the driver, it has a impact on debugging that
is not needed.


> confused,
>
> greg k-h


