Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA6624B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKJURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiKJURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:17:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298C50F23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:17:10 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q93-20020a17090a1b6600b0021311ab9082so1617642pjq.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfKHaD6cbSSWqGqF29LX7wOSKlH4iPXYasLJXyiiA9w=;
        b=tkvs+ltyClO5qEc6IGHzTNYPaZihZ8PgmqKo4goqrT68rhkjBPUygnE5AuO8BWe1el
         7FUhPE+eH66r0qqBXbAbb6lX5ACmY7HiSrlfuZ4WqYtU4b5zJWJxgdHvXKOEGL1r8R/n
         i2i7YxZYxP38iYqe+kpLXdSpS8K7K5QpuO2jJL47Jmez3zwA4cD0irRPyiIjd7LrtOkJ
         N7uDnk56XBKSsw3tfAazvddriegp1lf+K38vcOB995hEF3+vd3WMXmHNQj7pdgoLbkjo
         akrO1kUMwKF4X15RejEom5g+QYWN/dia9h75rwKZNbSkB0TdyC0O39li1Xw76nzQN0lX
         RfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mfKHaD6cbSSWqGqF29LX7wOSKlH4iPXYasLJXyiiA9w=;
        b=tXpg8eMFAecif9NumFb8z6UE6nfJRH9n2u33nKhoMlbo50xSSMULY8tJnVKYijKX11
         xAOPL/SMrIK8MeLqyegneGXX5bY8RSUNHS4ig3a9ReEwnDh+RUdn9USatWi+W3B9G+qZ
         LUiXaydk9SUQUUhu0u0vuEtB3TcVJghqorYq/lKFkPPg6FfY1QwiTx/fAQM9FtRR/AZd
         od/iHeb9F6NFwRlBFsxeufdrKa8FdcqdzD//HYpQc9ccrTg6PNO2hLuYDp0qsPsLNUSI
         hFi1iQ8X1r9rdtTQSgKZMvHhWkdWxShA+t1pAG1bkOKknq2udVxiVLcXFsqGp6fdNOaW
         ZXxA==
X-Gm-Message-State: ACrzQf3VZI2csQaThfRfykUbK8zI2NK+u1OGBS6qfA0NzYu1E5pkTpdK
        8Nl9D7ZTxu44A0K4z+fII7RdOvJvdys=
X-Google-Smtp-Source: AMsMyM6UrQV7x/ogAudTr1WEHqz0fZqaZkT3ac5o0dVZwQI/oLv8/RGEuVmI2RJ65xJ03sonZZrE8I9u9iM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3102:b0:213:b853:5e45 with SMTP id
 gc2-20020a17090b310200b00213b8535e45mr1908437pjb.97.1668111429969; Thu, 10
 Nov 2022 12:17:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 20:17:07 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110201707.1976032-1-seanjc@google.com>
Subject: [PATCH] x86/debug: Include percpu.h in debugreg.h to get
 DECLARE_PER_CPU() et al
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include percpu.h to pick up the definition of DECLARE_PER_CPU() and
friends instead of relying on the parent to provide the #include.  E.g.
swapping the order of includes in arch/x86/kvm/vmx/nested.c (simulating
KVM code movement being done for other purposes) results in build errors:

  In file included from arch/x86/kvm/vmx/nested.c:3:
  arch/x86/include/asm/debugreg.h:9:32: error: unknown type name =E2=80=98c=
pu_dr7=E2=80=99
      9 | DECLARE_PER_CPU(unsigned long, cpu_dr7);
        |                                ^~~~~~~

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/debugreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugre=
g.h
index cfdf307ddc01..b049d950612f 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -2,8 +2,8 @@
 #ifndef _ASM_X86_DEBUGREG_H
 #define _ASM_X86_DEBUGREG_H
=20
-
 #include <linux/bug.h>
+#include <linux/percpu.h>
 #include <uapi/asm/debugreg.h>
=20
 DECLARE_PER_CPU(unsigned long, cpu_dr7);

base-commit: 7420ae3bb977b46eab082f4964641f3ddc98ebaf
--=20
2.38.1.431.g37b22c650d-goog

