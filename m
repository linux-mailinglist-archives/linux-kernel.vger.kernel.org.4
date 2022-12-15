Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AC764DCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLOO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:29:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC752617
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:29:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so2897539pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY0Xezt8weAxCgCAphw/rTBxuMub8/nuZ/8USOGCrnQ=;
        b=KbhU4ZeyMh6DMdZAiSfWNy1r5/ncwItDfLQvvRldEl4DTEWhYy/ok0p5ykGyOiwITp
         rHkkwEEFi4KEk/GNL/UL3ikProFYFIoMegmuXQLpoclzuL3SaKkrYkKMsluttf1Xxe9H
         9lrz1B8gqkjlFnI+sORLxXSHreAbyEeTzBI6/aHcLVqlImd2Y/oNWHquRCAWWY1fKeK/
         QNESBQvXtU4dwArjMyZdpgYv2T9EET868gtY4NeQQcejWrbDWQZFqWOd/0I4pQ0UktiW
         tnpfJ1EEfji46g8fRzlopy6fp361zvXpw2+2aZYKxs0RnlNfPb8FoUkCuz81do8BeIAO
         u0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZY0Xezt8weAxCgCAphw/rTBxuMub8/nuZ/8USOGCrnQ=;
        b=q2Q2xHsflSbLG+DZSk2WqoSC16vm+8dMdcdQ7CiV1FoFcdrHdRJmpUNSe2n03Y5ppa
         2AlupfJzW+nhIkGqUkyAEMdtkgLNML/V+TNbMbenAMBYC0+YIV/LlfZ24yZnq3Sf3YYJ
         Agdwz7J6xUDFCeJa6EfonCXtrlT0EdbFtjY1CMVof0fSZC4MXLo+HfnV2zYg/tPaSJNf
         dMvJrc1Qcsu0XppwYF038Kh43arFdKrDFTjCFslWSvy6BGd6MJ5btCVtlhToZ+OCVX8c
         FRRXy9/o903wV/Fz6zkJaKA562i1R/ZD1sDTnAfChLbn/LoeHjCI/oywTFNRLRJDVbXt
         Xa3Q==
X-Gm-Message-State: AFqh2ko0AfqTw0Vd+TjUb0BMkDz/OYyxAVS0xKnKmZ6uvRhIoVaCruT+
        95l0RQnlH6NNwkTjXjHkdPajZA==
X-Google-Smtp-Source: AMrXdXtzaHPD9Hc3eiS4yWeAGkPZVVMYWzvh9WYT8Vza1Xd3bpwbjTJVVRviianjCkuwAHecKYeutA==
X-Received: by 2002:a17:902:e54b:b0:190:f536:e4a0 with SMTP id n11-20020a170902e54b00b00190f536e4a0mr3656585plf.20.1671114558216;
        Thu, 15 Dec 2022 06:29:18 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.45])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0017f5ad327casm3922010plf.103.2022.12.15.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 06:29:17 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org
Cc:     liwei391@huawei.com, mark.rutland@arm.com, mhiramat@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/2] arm64: Fix pending single-step debugging issues
Date:   Thu, 15 Dec 2022 19:59:01 +0530
Message-Id: <20221215142903.2624142-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set reworks pending fixes from Wei's series [1] to make
single-step debugging via kgdb/kdb on arm64 work as expected. There was
a prior discussion on ML [2] regarding if we should keep the interrupts
enabled during single-stepping. So patch #1 follows suggestion from Will
[3] to not disable interrupts during single stepping but rather skip
single stepping within interrupt handler.

[1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
[2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
[3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/

Changes in v4:
- Rebased to the tip of mainline.
- Picked up Doug's Tested-by tag.

Changes in v3:
- Reword commit descriptions as per Daniel's suggestions.

Changes in v2:
- Replace patch #1 to rather follow Will's suggestion.

Sumit Garg (2):
  arm64: entry: Skip single stepping into interrupt handlers
  arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/kernel/debug-monitors.c      |  5 +++++
 arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
 arch/arm64/kernel/kgdb.c                |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.34.1

