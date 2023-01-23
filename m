Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0776788A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjAWUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:49:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91132536;
        Mon, 23 Jan 2023 12:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSOD9BVaBcwJZmcNzw42Vb2Et3IBvAuUZc8tUgjsyxKmbs7DlwLIeUaMBiKpwaoQDnX+ERXXgTJ6rfcQlBsYiGYGsPmU/47vgWrUpySVUL6F73OoBr1QrOatj7VNG+JZFf5dYlunyoSYXh79olLickgg/cNfOfylwR7mbTIqOmHPZ1bW092KMiKRHvmDMNRM18JTiWyQRwxxS33AmM/O3nbNs9G0/qppwGY1FV/wnf3OGzFnOJlEEXcsNxpDscGCtRCmpdOSfAkcZZtAWb1a+miBESbLAsH9k03QeWwgZ82EQiqJyC/Cg+C6ZDZK87U/DVhz3N8j+dTbl1eskk+QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci9WdJzOEv5SEU9qHRw5jsq6WSG0XNAqTOwCTngD3Sg=;
 b=jw1jPMyacPhJ+60/WMJXHETwvSToRypo2eMo4rYju6AgxwdMvBJ+UbaSaAOVC07uV4CABmnszX7UI+C4EnxcP17MIXdmVmrzqOyT+TRm+qJSrYKwdDREGa9c1s6SV8mf4/rTjI1N2YD/BsmKCYM4DrsAlI8on4KQ1iw41c2csp08usRSGe0yHfInXA11Jm4512ws7qV+fj+/23cjEPLxb02kj8Oug4m7xjuUikzYpnB9izYibH53NTfVl93CMKmhRZWNE2LqML7adqe1MOTSZ0uuM8/LjY145u20TJuHXvHz8TVSE6rL2CowzK+utIbjlYLpmWsCy+DFzFJPGCixuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci9WdJzOEv5SEU9qHRw5jsq6WSG0XNAqTOwCTngD3Sg=;
 b=KmRVCmjxLmI+tJbAn8T8UqlWKiXQgfyGMvFiZMulN3kR6HsSXuhXU79Roxkp87bG3nSG3635iZZCmGZAHXpVe3G8g/pmD/KQMfLx41U9jzDnaxITxFrPAR6cbhfRXuT5y3RQmRiamDyxRwAbZw3n84sTNjdVLSCAN2fVTEjdSAuuTsGp4yb4OtS+n+Drfp6YUAzVkMKAWsp1Cz+mJDIPxslonLNmzyho8X7GkeKV5etCxwMO2SpThjd+jCqsVGbkU5nlX2VuRpexldROxbSSR4yQmDXlNKZ2xp2z39pGsaLXCZ8EG0kJ/8Z1waEyBXht40Gds4eLYcDKGHG6TwYCTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS4PR10MB5719.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 20:49:07 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 20:49:06 +0000
