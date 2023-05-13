Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966A7012BC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbjELXwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbjELXvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD103C18
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9963a72fd9so23006660276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935452; x=1686527452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NGpdato6VaRWPtVy0Xb6XT86ae084/tGO9eQqIWQisY=;
        b=V2qg6pEosKPgYv3xz41qbCC3jZh3J/DMpqxtXWZWSdb4Ni+x0zZ5vCpcKbqxgfMZsk
         4/HMGtfVm92qSukpIHjzQLbcctI/0nYPoKDz7u6Xw6EGorFkECXVGzTB42dJ6sl8IDdI
         GgetN+C74aBQrJerUDzJ8wNjSeIAt9ke2QK9imegSnLDhp6qzZha+dgfpGtZ+wU+5FYm
         RHZ30Aiz5XnUg6Gs5ATMZpbdAvPVOGrACllSwdAT1QbTvxk+M/ujU7zyw0cGhTi9tf5k
         d+EN5OCDl2Ox76IMlNw5CZnfSwnJF7sDQBwjp1awamDyJ6L0+AO9U6b6xWGauGtaupRY
         hb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935452; x=1686527452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGpdato6VaRWPtVy0Xb6XT86ae084/tGO9eQqIWQisY=;
        b=fZcwVAnqNETZ3P//TwssGUX2jy7mPJta3vg736CRyG6HE/73DoO+JsNbSrASgwz0/n
         NcBhxVpWCoArDZIK9MYKVFCNFL5CcScP5QosH8OuhMr/VLZIqvDWuzisnhd0YaZJHH/7
         DDHLpVmmsUnujkzdc267VWEga1q3pG5xd2dJDp18wyvYOORMpKwsHR3H35sK/8QiliL9
         Lk12ruArtM2D66AHTaDmOoIJ4er5AdWNEdf8Lv9pJ68dPqv1v2RpN0HxfjJ8hngGxuln
         UcmtGDaMO+A95hUVVmiUbyeOlp+W916MQCki9zAdqW1uQyKEnplDyHaWuzcr2IZ3b7iA
         HwrA==
X-Gm-Message-State: AC+VfDzAkc5idGzEmSgnTfnDRUQSNMCVIr01U9ekxbntI8xNamDP+WMJ
        0guwkhdoHTsU3E29D3aTOYPyCC8nzhw=
X-Google-Smtp-Source: ACHHUZ6rQgl83+ScHZSi2/PDJHLoq1j4+/LxtgMXAergNcCdWFhZr9rrfgNmnsB6NfpnpRo5P74OuUDuLWU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:32cf:0:b0:ba6:d183:5541 with SMTP id
 y198-20020a2532cf000000b00ba6d1835541mr3493648yby.5.1683935452176; Fri, 12
 May 2023 16:50:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:20 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-13-seanjc@google.com>
Subject: [PATCH v3 12/18] x86/virt: Drop unnecessary check on extended CPUID
 level in cpu_has_svm()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

Drop the explicit check on the extended CPUID level in cpu_has_svm(), the
kernel's cached CPUID info will leave the entire SVM leaf unset if said
leaf is not supported by hardware.  Prior to using cached information,
the check was needed to avoid false positives due to Intel's rather crazy
CPUID behavior of returning the values of the maximum supported leaf if
the specified leaf is unsupported.

Fixes: 682a8108872f ("x86/kvm/svm: Simplify cpu_has_svm()")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index a27801f2bc71..be50c414efe4 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -39,12 +39,6 @@ static inline int cpu_has_svm(const char **msg)
 		return 0;
 	}
 
-	if (boot_cpu_data.extended_cpuid_level < SVM_CPUID_FUNC) {
-		if (msg)
-			*msg = "can't execute cpuid_8000000a";
-		return 0;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_SVM)) {
 		if (msg)
 			*msg = "svm not available";
-- 
2.40.1.606.ga4b1b128d6-goog

