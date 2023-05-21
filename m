Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0108B70ABF6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEUCHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjEUCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 22:02:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE68D93
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 19:01:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae8de081ccso11111185ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684634516; x=1687226516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51eARV0mcKeV1eIZtds0tWRUIXNBvFSqTgfBgrE5Jwg=;
        b=xelRWVs3hikFpb6Z+GQFtokNQWEDsFQ16L9wp06fub8GBYnTA4OUitMDyex+TszXFn
         muJjlJWM011b09xLbXnpBId7LBmeLKJ/2x9KLxY8cbN7O44YMZ/zPT227036WmXvn4E4
         6tWGCQyzIqZmOqlNx1h4Mf7UNBXnxm8xg1wJs0xfENsxwlJNd6u4aqSDTP2XOUopPfmK
         V6O4giJfRAUCB8FTpncGp3G7MNz4APz6MsVEAOLwbZ1XrWICx7joDvSD0WGoDb4VGTcm
         j1kb4Q2H3wMg0pADO+lHH54XIuyPfPRq5ZslfMslq8bRHL824dHu7jsrYsDY387nMtTd
         pjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684634516; x=1687226516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51eARV0mcKeV1eIZtds0tWRUIXNBvFSqTgfBgrE5Jwg=;
        b=ARzFVR28l99O7TjbDtIwCq1aQe7ln+W+dlmgGCbHDUl3YCtR460yRFuH/1v0oKG98w
         nktKTORWgdpcG2sfwf9D74f3O6yvV+FVZg4lh0TFiuN1tdwZqPvsV/uTjCmM5l+MXs16
         xdsOO5i3A7XDTiBE5Z+EBXSemuTRUuc6r/PuHzbbKlwGVvuVSUHlqOTMd7E2LEKMvCrD
         BACzPGMLmXL2fRxztQIG9Hp4MLrQlrfKbzrUoTcrAE4N3Uuvg1fqCFIgkItf8++q5riG
         Jpe3i8U9boUWHv8dX7uGchykvrim4VJ45fG7DkYc3KjI/a2GStZ2/HO/zpzs0IbljIR9
         Kalw==
X-Gm-Message-State: AC+VfDzRDBN0oeJESKGO60QY8XNzSotI6nqv9jug4R/tBKnBXohKfkot
        9EosiNs4iZbSq3tsfJwQlfB5kA==
X-Google-Smtp-Source: ACHHUZ5ZFTB2b1TzGRnzu56JDQXNuSCkhQzwTKamxHc9v+Tcbetk0vwpHRvSFd3twRCqlRjYN2kXqA==
X-Received: by 2002:a17:902:e848:b0:1ac:820e:c34a with SMTP id t8-20020a170902e84800b001ac820ec34amr12119763plg.0.1684634516058;
        Sat, 20 May 2023 19:01:56 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:95b7:fae6:7e9f:45cb])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001ae0152d280sm2107584plz.193.2023.05.20.19.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:01:55 -0700 (PDT)
Date:   Sat, 20 May 2023 19:05:54 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>
Subject: riscv: boot failure for 3335068f8721 ("riscv: Use PUD/P4D/PGD pages
 for the linear mapping")
Message-ID: <ZGl8gn/rD8WZ0nak@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I tested 6.4-rc1 on an internal RISC-V SoC and observed a boot
failure on a Store/AMO access fault (exception code 7) in __memset().
stval (e.g. badaddr) was set to 0xffffaf8000000000. This SoC is RV64GC
with Sv48 so it seems that address is the start of the "direct mapping
of all physical memory" [1].

The 6.3 release boots okay and the system is able to operate correctly
with an Ubuntu 23.04 rootfs on eMMC. Therefore, I decided to bisect and
I found the failure begins with 3335068f8721 ("riscv: Use PUD/P4D/PGD
pages for the linear mapping"). The system boots okay with the prior
commit 8589e346bbb6 ("riscv: Move the linear mapping creation in its
own function").

The boot log [2] shows that the fault happens right after buildroot's
init script [3] uses switch_root to execute init from the Ubuntu rootfs
on the eMMC.

DWARF4 is enabled in .config [4] and the decoded stack trace [5] shows:

  epc : __memset (/eng/dfustini/gitlab/linux/arch/riscv/lib/memset.S:67)

From memset.S:

 Line 67:         REG_S a1,        0(t0)

From the oops:

 epc : ffffffff81122d6c ra : ffffffff80218504 sp : ffffaf8002e47500
  gp : ffffffff82695010 tp : ffffaf8002e2ec00 t0 : ffffaf8000000000
  t1 : 0000000000000080 t2 : 0000000000000001 s0 : ffffaf8002e47550
  s1 : ffff8d8200000040 a0 : ffffaf8000000000 a1 : 0000000000000000

Thus I think it is trying to store 0x0 to 0xffffaf8000000000 which is
the start of the direct map. From the boot log [2], OpenSBI shows:

 Domain0 Region00 : 0x0000000002080000-0x00000000020bffff M: (I,R,W) S/U: ()
 Domain0 Region01 : 0x0000008000000000-0x000000800003ffff M: (R,W,X) S/U: ()
 Domain0 Region02 : 0x0000000002000000-0x000000000207ffff M: (I,R,W) S/U: ()
 Domain0 Region03 : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)

The DDR memory on this SoC starts at 0x8000000000 with size 2GB. The
memory node from the device tree [6]:

        memory@8000000000 {
                device_type = "memory";
                reg = <0x80 0 0x00000000 0x80000000>;
        };

I think the direct map address 0xffffaf8000000000 would map to physical
address 0x8000000000. Thus I think the attempted store in S-mode to that
address would violate the PMP settings for Region01.

I do not yet understand why this happens with 3335068f8721 ("riscv: Use
PUD/P4D/PGD pages for the linear mapping") but not for the prior commit
8589e346bbb6 ("riscv: Move the linear mapping creation in its own
function").

One important cavaet: I do have a small diff from mainline to add
support for the eMMC controller in this SoC to sdhci-of-dwcmshc.c. The
output of 'git diff' when 3335068f8721 is checked out [7] shows that
this just adds a new compatible and corresponding sdhci_ops struct.
Everything works ok with this change in both the 6.3 release and the
commit prior to 3335068f8721.

I know it is a bit awkward for me to report a boot failure for an
internal SoC but I am hoping to find a better solution than just
reverting this change in the downstream kernel.

The reason that so few changes are needed to run Linux on this SoC is
that there is a service processor that handles all the low-level tasks
like setting up clocks and configuring various peripheral controllers.
Everything is already setup and ready to go by the time the hart meant
to run OpenSBI+Linux (fw_payload.bin) comes out of reset.

Note: normally Linux runs on all four harts but I reduced to running on
a single hart to simplify diagnosing this boot failure.

Thanks,
Drew

[1] https://docs.kernel.org/riscv/vm-layout.html#risc-v-linux-kernel-sv48
[2] boot log: https://gist.github.com/pdp7/afe78604f477c9e3a3cf0241bcdffcdb
[3] init script: https://gist.github.com/pdp7/8d61bafbca55e987b790433c0353831d
[4] linux .config: https://gist.github.com/pdp7/a4df66f1359a34194bddd32f74ab38a3
[5] stacktrace: https://gist.github.com/pdp7/0524892ea319775ea70e43a54cc842a9
[6] mysoc.dts: https://gist.github.com/pdp7/cd1b2e8e8d3f6047efd53e4ef65664da
[7] git diff: https://gist.github.com/pdp7/581c9e8415da94a29d34ae6d7cc14669
