Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344A64AC32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiLMARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiLMARJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A11B1DB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t9-20020a5b03c9000000b006cff5077dc9so14755375ybp.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh9OV8WXLZqVkS0eTF+TxxkJJsKrkd0m2OX0yvUCB3o=;
        b=sw5AF+UJzrAam2lKYUO+DY3lJy12wG52jO14k7mzCjLcxxLIwp1wBpj6wVqYtqBXVF
         59vS4E7gW4naKYM6Hk7aGKYpNTStZA8AyeHKiS1Zp63lxywrCOInD4USN6MkBgBw4NoX
         eN2lxEjW9PEtkdVREzFNueicrHCc0exuvCAPIMk3YVVS7eklH+VcuXQPTh0ZS9Sd5LX8
         cGWE/0zqnV0g/j784hDl74HTeHWiysY9ZLAx8E3jTWdl+pYwXeHcFR4+9h/Mt74o1u5K
         B3cgL2TWXr+P5NwxWcePS55Ar3q2GV+q43pv8aj7jsOs55kDdd5RUw2jebRRAKHKGp8g
         1SMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dh9OV8WXLZqVkS0eTF+TxxkJJsKrkd0m2OX0yvUCB3o=;
        b=2uT2VmJPrytU/NxISZPUEQbnxwWQT/5GBpcWPD6C+29QMGe4YsKzYejZpjxt9kfPr7
         ZRfBzs83B550804YEBK4BsOS96mUF9bD5vqmQDnYC1RHtL/fC7O6H/QUetB7vesdzPD1
         OhTNCzpKm53FNjS/6wZtM5aCLAoc7bu408TCC/F9PFFx8UxBqbFkrt1CpO791DVf4f3e
         ZN8F7Gm7oFcUnniifzLELyVrCKEq2RNnBFwiz4DInw2PU9LctV6wg6fawNExBPGKD7oY
         MBxha8V4k0z/ukFkncOROBH1GfM1wRrbuJtC5wmvRJvs+jWXd85xmsGSaFkQGDSGiYn1
         2ltg==
X-Gm-Message-State: ANoB5pkFU/gaoVwWQxj4t2B6Cm0Js8TtAa9AyyM//E+lp/+WswW1xBq3
        bKiFegMGVsZFYTlYrHIjfx/aADhB6lw=
X-Google-Smtp-Source: AA0mqf6PAlQug9BZraIHZdHpqKIVbXCcKOa0uk6qj29geZVqkrX39aClmamGhM5+3qzba2DS0aZNeAJ6gmU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca0f:0:b0:38f:fa8e:99da with SMTP id
 m15-20020a0dca0f000000b0038ffa8e99damr12937224ywd.355.1670890628580; Mon, 12
 Dec 2022 16:17:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:46 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-8-seanjc@google.com>
Subject: [PATCH 07/14] KVM: selftests: Use proper function prototypes in
 probing code
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
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

Make the main() functions in the probing code proper prototypes so that
compiling the probing code with more strict flags won't generate false
negatives.

  <stdin>:1:5: error: function declaration isn=E2=80=99t a prototype [-Werr=
or=3Dstrict-prototypes]

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests=
/kvm/Makefile
index d761a77c3a80..c22c3002492d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -196,11 +196,11 @@ CFLAGS +=3D -Wall -Wstrict-prototypes -Wuninitialized=
 -O2 -g -std=3Dgnu99 \
 	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
 	$(KHDR_INCLUDES)
=20
-no-pie-option :=3D $(call try-run, echo 'int main() { return 0; }' | \
+no-pie-option :=3D $(call try-run, echo 'int main(void) { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
=20
 # On s390, build the testcases KVM-enabled
-pgste-option =3D $(call try-run, echo 'int main() { return 0; }' | \
+pgste-option =3D $(call try-run, echo 'int main(void) { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390=
-pgste)
=20
 LDLIBS +=3D -ldl
--=20
2.39.0.rc1.256.g54fd8350bd-goog

