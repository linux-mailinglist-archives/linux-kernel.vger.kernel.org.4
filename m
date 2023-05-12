Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA47170119A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjELVwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjELVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:51:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CF92682
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:51:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643a1656b79so7429021b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683928298; x=1686520298;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/lBxOTCtayU+JLx1ARgdopct5AoQPf5/nXVYl+V+5s=;
        b=IgE8zU4bBemiV39/zUOWBZJL2A/jnGIdxPytgtf4R3zOUA+LBb17N/QqBYFScneUDH
         /hNOqngcBgimvMvcMJ3bexwDxfaz9WopJXK+f1FyJyyQMK0qO86rPCtCShZuMN8ZnTeK
         hnpEgR6Eum2VTgO2yCv4MO7Conx724Q6BlrdAjWIvXNBa67Auv5APfpqqVdGq1XHp++y
         4gCtVnjdoU3BP6Y97Mgz2Rl752kC4JaIJVI6s+xn3FipkrkSxHmvypaufFwFYXAsI6TG
         mVPny6EVJkw7u1mDpa17gFeq1Ang2/uXHMP8zHl8Yz12yQoWw/+bRiBLYyHcMf4g+bmb
         dTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928298; x=1686520298;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/lBxOTCtayU+JLx1ARgdopct5AoQPf5/nXVYl+V+5s=;
        b=eq6X2bJodSLNm908rl6PmKEPseL/qr8IwYNqMLBA5aL2WL/3DdQvcqjZ8eBrUqxuMa
         iBYE3Rcddehl1VEHj8z3PENF/1hVpLEGJQPj5eIbuSZNLZFz28j3pJwC0CdYjrcweaj4
         vZcFReSvu+sbHEuUTNND3HKpyQWCGO5dr/42bp9xZOpQV6JxxMsiqOGwEJzRazV4DOLf
         uID00b6tFhItGNoS8RuyexFssTfnmbTB1weoLFzatC0E/pYoi1TO8UG30YhUQXSaUl1Y
         AlXBUR6cOgJB3hl07C0gbprjxc+TAdC5qrMC+ZMBYYg4cKHCYn523/FZdMAndAicaMaN
         Dcog==
X-Gm-Message-State: AC+VfDxkKoncbQAzDLndhxxfMrVtItdczzf9fiHevJqXHtuW6cPUVGB5
        JjN9+P3lk1PE3r1zE5U/pGNKnA==
X-Google-Smtp-Source: ACHHUZ5CVA8A5BGqRPsBKfzaN6VwEM3v78qVong9m0e97ZCqeK0n/GAVy4p72AK2pLMzCeNCxqwOsw==
X-Received: by 2002:a05:6a00:801:b0:648:d20c:37dd with SMTP id m1-20020a056a00080100b00648d20c37ddmr11988601pfk.18.1683928298029;
        Fri, 12 May 2023 14:51:38 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id z14-20020aa785ce000000b0062a56e51fd7sm7485555pfn.188.2023.05.12.14.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:51:37 -0700 (PDT)
Date:   Fri, 12 May 2023 14:51:37 -0700 (PDT)
X-Google-Original-Date: Fri, 12 May 2023 14:51:36 PDT (-0700)
Subject:     Re: [PATCH 0/3] riscv: sbi: Switch to the sys-off handler API
In-Reply-To: <mhng-1895c1c0-4bc8-4156-909e-c20fa66e82fd@palmer-ri-x1c9>
CC:     samuel@sholland.org, dmitry.osipenko@collabora.com,
        rafael.j.wysocki@intel.com, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        geert@linux-m68k.org, heiko@sntech.de, kai.heng.feng@canonical.com,
        mcgrof@kernel.org, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng@uniontech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-d2f84d38-65fe-48bd-8328-328072326991@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 14:50:17 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 28 Dec 2022 10:30:11 PST (-0800), Conor Dooley wrote:
>> Hey Samuel,
>>
>> On Wed, Dec 28, 2022 at 10:19:12AM -0600, Samuel Holland wrote:
>>> I want to convert the axp20x PMIC poweroff handler to use the sys-off
>>> API, so it can be used as a fallback for if the SBI poweroff handler
>>> is unavailable. But the SBI poweroff handler still uses pm_power_off, so
>>> done alone, this would cause the axp20x callback to be called first,
>>> before the SBI poweroff handler has a chance to run.
>>>
>>> In order to prevent this change in behavior, the SBI poweroff handler
>>> needs to be converted to the sys-off API first, at a higher priority.
>>>
>>> This series performs the conversion, after accounting for the fact that
>>> the SBI poweroff handler is registered quite early during boot.
>>>
>>> The first patch is a dependency for both this series and the PSCI
>>> series[1], so I would like to get at least patch 1 merged soon.
>>>
>>> [1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.org/
>>>
>>>
>>> Samuel Holland (3):
>>>   kernel/reboot: Use the static sys-off handler for any priority
>>>   riscv: sbi: Share the code for unsupported extension warnings
>>>   riscv: sbi: Switch to the sys-off handler API
>>
>> Not what other stuff has reboot support, so I gave it a whirl on
>> PolarFire SoC & it seemed to work as expected:
>> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> in case the reboot folks want to take these.  I'm also happy to take the
> reboot change through the RISC-V tree with an Ack.  There's some
> discussion about this in the previous patches.

sorry, this is the old version -- I just got lost...

>
>>
>> Thanks,
>> Conor.
