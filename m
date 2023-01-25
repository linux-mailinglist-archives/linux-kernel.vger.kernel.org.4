Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F315867B8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjAYRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjAYRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:37:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93018B1D;
        Wed, 25 Jan 2023 09:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyzFuZ6hLdfz2nq/s5oo7VDaaWzI6LTi+7qTrmC2xjso1LUtZiJCrCtVWbXSKXVwcBbdNH/c/DU7rHHAsEoBb57zJYtb3x2GIABiEZC7Z/6RQbsERT+FsoMAtj8GADhCbNzmtOZyygSEjWXXo5IlqjlPUQvxyxuT6qvQxA82bTPhoJo+mXrLI+2KmI4FQIpGONpyRpkRVlT6MycqkN2neSYuJ688zVV8sbkVRENcJVHrmpdHhhTg8YvTvLZinsfIsbHgpVnL1hPLrOXivZ0WVG84ScWQ9J2DmJXCwlQbklOiulRlRWy2+f4JYRhBH4x4xBwyWcNEei7ZYjpzMxcvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R83atsfG1RG5zwquj/DKbTidVC7ysinCqHfcypjCR8U=;
 b=Dvap5fExp1sIfDbgPL2WGbl5bCNUv2n8Ga0RF4ENoCXBfQxXosxlEyDdE9q2QTpfwUqE0ItVB8WgwaIWe05pn8uytBWn1CDs8PjlOfmWPmIEf1vR1yKRG/hQpjHodJm+EMzZOjh9ufBG1TvQ3DRqrtbPhpaYWHpLiwqpwP9BZW2diprxukCeW3p/eha6iPv9TCHwvtMbGYR43fYzZ3qdKpEU4qcO+NCPHjdKVSas3BKuMYDQvfljmg2vDOKrtCASlgc3z/Nb8zUltYdOHc0zFeQCJdFadAr02OADlLCCYmHN/gAYX5aZEW5XshcNEaFfKi4ppYPMY/DWAw7koI/nAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R83atsfG1RG5zwquj/DKbTidVC7ysinCqHfcypjCR8U=;
 b=sbZPEJ3qZQsxqLSor322IslPv7dmHrEml0D/ngkSqwIqXVZEELP2eWTqV982e/fe9rarQM3w5V2aRedu8ZgxuU4dNzAYQgUp7Aj2FUujGqET3HA6YshkyeSf24IGEBhISbCC2qZW9up97z59rlNvhX5lksH93p352EeJJU5V9H02NcH7AEzoBBsqY1DFj/DbGZ1G2Y6ovcKhBpNkSizk+og+xgl6wKr2lO3BFx+rt+ndTfKEuLMIwcG2g6ubuSuFMKXVU+CZQW0H0bxQlH0/XEyD8PJhU06RgZJhuxgsqejKHwoj5usMO1wOE3OzhniGCuT11fy/k7tUrUPyHqZEjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB7505.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 17:37:14 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%4]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 17:37:14 +0000