Date:   Mon, 23 Jan 2023 21:48:59 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y8mv8PzL1UsP9gNh@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
        <Y8mv8PzL1UsP9gNh@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS4PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c08e897-0615-4dde-b0de-08dafd83447a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0actJ+PcRSdfqtgYN401qVLdgwr7CNnUqczmIjVDBwiUm5xMeiDHmykrtoP4EWx5Oke/m7+3d520NqKJ6aBe5K7V0BPfEpMoMwjKvm3l+n0A3VXUrRNFQDgjYG4I6Uy4iNSuwstEDh12GMSZsjoRLl9MqCWtP18uOQLYs0gqSrMtyG64yV4WufrYtmOszPSDqfjFy+Yzw604wFCbXWRzprF224UJOYHpTFNZ5Ek37z8CnZkyVRK21kzscgfVyLQvRMhzz0DiL+Suo8Srozk+rLonzlJyzBqHazQqcCUaf6S+TURcR5EswIwLpCG27UX7y7sunX6s5NF2LCrwbz5UZpskSbWzagpjX8XYA4uuRrke5K8hi5R8HrhSz6DbvBmCnwxyA+bevzZdO4Eli4Y99mLgBIOUYDyBvCrFcauuepxt8vuFYatzM1ticNhR0bifjTLyOgv+0uU4nnWVxm/nnI6/W4vdCKycLNOhfQzv7JLIw+K/vHRkOsR+MhN2HzQjbaiycNDUz+E+yE4Dmv2ZmLspeH1HOg/yEpfxbrZquaBQMtW7As37UtyCr0XrIFNc0wBs5jBGX1sVnphkJsdvQ5KQf3gPIeLXgY8m+EqjjUpkgGQmsRqaIYYHxh8dB90cx6Kc3isJW0FLdVdwixfew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(86362001)(6512007)(186003)(6486002)(1076003)(6506007)(6666004)(478600001)(9686003)(316002)(66946007)(54906003)(4326008)(8676002)(66476007)(41300700001)(6916009)(66556008)(82960400001)(38100700002)(5660300002)(83380400001)(8936002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2uUE1s4WG1dU1DQ03fLeSiPDGJy/kTYhzO/7bkpE2jZd0AQnyMFYWbZXTUe?=
 =?us-ascii?Q?hOGAdzj2JyV0lPRb2LVRLuJkjSEtSQHS2SQUxUtXXc4R7bUhZZJbVLCnoLyY?=
 =?us-ascii?Q?dofKoEfs+ALhbb0ucZX5z3woG5iWKhVwloXwWjOVXGtzpVQ7DPJ2miaC61As?=
 =?us-ascii?Q?q0pNyaDKqUg3vT93dQJcqGME6R9kHjAsAsOliNn5y++1NLpHcukXr2TijyA0?=
 =?us-ascii?Q?keb2gULvL2bNJXyg+y1IXnow5BtL6QnrTW8QSJw2xb47Kn4tRxWkM2mXG/zo?=
 =?us-ascii?Q?QtgrqXxy+do+pCaef3i2K1DeR95EaaoWPGUH6SBqcuw5IrDtCOVYLHsSHdUn?=
 =?us-ascii?Q?+S6kzxtkbdLqwzKoHR8wv0mZ32dyJkEFD/7w6hxQvOk/CEdTHMWQwNiZun00?=
 =?us-ascii?Q?YnwvKH4uosFOIv1u+lVCH1xQ2bJfyq08oyTbF1qQpbrhD49E3N9vwcUBd2Hf?=
 =?us-ascii?Q?Xo6vrBXvHkyIddO1zEiDa7Z8zowvxOn56WsR16YL/GnuxrQy6AsuKN0ch2Hk?=
 =?us-ascii?Q?vuRZmJdIBcA6soueQEV3OmYEnPIL8mJbvQuX59xS9osGx9e4k+syyITE1VZI?=
 =?us-ascii?Q?DHc3F7ubcsYN3bbW1jRMGb9emWIYp1Gz4uxhWy5e4drt8hS38AOYaksTRaSz?=
 =?us-ascii?Q?aawesco4/zYncGcGUx0XnIf3XSAxu7drwpEpEKN3/gIqVhLVYVkCzz0WzF5j?=
 =?us-ascii?Q?nXvA5NVVrvBhGVoEBJhj/KcAfbDPLx+4FZDRwl4fP7YwkDWi3LeT04FjsJUH?=
 =?us-ascii?Q?8OdytK1zlaCEjgBKP0HiaanBKl3iv6AgnqjmM036AVjaBMTwwSQlKo2Wv/Rd?=
 =?us-ascii?Q?GaRnHPV3dm3P1Y0KDDfldfrGj0PEb46zV9/S7vqmpst3Jfpl2MS4VmpaBwh5?=
 =?us-ascii?Q?dCTZDjkdN/fAvVO/DYG+rSzV/iH7lFexeiIntFMtqzcpiGBd5sIW5oXJ3CPS?=
 =?us-ascii?Q?D84VIxtp0oQn5LBaivg7GgwRuGQ3h5QEvnOxR4xx0711kyXpn/Ped0Ou54PR?=
 =?us-ascii?Q?fVGv0YrfJ5pX9rgO4hEpWq2RtgTRwfqo7TZat021nuV24AeIEfgM+92sMX+Q?=
 =?us-ascii?Q?xoHQjaAs4fcDMdjaLGrwWDE/ZBge26c7yx06TLzFVSgMijyDEm2ctAPnS8EK?=
 =?us-ascii?Q?1hM08OcRqRLHmcv6gCQ+y1VSlqpKa1/j3odzuiHdg1/6nSLcxRJ22q4ir5OH?=
 =?us-ascii?Q?KkM8e6oHx52wWHpMIWiXnxWu/EtiE7eqT/20Ota9HBXeJu89kVSc6khWNfnk?=
 =?us-ascii?Q?6OQ8Fmy+AoutxXtdTmDfO3iph6ueVyXPd4UU4Auj4AsGCFBJVqOlnTRVD7fE?=
 =?us-ascii?Q?Rd0NV0e+TlmUrRXuCsq6lGFsqCkU+mnVydCFcmftJ62Pa2ydojV7LmrRJ/ra?=
 =?us-ascii?Q?vwmYv4ojdikfnqRI4PUy/HHIdZEr/9sq20MuzCFdoq/rDPFfMuIJeTKUM9s5?=
 =?us-ascii?Q?E6lIYmp5soqZLSXLJSD4h3QYNjGydyVRdI1JjaZmW0PyDH+QNgS4buK5S5Mr?=
 =?us-ascii?Q?ud/R/5YyfkfGezD0Q3tMe6vctn9Vr3AwzLaC7XjZaEuOn1355xrAtDITt6Xk?=
 =?us-ascii?Q?P/nFaq0PXPRoVtgDqINYnDfXD+uPcJ4W3L9QaVr2TVrNvpZ+GCpbB5DbZO7b?=
 =?us-ascii?Q?QWtS6Sx9xyQWHZ7NCsBBmuX6sjd4spQ0Ey4JJA7IlggZ/E5wCBAGgnQz1Luy?=
 =?us-ascii?Q?M2m29w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c08e897-0615-4dde-b0de-08dafd83447a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 20:49:05.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+UBNCbri3abmlaHQWwvyufiWG+iem1oUuxYa2fmICkxA/YvrKK0Bof7/D1tZCZUN2hposkT7OFbIAZ1cyJRFvoqHONifCdgjd5/xfFIX5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5719
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 19 Jan 2023 21:02:40 +0000
schrieb Lee Jones <lee@kernel.org>:

> On Fri, 07 Oct 2022, Henning Schild wrote:
> 
> > If we register a "leds-gpio" platform device for GPIO pins that do
> > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > later. If there is no driver to provide that pin we will poll
> > forever and also create a lot of log messages.
> > 
> > So check if that GPIO driver is configured, if so it will come up
> > eventually. If not, we exit our probe function early and do not even
> > bother registering the "leds-gpio". This method was chosen over
> > "Kconfig depends" since this way we can add support for more
> > devices and GPIO backends more easily without "depends":ing on all
> > GPIO backends.
> > 
> > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > of Siemens driver") Reviewed-by: Andy Shevchenko
> > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > <henning.schild@siemens.com> ---
> >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> >  1 file changed, 2 insertions(+)  
> 
> FYI: I'm going to try my best not to take another one like this.

understood!

> Please try to improve the whole situation for you next submission.

When i have to touch this again, which i will, i will propose either
"depend on all possible GPIO drivers" or introduce "#ifdef CONFIG"s.
Caring most about big configs as seen in distros like debian, even for
embedded systems ... i think i would prefer the first option, as it
will also be easier to maintain.

I do not see the whole infinite loop story on my plate, but if that got
fixed i would follow up taking the fix into account.

> Applied, thanks.

Thanks!

Henning

> 

