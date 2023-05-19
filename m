Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7D709D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjESQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjESQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:56:26 -0400
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3C18F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1684515374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WG1RSR0Nrjlzr6FoHjRybr7SldwgPZKFpLsc5RhlBB0=;
        b=f0czjStSUJrgA0R0t1KvZDOqIY4HC+UGg2MIotlNGvJr7pOLU2uBH90cT2J3e6naPtkKCY
        wi6m71wQ6H6CeRxgsAdB8CTIKW5VkDt36Kfe91JblO7e6OYJ5gBZBLvQsrHLWIh7dNJOZp
        2d67HuK4cDvaPDyYT2UA2dWuM+/o39Q=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-184-2-xVVEZDOcWxnd01Ga3-OA-2; Fri, 19 May 2023 17:56:04 +0100
X-MC-Unique: 2-xVVEZDOcWxnd01Ga3-OA-2
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO3P123MB3001.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 16:56:03 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6c38:e856:880a:704f%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:56:03 +0000
Message-ID: <a83b8550-6a1e-f156-2eb8-e6b62d87c425@camlingroup.com>
Date:   Fri, 19 May 2023 18:56:00 +0200
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
 <849ac3f6-82e6-fb9e-a693-b78edd3e5f2b@camlingroup.com>
 <20230519123801.e1123cab701b6cb0ffbf367f@hugovil.com>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <20230519123801.e1123cab701b6cb0ffbf367f@hugovil.com>
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO3P123MB3001:EE_
X-MS-Office365-Filtering-Correlation-Id: e8189a55-2e8a-4870-8eaa-08db5889edeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: b4bsXPtHEdzZb/B289bDCJBdtlwTU86Mu4tpmuDwpXREPVQdZ68BuuNZTUouKQFp2IA5cgwMbQrxDXHQKCrt90i+TmRlKlPwT8GtOKykBxrxPn1lrjFyZ5LdxCJZpUYPPDdfexzAQ5blj/OxmGSOTSCRnNpTqZ34bMfeQaxr53d/iFK7hcAQvfc0iW2hulhPFNM+jMAyOwlrmJ/vDfNFQeceUkiOfQSEbSqDk7op4YtTA/Lcx00kQmu0+LldTr31219HY2c6tDkdBbz+V5rhs7LxBi3FRjmFH2Xojn9m78B+GrR5SpLhijfLbIntEXNigrFuNljF6xzIfkrx70MGreIjyon2sHYR9cLb3IJjmtwTbN2FwNBaOpPfd1CePfNwa9+11mSYEijhRbH6L61WOty1F3Ld91HfaFtf5jrA6jntr4qEHPG4hlyosmLjs8BAnkyWcOVWSwSaZhIyqRJ7u9eR05Z3B4OxVsX8BOBiIEBbgKaGxJ7xtgntEuQ63mIW00BDKA30Hl5roWGsN48NOf06++OImMg7B2iwVfzWo0jeT1TMAsbkvgVvFPQ4q9NBZKtJU6p0v2CzyoAVIFUKkk3HVtIgbenlBP8VnSlLPX0maAO5BXl1NNAd8ruUT/QQUCIgQ1a4s3z5+U5q6faRd+sSayZ8w3Z80oHdjrg1ZCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39850400004)(346002)(396003)(366004)(451199021)(86362001)(31696002)(2906002)(36756003)(8676002)(8936002)(26005)(44832011)(6506007)(2616005)(6512007)(186003)(5660300002)(54906003)(66946007)(316002)(6916009)(966005)(66556008)(66476007)(41300700001)(478600001)(38100700002)(4326008)(6486002)(83380400001)(31686004)(43740500002)(45980500001)(18886065003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?maEVPCJg8XKjsgmdU4abjoZjVMrsDdkXO3ax9Ds+jBRWR1n7r3xq3TvKJSdq?=
 =?us-ascii?Q?ON9CZqgotj/g0W7BgWEZhDyzYViLLyaFV//Pu1h25Nbzcb0zT0tEvhNo4hZG?=
 =?us-ascii?Q?7b1aoSDPp8ewALoPYjVfsYK3uHYzgZ386cx2HXu1CIhPGo5WldKY9MyfC5tr?=
 =?us-ascii?Q?nJxIfG/bNdOQJPsG+z0ukxHP6tdfmN40VsfGou+nx78qlwif7NAU00Ipo4hK?=
 =?us-ascii?Q?4/O5Vy42jeGsJChjbLFCpbAxo0/9PRRuvheMnanSz+imtipBaFCLqNEC7wQC?=
 =?us-ascii?Q?yCTZkAVIELOzUiTLH0dKLxi4GkEEsU05dgKZk6rEb1sJ6pGhwnoCsgBSQAUA?=
 =?us-ascii?Q?NI1VnUzlIVeXcakbRPIJuz36x49PGIG4y5kmxCDAv15lCRv/cv1XxIxXEHEl?=
 =?us-ascii?Q?L7cY3bP93UPMJ6q8hDpZA5NNgNHuQVdqABvLlojSdyI2wQYTtjumsTFIs3z8?=
 =?us-ascii?Q?E/S+LSdH6uyj++mvFn5qdv/D2tL/a3iqO3Cg46E9jf3BCGhN4dKvso+w5kyq?=
 =?us-ascii?Q?8U5C/rbxXc3Ktr6fB/7FwDwlEup4YYUQvVBYtNpwBuE8aawNSLfKgSDMY6Em?=
 =?us-ascii?Q?YEA6m+IYJ+z9oTaDXujJyvKoXF5wROrbru9DplN42O0532j6AfPTQcsVNJlx?=
 =?us-ascii?Q?l/XZhM0N5WP8VEoYQgXfbVHO1kh8PdMejPouH3OTXexWQpRYtyxUSkvAetjY?=
 =?us-ascii?Q?Et8Mxgzej3i/Wf8jueYcsOVAC0IFEVmQx4wOEjaNg0mL6/4+nkL90XMvjETA?=
 =?us-ascii?Q?og2zspBwpnOCYF39luRHAuNm8KfBLV3Aq0g/drvYfq+qbxi8gdpKTt4E0UQ/?=
 =?us-ascii?Q?ch95KnXxB6ebzNw0FKA0zxDw/DslyRokDMKXUvZZe6v8dprOJjgj+KwDkCkV?=
 =?us-ascii?Q?T3/0z+FrAIfMrEy3J9YTw9FToCud3nXIiuExSXS92+Ok29ShojCI8uR96wzP?=
 =?us-ascii?Q?i47B7GMxhb/VNPpSAiR6lczPvvzkWaShpF11Ol4xO2HT3IcxP0A4lTUALjAf?=
 =?us-ascii?Q?apA2hxI5H9bATSQUDZMtJ5QEbYWE3DPORJMXs7nwArcpi9Bkmh7nQITIOTBj?=
 =?us-ascii?Q?LbF3JkJnmy/eMZmeLyBIip3SFE32b29mh8N4aJcMOqjKHOVIUD3Vlfqsq9qq?=
 =?us-ascii?Q?b0DZpwvZORTEesipZO9gwcqSNOkAP1DDpAaH9O/dWEXBjcLq9kLL8IE3Y3fG?=
 =?us-ascii?Q?3qx1FgLaIkB7Dhp0uhbmbeboprQzQWmEQKBwYwJ+5nZVmdzGXbOiiTRAz/zB?=
 =?us-ascii?Q?soHHAZ3tcy+BdwZEPNfuRAivUN6iv+Zj/CN6BrV0LeIltIWgwfNwGyTOn5io?=
 =?us-ascii?Q?qpeRw7q4etl9j8za2cPNxcvX6qkNqfarnS/9RS2B0a9HjnOZ9qUfP2m30BAE?=
 =?us-ascii?Q?zGQ7rbSvtKleQU0C0iM92tk8GAJ8bxNIJfyaEbhQ4XthwORMNZ+XbtgRsssL?=
 =?us-ascii?Q?r0y+oGB0dI0MGpyOOTi6GIGVXtjP70aGijEG8UIhUsBap3sZZVVyFXvRE9cX?=
 =?us-ascii?Q?lnk2CWNuhT6O7r1N/Q7FIiwlTmYlNuyF67uZ3oi4l/chiIGjEWpdUoPxedlU?=
 =?us-ascii?Q?08BOneEjbGWGpz6JC61/N262G07oMQ5Ba/aiN3oBZJxl2JHxjPJJue917v4l?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8189a55-2e8a-4870-8eaa-08db5889edeb
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:56:03.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgZC1aj6B4oQNNJxSYZJAasHYLcyWKxrfxHawtVFWJgbdNhm1oREug8p+NKyrilnc2GcxL5VoshxFqJ/zyvoazhtMpkabGbSJ8Fhq0kpy44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3001
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


W dniu 19.05.2023 o=C2=A018:38, Hugo Villeneuve pisze:
> On Fri, 19 May 2023 18:00:54 +0200
> Lech Perczak <lech.perczak@camlingroup.com> wrote:
>
>> W dniu 19.05.2023 o 15:30, Hugo Villeneuve pisze:
>>> On Fri, 19 May 2023 15:00:58 +0200
>>> Lech Perczak <lech.perczak@camlingroup.com> wrote:
>>>
>>>> Hello Hugo,
>>>>
>>>> A couple of remarks inline.
>>>>
>>>> W dniu 18.05.2023 o 15:29, Hugo Villeneuve pisze:
>>>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>>>
>>>>> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control li=
nes")
>>>>> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
>>>>> changed the function of the GPIOs pins to act as modem control
>>>>> lines without any possibility of selecting GPIO function.
>>>>>
>>>>> As a consequence, applications that depends on GPIO lines configured
>>>>> by default as GPIO pins no longer work as expected.
>>>>>
>>>>> Also, the change to select modem control lines function was done only
>>>>> for channel A of dual UART variants (752/762). This was not documente=
d
>>>>> in the log message.
>>>>>
>>>>> This new patch allows to specify GPIO or modem control line function
>>>>> in the device tree, and for each of the ports (A or B).
>>>>>
>>>>> This is done by using the new device-tree property named
>>>>> "modem-control-line-ports" (property added in separate patch).
>>>>>
>>>>> Boards that need to have GPIOS configured as modem control lines
>>>>> should add that property to their device tree. Here is a list of
>>>>> boards using the sc16is7xx driver in their device tree and that may
>>>>> need to be modified:
>>>>>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>>>>>     mips/boot/dts/ingenic/cu1830-neo.dts
>>>>>     mips/boot/dts/ingenic/cu1000-neo.dts
>>>>>
>>>>> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control li=
nes")
>>>>> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
>>>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>>> ---
>>>>> v1 -> v2: Rebase because original patch did not apply properly
>>>>>           Add git base-commit
>>>>>
>>>>>  drivers/tty/serial/sc16is7xx.c | 42 ++++++++++++++++++++------------=
--
>>>>>  1 file changed, 25 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16=
is7xx.c
>>>>> index abad091baeea..4e3d2325ef6e 100644
>>>>> --- a/drivers/tty/serial/sc16is7xx.c
>>>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>>>> @@ -236,7 +236,8 @@
>>>>>
>>>>>  /* IOControl register bits (Only 750/760) */
>>>>>  #define SC16IS7XX_IOCONTROL_LATCH_BIT  (1 << 0) /* Enable input latc=
hing */
>>>>> -#define SC16IS7XX_IOCONTROL_MODEM_BIT  (1 << 1) /* Enable GPIO[7:4] =
as modem pins */
>>>>> +#define SC16IS7XX_IOCONTROL_MODEM_A_BIT        (1 << 1) /* Enable GP=
IO[7:4] as modem A pins */
>>>>> +#define SC16IS7XX_IOCONTROL_MODEM_B_BIT        (1 << 2) /* Enable GP=
IO[3:0] as modem B pins */
>>>>>  #define SC16IS7XX_IOCONTROL_SRESET_BIT (1 << 3) /* Software Reset */
>>>>>
>>>>>  /* EFCR register bits */
>>>>> @@ -306,7 +307,6 @@ struct sc16is7xx_devtype {
>>>>>         char    name[10];
>>>>>         int     nr_gpio;
>>>>>         int     nr_uart;
>>>>> -       int     has_mctrl;
>>>>>  };
>>>>>
>>>>>  #define SC16IS7XX_RECONF_MD            (1 << 0)
>>>>> @@ -447,35 +447,30 @@ static const struct sc16is7xx_devtype sc16is74x=
_devtype =3D {
>>>>>         .name           =3D "SC16IS74X",
>>>>>         .nr_gpio        =3D 0,
>>>>>         .nr_uart        =3D 1,
>>>>> -       .has_mctrl      =3D 0,
>>>>>  };
>>>>>
>>>>>  static const struct sc16is7xx_devtype sc16is750_devtype =3D {
>>>>>         .name           =3D "SC16IS750",
>>>>> -       .nr_gpio        =3D 4,
>>>>> +       .nr_gpio        =3D 8,
>>>>>         .nr_uart        =3D 1,
>>>>> -       .has_mctrl      =3D 1,
>>>>>  };
>>>>>
>>>>>  static const struct sc16is7xx_devtype sc16is752_devtype =3D {
>>>>>         .name           =3D "SC16IS752",
>>>>> -       .nr_gpio        =3D 0,
>>>>> +       .nr_gpio        =3D 8,
>>>>>         .nr_uart        =3D 2,
>>>>> -       .has_mctrl      =3D 1,
>>>>>  };
>>>>>
>>>>>  static const struct sc16is7xx_devtype sc16is760_devtype =3D {
>>>>>         .name           =3D "SC16IS760",
>>>>> -       .nr_gpio        =3D 4,
>>>>> +       .nr_gpio        =3D 8,
>>>>>         .nr_uart        =3D 1,
>>>>> -       .has_mctrl      =3D 1,
>>>>>  };
>>>>>
>>>>>  static const struct sc16is7xx_devtype sc16is762_devtype =3D {
>>>>>         .name           =3D "SC16IS762",
>>>>> -       .nr_gpio        =3D 0,
>>>>> +       .nr_gpio        =3D 8,
>>>>>         .nr_uart        =3D 2,
>>>>> -       .has_mctrl      =3D 1,
>>>>>  };
>>>>>
>>>>>  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned i=
nt reg)
>>>>> @@ -1456,12 +1451,6 @@ static int sc16is7xx_probe(struct device *dev,
>>>>>                                      SC16IS7XX_EFCR_RXDISABLE_BIT |
>>>>>                                      SC16IS7XX_EFCR_TXDISABLE_BIT);
>>>>>
>>>>> -               /* Use GPIO lines as modem status registers */
>>>>> -               if (devtype->has_mctrl)
>>>>> -                       sc16is7xx_port_write(&s->p[i].port,
>>>>> -                                            SC16IS7XX_IOCONTROL_REG,
>>>>> -                                            SC16IS7XX_IOCONTROL_MODE=
M_BIT);
>>>>> -
>>>>>                 /* Initialize kthread work structs */
>>>>>                 kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc=
);
>>>>>                 kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_pr=
oc);
>>>>> @@ -1497,6 +1486,25 @@ static int sc16is7xx_probe(struct device *dev,
>>>>>                                          prop, p, u)
>>>>>                         if (u < devtype->nr_uart)
>>>>>                                 s->p[u].irda_mode =3D true;
>>>>> +
>>>>> +               val =3D 0;
>>>>> +
>>>>> +               of_property_for_each_u32(dev->of_node, "nxp,modem-con=
trol-line-ports",
>>>>> +                                        prop, p, u)
>>>> The general idea looks solid to me.
>>>> I think, that with this property set, we should also reduce number of =
GPIOs exported by gpiochip.
>>> OK, I will look into that.
>>>
>>>>> +                       if (u < devtype->nr_uart) {
>>>>> +                               /* Use GPIO lines as modem control li=
nes */
>>>>> +                               if (u =3D=3D 0)
>>>>> +                                       val |=3D SC16IS7XX_IOCONTROL_=
MODEM_A_BIT;
>>>>> +                               else if (u =3D=3D 1)
>>>>> +                                       val |=3D SC16IS7XX_IOCONTROL_=
MODEM_B_BIT;
>>>>> +                       }
>>>>> +
>>>>> +               if (val)
>>>>> +                       regmap_update_bits(
>>>>> +                               s->regmap,
>>>>> +                               SC16IS7XX_IOCONTROL_REG << SC16IS7XX_=
REG_SHIFT,
>>>>> +                               SC16IS7XX_IOCONTROL_MODEM_A_BIT |
>>>>> +                               SC16IS7XX_IOCONTROL_MODEM_B_BIT, val)=
;
>>>> I just had a chance to test this on my hardware (with SC16IS760), and =
something still doesn't work.
>>>> When looking into /sys/kernel/debug/regmap/<device>/registers,
>>>> it seems like the proper bits are set, also taking the regmap shift in=
to account.
>>>> For reference - I did my test basing on v6.4-rc2.
>>>>
>>>> I used a loopback plug and statserial to perform the test.
>>>> Without your patch, when DTR is set, all other pins (DCD, DSR, RI) are=
 set. With it - they are cleared, according to statserial.
