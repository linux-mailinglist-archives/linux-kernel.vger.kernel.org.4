Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB226C3F95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCVBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCVBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:15:34 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066C5941D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:15:16 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a6-20020aa795a6000000b006262c174d64so6201662pfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679447715;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SydnB1+QRF9IlXppuAgZ+ky6nRrQbHVxvC/XmUdsdiY=;
        b=jbFmzeJWI4oKy/KdMtcNefGi/r6vZHAew2gWJPwPFQBeCLaM3x7BHXo3wkMdz7HuP4
         /AicEu9/SuwbhW7Def92WFSyg3tAk65lZhGnogbcTY/70fU4vDq1nVz1+hdMH2Iq91Ze
         RqGGqsQjKBwq5/dcJ/RgXyln4HndGZEZeu5aMOY9k+Hoapsv4gRGdakqDVE0ZoxTGPWs
         l50YENqy68/Dj5pBxSODe4lxXrjmk1gOndViZ3m7COxLpbpalrVexiM0+up5A5LR2Irh
         8hvesS0Ijk3Jdjvw2d575es68SifE54lmcLabytFMQ4D14nyKMnyk/jTWtRlym6i3q0Z
         8eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447715;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SydnB1+QRF9IlXppuAgZ+ky6nRrQbHVxvC/XmUdsdiY=;
        b=Wpn3IK6gttwWawk/umsMjoyxOWihNOvLSUzBebt7q+QNtexB1tTtHCeTNsutAnFyOm
         3ccH7cQoj75lbC5ON3cSN/E7stG2if+ToytoEDIxuMHCeyt0aQfURZ1f+x1/fAdWGp9s
         6J0k/P+gW+0kAdXCwdtcj8FLic5Ju5iOYeXJCzIeEJcbDOhcVF52vLTu4DhaCuZsWnMt
         oXlokdd8d6iWzr2eqJwWmhYIr8i6dRxxpTqhhSqDnXnv9qRRLTvr1aDsL0EWmCFrth87
         KEIwQZTj8svUYKkQqTpa/4rrhfs+kJx8rHHoVVjxfTstxcJeIzR/y/v5bhQMfVS4rjyp
         cUPw==
X-Gm-Message-State: AO0yUKWqEV+93FvpTV665e392e5y8sqFof+UPH7/TZCb1szhdVu3tuvS
        S/Ku3vFV/xyDoET5pDOjSmyZuhgyZkc=
X-Google-Smtp-Source: AK7set/C+Mrs7e6RBw180foyiW/qsz+MhC3ndbGaQMNRY8m0dLAIJw3N3stj0FBh9Ca3ynCft1fEzq/beUM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:768c:b0:19f:6f30:a3f6 with SMTP id
 m12-20020a170902768c00b0019f6f30a3f6mr427886pll.1.1679447715345; Tue, 21 Mar
 2023 18:15:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 18:14:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230322011440.2195485-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: x86: Unhost the *_CMD MSR mess
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the FLUSH_L1D enabling, which has multiple fatal bugs, clean up
the existing PRED_CMD handling, and reintroduce FLUSH_L1D virtualization
without inheriting the mistakes made by PRED_CMD.

The last patch hardens SVM against one of the bugs introduced in the
FLUSH_L1D enabling.

I'll post KUT patches tomorrow.  I have the tests written (and they found
bugs in my code, :shocked-pikachu:), just need to write the changelogs.
Wanted to get this out sooner than later as I'm guessing I'm not the only
one whose VMs won't boot on Intel CPUs...

Sean Christopherson (6):
  KVM: x86: Revert MSR_IA32_FLUSH_CMD.FLUSH_L1D enabling
  KVM: VMX: Passthrough MSR_IA32_PRED_CMD based purely on host+guest
    CPUID
  KVM: SVM: Passthrough MSR_IA32_PRED_CMD based purely on host+guest
    CPUID
  KVM: x86: Move MSR_IA32_PRED_CMD WRMSR emulation to common code
  KVM: x86: Virtualize FLUSH_L1D and passthrough MSR_IA32_FLUSH_CMD
  KVM: SVM: Return the local "r" variable from svm_set_msr()

 arch/x86/kvm/svm/svm.c | 51 +++++++++++-----------------------------
 arch/x86/kvm/vmx/vmx.c | 53 +++++++-----------------------------------
 arch/x86/kvm/vmx/vmx.h |  2 +-
 arch/x86/kvm/x86.c     | 23 ++++++++++++++++++
 4 files changed, 46 insertions(+), 83 deletions(-)


base-commit: d8708b80fa0e6e21bc0c9e7276ad0bccef73b6e7
-- 
2.40.0.rc2.332.ga46443480c-goog

