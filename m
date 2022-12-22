Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B11653E27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiLVKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiLVKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:19:28 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7664EB;
        Thu, 22 Dec 2022 02:19:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haAsPu/eTfDk3KqU6ScZyJHYISruW/VebPkzckNEIAR/0mafbtkt+JGzpgeqK6FeOR93qfrwMn4PpaEusEOQz6KSXTd4pJFIPqMtUE4KooEm/o0FOCt/t4sv1fEDpYp7wwsAPcuxpXyaTojzmVGYkl2XqtSy3UnIYdNWmc81jms1q5kY25U89HHOCSkFtDvc2g2YhgKusFUUxHHa1wN1LZ2o5hkb6dZUHpPRo+Gqn/ZVWq8WNZRzptJGkKkh4Y6lcwgqYbZ7GgrVp7P62Uy3A8gXOGj8+g9cJPbGNpMZhw3hwlxqrIUReXYTL5Z+hzzZFC8XKYmpqnxoOi6CCNmgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtad1o3P6PsmehLd1gCa9TEyyygWIxjD4EiplB/sYU4=;
 b=F9aZLxOdTzoHdv3CdyHhsub9Et4PJ3Ep/CmNoZ5VJLRyIdtjq96cSRciohpPFu5y4KSq6K7j2F7Tur1ILxdWj/exDyKUYg06v8ACu2Dy+peUGuL/A8F6JG8rLow8EciQ4W1eqPyFfbkZWVkuQkbl5pR1kWBzBof+qDJWndbh/jNEyM1FEcmW9P9q9o8zijbuBeRBrPlen6bfngBzWWUsGcMEqKmxS7jUN0UsoL/j0a++XDv1iItA5R73xUv2vN+Br75DqzoB/YYZBKxDyOkpJ0vPdFP0UKR2m3OBq0H7wLFekcwncVRjuvbqbczFe6BhVfZA1PAlwqQ3j6Tv7lpwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtad1o3P6PsmehLd1gCa9TEyyygWIxjD4EiplB/sYU4=;
 b=sz0bgVbCUfkk/fXfl8XDU5KjSEMyCQwnDDoyTFh/rI+rly12Wj7bTkurbO+PlbO9lyNnu3jkagtW/Hs9Q5LEQM5URxR5+BGJBgIkbBJBneR2kpZM8fOKMmxLG86MAcKa5mt64HVMHiteFtEK5t6ek8Q+4FlohG1AYlanDTazlx/CtCBQSfAwlI6Ee1rk1x0v8sfINLpbwd/vrwT2xlPhkeJa822/WfSOiAulo7ILEXuhnBrgqHGYXcuGaIrg5jJzc0QuQ6szvcMXBhIO44A+mndk9WcVWZISwohh8E2tmFqH2aGU55ouvh4pvbS9k7zcPciHVUbMfy6MNYCehjevAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB7075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 10:19:24 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 10:19:24 +0000