>>> It is strange, because the only conceptual change is the moment in time=
 when we set the IOControl register. Before, IOControl was set within the f=
or/loop for initializing each port. Now it is done after.
>>>
>>> Maybe you could try to put the section that reads the DT property just =
after resetting the device.
>>>
>>> While suggesting this, I just noticed that when the device is reset, we=
 do not wait before initiating communication with the device. Thefore, I wo=
uld suggest the following change (that I will submit as a separate patch):
>>>
>>>         regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_RE=
G_SHIFT,
>>>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
>>>
>>> +       /* After reset, the host must wait at least 3us before initiali=
zing a
>>> +        * communication with the device: */
>>> +       usleep_range(3, 5);
>>>
>>> Then like I said, insert the code that read the modem-control-line-port=
 DT property right after that to see if it helps.
>>>
>>> Hugo.
>> Hello,
>>
>> I tried those suggestions, together with the patch you mentioned in the =
other email - all to no avail.
>> I added a debug print to confirm, that the property is detected, and reg=
map access is executed - and it is. This is so strange.
>> Maybe the offsets in regmap are still wrong, for some reason?
>> I also double checked if it was possible to alter and check GPIO states =
through GPIO subsystem - it is.
> Then it seems that the remaining difference is the number of GPIOs that a=
re configured, which for the moment is always the value set in constant nr_=
gpio (for each device).
>
> I already implemented and tested your suggestion of lowering the number o=
f GPIOs exported when using some pins as modem status lines. It seems to be=
 working good, altough I have only tested that the correct number of GPIOs =
are now exported.
>
> I will send you the test patch and let me know if it helps.
>
> Hugo.
Hello Hugo,

I applied the patch marking IOControl register as volatile - and this one f=
ixed the issue. Modem line states are now reported correctly.
I think it'll be a good idea to bundle all the fixes in the series, when th=
ey become ready for submission.

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

