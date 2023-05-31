Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09972717D51
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjEaKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjEaKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:44:17 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B8BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1685529853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IANSlOeX5EqpeU4fazQlfihRkUQSjuYrJgehibsz+BQ=;
        b=GyAFdQbvbzFXmIHubBDkWr1FGLxHfEelQUidHG+kVxiYa6y5Hy+HTM3Q78rSyM4GKdo7vJ
        AU2jRKSdXYf3GFkOMEmoRv3+mci6zv2IM/TeYCZQwJv+VkNXh2dmI2pjBhCNQ/29/hlEqV
        b6djpN+PLU+sLEdKM7pIccyRQzLfpyQ=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-116-QqzLu0SYML66xDxaPwHMJA-1; Wed, 31 May 2023 11:43:55 +0100
X-MC-Unique: QqzLu0SYML66xDxaPwHMJA-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO2P123MB7306.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 10:43:50 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 10:43:50 +0000
Message-ID: <c691858d-31af-2892-c0a3-89a37b19af86@camlingroup.com>
Date:   Wed, 31 May 2023 12:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <c15a90d6-b3c1-e432-9216-c4c1e2c44ce6@camlingroup.com>
 <20230530090836.27b8d080d6b6c022b303ac9e@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230530090836.27b8d080d6b6c022b303ac9e@hugovil.com>
