Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BE76D276D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCaSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjCaSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:00:07 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02A85FF9;
        Fri, 31 Mar 2023 10:59:52 -0700 (PDT)
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V6rfwC017604;
        Fri, 31 Mar 2023 12:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=Zv8O5Huu/Z1Ptvu5S8LD/VXWgWYtc6JB16Lf7EWbwFc=;
 b=oVqJZP0dgkiA1UyeKpthp4mN1AxCsQ4YPcPE3mcxGXy19pypiCwToGdP5G1g4vgcOSw3
 psXQM8qjPPXVsozsDTeDRJrd4SHpo2BuCpOmwjKbnazd/ZYsDigKFqaf46yMDFRoSjrq
 5bPNwEkI98lI20H4qZMfdBgMVk+EO0A73fewMZcUB/uAzxss7rYDRpe5sQXgtOfz8V1P
 f76ZnkqHiLdYI6qiG+gx1VPjdu0FNfftwywqTKSv9ekWeq7OotcihO0cYV+iW4x1LVux
 AwmMGfTQZ6v/MEjAA6QT8oGg8qLRFlM1lhdOt/C44vR0U7v7cBMZ/Nf/BguHlF/zXGnn 0Q== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3phwx1cb2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 12:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIGUJzPypUPUyuym1HUZQVCNBwFhtm/G5KdW6QZzXu2EuxVKe5oEQzlhMmPlRU+M3UKosS1KWq3hiJ9iu5RWbmlzAY9nJbsu/CHKATDxdrgB/BMlmxe7sOomx6UId19YsqJeUqSC1KMup1p2z7sFwqhxLTea6Fy2QO1yk40lLy0ImzwrmCw44z1DVKZ5UMqKzxpbCDMxg0O2CWYfC7zOcZbkMBIMD656K63e2MATK2bJuIuCS+T3QBl3csytzKMk/qxY4j9V3GF+agaKsAvtc7qDLbyP/4ikW7Rtl2XQEYqaFhxRARB0b2JutuhJoYd4vFQ+V4P+/E57nsJOEvJgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv8O5Huu/Z1Ptvu5S8LD/VXWgWYtc6JB16Lf7EWbwFc=;
 b=CS3aKAoJa0rnTA+3cEMyuyfhWbMuJX9a84h0rMG7Te28H8R9RcdVRi/WNcLKm87H0Np2EI+FXeAv0JKIqy2Rzlx0R6SjCjMd3pRRGoGTFV8dWUmMb6VVsXieynQ85i9mPMjOoc0+b76lm+CjQzzYbUKOm6IV/ZLN4OjA2J0psJLDGftnbhprSEc0QhcFX+ueWZwYDX9qK9dBT+weAgIuJmiu79pZb9d9HqFsTyan68urqjU5BQmQJs/uHtyLT/QN79sZ7NmGD+egJZZPA+w55Ghz9NrsKYgwdyn2f8zIZI29YcLKM/1rHWLoqYyth44Nao19pFifNuwOe4MvZoDG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv8O5Huu/Z1Ptvu5S8LD/VXWgWYtc6JB16Lf7EWbwFc=;
 b=oW0foJgobInjbEhLVGFXodMFkuZ0nWsA1wh75wmHAPTBUau1FwwdKD3jz7xBZvCXlv6yQFjcRgJ378oBo9wsYuuDbjbhpBJinevC46SOvqihU3aNEmt5VzB+0gPAKarEN+vGRvQRSn9yJW0okZ428G2hhH7X0DYfSmDZUAfoglw=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB7853.namprd04.prod.outlook.com (2603:10b6:a03:37e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 17:59:40 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%7]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 17:59:40 +0000
