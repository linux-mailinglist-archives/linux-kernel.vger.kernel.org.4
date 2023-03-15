Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F36BBCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjCOTLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCOTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:11:32 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F44574FF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:11:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k3-20020a170902ce0300b0019ca6e66303so10923686plg.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678907490;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMgQGTcQjG0apjFdBh4p98H0FGogKfOZzjyv63Vic0Q=;
        b=PS9yB0zbrgicj/S+F9jVRLy9Bg2xZ+x7h3A4GUwtW2eNIQ0Ag9XoHyb6qztTR644TK
         SWT6g9lcTGOM7uH/GvnCH5rPSIEcw3BFr3sk28tByR6dL+HuccklPsuhNaUOrMlG5rwz
         7rMPU+aE+6RPs6UCjft0c+Moiq2hcV24ky17FgXpEKz2QpbJC6TZ/fKUQAM/vsd8JxTz
         dkWmqruc3n9dNxTzrm8KNzBOJQMPh/xuDB56NKGjrk1foKSqyZGB++V8tQuxVbCm48Fb
         JGzmKjjImWEbIJjVorgy0Nt8CLJ2X2Ag0SI3be3pD44DIy2JLdGqc2ucl20CoQ7IxZr7
         bCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678907490;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMgQGTcQjG0apjFdBh4p98H0FGogKfOZzjyv63Vic0Q=;
        b=FPhWbkAbnaFf7tssU8UI0LvaAi5cUzvq/9G7byMl2xH/mflEyGmmonezqrQcbaWXMs
         XUC5tEllOUZ9v29Dr/UIhHL3iYMaBDAPYQ99CGLW2N3BZfVtClTAxIEzgNGrM8FU4jK7
         LFJskKCRGzko8shDSCGHX7+4V6ljdEGHVBmmxvwPSnPBM1hlqUr2rmr5RaCvgF6w6k0G
         tQ5OXhe7JQXFHl5uRLKsgJ50cfJiklPHWhkgBiz2S/xqf7TIKyGZqboTLREtKQ6Us3TQ
         yHOJ/H/JiT8V+GcJtGijAS5uUWf3clOfeGKdApdbze5HIhuMOsiYRewLJB+1VWhqHIPV
         KqsQ==
X-Gm-Message-State: AO0yUKXigXEVJwbkDws4af9vqfD4ZuqFTAeIK1X8futBDbKqwaK0riOj
        0V6j+VDMacPtC84PyGG1KL86e9Tt6oU=
X-Google-Smtp-Source: AK7set8PX+opwBT3EzkxyYEVCN9z7q6FQj97cN39fn236CRigfg8YikKQF4ZGqzu01U/czta/Mcr9fBtJNg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:844:b0:625:5ac9:3e02 with SMTP id
 q4-20020a056a00084400b006255ac93e02mr370308pfk.0.1678907490648; Wed, 15 Mar
 2023 12:11:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 15 Mar 2023 12:11:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315191128.1407655-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Fix kvm/queue breakage on clang
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
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

Fix clang build errors for patches sitting kvm/queue.  Ideally, these
fixes will be squashed before the buggy commits make their way to kvm/next.
If you do fixup kvm/queue, the VMX commit also has a bad SOB chain; Jim
either needs to be listed as the author or his SOB needs to be deleted.

Sean Christopherson (2):
  KVM: VMX: Drop unprotected-by-braces variable declaration in
    case-statement
  KVM: SVM: Drop unprotected-by-braces variable declaration in
    case-statement

 arch/x86/kvm/svm/svm.c | 5 ++---
 arch/x86/kvm/vmx/vmx.c | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)


base-commit: 95b9779c1758f03cf494e8550d6249a40089ed1c
-- 
2.40.0.rc2.332.ga46443480c-goog

