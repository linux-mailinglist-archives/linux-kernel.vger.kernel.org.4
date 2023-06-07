Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B9726CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjFGUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjFGUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:35:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F71FEE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:35:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53ff4f39c0fso2492857a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686170122; x=1688762122;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anERRIco3r2Pzu1okFsSErGwX1u57H4zjQoU+iEzkG4=;
        b=v9vEEwAMrri+MzNgtR7kom2JjQE8LGwrhVherJ4PLHkyGznRbW9tBY07mSU7dvZzCR
         2Q4fobuI4mgLUsB2dXmumVzw6WHTrtPn6llvWR1Wzi1Tz0Q2pnjGQf0swgsaK24vm3Nt
         s1O38Nqo/1yG28o1FfOpQeDsHfets6OOQLmhx+MkMziQL/D68nrHoRKAEFWgYjd4oWYa
         ThAvUZbimDpv+/BZPybxj/+mw5N9P63fL8l6WRyoIfH4Lk4lrQiytdUabEeuHpO+iLbU
         W/J0DI/pnL7YYmConS9FaWuCMxKlTv+1hVA3LBTWre2qm/83EhUOOdmFzioq4hoOnAUh
         9+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170122; x=1688762122;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anERRIco3r2Pzu1okFsSErGwX1u57H4zjQoU+iEzkG4=;
        b=cZRerhd5sZZaLgQFuOkjlg5mDf00LeyuI74YeiDEsvOwMx5Te/WoblLB3rbk9GUImb
         1j/hr/PEYpv5hqLKZE3fK8Iuw93VsAKRdBzpphOwjroPV02I3rTm2GwhZoDSmGD+pwys
         30T+kH3/tWYfqNnsaMCPIgt/AxX+Yra4NxCcQSZDcGZRMT0+i8OXAqO7lfJbZtCcPClW
         tzwuV1YZSfq8eh3n5cFIt3nSs+9p8B/vft0oTKCJl4TFfmR2PFaPOwwfCWlKZjZTX5N+
         HXzlHrvt7ram2QTivoROj/ZCY11bzfUNEh+anXwE9ENaiAlKCdh8D8F3IfYMU1T447/J
         UJ5A==
X-Gm-Message-State: AC+VfDy8MrLKhZy1uc7Ix3znlKQBguGlZxQzE9/8yqUqRnWfQCWsBOt3
        kAiSRIY7zNMILGJJyReBFmv8wdMQfyk=
X-Google-Smtp-Source: ACHHUZ5ZK6Xqa68JBAcMUPiTMq8fiwzwrpi4nBTZWtdO8d3+4CXjpbW4rXaILDLepv5Ij16X/l210HWhM4o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7008:b0:1ae:5d12:743a with SMTP id
 y8-20020a170902700800b001ae5d12743amr2022899plk.4.1686170121670; Wed, 07 Jun
 2023 13:35:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  7 Jun 2023 13:35:16 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230607203519.1570167-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: SVM: Clean up LBRv MSRs handling
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>, Yuan Yao <yuan.yao@intel.com>
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

Eliminate dead KVM_BUG() code in SVM's LBR MSRs virtualization by
refactoring the code to completely remove any need for a KVM_BUG(), and
clean up a few others pieces of related code.

Sean Christopherson (3):
  KVM: SVM: Fix dead KVM_BUG() code in LBR MSR virtualization
  KVM: SVM: Clean up handling of LBR virtualization enabled
  KVM: SVM: Use svm_get_lbr_vmcb() helper to handle writes to DEBUGCTL

 arch/x86/kvm/svm/svm.c | 63 ++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 43 deletions(-)


base-commit: 24ff4c08e5bbdd7399d45f940f10fed030dfadda
-- 
2.41.0.162.gfafddb0af9-goog

