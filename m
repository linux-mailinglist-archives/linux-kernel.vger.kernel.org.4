Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6544C5B556E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiILHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILHkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:40:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22F11C37
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:40:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l8so1149904wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dQ76VMQhXb9hhh82jyPv/oM68Fv8aNARfJwVefdFGDc=;
        b=KfJ+Fx2rGUtduzdvQ6eVVbQ3lN2jGqIQQCuWauULPGyiN/NWq3saXuvZPl4idyWA3K
         lWkyT8lALSlq4x3I5Wjao7IHpLS+Dlyfw0ZP5G11iXTkzNVddv/y+Bpyq05ZYn7Nv/4/
         MZNrkCfrQclDMBe9f8fHdYe5Zx/kPKSiDX1XlJ74eAVywNJOCRsopDsxh2tscKBJfRvW
         hkFAL7Pjq5LLj3U+U19ZdEqMGnUu6BqMx8F7wbMdv8W2iMW7q+PLB3NbfT+umnK/+kHO
         t7ZCYLYl+ZHDj776Z/nviQBq7uTzEL9YaWlHXYeVo9oOEXIUMwV0NIHiT9ZNhWkchD2G
         3LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dQ76VMQhXb9hhh82jyPv/oM68Fv8aNARfJwVefdFGDc=;
        b=MXtUNzal1XUcRSZ6VAjZJyfwWlM+qOvK7A9A05YQIkriBJWFuLI3AxphJhfHsOeuRw
         maHDqP94OHvxy0kCpHAcARL3oZIzYL/3RVGFzJBNSBZp15Sz1NzUUy9yTLL1KHOBSLtP
         hzk0uhh5ec+bEqZQ4oZdKH0eQPGVcW62rYING5joW/D9H7+uzqKmDrHkWbJ/mwB4c7kN
         3jxhnei1+wO53+cwdgd3XCnuepw6hmM66HczlzP6nMHWCQNVkFhPTPtSwl4Ch1W4RGL5
         vV4yE0ayffRRqvaGZwxKIYFN2BaacQBHgXpQ5DZABABt74qG+aWmRhXLuaybYS/MFuCA
         QVPg==
X-Gm-Message-State: ACgBeo0MhXTffIyUuYowMF8oozGpKSEBizMIYyfTopEPu/VaQGdLgHa/
        MqdV5d/QeY+R+6UOntKkhKTmlJFFNJi2YA==
X-Google-Smtp-Source: AA6agR5A3SOR9AtS59XgAPlVXc/Q2Cvze/xaWb7e5lYdilBpDpYW6n35FpofqV0ZZ9OEWi75Ss8gFQ==
X-Received: by 2002:a1c:7905:0:b0:3b3:3fa9:4c3a with SMTP id l5-20020a1c7905000000b003b33fa94c3amr11108308wme.55.1662968412757;
        Mon, 12 Sep 2022 00:40:12 -0700 (PDT)
Received: from jernej-laptop.localnet ([89.101.193.71])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003b4868eb6bbsm3422776wmi.23.2022.09.12.00.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:40:12 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        qianfanguijin@163.com
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Evgeny Boger <boger@wirenboard.com>,
        Andre Przywara <andre.przywara@arm.com>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: Re: [PATCH v2] net: allwinner: emac: Fix double spinlock in emac_timeout
Date:   Mon, 12 Sep 2022 09:40:11 +0200
Message-ID: <2644795.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220912063331.23369-1-qianfanguijin@163.com>
References: <20220912063331.23369-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 12. september 2022 ob 08:33:31 CEST je qianfanguijin@163.com 
napisal(a):
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> emac_timeout() callback acquires lock and so does emac_init_device(),
> which called inside lock protected region. This hangs the system and
> produces following warning:
> 
> WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:478
> dev_watchdog+0x2e4/0x2e8
> NETDEV WATCHDOG: FE0 (sun4i-emac): transmit queue 0 timed out
> Modules linked in:
> CPU: 2 PID: 0 Comm: swapper/2 Tainted: G W 5.15.0-00047-g0848e4aeb313
> Hardware name: Wisdom T3 based CCT Family
> [<c010f740>] (unwind_backtrace) from [<c010b744>] (show_stack+0x10/0x14)
> [<c010b744>] (show_stack) from [<c0a4d978>] (dump_stack_lvl+0x40/0x4c)
> [<c0a4d978>] (dump_stack_lvl) from [<c0120734>] (__warn+0x104/0x108)
> [<c0120734>] (__warn) from [<c01207b0>] (warn_slowpath_fmt+0x78/0xbc)
> [<c01207b0>] (warn_slowpath_fmt) from [<c0898a54>]
> (dev_watchdog+0x2e4/0x2e8)
> [<c0898a54>] (dev_watchdog) from [<c019a888>] (call_timer_fn+0x3c/0x178)
> [<c019a888>] (call_timer_fn) from [<c019bddc>]
> (run_timer_softirq+0x540/0x624)
> [<c019bddc>] (run_timer_softirq) from [<c0101298>]
> (__do_softirq+0x130/0x3bc)
> [<c0101298>] (__do_softirq) from [<c0127ea0>] (irq_exit+0xbc/0x100)
> [<c0127ea0>] (irq_exit) from [<c017e514>] (handle_domain_irq+0x60/0x78)
> [<c017e514>] (handle_domain_irq) from [<c05a6130>]
> (gic_handle_irq+0x7c/0x90)
> [<c05a6130>] (gic_handle_irq) from [<c0100afc>] (__irq_svc+0x5c/0x78)
> Exception stack(0xc14f3f70 to 0xc14f3fb8)
> 3f60:                                     0003475c 00000000 00000001
> c01188a0
> 3f80: c107b200 c0f06b4c c0f06b90 00000004 c1079ff8 c0c62774 00000000
> 00000000
> 3fa0: c10b2198 c14f3fc0 c0107fcc c0107fd0 60030013 ffffffff
> [<c0100afc>] (__irq_svc) from [<c0107fd0>] (arch_cpu_idle+0x38/0x3c)
> [<c0107fd0>] (arch_cpu_idle) from [<c0a57f38>]
> (default_idle_call+0x3c/0xcc)
> [<c0a57f38>] (default_idle_call) from [<c0157258>] (do_idle+0xdc/0x13c)
> [<c0157258>] (do_idle) from [<c01575a4>] (cpu_startup_entry+0x18/0x1c)
> [<c01575a4>] (cpu_startup_entry) from [<401015d0>] (0x401015d0)
> ---[ end trace a70942a1265338f1 ]---
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> rcu: \x092-...0: (1 GPs behind) idle=75d/0/0x1 softirq=8288/8289 fqs=931
> \x09(detected by 0, t=2102 jiffies, g=13485, q=1635)
> Sending NMI from CPU 0 to CPUs 2:
> spi_master spi2: spi2.1: timeout transferring 4 bytes@100000Hz for
> 110(100)ms
> spidev spi2.1: SPI transfer failed: -110
> 
> Fixes: 492205050d77b (net: Add EMAC ethernet driver found on Allwinner A10
> SoC's) Signed-off-by: qianfan Zhao <qianfanguijin@163.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


