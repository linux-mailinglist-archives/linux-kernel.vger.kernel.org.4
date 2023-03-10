Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DDE6B5407
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCJWOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCJWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:14:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B94115DE6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:14:17 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i22-20020aa787d6000000b0061dda189477so3504895pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678486457;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o66EQfRmNxj+8F9jQg6/TZSeZfgO5WRCRyYyFHjsDdI=;
        b=TwMa3uXaJ/UYaq3eCVBhXdLLTBKJpqP7TapiMeVQQ8a9a3fdYAN7ttsg4P9jfrrsF8
         xUjcebWBSQqB34rXHC0GsJgb1rwQ6lGUXUSHYihGJrvHCayz5tkQgedJ3V9G985l6OXN
         fUDafN+8jo+SAVLa6b+gsNsVwmwUKOcRmGUdY280AwstjVC+S/SC22eMPXAcqRRdEU77
         wBIRL/FBFCnTfA7H48+xC+vGrenXEb1/X4N5KKU2IiVLQlyYMquH2BwZEhy/6xVYAYww
         Vy7lCsYX1/GGHaVWVEedLosBE0844f0lEyS14Z1tJajmZbl+IAjkU2lZwqMvnW0aop6L
         Qd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678486457;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o66EQfRmNxj+8F9jQg6/TZSeZfgO5WRCRyYyFHjsDdI=;
        b=fXXpqLfWIYe2gYE8phzof8b71YQ/qImNDQgS16DIoBLCX3Eievf7jrEadaFWer5Mfq
         clNc/mWWXDCaNPFGUu+s+frr4HlotgwEu+21yVxJnBCyq7k40E3jyIB1JA7cZ3WLsXPE
         GSdfVBzA5HDyVYlfVZEpt2YczEXTPjPN++8uIaP87f5tRdwpTOthNZ4y6XvjkWufRgLJ
         rq+tf2s24BsEsHeFM90Z9Ocy1N29nXZ2Uw0uSL184fbgkrQfo66Sw6jvqCROKXrXcpgR
         dnv6DG+Mxofz9re+XE6lFRrN+5mLvmNA07/Z5x7JP9yPhCNuGeE2akLZZXHjnkhzhxCk
         DoNw==
X-Gm-Message-State: AO0yUKVLIGLMsQ9CF9bSNWWyuZy8r2oV1Hkg3FWXjM04QuDHLDHCLi0v
        5bTxolmPIiIdoV0YjFcpaDCkZfwTt8E=
X-Google-Smtp-Source: AK7set805goRIsvSnul2pFSt3XcMbMwyPEPkZcFMUxZ30t6oqEBqPbhDmjMy4wuRS+A0hc3zwjCrmOjJRYw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dacc:b0:19a:6b55:a44d with SMTP id
 q12-20020a170902dacc00b0019a6b55a44dmr1555083plx.1.1678486456993; Fri, 10 Mar
 2023 14:14:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 14:14:12 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310221414.811690-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: Fix race between reboot and hardware enabling
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Tested only on x86, though there would have to be some seriously subtle
arch and/or driver code for this to break other architectures.

Sean Christopherson (2):
  KVM: Use syscore_ops instead of reboot_notifier to hook
    restart/shutdown
  KVM: Don't enable hardware after a restart/shutdown is initiated

 virt/kvm/kvm_main.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)


base-commit: 45dd9bc75d9adc9483f0c7d662ba6e73ed698a0b
-- 
2.40.0.rc1.284.g88254d51c5-goog

