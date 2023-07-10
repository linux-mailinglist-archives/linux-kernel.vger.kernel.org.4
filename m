Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0774D1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjGJJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGJJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:34:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4010CA;
        Mon, 10 Jul 2023 02:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsHHeW8MHgXBO7jIzcP5Y2SRvK02Ob3bmBLP06ucJXEJqpQMppHfZni2ikTePVfIGBxEAYinlrdzQdXC7xUUVsLGLZ74bWCAJ4uq98GMRlZ5Xsf6rpstYkBwIbHjjXTqLwsdxO7vhITAYBnrEIyu0O4oszCxaBAZL8FouFMhWw3GdQLPkU2iyNUae7fx2mO4Ro0a8DG/VrrlvMariPeY+uSD5YojzMcRXxVU6sBSdefgP3P6zMb+43PtjiNg2xIGzviLjQ0vzeUGwpUQY9cvnvmvrEomLjuEe49FrwHJKbOOBE160LNJFq/oJDVqOabaHPeFLG9HHB9OgVD1TBws1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyQJLqV8dcOLBA2fpKV9xonwHtVoNZwJjSaHG5wm0pE=;
 b=HNX873vTgHQH06hEPHpuGMXe7i0vXIPQUxuIBNRAWPVuuRX9CuR1jSZuQPJoT3S30Z2WeWzTqKpaMSBbyFChOzmpGefsAQ57Q/WqW0Ka85z8jSFy3ZCmc7HSuDnaWtMOwLgj67SQhTvHzcmVnX5oCuIaEIuLhFgjYcnQC+5UP7Ig5kUKSQyqTYGI1QwOloxNmJKaK5QAGTxuVzSXxha0TzCisc6c3agN9D5dKDSRwMC3i7dAqUQRRJvs3T8PR+0QKe26sRLj4hvCKVTJ8UwN4gBLABEF79tpgIirtQK9VU8J4PdqkffJ0XSnLSPCCj2J53BPRa5KpOi16ZpYRGi20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyQJLqV8dcOLBA2fpKV9xonwHtVoNZwJjSaHG5wm0pE=;
 b=YaMUDQ6LrLIyJKh9wExFoKIJfKrpzxlxLQANc+7cQiAnfOK5W1Fscw7gsF5S8LJvrYp22GdmRdpHRDGa3ACkUHZTAYyaerzt6lOzdfh2qKNDtJ05sdLpzeQHyzlEeXQGYvWO/7lnhcI22MAfX9e4KGDUcYClNuLGmbmut4l0+jIwGCP1QRkOCrVjBdRsqIt01a5UDVHdEExA5ZiIgi7EZOft/BNg66j7j09Xb4ULcqNPeyzGzfoEOZiWvfkDKyEAPs+JGahIyxOi65Ol+T0g6qyzU7BLyhu7X7Wtga0nm93kyiorsQnXorEegk3sixCzlrxSUn/Z3Rcvh6K8xs71+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by TY0PR03MB6630.apcprd03.prod.outlook.com (2603:1096:400:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 09:32:33 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::66e9:429b:7b34:639a]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::66e9:429b:7b34:639a%5]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 09:32:32 +0000
