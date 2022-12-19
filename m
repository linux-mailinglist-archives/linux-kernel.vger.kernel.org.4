Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74EF650A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiLSKZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiLSKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:25:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA5DF8A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:25:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so12506056pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K37gbY5Dl8sWIrBCYlNI70CebPhvB+1SPLpodhsI8Ls=;
        b=DcGzl2I7MILyelixxwuz25J4rmnqa0G05scGyE3bfVtF35zCpUdcXHKrHcTbkPtiWj
         uPESG1PUqJ5wcR/57uEmhY7NnCFerUH6JMg/H6cFqtGuoMb6/cpmtXsW/VgER7a879Ni
         x2a+GxGWSNfheBBY6goh9bbjNVlsgw8eADhqbtPJuWoO5n2XJHBY0OwhzmQla2/bXL76
         Gj7FY+puAIgDNJvZkf9JNFhUFIyIHYMhdo4ldIOOYXQkIJNaM4zJrGf8f0SQtmmynCPC
         gfDgQYf/qsupgOQIBlO33r10WosIT/5HDtvC/2985dDY446pjpfDDOufQcjr5kGNCHyg
         0RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K37gbY5Dl8sWIrBCYlNI70CebPhvB+1SPLpodhsI8Ls=;
        b=5lhiFAfyghUg8wEO4c41R/bJzwD51PdfMMplkSddEzDWt7xKjt2GegdrjevjNWHxfh
         rA54IEaN6xB/+96WpTC6f3bTEGATicWP/W8rZynyIUN0OzRq/ChqJ3q2Ku1+cXqWhu8Y
         D31CLGHd38mPrhIUhFOMJm0ns+C0tkyNG7qKH9V1PHLZh3M6/8TDwrTiiTrHwq5Qd2Kj
         8m4NAdf5UlKVrfLUiFZh75lV0Nu6GPqg7JxsNkjhJuhCJd+Z18NDo58DJOYV0R+ahSWs
         IxRZB2aO/fMTNNYX1jtFlG76dSL9LUKAwcrA6COEwsv/4mBla+spdWJhqiWm/453X4t+
         1PDA==
X-Gm-Message-State: AFqh2krwGDfziPFuIU4/LZ6nlCZmdYHerzttrsJrF3uAEsOWt2vfBQdf
        keq6tcFOc7h6YAQQCXhnhjsJtw==
X-Google-Smtp-Source: AMrXdXsdoBzxcvCunzKRloTBXDqSFwctK8CWxZNCjAFdUgSQVoY0Zypl1qwnE7PnzuPNeOviz3osyA==
X-Received: by 2002:a17:90a:6acd:b0:221:684a:d05d with SMTP id b13-20020a17090a6acd00b00221684ad05dmr9251001pjm.45.1671445503842;
        Mon, 19 Dec 2022 02:25:03 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.5])
        by smtp.gmail.com with ESMTPSA id 89-20020a17090a0fe200b0020087d7e778sm8832731pjz.37.2022.12.19.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:25:03 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org
Cc:     liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/2] arm64: Fix pending single-step debugging issues
Date:   Mon, 19 Dec 2022 15:54:50 +0530
Message-Id: <20221219102452.2860088-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

