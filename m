Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3076BCFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCPMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCPMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:55:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BC1024B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAZFzjBnTzFd/gm7BeO/IShPVsV6/sEtLGN1KmwWjfiS4sOLwPEkhgyzc4xUnsLALW/uPvt+SdM+blC9598pCzkm30U/He3yvERqv6QcCt9hN+4b88WKYWy3HZY6TnOfU7bXhcdM2vPkgp6y3/6N59u6PRXBegpUnM2s5v9wi1X45Sxdre1+7fgVjYASYas9YpTEr5cUTnb5DD4vUmlybvSfWk3Pfi7bGeFERmvIRK5qjYAtUpwUxzvnVEnXT9OJAxYUicUmP8XxMLfmOJp8LFyUR6Jai9/k77INUxyybBaJ8oyapd/ctxxRHpKkclidfso2TvC9tUDSMI76KuvUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwYtCzq4K6lIp6ni/xQzo4wyMmWeXaviZyl1+02RKF4=;
 b=A6u2U+smFzg8NpCfdWaEHc7HOer6DzRKjnK27vmV1J8zTex6y7+rariYA4nE8Fx5C6QQk1id2UYLY+4jnHvxMvvx7V0fmjWIqF+D2DVjRkk9fxKzN1fB2hn41HLIyUBjdxyI/X+9vCWZaRcs+3ZsXOwIXvf+ZWwMBsust06kTLqeL3xYZuPt5jUlaO3dcmxv5ydJnRbPRsNXfYKgobT0//vso8bZZd7L456uHJbXRY966vnSYZ4bfPuuGl/tF/E2Lkn0jPqrLjEszZrKUdf8L/02aJ2M9onhhle3PKZ/LcAvJt0RLMsqVYw7ik/8lg9Ddc111yNcoewuCo73RMbBZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwYtCzq4K6lIp6ni/xQzo4wyMmWeXaviZyl1+02RKF4=;
 b=OUUGeBovJ8aiHoE2Dcj1qY4Lcu0KvotMSk1O6yfcoKzzJ9sPDC23/+xF2+OG4rjSj6lW0+FSq/R0+s973LUVmMTl/wqYVUYPvv/hJv5mv8ZsB5GhAAzKZkREF3mGB2XbpEmjNxV2mNtEJUXNuSrY0a1HzUDg9Scmu3HO1mfA6sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OS3P286MB1995.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.31; Thu, 16 Mar 2023 12:55:03 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fdad:8d7e:adad:dc90]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fdad:8d7e:adad:dc90%8]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 12:55:03 +0000
Date:   Thu, 16 Mar 2023 20:54:55 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Kito Cheng <kito.cheng@gmail.com>,
        Nelson Chu <nelson.chu@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu.c: remove nonexistent ext from cpuinfo
Message-ID: <ZBMRnwL5hvjhm04U@Sun>
References: <YoSw8lNHJqRDy6lg@Sun>
 <mhng-7b349805-02ff-47b3-b9b5-31dcbd2bb256@palmer-ri-x1c9>
 <YqYuiVwarHnbggtf@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqYuiVwarHnbggtf@Sun>
