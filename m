Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E072C3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjFLMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjFLMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:10:52 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDC8F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1686571849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/2vlF+JdCCnYw5dq7SECyJZU0Yb4CbV/HKqZtf9vLc=;
        b=eoxBgU9RPW2t7aa+qb11Gw6+IJ7AYrVs2nnG3SFu8CRgkB+PYeqPpf9xd6CbvAt/k1tJHi
        K1vI00GiOO8XFVifozWcR5Pduzkou6wVp0/B+Dj2SzpkVgTTyJw4HmN1zE4QlnEp/p5pQS
        H90E3O7kmc3/tJdJat3UvZ7u6OZo0wk=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2055.outbound.protection.outlook.com [104.47.20.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mtapsc-5-92tsgDedMJ64mvwvDJejGw-1; Mon, 12 Jun 2023 13:10:25 +0100
X-MC-Unique: 92tsgDedMJ64mvwvDJejGw-1
Received: from CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:148::6)
 by LO0P123MB6735.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 12:10:22 +0000
Received: from CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM
 ([fe80::d98d:6e5e:2c40:7999]) by CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM
 ([fe80::d98d:6e5e:2c40:7999%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 12:10:22 +0000
Message-ID: <c76607ce-c75e-760e-9920-abf197bb0a88@camlingroup.com>
Date:   Mon, 12 Jun 2023 14:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 00/10] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        jesse.sung@canonical.com, isaac.true@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
CC:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20230607140525.833982-1-hugo@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230607140525.833982-1-hugo@hugovil.com>
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB5273:EE_|LO0P123MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ec9390-eacd-465c-b209-08db6b3dff5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: V6YAOihkFSB1keV3l3z8oWW2cHkySwlM/diKIueg4scL2Ksi0GQF0AY5PsSNnFtC1BrczlBvM99NkvP4tBLtFUHcB6lqDw5P4HDeLxY6UrI9dKC9FgwDEfuiJ77dxFD4xh/A03eijFy7ESI2of6+PqOmL6BGIJskgyjGI83X77EwgBHGd4PI0M7tAPePg3LVIVj2JP+8yMaxSyvpYY6y4alrQdgRi8dOtUYShk6n4mpQ4ySMCrPuyKBy0btSnLOXFRz0feA7RHUFsuhbv4XuAEvr0PCwJMB+95vCXNmn/Ta5Nf5PZ71GvcpW7aqwywvUwlpnjxHg4FRLQnPAFGlyeiTNjVtKi7PB82ZdoaB2gqnksanpszV8JekkiVRNeEMenGwGluwQgkypLE73fN1mnf92TZLVgBBalBRcOiCmsCH7/oCN77fVZG4t5pfD617LZN0sIk/bOegfuZTSeS4XRaeTpI/wf+tPw73T6RLwRF3LqQj2L6Fs6M/dSfk5RVCZcx6snAH9UeITkjgwhUeCv0LEtVE7sGJzZDmInpl3Q2qweJWI9054uVzLgpDN9rph+pMtRiBYnbxEHlM+NR3SXsWLqPqhahDc2DNIo7WGeeCMxxWe6Il+ZHknzyig3UvErKu5KtjksaWykG02bpqHd4YM3ReVODn+/TlrZsOambfWAfdizuEGKsRTpd2u4B0tKzjRn7QYAO3HDNR6n9El6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39850400004)(346002)(136003)(376002)(451199021)(31696002)(36756003)(86362001)(66946007)(478600001)(4326008)(6636002)(316002)(66476007)(66556008)(966005)(6486002)(7416002)(8936002)(41300700001)(5660300002)(2906002)(8676002)(44832011)(921005)(38100700002)(6512007)(26005)(6506007)(186003)(83380400001)(2616005)(31686004)(45980500001)(43740500002)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9G2nziCThw+2yeOlDwjGfpfr0Abull4T7lXnhzFoxwlJ5oG8ESLCab3RW1b?=
 =?us-ascii?Q?LtSrdO+GvOL4fmDm5xcxmIIalz6J7264w+DDjqQoqFK9Yn7syGPXfAvpeDRZ?=
 =?us-ascii?Q?0kSCpNR67RnAtgYi3CjqcYrVlOYoJ/G6/A0KjVSWLWj2n7yc/baFZnpIDnRl?=
 =?us-ascii?Q?FBTv+EnJwjr0rH4fev1tLpnI7xGr81yaT64Tdl2Slv7sRWaUfRgLzxSyZNxN?=
 =?us-ascii?Q?lcrI3eQJ4E7xb4HW5SzdHPAXxSCvr9sUlGXO1MmfapNCql0mlV7vx5SYIA12?=
 =?us-ascii?Q?nRus/lwdz1BXkZU1fw9lVJl19JnxCDwTpV+iXPcMRL2g2oxTP9KxC+gnUzdx?=
 =?us-ascii?Q?a1H1jSPY+gi1DEMSzM9MEy7dDC0ZYwIhmRbRLAI8FYL/2a5IoMRwuMJysA6b?=
 =?us-ascii?Q?pOLbsigIkqdx4CuIPCs87nQJp0qjR+EXQs5PUhXvyuuSxyufp6AHc30Jrc4R?=
 =?us-ascii?Q?TpbBo9UaR5llLSz+e3dCZzucncn6g4LtV6/m3zCrSELf+B+oUZghOHSgyxea?=
 =?us-ascii?Q?7rDiyregNQG2nli6j3KmbgrqrwhxjzoRFjYHfKZtfqGreZar56o5FQhe9cNT?=
 =?us-ascii?Q?mR/qHwjsPsZgXGIVjPIXysU14Vdaz+z7UFz+nmel4VVgX1a9WW1aA+Du4F6x?=
 =?us-ascii?Q?yJMDiMoUKqWkbbOccyaMPrMTAsk/53x3Fh3ZCH22Yh8KjjvdoZRK8V2JL3fs?=
 =?us-ascii?Q?Y2BzUhHFTUq1FZIjmE7plkd82XgIl7ofIFx/KunCBvAYzUZK2SDBADhEPV+4?=
 =?us-ascii?Q?tibgR2d7lX1lWHRAYhtwWP4N1ZZ3dV6KZNDOz5vZrPFtX5Uj2zOF48Je17iC?=
 =?us-ascii?Q?mIyRwTI68xpfzwHuW5FOVB4pyEuPvkDjUZu1rLV4KNSSfiJeqmUP3WM+Jdo6?=
 =?us-ascii?Q?dPATzMHCe0hahT97cvDWgGmv2wCyndaAQE+8XOeDJBpGC7eE4RJ3nLXxxNUa?=
 =?us-ascii?Q?ctLvjmXkMj5VN7f+wFy+sMCeVRKSEt1tk8goejAyHYZBPBQbIkM2PgYKK5Aj?=
 =?us-ascii?Q?GcNOKJ9tQ7VNjsue1HHFKpi+fhCBhs5zpzpgt1B58Ctav5fmpl9kYm61VPLO?=
 =?us-ascii?Q?jhG31GqXePziruZJFP8d19nMjVQYwuOYE+JPrEdXYe6pIcvNywbobAeF1jNw?=
 =?us-ascii?Q?oQfxaCq5IQY+ZsrLL0x+g62uL/Dpg4oQDJ5ag4o4c4b+/inRQkn5zkG8Q8vN?=
 =?us-ascii?Q?GsGVCFLd9zmVamkoD7wRq2XsVi4NSoAGT9hz6p0AQTbz6ksxdLE33kzhCpZP?=
 =?us-ascii?Q?eG84HIP+/m6aUbg2nRM9XIQMr9PVVtXIZyep5lI89pmcwNC+guczddXY/9vi?=
 =?us-ascii?Q?NzPkxAdqnLAqMbIxc6P0PHrCjezaDMUbU07Uqr3NOcCVz9X8eV1BrweK/yMG?=
 =?us-ascii?Q?4rBou/Q5s3eA/kz+B3XhMVRFINO+fzpVGhApJql3hu7qxhFDHFTRJWPlUhgJ?=
 =?us-ascii?Q?0nYCX2kTDu/yGE/TzMUrz8LIVbbCwaN+2Kl8NZSKsOb3dLxsUfgrhsdkY9F4?=
 =?us-ascii?Q?g0o/Wu3B5kMwZefm52zWQ+poTwpX69qs3TTb3YJKzkotAua3qu2wMYiuWI+D?=
 =?us-ascii?Q?MG/Qbq+9OYCbfVNjD+9gKX6j2zqWNqs7XMT1UPPwB1wVTUyJOihkPTDzXjsL?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ec9390-eacd-465c-b209-08db6b3dff5d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 12:10:22.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3ksdUmeCPXXXpYKJAqq3ts1qqhP9oXq7mjMKfrrPr6R8NlI29YsUiphEDRe7hknnA3ykvkOcCEuM6H4r7/xcK6vvHcxLAlOeqeyqoZDoVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6735
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 7.06.2023 o=C2=A016:05, Hugo Villeneuve pisze:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Hello,
> this patch series mainly fixes a GPIO regression and improve RS485 flags =
and
> properties detection from DT.
>
> It now also includes various small fixes and improvements that were previ=
ously
> sent as separate patches, but that made testing everything difficult.
>
> Patch 1 fixes an issue with init of first port during probing.
>
> Patch 2 fixes an issue when debugging IOcontrol register, but it is also
> necessary for patch "fix regression with GPIO configuration" to work.
>
> Patch 3 fixes an incorrect label in sc16is7xx_probe() cleanup code.
>
> Patch 4 is a refactor of GPIO registration code in preparation for patch =
5.
>
> Patches 5 and 6 fix a GPIO regression by (re)allowing to choose GPIO func=
tion
> for GPIO pins shared with modem status lines.
>
> Patch 7 fixes a bug with the output value when first setting the GPIO dir=
ection.
>
> Patch 8 allows to read common rs485 device-tree flags and properties.
>
> Patch 9 introduces a delay after a reset operation to respect datasheet
> timing recommandations.
>
> Patch 10 improves comments about chip variants.
>
> I have tested the changes on a custom board with two SC16IS752 DUART usin=
g a
> Variscite IMX8MN NANO SOM.
>
> Thank you.
>
> Link: [v1] https://lkml.org/lkml/2023/5/17/967 <https://lkml.org/lkml/202=
3/5/17/967>
> [v1] https://lkml.org/lkml/2023/5/17/777 <https://lkml.org/lkml/2023/5/17=
/777>
> [v1] https://lkml.org/lkml/2023/5/17/780 <https://lkml.org/lkml/2023/5/17=
/780>
> [v1] https://lkml.org/lkml/2023/5/17/785 <https://lkml.org/lkml/2023/5/17=
/785>
> [v1] https://lkml.org/lkml/2023/5/17/1311 <https://lkml.org/lkml/2023/5/1=
7/1311>
> [v2] https://lkml.org/lkml/2023/5/18/516 <https://lkml.org/lkml/2023/5/18=
/516>
> [v3] https://lkml.org/lkml/2023/5/25/7 <https://lkml.org/lkml/2023/5/25/7=
>
> [v4] https://lkml.org/lkml/2023/5/29/656 <https://lkml.org/lkml/2023/5/29=
/656>
> [v5] https://lkml.org/lkml/2023/6/1/1046 <https://lkml.org/lkml/2023/6/1/=
1046>
> [v6] https://lkml.org/lkml/2023/6/1/1328 <https://lkml.org/lkml/2023/6/1/=
1328>
> [v7] https://lkml.org/lkml/2023/6/2/861 <https://lkml.org/lkml/2023/6/2/8=
61>
>
> Changes for V3:
> - Integrated all patches into single serie to facilitate debugging and te=
sts.
> - Reduce number of exported GPIOs depending on new property
> nxp,modem-control-line-ports
> - Added additional example in DT bindings
>
> Changes for V4:
> - Increase reset post delay to relax scheduler.
> - Put comments patches at the end.
> - Remove Fixes tag for patch "mark IOCONTROL register as volatile".
> - Improve commit messages after reviews.
> - Fix coding style issues after reviews.
> - Change GPIO registration to always register the maximum number of GPIOs
> supported by the chip, but maks-out GPIOs declared as modem control lines=
.
> - Add patch to refactor GPIO registration.
> - Remove patch "serial: sc16is7xx: fix syntax error in comments".
> - Remove patch "add dump registers function"
>
> Changes for V5:
> - Change patch order to facilitate stable backport(s).
> - Change duplicate device addresses in DT binding examples.
> - Use GENMASK for bit masks.
> - Replace of_property_for_each_u32() with device_property_read_u32_array
> - Add "Cc: stable..." tags
>
> Changes for V6:
> - Fix compilation bug introduced by patch 3
>
> Changes for V7:
> - Minor changes and coding style fixes after review for
> patch 5 "fix regression with GPIO configuration".
>
> Changes for V8:
> - Move mctrl_mask to "struct sc16is7xx_port" to avoid compiler warning wh=
en
> CONFIG_GPIOLIB is undefined.
> - Add "struct device" member to "struct sc16is7xx_port", in order to avoi=
d
> passing a raw "struct device" to called functions from sc16is7xx_probe().
> - Add new patch "serial: sc16is7xx: remove obsolete out_thread label"
>
> Hugo Villeneuve (10):
> serial: sc16is7xx: fix broken port 0 uart init
> serial: sc16is7xx: mark IOCONTROL register as volatile
> serial: sc16is7xx: remove obsolete out_thread label
> serial: sc16is7xx: refactor GPIO controller registration
> dt-bindings: sc16is7xx: Add property to change GPIO function
> serial: sc16is7xx: fix regression with GPIO configuration
> serial: sc16is7xx: fix bug when first setting GPIO direction
> serial: sc16is7xx: add call to get rs485 DT flags and properties
> serial: sc16is7xx: add post reset delay
> serial: sc16is7xx: improve comments about variants
>
> .../bindings/serial/nxp,sc16is7xx.txt | 46 +++++
> drivers/tty/serial/sc16is7xx.c | 177 +++++++++++++-----
> 2 files changed, 181 insertions(+), 42 deletions(-)
>
>
> base-commit: a4d7d701121981e3c3fe69ade376fe9f26324161
> --=20
> 2.30.2
>
Hello Hugo,

I had a chance to retest and re-review everything, including setting state =
at direction change.
So if the pending changes to v9 are only the conversion of dt-bindings to Y=
AML and fixups to them, then:
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

