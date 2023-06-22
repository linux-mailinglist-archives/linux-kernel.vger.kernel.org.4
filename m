Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4373A846
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFVS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:28:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA15FE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:28:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b4f9583404so57318635ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687458537; x=1690050537;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5pPpV6BAFD4TLifWvN0B+3IxsV4SDIF9ZR1S6R6SGE=;
        b=GOmTF2DlxvZqeQDfyI78OemXdjjQfH9Ilk9xRzUi71d/sCw8jLLoug968FmGh07Ltx
         Voh/jniYcRHtU/7LyIhjU1V1X4YWiQz0OqrC5aIc/dKhqPgwJ1vaLFE3QAnNTNYw3VQk
         3tGIHx5hG/BYPINBwTJzR12n3lGUp9YGUVcAonaJQU3U4pY+jR5JxMyaUBZ1x9BTcbvY
         Ib8sSgWv8cthmnaxHu00qSv3/+tH4Ld22o5PXyhysImm9YYTypP5+MWkPF7RHNU3Q6dG
         gfpN96h5zSZ1LPtCCfSKCNarzZFLbG7QmKt2/sXmxh8r5pyFWXqngliQqYEP37v60cmh
         p8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458537; x=1690050537;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5pPpV6BAFD4TLifWvN0B+3IxsV4SDIF9ZR1S6R6SGE=;
        b=L9puai1ezYofavwFpAm8ZVxr0J6T4YnOTl8rM6FFJrS/Pr0r91NGagumvwQlG1GJRK
         x0QyGSVlhDWHsUdko/XoLrlQAzUbdy68JXzOP2ONmkBuOuLNacz4hAoarW+I2gVQsEZM
         /sm5zQEkoq2ZB8VtoDKzJNZ76Q58e9Sp1mLKxB4TSq3VExaj40LQO4dRU9ZTPGA7XWN/
         hlQscRYkR6FfUU0+Nw3se7SNQH8V/f/qaoIiqV9Ypg7J5yfVAbOEzkuHrG6SrWhvXCr1
         G2RXHPpRYrr8LFej1UF6g48XRfZ+OdNBaeCYohhMiq3oJLGuP3MKqo6F+nNOESJRhhYx
         4iaA==
X-Gm-Message-State: AC+VfDy/gXPJSAcvUkX57VAZwvZ4MW7I5azPbzUovATBXmnalhAPtFhz
        0JSRYZ1oKbkOt691GDl4ZkOB1Q==
X-Google-Smtp-Source: ACHHUZ4oQkDG7Am9kGaWj5ODKkVsXUlKPHI5unROmVOojf7emxVsqdA3Lmr2qF5VVkxWA5ukDwCMug==
X-Received: by 2002:a17:902:c94d:b0:1b6:b73a:553d with SMTP id i13-20020a170902c94d00b001b6b73a553dmr1272775pla.58.1687458537333;
        Thu, 22 Jun 2023 11:28:57 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001a69c1c78e7sm5713586plb.71.2023.06.22.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:28:56 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:28:56 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 11:27:05 PDT (-0700)
Subject:     Re: (subset) [PATCH V2 0/4] Remove WARN_ON in save_processor_state
In-Reply-To: <168736259084.605458.4732376069158804322.b4-ty@arm.com>
CC:     Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, chris@zankel.net, jcmvbkbc@gmail.com,
        steven.price@arm.com, vincenzo.frascino@arm.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        jeeheng.sia@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>,
        ajones@ventanamicro.com, songshuaishuai@tinylab.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <mhng-d670ba57-2c68-4d38-8ad9-795f8ca3b69d@palmer-ri-x1c9a>
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

On Wed, 21 Jun 2023 08:51:43 PDT (-0700), Catalin Marinas wrote:
> On Fri, 09 Jun 2023 15:50:45 +0800, Song Shuai wrote:
>> During hibernation or restoration, freeze_secondary_cpus
>> checks num_online_cpus via BUG_ON, and the subsequent
>> save_processor_state also does the checking with WARN_ON.
>>
>> In the case of CONFIG_PM_SLEEP_SMP=n, freeze_secondary_cpus
>> is not defined, but the sole possible condition to disable
>> CONFIG_PM_SLEEP_SMP is !SMP where num_online_cpus is always 1.
>> We also don't have to check it in save_processor_state.
>>
>> [...]
>
> Applied to arm64 (for-next/misc), thanks!
>
> I couldn't tell whether this series would go in as a whole but given
> that the patches are independent, I picked up the arm64 one.
>
> [2/4] arm64: hibernate: remove WARN_ON in save_processor_state
>       https://git.kernel.org/arm64/c/615af0021a61

I was pretty much in the same spot until I saw this, so I'm picking the 
RISC-V bit and just ignoring the rest.  It's testing so it might take a bit to
land in linux-next, but seems pretty safe.
