Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC967B2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjAYMxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:53:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681D710AAB;
        Wed, 25 Jan 2023 04:53:07 -0800 (PST)
Received: from [192.168.2.197] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 015C36602E4D;
        Wed, 25 Jan 2023 12:53:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674651186;
        bh=FsmNHA2oh2Kx15JYgMiYPMwo9fJuN5w1csBgs9yBag0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RpwnSDTKnV/756GSwFe99d13fNSHYTBDoI1mjxpTJsvNS7ku4HBu1ZgsTst6A0Dji
         Q776uDOZdQbH5Rqgit4GJWEZ3wL+2EAjVJekWRsEtkNaIKutJjJCaHDtIlHIsqGORy
         dDa+G53xoAZawv88Hv7ZzQZmLSefHyEMkK9Ll0mHuhhqBpowO9D5U9abGd2itwph3u
         QGoz6uXnF3HXtEvGqD+Z1ShQWD4IE/5QeLBcxsQLGCcjG3zwDF4z3ZDG6/LXbLpZSz
         UcfYhS4O90WWIjHzDOTV3TpOmihjVdGROF+1dP2eQhae8k6NKUU4X39mPRQc/DoaVm
         B+2oAPubBm6VA==
Message-ID: <0a180849-ba1b-2a82-ab06-ed1b8155d5ca@collabora.com>
Date:   Wed, 25 Jan 2023 15:53:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/2] firmware/psci: Switch to the sys-off handler API
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230101181715.42199-1-samuel@sholland.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230101181715.42199-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/23 21:17, Samuel Holland wrote:
> I want to convert the axp20x PMIC poweroff handler to use the sys-off
> API, so it can be used as a fallback for the SBI poweroff handler on
> RISC-V. But the PSCI poweroff handler still uses pm_power_off, so done
> alone, this conversion would cause the axp20x callback to be called
> first, before the PSCI poweroff handler.
> 
> In order to prevent this change in behavior, the PSCI poweroff handler
> needs to be converted to the sys-off API first, at a higher priority.
> 
> This series performs the conversion, after accounting for the fact that
> the PSCI poweroff handler is registered quite early during boot.
> 
> The first patch is a dependency for both this series and the SBI
> series[1], so I would like to get at least patch 1 merged soon.
> 
> [1]: https://lore.kernel.org/lkml/20221228161915.13194-1-samuel@sholland.org/
> 
> Changes in v2:
>  - Update commit messages
> 
> Samuel Holland (2):
>   kernel/reboot: Use the static sys-off handler for any priority
>   firmware/psci: Switch to the sys-off handler API
> 
>  drivers/firmware/psci/psci.c |  9 ++++++---
>  kernel/reboot.c              | 10 ++++------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 

Hello Rafael,

Do you think you will be able to pick up this series for 6.3? I'm going
to continue removing the pm_power_off from kernel, the new power-off API
feels stable now to me. I think the Samuel's improvement for the early
boot memory allocation will be good to have to avoid similar problem for
other drivers.

Ideally, the PSCI patch should get an ack, though the code change is
about the PM stuff, so perhaps will be fine to take it via PM tree if FW
maintainers will show no interest in the nearest time.

Thanks!

-- 
Best regards,
Dmitry

