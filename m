Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1E709BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjESQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjESQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:01:12 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62887128
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1684512068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Pp+s0IAHv7KJLq0c5Z4Kp2qnR79p9ts2eYQ+COyKfk=;
        b=jLFpO8DVZzSJ/v/UMxROyEcmPGuB/tQ1u3ka9fD27YQAGdP+SSz7Ul4P2bPHaldMD8p3nj
        J9wL1as0YfmFGtI3wKONcVO7uP/eRGPWlUSSSLyrZ/OqA9A1DFoADhvexrPWXjBD9lsYCW
        IdSz1AUoPjomvxt5WjGyRFhxFwWl/nA=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2059.outbound.protection.outlook.com [104.47.20.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-82-WGTnFhefOZSrs2lRJl8m7A-1; Fri, 19 May 2023 17:00:58 +0100
X-MC-Unique: WGTnFhefOZSrs2lRJl8m7A-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LOYP123MB3183.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 16:00:56 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:00:56 +0000
Message-ID: <849ac3f6-82e6-fb9e-a693-b78edd3e5f2b@camlingroup.com>
Date:   Fri, 19 May 2023 18:00:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 2/2] serial: sc16is7xx: fix regression with GPIO
 configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518132905.4182265-1-hugo@hugovil.com>
 <20230518132905.4182265-2-hugo@hugovil.com>
 <3a8cf0e2-b11c-d2f3-081e-a43bdad66224@camlingroup.com>
 <20230519093031.9c35c8ee5387e1fc4bdf79f1@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230519093031.9c35c8ee5387e1fc4bdf79f1@hugovil.com>
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LOYP123MB3183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea399af-22ea-4d80-eb00-08db58823ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: SQc+kpGcCr+Rd+foY3fxTHJUnzFgIHJgZb1aIPpnkUQIiGDisDU4FO4stzEzNlJ4Qb4MQsRkfrIAyqck2ogZufLA9U/CvjoVsMj5EinEdr3KPTVpl7YqW/FQYnFbGf/R2I78wZ8I5v6guWCm5NnCH9621vHCpNZ5jN3PWQ/Lrlc51DmtIqrOuFF3mKjhWxDJT6SxyKaDENIepOrDvma1UoiTc7RgEkl/bv2FMp6k+ESvTw3cfct7MGW+MqavLeqQodaZRs8tTJkrT4jPaIuLuWMNuYR/98EUEy6M9iy2ty8GX/Bscs4oqG0V8m+Wu3fnClPRUI2YxZoIZ14rxczbK4Lt4yn8ip/y1PBrSDbm7e9VSJwqHz00HV08UWrJ/iGimXGgtnLW4QfVEwJ0A4GYow5X7r/ohP12xqcOoW7sSqhxvo7zXbcnvoTYTNKkIVHvcqxQ3kgpKZnA3JgWUBqIprfFL+jGBxc62QqeCrNSDuTQp68z5TX5qUvcvD6kWwBXwZoVMsDyb/qwA7yOHG9nZ5Irj0/P5F2ZzFB4r8FHz/thGBRAJ5fA5+qv+zJqCAa/FtTPTSeMyqgN6UWwM8BJ17JTsNp2bK/HZ0fO5jH6ko6lAwPquO4BLs94Y2g1srCiSUmwTVvPML/9RJ9uYHdz6/pquxNxSjSxzUr/sJs3ow0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(396003)(376002)(136003)(366004)(451199021)(31686004)(4326008)(966005)(6916009)(66476007)(478600001)(66556008)(66946007)(54906003)(316002)(31696002)(36756003)(86362001)(83380400001)(26005)(186003)(6506007)(6512007)(2616005)(5660300002)(8676002)(8936002)(44832011)(2906002)(6486002)(41300700001)(38100700002)(43740500002)(45980500001)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/pERAR+T/xtR9TXF5oiI81T+tp/H/fMC2WohfpaYWkvhsB5BKcloj1Ebzw5W?=
 =?us-ascii?Q?faYE1Bg/HZSawaPOPJvyO0Dz5lMmmUeKAWvfmazjvNbI8e0ai1Pn3OtPw+fq?=
 =?us-ascii?Q?jl5xQolyqBSZ77D8f0m3h98vJTZWsHbFb4wFfESlQ1szE008fiYBDH/zYHNR?=
 =?us-ascii?Q?i5EYJZI7e9m63Ia8UM6ALHc6ZqcTwev+YeA8kvmLa6kbDw1MYKybD96C63RK?=
 =?us-ascii?Q?FwlE8/BTLiV9yHYVh29znobSUNlAmb3G2hBRL7Mwkx2Ha+9eLR28CvWF7w1k?=
 =?us-ascii?Q?6NUBqXwDHZoMOjYhVhMiT7ryMzVpoy/bUnMejNjVsxwyy6QlBCS8WkHmkhCr?=
 =?us-ascii?Q?PPOw+OXcTxk8MOt+tnH4uZxVpJ8Vha3W21W8SPItSzr+p4F204KJpIqRPPhx?=
 =?us-ascii?Q?6mW2Stf06jE38lzvmesKdm8Uk3DjWsQ5OmJNDQ6NJKt51a1f4rIvq2Dpeo6L?=
 =?us-ascii?Q?BN7ovq4rKRLQspYA8dFR4SjLNzeceb3wXPh34PpwH2eD/BNN+aOYKq6UQj+N?=
 =?us-ascii?Q?tnS3vx921Ea/SZO3fR5JknZ4iqdh+pwXuyjXtZvmNx937y8i91wD2jABIYIh?=
 =?us-ascii?Q?8DvxZkk9B1qdI4K8ad5upbDIXX9zKr3UUKlUToe4bRCzbAtJWlhs+NWHEXGi?=
 =?us-ascii?Q?/6GBWNnBzjMK22GMrfRGhhDLiLZLtKfk0yoq6OxbF4Ud1indhc1uMTSNZFju?=
 =?us-ascii?Q?zsbLQltobZ+xyuvczoJkN3PvPDsNpMGim6JBu/6sOlf1/rY3N+thdYMNfNIf?=
 =?us-ascii?Q?Rhnj0BFeQX0kTJPO7qsKcq5nGYHOKj9pODt/cRIkqcrc31qkBhl3m2dYf5R8?=
 =?us-ascii?Q?4fxcNoxLXm6n5wvWeFDhsy3oVZq6YpOSIgzXvPV/cTYaHUHlpjkqrS01w8VZ?=
 =?us-ascii?Q?sv8A+xMOJG0EprEQp/7TdTk91b3FN/BZu7SCDioKut2156u4u9j3PedRFrLK?=
 =?us-ascii?Q?sbWUqmfYRz0thcTDihNak9IhRRZlFlgTVn9tLSW94fgsLv/UmhqTN6exUO/x?=
 =?us-ascii?Q?ueT0ZhR4AkQeys7Zn4/LtneczSecGc8OucA0TZbejGAu6RPm0ykMoCI8L2xF?=
 =?us-ascii?Q?NXz0YIjNsAAq7g8whaF8Pj2Pymvtx7Z2Mpf1xBMYiBmbb6GIM0xpxvPY2V67?=
 =?us-ascii?Q?cKqBNxjMQMD0HDDt9yI1C3mtJO/qb57b5o9DhORuMkj87xytpqGNBrhYenuh?=
 =?us-ascii?Q?mWGf6IvCYlakM2Ge5edVK63XlVQ5fOBduiIqir/llaDj47+Co8zD5D/BAosr?=
 =?us-ascii?Q?5wGKTTSr5dceazC+enRkzgg9yVM/JlVxjNxtpR1DogH6cpXdr5LMXwtuqU/U?=
 =?us-ascii?Q?G8ZNHsz0v9MY8NBpelNcgcVeJV1kgRkTExqm6YOOyZxA+ZpkK2WJr9Z7jlBm?=
 =?us-ascii?Q?08GBgIlarQdo7TVCSlYhVOVR9wIbgwyLTHgLgAWrrWg1KqvHCijAy5LTuZv3?=
 =?us-ascii?Q?/WLY9eB8nVyJEzm67hOWgBoTD+TMNFB6p/KMhg4uJiYoLUNokPHK5Yb0whGk?=
 =?us-ascii?Q?jbLM1uosN2HatKzFKfcSWlatVGV+8HdFwuUhRCSEeuDJjhiMae81rEc1J2MA?=
 =?us-ascii?Q?HMLWfCEZglekLxQqXiwSP/PjAo43+Uz3vgydTS3a0xwj3tLHswPjveg2G0jt?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea399af-22ea-4d80-eb00-08db58823ae4
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:00:56.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tKwoV29L5mXrYTusLHh4jUYwuJHeOvtA8+B0hT/bkQ8moMI4OcHhJHVl4Spvh5i6/vSmW49m2z+BDOjjkO8hhP0WeKHXpxjkQfmrtbBUVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3183
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


