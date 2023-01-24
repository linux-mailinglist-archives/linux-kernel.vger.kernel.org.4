Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42873679953
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjAXNf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjAXNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:35:25 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4C3594;
        Tue, 24 Jan 2023 05:35:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzvSzIYI8O0QcgJ2QhqvvSCSPKCW0M9XZo5V0a63Ns0IMAUl3lHa0tO/ru36i7i99v+5s9pABaqKdLNpFE6xyfvvjmk+KNo+5ygW6QKXIxpekUBXZ5YwDQgxIxR6rPHHTMhcL4B5FlTUhWI3vwgJ7BNsiTPDq1OKYskt2no1qV6x8JS6V/6lu8kC1JTbZv9gJ1DT9HbJCwTmJspIDnUPcLTBQOCMWLys7mdpBC8NVE/jJ/4i9A7D2FXgVbD8ifNZRfK0CfDZuwNP84VG753faDFDgAe8bPRGSf4fCFevSXQAx58TvpqGZTDEcLD3cF3YR/dY5OKmaSrzDxwid42nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxMPl4q8GqBIuJ8Fm6YCHd3OTWYG33xC6QjwzmqN998=;
 b=HWmykYLksWw3Hz6R0tEKCwtGJBu7lYCIgAxpEu0WFu8dhF0VUYVUNYwhFlKbTscqGNAXfsU3tCkIt2qGQApHtVIbGUBKD89MJ0v1TLnCZZAWvS2wjqh6tN1A00wSNpL0XN7gWUo5bkWfZ70M+g9xrvE9s5qEityUZmjyUs0/FrBq2zRmKp9N3IA7oAooMFlYEVvblyOp98QIJAnKiB2zBfA9F4b2ys2Vx6SO6ZMuJvkPWhVijEn+94vLcJL5YLB9IA6UnqHwlMJA/f4KwwuahnV8sKUau9wXhSmew+cqis6luSXkd470trIseN86E2C9+ZAxFbbCgkRF+tSZJ2QlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxMPl4q8GqBIuJ8Fm6YCHd3OTWYG33xC6QjwzmqN998=;
 b=eMIyc1UCjAHEdg2qPMMcaUsRgdN7sYt9HFh7XLRYm0UjGH2yw8M/fMPJF9PZr3J+luL0xrmL2y6/1FTNu2v7N+ugvUox9eWleXN6Lii60yrSICFEidDhVoqNwbICKveeeutqYP3KvUPktlbFhczykDnvKIA8hpepk7HtALSHgjR7EhGxKCtPMOg9kUfBXzZCDNTCzf4o0ToKgsyy3150fHn7F+waJFM2KbB+DWGuq0JOJpaT/kh/KFc4QLQ+69FL8rkDOiCDL8Gt4YJNRx5LT4vjhFOeOSqvjCAtaddsv0aT5rdxgDWpchaT4Ho5jnJhp2ZDAo2v3coOttNXiak/QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB5879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:527::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 13:35:20 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 13:35:20 +0000
