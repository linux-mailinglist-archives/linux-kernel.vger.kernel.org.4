Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D739715A39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjE3Jbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjE3JbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:31:13 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790051A7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1685439045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYq5z9W0NccyKEsJKexRxxFs3gJikqqLjDv0pN+hT28=;
        b=Dbp2kkiZBrh6DmbBUjKHXcnQFAqmmR3SrtMLwXD2/nIIaX6pcwiq4Qz6lg4tGO4if7VNJO
        GrwKZTnZIs+VYCP9W09xedMxpJ7IzqiUAvI8sepmaNXxj1+SSksKlw1Np8/Cbt2y8YaYeH
        swPs24IH2fvS3W5z2xOk61uRtZ+cqNI=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2056.outbound.protection.outlook.com [104.47.20.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-19-7QfL-y1KN1WFW7i1tE2nNA-1; Tue, 30 May 2023 10:30:35 +0100
X-MC-Unique: 7QfL-y1KN1WFW7i1tE2nNA-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO2P123MB7163.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:328::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:30:33 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:30:33 +0000
Message-ID: <c15a90d6-b3c1-e432-9216-c4c1e2c44ce6@camlingroup.com>
Date:   Tue, 30 May 2023 11:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
CC:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20230529140711.896830-1-hugo@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230529140711.896830-1-hugo@hugovil.com>
X-ClientProxiedBy: LO4P123CA0485.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::22) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO2P123MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b1d8c8-2a40-428d-7c8f-08db60f0848d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: fxEnYUYPLBAaHl8t82BSZtcAtJAmM2OoG9mykPb/hm79t8xCFuilPgRWB44afemnRg6K9XZh8R4cVsX8tECoZB/fs2lSo4lHl7qw2bzLTJLtQ+UBxppEGKNPUnFY1l8pZhhKO6r0JfBFYW+70ubTOgyka/4OK8kEX4isUFEw4ybFqE2+UTCcJKmjP90lQLUeNFeY01n1PPXr96IdgpCdOQaYhhWXe3LucAe6wELncV679gJY7e7o4ujA+IoYpN1E6vGQv0VtoHzAQ991SynqTZ1xUymp7qxpzLh/ktAwLJWCjA3e+BovJtT82Zh5DgHr0bRBH3Gc6vq1PLc0KdF5iTjXcECmrfqVkpoPi82/rgqJQC7VKUiFpCNx1DwKZu2iZ7oPr6JG4jCmqlTq916OMhJ6epku8NxPC3enHJ+ojNk2rHtGqSDl1gKwPXy6eQvdbTqw9P4bHJQnP30YPvcxt0/xr6qzbsAmgoDcvTVejvq8+Inrl8Gn4NsS1wZ3kuH7X5sdjZ6hExbDyACVryL4t4O5QLg1asz9MpG6WlzoEINNfhBx6eplXysFT2anlJP0bv9Hh/ytcD/Ub/1yYahIF6YR6sNcAd8TYUqtYv9gHKPRX5JKUxqvIyHC0AYCykOXm9CsMlvjThK71hQHBEoKUQbxBERJrtA6UgFyWt1m2ZvPmlGkOrEbPySu2c5w4/N9NHp3RlGoK0Y1YABaSOpMVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(136003)(366004)(346002)(396003)(451199021)(966005)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(6512007)(6506007)(26005)(6666004)(6486002)(478600001)(66476007)(6636002)(4326008)(66946007)(66556008)(316002)(5660300002)(8676002)(8936002)(44832011)(7416002)(2906002)(86362001)(31696002)(36756003)(43740500002)(45980500001)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qz/bfQia/tou7gc7oA7750IK9GZzXy1OItFycnZ2a95yDihz1dtbVAjAe9yw?=
 =?us-ascii?Q?2/wY0oL3p3isJZj/x1vw8BoLkZARKtB9d8HNUrpWUkbZwrXDUVE/x4GRhGiO?=
 =?us-ascii?Q?odORgnDSVqPW7QaPnd8rthngPdaGAd7zaseHmZLYI+x2cPovKoDd/LWkcgmS?=
 =?us-ascii?Q?GcSLNQH/g3Knl1zB5tGCp5XoGURrj333t4km310rnVhil6+4TILEGuu0+Spm?=
 =?us-ascii?Q?t4CBDjui5eSmwH5pWdy4MA4yfnJBro1qjBiUgez56Qpp8gqiA2u6Wp/BnVRy?=
 =?us-ascii?Q?Ilb5gk4L+Ne3lH53Tkfm4vU+yKiABaSIN3qK+iXfPxr5epGgh2MiO3rpNJiA?=
 =?us-ascii?Q?RW01yJMY6SmyBGYOim/ak0TDF/JzHt7cHMRHouFg2J/cuOQrMFR4bdVuJsJa?=
 =?us-ascii?Q?vlZNfDUJWZrpSIDhTLYGILap8LBdDKMkeb66AY+KHEAb+LdUlYxcTU5F88aW?=
 =?us-ascii?Q?Uhr3UxSiWsMxW03l+EYDS1NPBzuWPg/BnJ2xEVSc5NxBBVOlAOUo7Ihnb/tn?=
 =?us-ascii?Q?TMykh9Y5h97lRYxFMQcKrO8iNS6ASrowfWsXXk6YvOPz/g9n0zZdvicoQKK1?=
 =?us-ascii?Q?PGmBUPY8I7bUbmZU1AnJ1GhzjHyVID8+zpLEzNfnNdltuTMI0uM66yiDMcEE?=
 =?us-ascii?Q?bGdDLjbItawiQo+W5GvgRCNA4/HKd5X4jjWSckq1HSk9al+lBJkHSzP5cimG?=
 =?us-ascii?Q?kFn2zaM0ZGxDj7KFUsHH9DR1DsgAByT7CS4f7QDqAzdUpfdjWVB234u8Z6mM?=
 =?us-ascii?Q?duAFiXbOT5CzGGnYRMMDGCc9jcwYDstsHq24rZd7n/kWW0z/dj0c1zD4gifr?=
 =?us-ascii?Q?jjW+piEgd+cA8pwg6YKtVW1OdOzvjrFBj0vMSJveroLwHJSxGdyHS1GGRa2s?=
 =?us-ascii?Q?55LB8acV7OA6dXb1U0Mp8E9i/VHcCZJnhM1pOnK3P0RmFeBz4+uwnr7KXhKQ?=
 =?us-ascii?Q?GX446yAmQtFOV4fc43xlX6zcRHdlknJqmHrzCLkUVl6uCEy6VB5v3K62J0d0?=
 =?us-ascii?Q?mMHbh6iYS72K3m/8c4WV/Ues86BkqrYpLump46RrGnz8zXkgDwzUk7PtvU3y?=
 =?us-ascii?Q?8Gj5FDD8AT82YsDgsPGhY53Q6KewgDhWjORFEJGU8xc6QFkIpGgw7zL/rWDI?=
 =?us-ascii?Q?+KMQkJCbUPONk/l0LkAwIQZkjtpB4XaNckzTQdwyY9z2sMceUhGlmHg08klX?=
 =?us-ascii?Q?OBw+pdpIxL2yedXxRu48Rt6ndBTrhtzzL+QUeOAbOgW1a1tln1fRggC1MXt6?=
 =?us-ascii?Q?w8qK+ZQ5H95g+uNzTGpWI2apDgncu17beGfxZXhK7hvQp4pvpNzSdxWYMAz4?=
 =?us-ascii?Q?tYuT970mH6TXcadN0s4rGjeGoU51jwgARrY1vbYxQULw/Ryzcw3/yBEnkX4t?=
 =?us-ascii?Q?37NFCtAOW0fa4qU8chsqXd59YbTWeJHTOyb+TIpRIhx1tb6iQadswU4r7kOd?=
 =?us-ascii?Q?nBuxezpfMgkQewrWJyIcVK7HACW8bu+pi4yE1xZmDkvp1iAE+e0DH5fla0VX?=
 =?us-ascii?Q?0n6TmOWBVaumi4ujKF5n3BfnxQgERIGCzA8qothx/bK5zElhtlW35/nDVjfq?=
 =?us-ascii?Q?qUYQ+pGv/eZQ5hSgHfFIswtnWd+O0xwiMylbIJoYkwwOohKW7jGlhsw1uZx5?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b1d8c8-2a40-428d-7c8f-08db60f0848d
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:30:33.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oynNsH4gvo4OIVcCMObpK69mZytSvdEv8/3aWcXcI7pMjtF4pyZ/lE7+9U4z+yHxhlrlc1VjM+KL0RoIZ/ZzQW+zv/3gTWjQa+645IRHdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7163
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