Date:   Thu, 22 Dec 2022 11:19:15 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <20221222111915.2e08bb46@md1za8fc.ad001.siemens.net>
In-Reply-To: <20221007153323.1326-1-henning.schild@siemens.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610::30)
 To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 851c2ab0-e160-4aea-ad1c-08dae405ffec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zEYUfZN7xlXofvSZq3miFEbFKX0e4j8g+7PTYSk8sIPXMHrOrhLK0R3JSvKqBnOKrokzeo1Vz0Y18E1bZsR8lxKUvxIsI6Ncsqp3ZwpM1uTOe7CihONXEhcAAVXPel6p9130ZCrJT879ejRKNI3jpxGxQ/NdlUmS2BvuEtUtH0a43SfV6bkhUWkh9TZhBX7CgGUkBgyFZrLi9Yd4How0bn6mPPxwPeJh72OM/mXO6RsPjj6d/8ASaDbV48CZLsfQz9RcEMdEK+arUiUyDNj8OF6J5hpwJaUhfk1wJvZw7v+P4+i9jZhTopC4k2fwNcXH8OCavXEu90UHOtKQHWIrQZGAV1Gnv583Ry7v5DI9v/cL+AN83HayFyN3U5ECPtC7aoBe8y30m3kzZCgr6zqxwtNgyflbo4IR+9SHiwFNZZn9mJKw4ALvHubOgXU0KyAGG9DIqb04dryL7CHcEVd97yt13++EELv5iyVVIAFDNiZlOeQ3tpZX723dEV1tH6/tugZ87jgdw4f/QtOayO6LvUMB+BIhCmxCfR7weHOhOiWOgNtMG8ZxeKtRyxwOAu99fXcQjbn84nXUoumyvQaSZDowkJfFeBhyPafBHjyRz/UBjFqmz93nKQW4zph9erXnJeu5FWyal2Qux9PjcPJdNFX/NOSIaocPfr4TlgXz9DCtmUg2Ha6sPcy7ECPfvUu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(110136005)(5660300002)(478600001)(4326008)(66476007)(38100700002)(41300700001)(83380400001)(66946007)(8936002)(82960400001)(66556008)(6666004)(44832011)(6486002)(6506007)(8676002)(1076003)(186003)(6512007)(26005)(86362001)(316002)(2906002)(9686003)(2101003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Jo7b2z/sqGov0Z7T5PRoMTbTEq9i4poxG/fSzDPF3TnDj9SR4nshD/LDQvW?=
 =?us-ascii?Q?Ji2H930zZdeqtHDzf9PgiadZlGwqWpNW4hE4XESM8IkWdpqs/2C9NqdDqEcM?=
 =?us-ascii?Q?l933/PpfQGU7cC0Z6JDmUkJR+gxllH3xZkMH6HJ7yukehe+eDH7wSn3mbKVU?=
 =?us-ascii?Q?+cXA/uCAToh9rlTF4mqN84T7BgfHBAKcHEj1KdT0iPBKYJFyRYzahnwRySzm?=
 =?us-ascii?Q?oAB7MLjBn+b1uuEZyh5UhdOHF7XJ5IXMfbKUOO3z+hFL7c4YNfFVnKzpnFz+?=
 =?us-ascii?Q?/BHXZA06mEJkSGSAf8QTzpaeFJVD4+0LCRt8w1EOPLC029Kz08r46qG0DR3e?=
 =?us-ascii?Q?ZLs62vq+1voUsE0pleILBJAqYM36ZQSAd7YOD8u0fy1un1aUcnhwHCvCcsSH?=
 =?us-ascii?Q?CKTecC3eo2i8+fKcCmmjh7Cytz62yHCpkIoWx9Str9e9kFEBBJS4wCzP7/Zp?=
 =?us-ascii?Q?Hfjh7CXA3dy+El0OKp6pRj89zVDKLVfwW41ybUaZ4lf851AvHo5C9oBVC8En?=
 =?us-ascii?Q?0mpBe5dtNCyE0JtSsLx99WYNBFLy2XIQbFz3TDk4mXU4MV7REwQh5o72JNgJ?=
 =?us-ascii?Q?0t/HJK7gWdEpzXcEi/Ic41BthUUBY3ykKFrEZ4WniRwCqTqAjX1Xry5ROAjK?=
 =?us-ascii?Q?H5MriNQ3XQLPYTQfZcxf0h2J00nSD7/0azy2KVD5uGnXlbzRjo6+xwVXceTD?=
 =?us-ascii?Q?DvHr9pPjrXctZ8+DakWzJJ4kb0/EL/XL2aWJpVwEnVZ/etrdjhtW5Fvh2LJs?=
 =?us-ascii?Q?Rh/iWIutZSDulE9EXdze+uy+iotj/jzS5GlIXCj3BS0D3s//H/mQc/TYIL2h?=
 =?us-ascii?Q?feiq3eZPP27kgT37UYnd3Ir/XK2q9Bw1RKZQ38FUvgw+kTYg6AfwCW2uD3VB?=
 =?us-ascii?Q?bo8NgzryZssYWmzjt7ykbLFuInprl169fFjDX79UraBYtHn7h5ASEfWndL+/?=
 =?us-ascii?Q?31Mz09YtuVOO63LAQJ2iazO6mWaZkakwJ+NdYsjxlwr2uyl+mO1dyTaGU/jh?=
 =?us-ascii?Q?76Z6/JGEBstNJRBk4I4SP5sGx+vnUpKanVyTgaa9nKLPZCpdK0ZoyUgAaP0t?=
 =?us-ascii?Q?tP23+ompGDX2C5YwucVBpaKW45PMlDXhywQ+yFY+lfXbJ6VTLkrNOTf33WAP?=
 =?us-ascii?Q?RUwDvJ5YEJ9K6ehzqoL3tiAlJ36Odw6cpGFfv3C9urm3pa0lJLw5hkgmOOlm?=
 =?us-ascii?Q?mEkJ3P+HYbfZJeCiJjYiKXW0CchFSoS/pEXspNxH0/if36dQHAP7svVt8YXu?=
 =?us-ascii?Q?gydFwybxOnXk2J69HY8lwGy2/Ub0AkVROIvM6jnb8gxvBZZXrOqlsT0f92Ql?=
 =?us-ascii?Q?IZk16bTnzQCf8TvbjFR/7YVH08G9sRWx8eEKriWJc3QnIc4gWMDMan7FXMEN?=
 =?us-ascii?Q?NpEcl/cRUPGUhMnPtcnUYukbyitsAU6kn5DZuuGGqZXmfcKDsfGewN7yUwNr?=
 =?us-ascii?Q?EUpyO9s3LEXRJ7DBJTJx1X53anTrtWa893OzVuK7eRPjFBgt4+vD2P1hcld2?=
 =?us-ascii?Q?X9TE8d3OZfSdjcuQNiIHTSrAGYOHOFFZlV+S7nDoBPDL863YmUpA9nU1PHN1?=
 =?us-ascii?Q?07uhWNKeRamUimWX3CRGSHI8UQdzV+GIlWaevGRm4ByHs93mVoigjWDuaraN?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c2ab0-e160-4aea-ad1c-08dae405ffec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 10:19:24.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5LaDLuATecobLyVsTpd+yeOpB3BFRb/vuNJKa2dKs9jyYqR/3P6tNmhj29MIf6O4dIHe1FC7LtRO0ZTPn0J2vfIrrzGydx3bbW6J5NWfuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7075
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. This still applies and still is relevant. Maybe got lost or stuck
in the LED subsystem.

Henning

Am Fri, 7 Oct 2022 17:33:23 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is no driver to provide that pin we will poll forever and
> also create a lot of log messages.
> 
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not, we exit our probe function early and do not even
> bother registering the "leds-gpio". This method was chosen over
> "Kconfig depends" since this way we can add support for more devices
> and GPIO backends more easily without "depends":ing on all GPIO
> backends.
> 
> Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> of Siemens driver") Reviewed-by: Andy Shevchenko
> <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> <henning.schild@siemens.com> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> b9eeb8702df0..fb8d427837db 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -77,6 +77,8 @@
> static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev) 
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_127E:
> +		if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> +			return -ENODEV;
>  		simatic_ipc_led_gpio_table =
> &simatic_ipc_led_gpio_table_127e; break;
>  	case SIMATIC_IPC_DEVICE_227G:

