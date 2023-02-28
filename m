Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF36A50D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB1B6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB1B6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:58:06 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CC77DBD;
        Mon, 27 Feb 2023 17:58:03 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4649624E36E;
        Tue, 28 Feb 2023 09:57:57 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 09:57:57 +0800
Received: from [192.168.125.82] (113.72.145.171) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 09:57:56 +0800
Message-ID: <db0036f5-e904-36b2-b3f5-3b0c520ca6aa@starfivetech.com>
Date:   Tue, 28 Feb 2023 09:57:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 2/2] hwmon: (sfctemp) Add StarFive JH71x0 temperature
 sensor
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230227134125.120638-1-hal.feng@starfivetech.com>
 <20230227134125.120638-3-hal.feng@starfivetech.com> <Y/y4LunvriV2RYwu@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y/y4LunvriV2RYwu@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 14:03:26 +0000, Conor Dooley wrote:
> On Mon, Feb 27, 2023 at 09:41:25PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Add driver for the StarFive JH71x0 temperature sensor. You
>> can enable/disable it and read temperature in milli Celcius
>> through sysfs.
>> 
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Co-developed-by: Samin Guo <samin.guo@starfivetech.com>
>> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
>> +config SENSORS_SFCTEMP
>> +	tristate "Starfive JH71x0 temperature sensor"
>> +	depends on SOC_STARFIVE || COMPILE_TEST
> 
> We (or I?) am trying to homogenise RISC-V with the rest of the kernel by
> using ARCH_FOO rather than SOC_FOO. We've currently got a mix of both,
> due to companies that started out with RISC-V having SOC_ symbols &
> those with history in other archs having ARCH_ ones.
> The ARCH_ definitions landed in mainline this week, so if you end up
> resubmitting this driver, it'd save me a conversion if you were to use
> the ARCH_ variant.

Got it. I will use the ARCH_ symbol instead in the next version. Thanks.

Best regards,
Hal

> 
>> +	help
>> +	  If you say yes here you get support for temperature sensor
>> +	  on the Starfive JH71x0 SoCs.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called sfctemp.

