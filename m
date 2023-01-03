Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6665C7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjACUVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjACUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:21:10 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654E12AF2;
        Tue,  3 Jan 2023 12:21:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmANVV1RCsIk4cH3FacYYuZSPuJSI1pGhucHGfwD+LzwvOYbA3Y5HXkjY/FmETPSnPgQxAlzV2KHobGsjagR09TiMrFpCnmCEm5B9aMLdn1D9mHBXn3+J+8zEdgSlrCiAj3ZB50CycLtFCMn+LPsuztfzLRvRhZRy4IOAHFXt2ppL74SVXNKQTj5FXSX/msdsD3QJGZcplH1XMOINjvGVF4tvTvo6/dea9FOemhTyA6mPVfC8lKrdL33EJ6m0ZoeRKjB57lTJKaeqqrt2wEgDM7kWoIatmQ0zu5GlWtXXswe7XyDRl3cJ+uMLGYjrCVMfGByK08mgQfvyUbLPQCOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X62DcfzzOnYkCGPy/E4uqQgSCwZ8+mR8yeP9suBg7/Q=;
 b=ht6mcheQtyw1RXCHCxld47Y9CEY2yol9nsjFuwZdpp8asWKMHgxvRpejhDlSwAoedF647hVPm4FdZo9WNvxnpi111WMlnMv8s21M5MBPr1cr0Zkg7DD+SpvgmgJKfM6GsJ45aHJkISVPw0lToU5DSwRp0suYE88jkxTvqvCe3f35pSibM2zMJl1tNilMH8uisofFLxjbDNHpP2Q70tN9WdLBZ86BorzYmez/aju/z2HEHGpaiA6GOghK3DGV5roBqVg75edBAYwIqie2zLLqWzTUq0k0TCMQkd64wFa28TZGtNpGTQiJHVfNiwbtVtAssQUdmogbjfoS6FstfzaaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X62DcfzzOnYkCGPy/E4uqQgSCwZ8+mR8yeP9suBg7/Q=;
 b=FqYugoxDCsY6Qh0KEAVsK0JYhqJIz2f5+6oEw//bnh1IcQ3OFF91oCJHixh6Gyw1DtQx7X+Kn9jluplGLNM0KFzBnzFXWgnpxPQaPG4MNcDvqmLkhcazmFHqkYES3bTUNPnHP2WT47V30fYZnK4cs6Uliekpb01DkcTJvbZ9NJXq4/tq5x1Xt8XdT38u+AtunhQezNdVrDUSC2DWJXxaKhPw98OcKBdlrk+hJ+XhZ6MAn2tdQLw+x6EpHiYMd3pgaVcYnV49hvwqSRoIDg0h5gUzTjOqeSAkmxLu7m1/qEUcb7udXP2UcRcXdRYYQ0k/Q59804y0gDOTkjYMispJBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM7PR10MB3350.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:21:04 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:21:04 +0000
Date:   Tue, 3 Jan 2023 21:20:59 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y6WX1Y9GZmvxqlCc@google.com>
        <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AM7PR10MB3350:EE_