Message-ID: <6afe63d3-5cfe-1cfe-0326-0c51c6a526ef@amlogic.com>
Date:   Mon, 10 Jul 2023 17:32:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 2/2] pinctrl: Add driver support for Amlogic C3 SoCs
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
 <20230710042812.2007928-3-huqiang.qin@amlogic.com>
 <CAHp75VevmTiv-OYVTn3bF_8UT9SKNU2oTrzS-AM1zoWefeJ=3w@mail.gmail.com>
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <CAHp75VevmTiv-OYVTn3bF_8UT9SKNU2oTrzS-AM1zoWefeJ=3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::9) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|TY0PR03MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: bc743c7f-9c00-4dc6-7edb-08db81289574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/FFypfDy75pBLoJsPiZPe1jEXkn73wJVM59oe396l3sEjENrCdxFYQ0Jo1HWG1NM9scuVqG/wXKaFtIX1ze/Ll9zhyEVAcOOpqn+5kaR7kzl1TmOntmYOLEAimQv63thOVDfw1Zr9XTUeLWSKWs5FTCpONoRoAyqCVIY4Kkd2z5efSyv/0Q1fMNqZgmZnK1XTBH8C8q7H86gMMZK9hhRL6E1OAF8JZdCpr+NzI6KNQC7RcsrhU1rvfpXuYia5I9tU4aGrwD1ANFz7RDsnU1eAMas+PPrNWEqBiy2vijdJ3gqifplPoePICMN7kU8CD5QCBltHCbf75OsEQ1Jrzsf5t5SvHFthqvgvRHSHz50zXiT0etvV2SAnDvMhC3aQN1lDIJG79ZYiDGTO2P3nwrG7wD3ZCQ013HOLQiMHBeL8rs8fxCyUCYztFiNXawX6U3K2POJDuJgtwlmCmOn0fkh1POP2IfTgm5/PNdIDsdVVlPTbO9WtqrlhMKLmdjKrLpgAtl0BG1nmADunrPFyUMGUrogmP3KNjulhOM5ow+wDZ+0abnix/EKMZYVh5C12Kkq9KnbQEuvFUSbws9y+JAPzvt54irETsG3lQdFRJ1SQOiKG3w3zUQjcot+XQR7Qg1IcwpB0RNZgyFfjw6yRTJMAoP4JxYD8ip0ut67QsCDSoONI0YHzjtRWP9ylUU3jjbY2wjUQOCABhA5lx84akscBqnQJ9qp1U89lfpTmBYH6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(376002)(346002)(366004)(136003)(396003)(39850400004)(451199021)(41300700001)(44832011)(5660300002)(31686004)(7416002)(6486002)(316002)(2906002)(8676002)(8936002)(6512007)(66476007)(4326008)(66556008)(6916009)(66946007)(36756003)(52116002)(478600001)(6666004)(86362001)(186003)(31696002)(2616005)(38100700002)(38350700002)(6506007)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGcyMUcwbUZuSTFkRy9tU0tNQm1zRUpZMWlkTTFiSU9ibVNJL2c1aGprMFFv?=
 =?utf-8?B?VTZ2ZmZRb2tFV0luMW9Memg4S09vSlBNM3k5c2ZYeHBGMEplQ3pNY01TYVE5?=
 =?utf-8?B?VStwUGg1Y2Vnd0N6MXJzN1VSZkFkakdibldsZzJES0h0N05BM1F4cnBCaUdJ?=
 =?utf-8?B?R3RoaXd1dXdFS2l0S0hoRGx0L01hNjBNVzM3djhWSFJhZ3NVMlhqUmVzTDZE?=
 =?utf-8?B?bnJSTWhOekQxZFk3V0ZlZERhY3Bqem5YUEFKc2J6WWZuQUJqNkdVbDNZdDNH?=
 =?utf-8?B?NWxZbnIvSWNyR3ZqWFczTG8wY1ZVRE14eC93Ni9wa3NCMFgza29RNUMwaGEx?=
 =?utf-8?B?WjZBWWlhclQ2VmFBVGc2RWdoMU5VWjJIam1zOFFxTXRXdEZzeTc5cE5DdVpv?=
 =?utf-8?B?RjNWSXcyQW1RUWpPVjEyVVNuWWdtTHNKSjRwNUJGN1VaangvUTQ4R0pjV29N?=
 =?utf-8?B?ZzN3SjJpNHVjc29ONE9jUVQ5b015MCtDVGVOZnRydjQ0M3B2cTdvS21MK0lB?=
 =?utf-8?B?Tm9tSnBlR0dGWHdMQzNGU3h5bmNSc3Z1UlB1bTA1UTVCdkJTeTdjSVNzZFQz?=
 =?utf-8?B?NHIrSi9GTk9WMTlIVmtYeml4VmlEbjZFdHd1VFA0a0FkVmpuWlpIby84d28w?=
 =?utf-8?B?SUt5QXF4RkxmV2IvYkdzYjB5RFdBb3FkWHBTZldhR1hrOERmb3RHdW5wYlZB?=
 =?utf-8?B?K21xTnRrUWR4V0wxT1NZMnhRMS9hS2IzNmR0VFVxYi95S3RiY0N3TDZnWEdZ?=
 =?utf-8?B?T0RhREdpbVRDbERzSzFjZ0Y2T2pkL1RHUERaWnZwSWdod3VzS2FpQlRVeUla?=
 =?utf-8?B?TkhDU3dlTTVhaUk1R2RDNm5GTTh0Y0FIZG00TFZvNHBGSk5sQ2VyNkd1b2Rn?=
 =?utf-8?B?NUIrZlFXaDhkTUQrWHp0cjBSQmRtbDlGeHpCTUlvV1lJOXZtUHpuNHA4cUZM?=
 =?utf-8?B?Q2NVNHBVN2M0Vlg3ZTlldFlGNkh5WkRrQlAvUzlXM2l3TnNPUTRyMVIvaHF0?=
 =?utf-8?B?SWlsNFZTSU5WL0Y1d3BjQ0VVM0ZNZWRwb2VYRGlCNEhhU2REbmVheWFiMm9s?=
 =?utf-8?B?QVppWldudEFJSkpCVzJUSnVBMXlsVkFxR0NQT3hvQVN6SGdTUy9YeDFqZlVy?=
 =?utf-8?B?cEJmYnpTNXB6Q1g3SjhFak9QejVEZTRmSW1yZnVUVXRiZEFYemdSbzNtVXZ0?=
 =?utf-8?B?WitwN0owT1drRWQvQTIyMWdwN2MyRTQranZXZktCSDYyNjV5U2Rtall0bVNR?=
 =?utf-8?B?Ulo4aXFwYndoclZFVHFrd1UzL0NTeThobjROc2loblVsRXlwaEc5MWNRcm9C?=
 =?utf-8?B?eUJhT2JVN2diR01ON0hJMkxQbWxtUW9FSnNtNnd0T0Zid2dRWXh5TnRzS0Qv?=
 =?utf-8?B?SzdFVnE2aDhYcHFLa0duWkNHV3NMMDQwNENmdFVZbkMxSUI3eDFuaFJlNE94?=
 =?utf-8?B?Qm93ZVRSMW1vY0dsT3pSTjhYWWVWNmhQS25ESHNGZmEvenVITkNnMmNlUUdw?=
 =?utf-8?B?UzhvcFMrMzFCVW1Oei9zaThWakZNdUVRcEFFMERqY3NPWnhsQlBqZWJvNDJz?=
 =?utf-8?B?c2hORklmTWU1UmdDOWNOZnFsK21rVWpmM0hpKzYwQUJ0aFFpRkVodEtVNldY?=
 =?utf-8?B?Wk03U3hRbWxMbndtUWtaSjdSYU5meFgzTGFBMGp2aDdKaWpDT0t1UWpBeGNB?=
 =?utf-8?B?Uml4R3pmc3ppQjEvV0oyRDNMbDg5OGtKcUFkdm9CUkdUYXJtNHlId1hOdDgy?=
 =?utf-8?B?ZGJVNGtDQlp5VlozYlhSOVMvWjJWSHZ0YU5CellVZHJkdkZUT1hqdEtJL0NN?=
 =?utf-8?B?UjhVOWN6S0RwTXRkWTlONUxiMHlNeWU5dTVZczZDSlVnK0RQWEY3RkthS25F?=
 =?utf-8?B?YVV0MTY3VHgyeDBCQm14WnJFRkNJZUV1dEFqOXBRTlkwMjNhUGUweVVsNm1m?=
 =?utf-8?B?YXVSVG9aazNrK1p3QTBsK0JOcVdqeEZNdFBxdnZSZ3RBa0dnenM2YUQxSkJr?=
 =?utf-8?B?TlJvLysrRnRXUzg2eWJqdC9KeTZVU2hod2JGaS83NjRPYm83QlI2Tm8wemdP?=
 =?utf-8?B?akJTR3NWNWVUOEZPMVRTdE05dCthalpoMWNQOThCZSt0N2FmSVc2M1RwM3BS?=
 =?utf-8?B?VzRQSW5wenlXZEx3c2drU1BmazZidVdaMnpaOW55Q3pNRGdicmR1ZmFoeTBr?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc743c7f-9c00-4dc6-7edb-08db81289574
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:32:32.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0WOSR4I7D2QRT1zlSCcoi1IUppCi6oMJDKl1jUX08GjnBpi3okX6wS5gx0z3b9sIPM+XhP3TEh71z+w8CkULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6630
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

