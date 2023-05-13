Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3170127D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjELXbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjELXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:31:31 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7F1B8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:31:30 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643bb9cdd3cso8275250b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683934289; x=1686526289;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOZreDabNqpUj7u+V8APqRqu4TK74uLHH24UEDNUCHI=;
        b=Zja9mH7oY+lw1E5/US7t2dlayN3yjG5xJZYmUi1MDWPsxw2Sy/jDu9vsw5olTvhSNd
         QCgQkjoYs8efeFbYFt87WjqxowUr6XJhvHeiVn9eyKykCmOnrNkC55/LgY0EDQKPJWim
         a6bM36P7UC21fS6BS4B6XHLZIivgPIeib0cLg0JTtNa1n0cX/fMBHSQHX3dvNKG/WG8t
         7N6LK6oLs/SBnJzm/i9BkS6O236X4516CUCogNmtvONYwYxdHDnwbvIqcgYmEUafFWKk
         UvqFOltbKLn9ANbffrpoouV/QgP0kXGjj8DMEuk7Yewe9MtzPew9TLs8tss9e/tpkpqd
         7WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683934289; x=1686526289;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOZreDabNqpUj7u+V8APqRqu4TK74uLHH24UEDNUCHI=;
        b=FgJli5+TENW21a6V2J86weG0gWcZKuPwhnflK/iXGzsPJRU2BkMVxZ/4O8SAyqCP+P
         THKbHL6erI8XKQw68OFWonczFbV7iXc/W8Nwbwc/k9VUKTr2bwES4PfSmxsuwftZbgck
         GUJAxW9xs61cTz9MGgeE0H1H78Ra9pQwA87464brkevOtqEMudLsCie+eY37Ln4J6rPp
         umy28q2kJ/apgAq3mOdke8bEZRfsC0WvIiQcKDNlJEAddday5p3cq5ItvcMm28khhzxt
         O8K4/OyKL8QacPKbVqLp9rm00njKCHWRjU8clib+Ejr3bneihG+SuMM2wMX1hxwlJfhe
         m12Q==
X-Gm-Message-State: AC+VfDwcHQvprgwxBe+SFDKx0A7YEjTsf5cwBm+uKG/hk6lp4bBGOLm5
        gngPXK+n7j3tSSZHrcUvoNDiV7nFcMA=
X-Google-Smtp-Source: ACHHUZ4+wXYsC9AiEzl5m7UK3UfElGCg0UgJLKMd3X0fuTu7gvDDXKM0VCK/mWN3zQh5HT0lfa6pt+xxtg8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:d42:b0:643:a029:5b3f with SMTP id
 n2-20020a056a000d4200b00643a0295b3fmr6979951pfv.2.1683934289733; Fri, 12 May
 2023 16:31:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:31:25 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512233127.804012-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: Fix race between reboot and hardware enabling
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where enabling hardware virtualization can race with a forced
reboot, e.g. `reboot -f`, and result in virt hardware being enabled when
the reboot is attempted, and thus hanging the reboot.

Found by inspection, confirmed by hacking the reboot flow to wait until
KVM loads (the problematic window is ridiculously small).

Fully tested only on x86, compile tested on other architectures.

v2:
 - Rename KVM's callback to kvm_shutdown() to match the hook. [Marc]
 - Don't add a spurious newline. [Marc]

v1: https://lore.kernel.org/all/20230310221414.811690-1-seanjc@google.com

Sean Christopherson (2):
  KVM: Use syscore_ops instead of reboot_notifier to hook
    restart/shutdown
  KVM: Don't enable hardware after a restart/shutdown is initiated

 virt/kvm/kvm_main.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)


base-commit: b3c98052d46948a8d65d2778c7f306ff38366aac
-- 
2.40.1.606.ga4b1b128d6-goog