X-MS-Office365-Filtering-Correlation-Id: b6037ce9-6782-4d32-24b5-08daedc809da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtcN/cW7PlFttwILzkshD/clXGqd99KPVMcpvEOzQqLIqT2y8DV/OuBLKAclwm8t7QSdPYUwMk09pHD1PLLx25VDNf7kPkCdy5VTzrpUxbysT4y/uxOoZarX0oPjyne0aRr8VZsHoaufCE3VNa7Uyh2LFliuhk0Ag4YN04KMEiFKmimVplBsTiPg0la9rnoOSXDM7Aa9FSVK16DfZttW9em1B8gc/Ozwpvl4+ygm1CgH+chl0T9T+RofaNjds2PyUjQb99fBh5+KqqD0B67BgjsHA0ffLGa2T5SxI7TDDkVABH5u8clJ0KNOjiyCKQaFJj93qXJFrAluFNLoAUU6lgGI/obbmVpb+RxhQJUHMM1bj/WUkqtDgxyUXLTXU46D532WtK2g6YWWVwqYD3Du2JzfYQMnnnRL/FWRqf68F/EuUj3ij0Wnp9CFHhLmSTk/dz4rkuagukHso1MTGo9ZgK1XvSsi+wenC/P3ohQY2yY1jxApEep/bd/IyIoW7pACkHKqXm+J5geV84lrfI7Uf3bugfoDdySZwnHB+L5EpklsQePqIKy3TeZaq7mG9QXoNbLDq0jCoNvu6H9Xb3388llPajY/pCYpfcm7F0qox6FjTuLbL3vkBINOTjw8pF+ecXhaHVtM6S4iemxcAR8qKfESBn8mW1nlolsEFxn5voqVA0rjs97c9EnsvtxiaxtiwDs1bvVkAuv7pYjvqUM8pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(83380400001)(86362001)(82960400001)(5660300002)(8936002)(38100700002)(2906002)(44832011)(41300700001)(6666004)(478600001)(6506007)(4326008)(8676002)(1076003)(6512007)(316002)(186003)(9686003)(66476007)(6916009)(66556008)(54906003)(6486002)(66946007)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYS2sXKP6iv+xMoeHGd/hXzjKVrx4Z2S+JmeMrujPXn9mK8tn9AlqvAWtpAF?=
 =?us-ascii?Q?/5RIK9E483qBGuN/X+T85n7tn6W9uswnC90M0hu7JMFMHOeVCQCbASbYhEpb?=
 =?us-ascii?Q?ubmUBzzyyWJJ8HJ1qLRYeDWJbNUsr4RpxtvT192xzf9M6O/rQA/ahvUbrkzb?=
 =?us-ascii?Q?gNJ27fTF3cu40yqppxVFCPnDLi4jBhOUP6JXWeLL05UHP/WWr437305nwUU9?=
 =?us-ascii?Q?zNVCF5e3xbrTlspRlu1r73/XhogAp6/nOF7dgKAFETCu45pvbyDGQz/KLb6d?=
 =?us-ascii?Q?NOMfzwQgqZBSheX8rnY9ZKLYhhCJ+qcLrjz6ElV/RoMg6zYK5vlXgQ9Eufav?=
 =?us-ascii?Q?lA835aN+utj+1VDVFlThgWue3khaYQNVsSF7ztMi5O5h/edaRVh0469KrANv?=
 =?us-ascii?Q?jdPyfg91Ta7b09DG9gxzqajDGTiQ+RMO/ZUw/ng0fr08LRFPRVVbv1AbCNel?=
 =?us-ascii?Q?daBqd3WWAaVI3Pc+6ITewMtjtLQIyFkBm9tUAUTyd3YdaTRrz8EVQB2yBjyJ?=
 =?us-ascii?Q?NKFIG0Yiwm4myfuhLSDJr6YUnlHj3vzkIIxFunBR7ujCIKbC/sv1T0d1Y54E?=
 =?us-ascii?Q?TbMhjvcZ06dnqnLe0+9FIeFuv72dA3J0+9rBlo+WUcP2PwMkdV/PIWXqIXE8?=
 =?us-ascii?Q?RFxJJ+k7O1sQt973BtTTKZw3/yroLfoB79jrvEfvUitF1+db3Qksi64FZqhX?=
 =?us-ascii?Q?QOgq14MGv5vA6lDkPfKZZ1Pk+MSvMfH3p9yY2aSb0BitpgAKTGubLpBVNQ3o?=
 =?us-ascii?Q?qiPDQoJ8klaqW5uyrbOsFco3qzbM1lvBiYDTzE7NxvKB1TB83tAXMNjCE1OS?=
 =?us-ascii?Q?QlaWmQU/ES1wEZlDp5pHTiVu0NImY9kjlvrN2t7mxzIyQDXDCMIeaUwwBrYE?=
 =?us-ascii?Q?wVzm+t+gDR3r7T3Lzlt4FGNeLLrfCLZYuhiQM3JpnU3jr3QQlAckJfjljaR0?=
 =?us-ascii?Q?570E1RmeRNeTD0d4bTIxBw8p0IVqx+euApu14i1AZa8dnwaF2G0zOenV1l2L?=
 =?us-ascii?Q?7hGgZpPgwGJoykGbC2hApUirzmm0x0rKuh3b3myZURKmrnluNNNDqX6M62Ri?=
 =?us-ascii?Q?C2TSjHR8Mlr3xYjSP5cYmx2N8+CQfMODAHL69xRGUo7a7OgHQ/LWL29DNL91?=
 =?us-ascii?Q?ucnp42Wo3m+Cl3bYRC2cuagOBuLiYP9my+Wyd541YCw9/j6i1B48RqR+4JMZ?=
 =?us-ascii?Q?z3fuA4k5xYMiYF0uOwdpSLJtZwCBTNuNHMp1+PPJVrAp20Au+orLfkFMfJXx?=
 =?us-ascii?Q?gQcfOArJdnseXnQuCUSVsBNZfBAOWh9q3SzcGn9lLkMeS8RkOYTqNovTUXOF?=
 =?us-ascii?Q?rT4kxlFKqsGrwsP/UjAtYN4+hnw95fkjD8G498EHAw7tg6x8VVleyakFLLQn?=
 =?us-ascii?Q?fscGLYghcpCE4PNzUxE8Kd8eybgolYthjn5KiIBXIcMvbkIAu/tr04klokp/?=
 =?us-ascii?Q?sfTDSG0n/63mwEyP/FywOhvfS6lXjx29LjyxWkjV2P/vS0Y6GO+XcJoH+wQV?=
 =?us-ascii?Q?1+D5FOQp8IMF+BL/WvARq7RH8PXJNVjtGhrgeIAwfC7D0vLhokVJegYKoshH?=
 =?us-ascii?Q?8EnCVneh72V/e711FHMPXMLA1yBjjiHWkEhgo25rQBQhn6YWHjLGK7aeVz0Y?=
 =?us-ascii?Q?m3AgYfIFv99XWkrXL2LzgCnXVnW1dAhv3DqZG68g6anIW8HuRZUoMrPsxCR9?=
 =?us-ascii?Q?QN8ZPw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6037ce9-6782-4d32-24b5-08daedc809da
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:21:04.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUUGAV5PSYVFVmN0XGn7DkrnepWMeMxgSnwiS5KVDQBTY6vGs1K707X3HaKnRwnk/eFN+Sgrszisx5qgK/aOkJH0b0cxXHXxli07hKv9wDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3350
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 2 Jan 2023 16:22:27 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Fri, 23 Dec 2022 11:58:13 +0000
> schrieb Lee Jones <lee@kernel.org>:
> 
> > On Fri, 07 Oct 2022, Henning Schild wrote:
> >   
> > > If we register a "leds-gpio" platform device for GPIO pins that do
> > > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > > later. If there is no driver to provide that pin we will poll
> > > forever and also create a lot of log messages.
> > > 
> > > So check if that GPIO driver is configured, if so it will come up
> > > eventually. If not, we exit our probe function early and do not
> > > even bother registering the "leds-gpio". This method was chosen
> > > over "Kconfig depends" since this way we can add support for more
> > > devices and GPIO backends more easily without "depends":ing on all
> > > GPIO backends.
> > > 
> > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > <henning.schild@siemens.com> ---    
> > 
> > What happened in versions 1 through 3?  Please provide a
> > change-log.  
> 
> Not too much really, but i will write a changelog and cover letter
> when sending again. Mostly commit message stuff and later a rebase.

