Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3066F1441
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbjD1Jdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1Jdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:33:49 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CBA40DB;
        Fri, 28 Apr 2023 02:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrMDzFAIcybXFg+asA2w5giiiMRmiZqxf7z+HLiyYwPk6myl4WRIG48FPJk/SmNcHZnBLtguZG7Lnfn3vwXi11gpnm2l9Hq0XYn1M+IwRKHyJybhOFSe5sGdO++bI6+L4PTC0Imb7A1LQFWPJmqOOjau9Lc7+lIsBkYjjB3jW6YGVEzDWWfRWSd8a8iMNPXz1zJczsl/dKvk3QDjEhpbxkV6/hJ5UHb2rQLIinIaKEvMj8QyK9RaoNmHnEILb2L7moUn0KggFAmtiJBMQHOcgakpKtV3rPXFeNsPQ5L6D1qs/naZ1N2h2cZW7QqHaLp36Cv4kjlUMNx/5vMNNvJoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw1wK3e+QkXBiiemi2dKIs9RhsrkeJ9toKINXGCYDIs=;
 b=hnixwrQZAGepvqpkA0acSHPfHGTXREHiA3Y/JIhdj4gf6CQnrnSj0tc26BAK1zkLk1e2lMjzlT6fJStOKXfrckXQRnTdk6fsTe6kmB335r/Lvko0ZOx6vNu/FytCgiuNB/8h1mLqXO8PcDXuGrmLOavDe3fGhdZ+1+SzKL+RrOFRT0y9o+JvqBKEFrUwTjRFUF81ZJT41KUzYAPzh9pi30wuV8gZmUMDfTY5Z3nLw+yV4t67WOoKW/lB26iwsr1BoALNE74a1hIFUnDCnN+jbzG354XFwWYMrMlMqHp4i1Tg3k6IaCda4MP19jeE+AoKvm2N2UOvhe2AfVQynKC9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw1wK3e+QkXBiiemi2dKIs9RhsrkeJ9toKINXGCYDIs=;
 b=Oq0y1JvQDufL+fh1s+hVcWJi0o4RvhW1YFkKvyiqsAuoiHHOtknjnEMsbdEYxhX2gtwmywEZ7x5i6fy1KAsW7bEJjHqTcciJ2+Ei0C6a8P9OIn9vL4MFbN9xTBZeA7zewt7iA3D8W8bVKXm/jlDAczXrLIBTp0DkC2gzyyOTrY7WJ6mFp/i6oyd7MAPgZAfs9rtBsZfOnCv0HN2bBLlrF1wE95ArBZPuK/jivksIHsHTCWA8bQN+mNLVb7Sex+JaCHWDlMGjlpHcyduTPaP5cqD1t6AOXQGxxeMHk7IjpCSqw2ag7EwjyYPb/A+BbyfZpWD4RnzyEnrcbLkHJnXtEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS1PR10MB5415.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 09:33:44 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9cd:f02a:9a74:b797]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9cd:f02a:9a74:b797%4]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 09:33:44 +0000
Date:   Fri, 28 Apr 2023 11:33:32 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     "Wu, Xing Tong (DI FA CTR IPC CN PRC4)" <XingTong.Wu@siemens.com>
Cc:     'Simon Guinot' <simon.guinot@sequanux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on
 Nuvoton chip
