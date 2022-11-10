Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D730624BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKJUfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiKJUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:35:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54D4FF99
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36fc0644f51so26073497b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTisTjUIrNkCCyr4cBDa7S6OIhSv9dwgO2DzrZiSE80=;
        b=ZdCPwF6lspGNSSyrb0tpnZ31ekYKyax6xWK8BW5KDDlXZZE8z1sCV4DsiArEXI2rSa
         lzjcNcnBDA9tVUoXbC7xjo8ugGIYBqVbdE1On6aHQn+fNnBs+ZFkKoAKjO4+Z+Lo8kJF
         PvGRuaeOV4K8QyZ/xMAoo6gENYYZEYzzjIB8rExl42ltExZhXmyAHJVywDfCMJ8yHkJd
         gqwTdKwGdfSRZfBnpMAsZoLmK29HKuDcl1g44LmaLhTxa/P+CfUPiyGwZ7430VZ2OPj6
         7+dp3N8YxE6jK56BY/L1epDXCYyS59msTMmZWLhH9ADBag8FRftpWsEm1kExjwmEncLR
         wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTisTjUIrNkCCyr4cBDa7S6OIhSv9dwgO2DzrZiSE80=;
        b=uYw+BEAJnkStyyJv04QyQEj21Wi3rTIYmpJJ3PQYDfbLcBsHJxFoA8aKOztrUQzqES
         NKFOoJxGjLfkgD7sP2J+A4IthjxNJxZ+SpMR8URfypDEuUcY/N2dEFdjN+5jt0Gft5oh
         9ZP7golGq32+qAk+ebe78mw5LUrBzOequhh80/7DuIdq5bOhT/NXbDBELQrjVP4/MLTB
         fIRtqhObyYK52x0DFHGWPMj+Gio55AUPbTdRyOjod4b2LT2qxbh4XWbgp5tpdg8WZBhf
         PvqWytQUV2i0RMcvRG10r1ROS4Z0gGvQAOu8f+duxJMUxtDkbjbay3G0llObxWXrmSQO
         4RCA==
X-Gm-Message-State: ACrzQf149+LN0LS5QEFrC8PNtnUgnRd9dpU+5JzoXyQa6uusPZtRH+XC
        c+8qOmaKFuOYwixEoLurlRqR4sLFp24=
X-Google-Smtp-Source: AMsMyM7a/KLlNFU5uST2o2eu3B0kOY/YIhg8n1dkNBkyAPYMrl8Elb7/Fm8PpFxGkqZe5a9ILfpo0b70FyI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1181:0:b0:6bf:bd96:2b01 with SMTP id
 123-20020a251181000000b006bfbd962b01mr62705133ybr.17.1668112506706; Thu, 10
 Nov 2022 12:35:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 20:34:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110203504.1985010-1-seanjc@google.com>
Subject: [PATCH v2 0/5] x86/kasan: Bug fixes for recent CEA changes
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Sean Christopherson <seanjc@google.com>,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three fixes for the recent changes to how KASAN populates shadows for
the per-CPU portion of the CPU entry areas.  The v1 versions were posted
independently as I kept root causing issues after posting individual fixes.

v2:
  - Map the entire per-CPU area in one shot. [Andrey]
  - Use the "early", i.e. read-only, variant to populate the shadow for
    the shared portion (read-only IDT mapping) of the CEA. [Andrey]

v1:
  - https://lore.kernel.org/all/20221104212433.1339826-1-seanjc@google.com
  - https://lore.kernel.org/all/20221104220053.1702977-1-seanjc@google.com
  - https://lore.kernel.org/all/20221104183247.834988-1-seanjc@google.com

Sean Christopherson (5):
  x86/mm: Recompute physical address for every page of per-CPU CEA
    mapping
  x86/mm: Populate KASAN shadow for entire per-CPU range of CPU entry
    area
  x86/kasan: Rename local CPU_ENTRY_AREA variables to shorten names
  x86/kasan: Add helpers to align shadow addresses up and down
  x86/kasan: Populate shadow for shared chunk of the CPU entry area

 arch/x86/mm/cpu_entry_area.c | 10 +++-----
 arch/x86/mm/kasan_init_64.c  | 50 +++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 24 deletions(-)


base-commit: 0008712a508f72242d185142cfdbd0646a661a18
-- 
2.38.1.431.g37b22c650d-goog

