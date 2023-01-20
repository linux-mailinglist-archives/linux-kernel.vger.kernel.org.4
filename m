Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D87674964
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjATCgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATCgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:36:09 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2060.outbound.protection.outlook.com [40.107.113.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E2A295B;
        Thu, 19 Jan 2023 18:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTPTXxqa/wprnS5WYPKO/1NV9QcRHUScFkkxAUNSvK+3WAF10xREz7i3V3OLcRmkZQI87N8G78/vLvWcThbQNTnmm6zCgYxk0guqoXu7M021IOG5p6Lz4eAw2SmdYKhgLRRHI2PgifwpmdKXvkKChlZgcX4JUL0cI9/odCTNxspqbAp4YRuV3KH2MzloCDEYKTT1NDi11cZogi10B90O1c4Edd7AeS0vn3n2/NzYxXpX2/xa03A8zOJmrPRe7tNuxssNphdk/fOYD1LwIIx8UOq9fNTR6nAjfAbOcZkVhUxz8r/fgQJcaG4XuWGMhES6rGiALio09xN9GAdnzQZiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sV/6Sw1sYBhvizjJ0t1fLvMMKNnX8PDsRLlrZElGNo=;
 b=DYwnrg6LGgs9vzkH7ENnObAN5NfOTOyGzEFSaxtr5Nx/iuhGh90genInuFCkQyECKLoPnKDhtOp/oMEdO+M3DqGbyaM2PR28WP1boDQKhOeG7fzAYvy6/2c1PFDtEankqXeMNYRZuq/n931/EO4mUpBJZeVm7NpBm4bgFEAOfqlYTdgEG+d51WOT0xyC7B4Rqbd3ogkyLVbexRMvwgAZmS4bqRe9vAgUeEe/82EdMTqtkYHXd6mQRHPLR9459bY3vUpOWKQ79+s6Px8Mk8UURp8mEfsseL5+Bf+nPiQBby3dT0IuQ23NMBoyF4QVLA9d3SyqtRKD8rSge9uLAP/vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sV/6Sw1sYBhvizjJ0t1fLvMMKNnX8PDsRLlrZElGNo=;
 b=iUCZ6HPDFHpJ/J1hfiIgzCUsUzRpRiW2hSpnD92MkKhJXldxDwq6PM0OLAtmA1v0MyRCdhwzGM7l6C8Rj4i6ewPnGu54BVWrt4zzmqEY82DD/Bf91KUvqE43piQkXHCw666n9lRWCK3a8bxU2Tl3CX1QQabjXIPNDwwDs2sjoKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by TYVPR01MB10813.jpnprd01.prod.outlook.com (2603:1096:400:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 02:36:04 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::4f13:ff9a:ae4a:452a]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::4f13:ff9a:ae4a:452a%9]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 02:36:04 +0000
Message-ID: <379c3311-9563-0fe1-760c-9dc252cdf0d0@sord.co.jp>
Date:   Fri, 20 Jan 2023 11:36:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Dennis Lambe Jr <dennis@sparkcharge.io>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?Q?Myl=c3=a8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20230119213903.899756-1-dennis@sparkcharge.io>
Content-Language: en-US
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Subject: Re: [PATCH v3 0/3] rtc: Set M41T82 & M41T83 xtal load capacitance
 from DT
