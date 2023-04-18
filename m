Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38C6E63B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjDRMmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDRMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:42:46 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C57CC3C;
        Tue, 18 Apr 2023 05:42:27 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9A27B24E31D;
        Tue, 18 Apr 2023 20:42:26 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 20:42:26 +0800
Received: from [192.168.125.87] (113.72.144.253) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 20:42:25 +0800
Message-ID: <18211b73-346d-d6ca-6d34-bc84184f8f55@starfivetech.com>
Date:   Tue, 18 Apr 2023 20:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/2] clk: starfive: Fix RESET_STARFIVE_JH7110 can't be
 selected in a specified case
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-mm@kvack.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "Necip Fazil Yildiran" <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230417074115.30786-1-hal.feng@starfivetech.com>
 <20230417074115.30786-2-hal.feng@starfivetech.com>
 <20230417-buckwheat-wilt-92a4e85a5ca0@wendy>
 <83c5a35a-c646-cbc7-83f9-c02fcb24e069@starfivetech.com>
 <20230417-bolster-vitality-89d279146497@wendy>
 <0fe42faa3b34f82cc2fb73ae61460bf2.sboyd@kernel.org>
 <be049959-423e-6cd6-1f11-9bfa72665803@starfivetech.com>
 <20230418-caliber-clavicle-e8c1beb3fb75@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230418-caliber-clavicle-e8c1beb3fb75@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 07:31:47 +0100, Conor Dooley wrote:
> On Tue, Apr 18, 2023 at 10:14:06AM +0800, Hal Feng wrote:
>> On Mon, 17 Apr 2023 17:22:01 -0700, Stephen Boyd wrote:
>> > Quoting Conor Dooley (2023-04-17 03:18:35)
> 
>> >> Aye, just the explicit dependency seems like it'd be less fragile and
>> >> more obvious in the future.
>> > 
>> > Agreed. Be explicit so we don't have to hunt down select dependencies.
>> 
>> With further consideration, on the other hand, if we set `if ARCH_STARFIVE`
>> here, it can point out that we need the reset driver to boot up JH7110
>> besides the clock drivers, and the reset driver is not a necessary option
>> for compilation test. So the reset driver is independent to the clock
>> drivers when you doing a compilation test.
> 
> If ARCH_STARFIVE is enabled, both options (RESET_CONTROLLER &
> RESET_STARFIVE_JH7110) will be selected & you don't need to worry about
> people not realising this. Try it out & look at the option in
> menuconfig.
> 
>> If we set `if RESET_CONTROLLER` here, the reset driver will be compiled
>> automatically when (ARCH_STARFIVE [=n] && COMPILE_TEST [=y] && 
>> RESET_CONTROLLER [=y] && CLK_STARFIVE_JH7110_SYS [=y]).
> 
> This is what we want, right? The more often it gets built by randconfig
> etc the better, especially for archs that are not RISC-V.

OK, will fix it in v2.

Best regards,
Hal
