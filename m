Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7A69D60E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjBTV7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjBTV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:59:39 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0F115;
        Mon, 20 Feb 2023 13:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+qHIaqWq400gp6Gos33hfsibAq+CbnV4svhZzDFTH8WKMpn5NmLHYTbanwhCqDvtqdo481tVRXZOXiiE8mfrXyQNAYwWLnCjiAW55a4zGCZYbGlZdA3yaCGRe/keU2a/IH9xA8bOOkkUS8puImnBvizdANCbLxocfLGDzMaaDszsc/Emf9vTCkdA+0FtYEgk9oI908WjyLV5UN9ZORBQnGrm2aQJitkHhz5A/NSelTtz7yguhmZjfg1o57+RFyrycajUN7CJm/TT+NDkmjuEQfAmWxlfhqBDN8EST/Oh7h/65PZ2zv1WUjyfU3iRLz/Wya4TVixzdAT8X0pXYUerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7skN0IBBuSa2LkexIbV9Txt8MXCK+0ROUoUXzOwbyA=;
 b=Y+4/j7iMFg+QUzhh6Z2iw30OhLGX+TzjaJn6VMOgs3mAr0z5ZKm5FVkJTgQ3//hSS3Y2YsldEhjNKj4DVt6ehREmi7/PAvzrkAIF+UqBvKKoEasHAwbzMfm/TMZ6KDCXG1N65vBKHJ9qoxjOuwlcjz+Mla4e8NX2S1Yvt38+4oiXP71cJ6gLUYnlR3G5mPeB1ff1ssyZAfBTd9UbI8aqV0hqGLQQBGj0aSBSt/sHivl1vNr6JWB06fGipy/K5t+RF2qkOP65jQvcnfbBI1ks8XlaNsmAApSRk1FidHTg0ow2hcZKOkQte+WfTUWyLJFH3eZRrnhaACMrLTThmp8KYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7skN0IBBuSa2LkexIbV9Txt8MXCK+0ROUoUXzOwbyA=;
 b=k2Sd+8h78fNCcX0K0MQvZ73o38TMQ3ErzAtCMFaoTNPKePO5a4rH1CE4uiGo1+Ex38H0G45QyUZqceK4TMuatRvckah2ChRSp1g5mg1AdmjS4JUFWDEKzNSsxfqjIIf/XzvUv9Lr2+hGsLrUgNIyP4R7SErMPxprMgv0HYCVshk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Mon, 20 Feb
 2023 21:59:32 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d71c:fd55:d8cf:4fc0%3]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 21:59:32 +0000