On 2023/7/10 15:33, Andy Shevchenko wrote:
> ...
> 
>> +#include <dt-bindings/gpio/amlogic-c3-gpio.h>
> 
> Seems some headers are missing. The rule of thumb is to include
> headers the code uses directly.
> Moreover, using a "proxy" header is not the best idea.
> 
> kernel.h // ARRAY_SIZE()
> mod_devicetable.h // of_device_id
> module.h
> platform_device.h
> 
> pinctrl/pinctrl.h
> 
>> +#include "pinctrl-meson.h"
>> +#include "pinctrl-meson-axg-pmx.h"
> 
> With the above, it might be that existing inclusions become unused, so
> drop them in such a case.

According to Amlogic's pinctrl driver structure, the code to realize
the function is mainly in pinctrl-meson.c, and pinctrl-amlogic-c3.c
is only used as a data file to describe the pins of the chip, and for
similar data files, all need to include pinctrl-meson.h and
pinctrl-meson-axg-pmx.h header files, such as A1, G12A, S4 and so on.

The following header files are included in pinctrl-meson.h:
    linux/gpio/driver.h
    linux/pinctrl/pinctrl.h
    linux/platform_device.h
    linux/regmap.h
    linux/types.h
    linux/module.h

Here is a case for each dependent header file:
    struct gpio_chip chip;         ---- linux/gpio/driver.h
    struct pinctrl_desc desc;      ---- linux/pinctrl/pinctrl.h
    struct platform_device *pdev;  ---- linux/platform_device.h
    struct regmap *reg_mux;        ---- linux/regmap.h
    Basic types of linux           ---- linux/types.h
    MODULE_DEVICE_TABLE()          ---- linux/module.h