W dniu 19.05.2023 o=C2=A015:30, Hugo Villeneuve pisze:
> On Fri, 19 May 2023 15:00:58 +0200
> Lech Perczak <lech.perczak@camlingroup.com> wrote:
>
>> Hello Hugo,
>>
>> A couple of remarks inline.
>>
>> W dniu 18.05.2023 o 15:29, Hugo Villeneuve pisze:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control line=
s")
>>> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
>>> changed the function of the GPIOs pins to act as modem control
>>> lines without any possibility of selecting GPIO function.
>>>
>>> As a consequence, applications that depends on GPIO lines configured
>>> by default as GPIO pins no longer work as expected.
>>>
>>> Also, the change to select modem control lines function was done only
>>> for channel A of dual UART variants (752/762). This was not documented
>>> in the log message.
>>>
>>> This new patch allows to specify GPIO or modem control line function
>>> in the device tree, and for each of the ports (A or B).
>>>
>>> This is done by using the new device-tree property named
>>> "modem-control-line-ports" (property added in separate patch).
>>>
>>> Boards that need to have GPIOS configured as modem control lines
>>> should add that property to their device tree. Here is a list of
>>> boards using the sc16is7xx driver in their device tree and that may
>>> need to be modified:
>>>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>>>     mips/boot/dts/ingenic/cu1830-neo.dts
>>>     mips/boot/dts/ingenic/cu1000-neo.dts
>>>
>>> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control line=
s")
>>> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>> v1 -> v2: Rebase because original patch did not apply properly
>>>           Add git base-commit
>>>
>>>  drivers/tty/serial/sc16is7xx.c | 42 ++++++++++++++++++++--------------
>>>  1 file changed, 25 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
>>> index abad091baeea..4e3d2325ef6e 100644
>>> --- a/drivers/tty/serial/sc16is7xx.c
>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>> @@ -236,7 +236,8 @@
>>>
>>>  /* IOControl register bits (Only 750/760) */
>>>  #define SC16IS7XX_IOCONTROL_LATCH_BIT  (1 << 0) /* Enable input latchi=
ng */
>>> -#define SC16IS7XX_IOCONTROL_MODEM_BIT  (1 << 1) /* Enable GPIO[7:4] as=
 modem pins */
