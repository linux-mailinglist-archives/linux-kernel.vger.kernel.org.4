Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C7687662
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjBBHcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:32:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406C20D16
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:32:04 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so981174pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tmb0HvG17lR3HM/pn9ITfJlpLMo0J+0/VmIcQoXEYTo=;
        b=LCjAFhZjfg5vRuF/JcColBokHhNiC/Gil36UGcekT2zgvnPMp5/y9enM1V+67agyh0
         PVlupnnNQlbO8jE+LRXyzYOGbDenj7OWCvWZltA8N+7sahG05JG0KT/NIOtV4rJRsxQQ
         5JGFSt04Ty5S8fUxAROkQs6yZFGRBgyHa9FrInO0CQOVSTQ5xaoeLLqXzzO+9nnqgT0k
         XMfWc96v+FtYTSUilBn9eaHu/9OYMu5671o4Bm8buPijZF1BptXLiTx+armGHyezU4c5
         GRuV1LfGj/BbFvzxlYjmDVB5xdp1f+KINEGGO83xGktKBqyahGxmDOlbojHSACWed8e0
         aatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tmb0HvG17lR3HM/pn9ITfJlpLMo0J+0/VmIcQoXEYTo=;
        b=S8qUqhhjS0DhxfkKmhtCiJ/7FpMF/N42wh8DRl5hTkOGKpJxUMisEiCEh4XZOA+VZt
         mYLCUs/SZNkS6h2nLasrFZRWM4sH5dmAPexDRscXcN3ftngzID9zUL3ZO4SLgkR3LWFC
         LDC2hfLv79eh0ZIefy3jZGv268fC96sSxo+OXB2wtzOb47VBuLoe3AhvTBeAUoAvONVJ
         mvP6RDRicYue2KNLxdYEtZb4PY9BNIsXeMBiXRqfbOALBk835TRbwxXpsz7yNF5Ptycj
         j3TgHhNjw1ZGipynoiNuFz7ymbjuEVGScyzt7EE4E/tmm2tlQcAIF5uf7ipGOG8dg8eR
         TOgw==
X-Gm-Message-State: AO0yUKUJ3nXVdIDh0Wxc7yNtudgPfKGLwXZ3Se55Xg6QSDHnK6CbxpDR
        aKRpuEiryzN7yoBaeVvqremj3w==
X-Google-Smtp-Source: AK7set/PZSRWBrfcMrIphz9zbcCCectwhWEzsmK0x9GFFLGtbHN0aXgwuMF6LUXiG63FL6t7JD4N7A==
X-Received: by 2002:a05:6a20:12ce:b0:be:c80b:a8c3 with SMTP id v14-20020a056a2012ce00b000bec80ba8c3mr6997681pzg.42.1675323124311;
        Wed, 01 Feb 2023 23:32:04 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.222])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00196077ba463sm12959015plg.123.2023.02.01.23.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 23:32:03 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        dianders@chromium.org, liwei391@huawei.com, mhiramat@kernel.org,
        maz@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 0/2] arm64: Fix pending single-step debugging issues
Date:   Thu,  2 Feb 2023 13:01:46 +0530
Message-Id: <20230202073148.657746-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
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

Changes in v6:
- Fix incorrect rescheduling check introduced by rework for v5.
- Patch #2: s/kernel_regs_reset_single_step/kernel_rewind_single_step/
- Collected Daniel's tags.

Changes in v5:
- Incorporated misc. comments from Mark.

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
 arch/arm64/kernel/entry-common.c        | 22 ++++++++++++++++++++--
 arch/arm64/kernel/kgdb.c                |  2 ++
 4 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.34.1

