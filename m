Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA3702629
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjEOHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjEOHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:36:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC710DB;
        Mon, 15 May 2023 00:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7WSLBRX/NBuJlrt4J1LKt2tq72wJPJpq8nFj3OBeJZ8yflCjKJR9w/d0CyxbI/qdWNARsMsfPUKacoMvcJFBnPMrBYamUpPEh19k8p7rMBF6KJt4U0oVCBa2ZLyJgFJ3s3D80vvDMbxqyk1UXHYvaPrw7gFuVgIUX7goI+mhbJYbQxVZcB4Rw7uFNDVJELaIvty64j9JncFfN2jMF9qzig3F0iD9FbiPKvT2Tw6rtfUdnv3VWSkAqHB0xOBCZPdr7XKKbnUlA/ye7feXeOtrz9qxogDNPVf4P5YtgeGleMR3UK2FvZwgSX811wQ/2CaHvymWWP/6GJjKYHG04wwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt3UrwbCB0DAHarbQDo/RTQ6ZERKgK55dWK8uvxS0d4=;
 b=QgRpnjxkLSLoBeIKrGI4Hby27c0dCrXvkd7PokI/KZJHSZSr42ebF/8ZrGHNd5ql7IidXF9Ry8pUYEannq3qaArACg7bgvXlGKa0SYWWQ7YBMW2TdF8ZPKoG6y+w2AYxmoW5e8ZZRMPw+AFWsYp3TaZ+f4uIxGcWp24oR1HdMlqFUGkX0YQ6mPLUhoaCRWe/iqDsJ+ITcJykxIoO+tRg7Hc8gZm5UyIPgNdOF2+ZaPKKqsti3koOrNbbA9G4wUVZWOlHqFZ8FWOjT9m2Btth6RSXOx6tiMwFyXA9S5+jgpsEbHFQ49vDi/ueEJhotZriHoXKSw4s25gU0+0ApFdq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt3UrwbCB0DAHarbQDo/RTQ6ZERKgK55dWK8uvxS0d4=;
 b=XpvGj5joW4Yt6hU5+SxAkm/M7+mCODztbpRFhCUlNtvYVviiZMJOJ5wzh80QxSHeHG2RTE/IihSSpj6kUxnMRnFo1OScdqo2zGm4GnH94s0T5tayBmtTrkQ2k9ydgTIkMQau+TRiIH+VOqMjTpY77HOstmA1I2pUGH9y5uTT4QOegrWYPd03OPsfWhBB6lpcu8oI1OvlBYgzualddDqQ9SQwND39FYHRXY2i75kQMIzLxcB0WGNc8n8gj80uVzW3o4ZdmjGFTA7zf3gIKErl0LEuSIhpm7yVjohWXCTipwVWfPveqvfA+3Z9N3GgB2r/faTwFn6ZSWytsPPdej8YHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB7514.apcprd03.prod.outlook.com (2603:1096:101:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:35:50 +0000
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1]) by SG2PR03MB6730.apcprd03.prod.outlook.com
 ([fe80::e116:7d2a:af78:fcf1%5]) with mapi id 15.20.6387.023; Mon, 15 May 2023
 07:35:50 +0000
