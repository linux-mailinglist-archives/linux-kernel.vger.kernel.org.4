Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026327485D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGEORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGEORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:17:32 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56B12A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:17:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38c35975545so5379502b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688566650; x=1691158650;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDWjRluYFM3mzOmtAT5NxskA0RqCR9Q0xHAxLzDYI6Q=;
        b=1A0GhTw4X78yyD2diHuDymDRZR0tQNRmSpxLTIj7P8axsyHpQ76WpBlK7JScRTqEyi
         qKZbGWOykeW46T98BwEJLH7IUhH/2PRp++x/HCuE50ZHgdwfYkF5O/jP8oo2HCTLq3iz
         b94mo8vfnMuT2Xuna48eP7xM7D7fVhQj+B3YOtrgKhtLPwCQbfg6LITO61uqAyARvdmV
         nQ3oCq/Ymh1ELjOMes6j/DOkWslMYzhlnDVb/5jSrmDkTzaNkMx4plvYBIdhf3rp1SBG
         Yjl7RzSl95D8GYwyXeUS/Lgssb6pbH1Le4KEg1hZf5VlIqu08eWtq/q7ZbeVHuGvt7ZR
         wxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566650; x=1691158650;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDWjRluYFM3mzOmtAT5NxskA0RqCR9Q0xHAxLzDYI6Q=;
        b=NQEI99eX3bKflzByGSXssqmmYE1FlEXKF2b6m9nKY3E1qICH/dfkKqlVB2ZT27vjKe
         DVWIS75fwLsrQAGiyW7Jc9rOWZgDYTv7JDGOvLLfydh7f4R0MCLnVsoMFwPuwuH4ps1b
         Znr5fubAMNV0L+NAUY93bkJMmJKslJFE07fQKZU+D7k/ByPiyMeQvBx3u1YOOn0tpvjZ
         aC2TcqVjDPf4MrH6dEAVGvQzkDc8qXOlLfC0aa1sRL8BrVLrGmsJUYAHKhQNX2qol9uM
         qBbV98EUYAMvaBq7KAL3t12KHp+Z5hoPeBi9UnT0rKVMIz4sNErpgMApIeWzQDVA5/dO
         oBpQ==
X-Gm-Message-State: AC+VfDyS3IonCyvemCij0R1BnVk8u4cgzHg2dsHxlxndbfXhFTUioAYe
        dMOdWEoFnukHHQpxRaAH5FJ+2Q==
X-Google-Smtp-Source: ACHHUZ5XPlff29EhdpKAoQIvbVbYkIFGTC1KnDDcA8GRrYOAyjREHvoSgUZXyUCAixVctnbm/B8Qrw==
X-Received: by 2002:a05:6808:1312:b0:3a3:6329:4cb7 with SMTP id y18-20020a056808131200b003a363294cb7mr20423361oiv.9.1688566649962;
        Wed, 05 Jul 2023 07:17:29 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0066ebaeb149dsm16562980pfb.88.2023.07.05.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:17:29 -0700 (PDT)
Date:   Wed, 05 Jul 2023 07:17:29 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Jul 2023 07:17:25 PDT (-0700)
Subject:     Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
In-Reply-To: <20230705114251.661-1-cuiyunhui@bytedance.com>
CC:     sunilvl@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        lpieralisi@kernel.org, rafael@kernel.org, lenb@kernel.org,
        jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     cuiyunhui@bytedance.com, Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-48837062-b9f6-4968-be9e-9d3b352be117@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2023 04:42:47 PDT (-0700), cuiyunhui@bytedance.com wrote:
> Here's version 3 of patch series.
>
> V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
> consensus with the Maintainers.
> Please refer to:
> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cuiyunhui@bytedance.com/

From looking at that thread it seems that the consensus is this is a bad 
idea?  Sorry if I'm just missing something...

> Changes v1->v2:
> Adjusted the code structure, put the ACPI part under the RISC-V architecture,
> and put the general part of obtaining SMBIOS entry through FFI
> under driver/firmware/.
> Please refer to:
> https://lore.kernel.org/lkml/20230703-71f67eb66a037f5c0fb825c6@orel/T/
>
> Changes v2->v3:
> According to the suggestions of maintainers, the code has been modified as follows:
> 1. Modified the commit log.
> 2. Added description of "ffitbl" subnod in dt-bindings.
> 3. Add stub function to the function
> 4. arch/riscv/ and driver/firmware/ use CONFIG_FDT_FW_INTERFACE to control
> 5. Modified the ffi_smbios_root_pointer() function logic and printing
> etc.
>
> Yunhui Cui (4):
>   riscv: obtain ACPI RSDP from devicetree
>   firmware: introduce FFI for SMBIOS entry
>   riscv: obtain SMBIOS entry from FFI
>   dt-bindings: firmware: Document ffitbl binding
>
>  .../devicetree/bindings/firmware/ffitbl.txt   | 27 ++++++
>  MAINTAINERS                                   | 13 +++
>  arch/riscv/include/asm/acpi.h                 |  9 ++
>  arch/riscv/include/asm/ffi.h                  | 14 +++
>  arch/riscv/kernel/Makefile                    |  1 +
>  arch/riscv/kernel/ffi.c                       | 40 ++++++++
>  arch/riscv/kernel/setup.c                     |  2 +
>  drivers/firmware/Kconfig                      | 11 +++
>  drivers/firmware/Makefile                     |  1 +
>  drivers/firmware/dmi_scan.c                   | 97 +++++++++++--------
>  drivers/firmware/ffi.c                        | 42 ++++++++
>  include/linux/ffi.h                           | 29 ++++++
>  12 files changed, 246 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.txt
>  create mode 100644 arch/riscv/include/asm/ffi.h
>  create mode 100644 arch/riscv/kernel/ffi.c
>  create mode 100644 drivers/firmware/ffi.c
>  create mode 100644 include/linux/ffi.h