>>> +#define SC16IS7XX_IOCONTROL_MODEM_A_BIT        (1 << 1) /* Enable GPIO=
[7:4] as modem A pins */
>>> +#define SC16IS7XX_IOCONTROL_MODEM_B_BIT        (1 << 2) /* Enable GPIO=
[3:0] as modem B pins */
>>>  #define SC16IS7XX_IOCONTROL_SRESET_BIT (1 << 3) /* Software Reset */
>>>
>>>  /* EFCR register bits */
>>> @@ -306,7 +307,6 @@ struct sc16is7xx_devtype {
>>>         char    name[10];
>>>         int     nr_gpio;
>>>         int     nr_uart;
>>> -       int     has_mctrl;
>>>  };
>>>
>>>  #define SC16IS7XX_RECONF_MD            (1 << 0)
>>> @@ -447,35 +447,30 @@ static const struct sc16is7xx_devtype sc16is74x_d=
evtype =3D {
>>>         .name           =3D "SC16IS74X",
>>>         .nr_gpio        =3D 0,
>>>         .nr_uart        =3D 1,
>>> -       .has_mctrl      =3D 0,
>>>  };
>>>
>>>  static const struct sc16is7xx_devtype sc16is750_devtype =3D {
>>>         .name           =3D "SC16IS750",
>>> -       .nr_gpio        =3D 4,
>>> +       .nr_gpio        =3D 8,
>>>         .nr_uart        =3D 1,
>>> -       .has_mctrl      =3D 1,
>>>  };
>>>
>>>  static const struct sc16is7xx_devtype sc16is752_devtype =3D {
>>>         .name           =3D "SC16IS752",
>>> -       .nr_gpio        =3D 0,
>>> +       .nr_gpio        =3D 8,
>>>         .nr_uart        =3D 2,
>>> -       .has_mctrl      =3D 1,
>>>  };
>>>
>>>  static const struct sc16is7xx_devtype sc16is760_devtype =3D {
>>>         .name           =3D "SC16IS760",
>>> -       .nr_gpio        =3D 4,
>>> +       .nr_gpio        =3D 8,
>>>         .nr_uart        =3D 1,
>>> -       .has_mctrl      =3D 1,
>>>  };
>>>
>>>  static const struct sc16is7xx_devtype sc16is762_devtype =3D {
>>>         .name           =3D "SC16IS762",
>>> -       .nr_gpio        =3D 0,
>>> +       .nr_gpio        =3D 8,
>>>         .nr_uart        =3D 2,
>>> -       .has_mctrl      =3D 1,
>>>  };
>>>
>>>  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int=
 reg)
