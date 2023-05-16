Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E270491D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjEPJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEPJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:24:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930961B7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:24:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51452556acdso9651782a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684229059; x=1686821059;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfIklMWyxHqT15p3DEDH7Q3m1hZaZiD2446SsTwPHNU=;
        b=jgid5FsyiXSUa8KMxp4EGQwY6+r+2EY2Pae/pn3FPkEqWy0fhC/UqIeyRyoelGyl+Y
         6DfG0gXZJ9xbmSgPL5RhhhmbEG4evEhlMJgR8YHye6wZxmnNMZUXEoeUjmJ9vPO9t/y2
         /uLd/ZPl2ZbcCuFQHxlpEzzYDQXZyOl4CLLiOZJOptaGLL+zqzN5Yy98gy2DS8HFZQNr
         w8weSOdrQKbcxaYj5KQVO9d24tahTUp9W5iKtEHwEzjJVxS3lVytMPtLupyF6k79KVAi
         f8QnQHh9hOcD4ejx6mocR2hwDNrLhZOu7iQNOT0TFMRr9OC5YsVdbBU9h0PS43hAfsEk
         wOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229059; x=1686821059;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfIklMWyxHqT15p3DEDH7Q3m1hZaZiD2446SsTwPHNU=;
        b=QAZm7V8V/dq4jVn1AuwQFX2qrUpGYO8cK8mcJJStT1SLp/2bBZI6o1V4yl7nMl6eci
         jKM1FBnQnXF5oEeRzzzmuxuTsMNFoFObilAeBTZWlsGANlOGUFj/zEbtpWEl0D5gEEar
         yNJ46ImyF2IJQhKPCRm5dxBc0/3nHF9ASwvKrT9mzm6gYDxX78SmcaMHAFsqTx+eMlBI
         NIzMX2Hu1DkgxHAZHjqaNj3Dj2dj6r1JeV/CVrnP3XQ/zBCznnHuOJ8CACqVNt6628gf
         41sGbrZjY8CLQFTes9o92rNSGcMkjOk1jxLLtju7JgBNG7qYiKF8ykmB8lcvB/m8i164
         lX8A==
X-Gm-Message-State: AC+VfDyzh5tbSmian5UbFk3x2xCym0NAs5BjCwrJEh++ZWXXYayXGs6w
        lV4anC5xTFWDaEoDC/nMJng69hhNVxCbuKgHC7Yj/6tJeEQ=
X-Google-Smtp-Source: ACHHUZ6dVVtR+AmIfSaeJoNfitxBaphnrQs6YXNn+RDYS0Eqsag+GBvPqXOw+vtkGTHRoZgt/K23OijmrgS3mP3xCxw=
X-Received: by 2002:a17:90b:33c4:b0:250:d293:5da0 with SMTP id
 lk4-20020a17090b33c400b00250d2935da0mr21720438pjb.17.1684229058691; Tue, 16
 May 2023 02:24:18 -0700 (PDT)
MIME-Version: 1.0
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 16 May 2023 09:24:07 +0000
Message-ID: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
Subject: Bug report: kernel paniced when system hibernates
To:     alexghiti@rivosinc.com, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, anup@brainfault.org,
        palmer@rivosinc.com, jeeheng.sia@starfivetech.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description of problem:

The latest hibernation support[1] of RISC-V Linux produced a kernel panic.
The entire log has been posted at this link: https://termbin.com/sphl .

How reproducible:

You can reproduce it with the following step :

1. prepare the environment with
- Qemu-virt v8.0.0 (with OpenSbi v1.2)
- Linux v6.4-rc1

2. start the Qemu virt
```sh
$ cat ~/8_riscv/start_latest.sh
#!/bin/bash
/home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
-smp 2 -m 4G -nographic -machine virt \
-kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
-append "root=/dev/vda ro eaylycon=uart8250,mmio,0x10000000
early_ioremap_debug console=ttyS0 loglevel=8 memblock=debug
no_console_suspend audit=0 3" \
-drive file=/home/song/8_riscv/fedora/stage4-disk.img,format=raw,id=hd0 \
-device virtio-blk-device,drive=hd0 \
-drive file=/home/song/8_riscv/fedora/adisk.qcow2,format=qcow2,id=hd1 \
-device virtio-blk-device,drive=hd1 \
-gdb tcp::1236 #-S
```
3. execute hibernation

```sh
swapon /dev/vdb2 # this is my swap disk

echo disk > /sys/power/state
```

4. Then you will encounter the kernel panic logged in the above link


Other Information:

After my initial and incomplete dig-up, the commit (3335068f8721
"riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
is closely related to this panic. This commit uses re-defined
`MIN_MEMBLOCK_ADDR` to discover the entire system memory
and extends the `va_pa_offset` from `kernel_map.phys_addr` to
`phys_ram_base` for linear memory mapping.

If the firmware delivered the firmware memory region (like: a PMP
protected region in OpenSbi) without "no-map" propriety,
this commit will result in firmware memory being directly mapped by
`create_linear_mapping_page_table()`.

We can see the mapping via ptdump :
```c
---[ Linear mapping ]---
0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A G
. . W R V ------------- the firmware memory
0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D A G . . . R V
0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A G . . W R V
0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A G . . . R V
0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD D A
G . . W R V
0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A G . . W R V
---[ Modules/BPF mapping ]---
---[ Kernel mapping ]---
0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D A G . X . R V
0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A G . . . R V
0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A G . . W R V
0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A G . . . R V
0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
```

In the hibernation process, `swsusp_save()` calls
`copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
bitmaps,
the Oops(load access fault) occurred while copying the page of
PAGE_OFFSET (which maps the firmware memory).

I also did two other tests:
Test1:

The hibernation works well in the kernel with the commit 3335068f8721
reverted at least in the current environment.

Test2:

I built a simple kernel module to simulate the access of the value of
`PAGE_OFFSET` address, and the same panic occurred with the load
access fault.
So hibernation seems not the only case to trigger this panic.

Finally, should we always leave the firmware memory with
`MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at least
in the current environment) or any other suggestions?

Please correct me if I'm wrong.

[1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia@starfivetech.com
[2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@rivosinc.com

-- 
Thanks,
Song
