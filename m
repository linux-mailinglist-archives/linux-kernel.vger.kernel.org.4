Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB406AD5E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCGDsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:48:15 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE258C20;
        Mon,  6 Mar 2023 19:47:44 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 03FF224E023;
        Tue,  7 Mar 2023 11:47:42 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 11:47:41 +0800
Received: from [192.168.125.128] (183.27.97.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 11:47:40 +0800
Message-ID: <c745392f-6d8a-8e00-803b-dd61a0a008a0@starfivetech.com>
Date:   Tue, 7 Mar 2023 11:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/3] clocksource: Add StarFive timer driver
To:     Andreas Schwab <schwab@suse.de>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
 <20221223094801.181315-3-xingyu.wu@starfivetech.com>
 <mvmzg8vlcfk.fsf@suse.de>
Content-Language: en-US
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <mvmzg8vlcfk.fsf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/2 17:39, Andreas Schwab wrote:
> drivers/clocksource/timer-starfive.c:117:13: error: conflicting types for 'timer_shutdown'; have 'void(struct starfive_clkevt *)'
>   117 | static void timer_shutdown(struct starfive_clkevt *clkevt)
>       |             ^~~~~~~~~~~~~~
> In file included from ./include/linux/workqueue.h:9,
>                  from ./include/linux/srcu.h:21,
>                  from ./include/linux/notifier.h:16,
>                  from ./include/linux/clk.h:14,
>                  from drivers/clocksource/timer-starfive.c:12:
> ./include/linux/timer.h:188:12: note: previous declaration of 'timer_shutdown' with type 'int(struct timer_list *)'
>   188 | extern int timer_shutdown(struct timer_list *timer);
>       |            ^~~~~~~~~~~~~~
> 

Oh, this timer_shutdown(struct timer_list *timer) function was not available
in 6.1-rc5 which this patchset was base on. And in the new version, it's the
same name as my own function. I will change the name of this function.

Best regards,
Xingyu Wu
