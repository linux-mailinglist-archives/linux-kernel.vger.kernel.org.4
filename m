Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7C6E3A71
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDPRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPRWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:22:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300F1FEC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:22:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f46348728eso520417f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681665721; x=1684257721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDlQI/J+UFcjKa6nIRBcZjhQV/MQ60rlZb/LHoB6Dp8=;
        b=fOnB9/GClUPxMSB+z+8X5YoIs+bYGohLSbNJO4lElgVpmh9dkh20EsjQBQP5iJ4SpB
         48APshaUgpALCK1NugS+2pgwezYRielOJ9tjRFNuMQyWC2i01+VDWCUJtvApczZTtbee
         TVgMYt59oSZ/U1irMHRgmtymG+t6YemBdhPq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681665721; x=1684257721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDlQI/J+UFcjKa6nIRBcZjhQV/MQ60rlZb/LHoB6Dp8=;
        b=N3DJX/uA5y1WF/tlw++eM+kAPT9OKkh+/+bbHT/vOsetsEqsz9GSwsrgRsORU10zyw
         RfdmU8Q6F7eVdB0PveNT49CqR8QAjM/hHC3DbquDF2Vce4HPB4drjKaAYZfr9INGoPeo
         d2lqbHHpRKjt/IUrfN7/SqQggdF0zMcZsxx6R2vmfBIrlEE1Q/FJD7JRcef9MWN1rNyL
         2T9ddrxMIFVq5WJlBmElPyrJvARvJtR7qWNd1dRsAZkTVGz2Qwk2T/B7jfm8KIN8SCNZ
         mc2rfIuOpJjFAv1Y+AFODD6RVZdRca40mXfztUIhD5uWHJaV5arLxr7fVKU3nyaQVo7V
         Bsyg==
X-Gm-Message-State: AAQBX9eUEUUQfVovAVsCAVLjwZPhmE21xAdJzXYJfv1a1wCg0rRdjDBj
        2hCRJhavEJJKQRRlpa1zzvdmEHZhXV0HDhUGRZkDljbm97rdVHXmPv59XjMABfuGuRZ+num9oXT
        vW/HgwF3+mdmLncyxF3/2RcS/h0CoTSaCQxnLFJ5tX4XVzP81vO0skHN2d0qLFh+esfMWyiZMZd
        vDwAi6v4NeRF3Z0TbHf87rpbL0B7dC
X-Google-Smtp-Source: AKy350bIAcypE5oApgVn5rul6KQifXK4N2ExuxKCNn8gC3dsfIPPIRPvhkqxmOEJW/RiIYN4r2Wfkg==
X-Received: by 2002:a5d:4610:0:b0:2f6:c5bd:ba13 with SMTP id t16-20020a5d4610000000b002f6c5bdba13mr3921614wrq.42.1681665720867;
        Sun, 16 Apr 2023 10:22:00 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b003eddc6aa5fasm13355192wmo.39.2023.04.16.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:22:00 -0700 (PDT)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        vbabka@suse.cz, 42.hyeyoo@gmail.com, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: [PATCH v6 0/3] Replace invocations of prandom_u32() with get_random_u32() and siphash
Date:   Sun, 16 Apr 2023 20:21:58 +0300
Message-Id: <20230416172158.13133-1-david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

Hi,

The security improvements for prandom_u32 done in commits c51f8f88d705
from October 2020 and d4150779e60f from May 2022 didn't handle the cases
when prandom_bytes_state() and prandom_u32_state() are used.

Specifically, this weak randomization takes place in three cases:
    1.	mm/slab.c
    2.	mm/slab_common.c
    3.	arch/x86/mm/kaslr.c

The first two invocations (mm/slab.c, mm/slab_common.c) are used to create
randomization in the slab allocator freelists.
This is done to make sure attackers can’t obtain information on the heap state.

The last invocation, inside arch/x86/mm/kaslr.c,
randomizes the virtual address space of kernel memory regions.
Hence, we have added the necessary changes to make those randomizations stronger,
switching  prandom_u32 instance to siphash.

Changes since v5:
* Fixed coding style issues in mm/slab and mm/slab_common.
* Deleted irrelevant changes which were appended accidentally in
  arch/x86/mm/kaslr.

Changes since v4:
* Changed only the arch/x86/mm/kaslr patch.
  In particular, we replaced the use of prandom_bytes_state and
  prandom_seed_state with siphash inside arch/x86/mm/kaslr.c.

Changes since v3:
* edited commit messages

Changes since v2:
* edited commit message.
* replaced instances of get_random_u32 with get_random_u32_below
      in mm/slab.c, mm/slab_common.c

Regards,


David Keisar Schmidt (3):
  mm/slab: Replace invocation of weak PRNG
  mm/slab_common: Replace invocation of weak PRNG
  arch/x86/mm/kaslr: use siphash instead of prandom_bytes_state

 arch/x86/mm/kaslr.c | 21 +++++++++++++++------
 mm/slab.c           | 29 +++++++++--------------------
 mm/slab_common.c    | 11 +++--------
 3 files changed, 27 insertions(+), 34 deletions(-)

-- 
2.37.3