Message-ID: <1b8b6bbc-34b1-a2e5-0af2-6d03b2e2f797@oss.nxp.com>
Date:   Mon, 20 Feb 2023 23:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 03/10] media: Add YUYV64_12 video format
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1676368610.git.ming.qian@nxp.com>
 <f5ef51d5e0ce881501a3d72a8e49c8a040fc64f6.1676368610.git.ming.qian@nxp.com>
 <b734fa87-c3ca-5c21-d8ce-ad5083461200@oss.nxp.com>
 <AM6PR04MB6341F28B0116C2263DFB9ED0E7A49@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <AM6PR04MB6341F28B0116C2263DFB9ED0E7A49@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0085.eurprd07.prod.outlook.com
 (2603:10a6:207:6::19) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9244:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6953718e-4196-458a-4f27-08db138dbee9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGTXum1mZdKSPeOzeWN0oMJaGzMgAse+zun3g91dJy6DgEqHQCPYhT6Alp9ThNVsJbT/TYsrNQ4LDhNb8/+sNjmk9GMqK4DEbFN3wJTsuBeIXYYS9DtHo+iI8Qf2YcJr08ms4bxsoymna/pEH2pzHEKNfUzQTtX+nVRX3DzchIXKN3i87pn43CMMQybSeHRW0xgxNaDznBH9PKAAWUBlgMWdT/1kW6MPC/xMIX+f5qFsxbnlXbnh7PFygPFPhcz+evpW+MPjnpTUOYZHu6GHf2H53VpoeCUZ5cLBlqIzzjTtbbpzfiB6jSoNOXGvK6Km4MRPJYCax+zuzupi4BejXsGnJITVXjO6La4gBPkVhuHDowMVVUo0R/sGXxoF9Gwi7VNPMlo5bPlyPdcxNRq039KXnuXBUnCYaQOiuLVr+9unPVZuDmtXVqjhFNdLVuun8SNh2ZBf3WdjYRi8UPzmxlwBpCEbJALuox+JTSl0DwVFIS51wywWHK4Fi4u6JBUnct1Fg9U9Xw6Fq/1V1oIqvkabGO6rou4va1oWVQ0hTawWAQ7Ziv3ZfjR78Az7hOty1niwLd8WkXxaO+sD0litNdv+eJCC40yraRUOyQeidi3AcgM+wwBzXS5CfL4ZWr3AWzE2uNtaBie6tdx6Ep+ihu6+FiFBE/VsVXabRVhD0qo+0kJZY6YKTryzEDi2S9BqtDmLbSjPsscUkk3O1KBqFFMX9GYZRLtQ9bLw/TO1bdFMM3OCBPOIk9+tRPAfAXmG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(83380400001)(41300700001)(186003)(26005)(6512007)(54906003)(110136005)(316002)(31696002)(6486002)(966005)(52116002)(53546011)(86362001)(478600001)(6666004)(6506007)(2616005)(66556008)(8676002)(66946007)(66476007)(4326008)(2906002)(31686004)(38100700002)(38350700002)(5660300002)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZuSUx2RVQvTjVmOHE4ZEljMXl0WDBpTXFmemttNWdKMnFCNXJRZHBPdkZU?=
 =?utf-8?B?L0dCbGFsckpZVXBJQ1ZsOHlkd1NBZXFkTFV3QStSR0tQWDhlOUtkNXh2SzNL?=
 =?utf-8?B?RC9Ga2ZpaGZSTFZBUm9HNDUzWVJlcnVkV2NHZ05lUktJaCtKdUtiQ0laNXB3?=
 =?utf-8?B?OS82dUgrMGpoR3VvVGNDYWVSZm9FbGlOaHRKNytSY21nWVZxdHY5NGRlNGxw?=
 =?utf-8?B?QW1ZQU01Q3kwVCtKZ1JpbmNMVHNzTnVWa21jbEpZSDB6V08wZ2FLQ0xUdW9C?=
 =?utf-8?B?cTRFN2VmVHRBaVN1a2VXdVpISVd5K1lGM3JQcU1yRUhFOG41SUozYUZQbENR?=
 =?utf-8?B?ZGM3cWVZTVA4WHgxYTM3ODgxWXgyZ2RJTGxoRjk0ekF1MnVjRTd3YjhkSHRN?=
 =?utf-8?B?V2oxMWo3ZExEVnJ2ekxiUlg2WFBxRWVZaXhVdVJsL3YrbmxsWVdCU29GbEpK?=
 =?utf-8?B?NWtKTDlGVnZubTNsdWNmZUpFYjdkS0tYMmlnNnh5Y3BTc3lLU3lKWTFpQyt1?=
 =?utf-8?B?SVRVeFdHRnpRWlVCMHE5Uk5ZR2NhM1pyR1hEL0lnYWs5UENLU2x2eDhlNlgz?=
 =?utf-8?B?WGo1dXhHZW0xdWNlMkF6SExZZDBIYXdNWXBUNThocVlYZUIyNWtSTTd5WWlm?=
 =?utf-8?B?Y1Bzd2JnbVBjNk5ZR3I4NHVIejNEQU9aYnJHUk5JWC9DSGxwcFhUTlNJbzlo?=
 =?utf-8?B?TmxLM2RsQkErTm5CeCtRSUZBdWRQSWxPcEpLL2daSFV6TDFlT3c0YjRWa3NE?=
 =?utf-8?B?UkpCeXY4UjJOcWZVa2tZYTRDcWN4SVdGVFJ3NlFGWTVJdkZpQ1dPUUZTSHFS?=
 =?utf-8?B?TnpvZEpUYjFBb2Rub0RTRkpscjJ6dlJlU0NUVlVwTjBCT0RUbFArYlpQakY4?=
 =?utf-8?B?TXF4Y2QwVml2S1RTNS9xVHhmSERkRDl6bHZDMWV1MkxJRHFSNExscis0Y2lB?=
 =?utf-8?B?dWhpMTVva05oVkgweFVrcUt2ZzNyNFB4YjVMcHM0M1pEc2ZvY2o1NVJ5OEM0?=
 =?utf-8?B?OW10bUViRG9pNzRRWE1vV3JzVHdIY1l1V3RBQ2JaZ20wenpEL1BYUCt6U0k5?=
 =?utf-8?B?bytFdGlsY2Ezb1BNVlkrck4yeUFuM1VsVXZwUXd1TS9tcDlONFNoSmhZaUVU?=
 =?utf-8?B?R1pET0tsSnM4L1djVVFJRDFocUhBbWZKY0xINDVrcThzYzc2OUwzQStCTVEw?=
 =?utf-8?B?Rlp2ZEhsRG9jaEZCSEh3a0RTb1NmRThCejArck9HNlRrN3prNUExU0lkcjhZ?=
 =?utf-8?B?bzY4R0NVUEdKU2FEeHJtL0pwaG05Ri9EV0tmeW81VG5BWW93aXA2bXJudXh5?=
 =?utf-8?B?R3RpZ2ZYczIwSWVlNlNYa0tCUGRyVDVoQ2hqeG9DYlA0amtUVUNmK1VlVGZX?=
 =?utf-8?B?b1M0eDFQejA4TWZPM3FlNmxYRU5IcGpKQm0xL1FBVFU2TkR2ZnlsL1NDU25D?=
 =?utf-8?B?NGNqY2lyeUsrcm1vOW81ckg4M3JEeTdha0RsODVCMWJIdkkrWjVDQnV5T1cw?=
 =?utf-8?B?VCt5VjJHc1hkZm5IQ2paejJjMCtZejg1cFpLN2xudExJQkNjSXdnbUR0K0xk?=
 =?utf-8?B?WmtrTi9UYjRDUlZUaVVKTmlUWXlGMlpkTVdkY0JTRis1SnVBMUlEcDk1ZCs3?=
 =?utf-8?B?MTQxWGIyb1JYTWtjQUJxb21JMGN6U01tVE85Y2hQdmNvcUgwbFZOd3F5c0xG?=
 =?utf-8?B?NlRCUzFiRW4wTHUvc2c2MWVhdnJqTXFSMzh4RzZ1QVI1RUY5THNiWHJHRmVC?=
 =?utf-8?B?R2xodEtTME1IeUEwYmJVMXp1S0hUMTliL212Vm4ydXlNZ2xlSklWWDhUV0ND?=
 =?utf-8?B?bTFDS1g4ZGh3Vzl0VDE1QlVwenZTL0NDTGdsZXIvNlFsUENTa1IzQklGNWVi?=
 =?utf-8?B?MXFjV2dWQzNiTWZOVE8xc0MyWENXNlcrZEdubEQrdFBGSkJUVlJrMGsybGdz?=
 =?utf-8?B?NWxpTlpjVmRqdXN6N3A3K044aENiWmJ1M2lqUFhtc2JmUTFhakJzZXRxZzZ4?=
 =?utf-8?B?WkJkRWlRR21nbGY2V2JPM1J2a1N0bzU5dmgzc2Ezc2k2dmhFZDlHZTVPaHFZ?=
 =?utf-8?B?VXdPUGdIcGtncG9zb1Z1ODVLeVFQRzJaZ3ZOaTlkQmhsVk1LdVA1UjdYRk5h?=
 =?utf-8?B?NlRIQTVwLzVBNURRcTZ5OGhIRXdzdlpma3Q0NzN4NGFjTC9scC91bFpKZmx5?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6953718e-4196-458a-4f27-08db138dbee9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 21:59:32.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RguUQV9jB78lo0b0y86mPc/Zk9yNBveXD3mUB7hdwlCxqOITHNU6z/lAl/48TmaxLjcI/LOaXHHtZUdbj3sGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 20.02.2023 04:15, Ming Qian wrote:
