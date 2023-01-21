Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA567693E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAUUex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUUev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:34:51 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53828D32
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:34:49 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LGaZcd025782;
        Sat, 21 Jan 2023 12:34:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=O7FgWsw0tcRueDUviV96jHMmIgPrUAQqV6HsD60N/Vo=;
 b=dGEuBQyC6wOjjroe7VS8j2hB2/7Q0wyhdjuMKlLgZuzgpDktCL2xM/8B0vDxN7mXecY/
 Gthnd94vZUcidmaMWyVXm2PzSrPRginzZptey4gIkZzslxy1kyPKgQk8CWdEX0TDXnVC
 QVQrb1zkGJCZlLAPJvxHWFroIMvWFhnwV2/xzPxE+IReKd31nWfSpXCDPJjlEWEI36L4
 GrcFbMAmnd4yhTtdUcQksroAb/ZrEiuiK7zuRnhXIZLQWVhgs+1qhqev+XJKdrfXRXXs
 HfHwfS2sDZ4yj99Do+LusI6rUo9avia/IpxkH9DtvpMR5Bzja0nHLiFo+ivV553aJTLw IA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n8ef3thr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 12:34:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZrtrlXVE4E4C35H/LYpojL46x9OQbVADuQIcOUgH1NYxj8hulz6cTu3J0YehWmk8czfKhtFV56Hsg/h5dqu5dqBRSBxB91M8SrYInIiVpAHR8qidQNseiPtOLX4q4em5vhQDFN12I1ePbcjvoiHojRwlko/GIpiuRh+hYXImSM3kRyc017fXKkWZZadm+PT70PddO5Ups5NqIdMl3MspjxmQV8sx+UFKxon1wsP8PtrSKMp0Z3U+QKdOO4xMEk810sjZ7FByeMnvCQO6tLUhVK1RNGRqBNNdrIClbsmEk7uVwEfQjSLZNyPkYo0LjOgknkAbVoAiErc8mrF5HU39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7FgWsw0tcRueDUviV96jHMmIgPrUAQqV6HsD60N/Vo=;
 b=aHMAVmWukXrpkgRWoaOgwkNuVjsE9Md3wxxIafSQUuRlr1k43igWnbVPQUMwGCge7eznzERClCwq/DXwTxI/YqtQjCpEgTZW/D4oFhgdIBiLJADEwd+36AmtmvFnPfmPm2/QHB7X0RQg2Z0HO1ijZLivTZNNSd7bbmr/MnrdCShEqzcgkFdUryfi5bQ3djcQhdrVIPplKU//QmJaQ6gRR+NkkbVgRBprLIB70mOZntFZBnrNMo1opIrnCMsybpaj9Rl6bsZq8jXDGh8dFm0XoiRLZxFDgk9DGcHj+0WF7LzqH6r85Pntw7vkKF0aPO5NcK3BhY0zcAHazzCfqPyqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY8PR15MB5927.namprd15.prod.outlook.com (2603:10b6:930:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 20:34:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.028; Sat, 21 Jan 2023
 20:34:09 +0000
Message-ID: <9b556b3d-538e-733b-7525-57a78012d3bf@meta.com>
Date:   Sat, 21 Jan 2023 12:34:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] mm: Functions used internally should not be put into
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, vbabka@suse.cz
Cc:     42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        roman.gushchin@linux.dev, rongtao@cestc.cn, sdf@google.com,
        yhs@fb.com