W dniu 29.05.2023 o=C2=A016:07, Hugo Villeneuve pisze:
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
> Patch 1 fixes an issue when debugging IOcontrol register. After testing t=
he GPIO
> regression patches (patches 6 and 7, tests done by Lech Perczak), it appe=
rs that
> this patch is also necessary for having the correct IOcontrol register va=
lues.
>
> Patch 2 introduces a delay after a reset operation to respect datasheet
> timing recommandations.
>
> Patch 3 fixes an issue with init of first port during probing.
>
> Patch 4 fixes a bug with the output value when first setting the GPIO dir=
ection.
>
> Patch 5 is a refactor of GPIO registration code.
>
> Patches 6 and 7 fix a GPIO regression by (re)allowing to choose GPIO func=
tion
> for GPIO pins shared with modem status lines.
>
> Patch 8 allows to read common rs485 device-tree flags and properties.
>
> Patch 9 improves comments about chip variants.
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
> Hugo Villeneuve (9):
> serial: sc16is7xx: mark IOCONTROL register as volatile
> serial: sc16is7xx: add post reset delay
> serial: sc16is7xx: fix broken port 0 uart init
> serial: sc16is7xx: fix bug when first setting GPIO direction
> serial: sc16is7xx: refactor GPIO controller registration
> dt-bindings: sc16is7xx: Add property to change GPIO function
> serial: sc16is7xx: fix regression with GPIO configuration
> serial: sc16is7xx: add call to get rs485 DT flags and properties
> serial: sc16is7xx: improve comments about variants
>
> .../bindings/serial/nxp,sc16is7xx.txt | 46 ++++++
> drivers/tty/serial/sc16is7xx.c | 150 +++++++++++++-----
> 2 files changed, 156 insertions(+), 40 deletions(-)
>
>
> base-commit: 8b817fded42d8fe3a0eb47b1149d907851a3c942

It would be a lot of sending, to do that for every patch separately, so for=
 whole series:
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>

And where applicable - for code patches:
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>

I tested whole series at the same time.
I did my tests on an i.MX6 board with SC16IS760 over SPI, which differs a t=
iny bit from SC16IS752,
and everything works as it should.
Thank you for fixing this!

> --=20
> 2.30.2
>
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