>>> @@ -1456,12 +1451,6 @@ static int sc16is7xx_probe(struct device *dev,
>>>                                      SC16IS7XX_EFCR_RXDISABLE_BIT |
>>>                                      SC16IS7XX_EFCR_TXDISABLE_BIT);
>>>
>>> -               /* Use GPIO lines as modem status registers */
>>> -               if (devtype->has_mctrl)
>>> -                       sc16is7xx_port_write(&s->p[i].port,
>>> -                                            SC16IS7XX_IOCONTROL_REG,
>>> -                                            SC16IS7XX_IOCONTROL_MODEM_=
BIT);
>>> -
>>>                 /* Initialize kthread work structs */
>>>                 kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
>>>                 kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc=
);
>>> @@ -1497,6 +1486,25 @@ static int sc16is7xx_probe(struct device *dev,
>>>                                          prop, p, u)
>>>                         if (u < devtype->nr_uart)
>>>                                 s->p[u].irda_mode =3D true;
>>> +
>>> +               val =3D 0;
>>> +
>>> +               of_property_for_each_u32(dev->of_node, "nxp,modem-contr=
ol-line-ports",
>>> +                                        prop, p, u)
>> The general idea looks solid to me.
>> I think, that with this property set, we should also reduce number of GP=
IOs exported by gpiochip.
> OK, I will look into that.
>
>>> +                       if (u < devtype->nr_uart) {
>>> +                               /* Use GPIO lines as modem control line=
s */
>>> +                               if (u =3D=3D 0)
>>> +                                       val |=3D SC16IS7XX_IOCONTROL_MO=
DEM_A_BIT;
>>> +                               else if (u =3D=3D 1)
>>> +                                       val |=3D SC16IS7XX_IOCONTROL_MO=
DEM_B_BIT;
>>> +                       }
>>> +
>>> +               if (val)
>>> +                       regmap_update_bits(
>>> +                               s->regmap,
>>> +                               SC16IS7XX_IOCONTROL_REG << SC16IS7XX_RE=
G_SHIFT,
>>> +                               SC16IS7XX_IOCONTROL_MODEM_A_BIT |
>>> +                               SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
>> I just had a chance to test this on my hardware (with SC16IS760), and so=
mething still doesn't work.
>> When looking into /sys/kernel/debug/regmap/<device>/registers,
>> it seems like the proper bits are set, also taking the regmap shift into=
 account.
>> For reference - I did my test basing on v6.4-rc2.
>>
>> I used a loopback plug and statserial to perform the test.
>> Without your patch, when DTR is set, all other pins (DCD, DSR, RI) are s=
et. With it - they are cleared, according to statserial.
> It is strange, because the only conceptual change is the moment in time w=
hen we set the IOControl register. Before, IOControl was set within the for=
/loop for initializing each port. Now it is done after.
>
> Maybe you could try to put the section that reads the DT property just af=
ter resetting the device.
>
> While suggesting this, I just noticed that when the device is reset, we d=
o not wait before initiating communication with the device. Thefore, I woul=
d suggest the following change (that I will submit as a separate patch):
>
>         regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_=
SHIFT,
>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
>
> +       /* After reset, the host must wait at least 3us before initializi=
ng a
> +        * communication with the device: */
> +       usleep_range(3, 5);
>
> Then like I said, insert the code that read the modem-control-line-port D=
T property right after that to see if it helps.
>
> Hugo.

Hello,

I tried those suggestions, together with the patch you mentioned in the oth=
er email - all to no avail.
I added a debug print to confirm, that the property is detected, and regmap=
 access is executed - and it is. This is so strange.
Maybe the offsets in regmap are still wrong, for some reason?
I also double checked if it was possible to alter and check GPIO states thr=
ough GPIO subsystem - it is.

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