Message-ID: <20230428113332.3a7b9a18@md1za8fc.ad001.siemens.net>
In-Reply-To: <759b2df004e2445e850a01b33e748972@siemens.com>
References: <20230427152055.18380-1-henning.schild@siemens.com>
        <20230427152055.18380-2-henning.schild@siemens.com>
        <ZEuBMCxeWAx9OilV@76cbfcf04d45>
        <759b2df004e2445e850a01b33e748972@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:610:b1::25) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS1PR10MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e260d2-e3b0-4317-5aa3-08db47cba8ed
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B88s271N1pskvqMDZor6hL1z+hRS4o88s7ojcdDFY27QNQkc2w5JuQDCZfHKx41CbPjEKIHpKORYvosHpioa8fLL3JThLf08mBtOshygH7oC1DxuwWzuucAuXz3vFmJ42KJflQn5deg34gTCzOIo5t35p33cxEB5kO9Vs2gFMJ9bq8wlFiMnDH7sUK+Lx3f7DQ7sRHQv0LuENHkczkq6+dM9rnIgoR8sOx4IQ7soHfFrHiafTeoCh87GEWmFdhpkfyZq1ickYnrNfhYarnJv9nXh5QeAbOp0+9+nUU8MmFs+/8PkaMkqNq83qB/R8Kn1hXhQXwARfv7H+pCSq5FvxlpWEgj8GYu0vIExbZFA0VB85ZYecWsFa1kr/IMRlyLLpkmr66DL/iph9ZztBVsQnZZw8Yk1PJCQ3+LaOAexL3v6WvceWXrVmrzbrpOrK5Y5n4uWoVBUnFdYefDD+fR/BHQFXVO8Xqee6zwVyfEc2Vrig+G39iIp5Feeto0yCTXuMUzPujY4C1xTjmOGbHSmiXyjlUWnsQOAN6e7wsEWap/r3DLPo7yfXcy1rJRFqJEf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(86362001)(478600001)(54906003)(6666004)(6486002)(1076003)(6512007)(6506007)(53546011)(9686003)(26005)(186003)(316002)(82960400001)(41300700001)(4326008)(66946007)(66556008)(66476007)(44832011)(6636002)(83380400001)(8936002)(6862004)(5660300002)(2906002)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQxNsxL6zHklWE8GZvGpSXlwhmWWdPzY7siydVuFKfSPvCbx53+XFHzpW7Ay?=
 =?us-ascii?Q?6tAWii5fg2D5OIlVvhk+mG2H6ZZkn6BqgSFKikrhJV5f94Ej6ZzDhmDq8Sky?=
 =?us-ascii?Q?GsqbtGXkGSI6DSiGXtsL6ZWxb2+W4VktYD/hkda4Zt5cy7cns9AAPUYhZR10?=
 =?us-ascii?Q?E+iZ14xZqETJ9nT5nGsmmTefqejcfJlmDD/N037jTZfW+hcy3NPFoOqCzkOb?=
 =?us-ascii?Q?yzqCnYd6I4owyARtvRIQAxJmWf5QqAgFpTDp2M+UN8X+hM3wiSiQWg7myMZn?=
 =?us-ascii?Q?ffZ471dzOJgwKLmK+NUx0DwPHt+wwtdEmahzbIhpNlvcMXjJgexHWVfQYTaS?=
 =?us-ascii?Q?7tF8D4boTG3+MioDG9WmwXpRbxeh4Q1CF+GttM2B4c1gQNe1DiGi2MYy2vE+?=
 =?us-ascii?Q?QWS5ATrs1lo0iaCtSfsTkpJK/FRNnwN2rG9v20LWi4IxX1fPN0/bIi38pBbP?=
 =?us-ascii?Q?DAiosL5KA0AKFzhLl0ghlkq6TMGz8Z/N8SFsB8xXhfxIwRovuzDm9eDtDgds?=
 =?us-ascii?Q?wkhgR9sTW/VqKmie0o4kxYM/U62LooCCELsNTsuPKtbjM0JArZpsVTErwDCR?=
 =?us-ascii?Q?D44YUSpev1lxjxpryVZ3hL54BSBTA/O//jeN9cQiATekFpziWHYkgxLaxPdN?=
 =?us-ascii?Q?tq2/qU1stut5p/JGxbX34ennGEGWAJUWqNJFAzia0URF+yf8RwHqp8vFPWH5?=
 =?us-ascii?Q?/Ap3gSgJzQVnggxuE2WwegRo41mypdZClCHqLX+ruSKM/jrR7LEMP2aIUGWv?=
 =?us-ascii?Q?YFkpH5FVMiwkxh8uVG3iLy8w7crcnPTI46s2mfVadJ1JeXgf2XL9TEYmqj1C?=
 =?us-ascii?Q?/q40BrAnfMmT+ZT3lxxzQ+sElNwJ+gdCx90oeHLGWwXxq6+KCYrqEKCEMVoP?=
 =?us-ascii?Q?oX0SVNThv+npuAUG1co5IRmv3ZCE66aYOtZO16B/W5GV2AIwtbvOJiljJVxZ?=
 =?us-ascii?Q?NRj+HSyncvPoNc6DAlnZQp+EvC+PVv3+F+Q8Hsr57LWBJ2bgDMTOJ6BWO2Ef?=
 =?us-ascii?Q?B3JRbuG6uny+4JJYOm4VIKMIkhYo9shZXiVgE7wD9Qpva+Fwraehk0JwSrpS?=
 =?us-ascii?Q?qY69UX7yIJXz2qUDLUO1GA7yxrKxVs/fc0tEN4xf/UB0sWPMEdpriLdR9/EC?=
 =?us-ascii?Q?n/I8iCUWsKRf54W5ILZTGTQ3lZd8RfTzA0zoluWopoDxB29fJ6UgmsGY0CkC?=
 =?us-ascii?Q?2hcWZyX/XN67ZhlyTZQo1es7S2iSGnsX0ZOd2fO2ollEOoFxK8GhQPesXMwe?=
 =?us-ascii?Q?tplUfrqRCgrdJnDHM1J7sdBLu6/8pdx4CsEsFfr55CVpz6HdN5U7lGvEOSOS?=
 =?us-ascii?Q?M+s4EzNw/rb3KKUJWtczLBF1dTA9U5VGUVcpC4NP8zr4or2Q0CqV6C77Cu0B?=
 =?us-ascii?Q?Lwc4F6qarWdr5mfZeHznopl5dEB+zxhtov9bR0QmftzP+yJehmBa4hQrjfyr?=
 =?us-ascii?Q?T+uGrK9FO4sL7BwbBvm1SQMGZgzc4EL1cEBomVxydlKuCf7X0v9RufnzyBU2?=
 =?us-ascii?Q?mZuZpUAmSzN9IITatop9aBjCYehAPLFWvOWdKoJDWwBmZETdr52zlYScf4Mw?=
 =?us-ascii?Q?dj5KgF/T9LQ/M1AaBv5jOTqU2U+lgm8wjT0Xcy4VxfvveeHcEYMY2j/4K8uQ?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e260d2-e3b0-4317-5aa3-08db47cba8ed
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 09:33:44.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3R4r8ClnqEeX/a+Bf5WEboE1V2TCu2GZ7BS9eVaey+vxLJtuzHh4aCRXS890WC6liFVq2rMGmgHVQmWOl4NjNrantV9MiXoDckKhSNqv7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5415
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, 28 Apr 2023 10:26:18 +0200
schrieb "Wu, Xing Tong (DI FA CTR IPC CN PRC4)"
<XingTong.Wu@siemens.com>:

