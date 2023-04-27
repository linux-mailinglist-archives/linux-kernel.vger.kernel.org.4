Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7D6F0B49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbjD0Rpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbjD0Rpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:45:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84502BE;
        Thu, 27 Apr 2023 10:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9HER4crHxPI8ivLS+ldYpsFVB+7b0i5WAbBVH0kgyOEQFTulTOhzLCGUcmH1zzv0/S574Ikz9GBuQ9OLgWiDHQ8zKCBGJz24zfn7CX+Rc9WOhkRPXbCBvmXTJXXfhZCvXcfrU1OSae+NA9Yg4CxiZyjUq+o+8WNM8IEOYmfCUEgKDLEv45ypMhjSyT6cldMt0XMWZrDkrVPwU++gBojynItMvQPg3Ftn538mIQi8ZuJw962J9FtnVG2Q+axz9lFy6U61majpd5Zh6KH8PBL/cMGIzYLAjK50zEsvBdRwXDoM6O+leYSDhuM07Mz0FBy32OMTYDRE8M+Ft74xECppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcbA6Kp73+hDC5NQv7cOQXolkZMIF1jhy9P1ERFYbUw=;
 b=fX/oeseGQvL+9vWYGRu8OCMg3D/7Ci45amRj4otJqAyKAZcaN0wNH0js5RUeOIf7LyYO7Nbk5V7uG47XQeHRh9m2GurdgaB2aU363W/ItWa8SvEUwflZDldb9XDZwJQJhqfdvp95o7PVaAEN28NrG4gtpYgd3RjwvbJzHzvkOQG61efOrBY2JU8CAeNFgVh7UqHIu9lUIvjYU8GKV8X9hEL8lypJaY/dWVKtJQZLDDTFWHIyFiFVG/Zgval947AtRA6JycIsZpD4NzoE+41/SLta8D/fw7fKaQ5LHvK+5JU49gD/8r0lWnUBk0h1mIckEizlddgUmeK4EC0ORgvQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcbA6Kp73+hDC5NQv7cOQXolkZMIF1jhy9P1ERFYbUw=;
 b=PLau0EJAlaZPEoX+zq234H+I8E9IVSpCdIrqXoVhNDkE1io1eJSyL6vV3kMsKWNksaVlrZmf/M++c3gWMvk+ZdkjaDsH+pdcvGz/9kJPGNBQR1P2JwE+9+JGNlSvySTlZQanl8lmRRqEC+FlxyqCHAEe4I4JkPeeZgNbHLPoLHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB7930.namprd08.prod.outlook.com
 (2603:10b6:a03:40d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Thu, 27 Apr
 2023 17:45:31 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 17:45:31 +0000
Date:   Thu, 27 Apr 2023 12:45:25 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        phone-devel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Message-ID: <ZEq0taaQFT1znDN6@nixie71>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <ZEpWrWpzkI9kNTkr@duo.ucw.cz>
 <de87d6ae-3449-5581-3e17-4aae72e8197a@wolfvision.net>
 <ZEp1Z08/CQ+waw8+@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEp1Z08/CQ+waw8+@duo.ucw.cz>
X-ClientProxiedBy: DS7PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::10) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: e142c4de-3297-42d2-78ba-08db4747324c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX4PkdSLfDx1yNcD30pk20WxqStSA1g2SQiWfdT8WWuLJ4eGD9I1SUyxBpvLTa+8W9EBRLPT4bk6saTKzbLqSjOsuX5Yd5dqow+arBqMXHhGqmf28urB1xLiMkoSA/VotTYjF2vhs7NbyfGLS9xMsj4SQ0mEBM3IrqLH2ZyvxX99DHQScrPsXi2KIRMuzSvqRBdgCee0kkaFu81R+OYW2+bcyz1w2lm0JFlEDaI/CnVgnsAez9vQsN7Orv8datQoYvfiVj+9x8OTtbkEElBbTVJtRgnvXWPt+v+ZhXGgqdoitdHpXSJfuIOouo77rtnLtkJsnf9JMn2hOlqA+6VZ7PBZJ90MHJnWSaO3yCUezd3TrfmFW5n0KOYiimi5Cr1wWC024HnU1nTT6u6HSy33fM/wiHUTofA9dTEda07xGqkzBTzbgUgE9xdKigVFSx/niUoKNm2sYUqMa7dzabKHQjxzowjvQ826P+BQbsh55BEbC93OAEEvzn67/06Jv11jkeazPg7tL9nKRFL9YARExo7KS4Tfpc0KmclY/udS0mXiTEXqcsZJLAF/CwpbnW98
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(39830400003)(366004)(376002)(451199021)(6512007)(9686003)(26005)(186003)(86362001)(5660300002)(33716001)(6486002)(6666004)(6506007)(66899021)(8936002)(8676002)(54906003)(41300700001)(316002)(2906002)(38100700002)(66476007)(4326008)(6916009)(66946007)(478600001)(7416002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jEI7hytQpfc9+O8ZZ6Si6bu1+m8GTH0S9WppGU3NT4mg83jdY50irry4+ZWb?=
 =?us-ascii?Q?GwYqDjrRoDMhwz/g5KJIuXX5B1xzZkdd/hd36w7iVL7tG1Oz/9xygvFBuJw6?=
 =?us-ascii?Q?ap2rVszEb4+3+i8xr/4ZbIeg53aDc0S3ne/IuN57UKHCk72bXJUN/zHIcFZ6?=
 =?us-ascii?Q?SuE9oEOxIVc/0w33uJPaluB1Cez63PVQR8xdCiuGo2TkRA+VtHx1tVsErJMR?=
 =?us-ascii?Q?eA0RqgCICO5O2haiwTFUmp75a9MYJozUnvFEyZckWJxoaO2NgNRsviR/JEWn?=
 =?us-ascii?Q?XAeFaYIpxvWy7lT0dQy7r7N44JyPtlQeqF9HCReZyrbnrkfkYwlUb+zPPmcn?=
 =?us-ascii?Q?9GoYI6+coNkYy6eo9VN0bxwLjryJ0HyvTmgBIc0h2JlgfhTJahZE5YaxlDyT?=
 =?us-ascii?Q?Hr72pWPg9YfA3TtJq1Jixh6ppB6l6mOJNnw5aq8GtdM/+CrbtFG5RDQaAFz6?=
 =?us-ascii?Q?+hTz4ApGuKxF2/uoX3Ez4kWQMjy6NihkAQELbBqxn/eVYcNWKXYabEo0Z+RB?=
 =?us-ascii?Q?ni9+Dg6+KgL/xrIiJUr5HZmaH3DMFnA1PZa1HVwZAfTI9vd7flx6llk3EI8n?=
 =?us-ascii?Q?iCHhVh//rwEwUWj8zvn0MPpbIe+GHGvHNgiyPfvBiIBVAjcKolLhrSuRXWqt?=
 =?us-ascii?Q?5J7w+4Td8n07dYIvo3LK4rDoi0DEUw9uGb3coNOXIvdFamj1xKAW1GvDjWX9?=
 =?us-ascii?Q?3UWk8WTWUEV0zmokOIGDrQre8GxctsOQbKQWRTZHHDErWD9xLgLCpyzHmtqU?=
 =?us-ascii?Q?Z0b/80W7LbUFmuP1CYx1A6VmpVPZKRlBKlTIn6P3YNQtUrMOVD1dAK6uNa6n?=
 =?us-ascii?Q?Fj7EB+hG3pjgcTmOcZkqpz+pBL5xDIK6VSidu1ATYs02C86eQZKji89S0BMl?=
 =?us-ascii?Q?7ZNIr5Gn9RwKsmJ4KuP4kiwZw/adyLnUErH8dH+a/tlCvhJt8oX6g+sNuZc9?=
 =?us-ascii?Q?3lxjoAVz+zxPozTnfYppO/QE78qiJr9dyiucXMQI0Gml+WALXxzDpE7mgzSA?=
 =?us-ascii?Q?WRD9WPPpyZ62BUlc4xhkHAUWXwE8DfOoja+qekpKaUamcB5t+QOwtFrnvwl7?=
 =?us-ascii?Q?lWIbkcaeTo3CLW2jmmQcBXIfQuBbpH0kwAlc7m7u1i6BUAlE5H9CaGW9yPtR?=
 =?us-ascii?Q?65XewM5pLe8YBz4+BsCnZ8jlOQiOs02TgoSIAOv+gGxzSJjg42Z6pf2TyE4b?=
 =?us-ascii?Q?xuTPZZcHye8pGSY4GxcJcb9Rd9AG39c+u3xrAdktk4HPm+BAT0hVfwlgPZVB?=
 =?us-ascii?Q?+JmKIdnwmS2d0pK0zf3JMrhaJuPd2sBmcuEVmBna0gpLt0TdhURKVI62DtAm?=
 =?us-ascii?Q?vEKOqTcQoRvcknl7zfJAiVuejTeg4WHBJ++iCKALK0XBbPuBJv9VDIuP1s8i?=
 =?us-ascii?Q?5HyfQGrO21wrkWvhUlFIrvw3HPn2gxPYzqKmSd8p7yBJIYcTyXZzqARnRmG9?=
 =?us-ascii?Q?x4aE4B9yOIhqTaM1x69uQ9pIZkA77wrntroqwjNqRR0D/HOaKYxVeEx9WpIJ?=
 =?us-ascii?Q?VIeZDYD8hZZ8CDw+YkBBWSKx724S6qg34Qo98mf+B9Re4vJoKcGPTw7KSmxp?=
 =?us-ascii?Q?QDnGDs4gBhO1ag31PEqYCitfhKmzOgdwctWRWqkF?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e142c4de-3297-42d2-78ba-08db4747324c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:45:31.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYXcA31vRgyOOx1mO8t2HdXIJEnSuMTKEdBSOi5RsL2ceII6ueLOtjmOjHQqKMMSZt2XdBH7+iPaAzz7fBM/2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Thu, Apr 27, 2023 at 03:15:19PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > 
> > >> Some touchscreens are shipped with a physical layer on top of them where
> > >> a number of buttons and a resized touchscreen surface might be
> > >> available.
> > > 
> > > Yes, it is quite comon, for example Motorola Droid 4 has 4 virtual
> > > buttons below touchscreen.
> > 
> > Are those buttons configurable in some way? Or do they have a fixed purpose?
> 
> Fixed.
> 
> > How does Android handle those buttons, BTW?
> 
> No idea.
> 
> > > One question is if this should be handled inside the kernel. It will
> > > make it compatible with existing software, but it will also reduce
> > > flexibility.

That's a great question; I think there are arguments for both.

On one hand, we generally want the kernel to be responsible for nothing more
than handing off the raw coordinate and touch information to user space. Any
further translation of that represents policy which would not belong here.

On the other hand, the notion of what buttons exist and where is very much a
hardware statement for the use-case targeted by this RFC. It would be ideal
if both the kernel and user space did not need to know information about the
same piece of hardware. So I think it is OK for the driver to give some help
by doing some of its own interpretation, much like some hardware-accelerated
solutions already do.

While there are obviously exceptions in either case, I don't see any reason
to prohibit having a simple option like this in the kernel, especially since
it doesn't preclude having something in user space for more advanced cases.

> > 
> > I would say that it should be described in device tree if the purpose is
> > fixed. For example, if there is no display behind the touch screen at a
> > certain point but a printed sheet (e.g., with a home or return symbol)
> > then it is clear that this button is not going to change. In such a case
> > I doubt that flexibility is required.
> 
> I agree it should be in the device tree.
> 
> AFAICT hardware can do drags between the buttons, and drag between the
> buttons and touchscreen. Turning it into buttons prevents that.
> 
> Plus, real buttons can do simultaneous presses on all of them,
> touchscreens will have problems with that.

I interpreted the RFC and its example to accommodate multitouch support, so
I don't see any problem here unless the vendor built such a module without
a multitouch panel which would not make sense. Let me know in case I have
misunderstood the concern.

> 
> Best regards,
> 								Pavel
> -- 
> People of Russia, stop Putin before his war on Ukraine escalates.

Kind regards,
Jeff LaBundy
