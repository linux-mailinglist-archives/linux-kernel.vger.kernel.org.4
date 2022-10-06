Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D68C5F717C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJFXBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJFXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:01:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F36FFF97
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:01:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pq16so2973362pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anISFbJjAjDIRPLJj7qAWgC2bHYps5yuOXEilsdNLtY=;
        b=EhmKoP0UfagPqit1M6IOyZoC5dZ9WJ4TM90+Nn6QgUxOn1Tx1zdLmjajrA2VVjZ6ui
         6zxUgjfbYR2vpWtn7ZawmRDm5maTeAjSisjYByOzyhHUlJVY1x8RLfjhVy/CLvgmuU4R
         wUW2mHPJwXrV90z+lpbG4QN3qjM/mZCBpT1HsZwim8aSfeCBwU/czmOY95Q43Vx9V2K+
         C8sFyAkNpbj0x87Rcwg5TuzxkHdUte9cuEaKHtNhskUG5JT6mzlxYLAFVoEnVwHsEZte
         fyW6L5KXFUDDewJSXoZETCiCmdlswfrAtCilrcIbfazfkL8ibGHx66pDQrwfY0Q/d9fw
         6STw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anISFbJjAjDIRPLJj7qAWgC2bHYps5yuOXEilsdNLtY=;
        b=cPTwiODvaJIEvNstKKFQ6kWabJ6vduRO95FnMsdHN4Z8SRLns2kIiaRA3j3jOfAKqv
         s5PKvRaiyFfwyzTdhpsxS2KbwMjWAfqzGWUL1TLS26T3gpAPpGpRObYnbi+54E+pnJgX
         +gXp8xUqcX2lv5gKb+uh6jiLhdCXOYcKttaQ4cmmJRWCLA4LlipJERxCVsfYS5hJUe6b
         BN2Vzq33zHTWXW8iQgZDyQLyljKe38vVJE0JWP0D6nDi3H0bK/s7+chggeSN+QY6FlvN
         sEXWXV2V8qjQATSDeNQCMKKkn6KANT4Ourzrs+BycoKv9NAIFYIs3D/Vp6/vOvTnz2ep
         sONA==
X-Gm-Message-State: ACrzQf13yBSu7EsoteuYq0gIKu2oN/npZbF8jXKBTjOSqi+mdyCvWKhp
        Ji6UtRqPmkh3kZrCxeK0AddBZjezQ1qooQ==
X-Google-Smtp-Source: AMsMyM4OIzejez0bkjljwc0CT8TkhyhuVjpXlC4/HJk78p0kg6ne12YpdhWh8nN0Lkgz+n3+k+RTYw==
X-Received: by 2002:a17:902:ec86:b0:177:f35c:e118 with SMTP id x6-20020a170902ec8600b00177f35ce118mr1697617plg.138.1665097273528;
        Thu, 06 Oct 2022 16:01:13 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bc8-20020a656d88000000b0043a1c0a0ab1sm257309pgb.83.2022.10.06.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:01:13 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v4 PATCH 0/3] Unify ARM64 & RISC-V Linux Loader
Date:   Thu,  6 Oct 2022 16:00:48 -0700
Message-Id: <20221006230051.185850-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series unifies the linux loader for ARM64 & RISC-V. The linux loader
for ARM64 is pretty much arch independent. Thus, this series just moves
it to the common directory and update the make files.

This series is rebased on top of Ard's LoadFile2 series[1].

The unification effort was a little mess and I was to blame :(.
I started the effort but couldn't follow up after. Nikita picked it up
and rebased all the patches along with LoadFile2.

However, Nikita did not follow up after v3 as well. Ard revised his
LoadFile2 series few weeks back. As the ocotober deadline for next grub
release is closing, I decided to rebase the patches so that RISC-V support
can be officially part of the release. Sorry for the mess/confusion.

This series has been tested with OpenSuse image in Qemu. It would be good
to get more testing on ARM64 and real RISC-V boards as well.

Changes from v3->V4:
1. Added all the comments on v3.
2. Dropped LoadFile2 patches as Ard's series[1] updated those patches

[1] https://lists.gnu.org/archive/html/grub-devel/2022-09/msg00057.html

Atish Patra (3):
loader: Move arm64 linux loader to common code
RISC-V: Update image header
RISC-V: Use common linux loader

grub-core/Makefile.core.def             |  8 ++--
grub-core/loader/{arm64 => efi}/linux.c |  0
grub-core/loader/riscv/linux.c          | 59 -------------------------
include/grub/riscv32/linux.h            | 15 ++++---
include/grub/riscv64/linux.h            | 21 +++++----
5 files changed, 25 insertions(+), 78 deletions(-)
rename grub-core/loader/{arm64 => efi}/linux.c (100%)
delete mode 100644 grub-core/loader/riscv/linux.c

--
2.25.1