X-ClientProxiedBy: LO4P265CA0084.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::17) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO2P123MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: c0736ab2-c05e-4b0e-3eed-08db61c3eb70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 2OMM1wYEkl4v96bQoJjqYjcxLrOm1ROptfDtvN7suCTztPdIXqoJYRhY/jFFgb11/1rEv2KR6m1H9UFWdPjBbM/VZIQi9wk7N7lJ7cvDmWC11lLwuyh4AeOyxx0ryGPCvW2+owamess7nJcsHP30kL3qKvpom4zuYtIEqCw1FRv5et5cQSmvFwaTeVWHaF+Dh+q6fSXIBn1xWgyr3I1hh1w+Lh5b+FgZAli3H/SXSHdNAurPeCoNIVBF6y7PrO6gETq0uKIZGwLDIY5iZRwJTteSuEZCory8oz7B0TVvLwrsaUjv1l5BBdRUDZvI4w37RKWeS5gNdTmRvKNz/n8jYnRZ4G8qBZXVnoW53cEyR3qLO6cq2aH0/Btgld6H5KuiLkVFkKcR/yqIoynWh4rBHuMT1sc5KTPj8azyvLLAIfhc8fPXFK1HLjIO9GEZEZuGhsYzIUb3G+OXt47v29OTH9SLS2IM5lBCBlqZfleMTnJR2UtgRgTWcbPjgTLkhV35MDsDWj9uIJpXi60bHu87d8cUY61JpbTQwu1V1vyRb7M+aihc4PF2Q7TG8uZOmXKgA61zez9Ea5CmUyK3v8ZixXroon3bf31X+uYN8pKEH5KLKPPJEoAquJNEz3H/d0R6uKQxUE4vD5DabKAwGmjIP4tFS1TdkHVufyYeKh3Ik3tO8xANgGGOhjupfZWa1qjPBSrO5kYu8189Mb9fEeCzDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39850400004)(451199021)(966005)(6486002)(41300700001)(31696002)(83380400001)(86362001)(2616005)(6512007)(186003)(26005)(6506007)(2906002)(44832011)(38100700002)(8936002)(316002)(8676002)(36756003)(7416002)(5660300002)(66946007)(4326008)(6916009)(66556008)(66476007)(478600001)(31686004)(43740500002)(45980500001)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z3nW+6wNfoj6wLkUQMayrsFs+UZlOzj7zjURyoD9mD45JaJwsS/yI/wYUijm?=
 =?us-ascii?Q?6fS4JWSM7ixQAJaNvFd3pYcC6ezw7irbwz0VP56klOIGwgzAeaav1TaPd3DP?=
 =?us-ascii?Q?uCta7pLM3IIhbzuhie3aMhOVj7KCL8/Qu0IeVypryxxCO6luX2NJeqR0xE+q?=
 =?us-ascii?Q?fgqUhCMIO4js6rWu1eT/udA/4PIjbljbfGjU2LEe220x467K2Iseha/qa5qd?=
 =?us-ascii?Q?04AsumNWggUaEtZAzGjdCfv3vPvMv4j5l/LcMYBDrEQNn7PmvHi2Jgd0t2Ev?=
 =?us-ascii?Q?zOSlQVldedI8EmYJ1W5yqEOBadM0VHP8foPot7CNbgnreH1sA9gyl+4j82+k?=
 =?us-ascii?Q?nhadmqQpAu8+cS5JaInamR6QMn9RZHEjeGEmdkxkWu5eeaPowkrb8dvrQ0Tw?=
 =?us-ascii?Q?GTMK+IJQrQGOfXvMSES0LlE3u6N6O4wmfq7rgxLCRQ9KBznXacCWaQ8ZnAuw?=
 =?us-ascii?Q?98a/n6WM7V5GRROFqTeoW7EUWakCi8Q+ZD8Q26G7GHzu814hja6oWDuOTRlQ?=
 =?us-ascii?Q?z/cwzVVyAw1oBLHD3SEy8jnlYxoVa/l13nuRJDFCDSEmRdM1qG8GiR4/Qred?=
 =?us-ascii?Q?Ru7NMJAPuIOYwCPHIZocgOR7nbCGStMf3XmD1+LWrfAYdTsbQWFqYi/k/e38?=
 =?us-ascii?Q?cz/eofx35S10TMdEZJVws+PoUDmwXx05zAfB9iCzKcgK77JMWZ7xVPgSQlDp?=
 =?us-ascii?Q?sOISiQ0wnYfMOW1xEqWv0GzZ4aCb2zaQg8eU2sB5d7EPcjq5nDC0lDZC9q8F?=
 =?us-ascii?Q?TbBR7LkIag6R6i2LSdhTexi6jlu7k1HPYselupWksmGFvG//6616ykVt7cCr?=
 =?us-ascii?Q?LrA+GjYUtY6FMpSeNXBqqru8TSolnPvHsJE3TYtha1quKJD4ITJbjSbwfdVz?=
 =?us-ascii?Q?Dt+HRh++uvdQqdqKEfAJgjb+g+gw+/Q8KJ2Qer+BfsxowhmJnQtSRD3Q45T2?=
 =?us-ascii?Q?ao62ek3M2ftDQXSsWyC4CWynuZdeZjSRI2U4LonSGm596V+chmQOqNcVQjGD?=
 =?us-ascii?Q?IDtWzX3Zjr+nJ2r0zFBwKu8tyVyafcGXn0kHrGtGYci+k4BjduHaj4alZNZD?=
 =?us-ascii?Q?HYFb6Ykvsm20MNi//HNAkcu4TU7Rts3Fi/vXW8twSUcMON9mDw/sLo8jsGlq?=
 =?us-ascii?Q?51zctSgjzmmv6+W+yNHla/N0ZijhgztwF3W4Q9jBF1PiCIlFhGTTIR4ROrOZ?=
 =?us-ascii?Q?h1+fCO5ynbkilQsjsGp5vLEBqyhV6wHOSZ53ICwOp1Eg/rh6jsLaAGHZz9tM?=
 =?us-ascii?Q?iCgyWF8iyF7DUwEB068RVUbiA8ScOsHUziPViuSHgfHG65cZUv82fAcTy312?=
 =?us-ascii?Q?hXhTH2PuhGV+7tIAkfLXPhwx4PXC9pQEg2v5Se/agMl1G/0laXs2uk6SKD4W?=
 =?us-ascii?Q?eA6RDTGEFiWofPbhCmtfGSzzlLjc5PEH21GPwJFT8LpFLQ2/eq8s2Lqd4q7l?=
 =?us-ascii?Q?UZhOGwAuh0QjhITDIKusfOYlQvMzE809Iz4BA0ChbBnYun/XRUyAP5bm8nFq?=
 =?us-ascii?Q?pdp2S23fkIeu2RV/JWwwvlZGbMbXhNSb9zq/5SzCS/DDGGBb9GHWFeKobNnT?=
 =?us-ascii?Q?rdISN5U2sp1lmgPFqEmkZuGP/EjOsnD97rqLV/hv48IIFBbEYaKVhMGPks/q?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0736ab2-c05e-4b0e-3eed-08db61c3eb70
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 10:43:50.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fAEVscsRrPHlOjHwUnGFOLSDHD1q7r34PEPRKuFWRgMqjgUllyUwBY0Dhma1jh9qcZUy8mgeqjAZlKN4mGS1shuRlR4H1k4uVmCXNopL/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7306
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 30.05.2023 o=C2=A015:08, Hugo Villeneuve pisze:
> On Tue, 30 May 2023 11:30:07 +0200
> Lech Perczak <lech.perczak@camlingroup.com> wrote:
>
> > W dniu 29.05.2023 o=C2=A016:07, Hugo Villeneuve pisze:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Hello,
> > > this patch series mainly fixes a GPIO regression and improve RS485 fl=
ags and
> > > properties detection from DT.
> > >
> > > It now also includes various small fixes and improvements that were p=
reviously
> > > sent as separate patches, but that made testing everything difficult.
> > >
> > > Patch 1 fixes an issue when debugging IOcontrol register. After testi=
ng the GPIO
> > > regression patches (patches 6 and 7, tests done by Lech Perczak), it =
appers that
> > > this patch is also necessary for having the correct IOcontrol registe=
r values.
> > >
> > > Patch 2 introduces a delay after a reset operation to respect datashe=
et
> > > timing recommandations.
> > >
> > > Patch 3 fixes an issue with init of first port during probing.
> > >
> > > Patch 4 fixes a bug with the output value when first setting the GPIO=
 direction.