>> From: Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com>
>> Sent: 2023年2月19日 5:52
>> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org; hverkuil-
>> cisco@xs4all.nl; nicolas@ndufresne.ca
>> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; X.H. Bao <xiahong.bao@nxp.com>; dl-linux-imx <linux-
>> imx@nxp.com>; linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v3 03/10] media: Add YUYV64_12 video format
>>
>> Hi,
>>
>> On 14.02.2023 12:04, Ming Qian wrote:
>>> YUYV64_12 is a YUV format with 12-bits per component like YUYV,
>>> expanded to 16bits.
>>> Data in the 12 high bits, zeros in the 4 low bits, arranged in little
>>> endian order.
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>>    .../media/v4l/pixfmt-packed-yuv.rst           | 42 +++++++++++++++++++
>>>    drivers/media/v4l2-core/v4l2-common.c         |  1 +
>>>    drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
>>>    include/uapi/linux/videodev2.h                |  1 +
>>>    4 files changed, 45 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
>>> b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
>>> index bf283a1b5581..76fc331f126e 100644
>>> --- a/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-packed-yuv.rst
>>> @@ -341,6 +341,48 @@ components horizontally by 2, storing 2 pixels in 4
>> bytes.
>>>
>>>        \normalsize
>>>
>>> +The next lists the packed YUV 4:2:2 formats with more than 8 bits per
>> component.
>>> +expand the bits per component to 16 bits, data in the high bits,
>>> +zeros in the low bits, arranged in little endian order. storing 2 pixels in 8
>> bytes.
>>> +
>>> +.. raw:: latex
>>> +
>>> +    \footnotesize
>>> +
>>> +.. tabularcolumns::
>>>
>> +|p{3.4cm}|p{1.2cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8
>>> +cm}|p{0.8cm}|p{0.8cm}|
>>> +
>>> +.. flat-table:: Packed YUV 4:2:2 Formats (more than 8bpc)
>>> +    :header-rows: 1
>>> +    :stub-columns: 0
>>> +
>>> +    * - Identifier
>>> +      - Code
>>> +      - Byte 1-0
>>> +      - Byte 3-2
>>> +      - Byte 5-4
>>> +      - Byte 7-6
>>> +      - Byte 9-8
>>> +      - Byte 11-10
>>> +      - Byte 13-12
>>> +      - Byte 15-14
>>> +    * .. _V4L2-PIX-FMT-YUYV64-12:
>>> +
>>> +      - ``V4L2_PIX_FMT_YUYV64_12``
>>> +      - 'Y212'
>>> +
>>> +      - Y'\ :sub:`0`
>>> +      - Cb\ :sub:`0`
>>> +      - Y'\ :sub:`1`
>>> +      - Cr\ :sub:`0`
>>> +      - Y'\ :sub:`2`
>>> +      - Cb\ :sub:`2`
>>> +      - Y'\ :sub:`3`
>>> +      - Cr\ :sub:`2`
>>> +
>>> +.. raw:: latex
>>> +
>>> +    \normalsize
>>> +
>>>    **Color Sample Location:**
>>>    Chroma samples are :ref:`interstitially sited<yuv-chroma-centered>`
>>>    horizontally.
>>> diff --git a/drivers/media/v4l2-core/v4l2-common.c
>>> b/drivers/media/v4l2-core/v4l2-common.c
>>> index a5e8ba370d33..8fb1c0fa8158 100644
>>> --- a/drivers/media/v4l2-core/v4l2-common.c
>>> +++ b/drivers/media/v4l2-core/v4l2-common.c
>>> @@ -258,6 +258,7 @@ const struct v4l2_format_info
>> *v4l2_format_info(u32 format)
>>>    		{ .format = V4L2_PIX_FMT_YVYU,    .pixel_enc =
>> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0,
>> 0 }, .hdiv = 2, .vdiv = 1 },
>>>    		{ .format = V4L2_PIX_FMT_UYVY,    .pixel_enc =
>> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0,
>> 0 }, .hdiv = 2, .vdiv = 1 },
>>>    		{ .format = V4L2_PIX_FMT_VYUY,    .pixel_enc =
>> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 2, 0, 0,
>> 0 }, .hdiv = 2, .vdiv = 1 },
>>> +		{ .format = V4L2_PIX_FMT_YUYV64_12, .pixel_enc =
>>> +V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0,
>>> +0, 0 }, .hdiv = 2, .vdiv = 1 },
>>>
>>>    		/* YUV planar formats */
>>>    		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc =
>> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0,
>> 0 }, .hdiv = 2, .vdiv = 2 },
>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> index ec1c9ef27e88..e5002d6fe7ee 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> @@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc
>> *fmt)
>>>    	case V4L2_PIX_FMT_YUV420:	descr = "Planar YUV 4:2:0"; break;
>>>    	case V4L2_PIX_FMT_HI240:	descr = "8-bit Dithered RGB (BTTV)";
>> break;
>>>    	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)";
>> break;
>>> +	case V4L2_PIX_FMT_YUYV64_12:	descr = "12-bit Depth YUYV
>> 4:2:2"; break;
>>>    	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
>>>    	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
>>>    	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
>>> diff --git a/include/uapi/linux/videodev2.h
>>> b/include/uapi/linux/videodev2.h index 3d8f89bff33c..3712a36d6fdf
>>> 100644
>>> --- a/include/uapi/linux/videodev2.h
>>> +++ b/include/uapi/linux/videodev2.h
>>> @@ -618,6 +618,7 @@ struct v4l2_pix_format {
>>>    #define V4L2_PIX_FMT_YUVA32  v4l2_fourcc('Y', 'U', 'V', 'A') /* 32  YUVA-8-
>> 8-8-8  */
>>>    #define V4L2_PIX_FMT_YUVX32  v4l2_fourcc('Y', 'U', 'V', 'X') /* 32  YUVX-8-
>> 8-8-8  */
>>>    #define V4L2_PIX_FMT_M420    v4l2_fourcc('M', '4', '2', '0') /* 12  YUV 4:2:0
>> 2 lines y, 1 line uv interleaved */
>>> +#define V4L2_PIX_FMT_YUYV64_12   v4l2_fourcc('Y', '2', '1', '2') /* 32  YUYV
>> 12-bit per component */
>>
>> It seems Y212 is already added with the same fourcc code, causing build
>> errors:
>>
>> drivers/media/v4l2-core/v4l2-ioctl.c: In function ‘v4l_fill_fmtdesc’:
>> drivers/media/v4l2-core/v4l2-ioctl.c:1455:9: error: duplicate case value
>>   1455 |         case V4L2_PIX_FMT_Y212:         descr = "12-bit YUYV
>> Packed"; break;
>>        |         ^~~~
>> drivers/media/v4l2-core/v4l2-ioctl.c:1349:9: note: previously used here
>>   1349 |         case V4L2_PIX_FMT_YUYV64_12:    descr = "12-bit Depth
>> YUYV 4:2:2"; break;
>>        |         ^~~~
>>
>> Regards,
>> Mirela
> 
> Hi Mirela,
>      Would you please double check it?
>      The format V4L2_PIX_FMT_Y212 was added by the first version of this patchset, and it should be replaced by
> V4L2_PIX_FMT_YUYV64_12 in this v3 patchset.
>      And I checked my patch, and my local environment, I didn't found any V4L2_PIX_FMT_Y212, and I didn't meet this build error
> 
> Ming

I applied the _v3 version of the patches over linux-next, and the build 
error comes from conflicting definition of the fourcc
#define V4L2_PIX_FMT_YUYV64_12   v4l2_fourcc('Y', '2', '1', '2') /* 32 
YUYV 12-bit per component */

with this patch, which adds:
+#define V4L2_PIX_FMT_Y212    v4l2_fourcc('Y', '2', '1', '2') /* 32 
YUYV 4:2:2 */

commit 0dc1d7a79a8d13e316d3b168e9fc57e376099c7a
Author: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date:   Wed Dec 21 11:24:43 2022 +0200

     media: Add Y210, Y212 and Y216 formats

     Add Y210, Y212 and Y216 formats.

     Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
     Reviewed-by: Laurent Pinchart 
<laurent.pinchart+renesas@ideasonboard.com>
     Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
     Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
     Signed-off-by: Laurent Pinchart 
<laurent.pinchart+renesas@ideasonboard.com>

https://patchwork.kernel.org/project/linux-media/patch/20221219140139.294245-3-tomi.valkeinen+renesas@ideasonboard.com/

In this case, matching the formats defined in DRM was the stronger 
argument for the format naming scheme.

Regards,
Mirela

> 
>>>
>>>    /* two planes -- one Y, one Cr + Cb interleaved  */
>>>    #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr
>> 4:2:0  */