X-Operating-System: Linux Sun 5.15.67 
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|OS3P286MB1995:EE_
X-MS-Office365-Filtering-Correlation-Id: 714116d2-8f8b-4752-3f1d-08db261da8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMLq7ynTo76MHMBI6uuz5o7i5xxLyH8lrqoJL/uUCmPEzgrG3CQ6aAg5grFWXtD5Cra3o1wV4u/sf1QsNHYfgeji86YtSJkrqJHQb7p2eawrk0+jBgjo7H4LJr+Eae3TVQxr8zmcZOgRmmKVTP7EsyfxFW3JY1aImQ9Hzl1lgkoccEYRYK6na5cEvwd7RvUcE/SutTyo9GieCFMt5X2s45oXovcPNgazo07WDg7NOrTy7QBibWYktNkwcv0131z/3S1wpij0wUllK2tRWRuhy9JBlSwODMGfjcZPBR8UqTFUrsIVJdU2NgYksznjVuQUdqTP4Xt7sep93FO5WakJbtJ/EVZe7fo5JxTQK2KBq0byhSwCGG0pR5UqXn8p+/sFG8an3dIvkV0qVbLR4yNtSc4h/GOaZhTajhO9ll1070TV5Ul49oEUaCFw7HQBnoiV6Nw1rEm96cXPM2OnI76WAE51c7fzhaakA3wedRaOY89sph8TEEIjIYYzDBer5vMIzb0yFu2jEVgR6hTKCDA0Xt0n52iFT7ecZvM3brSfjRwRegFKND4Y6WdPpPpZdgS8UJNeeuFbEsZOcMRA0blwieBSr1+irETE6E1JeJAvEQYtX7TqEhbufWd7En64wPu08PvHqwm1uzhpavnZxWEBkI9TOmozDbpZvGJeOGlUUIpu3ez6wGsywenbB+GOTo7k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(366004)(346002)(396003)(39830400003)(136003)(451199018)(86362001)(38100700002)(2906002)(41300700001)(8936002)(5660300002)(33716001)(41320700001)(66556008)(6506007)(9686003)(6512007)(186003)(4326008)(786003)(316002)(6666004)(54906003)(83380400001)(8676002)(66946007)(966005)(6486002)(478600001)(66476007)(6916009)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oW1Os1bzjZYFiNh+S+WRyxgY5vsY9t0IaKiyZFjDrhC+5wsaPDtxpbbSnhAq?=
 =?us-ascii?Q?qNKXHkM/UNHlVNlB1oU9qh3gzvUvDjBwnJCTk/db4/cbAvCxi1NjGd4BgwvT?=
 =?us-ascii?Q?q+USP3Z6tJG1KRX2SaGQQ58dCn3rRNq1+SruUYMv5C2MsoM64m9rU6mhB1yl?=
 =?us-ascii?Q?7azjiNpMw+7tGIlWIqdQ2kUz8cF+RRIv9FcgngQMfCtI36ZwNJJ0ob5UoJQs?=
 =?us-ascii?Q?xaMLcX9FZg9gJ+Yw2Mmn6VgRJ8QNJ6d1PEZYpNhY0WjnkcfV5cJo22r2J/Us?=
 =?us-ascii?Q?rsT0FzzJNyirkm1IY0rJUU8UMBpCZLUXFIbOjUZ+QGmpOYqxIdM0/6rzH+bU?=
 =?us-ascii?Q?KOSOb5M/42RymgccSQBrAhIax+i8Ze/+8SbnpCxnSZMCfxxQ4zZSmUbG5FRm?=
 =?us-ascii?Q?p5moT/QXYhm93ezvMsArifnJRIkZ/tnKMtj58kLnnypVG8uoKC34Fmvr1ggb?=
 =?us-ascii?Q?nc6Y3VhyAxOpjE8pIP29OGNm1RLJi/ZuXx2JBMZSwZpXYu5a/OJWldmJHgox?=
 =?us-ascii?Q?4m3aKpTXb6RYP6sPdV0AT6+c0+2mJJP/Y4amP02CrHbjU0sNd3bqmyC4sqtG?=
 =?us-ascii?Q?yEMSLLDdDn6WiiDJYCljiuCXLxUza4dTenAEa0hfLC+DjqsPeTvOrZpWbDN9?=
 =?us-ascii?Q?beUjQ88qCQ+3O5PyEZRsrJvlLoOitKNhVOsMm1EijO/Eoz2cQg017dOMy6OF?=
 =?us-ascii?Q?LNlYRTG4w/6MnPNSIHYc8gIT857P0Vqg+jJKp127D4vN4Av6jeiUoWamiQA8?=
 =?us-ascii?Q?4UW6wj3maMeS4e4ynHDNbazf+oOIRNHDUIyvIuYfGRzMetuDjXEbxANJP27q?=
 =?us-ascii?Q?51hglqskdjId2JgoQwfdEXdGUGVyroMF2TDR4XNoyCGKALcUsLxwMi+5+TkE?=
 =?us-ascii?Q?VlaPLpW3OqLD6kGkxw6SBmYl9bcqLlG+vq/cVVzjPHfe7GLXCk9CZote4KwJ?=
 =?us-ascii?Q?atYtbSPMADXXHl3fZ+bb/N5NqKyx8Kw3otOd8p8Gwc9QB9vHnw+Ft1XF1lJv?=
 =?us-ascii?Q?8qDtuvhOF/KyT/lhXRhlKHcqBAbbGCECoQxNphyjSHGdQJxFmAJd8/Rkepuq?=
 =?us-ascii?Q?No1ku7LTgQK/wCI5r6cXPbJWTd7uwzCErmKLgivhiyA5u+omvgkmEj4uKrFI?=
 =?us-ascii?Q?xJ9PHiI6DN2u0d06xUHnbV5CbnFc3dAL8r/u78nIbjauMdw8m0Ds83JDwOf3?=
 =?us-ascii?Q?10ypItlBnwhF+K/YGpolpUANxiqYWpOAyPFSmWgzT+zSkzLrgtQhNlWyn2Kd?=
 =?us-ascii?Q?FXUToxMGLIAFWGdqV2lMfILue5gyT9WJw8fRliWBVGBOE+kXAIz+O17gI6Hm?=
 =?us-ascii?Q?wRvdx1ubQSaQyydZe4CMxlXSOyTY2wWxoz87dDiIk60D2+bT5EdlwL/b3wsp?=
 =?us-ascii?Q?G80qfT1paZGctNdYEiTIMvkqsdMRFDUP11Nnagn5NPhFFwfaxS5eNjvTJsEf?=
 =?us-ascii?Q?v5UUWpz1ecnWYcllFy0iowZbNVWoxbgDkUyMWZwL+ZITVH8UBs2h0wVkRUIu?=
 =?us-ascii?Q?AzLVYMIszFowMvZTjAi0jpkjz7kgPx5aCHfHqWtDCTi2F64ZiaJgfHCBGP4d?=
 =?us-ascii?Q?/eV0CBPtpWC1XlqEedRIDhqM41NS2o2/eJpMVYhP?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 714116d2-8f8b-4752-3f1d-08db261da8b5
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 12:55:03.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d/0ZaFPiN9NKuY56M9gqMKIgsemG/psZYpUfLb86PzJbbsGpdlCZu0q7O+mNVOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:20:57AM +0800, Hongren Zheng wrote:
> On Wed, Jun 01, 2022 at 08:52:42PM -0700, Palmer Dabbelt wrote:
> > On Wed, 18 May 2022 01:40:18 PDT (-0700), i@zenithal.me wrote:
> > > On Tue, Apr 26, 2022 at 06:08:01AM +0800, Hongren (Zenithal) Zheng wrote:
> > > > There are no single-letter B/K/J extentions,
> > > > as they are never ratified. For P, it is still in
> > > > progress and not ratified.
> > > > 
> > > > The ordering constraint of these placerholders is now removed
> > > > from the spec. By commit ("Delete more nonexistent
> > > > extensions from the naming constraints") of riscv/riscv-isa-manual
> > > 
> > > Hi, is there any further update on this patch?
> > 
> > IIRC there was some debate as to whether that change constituted an
> > incompatible change to the spec, but I guess it's stuck around for long
> > enough that maybe we should count on it being canon now?  I added Kito and
> > Nelson, there's a GNU toolchain call tomorrow morning so hopefully we can
> > remember to talk about it...
> 
> Hi, I'm curious about the output of the meeting, any update on this?
> 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> > > > ---
> > > >  arch/riscv/kernel/cpu.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > > index ccb617791e56..53a061ab0743 100644
> > > > --- a/arch/riscv/kernel/cpu.c
> > > > +++ b/arch/riscv/kernel/cpu.c
> > > > @@ -113,10 +113,8 @@ static void print_isa_ext(struct seq_file *f)
> > > >  /*
> > > >   * These are the only valid base (single letter) ISA extensions as per the spec.
> > > >   * It also specifies the canonical order in which it appears in the spec.
> > > > - * Some of the extension may just be a place holder for now (B, K, P, J).
> > > > - * This should be updated once corresponding extensions are ratified.
> > > >   */
> > > > -static const char base_riscv_exts[13] = "imafdqcbkjpvh";
> > > > +static const char base_riscv_exts[9] = "imafdqcvh";
> > > 
> > > The base_riscv_exts "imafdqcvh" is exactly the spec now, as
> > > https://github.com/riscv/riscv-isa-manual/commit/db7a4a0dad0e99d1ec1fc67b582624fc0aeae98e
> > > (Add single-letter "H" extension to the table)
> > > has shown
> > 
> > Oddly enough I stumbled upon that one this morning, it's another one of
> > these like the HPM stuff: we used to say "there's no letter describing the
> > hypervisor behavior, so it's part of the base" (see the commentary on the
> > binutils patch), but now that there's a letter I'm assuming we should split
> > that out?
> 
> I'm afraid I could not help here because I'm not familiar with this area.
> 
> > 
> > Not clear if the RISC-V folks want H to be ignored by software like those
> > other recent changes, and if so it's also not clear that's a good idea.
> > 
> > Anyway, sorry this is taking a while but I think it's going to be too late
> > for this merge window -- kind of silly for such a small patch, but it's got
> > interface implications and it's all a bit of a hot topic right now.

This PATCH still applies. Might there be some update? Can we safely
pick this PATCH?

> > 
> > > 
> > > > 
> > > >  static void print_isa(struct seq_file *f, const char *isa)
> > > >  {
> > > > --
> > > > 2.35.1
> > > > 