Date:   Wed, 25 Jan 2023 18:36:59 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230125183659.7dd9e0f5@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75Vf5MAsiYKdmF2oQ2rNDjKUVW9nk5FjPhUcD3b-4r_u6yg@mail.gmail.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
        <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
        <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
        <20230124143514.1abf933f@md1za8fc.ad001.siemens.net>
        <CAHp75Vf5MAsiYKdmF2oQ2rNDjKUVW9nk5FjPhUcD3b-4r_u6yg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:610:cc::23) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: b08adede-8ec7-4065-1acd-08dafefacbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfpVdL+r34hymKADi/rcPSTaPyglRaPDFzbd1pNI9HCKivDaauVpUnuVb1P1nDD58KVBMukOxI5wkVKf2RdP0TXp8b3FnghJ1NLMx3mLBrwk/4XQgBQSRZlPCvXvHYpEBO/F1Jc3fKN3qOnxdHBMfsmpOYnVRPN8QQfqzCzH7enRtUg91C2EhPta8Y3uAPz9gmPWwKVCUwuwnqOTJAzWWKjm6tJ62eD9ZkUrK/A07hdtqTCwWGuYFPTXq33/L1UbgYE/jCnh2MuyX8AYvaovHhCuH2qi9DKD9MF/uUhE8Y7honPkQSavNqKt0W/BQWyDhbFQPXb7p1/QEAbOMirEPJkMNkUOBBDpF2LM17A2iO+r+frND372ph/9zTeJ+IEr21HweJKudmyelKQlbW2HsG+FdpHk+Jiv1oKzHW4gt3/i5HcU5BZaFfP0G/GJRJjbkiI6Feqsb2z6Dh2/aBaNSxsOwS98sWA/JO5t4ZD4ZCKqmuhZNZRkoroFdeb5zRe1miEGGeM9YtcNFzzOiltK3lmfxz1VrXyrvlCwe354JSRGhKs5R0pjAm6RscwbhRyDPx5tltlzW667s5giiWWgYXMc33pfR1fvof8fi/MKN9m7fE+RGyCsrPrAShy6fTtdzVj95BehUTEk4brILUllaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(2906002)(478600001)(53546011)(54906003)(6506007)(6486002)(186003)(66946007)(82960400001)(38100700002)(86362001)(66476007)(8676002)(6666004)(6916009)(66556008)(4326008)(316002)(9686003)(8936002)(1076003)(5660300002)(6512007)(41300700001)(83380400001)(44832011)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGgVHBQKhtwzzYEnh6XcMmVL6yyVkr3W+YTjOxUodp28zao4y8CPVnha9oy3?=
 =?us-ascii?Q?IBLpC5NkhyHuTuTh4T9vmhrXuoCBOhmZEWjl3wqVmAPpSVPvY/NJ5ftbDHfi?=
 =?us-ascii?Q?7W5xGR3N/OxNbVKv4m1/9Y4a3Hr+Cm9Kvy9HXiJuJCuuMnXgRarlwXGNdFK/?=
 =?us-ascii?Q?eanjsGQosugSNZ1yjntmOmQFTdArrAFVJiHkUSYfyvuB6poA/Ve6cktNl4iE?=
 =?us-ascii?Q?HX5FNbZR4Pl8JWSkYrZ3reunboX8tsEbwRtfTgixEidPHQH3PsLujaHMnxLZ?=
 =?us-ascii?Q?b0IAfyAF3GE1wfvN8f84OeNF7eaF+mj8gtf+cgCiNw3wREAQ9+5yMRKhtoRE?=
 =?us-ascii?Q?X+FfM5iW3eo39B70Er/7OzQ2zW6YQces0FnnMIg5BC/8Gd1kngKXD7MzzuKB?=
 =?us-ascii?Q?qsUUxkV7bmMLS5me81nnPLfzpissO0hd9KSnl7dd0g4F/HbtV4I753kKtRHn?=
 =?us-ascii?Q?nwYywcG4TNtGiyv+obzs/2kNwEN++6GUS4OzG0Las06CmCg1Y2gaSVFoNDQh?=
 =?us-ascii?Q?h2iu+AlJ9cCusB+w580ajSDwzJ6U7RDoe+UY64xAttWWx0RD4S79q+sIQxMi?=
 =?us-ascii?Q?0nrV7xH3XEDtBkRpzyXvCwvHsGsS1LszrGgOOZMpVGmb+tZV+GwVxwF4INSm?=
 =?us-ascii?Q?ev6cChjsLS/Wg2LAagqwUgh+3Ypnz2HkB8W4ugiXV3F8RwrC4kO7MVIcwVyy?=
 =?us-ascii?Q?/G/PYPdwJ2ltv0/nDIGYM8rv0hu6DZdlZRjePiwsWjppgKKFUVlC9BKjuOOk?=
 =?us-ascii?Q?1Jq+/7fjdK/J8XYRralm+a3ZtJsFbBQLsoG5lJ1YX+BQHzQSc1LzCSZf+gH/?=
 =?us-ascii?Q?B2dKftUcJjqNOGqQ9umqtGujkOGK8aeKhtsh83Ah1NmlG4lfbF1JxnCG/WJK?=
 =?us-ascii?Q?LH1ap3XZo7/HlpsrLv0ta7JCwaQPN+AAk87kbb6Q8Ay+tixsr2Q/n1NRAc82?=
 =?us-ascii?Q?vWh8CMnMl8YXOvF4P7lgbtEi5DjXAqg3gtUHDTY56MS4mSx6NOMXjnutCca7?=
 =?us-ascii?Q?rUKO4spqeh5oQPNzlt3yh6CmdMDP8F09E9fo+ct3Y/FaPNIBZADYTUEqPDSW?=
 =?us-ascii?Q?9qvh/4Fcgd6T5Sk7OyUdwj78/u6sStkqbjij5s+CuYtNJFVh+QdjZ8GI5sER?=
 =?us-ascii?Q?lM+eLz30oWbipoWVQkfwhEuQjWD+ygvfQd1zJhO11n0C+lijgA58cX2a7g5V?=
 =?us-ascii?Q?5BiLeXZ7gj6mh8G9Xcf7jcDOx0V5H72BgfX4jZN2pSrU/PWIC56F0p4Q5UPD?=
 =?us-ascii?Q?QsCI60CIrRD4pz/X6XAc0yL0qB133BmXgMNrWNAWnlaS3BwD3Y+SN8kXe75k?=
 =?us-ascii?Q?zxOCKC6I+Wd32OjXz1A2KwEerKRsW481GQrAmS01gKFUpWT91za8DyDOGb/W?=
 =?us-ascii?Q?9INz0bEX8LqZGiokrcj5jWi5XrGnFryBD90Vr8zBbnt8MS9qBfTZR/3YRUCq?=
 =?us-ascii?Q?2txWSvUmJpOWkl4SeQMl8xEfUUV+PDm8350qAS9wCoZPxTuwaCkrMROm/AwV?=
 =?us-ascii?Q?DcvId96wsIUiIzlvdo2XwyT124goFw6A5Liva+EUyFrFmLxmb9K5/LJt6sY/?=
 =?us-ascii?Q?z0U4Ph2VhGC2OGiYOYY5DbDa2coPLae/g1i0kygt8XPceFnks3+Ya/QrkwjQ?=
 =?us-ascii?Q?/5HHDIRjB6fZzFz2wCAO9+F4zSordBygeyvsOEdCYJCHXXv+N42naXuTn6ze?=
 =?us-ascii?Q?UNbv2Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08adede-8ec7-4065-1acd-08dafefacbdb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:37:14.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg0YFNvpe2hoSkvxbVSFczfX8Zm6Z4oBSHFjEny4K+oglkrao+EMWadi8M1eLupgWeiDqyu9PDrulgO5dmM9XyZt4hIzFH1xhNQ4/FY62J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7505
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 24 Jan 2023 15:46:01 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Tue, Jan 24, 2023 at 3:35 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> > Am Tue, 24 Jan 2023 11:46:34 +0200
> > schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:  
> 
> ...
> 
> > I would like to keep the number of files and CONFIG switches low,
> > with a focus on the config switches. Every new CONFIG=y/m has to be
> > requested in countless distros. So far i only dealt with debian
> > where ubuntu might follow, did not check others with recent enough
> > kernels ... like fedora if they have the SIMATIC stuff turned on or
> > need to be asked to do so.  
> 
> If you put the proper defaults, you can get good results without
> torturing distro configurations.

Meaning i could try sending a patch to set "default m" for all three
SIEMENS_SIMATIC_IPC
SIEMENS_SIMATIC_IPC_WDT
LEDS_SIEMENS_SIMATIC_IPC

I was so far too shy for that. I would even go further and add
GPIO_F7188X
W83627HF_WDT

Henning

> See how 8250 has been splitting over the time, we have +~5 new Kconfig
> options and their defaults are to keep the current behaviour without
> the user needing to do anything in their configurations.
> 