> > >
> > > Patch 5 is a refactor of GPIO registration code.
> > >
> > > Patches 6 and 7 fix a GPIO regression by (re)allowing to choose GPIO =
function
> > > for GPIO pins shared with modem status lines.
> > >
> > > Patch 8 allows to read common rs485 device-tree flags and properties.
> > >
> > > Patch 9 improves comments about chip variants.
> > >
> > > I have tested the changes on a custom board with two SC16IS752 DUART =
using a
> > > Variscite IMX8MN NANO SOM.
> > >
> > > Thank you.
> > >
> > > Link: [v1] https://lkml.org/lkml/2023/5/17/967 <https://lkml.org/lkml=
/2023/5/17/967> <https://lkml.org/lkml/2023/5/17/967 <https://lkml.org/lkml=
/2023/5/17/967>>
> > > [v1] https://lkml.org/lkml/2023/5/17/777 <https://lkml.org/lkml/2023/=
5/17/777> <https://lkml.org/lkml/2023/5/17/777 <https://lkml.org/lkml/2023/=
5/17/777>>
> > > [v1] https://lkml.org/lkml/2023/5/17/780 <https://lkml.org/lkml/2023/=
5/17/780> <https://lkml.org/lkml/2023/5/17/780 <https://lkml.org/lkml/2023/=
5/17/780>>
> > > [v1] https://lkml.org/lkml/2023/5/17/785 <https://lkml.org/lkml/2023/=
5/17/785> <https://lkml.org/lkml/2023/5/17/785 <https://lkml.org/lkml/2023/=
5/17/785>>
> > > [v1] https://lkml.org/lkml/2023/5/17/1311 <https://lkml.org/lkml/2023=
/5/17/1311> <https://lkml.org/lkml/2023/5/17/1311 <https://lkml.org/lkml/20=
23/5/17/1311>>
> > > [v2] https://lkml.org/lkml/2023/5/18/516 <https://lkml.org/lkml/2023/=
5/18/516> <https://lkml.org/lkml/2023/5/18/516 <https://lkml.org/lkml/2023/=
5/18/516>>
> > > [v3] https://lkml.org/lkml/2023/5/25/7 <https://lkml.org/lkml/2023/5/=
25/7> <https://lkml.org/lkml/2023/5/25/7 <https://lkml.org/lkml/2023/5/25/7=
>>
> > >
> > > Changes for V3:
> > > - Integrated all patches into single serie to facilitate debugging an=
d tests.
> > > - Reduce number of exported GPIOs depending on new property
> > > nxp,modem-control-line-ports
> > > - Added additional example in DT bindings
> > >
> > > Changes for V4:
> > > - Increase reset post delay to relax scheduler.
> > > - Put comments patches at the end.
> > > - Remove Fixes tag for patch "mark IOCONTROL register as volatile".
> > > - Improve commit messages after reviews.
> > > - Fix coding style issues after reviews.
> > > - Change GPIO registration to always register the maximum number of G=
PIOs
> > > supported by the chip, but maks-out GPIOs declared as modem control l=
ines.
> > > - Add patch to refactor GPIO registration.
> > > - Remove patch "serial: sc16is7xx: fix syntax error in comments".
> > > - Remove patch "add dump registers function"
> > >
> > > Hugo Villeneuve (9):
> > > serial: sc16is7xx: mark IOCONTROL register as volatile
> > > serial: sc16is7xx: add post reset delay
> > > serial: sc16is7xx: fix broken port 0 uart init
> > > serial: sc16is7xx: fix bug when first setting GPIO direction
> > > serial: sc16is7xx: refactor GPIO controller registration
> > > dt-bindings: sc16is7xx: Add property to change GPIO function
> > > serial: sc16is7xx: fix regression with GPIO configuration
> > > serial: sc16is7xx: add call to get rs485 DT flags and properties
> > > serial: sc16is7xx: improve comments about variants
> > >
> > > .../bindings/serial/nxp,sc16is7xx.txt | 46 ++++++
> > > drivers/tty/serial/sc16is7xx.c | 150 +++++++++++++-----
> > > 2 files changed, 156 insertions(+), 40 deletions(-)
> > >
> > >
> > > base-commit: 8b817fded42d8fe3a0eb47b1149d907851a3c942
> >
> > It would be a lot of sending, to do that for every patch separately, so=
 for whole series:
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> >
> > And where applicable - for code patches:
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> >
> > I tested whole series at the same time.
> > I did my tests on an i.MX6 board with SC16IS760 over SPI, which differs=
 a tiny bit from SC16IS752,
> > and everything works as it should.
> > Thank you for fixing this!
>
> Hi Lech,
> thank for your feedback.
>
> You mentioned before that without the patch "mark IOCONTROL register as v=
olatile", things were not working properly for you. Could you retest by rem=
oving this patch and see if things are still working?
>
> Thank you, Hugo.

Hello Hugo,

Just checked - this patch is required, reverting it causes things to fail, =
so this patch should be marked as a pre-requisite for the actual fix and in=
cluded in backports.
Perhaps using direct write to this register made it work, but it was likely=
 by accident.

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

