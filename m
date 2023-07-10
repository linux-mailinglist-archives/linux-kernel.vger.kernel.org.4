Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4E74DDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjGJTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjGJTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:10:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C02724;
        Mon, 10 Jul 2023 12:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWDALgY+tisPHc54uZoALLcIRiytaEAPYHg2z1Q0WTE7pQ1aOBnBPR3SGWL22Gbp1VROIH0qmiCZ8IEb/8V3YSyjZlaebyxu8ZEY5oy/Uk9JMss/U2iRyxIpCvb5EehjdVJv6ueh8hDManPEK4yaiLdq50VaP8YA+JuhiE4su5ajZ281VKggkpXulBm9UyTLhICbRyE+V1PGXz5Y3LRgNE7jhEoRxjU6HnGbp/rahlQh+gkbfUiuozT/YvLZ7DuBoV3KNLcHo5dH/XqnaFkRn030JDQM8xyEvbF0rQ9J5+Vh0RGy2MY5U79QPc3bDH41MUL+G7/9GOEOcY6VMLf2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xn52Nz2hwmNiY7UxuvErayOMCOGNFhjZlrYQ4+VpLI=;
 b=ZxPxIkQGsG+rVyTIVZUBfoZy7hxlNej44esXaWQHkRO6Dqdu0M3w+SH1R1JOqVM5W1Y2hsCUY1EjEDpcEVHk8ZEO73xGnaEhegWBmr3HIcxCo2x7rkZytgHn9i9WXFU6vbEStIxt5+tCQ9H9IrfH7Mt16s7UyZvNPd0Im+IhOiFuCgK1MM6NZoLsjuMAU8TXRujBltco8s+a6d9BJYOslnHH4DaL7v++PTPtNmKAfRF/CAuRhaVn4CYy6vk8LNBXVt7HewQSSI4fuVvfB0HdjrHbjxni4VzPRGYtG11oahiIqYRw2QVbh1Mdev+q6Bgvt/8V5Z4jIqB8O5fBc369xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xn52Nz2hwmNiY7UxuvErayOMCOGNFhjZlrYQ4+VpLI=;
 b=QoJig4Rqf6I0ZnqgOGLlfrmllzROoTEl+nGpk3x2ZJOgOTA3jRt8U/U7ytrGKTU6ynGevrJPlJDSizO4FoT49632VWoaBekxpk/WOZuXgt/2uIow6wh78W/LUvsvq9y0GcF7MlZdKdEuUw9y7KEBrgCAN1taDrvcme9WsZPZfHwn+/0iduvCIOZm5u2v18KUNvUVxR+warTdJbtdPBkvucAFVO34ib1OqfKjEHmm7MvJ2UCdGfJkMNxtjXmJu+uPoe79x2R4Ze7AZHA6u0GJQEjFIlTreMbZ83S3rhHFM4DHPtpAfNRWhtrDYeB1SEnGpbjgtnIycjGxUAwhrnFOzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com (2603:10a6:7:17::28)
 by AS8PR06MB7958.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:08:36 +0000
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3]) by HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3%3]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 19:08:35 +0000
Message-ID: <87fac0dd-9a97-b188-4887-8c4bb21196d5@vaisala.com>
Date:   Mon, 10 Jul 2023 22:08:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] net: phy: dp83822: Add support for line class driver
 configuration
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
 <261cb91c-eb3a-4612-93ad-25e2bc1a7c23@lunn.ch>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