Message-ID: <b47c51dc-a4c3-ed7b-65ae-3938971f453b@ni.com>
Date:   Fri, 31 Mar 2023 12:59:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-2-brenda.streiff@ni.com>
 <9cd03cb0-0924-3431-8fe3-4d5f4a27b1a1@linaro.org>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <9cd03cb0-0924-3431-8fe3-4d5f4a27b1a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0022.prod.exchangelabs.com (2603:10b6:805:b6::35)
 To SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: fee9b67f-e040-4904-3168-08db3211b33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+l1Z1FcPrIU27S816EI4JgeEuUV1chAgsMulVjYKMrkFBkkgZNhoX0Hg/zppSq7ftVkvKfJPkOQvqBJUhpOfZAvrlYOSdO+TkdVgQFwrOvu7mc/X5rPMTa5vDddoZ+8KNoHoYX6gMkfawVuEQF1pBESFMi3KADTeh/nVV7NMCTUuFkKSlA5T9DRC1mX5NzfqlbUcCMyYrGfu9TA7EwRclFQCT4g+pUp4rJc9CYSFXCh9K+ZQLulM25JjAMbUsF4XGrs1sQsBHlKXTL5rhL9PPzcWF3V0aCDXBT6K8foowqwxefr2+cGfvzexTurLnbQkhMaIxyHDc56ZXxdMH+dj4gbt69rzvX7GwfY9542uaWm9TirbZDxg4O4l3cDQmlgx2KHKh5ej4laD3GH8NvzD1/XUVWAnMaCaFFhWJbcGsH8vyao9007LbMR0fISJ4+TJ+jNIo2Dau8Clj0yg92Hqxx41jVRmeAYSs7ZkRxlu9eWtRti3kuLzDmil06Y0wCxmYqQTOhLwQQx9UCXygwboV9jT8rCHSvJSKh9L3P1NeGKqIDkXShY6GUfBEmANez/JH6nlcw5dWxQxJ4FHPZ7rT1ppRz5Ee7Hqhr3ewafJ36fIiMAlGvh2+gmI6pK468MRprO9JqFgNCsEpr11mvlyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(186003)(66476007)(4326008)(54906003)(26005)(31686004)(66556008)(8676002)(6916009)(6512007)(478600001)(2616005)(5660300002)(6506007)(316002)(44832011)(41300700001)(4744005)(2906002)(6486002)(66946007)(38100700002)(8936002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRxMUFha3pZTCtIR0RsL1BJOG5jWEs5eGQzWlhYS2pVVXNnb0Iwam5RSklr?=
 =?utf-8?B?RGxaR1ZHa25XMlk1ekJ5aGQwSXhCV3owZHdsSDJoMHdHREtEVjB1TnNsZUNH?=
 =?utf-8?B?RnMrZXF3U2RlKzByUVNUZFVhenJhRzlvTHZoRks4d2EyTXFFT1h0YzlwTW9O?=
 =?utf-8?B?MFVwck1MRkZJZ2JrTXJCV1plMHdXT2Z5eVNxVVkrcU90SENNSytQMURUMG95?=
 =?utf-8?B?Z0FDZzdkMzAvNmVVemVYRG50VFJabHJ5blVLNzNLanBkQ0huQzVzZDZodzBM?=
 =?utf-8?B?bWRMYTc3SzNJWC9Ndlo3ZGpqZmI5TzRxRjZnb25LdkFBVlM1cDZKOUtzK0Ru?=
 =?utf-8?B?TmFocnZ6WnErVGhNSWk1S1lQWGw4NHJtUlQ5Z1U4eUdGNlBmNjQyZVRhTnRM?=
 =?utf-8?B?YzVxMVBVWjhMM2hhbjlXbU4wT1JGaU1XNFBFdkJtMGF3UUo2endIV3JoWTNl?=
 =?utf-8?B?Nlk1WHNDZjd4a0dpQXhPSE5tcEZjZ0ZQaXlKcjR6MjQyTDhVem1XRFB4d2d2?=
 =?utf-8?B?WDBEWUFDVWEwTzZzSHJobGxHR1F1ZGk5RnlCVC9tWE8yQ2pKWjViWDIxaHB1?=
 =?utf-8?B?L2xiTG5pUlJGalBZVlVBSmJXZTNoT1VocHhUWWNIV2dDODh0K0pkaFpBWHNF?=
 =?utf-8?B?Y0xvY0pWMGVaallxaWVMd0svQThJc2d0MHVnK1RoU1ZWcHlmWGErYkFRWWlK?=
 =?utf-8?B?cFJOemJRMTlXdFRYTUZkL0x1UnZwNVFVZWZvVUxJcWo2c0dmUFZOak5LUjFU?=
 =?utf-8?B?YmJCdVlXeXJVbk5hdWlPeW5tTkQvMHowb3ZkK2s4emMrVHMyZjdPVWlGNHVQ?=
 =?utf-8?B?WUxER21hSllTV2EvWkcyYnZVSHdXL0s3L2dZQmxuSis1NThHNWN1dWFTQTJ2?=
 =?utf-8?B?VHNJaUtJS01VcUYyY0E0ODlSM2RSVDVQenVtb1ZueFJDK0pza3kvNENFQjFk?=
 =?utf-8?B?YlNWMlJuTGs0WTBudlBCUEZKR2ZFazFCRDE1NVlsWXhzU1o5cndDNWxveitw?=
 =?utf-8?B?b29HdWVtb1VUWXEvUUxXdElnakg2OTg2UUdKS2J6Q2VuZEFMRkNIZ1FZUG5P?=
 =?utf-8?B?YXBuQmh3ZnJwVXJ5U3M5WVlJbE9CZUducnNCTS8xbFFzVXhpWHd6MXVTQ2Z2?=
 =?utf-8?B?ZmJMdThvbFpMWE56NVgwUzV1cDBtNy9VQkFWKzZGSS8rcVluN1B3d0l2UE8x?=
 =?utf-8?B?U1lQV25CTExHeHdPb2RsVElnZDFYVVltbDJHVUpMME5qbVd5dVRWUVg0WlRS?=
 =?utf-8?B?cUVkdzRhOEZpN01pTkp1TDY3ZHRFQzlVNy8yc1lvTER0dHkzWmFuYS9JM013?=
 =?utf-8?B?ZWlPSkdDbWRvYWgwUjVOSVpJZ0hiV2RKWEEydFdsU3g5TFYwV0txUTAvMVMx?=
 =?utf-8?B?OEVNOHNwaEphMXdPNUkxTFB1UUdYTTB0M2d4eU14WG5XQ3J4Um1sd1VmakVw?=
 =?utf-8?B?eGZXTDgraWlGUGQ2bE9GWVJNQlF2WnIyOWExVVY5VW1MS0hkdkFFT0hsazBw?=
 =?utf-8?B?eU4wNUtldHlIUHlnOWZReUVaUG00RE84RjhjcmdqMUNZWUtCL0VIclowNUtJ?=
 =?utf-8?B?SFNtQ0lwRlRScEMrdWhKbHBOcnNvV3dTK1Ezci9lVGhCRkw2UWxNb0pKeWV2?=
 =?utf-8?B?MWIzRWE4NklwWmdkaFZOUjlyTkdrWFpMdTFnNmU0NGp3NmYveEp0em15UUx3?=
 =?utf-8?B?RU5NUWFyMWsvSDhSNmdjT2gzd0ZORWljZUl6Q2xxOU15QXpUZU1uY1pTQ3R2?=
 =?utf-8?B?MWhUK0ZtbDYxTzVJQWk4TGFQc3haTjJpNG52cmNlamV1NnVuZUpJWEtTRGx6?=
 =?utf-8?B?UVdWaDBoU0pMTVFyL2RkeU1jdGQ3NzVENC91YzNsTy94NDNCeG9ZWHhRaUhj?=
 =?utf-8?B?L0tSdU5xUVpWTWpkRStxcEFXS2JFaWV2QjJOUWZCWWErNTAzVkZMV1gzVkhw?=
 =?utf-8?B?dldWWjQzbVgreGxSTGE1dDl5QmxYQ3hRTnkzQm9MY2ZKZ2tBM2VERS9zVHZQ?=
 =?utf-8?B?U09FTDM1VXc0THgyTW9iV0xEOFc2SUcvMXBjRUNmSDFXUThld3dibTE3UkhS?=
 =?utf-8?B?cFZyV3hhUWtVdlhLVVNPU29KcFhrVUJCeitXeEh3SG8rWGd2T1NGOEU1L0c1?=
 =?utf-8?Q?DotBgptFCglL5VU8ChE3Du0Sr?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee9b67f-e040-4904-3168-08db3211b33c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 17:59:40.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgQamjsRsdNTkcnElioVlD0pKrwsr5LUqsgPFLM5dknANw+CBue/EGmBZcdCTKtNTx/trgP+NQYPtQvYGAVbRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7853
X-Proofpoint-GUID: l2eWjNxlTz5-_bRtNOV3NLPk9Es7Yg6a
X-Proofpoint-ORIG-GUID: l2eWjNxlTz5-_bRtNOV3NLPk9Es7Yg6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 suspectscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=875
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310144
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 02:28, Krzysztof Kozlowski wrote
>> +      - enum:
>> +          - ni,ni16550
> 
> As Rob pointed out - you did not test it at all.
> 

I did, with dt-schema 2023.1 and the 'make dt_binding_check' command as
described in Documentation/devicetree/bindings/writing-schema.rst
(with no DT_CHECKER_FLAGS, because I was unaware of it until Rob's post)

Is this a documentation gap, or is the DT_CHECKER_FLAGS option slated to
become the default for 'make dt_binding_check' in the future?
