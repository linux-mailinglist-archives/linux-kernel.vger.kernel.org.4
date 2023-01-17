Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D6670B36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjAQWGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAQWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:04:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5947EE8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ss4so70974322ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXwBXsjVQJZdCpgvR9RDOMw7BAY0UiJH/yPG4bb3O3g=;
        b=XUDDTGy9/TAfXMpGQYay0b4GGosyJi6sWiFcJQkBadl4VSrhLY5/zdVGw0mI8bPqyf
         fDm4Elqgd7PHIQU9dfqjN9VQlYYPPprltlOYJSWb+P9Ah3jO1KjegPlTQbgV/lrbge+l
         23JelNoNYwj7U3OTD4frmfm/vJAIC6NhjTsDO34w0NO5VJc/YUXtETVOdOU/iPYodEeS
         ZR9+94wzl9D38A3o2n6MC5pazdQQ5ReBWm9KMC5fRbqNaywdfVGEvwNxYI1s9nFUE1hJ
         Umw1cQnJ8QzFurfJWdEiZyDy5MDJVDb2nlueROlm5k55s2fKLju6NYHiakaFz7Xj8iBl
         lHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXwBXsjVQJZdCpgvR9RDOMw7BAY0UiJH/yPG4bb3O3g=;
        b=zhtMtuesUeRS2IHluOH0BVlAfzyopChb7cUHE1itr88iQUSIvSEidn4Ms92XpSoT+3
         6dhqkTcbMOP249gr1lNluVcsGkZy9HwuqMdFw5S+wE0yhgnIIhpxes4peSn5My3tXmox
         qXrj4Udn2L8+gxbTNGHkqrgK1CB0rbDCTjtUUBqJqFGgfXnLBvB4O0ZrK0K+V+uimXNL
         6A8aSDkVJSMj534rOPFXq/2Ne0o6W8qA9sYsWbmcXsSWTcDcOB/jKxhBc/yQj4kyVv3X
         EOIvHcLxr3pDWmY8ShptwtHjRgxUyVIv1yM/uFKFiINMXSQemsPebctVcE5OUz8UJJwA
         OVqQ==
X-Gm-Message-State: AFqh2kqDRbVY+YwOdca5M6mN3k1rl/bzuwoJ2gstwZnnbFhtEjXTCz34
        fcYy7sG3is7sGeRfgVvJQYAv2w==
X-Google-Smtp-Source: AMrXdXsakl8ZadOCDEzWtsIiWqMawlGC5N4+A+lM/Xbx8Mj9kVv5yEkRKX+KizZ+onOTROGq8JqS1g==
X-Received: by 2002:a17:906:b24c:b0:869:236c:ac41 with SMTP id ce12-20020a170906b24c00b00869236cac41mr4509290ejb.24.1673988268836;
        Tue, 17 Jan 2023 12:44:28 -0800 (PST)
Received: from nuc.fritz.box (p200300f6af098f00245ad18781b5e181.dip0.t-ipconnect.de. [2003:f6:af09:8f00:245a:d187:81b5:e181])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906970200b0073dbaeb50f6sm13477051ejx.169.2023.01.17.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:44:28 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 0/3] KVM: MMU: performance tweaks for heavy CR0.WP users
Date:   Tue, 17 Jan 2023 21:45:53 +0100
Message-Id: <20230117204556.16217-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a resurrection of the missing pieces of Paolo's previous
attempt[1] to avoid needless MMU roots unloading. The performance gap
between TDP and legacy MMU is still existent, especially noticeable under
grsecurity which implements kernel W^X by toggling CR0.WP, which happens
very frequently.

Patches 1-13 and 17 of the old series had been merged, but, unfortunately,
the remaining parts never saw a v3. I therefore took care of these, took
Sean's feedback into account[2] and simplified the whole approach to just
handle the case we care most about explicitly.

Patch 1 is a v3 of [3], addressing Sean's feedback.

Patch 2 is specifically useful for grsecurity, as handle_cr() is by far
*the* top vmexit reason.

Patch 3 is the most important one, as it skips unloading the MMU roots for
CR0.WP toggling.

While patches 1 and 2 bring small performance improvements already, the big
gains comes from patch 3.

However, as the performance impact is huge (and my knowledge about KVM
internals is little) it might very well be, I did miss an important aspect.
But KVM tests ran fine, so did manual ones I did that explicitly poke around
CR0.WP toggling corner cases.

Please give it a look!

This series builds on top of kvm.git/queue, namely commit de60733246ff
("Merge branch 'kvm-hw-enable-refactor' into HEAD").

Thanks,
Mathias

[1] https://lore.kernel.org/kvm/20220217210340.312449-1-pbonzini@redhat.com/
[2] https://lore.kernel.org/kvm/YhATewkkO%2Fl4P9UN@google.com/
[3] https://lore.kernel.org/kvm/YhAB1d1%2FnQbx6yvk@google.com/

Mathias Krause (2):
  KVM: VMX: avoid retpoline call for control register caused exits
  KVM: x86: do not unload MMU roots when only toggling CR0.WP

Paolo Bonzini (1):
  KVM: x86/mmu: avoid indirect call for get_cr3

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 38 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/smm.c              |  4 ++--
 arch/x86/kvm/vmx/nested.c       |  2 +-
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 arch/x86/kvm/x86.c              | 28 ++++++++++++++++--------
 7 files changed, 50 insertions(+), 28 deletions(-)

-- 
2.39.0

