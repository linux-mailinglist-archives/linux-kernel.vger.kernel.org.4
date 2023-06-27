Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A48F73F0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjF0Ca5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0Caz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:30:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A081B2;
        Mon, 26 Jun 2023 19:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLEdZMfSRsVSOJTY3CJfltQIlnOosVDKzjFsDliLlK71XXx8ZChoesh6VlagA3nLPhVTszB1z5MTHzA0sqS4XsrJsymYzenwASjx2G0YLAJWg/2ukSF3lnoIhXxyd2ibmPPAl0IFoG2fz9FP2x/dVTGqQRDHYzK+a9EvYcP3/LFF4Y16lJu3Xg1lZuoYqhzLvpzUkPvV61S6yQT8Kjmeuxld8TrWtKSWAB0OslYyRCOyzG+lRloCEt7q9IcnHFsPuldhB7/4O5KKqhIb7AF6bL/rmYZdpwxHQUcI8siVhXGrSLC4arBOgfD+wIbDFrk9Ov28SpCRcA1akjHaoae0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKardl8PDgqtc5L6WxHchHaxWj/jMdqeT8sKlMYJbLI=;
 b=dhAA8/3/Q8dgpxkbxlC0M6YdqXoLwZbEwHsXAUfzX/osdyOgbRkbBOqWP7ljgpPm1FLbCu74TuqQeSu1gRl5YPbQ48snaEjCpi4gH6qUOdaK3o7Ma3Xbj0ShnnMI7FndhCI1slRb4HTZOa7cIoIA6QdFqcp9ZIzuoEF7iHgmGNCNW6qoIwmZBebTKUePIisLSP8Kdc2Sm2KEiul7986k6aOllD7cOODy0JG8v9tU+3mRGskv2PDXq0gqn9neF+pBn0Ptd7CDUVjStA8GsQneWnv/i1u/rWpuuBckPgYH+dkBImhEopNXK4LCl8SG5L9Ya/tkOVwbilUq/OwOUY9DKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKardl8PDgqtc5L6WxHchHaxWj/jMdqeT8sKlMYJbLI=;
 b=NylJwR2COGenwpOgEk9bqWCN75kj33vYOEMiGWJ/sg4+GYtNFseJ7xaLy6YvkROh5hu3FDRSfaK5/XKZ/L11PJeAg0jCoo+llXcPx3pS10bf6mSEHpzcKNVCQON65gYclvP9V2An45ZvXciqKnpAKfAErswE8kyKTiSMZjeQiwhChh6ImXC4ZX+RLpE/l7Gtij5VodS/IHViFGWGu7T70EROcV87b7N1F/eTWofTzrMCXKjgIsEIIOXXMZgq9bauaq8KIcbyrPUItBdiEvDbimhS89/flv6nZBRi04zFxJLhwzd2p7Y+fPrIm9Hzrgzu6ewoxT2e25x2I3NDsmD5lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB7974.apcprd03.prod.outlook.com (2603:1096:990:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 02:30:13 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 02:30:13 +0000
Message-ID: <57c200d1-b01d-003f-d530-81ec378ce283@amlogic.com>
Date:   Tue, 27 Jun 2023 10:30:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add T7 based AN400
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626095223.721011-2-xianwei.zhao@amlogic.com>
 <cd9d82cc-d98c-f4d8-8dd5-01ce4130aa78@linaro.org>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <cd9d82cc-d98c-f4d8-8dd5-01ce4130aa78@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4b917c-8270-4325-d083-08db76b66f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbdCyt63QYxpmbHefGerYbLEWPKENBTJgKZq07PVKLOQ63z4iU3T03cAKzXeKtUCg/OrXZpBYLzvqEfh49D2+4+OsUwPpkBqo1SibS8tQK36/mbqqmz2gxl9DHn7I+kQ1fUv0yEHA30LQ26IEcBoxVwEE1qc0dKkWiMhtDxWTa4ySutAjEjeAljAmkuFc1yZ6MLMNHz8Gpy/BleZlyvN/YXIESQ9TYx39UZsbRDAgoNziAJywYYve+a+tLlbHGVGCd3e5NXPEa0TZS3fvkmJHq3Vs2g2TY+S39L0BtU1ER2reyPIzHmgbajuPskruiH6ZBfwXLt5gKx1rIhhV0N+cAmaoLySaFosrbTs9URayZEBHThJQTQCJvicXzaR6jECA+BCkmBgBLwmeOCX0lREyK2xhCkD1K3tPwIlm1dBAhpr/HPSraw8WXGGQd1IBaaOHg806aHbXTXl7kFGy+PCNiFY1oyJEFuGSs07zdBD77bKN98LVGD3kZhJlcyxhnVmr9xQyR2ibb7pa7owHsWHjc985+vH9aOwcNhnuUdg4d+9VtN/Dpo2X7EL+aYGhr9eN+l/fudmCGCBYRNFiOG7F+Tw9a3ycZb92+3CrybDVVgDQrz54ovIQUyR988Hgsu0rIMk6v8f13792jUjEuSNmRdDBWKSPXjFh1Q0pa6yRUNz3swJrfygwcaWJERzT9D0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(396003)(136003)(366004)(346002)(451199021)(41300700001)(26005)(4744005)(186003)(2906002)(38100700002)(6512007)(53546011)(6506007)(8936002)(66476007)(5660300002)(44832011)(66556008)(66946007)(8676002)(36756003)(6666004)(7416002)(54906003)(6486002)(4326008)(2616005)(31696002)(86362001)(478600001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJkZTU5a3dPTysreVFoVVFRNGNvZFZNck94K3QvRlJaOTZEaUI4b0FNTFRm?=
 =?utf-8?B?NjU5M1lteEk1Y2k0eGwwYXZJSTdVdjlvVlZWQ1BlRlJncFVJMVY1bUdscW1i?=
 =?utf-8?B?YkdpSDZMemdXNnBZdGJMM3NYdXM0RWxFNyt2Y1JVMDV4ZXRIRWs3ZmFRVHor?=
 =?utf-8?B?a0svMnlZTnRlbjd5dTFCcEtVaHBBMVMxUHViazRVOVFFQnhlUEIySkUzY3Jp?=
 =?utf-8?B?RWRUV2FYR1d5dzhMZVRLU0RiNnM3c1Q1ODN0bTVXbCtQazZWakhQV2J0bnB4?=
 =?utf-8?B?aGd6VlFBT1FwblhxcnBLZ1pSQ2FnRmRZOFVzS0w4RjluYlp0eEY5RVlHZGlh?=
 =?utf-8?B?czh4MHRVUG1TQUVXdHJac0haaTFySDhmVmNzclkzWGFHbldGRlRnZnhqNWo3?=
 =?utf-8?B?SW1POGJoQXFPRjNXUkdiRjhlekJ3Y1RlaU1DY214RDB4VHA5RmZGVUl3U1Az?=
 =?utf-8?B?a0RYdHY4MkNqWU4xSE0yaHdnYUJ5ZW0zNUNxS05OVTROb1IvbGROakc3dEJi?=
 =?utf-8?B?Y2NvUTFHd0x4dW4xYkdweVowQkJVRUhQRVo0SURPMnJYTUgwOStlWVJJY1dl?=
 =?utf-8?B?Q1hCNXRYcGNER2QrTWdvc2FuY29TQjcxWXQwN3RSbjV6UGVNSXU2TjN4TlNB?=
 =?utf-8?B?a0NkeTRRRk5GOWk3c3Q2VmRHdGVuZzdTOXRXdmxMaElpK2tEdTF6RW0vKzZV?=
 =?utf-8?B?S3N5Q1VUK0QzNloyWFoyejVOMWdDRjhia29EdVZweTYwSnEwMHhnK2pRQnhM?=
 =?utf-8?B?RGZKOWpYcHBzY01zUU5SYVdoayt4U1c3bEwvM01oZU1RcUt6RFJ5WXdMVDN5?=
 =?utf-8?B?d2tSY3R4V25LYzlNWjlybENLMGJqWGJTc1FKK3NMTzIxaFZteG9xVGpaNGkr?=
 =?utf-8?B?THQ0YkM1UE1qSUxsTVdVc3NZS29UdHJXNlpHMi8wWHY4eVczcWp4THNaOXpa?=
 =?utf-8?B?dEZ3eGgvcVExcisrS3B3VmdZSkZzSExLcjFGYjNaaWhScjlHelQ4a3N3aHp4?=
 =?utf-8?B?UW1GNjV4MEllODhJODZrVmxNQ0VjQVdQQ3dzem5BSW1pWXdFWmMyUEI1OCtr?=
 =?utf-8?B?bEpXVmEyYzVQODVuWjk5UFhSd245ekZzdGgzL3JZeGhuZ1lJZTdITEE2S3cr?=
 =?utf-8?B?elk3MXBWb0FEaWs4L24yRXdIdHU2Vm1lRXRwN2t6ZFl6Lzd3TGw2THF3dEsv?=
 =?utf-8?B?dThrYkdkOU9xOTZHaHFISVh4SUN3WVhlSmY4bHJDdk1QVU9PeFlUbDkraWl2?=
 =?utf-8?B?VTRXODJRTUlLWHhaZG5CSmVvWXdsUWg0WXJoRDhZMDc0NFlQdENJT0t6cWJ6?=
 =?utf-8?B?UitvdCtyQ3VSTEhQOUtVdGhPVkJjeWM3SUJsSXZqdGR5R1pjRkc4VnVRb01O?=
 =?utf-8?B?NU9POVZvYldQa2FFQlRSQVlXREFNTzRXc0J5Qm5Fc0w4S2lRbnhIMEtmZG9w?=
 =?utf-8?B?bGZBY09oVmpjVExpMFUzOHNJRWRkVzhWK0sxa05US1QwcnY4ZDArNEc0eU15?=
 =?utf-8?B?VWNobDg3bmZMWlpGOGhyajViZzlTQi9QRmFhVy9GdTYzV05EVW5xZEZWSVdT?=
 =?utf-8?B?MnJmalFuYVBWRVJlMUxVUTljYmE4OE4zMlJFbHMyTk5LS1M1bysxczZoaTl6?=
 =?utf-8?B?WDBBeGg5VFFTUkZ3QldXeWdlbVBibjdIeFRGa3JVN2dIMWtONXIwRitQV0oz?=
 =?utf-8?B?R293SDF0NzBHeU02cXNBTXpNYmJhcDRlN1BUNFRwdUNocGpWWTVmY2JKV0No?=
 =?utf-8?B?NytXZzRsSUdPVUpiNzl0RzVWaXNaT29ZV2ViU1FEakRVeDlwUkdYNmZBQmhB?=
 =?utf-8?B?K1RwUUc3S015U3VBODdYcWZOc3RVN3ZsZTZGNVlweThFd1NISERvcEJoSVRL?=
 =?utf-8?B?QXM5cUlqdTRxUVdUaFl4cnFzRVhXalRCbWRnNklHbUJnL2hVOE9rcmFQRG1y?=
 =?utf-8?B?NVNZZHZUc09zdm9TWGxQaXUwc1l5RGZFS1BYN2k1WWpvWjdMOE9SaXljeUMx?=
 =?utf-8?B?aWdrRmFVN0ljYW11YmdTZmYrZHdOSk1XcG44TmxUSHJudWFSNE91MUhzcDY3?=
 =?utf-8?B?OXRmSXpYakZYajIvQzVSWDBkck5oUC9nOWdiNTB6Mk1kSVpYNXhnRzhwQk5t?=
 =?utf-8?B?YTEraFk2QlV0Tm5pRmQ4NXRycFh1NUE5K1R2TUR4c2JnQnRKNVVlR215bE02?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4b917c-8270-4325-d083-08db76b66f6e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 02:30:13.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdiNSeIX+s/rkZNwslejx0fGZ6hy9XU6pdlA07uf8OImE1cr0hHqN6YF+52eRx+XA91zH6lkCneAd3AebuekiAQHVymE8eLPqukA1dUIouw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7974
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
       Thank you for your reply.

On 2023/6/26 23:38, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 26/06/2023 11:52, Xianwei Zhao wrote:
>> Document the new T7 SoC/board device tree bindings.
>>
>> T7 is an advanced application processor designed for smart display.
>> It integrates a powerful CPU/GPU subsystem, a secured 8K video
>> CODEC engine with all major peripherals.
>>
>> The main system CPU is based on Big.LITTLE architecture,
>> with quad core Cortex-A73 cluster and quad core Cortex-A53 cluster.
>>
>
> If there is going to be new version, subject: drop second/last,
> redundant "bindings". The "dt-bindings" prefix is already stating that
> these are bindings.
Will drop "bindings" in next version, thanks.
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>