Lee please let me know if you insist on that changelog, in which case i
would send that same patch again with a cover-letter that will carry a
not too spectacular changelog.

Or get back on the rest of what i wrote earlier, maybe we need another
version of the patch and not just the same one again with only a
changelog added.

Henning

> > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> > > b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> > > b9eeb8702df0..fb8d427837db 100644 ---
> > > a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> > > b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -77,6 +77,8 @@
> > > static int simatic_ipc_leds_gpio_probe(struct platform_device
> > > *pdev) switch (plat->devmode) {
> > >  	case SIMATIC_IPC_DEVICE_127E:
> > > +		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> > > +			return -ENODEV;    
> > 
> > I see that there is an unfortunate precedent for this in the lines
> > below.  However, I also see that the commit which added it was not
> > reviewed by Pavel.  
> 
> Right i think that might have been you in the end.
> 
> > This is an interesting problem, due to the different devices we're
> > attempting to support in this single driver using different
> > GPIO/PINCTRL drivers, which is unusual.  We usually resolve these
> > kinds of issues as a Kconfig 'depends' line which covers the whole
> > driver.  
> 
> This was tried but the result was not too nice. It is really the same
> gpio led driver implemented on top of multiple possible gpio chip
> drivers. Making it depend on both pulls in too much in case one wants
> a minimal config, writing a new driver for each backend would
> duplicate too much code.
> 
> But maybe a splitting out a -common or moving stuff into headers could
> help with the duplication if we want to go the "one driver for one
> device" road. I would not want that and what we currently see was
> discussed and approved as part of another series, when i introduced
> x27G.
>  
> > Would 'depends GPIO_F7188X || PINCTRL_BROXTON' be a suitable
> > replacement, I wonder?  If it's possible for SIMATIC_IPC_DEVICE_127E
> > to be probing when only GPIO_F7188X is enabled?  If so, this would
> > result in the same scenario.  
> 
> No that would not work. Depending on which board we are on we depend
> on another pin provider. "&&" would be but it would be kind of
> overkill and not allow for a minimal kernel config in case someone
> wanted a special minimal kernel for either one.
> 
> > It also seems wrong for -EPROBE_DEFER to loop indefinitely.  Surely
> > in some valid circumstances dependencies are never satisfied?  
> 
> Well that is what i would guess as well. But that infinite loop
> waiting for a pin to appear endlessly is a part of "leds-gpio". If
> "leds-gpio" had some magic to eventually bail out (maybe say we give
> it X runs with some sleep back-off) i would not have to do anything
> here. I consider that patch a workaround for a shortcoming in
> "leds-gpio", which busy loops and fills up your disk quickly with logs
> if you mention a pin that never comes. Which i imagine can quickly
> happen if you have a typo on your device tree or a kernel config not
> enabling a pin provider driver.
> 
> I am not sure there are no other valid reasons. And i think that indef
> loop needs fixing at some point. Hopefully by a LEDs maintainer or
> maybe i will even help out.
> 
> Until that day i would like to have the proposed patch merged to not
> have users run into a known issue. The pattern is established and has
> been discussed before and the patch it rather trivial.
> 
> Later we can see about improving and ask fundamental questions again.
> 
> Henning
> 
> > >  		simatic_ipc_led_gpio_table =
> > > &simatic_ipc_led_gpio_table_127e; break;
> > >  	case SIMATIC_IPC_DEVICE_227G:
> > > -- 
> > > 2.35.1
> > >     
> >   
> 

