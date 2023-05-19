Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3037097E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjESNBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:01:23 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA1D3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1684501275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGWrr6tPjsNEmNEJDedXsdITYAHgXv6ME1TpI5iusdA=;
        b=DJV6JVCjNN6Uy54KRAqq71zEhvg30IMRExAr9vBv8/u8N6Ya4Rq1QsRRmduFmeU4UAV5G7
        9vSC/TewPufqUaL6e5JrQ59Je7Wm1N6kIxSZjQlOTXbIvx5Vs9nWtIEVvOguPkpt52qspW
        wuJyapfDYT88FxJ27J1KmH8MX9tUS0s=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2052.outbound.protection.outlook.com [104.47.20.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-317-amOO_usBN1qxs3KuROUdow-1; Fri, 19 May 2023 14:01:05 +0100
X-MC-Unique: amOO_usBN1qxs3KuROUdow-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWLP123MB6858.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:01:01 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 13:01:01 +0000
Message-ID: <3a8cf0e2-b11c-d2f3-081e-a43bdad66224@camlingroup.com>
Date:   Fri, 19 May 2023 15:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/2] serial: sc16is7xx: fix regression with GPIO
 configuration
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
CC:     linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518132905.4182265-1-hugo@hugovil.com>
 <20230518132905.4182265-2-hugo@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230518132905.4182265-2-hugo@hugovil.com>
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWLP123MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: d921dd76-a0d3-4a9d-4db7-08db58691880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 8W8AWFYGYc9gHAjKaXpTuYb0g8cd8giCmNnNEOyWxSu66cFDNT4/lsBQbBYFda0o49uWFPvRtwWh3BPCl3Rn///9aMyjxW6FyB+C7T8IBiIYgitwbCGB9rv0pAvnuQ+uJvd1BnjzR6s7vi7rwQV7Tk6r8g9iVtQSQYd6Cw7yOOAtO6Q+k7qrEuNPSQFCj6ros+WzKAGBI0Ha8n+sFMknaXZCnVW1Tz91UUb43M/soN6zgAPHl8r9QSN0TD+IxOGVnuTc65q8BknKQ0PWicKEk/jxAKlS1skXYBx7FqpieYL7AUzDKmYyrHJ1WqnGM/bEhDp4v2oU3tcCizpKVd7bDB1evYiYQXLs6kS5iYNS1yJ6LffIQ6wXnoU8iXSNzQr+49xqxv3I/sgCh3D2oKrufVAPSNQtHiZC8wkwK6QT4g0y6fRNDd/DzZwf43Sx27re2yyk0YQns/8txuFo9+nj9EiFfRnjywICzWPF87in1+NkJBETotW2iHuzqpRkoVF1Q0Lpmd9K/7hirpcdqBebrpQ2+Fd6iwSMwPKmJ22sLY8j8uS5R/sA3m53BIGpGjlOmogBX/tGFZxee29qpF3gJpYWj9AseEgmG5FU5euKqeei1AQbghnlIcr3c5P4315+KpVxoBRCPuCQOibMZGdyJ1mBe8HhjpyJ6xYhrPTsD1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39850400004)(346002)(366004)(451199021)(966005)(6666004)(6486002)(38100700002)(186003)(26005)(6512007)(6506007)(2616005)(83380400001)(36756003)(2906002)(66476007)(66556008)(66946007)(4326008)(6636002)(316002)(86362001)(8676002)(8936002)(31686004)(44832011)(5660300002)(31696002)(41300700001)(110136005)(478600001)(45980500001)(43740500002)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3O+Ucf2qqJGSSW91Qkgr14czQ6GBJWJvO2HpO8rUiMNTkMargmQLl1vCoMEB?=
 =?us-ascii?Q?OzFPUVCYaZ5tVz6qVVKYWJYyfx909yhjEfG87rvt35T+B725VqrToF/RlWtw?=
 =?us-ascii?Q?RRt02UgkVUpkH9aE+Rb/jZc+3vpMA3e9IrihHiMw/q4/BIS/xrZv3aWPYRWL?=
 =?us-ascii?Q?YuF0d+dDYqNH1FxV8pbAkpZyuW6AWni3T1nhyFB8/WVTDgEhyxKvG2WfUOth?=
 =?us-ascii?Q?C9fHruQmKrvXebhff5y5AbODQCgLOrvf9alE1HL2WN6KE5rLR8d0XRvlkblW?=
 =?us-ascii?Q?ljnlyymMFl8+9PCAwz/a4eDSgtHEZIrj+4YVlo0eWXPuJTsuD3A4g6Q3+z2q?=
 =?us-ascii?Q?HKQjLsA6x/O5wK+qPZckHC4FJEJSTSxrLfAthsK+HpWByqyaX5KB4ZedxyLo?=
 =?us-ascii?Q?6W7uQuCbgMJrqHHKq7hSYBSXmUxjYH8oXeBLSfdXFUNd+uaqVwAetfbCr4+C?=
 =?us-ascii?Q?ow7E+P1tfYCANe+3lMedcSMjHenXFbu48c1sHPSoPnoppxScXG7jWCnEHbZC?=
 =?us-ascii?Q?aWrSZWQb3zCWVjlbzwCfHnvDMPNoaSyOlmE7JbVw59ZSooDj6BJuC6A+aouP?=
 =?us-ascii?Q?Xg/Fo6y0aW2AdWzO75b99NDy1TEakUKBRHX/2Bsp2MVj8xVyO11d0S9xeezl?=
 =?us-ascii?Q?EZ3lKj9Ep8H3eUJhggEG4CJY2vQNt+durHmlL5Acb4nUFON4SK/94qQ1MkVu?=
 =?us-ascii?Q?lUizwzKGYHp1wx18zySMWphJq3ZcEYg+i+rHCmF+vIIwGRykp4pUchsEKAOW?=
 =?us-ascii?Q?bVvKU9Um+Euk3fnri0TDM7rV1x26GzN4AqyeyaVG92vm5CTQ0BKxi1DO0UfO?=
 =?us-ascii?Q?siNhp5H2+MyBdOTSKRoh2k/5VY3puGyNdkgS08GerEwI6sJ3ICa04f9ymfSa?=
 =?us-ascii?Q?79UAEHSNDnaGnIt3chEDTLJyL45LEueyfGMcERgq8q6YiFNukRB7Ah8yKvct?=
 =?us-ascii?Q?cgdWJ1AEhxFNbOPb/JhEGvDwuVFd8N82hVobnZOGqBujZKWK3wtjiVS/lmus?=
 =?us-ascii?Q?4JL+wY6y5tYai9ZSRFWdelrc3TRFc3kftF2Fw7e+cGYG3rS4dn0IScq+Elgx?=
 =?us-ascii?Q?KeINVvTTB9ovJaYBZ6dxktESNOA3HO+HCHYA3uoCctu2GDxDwclBZti4G1fl?=
 =?us-ascii?Q?9jhqW2ipxzpojLMEQzcs7EmP2RwF9UFnIhhacUpKRw378h8rl5vL0cdRQwPq?=
 =?us-ascii?Q?+hYKaWCY8n1AqqG/wdPqoE5fvgy/UQGCwOsUotsmyHKhkqiZve/k2GrMTreZ?=
 =?us-ascii?Q?E5CtZIY0F3WutuMqFdoQd8ZDDsk2SPXUPVKZolLz/2hrpZCbJJe4FoY97ir3?=
 =?us-ascii?Q?We7GyyJKjt2eNlRj31hsmkbcp0ThC4nGh5EknsvUAlBVas9nXWyivx/o4ST+?=
 =?us-ascii?Q?PJPX/cwjB0B1uIvxaRo/Gh7k0SuxzBUIkU5qJErbjQWrVnk8QWndDWMslMl4?=
 =?us-ascii?Q?Nya+pfNvP4u+AHcM6HjX7LlGKV3sBt86N2UjlCz4kIrBoX0xBwsePc8tAEjA?=
 =?us-ascii?Q?Aduwnf4ShWrhvgALgpc7g6pms8k94tfCcBsCYeuoDAX6SxDBfkOOnm00gn8c?=
 =?us-ascii?Q?/WtDjD+koCt/dpKyhDbLVaA+sO3EKv/WSHiofZnOaXkt9IXHZq8zUeCWchCt?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d921dd76-a0d3-4a9d-4db7-08db58691880
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 13:01:01.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXcMXdruKkhZEzkLK9W3PEFJ3zMZTqRtdAz/DVUESvcsVHZhN4O3GNXXUtczM+JP095l2AWHbx+GmjEU7ll/I7OKZpen75SQCwkXoeplKPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6858
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hugo,

