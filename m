Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD1679C88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjAXOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjAXOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:51:28 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656E4B1BD;
        Tue, 24 Jan 2023 06:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVs8P142KlFBNh+L0Izs6EYgh89bCKR1AFaeJJkopObCLUX8rn40flhtgFaxjo1x2lpN2R1iOro2ECzL5vthkundc9QLJJA/R8T/boeEmSpYNTzUZy8ZE1X6wc/JpjcOU8o88mPTCR2SgcosvmroYksMut3qaGp7poQ7l3QoZER1RhH4d5GCHJoM13l/31tsb6SBsLoMtsSWWZgwsBlgkJpmj51FJf+8Ce9ApmsMostcYQFSRe0bDoYV1EX/ZY5v7ES+oNTVlZxZ+cyHCPCdvbd1C4NZyWeqleMOEwBSn/cquBW6N0RERtDo7+H2vMAW4/ajKo47BC9tMi9DT1XSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgzSZ9A71DuyE6ZdjDII5fVdLw+qoBKMwEhKvIg2Utc=;
 b=AuQgJFh4TBirFQS/TpyIa0zG3EQFbRcAc9oSSopJF2dO0p9zxOJU0+lDnshT0FG38UqFpAvgiYYCZJprf+X9exTIjh2WnIulL1znk23MHgQ8B7FOEjWc7CBbKMqLsf0HtXH+igw4qv/W6sPFsLk1RdOvCv7lRhej7EroQijq+pE6id4R7GE3fhLHJTugEbkoOuihXSWARBxL1N3/wGcmcjQTmS37fG+z2jTS8CCpQ3uOhtbaoKcSCPMhh/OqIv8H+S9NkxWQGKKexoQc/+CHYiNXkldbrs4Bpd0ky43lzg0l1BzubnQxFoPCY5x9Kb5ciQ5rmsygHb3HaRc7IyjAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgzSZ9A71DuyE6ZdjDII5fVdLw+qoBKMwEhKvIg2Utc=;
 b=SIpy4u1h454rJH9MYw3/hP5ixl8CqZY/+rpMPgOpU5axNQLZ/4Iq/KY3zO9k7v9vTW3PERGC0tyIIdXgFg8srilzIz4cAHjkfSZe1hNHqZljbiqij/Ckq9DIUHtLtvJ3G2XI8nELwXR/rt56PsotEgfjUwrBWkGsDCmrWN9S4KSQMqs8gSegdnCzYoo/yh5cwal77j96cO0+jn/C+WghiyxcW9ZMpcpMsMNMFWeKAMP/tUVGsvF3BzkfCf9uHieQbqKfGiLo56T/Z/zgRWu7AUzSxRWjYCAku8XtU77pQYrFIilXgwV086PvbsWQhGql8bpyZRzgPE8bn5gM9+4TRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAVPR10MB6909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:51:07 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:51:07 +0000
