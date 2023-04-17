Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B56E512C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDQTvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDQTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:51:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4B846A0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:05 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54fe82d8bf5so116400527b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681761064; x=1684353064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16bK4B8B1HSdwGL8nDI39J+E+/3IAw3fz4AXkqHxJaw=;
        b=XwfJ6DoKaUhwsFVYOuNq1/DJ8HRZJHYVvdh3JVsQfynQZM0l1OIwhn+AWoQDX1qMUn
         PP57fozW1Ikxf49qI+M9VZqg3Y7usRis2ZmR6fBJKkAq5Ny0j5S11sKdYtMIgP0uRURt
         Vw2GO33MeNhFt+SSWvR1vW1VUNvnZGP6P4kThHTAmdQROfucmCBOoncuf5dj7i9tJKcO
         siEZ5mnVKxiO545NTM//EfTbl7vA407Y/z3x6xuXPZTQA01ODvCnLtVg0nzAeDDMzwn+
         VvruZ+oTcizfV8LRhJk2C44zIevhOaQ/noA+Bj/xZFlzmrczOTkmKDa6/tT25qzQqDvF
         9Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761064; x=1684353064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16bK4B8B1HSdwGL8nDI39J+E+/3IAw3fz4AXkqHxJaw=;
        b=NxFdXaakS/UXuTtQ6Z/dXFddL3q0kXV/YaMfRvXRN4tOP0EfTpkAVYSwSnTJMXU61y
         zbBlMOIcd3rJ5VBxqmmQB7AtiOrAIoGKxc3AY+vCT5cSykeDFW41F90wqyDWN+V8D2gQ
         TwCpuDReqQcnz6K1g+hxSQbmQtWcSFB53AeFzk4uVSSLsiVu+xDP4qM9Tzcl4B+PeUwx
         25yv/WrWGo9ylK6eFeiiuyyl0FfM+9P7Qo3U4m64+bbB464noLzh/TOdylWxEIMUJQTX
         ht0mTReqLFBtiQWnszL63R9kC4X2L4e0MIyp9+t/VZsmBIoJ1iAm5BwOdfLMNZs/9Z/H
         SyzQ==
X-Gm-Message-State: AAQBX9eaJetyjQoUFR9hagFr6ZLFlE2tcPAKaeDu6vb1dGXYvnnRCBgi
        vxY8aLQj4J5BVwZNG+KEbPWFlA==
X-Google-Smtp-Source: AKy350YUOcPtOysYC5RppRKEd6liQcgq+GLl5DvRzWfIvkhxXxoTYZjEpzgg5lHWrcqP1NXJiWHIXQ==
X-Received: by 2002:a0d:db45:0:b0:538:49a4:b166 with SMTP id d66-20020a0ddb45000000b0053849a4b166mr15720640ywe.11.1681761064185;
        Mon, 17 Apr 2023 12:51:04 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u125-20020a817983000000b005463f6ae720sm3293158ywc.68.2023.04.17.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:51:03 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 0/4] Refactor 104-quad-8 to match device operations
Date:   Mon, 17 Apr 2023 15:50:46 -0400
Message-Id: <cover.1681753140.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Fix endianness errors by utilizing get_unaligned_le24() and
   put_unaligned_le24()
 - Mention benefits of using regmap in the commit description
 - Use "int ret" for regmap_* return values throughout for consistency
 - Reorganize declaration lists to prioritize longer lines first
Changes in v3:
 - Add __always_inline attribute for quad8_control_register_update()
Changes in v2:
 - Drop FIELD_MODIFY() macro introduction; u8p_replace_bits() is
   utilized instead for the same purpose
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()
 - Replace FIELD_MODIFY() with u8p_replace_bits()
 - Wrap up control register update in quad8_control_register_update()
 - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
   data

The 104-quad-8 driver was initially introduced to the IIO subsystem
where it didn't quite fit with the existing paradigm [0]; these
differences eventually led to the creation of the Counter subsystem[1].
As a result of its awkward beginnings, the design of the 104-quad-8
driver was structured around maintaining abstract state buffers that
would eventually be converted to match the actual device registers
states on-the-fly as needed.

The original design approach for the 104-quad-8 driver was neither
efficient nor easy to troubleshoot, but it did allow us to focus on
implementing and supporting necessary APIs for the nascent Counter
subsystem. Now that development for the 104-quad-8 driver has shifted
to maintenance, it is a good time to refactor and clean up the code to
match closer to what is actually happening on the device. This patchset
is an attempt to rectify the situation as such.

The primary change is a transition from maintaining individual
configuration states independently, to storing buffers of the device
register configurations. To that end, the bitfield API is leveraged to
access and retrieve field states. Some helper functions are introduced
as well to abstract the handling of the PR, FLAG, PSC, and control
registers. A migration to the regmap API is added as a follow-up patch
due to its dependence on this patch series.

[0] https://lore.kernel.org/r/b43e2942b763b87afc85bfa9fe36e5695cba4c44.1475079578.git.vilhelm.gray@gmail.com/
[1] https://lore.kernel.org/r/cover.1554184734.git.vilhelm.gray@gmail.com/

William Breathitt Gray (4):
  counter: 104-quad-8: Utilize bitfield access macros
  counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
  counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and
    PSC
  counter: 104-quad-8: Migrate to the regmap API

 drivers/counter/104-quad-8.c | 802 +++++++++++++++++++----------------
 drivers/counter/Kconfig      |   1 +
 2 files changed, 440 insertions(+), 363 deletions(-)


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