Message-ID: <8c6ad0a9-7820-c7a2-bd3b-1eee87d96728@amlogic.com>
Date:   Mon, 15 May 2023 15:35:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V8 1/4] dt-bindings: clock: document Amlogic S4 SoC PLL
 clock controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230515031557.31143-1-yu.tu@amlogic.com>
 <20230515031557.31143-2-yu.tu@amlogic.com>
 <590560c9-4da6-bbd4-6aac-de57ab5403ba@linaro.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <590560c9-4da6-bbd4-6aac-de57ab5403ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::24) To SG2PR03MB6730.apcprd03.prod.outlook.com
 (2603:1096:4:1d5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6730:EE_|SEZPR03MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efb6774-4c1a-4204-9cf8-08db5517005e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIHxFlpiARR+f/P9UdHmYPRdWCOMSiprjbSn50yvafOCe3T/oM2hspYJxfjUM5N04C5G3gGKgLi/wD/Xy48nfkSALQpIZj3RngBee2VtOcsur64rVcHAb46Bezs4XYodS6sGosQdkUU5/DOJc/NDt6SqR2muBhv6lfv/W5JPWafqdO3ToWb9Do22R5YCfqf7sLWM/qhz+eRglEyjllMUrCbeRmV3bzkDM0k0a0v3lSTGTdeFvQ/pgpjkbpPP2V1UtKk8N5owFV8d44M7UnRq3j8rU7E7B/rb/7P9F/hriiJu/yaDVeN+PfNBkODuNxbiJ5JXk41B87uzBO/8MgL5Xhz5HQf7WC/JN3vi6B4A8mj/OW9iqXG6oMJxviIqg3eeRCO5HIce1ZGPMTOjEFQ7eoYQr5VxpdxmKRXtLODu9RpcIc9qipSf04RPRKZt5IJjUG4F1r4D1CJeohKK0ecMbL6K/TDcg5jyDzGq6/GpugVle+APq7xLApjoC3LrtjipCyYtvBxTF+TbmGrRo6P66SdHyDpkkFvK9/96N5R0zXPuWAk2Ek1Hp8LrywlauZj61BAGOAD1PmTlZ3QIpyHR+U1TsaothPyZFTxQvv4gWfwaAOj6l9uVOFSmpeTo94ytMSesl5fcO3wuli0/MWWK01CACne1ReZOY/rAaF8hFa+3Q2HANwc26pKnVgu2VQhbIk/MluxJO2uZEkBOa9x0Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6730.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39850400004)(136003)(366004)(376002)(451199021)(2616005)(2906002)(107886003)(4744005)(83380400001)(6666004)(966005)(6486002)(66556008)(66476007)(66946007)(478600001)(110136005)(8936002)(8676002)(7416002)(44832011)(53546011)(6512007)(26005)(186003)(6506007)(5660300002)(4326008)(316002)(41300700001)(38100700002)(921005)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9GblBvRlNPRzd6WExkRlJ2VHJDQURuOU0yaGVDMXhnTVcyaEY4MURCeW4y?=
 =?utf-8?B?TTlpeS9vRElidUJuekJYMFhBZVJGeGErcXZGQ1d0QU5EazZac0h6SnFsaGRq?=
 =?utf-8?B?cXRKcVpsbXlsenFiV3VvdStTRkZReDd2clQ3TjlTa21FVno0Qm1IVUVnQTVo?=
 =?utf-8?B?RDA5dWg3ZzFjL01hNW1IMVBGLzhwZzZ0bEJtdkRMaUdVYnBkMk5zcFNXVWJr?=
 =?utf-8?B?a2QrTVNyVGNFUm1wOExyTFpLMS9JcDhieStMSnhtZ2Z4S3VGUmFuTy83ekoy?=
 =?utf-8?B?aTBLamhVR1V5WjdKZ0ZaQ1Z0SlU5MVVTbnAyVm05SzI5dE5vY1gxR2cwS3p2?=
 =?utf-8?B?Tm9Oa0ZMS0hvaTVxc0xVVDlZejN0VmF0MWdlZWtwcnJNbmNnS25nOXN2YlUy?=
 =?utf-8?B?YVdxUlVFeVIxQjhjckd0ZHJKTmdDVDJRdjNkOUJmNk1CRXNLaWU1NkFQWC8r?=
 =?utf-8?B?Rlo0LzBtV0MzRVl0QWNUWGJWaERRd0ZRN0tLenZUNHJ1ZUp2cm9vV3l0bk45?=
 =?utf-8?B?a3ZDdFdlUzR2a3QvUDkwYWF5RzBxK1pJNWpJeE1ZY1pJdTV3ZEpFcWdUc0c1?=
 =?utf-8?B?U0tJRkk3Q01jb1BYK1lkbWlHeURqcUVHc0o3NVhRbXdidmlzSHJsM0Yrc0dx?=
 =?utf-8?B?WlBQdjZKQ0dFeXA0UEIxSlduWTd4c1cyNWFGVWpMWXRpd1YyendmRzNnSnpT?=
 =?utf-8?B?ajRENmZGMHIwajFQYWFhZWYxNmgzTCtxUkZ6WU5jdmE0TFNOQXIyMzdsY0Jy?=
 =?utf-8?B?SUdWMmRhNVBVcU5LRnloT202My82Si9pajlVR0VRNWw2YkRqeWpCZ2hkOHpO?=
 =?utf-8?B?ajBNREdKak9rZE8wTFdyNGI1SENWejYzcitWRGM5d2JkNlRLNVZoY2xjb3BG?=
 =?utf-8?B?elgrZ3A4SjlLdjJSczdGejgrWVFHemVFZ3VTNDhhR3VTZ3lQSWN3bVB6ZVVR?=
 =?utf-8?B?R28rRHdxUUF3bEswYkZhMGczUGZqU0hxcHkyN1BTUkNOME00bUhsU011eWRW?=
 =?utf-8?B?eUlKcFlLMldISWlMWitvekNOREZSZFlwT3VDd0pQK2xyTzVsSS9qYWQ5TDQ3?=
 =?utf-8?B?YUpyakh1alNxQTdqd0JvcmcwUDRNU0NzYmNJSExPQVQ5ckc3cGx4TFNUUkV5?=
 =?utf-8?B?Q3RHcENZVDRPNVFtYjJjUEtTWVREWEM3TFdWWkI4QTYzVEhEbkpyWmZ3U2k0?=
 =?utf-8?B?SThjQmRCOVdkVER3ZEZmS1pSYTRqVjA3eDJzLzlLMGpmS2lVeGYzT25vUlhI?=
 =?utf-8?B?WldTdFlGL0swUkRGRGlQZTVoMHcrUnFzZGNaNldUVUVmaWZWb2wyRHlEZTVH?=
 =?utf-8?B?cHBudzZ2ZXpUTWovNysrZmsyQTloMGtUQVRTN3RSUnN1cDFWK3JlQXpsRGdU?=
 =?utf-8?B?eXN0ZHE5YWJKcGY5YWVDLzRmT0EvbWtiRkFSK29mdjkxRmd3RmEyQjg1MGJH?=
 =?utf-8?B?c2JlTEIyUERtNS9HaXlkdUh3eExuSDRMZ1dEY0ZIOHVMUU5aUDhIR2lSenJq?=
 =?utf-8?B?WVNwdG13THFRUWhKRGF4dVcrN1JoRGxsUlVVUlQ0K2FSZnloOW1lcE5tT01X?=
 =?utf-8?B?dUcwYlIzSGMzSTFFUFBGNnM4ejhlK3dtWUVDMnN5T1pYTG5zUnUwSG9Nb1Vl?=
 =?utf-8?B?Vi9yOXA2bmwxTHFUYWlHdUJ2Z0I1YWFkZ1ZtSlZBcVRxV2l6MGRnbEt5cnEz?=
 =?utf-8?B?eUpodC9hNkpVZXZ0ZTFtY0tMQ0VvQnc5Rjk3d1hTRUFqU0E5dDBjejlTcXZh?=
 =?utf-8?B?UWtRVzJRNmRXYWtrVlMyV0FJTHhzUEJoMzVEdUtuTXgyU1VWUlVkdEk2QjNJ?=
 =?utf-8?B?bTVrdzNaeERVSVJPSzM0d2ZHUTJpdjdCRWR4TW8vQ2ZMNXlNVkVpOTU5N3ky?=
 =?utf-8?B?VXJBQnc3UjVJSDk0NDhJT2R4b094MmcyaW9laTJsM3pPQlhCN1pEMDNsS1JG?=
 =?utf-8?B?YnppM1pTZ2FxSU1jL2tmaHRXTFY1UDQ1WUFLSFJUK1YvVytGL1RGTmovT3lp?=
 =?utf-8?B?enRjcnpZZnZHd1lPZm5qVXc0akpiSzRaN3F5Y3ZGb2JvMzh0K0RFSHAzTVdN?=
 =?utf-8?B?VGoyUmZjTTd1L2piRUFYZENmWVVPQm5FRG83Lzh5TlY5SHpwVFhaL2F2RnRs?=
 =?utf-8?Q?48yxX+DlCuI6aEbgqXzWDDzUD?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efb6774-4c1a-4204-9cf8-08db5517005e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6730.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 07:35:48.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MBjAaznkQQj67/3uoiFQ6j4jyK59Nv5Ri1jWq8tstIVbQfBbJJKKPAbREzJ7D50/jxyS4KnJyceMnHHi/Z8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7514
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
	Thank you for your prompt reply.

On 2023/5/15 14:32, Krzysztof Kozlowski wrote:
> On 15/05/2023 05:15, Yu Tu wrote:
>> Add the S4 PLL clock controller dt-bindings in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.

Yes. I don't know the process. So I need to add Reviewed-by: Rob Herring 
<robh@kernel.org>. And resend V8?

> 
> Best regards,
> Krzysztof
> 