> Hi all
> 
> The chip id of NCT6116D is 0XD281, you can refer to
> NCT6116D_Datasheet_V1_0.pdf, Page 291

Thanks Xing Tong. I think we have come to agree that for now NCT6116D
0xD281 will not be supported in the kernel. Maybe until someone has
access to that very chip and a use-case.

But you managed to somehow get these datasheets, which are still not
publicly available. Maybe you can use your contacts at Nuvoton to
kindly ask them to publish those specs on their website for future
reference. Some specs are there, but not all. That would help people to
add more chips and avoid mistakes like they happened to me.

Henning

> BRS
> Xing Tong Wu
> 
> -----Original Message-----
> From: Simon Guinot <simon.guinot@sequanux.org>
> Sent: Friday, April 28, 2023 4:18 PM
> To: Schild, Henning (T CED SES-DE) <henning.schild@siemens.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski
> <brgl@bgdev.pl>; linux-gpio@vger.kernel.org;
> linux-kernel@vger.kernel.org; Hans de Goede <hdegoede@redhat.com>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Wu, Xing Tong
> (DI FA CTR IPC CN PRC4) <XingTong.Wu@siemens.com> Subject: Re: [PATCH
> v2 1/1] gpio-f7188x: fix chip name and pin count on Nuvoton chip
> 
> On Thu, Apr 27, 2023 at 05:20:55PM +0200, Henning Schild wrote:
> > In fact the device with chip id 0xD283 is called NCT6126D, and that
> > is the chip id the Nuvoton code was written for. Correct that name
> > to avoid confusion, because a NCT6116D in fact exists as well but
> > has another chip id, and is currently not supported.
> >
> > The look at the spec also revealed that GPIO group7 in fact has 8
> > pins, so correct the pin count in that group as well.
> >
> > Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton
> > NCT6116")
> > Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> 
> Acked-by: Simon Guinot <simon.guinot@sequanux.org>
> 
> > ---
> >  drivers/gpio/Kconfig       |  2 +-
> >  drivers/gpio/gpio-f7188x.c | 28 ++++++++++++++--------------
> >  2 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index
> > badbe0582318..14b655411aa0 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -879,7 +879,7 @@ config GPIO_F7188X
> >  help
> >    This option enables support for GPIOs found on Fintek Super-I/O
> >    chips F71869, F71869A, F71882FG, F71889F and F81866.
> > -  As well as Nuvoton Super-I/O chip NCT6116D.
> > +  As well as Nuvoton Super-I/O chip NCT6126D.
> >
> >    To compile this driver as a module, choose M here: the module
> > will be called f7188x-gpio.
> > diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> > index 9effa7769bef..f54ca5a1775e 100644
> > --- a/drivers/gpio/gpio-f7188x.c
> > +++ b/drivers/gpio/gpio-f7188x.c
> > @@ -48,7 +48,7 @@
> >  /*
> >   * Nuvoton devices.
> >   */
> > -#define SIO_NCT6116D_ID0xD283  /* NCT6116D chipset ID */
> > +#define SIO_NCT6126D_ID0xD283  /* NCT6126D chipset ID */
> >
> >  #define SIO_LD_GPIO_NUVOTON0x07/* GPIO logical device */
> >
> > @@ -62,7 +62,7 @@ enum chips {
> >  f81866,
> >  f81804,
> >  f81865,
> > -nct6116d,
> > +nct6126d,
> >  };
> >
> >  static const char * const f7188x_names[] = { @@ -74,7 +74,7 @@
> > static const char * const f7188x_names[] = {
> >  "f81866",
> >  "f81804",
> >  "f81865",
> > -"nct6116d",
> > +"nct6126d",
> >  };
> >
> >  struct f7188x_sio {
> > @@ -187,8 +187,8 @@ static int f7188x_gpio_set_config(struct
> > gpio_chip *chip, unsigned offset,
> >  /* Output mode register (0:open drain 1:push-pull). */  #define
> > f7188x_gpio_out_mode(base) ((base) + 3)
> >
> > -#define f7188x_gpio_dir_invert(type)((type) == nct6116d)
> > -#define f7188x_gpio_data_single(type)((type) == nct6116d)
> > +#define f7188x_gpio_dir_invert(type)((type) == nct6126d)
> > +#define f7188x_gpio_data_single(type)((type) == nct6126d)
> >
> >  static struct f7188x_gpio_bank f71869_gpio_bank[] = {
> >  F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"), @@ -274,7 +274,7 @@
> > static struct f7188x_gpio_bank f81865_gpio_bank[] = {
> >  F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),  };
> >
> > -static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
> > +static struct f7188x_gpio_bank nct6126d_gpio_bank[] = {
> >  F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
> >  F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
> >  F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"), @@ -282,7 +282,7 @@
> > static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
> >  F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
> >  F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
> >  F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> > -F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> > +F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
> >  };
> >
> >  static int f7188x_gpio_get_direction(struct gpio_chip *chip,
> > unsigned offset) @@ -490,9 +490,9 @@ static int
> > f7188x_gpio_probe(struct platform_device *pdev) data->nr_bank =
> > ARRAY_SIZE(f81865_gpio_bank); data->bank = f81865_gpio_bank;
> >  break;
> > -case nct6116d:
> > -data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
> > -data->bank = nct6116d_gpio_bank;
> > +case nct6126d:
> > +data->nr_bank = ARRAY_SIZE(nct6126d_gpio_bank);
> > +data->bank = nct6126d_gpio_bank;
> >  break;
> >  default:
> >  return -ENODEV;
> > @@ -559,9 +559,9 @@ static int __init f7188x_find(int addr, struct
> > f7188x_sio *sio) case SIO_F81865_ID:
> >  sio->type = f81865;
> >  break;
> > -case SIO_NCT6116D_ID:
> > +case SIO_NCT6126D_ID:
> >  sio->device = SIO_LD_GPIO_NUVOTON;
> > -sio->type = nct6116d;
> > +sio->type = nct6126d;
> >  break;
> >  default:
> >  pr_info("Unsupported Fintek device 0x%04x\n", devid); @@ -569,7
> > +569,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio
> > *sio) }
> >
> >  /* double check manufacturer where possible */
> > -if (sio->type != nct6116d) {
> > +if (sio->type != nct6126d) {
> >  manid = superio_inw(addr, SIO_FINTEK_MANID);
> >  if (manid != SIO_FINTEK_ID) {
> >  pr_debug("Not a Fintek device at 0x%08x\n", addr); @@ -581,7
> > +581,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio
> > *sio) err = 0;
> >
> >  pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned
> > int)addr); -if (sio->type != nct6116d)
> > +if (sio->type != nct6126d)
> >  pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
> >
> >  err:
> > --
> > 2.39.2  

