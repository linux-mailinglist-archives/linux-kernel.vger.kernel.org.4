Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49EF73C45B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjFWW4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjFWW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:56:12 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3A271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:35 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a98a7fdf3bso848254fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687560934; x=1690152934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPrIWn+cvb1S/UxMPBEYNq5YDo7AvW0qpESms0jFO9k=;
        b=Apprjm6nwEoqnJSOJ85paKfuZpoq7+ebBjkn1xcr5jFpt61KDcQgmluamM+eTtrnoQ
         cZbC0HXyQpeqfheDseZf+jTc/GgCLia499o+18rBQcgmHvX6qeFvi/UD4mr6ek/7T+Ps
         lZgutYQl8P1CZiz5QgLXoRPq7ewQXIYLGrz/CeY9YdmeX4WrwXpax2DzMXKkaXlLpOJT
         WoLI7xCGgZR2qM8LZybZ98vnQcwSMDmOx7/tzMBcoUhNV6gBQQTcEktjprBdf7/8GFid
         i25t2Pnz/YUcZktFGTFFOj3X5uIWhEV2rto9l3cKwChr9rcKc305Stj7VHAOjhkyZQWa
         BwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560934; x=1690152934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPrIWn+cvb1S/UxMPBEYNq5YDo7AvW0qpESms0jFO9k=;
        b=cCByRr8P82M+++MmBF3+mp78t7QKlLD7UResjO9xh8cE18J4co7vccR6HJoKgPV0dZ
         T0Sa57BV45a7BJyAyp80P03jei1ZkOdoeDfIwoD2ofz6jzAWgH03+w1gV5xHY/24eNH7
         kqYIWvmY+40/rN/xy2RWPWCjsNNBUaJCF3xtF+AqX7onCRZY+8KBLSQh2CRxxqaACg3P
         nEGxXWk67HUZDjQsXvRl9JMWqZBKhZ+x8nQcWx06/xrwPDTyjVBActH4TLVjs5Lr6gxC
         cBBLmPloIVXTT5NmtlDXRrvLFbJJbGjKOmAuYUWobfcgIJqZJJNBsc4qrP//W2fgON5m
         iJxw==
X-Gm-Message-State: AC+VfDyhw8Tlt5+RpYeZTd0RfEJbIYDClGz/jlMUvMWBJtDOX+SY7L3M
        MpGA6mFqz7msMlbWi/fBihg8t8BmeQ==
X-Google-Smtp-Source: ACHHUZ6vgLZe9wMNWULVUCOrjEOsCUJGBVa9mhGcxRUqMpGXBd5HahZ3ZsLBlPYCfUhiIGC8Rk4viA==
X-Received: by 2002:a05:6871:711:b0:1a6:98ca:4377 with SMTP id f17-20020a056871071100b001a698ca4377mr11759744oap.24.1687560933784;
        Fri, 23 Jun 2023 15:55:33 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id b21-20020a9d5d15000000b006af9d8af435sm267479oti.50.2023.06.23.15.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:55:33 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 0/2] Rewrite ret_from_fork() in C
Date:   Fri, 23 Jun 2023 18:55:27 -0400
Message-ID: <20230623225529.34590-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kCFI is enabled, special handling is needed for the indirect call
to the kernel thread function.  Handling this in pure assembly is not
simple, so moving it to C is more appropriate.  Instead of moving just
the indirect call to C as Peter Zijlstra has proposed, this patchset
rewrites the whole ret_from_fork() function in C (other than some
necessary asm glue remaning).

V2:
- Fixed wrong address of pt_regs being passed
- Simplified 64-bit asm stub to not use a tail-call

Brian Gerst (2):
  x86/32: Remove schedule_tail_wrapper()
  x86: Rewrite ret_from_fork() in C

 arch/x86/entry/entry_32.S        | 53 ++++++++------------------------
 arch/x86/entry/entry_64.S        | 33 +++++---------------
 arch/x86/include/asm/switch_to.h |  4 ++-
 arch/x86/kernel/process.c        | 22 ++++++++++++-
 4 files changed, 45 insertions(+), 67 deletions(-)

-- 
2.41.0

