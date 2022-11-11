Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E0624EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKKAWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKKAW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:22:29 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C589F1F61E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:22:28 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso4338051pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tu3dCtFufgUDFLM6WYvxUNCj6ktfCE/LA/hYpLdB8c=;
        b=rEB1mAyMxXDNduA/agNa4Yf6hTGKxlP80YetPbguBje7Me+p3tEaVIGLl02RWTFwVk
         dBkheG7mlpYjn/UPHMiPgbK9gfaAMaRsB2x5+dkW5p+OzuVRWPNWrHmcI+9M1vG++D5W
         c1LKq0XlkKx4WAkCLx1c9fIr9rpzQkFdiM/TUdoADn4QJ9B38jgiDQ6FMWDwQ/Bjt4Ah
         3hLE68y+d3hpeazs+evohsB+ct0b2M54qP4IgUDUHHd46GOsERjmi7zjpTfZ8vzs0HbE
         +tYbVMASPszNQGV1F/DoYESPQC6WBcyHgXqDZ7JVKg8f3mUT+xN8r9tAyeZrfhAOaxsF
         RCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Tu3dCtFufgUDFLM6WYvxUNCj6ktfCE/LA/hYpLdB8c=;
        b=hf/KoSiFxygeLtMPKdtEQ29vwCDh6kBXjEjwmEWuOscMz8DAQIqglTLBIE8LN3NZlq
         XgN2pUgIT6zhZD0H2NrwSD741DnpYrwW0WAsg6JIvg1ygL+gYRTKgF+wwaDvyQaIyzqd
         XcRNQqeajn4Jww50wXr5x5kn+jAFAPMEnybNteBoIBoG1+4J3Bvs+DmazZuGIQFBmXOS
         iOr8M/Pq9Wieuu3oZqQSgotpxqeVvRXObUyJo+OTK8+uPxsT8lc9jWAVGl9+iVx7MZqQ
         5tZ+JxqriGGjX9ol8kHt6p4swdqsXIMPL/ER+FvsM4QcxAgKRNAVf+LuQkmLtlWJrY6T
         eoMw==
X-Gm-Message-State: ANoB5plOMbfX1qmzmsDs4mfphWsLZak66EaduLmv0eF0xDgIn6F+wa/5
        ffT8k5TF44yWKJGPa18gvt/z0p+L+ks=
X-Google-Smtp-Source: AA0mqf7gd6ludvatXIsAaRd/oJX7eHNkWOsdyqA+0PpESKhUZp0jiEC3aQTOvc2LFe0GViwpO5qmyq/WklI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c58e:b0:20a:eab5:cf39 with SMTP id
 l14-20020a17090ac58e00b0020aeab5cf39mr107418pjt.1.1668126148029; Thu, 10 Nov
 2022 16:22:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Nov 2022 00:22:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111002225.2418386-1-seanjc@google.com>
Subject: [PATCH 0/2] drm/i915/gvt: Fix for KVM refcounting bug
From:   Sean Christopherson <seanjc@google.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Bug fix and cleanup related to KVM refcounting.  Found by inspection while
attempting to clean up KVM's page-tracker APIs.

Compile tested only!

Sean Christopherson (2):
  drm/i915/gvt: Get reference to KVM iff attachment to VM is successful
  drm/i915/gvt: Unconditionally put reference to KVM when detaching vGPU

 drivers/gpu/drm/i915/gvt/kvmgt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)


base-commit: 1767a722a708f1fa3b9af39eb091d79101f8c086
-- 
2.38.1.431.g37b22c650d-goog