Date:   Tue, 24 Jan 2023 15:50:55 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230124155055.724f543c@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230124145248.3fffa6f0@md1za8fc.ad001.siemens.net>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
        <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
        <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
        <Y8+zD6AxuJVy5b7Y@google.com>
        <20230124145248.3fffa6f0@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:610:51::18) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAVPR10MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e677a1f-f531-46b2-5cfa-08dafe1a6c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk2VdYTJ9eCWFVnEsFlEIw0Pph5RoLcQT3bZZ/bRFR7j7+RhJwTBrP0IJhOJc3tvDE8W7bf3llp3J08gmsBJRn3R9J0F1qq+xz0PEggCXnRnWWmhvCe0ezivSRsLuOr89tNvoLDJAvG9LPdnkZo41TGSkHZVVWrwQFh6JG+mmd7P0EN3jk8q6pBitWmatOuOEDbZSpN6gQjRM1r2k1fOgc1rmnqTVPtlQ8q354nujzW/ybTV9p0+dZP++FCSEytFg9RnFT7FR6a5hCE2nwXmyMFiXyBbgupBJYQsiKfUSGpzTbxhsjS+XUKtY1hZHpTkP1NKy+i9AK8FLPQA800dFxcxbrDt5tax74m0ksjZuLK0mcBsmoq4hmhsdL6chO4S+JPWgpb7KUPAwxpkr3jOt9xrstJVePi/hAVERDy0KZuZ+fos1cLrmukWQVBPAbJnvFwp9bE9OZdBizAvDNFows21Kj0+ADKIWkwMLUKN5lUHxgsQK2/v5hq8fttJysYZ+8rZQaMdIN2fdYkk2OhsFFEiH/VKer9GFoywujtJ/BqLjfpFGskzS0hL6AC+hU21GKnB7s54ZfSTCI+3rMzcE8CWkG4/cdGytW6O+W+1yfaK2TDm0VPTxvTE88KTVDJyR0aj/NhbTvZ9ZhZyMlaEfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(478600001)(6486002)(44832011)(5660300002)(2906002)(9686003)(6666004)(186003)(6512007)(8936002)(82960400001)(54906003)(316002)(66899015)(66476007)(53546011)(66946007)(66556008)(6916009)(8676002)(4326008)(1076003)(6506007)(83380400001)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PFMwr0f/2GMudFjAzms9lQAzoRsIEnknYev5IgKy0KhCUssHqCxHJ40nxPQW?=
 =?us-ascii?Q?azhUBrEXXl6j/tS9mSoY4PynZcS+syUNUWlI3ZoYC7wshIYRqEaCkkZjv9Ud?=
 =?us-ascii?Q?TCa0hdvGn8tPjzpP4NTbJUb57mVio61lTtRymC1goxQDvKLZRSwC96KeIHT6?=
 =?us-ascii?Q?WPz5EjcQtq1+4iRI0BbtWUxvcZe0HcVX2gW5QRx5Fjqw4Dx5gUWuisflLSxB?=
 =?us-ascii?Q?0E2OiGUDY0Z11Rq1fbi9q51F2DSMpeLcJ2pWY3gZjJJDpA+mnBtXkiwTqOIS?=
 =?us-ascii?Q?gArSl1j5ti/plwlbjoOyxljgy7nkeUYSB2BjjtEM9lHtJ6UUOGse3qp1mKjp?=
 =?us-ascii?Q?d7tJBJJa66LCnpm9ZnQJU5xCAlmUMjuYcW1kjXrsYyAi+X+kVoD8J2+/tWcx?=
 =?us-ascii?Q?H5KHGWRbBA3mycNQ0BGPxgoRMPp6AZAQa6Os4+ArBTrPqRL3yHmm4oYrZKVG?=
 =?us-ascii?Q?uDGQflaOdWTolpLXQldKJT9kuHqkTXsJV/HKNAacn91s3fptxPMZGj8MmLVG?=
 =?us-ascii?Q?MgNFj9kJ3fU0MU53Pj0wboT8bXwamEG1Zy5LQqGdBC5IlGpeidwS7684d2TJ?=
 =?us-ascii?Q?eT+GRuTc3DPJIRWZRqvX8JEzhag7KH8HYXyTtP0DApq7yta/8L7VUJynT5GD?=
 =?us-ascii?Q?+i72Ue1p0FHZP8MTxVfqggQU0GLYXaNnElQNaFpywoZ12D7teaVacnsAl9vv?=
 =?us-ascii?Q?4m4eRw+2m7VDZVA6b0FkqDbjnidZh9W9w8G4tnGuFfMdxSrGDTUSL5eiACzO?=
 =?us-ascii?Q?xxBdbjcBWsYqReXBnlTs2vjyGQkryVapP51sYHoaFXMBio5ESPiROp2KT9O0?=
 =?us-ascii?Q?PdHYBtSU/oIvIqnZbLEKBjHSoE7ACIXX+j5++psLOc6phB+MCmgPoUScJFX9?=
 =?us-ascii?Q?eauMACkibTfrrGRj2vGuWdsTARdXYOq0r4FAC85K/j0OAmDszkO6/hfQTQO/?=
 =?us-ascii?Q?Y+PvJsEjkgirXvvpnkeHJtFxjZSWevW0UMXVKxsgYpPlo+TAYuafo2bWHKNR?=
 =?us-ascii?Q?EtQaFEcN36vYTh70LU9WuATkTpty/lg9C4vxpX0xVsHYM7gPDT6+l0BKhG/0?=
 =?us-ascii?Q?ToPH2wLq530JBTxd39H96X1gcnkfOpEly05P1jmsqKiZT5wdK7Pz7E0ZPf2l?=
 =?us-ascii?Q?eaaYlJw7+uYgYgFYVzGKNG6oLnTK059ICBpI6eCkvHw5dj1S+ab0AB3NecUF?=
 =?us-ascii?Q?F6Y2hZaf86hVgqWc1dz1ZrDgUJQtCS9r4rKe1RcBaYF/pcKV6u9qPDVwgZyj?=
 =?us-ascii?Q?VUtHI8cif95nZ7rq+MSUiqFThwnEYRzgU9qHMwSoNbvQ9UJYDFG8rkuBdUbH?=
 =?us-ascii?Q?IG2bQnVUhNewiMYTGbRCocMrl9wab7cIVS6RtQA6RYpMUj42edNpr0Vrb8ML?=
 =?us-ascii?Q?umuiZtLhMrXxnhrWZy5HEQaWRUQyz0GKec66OcbEvaJFU0lFMhNKEP+Lmdy+?=
 =?us-ascii?Q?MmsNB+wdh/vvFVbzfUDjNhRVZ7Fq/PQNU5SrG36SkPLihTY3kf2zVEiBQW8A?=
 =?us-ascii?Q?Mdkctq3aq/zsE9iReRqNiAhXY5NpNii/jARncczlz7F3X7zwB0ZBr4qjTmpB?=
 =?us-ascii?Q?xrnkv5+dWvSD0Z0tv5dgX1RzOgLPOzRbyvCqggsiQdRDjYBL8XwB/M9lxknO?=
 =?us-ascii?Q?UPzgIaTJ1bV+RM8e/rJNjs1VtEbWy0XYweHiokCwSoNht8PXJnkhhBBpp4OO?=
 =?us-ascii?Q?JKXlFw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e677a1f-f531-46b2-5cfa-08dafe1a6c89
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:51:07.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99oHh68YyL2VuPO8k6qzBdR2STZAhSBBjWIbLBbdSfPm5nWnmdQxw+/HqoX/7CR57Q7sJxhTRpKI6KSp7WdLPk0rsWSQ+sMs6j+0ppj0/KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 24 Jan 2023 14:52:48 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Tue, 24 Jan 2023 10:29:35 +0000
> schrieb Lee Jones <lee@kernel.org>:
> 
> > On Tue, 24 Jan 2023, Andy Shevchenko wrote:
> >   
> > > On Mon, Jan 23, 2023 at 10:49 PM Henning Schild
> > > <henning.schild@siemens.com> wrote:    
> > > > Am Thu, 19 Jan 2023 21:02:40 +0000
> > > > schrieb Lee Jones <lee@kernel.org>:    
> > > > > On Fri, 07 Oct 2022, Henning Schild wrote:    
> > >     
> > > > > > If we register a "leds-gpio" platform device for GPIO pins
> > > > > > that do not exist we get a -EPROBE_DEFER and the probe will
> > > > > > be tried again later. If there is no driver to provide that
> > > > > > pin we will poll forever and also create a lot of log
> > > > > > messages.
> > > > > >
> > > > > > So check if that GPIO driver is configured, if so it will
> > > > > > come up eventually. If not, we exit our probe function early
> > > > > > and do not even bother registering the "leds-gpio". This
> > > > > > method was chosen over "Kconfig depends" since this way we
> > > > > > can add support for more devices and GPIO backends more
> > > > > > easily without "depends":ing on all GPIO backends.
> > > > > >
> > > > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > > > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > > > <henning.schild@siemens.com> ---
> > > > > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)    
> > > > >
> > > > > FYI: I'm going to try my best not to take another one like
> > > > > this.    
> > > >
> > > > understood!
> > > >    
> > > > > Please try to improve the whole situation for you next
> > > > > submission.    
> > > >
> > > > When i have to touch this again, which i will, i will propose
> > > > either "depend on all possible GPIO drivers" or introduce
> > > > "#ifdef CONFIG"s. Caring most about big configs as seen in
> > > > distros like debian, even for embedded systems ... i think i
> > > > would prefer the first option, as it will also be easier to
> > > > maintain.
> > > >
> > > > I do not see the whole infinite loop story on my plate, but if
> > > > that got fixed i would follow up taking the fix into account.
> > > >  
> > 
> > I still don't really know what you mean by this.  Probe deferring
> > should not work this way.  Do you know why the loop is infinite on
> > your platform?  What keeps triggering the re-probe?  Are you
> > continually binding and unbinding drivers, forever?  Also, what is
> > printing out the failure?  Maybe it should be silent?  
> 
> It has been a while and i would have to reproduce this. But basically
> what happened is that i registered a leds-gpio platform device with a
> lookup table, no errors returned and my "driver" would be done and
> leds-gpio takes over.
> 
> All GPIO_LOOKUP_IDXs point to not yet exisiting pins, potentially
> never existing when the providing driver never comes up. Now leds-gpio
> internally tries again and again with a high frequency (busy?) and
> printing stuff (would have to try again to see what).
> 
> I think one could modifiy any other leds-gpio and totally invalidate
> the lookup table by introducing typos in the chip name of each entry.
> 
> But i will rty again and get back with a better description. Maybe the
> bug was fixed in the meantime or i am doing something wrong when
> registering that platform-device.

I tried again and it turns out that my driver is to blaim. After
registering that leds-gpio it goes and initialized two more LED-related
pins. If those are not there i return a DEFER out of probe and that is
causing the loop. I will have to find a better way of dealing with
those two extra GPIOs and possible DEFERS on them.

gpiod = gpiod_get_index..
...
return PTR_ERR(gpiod);

is seems to be the real problem here

Sorry for the noise and thanks for asking several times, better patches
will follow. Ideas and pointers welcome.

Henning


> Henning
> 
> > > AFAICS another possible (not sure if it's preferable) solution is
> > > to split this driver to subdrivers and each of them will be
> > > dependent on the corresponding pin control in Kconfig. It will
> > > satisfy both of your requirements, right? Something like
> > > 
> > > simatic-leds-core.c
> > > simatic-leds-127e.c (config ..._127E depends on PINCTRL_BROXTON)
> > >   
> > 
> > In theory, yes it would.  You could also introduce a core driver to
> > contain all of the shared code.  Duplication would also be a
> > travesty. 
> 