References: <ae5ccd01-f43f-1228-414b-48491e477768@suse.cz>
 <tencent_6BA336883F064B42805919971C2AC6AFF508@qq.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <tencent_6BA336883F064B42805919971C2AC6AFF508@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY8PR15MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd4136d-1bb1-42ef-e043-08dafbeed919
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssj6pZkEhTSVE7s9IVQPQPtBFWO9dCQvk9XuqjDL2DzFR/lQaLbcddgi7ifbtpeH6ma2QydakzQjFbFi9B/6ZDGEQrmPFxC80yfweOY5n7yLJF1B5e1aA7eDPd0CtyizBpKiPNVcDyPI7sxDNxaKm+xTLYR2nrVhyWQAmOfq2atLEFZLJh1Gesxe4BpdUrBIdoKuKpceBHGrD1YgI0UNqWLGbDd+MuhU1kMaNKO/bJmUqjZzYe0mJxd42ReK+XD/a5thoylGmv7pq5WqzrmKkVhK53oFEcXogAxDIw852SwBvXvuasP0u79UcLzRfyZWnWyh/VuMAh2miHLZyZtV7Q2mDyt+NzDOHaCPDa0aUomdr4E1oxHBTgTjI8OywvJVGpfLrQfkaVgYFC6koq2uI0uOw8h5dqlc51s8p5qNrK4FIoTJqgSyX6WqpuMwhfrljxlfSQrscaEFHVingmkchYyRmmizwW555ZEzZ3lAbcqsgPC1XeLV6I7c81SlH2YwmzbklyK1NevKEcZZ2lI3pNhwB5N9iCgNl4dDm6/KwIRg5xttQS7V1lQOAIAu95aZZZH7kb2YHnsY1H/0HDfYO73RrSzzv3hLZ2/J6a+O7YTm5juJDoKAMbfKeWV8JZSMP/948fjldLkim7K3LXnT3g2t4D4eG20I9m4pe9p6kXeZAIBhNPHGY1F6S1NiyAY5iO+Rpp88T4dWmct9PBy3LAeavDSRqUJgP9BtLA7FbTc8Vu8Ow6qovjLnQLTAPy2tYaym2HA7GaJQtLf7X+g4l8c0glXbq4dOSLYGimlUJJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(966005)(6486002)(478600001)(38100700002)(6666004)(41300700001)(2616005)(6506007)(316002)(36756003)(5660300002)(66476007)(4744005)(8676002)(4326008)(7416002)(86362001)(31686004)(2906002)(6512007)(31696002)(186003)(66946007)(66556008)(8936002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJRdVErK2hjUlJwTm1jMDhQbmw1eTJaRXZoczlzN1NyK0IxWkFOOXhrNWQ1?=
 =?utf-8?B?d1MrK21Tc0F0WUtjNEUvWXJWVDQvM1lNMW8vbWFzYXRWREJmY0VtSmNyQ1B3?=
 =?utf-8?B?OHdHbG9MTG93THJxRjJGZG5zdGliT2oya0tWWUU4eFp0YmJtSEpGR1lTTC84?=
 =?utf-8?B?NEwwQWFKRU1nWmc3Y3ZKdFVZcHFJQ242TUI1WnlWUlVGTmdYOHBmUU1aQ291?=
 =?utf-8?B?QUNkaXc4UGpKeXAvUW5LZFh1UCtZdWJLS1dvSWkxdUx4cTdUYjN4Q0xLWXFo?=
 =?utf-8?B?bHlXR3VpQ293M1l2R3BydXhCTmtTMTJYcVppdDN6WEtsbU1acFpYN1dOOVhs?=
 =?utf-8?B?cVROSE5kRTN3QVBCTlJWYjNLaEd1dHRBbDRBSi9RMThQSW02NlhPVSt0d2Zl?=
 =?utf-8?B?UmlBeWJORTdFZVRRNmhrT3h1ZlZRK2hDK2JnOHBaOTNpYnRiWW1kaGUzT2JM?=
 =?utf-8?B?bm8vWlBUd2FXMVJTOXNTa1Z3SnMxdWovNVNqeW9RajFLMjVsYUxFT0o4bFl0?=
 =?utf-8?B?L0tRcCt3eWwybE9ZVTFZb3Jzc2xUSGp2Wm5DMHJpRDdGQkMwUEhucFNlajh0?=
 =?utf-8?B?am5PMS9ZSnlsOStpR0hXSEFqWUl4Y2R5WCtDVDdxNkJ2QXQrRkRMTE5MQjM0?=
 =?utf-8?B?VTJoMWVRNld6MDJZSU91bXg4OXhiYTJ1OXJZUGgyaS92UEtSNmJnYW1WcFIw?=
 =?utf-8?B?bEtISk83Sk96dHpINjFraVBUdXdIL2xsNUVlNlhmWm83M09rRG04a3FSdkNS?=
 =?utf-8?B?RU9lVTdqZUJXTW0wTTRtVkxuVjg1UllyU0tSMllFTDhaMm5PcEpiZkYza1Bq?=
 =?utf-8?B?V2VSM1REalJEb1ovcEFhK2JDZHA2VDIwRlYzZnlWVnlnZ1BmK3ZUeXFCdEt1?=
 =?utf-8?B?SUkzcnN6K0RMTi9OU094WjV0ZkltNWUvU0cybmxlU1NyY2JWNjg0ZWpmeVo4?=
 =?utf-8?B?ck5MU1JvMmJwS0YvWmRIYUZaS0Y5aUtPZlJJQVp5WnJjazRkUnRBRGt0TkM5?=
 =?utf-8?B?SjhnSmxlcVB2OHpRQk13N004Q3R5NHpONGFhMVpVaWtzVHR4Y0lXSWFBTTZJ?=
 =?utf-8?B?OENPZG9TWEFsQWhuNHlSdkNlMURheDZnRFYvcnZrcnUxOUpjR3RmZ0JVMytk?=
 =?utf-8?B?cks5OHAxeEdJZXEzemt4N0N3RmlhaWFMaDIzNnZTV1hBRlJCY3AvVzc2a25z?=
 =?utf-8?B?bG8yendtNDNEV201SWZtTDdpZWlUMzkxcUN2TC9ITlVvc0N2S0J6ZjVPRXp1?=
 =?utf-8?B?dzRLMHVlUXB4bFEzUUhnZitLeUY4bThGQXJRN0xTTGMyUldCVFFRQ0orVE9i?=
 =?utf-8?B?aHZqMjJxVTBjTlgzbmE2Z0JDMlFySmRlUHJCdmFobGRITjVWbFNlcHRwTDFQ?=
 =?utf-8?B?Z215Wm14d3U5OGJvdEFtMVFHby91cUJLdkJMOEExUXk3Yittb25YZ0lVWnJz?=
 =?utf-8?B?aXdPeGlRc2pLU01ZSFRzMTVwdjVJNzBMQVV2OXhZUzJDcHp6QmtoVzNMb1M4?=
 =?utf-8?B?NXZHQytSSXpoTlRBV29LVDdaK0NYOGhubC9laHMzaFdaMUo1K3pMb09PdG5U?=
 =?utf-8?B?UWVCMkkzandtUGZKNnJqdDYxTG9JT2FiN0ZxeGRybUxtMlZmRVhVNmM3UDFQ?=
 =?utf-8?B?ZklWeGFSSXlFVjM5YVlUOVB4TGFRMWlleHRpUGxjVStlem43MERKbk9zbFEw?=
 =?utf-8?B?YWluT0JzcUhMUFdSY2dUYmEzelA3SG0rdGs5bzN5R292aVhKRGg5eWI3dTZ6?=
 =?utf-8?B?WlQwbFhERk9uWHErM3VlTFBKYlNXNHhjMExwVmh5QjE1cG1tU1JoK0kvYUky?=
 =?utf-8?B?K2xqUDlTbHlpOGlZZmhtTnZLQlUvWGhkUWl4aWZLY0xNZXJqRWRNNEJnTXlS?=
 =?utf-8?B?dGdoaHhaZWRKNlZka0NnVzduRGc2d1NZbDJ5NWZ6OEc2VzVwV0NWcTl3bGRy?=
 =?utf-8?B?bzRzMzZMSzQ1cUhQcC9rS2IrVXBmRURYU1NUVkx1ZEsvR3dsc1pzT1pQYW5v?=
 =?utf-8?B?WTV2d3pRd25tZTRwb2U2S3NuU1prL2tvRjJqZmxheXhPY3pkNG5NdGxqaS9r?=
 =?utf-8?B?RTR2MnJKY2tLdnVmNmF3RGlXRjFnTFFxcVpDMzE4eVIzRzVRRkJVRjBQLzRn?=
 =?utf-8?B?eFgwVjcyNnlWNkZrL2pLNnhBQTljNDhDbnd0dWd0RklXcHVSSDRCS3M3RHhK?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd4136d-1bb1-42ef-e043-08dafbeed919
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 20:34:09.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBlN67zSSXRLHZhL9AYjmfTeyeN2LQzpCgXjS0mfS7rP92GYdyNX/GNIlYLbp4vW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5927
X-Proofpoint-ORIG-GUID: jmtGki8SkxeG_-p_lNExVP0CXs9qJKR4
X-Proofpoint-GUID: jmtGki8SkxeG_-p_lNExVP0CXs9qJKR4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_13,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/23 11:23 PM, Rong Tao wrote:
> Hi, Vlastimil.
> 
> Thank you for your reply. Indeed, BTF can eliminate the existing problem
> of data structure parsing. But as far as the current BCC[0] code is
> concerned, more surgery may be required.
> 
> Now the bcc problem[1] should probably be solved by the bcc itself using
> BTF, and should not bother the kernel. I hope the maintenance engineers
> at BCC can agree with this. Thanks again.
> 
> [0] https://github.com/iovisor/bcc
> [1] https://github.com/iovisor/bcc/issues/4438

Rong, I have added a comment in above [1]. Let us try to resolve
this issue inside the bcc. Thanks!

> 
> Best wishes.
> 
> Rong Tao
