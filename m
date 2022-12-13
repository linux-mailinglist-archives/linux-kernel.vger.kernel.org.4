Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207264B4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiLMMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiLMMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:09:59 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19317415
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMJtsufrv9Elb5khPapZTS3jaL3qNnOXN1zcossegXghDAqq37/dtu2QB7mBM2K4xKjlE2g+LWCsDSf5mFexLVGmJixmTzmYvCw6Af6d71EOEeBCpSchTY2HBTjwKKtJBUpH5NA7SP4LcE6GCQkv7rT+Wt8MYOTHsabXPATqoIzlYklazFfB/KGtcmzbAZKDjnUGhAj3hSWQVvCeWYhOQVk+8Gq0nV1X+kD5+qpdQTIPGYgn0G9m0GGWYlIaXY8rXQIQhGIvgfn4jkxP/EgweL9fWFIcObXdw5LiMMCXaOz9n3Miq2RHtjrxzF82CEgGZAuX2IayR5CI34Oyk1u3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz8pX2IQuo2qcgHUvf8x6aPqngxMUSw8HnnbdPmWevs=;
 b=nrfgLU1Mxkm/ECVJkIdKozKhenXStp5H6b+DAf78kzu6SwWYbgoRkOr3eY7v45RzDaAONVk5DkFEswXpzE34bZ84HtLaDiORv1p9rQXcdmBRa2i2BCZ8uw1QfulrTMHRpqJo/KWYPnGqFD0Ix6cSM1Ps0brrlc1hYtbVBFx7VbqK0FeMRZ6FVN1txA2ejcJvfN62VSYvR14l0hAF5f4vMcV88lwBUhL0l/ZvCu1FhCDI1HAsaLOuXj1d/lMop39Pbh+tyj1Wrz7mSoHJTc4NWpGfc9wSj8BNntyZEkia1ygF4LyYcHmHXFNBgp/k9I+7Y6L731ODroW7Wy8PfcJaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz8pX2IQuo2qcgHUvf8x6aPqngxMUSw8HnnbdPmWevs=;
 b=PvGedrM7w0j7JAlpNxLNrmHCLQePOQ484mrsRsLx/Hmg+w0xpUx/xlJ1MvE8w48ThGSYF6LEdrvhMkGt611++3aJUEyfI1Bd5sbbVM7nw01C55VWQBlYeftyqgdBMjMlQSlNmXYtjZAjHYBpc+5ULSzKI8e5M874DBOC4SfwCku/M2I5xLQTGUhCKS64bdWJ3zBA7LBAp3OL/jUefdm4FeH9td7xxfw1fLauMGQ5m23hwqVrCMFMDn6ovJXz8yebL4tfnM+n8ujUEr5p0jDAuCxocdAIcdtoink9WL/IUTy1VX44MvtVKCdGGfn/QBMhONhcF/haYXxz+YVi+VAFbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5770.apcprd06.prod.outlook.com (2603:1096:301:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:09:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:09:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: do some cleanup for f2fs module init
Date:   Tue, 13 Dec 2022 20:09:46 +0800
Message-Id: <20221213120946.16875-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <635cee2a-3f11-b963-b800-b417be7007b5@kernel.org>
References: <635cee2a-3f11-b963-b800-b417be7007b5@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4267bed2-8e36-496d-f027-08dadd02f24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKWBbpH/ZhqyYNZqcdESmPmLPO6Z6ufVMCx6e7OTE5LhJpT77azxpFMz0Gp9HFlJCE7qbbppe3cZn/6BCuHZ4ZQH7oVcP/bRQBtvgB9kjuljE4d7GVuZxPOWFQYffIr0l/brYcpXik9ee74nt/EgaqW295k0at7idSCQ7ddN9gwEnvIs2subbgOXjK9QQyk4iC2U8Ol0lth5Amv2BajNQkajzWe4yOFU1FMN0Cwn7K1aWT3IbCKH0e6LxvBPD5q6/fx/i+Ooek/B//EfpxAvPCFrnXmNgjH6iF2RHC464cPmAruHU6mbKcMr14u5LTp7YuhkEPwBvY4TN181dh44p9wLg31npdS2bvKD9G5FtqHPz/360IaImxdRuabGWPUm7r+VNaNsqRIoey2njl6JcM+Epy6PACcI6MrDErP6zoKrZdSG5blP8CG4N2wzaW1fHtnLwmlbrKghrR5chlIWTRvFVbTQD6ktDA7+cXHU+rs8VOLXjrOl2Vy7PW7SzMUZxHO05pacNFBIm9urnTlIVh60wBHzATJe6z8f8eb8Jx7stddyLz4opuJCse123nG1mzwMKG/Z/MHdExfAjRJcgcpzDLWm9RgHNRVjAvyUNd60bF1nDZiuCC9BLCoMaWznIZgjPAAoCYQ5nmbfWSBQjEQG2j6HzkLDKT1R2KnrzWj/b1s/74L8VXPwtuujynUKyd/s6nbhWeHPjtoKCSaZjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(86362001)(52116002)(36756003)(6486002)(2906002)(478600001)(5660300002)(38100700002)(66556008)(8676002)(26005)(6506007)(6512007)(66476007)(6666004)(66946007)(4326008)(4744005)(316002)(8936002)(38350700002)(1076003)(186003)(41300700001)(2616005)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tM65QBr+MtlGrKI4wOMvDx3JdZ4UHBw4k0uMxOlezSDF7wqO+oFZQK8u+aDD?=
 =?us-ascii?Q?HD+hMH+uQfcClqAmIHJSvDdL6AXkvrXVk2kEqz26REy0CZpgh8UZg7iXImAO?=
 =?us-ascii?Q?WA4l9hUYo6kt3o1Occ3fgBM1DW53Be8hyQbgG0HQczTrh/VuhdC/HKizEga2?=
 =?us-ascii?Q?CoHNyZQWMqL5WRFX7VRYkfNWieZWfc5eDZuJds1NhQAobY7uGAGgkjcRBxdY?=
 =?us-ascii?Q?93gK4ua18XzXtHp7zc/ClGvZNYk10Tm87vP9qjNxhHfnTE0DqPf2i1ZMF5cs?=
 =?us-ascii?Q?QgpsFBGyTRgIlMtfTpOiXUUX6PWDa7xaUJw16b8HtkwXsojBMSqpasjBJb0y?=
 =?us-ascii?Q?Ryg98U+Abr7hpVzJY2v4U9baU821y7AkiImWaeJTis2srsIhqCzfIOS+BZZH?=
 =?us-ascii?Q?vnCD8AD+EQRm0M3n6KF2RI4iETWiEAleF89J79NVw7YGyAapn8qmqTrRoDmI?=
 =?us-ascii?Q?rsVjClTL3lYp0lBdyQ3lsEqvyJM16wZySuuYV2Od3yNx/V+/HayV0wObJFTb?=
 =?us-ascii?Q?WoKhYPa53/o/SYSOJTF4Ak5Qd32UIuinNJKF3NLpjrQXEpAtOuZeH6n4kQJj?=
 =?us-ascii?Q?RofnSEVesAKWfer9QJV/FiCdGglaKWmLalM1KPJE9WHw5Spe8xrLRXDLeXgR?=
 =?us-ascii?Q?iijNoOMkxhyogCC3hI98S22+XPiQ1BIhZX6C5wRW3qxbGcQ67lUukNJGwzQK?=
 =?us-ascii?Q?Hoz3b47hLnW8Ze1X8JGxpB7ZUzgNWc8UvXBZ5kUt+clXpsw2E2860f4ZmO++?=
 =?us-ascii?Q?qCXBf35Ef21xVnxnK1Q11DvKnRs8wSvMXJw87N0Uk1pf5O7JHCUrwUeT/dK2?=
 =?us-ascii?Q?LNCYBa6J1I3yZVVEUFgyFYH/x8D7yEpUz5W9K4wB/uFAnoqqXaLkPjB0P6g1?=
 =?us-ascii?Q?DN4KwP2Fr8B/gXrzjT3Wa3zflPj9uFxB1xYzY/vbnLOI+kVZpGvWgSm0vgJM?=
 =?us-ascii?Q?GiAFIVjHlpSw3ULUkDzaTLaaZnL3oLFoLSNBeSJ6njgGH+y/m06V6FuWAmUu?=
 =?us-ascii?Q?u5HvBuqbzFxMZZ9SfekDvN62naWjWa6rs4eU51UfuykcHyQnrkXTzOzvsl7V?=
 =?us-ascii?Q?oCyPWY8m0/QJFTDA7SR4oNp0hzG/0SkM2ghHOUhE1UpScUe+BqcSkvudSe5z?=
 =?us-ascii?Q?V1/Oygx42sQhrdDqMRr6Tu1YoHROd929Nx8qRpQI+lt0odUmEt6Q5sPJ0NDD?=
 =?us-ascii?Q?fdV8Rfii1k/gPUXRndNSMm/emOE0GET5HKPwthYMrY7jMC9pjrBYACj8q7dk?=
 =?us-ascii?Q?EeJVFZfnEwqVkzu2tVhCmvTN7SPoIYryJH/6O1kTjlbAdkjjAQ09ZiSkD2B3?=
 =?us-ascii?Q?SKmi++4+xGfm7a9bB71eMJ3raPYw6CTvG4ecwqnXsYuqCp+cM0WJA5MmKw5d?=
 =?us-ascii?Q?S3izHdgMtyeYAqCdPqIDMtARaAEL36mXKF4XxhrM0DF4qhgRXfb0g5lRzhym?=
 =?us-ascii?Q?bt6ccDgzWKB5KpAfMEIPD/ybTHhuYj94JLaJ4dM5BRocAj7sXSLzk4BFsl2r?=
 =?us-ascii?Q?JS+XvtsiH78hIoMUQ9kf2WRJWKR6F87p4ptMGK93+9o46aTc1yfOB922TSbe?=
 =?us-ascii?Q?8JrJ5SSreCa7ceQXkK6m0N2c8aiaBRNgVeOPvKMp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4267bed2-8e36-496d-f027-08dadd02f24b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:09:55.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+Dhp4rX05+T2IRLaE4QCadQh5SJj8PNR0PlexqvH4Kgty8nq+3v9w1T0QsftgXeAOqhoJUjM7fGUHyZ4mzY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> I don't think this needs cleanup, other part looks good to me.
>>>>
>>>> What is the point here comparing to the below? fyi; I picked this change.
>>>
>>> IIUC, the question is for Yangtao? :P
>> 
>> Heh, to you. :) I think either looks fine. Hence,
> 
> Ah... alright.

> I comment on this cleanup, due to I don't see any benefit, since both implementations are very common in kernel codes.

Mainly the cleanup of f2fs_init_compress_cache() and f2fs_init_bioset functions().
For other parts, I don't think it is necessary to take up too many lines, just deal with them by the way. :D

Thx,
Yangtao