Date:   Tue, 24 Jan 2023 14:35:14 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230124143514.1abf933f@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
        <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
        <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: e4868b73-56aa-4203-1edd-08dafe0fd678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7FnH1Byt4uylEH2BAf95uyDmTFECiZvpskgxmiPLJiVon6ceRl4F5LWvcXWeKduKneQRVVFVTe+2yds395/gstYjwN3JPRn0ULODii/BLeeLsILvo/9Ckiv+sSvjIQ3B4tJ8PJ/tFtlRpF4gd1cYP3ean3MZzo1ZcdBLEC8/oeNRatht2Z9cFw7W7zKmjnoeugBAaXUM08C5stKjkD5t9h/IeqnfzhpjyKFKIJBcixg+y2+l/Qiz4ucsL0V11FqQoSiDmRfxJu92TUVUcnXBJjURxbBtY+pahG8Q4E+1UKXcExeLT1+8F5Rh5FwLTr+7S/wUXNqtg+Qla5Qy8V4fG36KnFUWGhyXzxspvnaE0dblYZtg5dx114vrH22vrBMeOWaVvavENYUq1zGI6XUFipWDZ+mISmbvf+DfwC66Pql8FcFMwa4sac4LmWQBZ1ay0U9sqsA0LujQRiGb8lBu2wTe+zuVEZOvJfQIZGCiLJZSCnRMeEFhqdF0ScQ2RBRQlaaTj4ZdWa8xv2oG0+BepT258TxgFYZLQbpKDeUZ8ULx/TMwOYlfxDIpVvbyciwE8AmK6XYINPONCcRT6gPMg5dBcpJ4Pz+S2RXFZyQEwyJ2trApUt8Ay0z8iQLYkPu7RYtJHXp+k5tnhTmqxkJQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(86362001)(66946007)(66556008)(8676002)(66476007)(6916009)(44832011)(4326008)(5660300002)(2906002)(8936002)(38100700002)(82960400001)(6506007)(478600001)(6666004)(54906003)(316002)(66899015)(6486002)(41300700001)(6512007)(83380400001)(9686003)(186003)(1076003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KqMSpo65BK3TUBm905vCTOBs2BGtD7Cx5XhlSWKhxDZgWA4xgYDSegt9rqlx?=
 =?us-ascii?Q?VW/rGrfGIQ0ZRl9u4+2XVeMgm9gR0x1I3xQmQmneffTFYyT+wr9lM49ayFfe?=
 =?us-ascii?Q?sDaKxtZerKZ/z4ASHCS2hA6AyCHO12mHoNZXAtAc8kliw91vimyokGQlpENl?=
 =?us-ascii?Q?SPyx0O287B8RPE43v2tQ6kjf4HyyCQeBi24I8rq93Rwqh+ptgAz4pvDJarsg?=
 =?us-ascii?Q?D67s9C2jTEikgTOuzAe/1roLtuCQd7qImWbqPDpTR/m1XuXVSBWJfuxzDg3e?=
 =?us-ascii?Q?2JqWrbZp1NQ0YQvytI71yzM/A0V1ag3HvAlac0I+gIwcaPyzXfJ8eM0PnUYI?=
 =?us-ascii?Q?DB2xV+MtmFS6pSLkKj3wfwrmJ58vTFagshZh5F5JuLiNuNA4al5GiklBSWP9?=
 =?us-ascii?Q?5Qegxk/u5TWEjR/ZljvW3QjJ5+1KKoeAhtaRbuXfwf63KmZD4E4jJfBj/G8S?=
 =?us-ascii?Q?qBpXtqJErapkY9mtXeHhFu4m0sG/qYsZHrSGDf/ui9U5FhQEgrxoAHYz6D8T?=
 =?us-ascii?Q?elUulZV7HpBhaVzZNUh33mOBX7D+T5MXAtNCrO8DGVC75QLzlaOa9YgFtEJb?=
 =?us-ascii?Q?N3DIjQhmU6XU/cXbCU2x1S6raD4qJJ18N0pF+WrBsoEPAV850Xi8E57TXvTm?=
 =?us-ascii?Q?5We3C6dGrplW0KEp0jSZot8jCfVNU3LcD6l5DYV7Nn+5J53SwdPaDZfd4vyD?=
 =?us-ascii?Q?jzDHUixj+duq2uko9ysdrWue1e58JY4RPCivP9fFjxZXSbNNrgq4TcdbvfHf?=
 =?us-ascii?Q?UhJ0JLlaWunPUyDvmfWYC4OSjJpjrYayXbazZLQAF8k9YYYRFEEnRqddsrRs?=
 =?us-ascii?Q?liFAto99uiiFbFcK2Uu6bvNqd4dfl0cvsR856HViiswvcpYJ0o7jleMafxAw?=
 =?us-ascii?Q?ZDmqCPopNXgDVRzV4LFPRaWIiEOXdCtfKjva+nrpO1PcVe0DukMYFax5iFa9?=
 =?us-ascii?Q?gjXr1mQ4qlG8z7hd30fRS+GTLTEn7rmSdxfzQ1t1xFBjWuVW22PvgCh+d02B?=
 =?us-ascii?Q?kA1ZDjxajn/ZYRQ+sLxpdIdli031HZPVmcRWptFDFBJkVnYje7pTjn5ne/na?=
 =?us-ascii?Q?ZdQ5NSUtvDCWbCpvQQV6KsBb80V2K6OwbW5OyTDVgcry0X1sYODBffTd+iX9?=
 =?us-ascii?Q?l60iQKYUVJqILdT8UAWvb1dhrjHlspfwSvcGqfAr0vk3DQlN6gRg3YXMbdL9?=
 =?us-ascii?Q?dij/SysPPb+3PEa35yHgZR6VurEEpghyEy4nXkQ8DTGbYMeKRreHdccfPyQx?=
 =?us-ascii?Q?sh7HajIHeSW5Kg/9rsX28v6D91uXa7D5XjfEJ9h2PuxMkZufJYjuoTRvTePj?=
 =?us-ascii?Q?yS9U0ikQMPLHvLNwFLo4rvhCdXPHcwJkO8S6/EATy1GR6VxfxAaoPBzu7Og/?=
 =?us-ascii?Q?U0ipzVIt8wsdxGN1qPBJnUl+7tK5zaPtm6uSZ9Oee+LKF4b4txI2IsokKsC3?=
 =?us-ascii?Q?74dFnSyhTkl2oJa42tHsWjI2FobF9nrnVYx8yAyBftVALJHJLoqiAPlGG8uZ?=
 =?us-ascii?Q?t7rlcc62Tyvbv7HUjEBwJh16Xrx+L/meE29kgi2OtnJF5a2x9k0WntayMIxI?=
 =?us-ascii?Q?3ug5QX5SGCgrUkMF5+sJeDjIsAlpPcfJ38LJMqVqamV5xvUQvENrT2sTgOfp?=
 =?us-ascii?Q?UtSnRI+FtVjst3Kx1na1Mnx3/A3htQxHEWkuPeqRDybPW9VXZ4m12EigsgqU?=
 =?us-ascii?Q?OFcFdQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4868b73-56aa-4203-1edd-08dafe0fd678
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 13:35:20.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9EfFar9Suo0cIYRBa44ldBvWUvJ0S5CyBmOlCXmclivEcjwbdz0e3sLVGnrNI2cn2Q2INophngVUNsr/IQPCinkS90JHULVpiZF1+nO+ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 24 Jan 2023 11:46:34 +0200
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Mon, Jan 23, 2023 at 10:49 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> > Am Thu, 19 Jan 2023 21:02:40 +0000
> > schrieb Lee Jones <lee@kernel.org>:  
> > > On Fri, 07 Oct 2022, Henning Schild wrote:  
> 
> > > > If we register a "leds-gpio" platform device for GPIO pins that
> > > > do not exist we get a -EPROBE_DEFER and the probe will be tried
> > > > again later. If there is no driver to provide that pin we will
> > > > poll forever and also create a lot of log messages.
> > > >
> > > > So check if that GPIO driver is configured, if so it will come
> > > > up eventually. If not, we exit our probe function early and do
> > > > not even bother registering the "leds-gpio". This method was
> > > > chosen over "Kconfig depends" since this way we can add support
> > > > for more devices and GPIO backends more easily without
> > > > "depends":ing on all GPIO backends.
> > > >
> > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > <henning.schild@siemens.com> ---
> > > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > > >  1 file changed, 2 insertions(+)  
> > >
> > > FYI: I'm going to try my best not to take another one like this.  
> >
> > understood!
> >  
> > > Please try to improve the whole situation for you next
> > > submission.  
> >
> > When i have to touch this again, which i will, i will propose either
> > "depend on all possible GPIO drivers" or introduce "#ifdef CONFIG"s.
> > Caring most about big configs as seen in distros like debian, even
> > for embedded systems ... i think i would prefer the first option,
> > as it will also be easier to maintain.
> >
> > I do not see the whole infinite loop story on my plate, but if that
> > got fixed i would follow up taking the fix into account.  
> 
> AFAICS another possible (not sure if it's preferable) solution is to
> split this driver to subdrivers and each of them will be dependent on
> the corresponding pin control in Kconfig. It will satisfy both of your
> requirements, right? Something like
> 
> simatic-leds-core.c
> simatic-leds-127e.c (config ..._127E depends on PINCTRL_BROXTON)
> ...

I would like to keep the number of files and CONFIG switches low, with
a focus on the config switches. Every new CONFIG=y/m has to be
requested in countless distros. So far i only dealt with debian where
ubuntu might follow, did not check others with recent enough kernels ...
like fedora if they have the SIMATIC stuff turned on or need to be
asked to do so.

Henning




