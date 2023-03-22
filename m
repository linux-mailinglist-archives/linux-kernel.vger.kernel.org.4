Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B66C3FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCVBej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCVBeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:34:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F7580FC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:34:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r11so66974881edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679448868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20Pyhhogdvuzcwy66IoLIObVTFFoDuLSanFwt4yn3sg=;
        b=f9/Q57HJYkdBkYSk3Cz1OpO7rWHYV03lStYHaXk6boTZcSJ40xYkMuwdqHDiMlSq3j
         OJBfsvKo1vPOQDmwchCec/BNabcJ9KWWuCtDSTnsI+2i8zpwxoDLn2mgrFnCC6mUUFxs
         w/4JcgewMJhQzXXKxKtxpzkH1MYUOVJtJBby2gvKitsHmiy6Vfi210mevTuLSRCKVP/j
         zZ7AdcedhSruNfUATKhlh60Z+h2ieSo7KGxhwRkcHuD/HbyRaVyUUuPeCQUagoT2YMXz
         v+nJgPEmLP7DXXakGWBO6DeK/s19mTYgUj0ejEG7SRozle2u/5aszIKO3WTZUordOlsE
         x41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20Pyhhogdvuzcwy66IoLIObVTFFoDuLSanFwt4yn3sg=;
        b=idESW9ktG38wwuJDtwHbmltkB1/IeFBy6rCsnS7ej3GfFNcVIBG5h2uvoYgUGejZe2
         7ojYVKOKXfNRTc+XJMvjGe9v6YhMMTjDskdst5MINJ0uVvEXZYsv2x1LFdq6tzulXJ2K
         Uo0oJ2U0VUISMJirRgVcxL/HhTqbDAmlC9CZQtgm/dIt/yc5AZHDG8XThq+b4MrXjPRw
         jKTBcLFLW8L+uJ1JQ0HESS50H9OBYGVNMk0cwfdzrmaCm0SCgm24/M8pfpW6c985omkt
         6WCEraLwKPJdfRkCX/BGTU8VT4jin1Zl4nKi2uRSjhTFd6n804/hgF+urpk8zWeF/p9W
         lsUA==
X-Gm-Message-State: AO0yUKUggZdiU5o7ZqFl6D8dZhPP99iVhvZ7PVkYjlb0iHBc9MKbN1XJ
        OrmqVRvq+mjgU8ftEXgL3pTJjQ==
X-Google-Smtp-Source: AK7set83J3xOO8o1D3Gdrz2H4PeTH++kFeX21rM9B0OhHYvU5u4w6S4YmOd0zCKuu3VxhJskztXjCw==
X-Received: by 2002:a17:906:9409:b0:8f4:ec13:d599 with SMTP id q9-20020a170906940900b008f4ec13d599mr5158453ejx.27.1679448868701;
        Tue, 21 Mar 2023 18:34:28 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af344e007f5e5982a136b54e.dip0.t-ipconnect.de. [2003:f6:af34:4e00:7f5e:5982:a136:b54e])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709067c8b00b009231714b3d4sm6356260ejo.151.2023.03.21.18.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:34:28 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH v4 2/6] KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP enabled
Date:   Wed, 22 Mar 2023 02:37:27 +0100
Message-Id: <20230322013731.102955-3-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322013731.102955-1-minipli@grsecurity.net>
References: <20230322013731.102955-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to unload the MMU roots with TDP enabled when only
CR0.WP has changed -- the paging structures are still valid, only the
permission bitmap needs to be updated.

One heavy user of toggling CR0.WP is grsecurity's KERNEXEC feature to
implement kernel W^X.

The optimization brings a huge performance gain for this case as the
following micro-benchmark running 'ssdd 10 50000' from rt-tests[1] on a
grsecurity L1 VM shows (runtime in seconds, lower is better):

                       legacy     TDP    shadow
kvm-x86/next@d8708b     8.43s    9.45s    70.3s
             +patch     5.39s    5.63s    70.2s

For legacy MMU this is ~36% faster, for TTP MMU even ~40% faster. Also
TDP and legacy MMU now both have a similar runtime which vanishes the
need to disable TDP MMU for grsecurity.

Shadow MMU sees no measurable difference and is still slow, as expected.

[1] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 arch/x86/kvm/x86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 237c483b1230..c6d909778b2c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -906,6 +906,18 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
+	/*
+	 * CR0.WP is incorporated into the MMU role, but only for non-nested,
+	 * indirect shadow MMUs.  If TDP is enabled, the MMU's metadata needs
+	 * to be updated, e.g. so that emulating guest translations does the
+	 * right thing, but there's no need to unload the root as CR0.WP
+	 * doesn't affect SPTEs.
+	 */
+	if (tdp_enabled && (cr0 ^ old_cr0) == X86_CR0_WP) {
+		kvm_init_mmu(vcpu);
+		return;
+	}
+
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
-- 
2.39.2