In-Reply-To: <261cb91c-eb3a-4612-93ad-25e2bc1a7c23@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::35) To HE1PR0602MB3241.eurprd06.prod.outlook.com
 (2603:10a6:7:17::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3241:EE_|AS8PR06MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: c57f02ea-6788-4c04-9534-08db81790f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVfnBaxTdVPW+otItLgFjcI1yqT9UMO3ben7RbBM1cjiScLYsoKJC4LmhfDzBwOe3GQWIoRcWWVGiz1VMoPt5nl4R5GVjvv+LNSYyU+0i1/GyEw/jJ4UkO5ATtdGTctxQ2goqDhSu+hU6N8NAv2d9YzUoI7odDBJHBkUp8KRG+1A+TCUG+IIUh2f/A8QIwFWNLEe+BQTtuAu9W6r1z1AZzVeoUa27NNGlqc2/ayFzhdnW5AcEgoniVpTFZE+TVR/P5McgsvGv3GDl10phi7q6RErteoRQQzmAEB9PWg966661Q46e4PzJHfdKUuX30pRb0W0maZlIZ26tHZjYpQzGZKw19tLPqlhg36E5nmGuhi6oF1XTTB10Wmlfr2lqhyxcwNQf2rlvUnq0nfLo+evL6Yldp/6CCqLK10JwDmJ4KXugm0FSopxE5uLO13jxKQNdiqHxnOCI3ojgdpOpK0/GqUNy5x1BouC1QDA2Oj+jXEXiRkdevp5thJK6Y4Aipl5tMA2fz1w6LmYCfRYkuzERfujjgSkDDrrswszDzDKCzn7H/lTGltHzTyWfSl6TMFZsd+7FGlV/t7ujmMLtNBc+wLnutB9FKLAxUFikzAseY4Yux259K91+4ZE9QVH/SJxa1nK4JYmbyTIXnPJHar5Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3241.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(451199021)(186003)(26005)(6506007)(2616005)(966005)(6512007)(66574015)(83380400001)(41300700001)(4326008)(6916009)(66556008)(316002)(2906002)(7416002)(5660300002)(66476007)(8676002)(66946007)(8936002)(478600001)(6486002)(6666004)(54906003)(85202003)(85182001)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxPdUl0WkRJQzJzQnUxU1ZMRU85RTEzQUZHWURFaDBCYTlkV05MM2JSV1VX?=
 =?utf-8?B?bHNyVlh0SUJ6TkJpdFhQeVlTVW5FeVdmeVpyTjdMaDk1U05EZC9nUG5xYWhy?=
 =?utf-8?B?bitDbmI0Q2FNaHFOVVBpdGVIcktJVzdVaFh0RlhkVmV0YkRWVVlSMWVDSStq?=
 =?utf-8?B?VERVcDlCdnQrU0M1NGt5ODIvc2RJWVVtZm5tYWVPVEpGbWdObXMzeVBqaUYy?=
 =?utf-8?B?b3FRMGNKV1F6YUdPTGd5TTNsK0E2MTlYSFRFNUxSZEM0YzdxYXNrVDNBdGdh?=
 =?utf-8?B?dzVBeGMwaXgraUxNU3d3ZlZGaVR0cXJIT1ZMZVFYYXFIOGcxc0paTk5pcll6?=
 =?utf-8?B?NkdESkhmb1pjM1M1M0JtSXJTRERUbkZNQ3BpdmhDYVUyL0tBK3pxNXBtVlg0?=
 =?utf-8?B?RTQyazBHUG9qWWxHUEVUS2lQcy9ZWktwRWMxRTJjSmR4RGprSjlPYnZ3MGZy?=
 =?utf-8?B?M2JXcXFHVlBKb0xPTy9CWU9TMVk3dzAyRDhWN0cvNWNuQlY1bytEOXE1czhs?=
 =?utf-8?B?dGZPZkRpTW9kVUY3bWRqNzV0UzMrZmQwcnRwT0t5V1daN3REcUY2Sld4T0lj?=
 =?utf-8?B?ZVhnTmFnRFh6OU50QWJSbXcxdWIvUHdQbkRSRHc3OWRqN3Z4S3JyWXpvN1Vs?=
 =?utf-8?B?RWwwcGYvTjVNT0JRNXRQaGQra2RPMlRTZnJvS0w1QWdaVm9uUG92dkZ4QVVo?=
 =?utf-8?B?bUFZaW1VV3RlZjJncUhnYm5vMENWK2daRnVlTk9DbCswWjA0Um92ZG9tc2JU?=
 =?utf-8?B?dzRzZlB0cDlKMEFlZmhTQ3N3ZFZpUEU3RERacldiaWFpUUkxY2Q3cWpQQk04?=
 =?utf-8?B?Z0hMVThTcjZNVnNCQ0ZNT1dVZTJLQXFOOW9pWmtkYWJmU3NzVWU5dldkNm94?=
 =?utf-8?B?UVhvSlhpYlFEemFmZzJkekgwQ2ZqdFMwZ2NwY1pDMC92ckxHNWNpOVRsa0dw?=
 =?utf-8?B?VVhCNUlGKzMyYWtrUkU4Mm9VZ1YxbFd6U1FoZlNBdEU3ZVNXSjlMMEdyaWZ6?=
 =?utf-8?B?bitkYXJZa2Rwa2pxQlJGbHFZcmRsUG84bGo3Ti8zblVVb2d5VlQxOHlIVmQ0?=
 =?utf-8?B?OVIvWW1TdW9XSFFESXc3ZmxwTjMyZUluQ3RLK2VmQ3NZNkpHc1pOWDRCQWwr?=
 =?utf-8?B?SmZ3U3ZMUWsyYlo1Ylk5WXJNYUU1Z3VLQ3dKV0FqdEc3Y3JaejloRUEzN2I1?=
 =?utf-8?B?TlVBOHVrT3YzVTE5dWJMRFBtOEwwRGx1OVNkYTdnN014czB5WlU1K3NQWXJV?=
 =?utf-8?B?SWRNeG9uaGMwQUg2bTVyM1hld0szT3B0Z0IxL0QwUWNUQklVazAramFUS3ZF?=
 =?utf-8?B?dWo1NmxjZUlyRTJ3SHRBSDY3OHRhT0wyWk5GYm9GR2JEVmwxY3I3RnllSWho?=
 =?utf-8?B?R0s1bVhwZ0tCTVo1eFgxTlVoUkdZNnNqeXFCRkZwc3FlN0swbWJRL0xnRGxy?=
 =?utf-8?B?d2RFbTdXMHltTjhHK3hHWURrM0ZRRkh6K1JSb0svV2xUb3JLb3plVVVMS0pK?=
 =?utf-8?B?L1dreVF1QWtrTCtqb01TWlRNQ2szR2EzRTRhR2dEenR6NXdaWEc1RWhJekho?=
 =?utf-8?B?bWlORmg3WHpHOURWRXpEMFp2L1ZmdGlhTmh0NDFsS2FSRE0zc1RFejBNL2VW?=
 =?utf-8?B?KzhNWnUyRzczRnl0QWxxdG83TzhnRkZQM0QxdlJ2N01ZY0lmSTVUVXJLSTJD?=
 =?utf-8?B?RTlZcFpQd1RVMzdEaEpSZFdKeEswNGJKSFFMVDVVTGhnTzArUm50QUczSVF6?=
 =?utf-8?B?b0FGVFJ5bXcyWGYvQWFjdzVtNVFPaFEyYm52NWlnbzYvYlFoUjkvWkgvMVlq?=
 =?utf-8?B?RzlzR1h4NmlLMWNiM2w5a04yL0hsUVVLaDNxTzg5Nk5KeDB5cm12V2JTamEx?=
 =?utf-8?B?NXpyYi9jbkYzbHBUbWtobjY2SngrWTBTREI4OXBRTkRmYnZZK3lvT0I2TVF0?=
 =?utf-8?B?Vks5SEZvb0toblkreXhqcnc5RlI4YzRiNkpoRFRVd1VOVktFSGszU3FGUXdD?=
 =?utf-8?B?ZEFuU05LU1RXcDE1RSt2L3JuVUdJTWg0SGVPYWlCUXR4UjFXWkwzcUpyYlhm?=
 =?utf-8?B?VitXaHh1OWNYcU9vRnBTaVRiNHVOL09lTmpUWDRickpIM0tzSE1SaDBhU3I1?=
 =?utf-8?B?STZjQ1pOOExhUHppa0M0ZFBrVHZTNFc0NGdialZ2MXVmK1F2N3BvWi8xV08z?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57f02ea-6788-4c04-9534-08db81790f3d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3241.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:08:35.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOiETlkbkPPMtLHxOx3XaeOchjs4Ndx0OS6TMyha9AFXVl9st6VmtZdKODXaLPZhCpW6bE+Oe7vIXFKzCzjJpoDnl9reEruVLrsKGDadgW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7958
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.7.2023 21.38, Andrew Lunn wrote:
> On Mon, Jul 10, 2023 at 08:56:18PM +0300, Vesa Jääskeläinen wrote:
>> Add support to specify either class A or class B (default) for line driver.
>>
>> Class A: full MLT-3 on both Tx+ and Tx–
>> Class B: reduced MLT-3
>>
>> By default the PHY is in Class B mode.
> Hi Vesa
>
> Do you have a reference to 802.3 or some other document which
> describes these. How does reduced differ from full? Is this really a
> hardware property of the board?
>
> Thanks
> 	Andrew

Hi Andrew,

This is needed for configuration in link between DP83822 and Ethernet 
Switch chip. In the connection there there is no Ethernet cable at all 
but routes within the circuit boards but instead has capacitive coupling 
on routes.

The other Ethernet port with the same phy is connected to normal 
Ethernet cable and in there this configuration is not needed.

So the setting itself is related to specific circuit board design.

MLT-3 is related to encoding used in the signals -- I suppose wiki page 
is good introduction reference:

https://en.wikipedia.org/wiki/MLT-3_encoding

I suppose this question in TI's forum gives indication what is the 
effect of the setting:

https://e2e.ti.com/support/interface-group/interface/f/interface-forum/572998/dp83822hf-transformerless-operation

TI's datasheet is not too verbose about the effect:

https://www.ti.com/lit/ds/symlink/dp83822hf.pdf?ts=1688188848392&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FDP83822HF

I cannot say I am expert on the Ethernet line encoding -- my 
understanding is that full MLT-3 is "normal" signaling mode and reduced 
MLT-3 mode is extension on the chip to perhaps reduce energy consumption 
with real Ethernet cables or something like that but in chip-to-chip 
link the reduced mode does not work and full MLT-3 is needed in order 
for link to come up.

I hope this helps?

Thanks,
Vesa Jääskeläinen

