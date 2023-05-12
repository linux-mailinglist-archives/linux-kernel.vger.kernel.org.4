Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96842701192
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbjELVuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjELVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:50:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54312682
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:50:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so7084174b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683928218; x=1686520218;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXshd51fH2+G3epdXCEAiwTlwyZiu61NCKXGF8cY8aI=;
        b=hijUWW7YGEiY7G1Qeg4PABKlij9oIFKh1iXUlbGTJjd4I+SL5j3NCzvgEQ8zoZT4aT
         wy192rGcvymwNscv/Tr+wKES91UJhfykzelovxv/OzgMvslZurtTmUk98kmx9aEDqPQ6
         jVublaFURukhXJqmbDLw4rC5OpSRojatblM3MW3l71zW9MQbcNeimQNcLs81fBxSj5nx
         26wlq4DQjCF38eIM11yBQYPYvPf0u+stV5IxKTsaR3e1OmkK/I2MZnCJcxrJNpocMEoy
         +8lVR/tWKaoFKAjL1FumNIGrc4eA22kUifLMAg+Vu0MDmCU0PgvX8UucR2n2o0bnTOFX
         BciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928218; x=1686520218;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXshd51fH2+G3epdXCEAiwTlwyZiu61NCKXGF8cY8aI=;
        b=LSCFpnpoO6v/9q4E1J3GUVMG1a7wNRGFt+iVZikLWPIJT4tV1JXmc5/TyjALjwSUdp
         ht1Sln2PBHN/uGFAB7ochIlqbR3iBitJtzFyujHQLHrSv21h2GOGvZWv/PBlxEyypf18
         KDkt0/DLuMdT9p7MYfKRha6kR4n+ieiwinvhitcnrRhBDSnnJ5Fmrm2r0rWnKh7c38+j
         fUcduL/lSqWO3dNrrtgLTeGy8jZT/IyPUFI1GGBWrDReUD0QbOumXVNhLIpFYu+/MfWX
         7bxf6q71wtYjzpfz6fEw5uRqGlNMduCX/pgMjtLrcNlKxJB+KCiacAZOt3V32bgWykjs
         vWkg==
X-Gm-Message-State: AC+VfDwdnKa0/Bb7JDc3r6w+8T0YAAwOWxA9tybXvM1BpGt3iXY0QbOY
        8ksdgWVtYCKoIGiDEJDkXRhr8g==
X-Google-Smtp-Source: ACHHUZ6QnDiLUa2/w2yCFZmwe7mkNFnoMETOFiVkUsq9LBgtSgJJRl8p+zso0mUoALLTMQiq9XEUWA==
X-Received: by 2002:a05:6a20:3d95:b0:101:36b8:f077 with SMTP id s21-20020a056a203d9500b0010136b8f077mr18764616pzi.28.1683928218180;
        Fri, 12 May 2023 14:50:18 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79115000000b006348cb791f4sm7503301pfh.192.2023.05.12.14.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:50:17 -0700 (PDT)
Date:   Fri, 12 May 2023 14:50:17 -0700 (PDT)
X-Google-Original-Date: Fri, 12 May 2023 14:50:14 PDT (-0700)
Subject:     Re: [PATCH 0/3] riscv: sbi: Switch to the sys-off handler API
In-Reply-To: <Y6yLMwhSypqp5+Ir@spud>
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
Message-ID: <mhng-1895c1c0-4bc8-4156-909e-c20fa66e82fd@palmer-ri-x1c9>
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

On Wed, 28 Dec 2022 10:30:11 PST (-0800), Conor Dooley wrote:
> Hey Samuel,
>
> On Wed, Dec 28, 2022 at 10:19:12AM -0600, Samuel Holland wrote:
>> I want to convert the axp20x PMIC poweroff handler to use the sys-off
>> API, so it can be used as a fallback for if the SBI poweroff handler
>> is unavailable. But the SBI poweroff handler still uses pm_power_off, so
>> done alone, this would cause the axp20x callback to be called first,
>> before the SBI poweroff handler has a chance to run.
>> 
>> In order to prevent this change in behavior, the SBI poweroff handler
>> needs to be converted to the sys-off API first, at a higher priority.
>> 
>> This series performs the conversion, after accounting for the fact that
>> the SBI poweroff handler is registered quite early during boot.
>> 
>> The first patch is a dependency for both this series and the PSCI
>> series[1], so I would like to get at least patch 1 merged soon.
>> 
>> [1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.org/
>> 
>> 
>> Samuel Holland (3):
>>   kernel/reboot: Use the static sys-off handler for any priority
>>   riscv: sbi: Share the code for unsupported extension warnings
>>   riscv: sbi: Switch to the sys-off handler API
>
> Not what other stuff has reboot support, so I gave it a whirl on
> PolarFire SoC & it seemed to work as expected:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case the reboot folks want to take these.  I'm also happy to take the 
reboot change through the RISC-V tree with an Ack.  There's some 
discussion about this in the previous patches.

>
> Thanks,
> Conor.