In-Reply-To: <20230119213903.899756-1-dennis@sparkcharge.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::23) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB7049:EE_|TYVPR01MB10813:EE_
X-MS-Office365-Filtering-Correlation-Id: b63f7c5c-1f05-458d-3bf2-08dafa8f13b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7VgTo0QBGnepXbOEbaf/olaEqXtkVWy/kkFRFfOjfYTH/lN/74o+BL8AQEvuYenD6H6KqqHNhbdsMSt2oNNoQndsOcKLaRb1IMhqiCkFqk/n8CLx/+H+U+kaQbE5HvO3OrCj9k87PmggHXyXnquJ/2BFhW+IqTe4HJ4qVKwJx36MxXFRi1Zi0VHm4nFfcVkSZG6HnF9KbU9y2FKK7PQz6S8huhIFRV8hzFDFoZBqt+zAcMkIyEC/eYiJfTrKxDku3qCYvq2A4VADm3KHMTjeHsofpJLZlJO9razSl3Vk2hU9Is2BHZV6pAauN4NX5ISoYw63pa58kRAaFjkmWsbDk5TR2PVPGHd5bAKMqwIMfD8hj/zsDzTAgV/bRasu5Mr1PshExcQJFiyYobQpk1YxRwm7ud5jAMM+mPaIL09R0prDg96Af0LYxWpfcQoMWPkx5qARZ8z+UV1y6zAbTvhfJGfj5sVeSUXhXZP3VBVyDcXIfh19lQc38I4xgmEefmM3mIuZ9nm+YB00pR2BEj+TGFO9iOA//Ji2TjzA3rzexs8/dUlbgLXw/wfHVK4YWY9rXg3aXJGd/L/TpxYdAMjdOqeaFIa7Wbu+XTG12KwYO3YB/XLGcERYtN5bpIjuaTzApmRFJmGa3tJYkZs44WTjNHgV+QnnL+T/M7m/JFT3JMns1bO3OK06jBGWr4GWttXCQuko7FP5yGfEQNgcIQ7QpI1ioJKiBJKvk1I6edxohc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(376002)(136003)(396003)(366004)(346002)(451199015)(31686004)(6486002)(478600001)(53546011)(6506007)(41300700001)(6512007)(186003)(26005)(7416002)(110136005)(2616005)(66946007)(4326008)(83380400001)(8676002)(36756003)(66476007)(66556008)(8936002)(2906002)(5660300002)(38100700002)(44832011)(54906003)(86362001)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJDYm5vdkV0SXV4S0gwVGx5RG4vbUorV2dULzZuWG9kYS9yVkJEd3Q2Mmhz?=
 =?utf-8?B?clVmVjJsa2t4ZisvYnhLK3NrT3dDeUU3TTlDQk93eXYySFk3NUhjd2hGM3Zv?=
 =?utf-8?B?R3kxS1o3eWtpVjdyS3dqVjJFakFxY016Qnp1S2dJcUtNRi9VeURKNURrRkRO?=
 =?utf-8?B?SUQ0angvcGlYV2tzVHFZTlRtZHNXTXhhekUyWmVEbXYveFRCTGwzTzhwMUJp?=
 =?utf-8?B?ZjBmcjhYYmtjNi9EYTVmeDhkSVFsOGdqcVBBNGNJUzNhcGxyb2FmSlN3MFpF?=
 =?utf-8?B?MktGR0xhY1EwWnVPbkZOTTFtQTBDR1lhUnA3b3JOSXU1ZmI0U09lbHIya0l4?=
 =?utf-8?B?WW4rQm5FWlFoWEYrS3VGcVBQS1o3VFQ3bGxybGFKMzZERHhrUFFranpQcUV2?=
 =?utf-8?B?clU3UmVRRHhidU9WK2NFRXB5YkNhSkp0eUZ0RUJkdmdKY0c3Njg2OUlCUTZs?=
 =?utf-8?B?R3R1a1pkTWNiWXRKTC9mdWRTSzFDRXNBMGVBZzhqMzRUd1krbE1RVEFGNHlm?=
 =?utf-8?B?Sk1yZXNPWmErdUxCVytsN0t4UzQyQzBZVHkwbi84K0hVSUJETkN1bU1QYXgy?=
 =?utf-8?B?L09QTFE3a2lTVWxTdE8xMGNpZFpnbm5NWVJZQ01mNVErclA0ZVE2ZXA5bEdI?=
 =?utf-8?B?Z0wzMThDQVdqaVM3eFBMbjZxK1kzTzU1dVFMYVpBTHJTQXgyWEtudHc2cTEy?=
 =?utf-8?B?OENTa1Y3Q0xhZGVWZGhtM2Y2eHlxY29meVFzaklDVzhxbG1ERVZxcHR5VDBY?=
 =?utf-8?B?cVgwSjZCTlBZMmhUQUJ2UDdEalNNakpsMlR3Tlp2S3dlYnZwcEhZOWpQVjBx?=
 =?utf-8?B?Vk5IUTFEWThoVm5QbnRNTGgwVzFKZW1iUTdkTkoxT0pGelZURkVBcFRLWHlz?=
 =?utf-8?B?RGhyRy9vVk5hTS9wUUdHd3A5WWtCQXMxS2VrVGkrRHBKM1U2T2dvTElkQVVl?=
 =?utf-8?B?NlFjOWNSaXlSYVQvblFNeEV1MjV4RDBFWmpINldlOU1Nd2pqei8yTU10M0ZW?=
 =?utf-8?B?Sk1mb0lWdk5sM2syaWY0cFJMcVVadkp0UHBSQXdQNTZrTUpMYzN5ZHRXdHIz?=
 =?utf-8?B?SVEwclcxNXlRRm9PSW1wQlJ6VCsyZm1kQXNEUjBSZThERzFhRTlXbHpoYUlz?=
 =?utf-8?B?S21vYll6SmUzanlvMDc1emZHYW42K0J6Q2IvcDlIRWRCbmxxc3NzQlhTVmNR?=
 =?utf-8?B?UkU1anVadFNnVXJlS1pRbll1Y1UzOXZiSmhpT3NuUkFiUlJLKzIzVFR1QmY4?=
 =?utf-8?B?S0hGZXJDWU5NNDVMVTB0Y1F2eUg5RXhhdUlXMHhKNlRYSlk2eXk0Y0NaNXNq?=
 =?utf-8?B?N09qVFJVek1aZXBpMW8wWXB3dllxS0RPTDV5dXFibEpkMS9QNVJMN0M1WGJs?=
 =?utf-8?B?MjI2TDkrSlJQYlZKcUYxYmlhWXo5dE9DbEZDMW9OT0FCNVM4Qy9IclNoK0RM?=
 =?utf-8?B?WUNiRTBXYWxLQmVqKzdaNEYyb01qWVZZODY0WlpYdXlnaThHMWsxRHowVmk3?=
 =?utf-8?B?VnltaUl2WEhLc0piYTgwLzdIYnhIZDNlL0YwelgvekNoQmhaTGxqSHBUaWZM?=
 =?utf-8?B?S0tBeVA4akloQW5rSDl2Y1FWOTR2cnBIV0Y0aGtvSmEva1NGUTBjY3FjQ1hI?=
 =?utf-8?B?ajQ1a0dlWW1iUTRCS09pZUhrVWZFZWJpd0VTR09ldDREdGdjZDRsSURSOWZG?=
 =?utf-8?B?dXJJKzdrZUZ6UjgyZS9lNGZUNVo2MGJNYVlGSUxsckxQdGFsaVdIa2RJMWQz?=
 =?utf-8?B?aWw5WkRCbEZydWlhcWU0K1dUbzY0ZHgwUjQ4VDNrSkIrOUhvVnFVMGhhUjhL?=
 =?utf-8?B?Nlp1aXZMdDU4SGJva0JsNkhRWnc1WkszYTdOTkhSTG5FZ3hJYW5qdDI2R1px?=
 =?utf-8?B?SG96cENHbzZiQVFXWkZFWmxmTytRN1hwT3FadFVMRFJGSFk3cE1sSWpiSnhm?=
 =?utf-8?B?a1JPYzhnOVg4Y0Ezd3BFdHgwaThZeXBrVzdSQ2RGN0JBbk02UGRmczNSUlE1?=
 =?utf-8?B?ZGJ1dnh2Nm8zK2RTWGcyeHNCbVhWZUpBSWF0V01LM21DN1pHaC9mZ0JhbTFz?=
 =?utf-8?B?a0djR1lNSkhzTWlOOTB4eXRuaVU0My9xbXg5V2tzQzZxRWo4bGdXVXhZS0gv?=
 =?utf-8?B?ZURGd0szSjlqcU5FejVHWlJTZUZXMUpxTzljZzNObWpYRlRtMGxhZll3dVlH?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b63f7c5c-1f05-458d-3bf2-08dafa8f13b1
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 02:36:04.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV51eRPlefPbOVpnwMkRD8Q6RD0V+FQ69kBD3ogFPd9M28rBso2m5+HIESF1TXDqQsYSzJiYgrX6KhEL2Qlk8CdthAi4CV2UiEo21MAj4QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10813
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/20 6:39, Dennis Lambe Jr wrote:
> In case it's additional reviewers, I have CC'd some more
> potentially-interested parties this time and updated Atsushi Nemoto's
> email address to one that's hopefully more current.

My addresses are both still active (dispite the slow response).
Ether is fine.

> I think the original author listed in the header for this driver,
> Alexander Bigga, is inaccurate. It looks to me like his name got copied
> over by Atsushi Nemoto when he created m41t82.c by deriving it from a
> similar driver. At any rate, Alexander Bigga's listed email address
> bounces, I didn't find a newer one for him, and he doesn't show up in
> the kernel commit log after 2007. I don't think he can be considered the
> maintainer for this driver anymore if he ever was.

In 2006-2007, I wrote rtc-m41t80 driver based on Alexander Bigga's
rtc-m41txx driver with his cooperation and review, then upstreamed it.

About your patchset, I have no idea, since I have not touched this device
and driver for a long time (>10 years) ...

---
Atsushi Nemoto