Since every data file will use them, let's put it in the header file,
so as to reduce duplication of code.

> ...
> 
>> +static struct meson_pmx_func c3_periphs_functions[] = {
>> +       FUNCTION(gpio_periphs),
>> +       FUNCTION(uart_a),
>> +       FUNCTION(uart_b),
>> +       FUNCTION(uart_c),
>> +       FUNCTION(uart_d),
>> +       FUNCTION(uart_e),
>> +       FUNCTION(i2c0),
>> +       FUNCTION(i2c1),
>> +       FUNCTION(i2c2),
>> +       FUNCTION(i2c3),
>> +       FUNCTION(i2c_slave),
>> +       FUNCTION(pwm_a),
>> +       FUNCTION(pwm_b),
>> +       FUNCTION(pwm_c),
>> +       FUNCTION(pwm_d),
>> +       FUNCTION(pwm_e),
>> +       FUNCTION(pwm_f),
>> +       FUNCTION(pwm_g),
>> +       FUNCTION(pwm_h),
>> +       FUNCTION(pwm_i),
>> +       FUNCTION(pwm_j),
>> +       FUNCTION(pwm_k),
>> +       FUNCTION(pwm_l),
>> +       FUNCTION(pwm_m),
>> +       FUNCTION(pwm_n),
>> +       FUNCTION(pwm_c_hiz),
>> +       FUNCTION(ir_out),
>> +       FUNCTION(ir_in),
>> +       FUNCTION(jtag_a),
>> +       FUNCTION(jtag_b),
>> +       FUNCTION(gen_clk),
>> +       FUNCTION(clk12_24),
>> +       FUNCTION(clk_32k_in),
>> +       FUNCTION(emmc),
>> +       FUNCTION(nand),
>> +       FUNCTION(spif),
>> +       FUNCTION(spi_a),
>> +       FUNCTION(spi_b),
>> +       FUNCTION(sdcard),
>> +       FUNCTION(sdio),
>> +       FUNCTION(pdm),
>> +       FUNCTION(eth),
>> +       FUNCTION(mclk_0),
>> +       FUNCTION(mclk_1),
>> +       FUNCTION(tdm),
>> +       FUNCTION(lcd)
> 
> + trailing comma. The rule of thumb is to add a comma when it's not a
> terminator entry.

Okay, I'll double check and add them.


Best Regards,
Huqiang Qin