A couple of remarks inline.

W dniu 18.05.2023 o=C2=A015:29, Hugo Villeneuve pisze:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines"=
)
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.
>
> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
>
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.
>
> This new patch allows to specify GPIO or modem control line function
> in the device tree, and for each of the ports (A or B).
>
> This is done by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).
>
> Boards that need to have GPIOS configured as modem control lines
> should add that property to their device tree. Here is a list of
> boards using the sc16is7xx driver in their device tree and that may
> need to be modified:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts
>
> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines"=
)
> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> v1 -> v2: Rebase because original patch did not apply properly
>           Add git base-commit
>
>  drivers/tty/serial/sc16is7xx.c | 42 ++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index abad091baeea..4e3d2325ef6e 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -236,7 +236,8 @@
>
>  /* IOControl register bits (Only 750/760) */
>  #define SC16IS7XX_IOCONTROL_LATCH_BIT  (1 << 0) /* Enable input latching=
 */
> -#define SC16IS7XX_IOCONTROL_MODEM_BIT  (1 << 1) /* Enable GPIO[7:4] as m=
odem pins */
> +#define SC16IS7XX_IOCONTROL_MODEM_A_BIT        (1 << 1) /* Enable GPIO[7=
:4] as modem A pins */
> +#define SC16IS7XX_IOCONTROL_MODEM_B_BIT        (1 << 2) /* Enable GPIO[3=
:0] as modem B pins */
>  #define SC16IS7XX_IOCONTROL_SRESET_BIT (1 << 3) /* Software Reset */
>
>  /* EFCR register bits */
> @@ -306,7 +307,6 @@ struct sc16is7xx_devtype {
>         char    name[10];
>         int     nr_gpio;
>         int     nr_uart;
> -       int     has_mctrl;
>  };
>
>  #define SC16IS7XX_RECONF_MD            (1 << 0)
> @@ -447,35 +447,30 @@ static const struct sc16is7xx_devtype sc16is74x_dev=
type =3D {
>         .name           =3D "SC16IS74X",
>         .nr_gpio        =3D 0,
>         .nr_uart        =3D 1,
> -       .has_mctrl      =3D 0,
>  };
>
>  static const struct sc16is7xx_devtype sc16is750_devtype =3D {
>         .name           =3D "SC16IS750",
> -       .nr_gpio        =3D 4,
> +       .nr_gpio        =3D 8,
>         .nr_uart        =3D 1,
> -       .has_mctrl      =3D 1,
>  };
>
>  static const struct sc16is7xx_devtype sc16is752_devtype =3D {
>         .name           =3D "SC16IS752",
> -       .nr_gpio        =3D 0,
> +       .nr_gpio        =3D 8,
>         .nr_uart        =3D 2,
> -       .has_mctrl      =3D 1,
>  };
>
>  static const struct sc16is7xx_devtype sc16is760_devtype =3D {
>         .name           =3D "SC16IS760",
> -       .nr_gpio        =3D 4,
> +       .nr_gpio        =3D 8,
>         .nr_uart        =3D 1,
> -       .has_mctrl      =3D 1,
>  };
>
>  static const struct sc16is7xx_devtype sc16is762_devtype =3D {
>         .name           =3D "SC16IS762",
> -       .nr_gpio        =3D 0,
> +       .nr_gpio        =3D 8,
>         .nr_uart        =3D 2,
> -       .has_mctrl      =3D 1,
>  };
>
>  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int r=
eg)
> @@ -1456,12 +1451,6 @@ static int sc16is7xx_probe(struct device *dev,
>                                      SC16IS7XX_EFCR_RXDISABLE_BIT |
>                                      SC16IS7XX_EFCR_TXDISABLE_BIT);
>
> -               /* Use GPIO lines as modem status registers */
> -               if (devtype->has_mctrl)
> -                       sc16is7xx_port_write(&s->p[i].port,
> -                                            SC16IS7XX_IOCONTROL_REG,
> -                                            SC16IS7XX_IOCONTROL_MODEM_BI=
T);
> -
>                 /* Initialize kthread work structs */
>                 kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
>                 kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
> @@ -1497,6 +1486,25 @@ static int sc16is7xx_probe(struct device *dev,
>                                          prop, p, u)
>                         if (u < devtype->nr_uart)
>                                 s->p[u].irda_mode =3D true;
> +
> +               val =3D 0;
> +
> +               of_property_for_each_u32(dev->of_node, "nxp,modem-control=
-line-ports",
> +                                        prop, p, u)
The general idea looks solid to me.
I think, that with this property set, we should also reduce number of GPIOs=
 exported by gpiochip.
> +                       if (u < devtype->nr_uart) {
> +                               /* Use GPIO lines as modem control lines =
*/
> +                               if (u =3D=3D 0)
> +                                       val |=3D SC16IS7XX_IOCONTROL_MODE=
M_A_BIT;
> +                               else if (u =3D=3D 1)
> +                                       val |=3D SC16IS7XX_IOCONTROL_MODE=
M_B_BIT;
> +                       }
> +
> +               if (val)
> +                       regmap_update_bits(
> +                               s->regmap,
> +                               SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_=
SHIFT,
> +                               SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> +                               SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
I just had a chance to test this on my hardware (with SC16IS760), and somet=
hing still doesn't work.
When looking into /sys/kernel/debug/regmap/<device>/registers,
it seems like the proper bits are set, also taking the regmap shift into ac=
count.
For reference - I did my test basing on v6.4-rc2.

I used a loopback plug and statserial to perform the test.
Without your patch, when DTR is set, all other pins (DCD, DSR, RI) are set.=
 With it - they are cleared, according to statserial.
>         }
>
>  #ifdef CONFIG_GPIOLIB
> --
> 2.30.2
>
>
--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

