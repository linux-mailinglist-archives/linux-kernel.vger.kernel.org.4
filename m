Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FE6A59DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB1NQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB1NQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:16:42 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D522D17B;
        Tue, 28 Feb 2023 05:16:40 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5975424E287;
        Tue, 28 Feb 2023 21:16:23 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 21:16:23 +0800
Received: from [192.168.125.128] (113.72.145.171) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 21:16:21 +0800
Message-ID: <f9e380f6-334f-11fa-1118-8d6c3c9befaf@starfivetech.com>
Date:   Tue, 28 Feb 2023 21:16:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, "Conor Dooley" <conor@kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com>
 <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
 <Y/3coFvMWOLaaY9p@wendy> <545c23f3-1d68-2bff-89d9-584e3ca31044@linaro.org>
 <Y/3hVlp/YPnWHDCX@wendy>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <Y/3hVlp/YPnWHDCX@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/28 19:11, Conor Dooley wrote:
> On Tue, Feb 28, 2023 at 11:57:58AM +0100, Krzysztof Kozlowski wrote:
>> On 28/02/2023 11:51, Conor Dooley wrote:
>> > On Tue, Feb 28, 2023 at 11:36:49AM +0100, Emil Renner Berthing wrote:
>> >> On Tue, 28 Feb 2023 at 10:44, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>> >>> On 2023/2/26 22:14, Emil Renner Berthing wrote:
>> >>>> On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>> > 
>> >>> So the dt-bingdings need to rename, and which one could be better,
>> >>> 'starfive,jh71x0-wdt.yaml' or 'starfive,jh-wdt.yaml'?
>> >>
>> >> Sure, starfive,jh71x0-wdt.yaml sounds good to me.
>> > 
>> > I feel like a common comment I see from the dt folks is to not put
>> > wildcards in filenames & just pick the first compatible.
>> > I could very well be wrong on that front though...
>> 
>> First compatible is a bit better, unless you are sure this will cover
>> all such compatibles now and in the future. For many bindings the
>> family/wildcards were fine in filename.
> 
> Ahh cool, good to know what the specific policy is - thanks!

If this watchdog driver is improved to also support JH7100 in next patch,
it seems more reasonable to rename the dt-bingdings to 'starfive,jh71x0-wdt.yaml'.
