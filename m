Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2D36E5E73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjDRKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDRKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:17:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F267A8A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:17:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso34725e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681813076; x=1684405076;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYl/Oz3UxWL8YEPjdztiHxLe2qdPPPEyqdO/kFl/aj8=;
        b=a678TKWgqb1Pt1vIE8NEsK8HmAbDdG3KAKO8UAIjB+tZ6nJM2CI61vM+iQj0hlVyT5
         2VPJuSwOc8igGipc+cjuik2EES+biE0lrguoi4/WYdM4boJ86unD4lxMNHiOc9FL/Nhh
         H+Sn/yMFfu7pFZ2RElVV9mJu1iw2AMlfy81Tax76E8KRcXyifWjKyuWiMs9T3n7Hx26j
         sHgX+XvMQaz46D/E/hyShD71+SUZsWfbAKR2eNw2loKGIdOfR/RlwHq7HQjpGivWCZUg
         oNVBjppShCRDUyrBRQn8zei2/Bo8ZVetuKLMP/JRKThpUbpzt85fuxd/8tUiDW6sFrnU
         na4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813076; x=1684405076;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYl/Oz3UxWL8YEPjdztiHxLe2qdPPPEyqdO/kFl/aj8=;
        b=e0nj0y1yFjjmxDAhA3DEKliEXW+6nsXClIrmYtfX4MLET/zsc794mESNgiJXcYaEcM
         MPGscmauk3iXAB02fccCotPcKGTOkC8sASM9Dsr6WweODN1MafdMpPD5zKSDDTK4BzzX
         sTEflrisoiUhuyFUNGyaxgGBWsCN76FvbDG//oPJWatEDFFCXmZ1C/JJzvHaj3y1vYxB
         kIADe4KXCX5zBelXwSEv66L5mXfaeXNdX6nHTgbz0M6UogOnu5ZrL66bNM7NG1a1fBr9
         4+NFeCnA6/aSFaF4WFaVcskEUSV5VKhW/8ggErDnIGKMX1CE0oBEAItMIJ3io0lwRKLY
         2Tjg==
X-Gm-Message-State: AAQBX9frUhPVpqMUebIncNER/LsBP4/oL+s1ZGw50jeQLUCUIEns4yqf
        BA2ehxN7TZUhMTIy7APytTanXCqHel7FIxhJhneb7A==
X-Google-Smtp-Source: AKy350aOiDKrTU1YE/OnYRqS8F5jNyelOkGz358yc/LZOs1Ra+0Gr3iD1GHqLIhP7dApHsUrOZGTHLukukOhTTHcQBI=
X-Received: by 2002:a05:600c:3b8c:b0:3f1:7490:e5a4 with SMTP id
 n12-20020a05600c3b8c00b003f17490e5a4mr155593wms.6.1681813076345; Tue, 18 Apr
 2023 03:17:56 -0700 (PDT)
MIME-Version: 1.0
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 18 Apr 2023 12:17:44 +0200
Message-ID: <CANp29Y6YqPbE9Y3iQEaTwD_YAQBvsxxRE=0COVYy=gBP-USvkg@mail.gmail.com>
Subject: arch/riscv/net/bpf_jit_comp64.c build error
To:     pulehui@huawei.com
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pu Lehui,

I'm writing to you regarding your following patch.

Author: Pu Lehui <pulehui@huawei.com>
Date:   Wed Feb 15 21:52:04 2023 +0800

    riscv, bpf: Add bpf_arch_text_poke support for RV64

When trying to compile the "fixes" branch of the
"git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git" tree,
syzbot gets the following error:

arch/riscv/net/bpf_jit_comp64.c: In function 'bpf_arch_text_poke':
arch/riscv/net/bpf_jit_comp64.c:691:9: error: implicit declaration of
function 'patch_text'; did you mean 'path_get'?
[-Werror=implicit-function-declaration]
  691 |   ret = patch_text(ip, new_insns, ninsns);
      |         ^~~~~~~~~~
      |         path_get

FWIW the compiler is riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2.

Could you please take a look?

Best Regards,
Aleksandr
