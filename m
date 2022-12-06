Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C50644A59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiLFRgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiLFRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:36:07 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207232BB4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:36:06 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cp23-20020a056a00349700b005775c52dbceso640921pfb.21
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qDEmCeemZEhSqKDixoru92cxFOmUueLA1+as4+4wo7A=;
        b=VRXDpEfkgrTrYlFOfzS1yXjcPrpeBHd7K7YTfAHbd7aITI38YIhDFDC7hyMnwMOsYn
         fUbWJIrPmUG66HmbBOsfOTBH5pBqEDE4kpaV/ZXQghfsPtkPR1vl5wm2CP9tHgFhQH3u
         uKyfbzxZZQrvALyHVvKyEzwmayOCUysiVCNdUOvcmsBnfIvxSwuG6C7WKCHb1V4/Fx3P
         8aE8rNVl7bXOcVP4crWPgmDdgZxGNp7SkeGrQh/t+iOoOm+iyKxe1CLyadXFIea+yvyV
         L6W1kZC+BX7qeWowNj278A+ojljC1D1hRxQJsRS8BAtpfCg/z6y+EH7TKaeAMuUTBjSI
         JVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDEmCeemZEhSqKDixoru92cxFOmUueLA1+as4+4wo7A=;
        b=pcMRvsHzzn4pKmxwuuyv1qvkQqpXbxz0RXbBf/hNeILcE1UArydvHKPGhTXS34ODGg
         FzmbtJuwl2tneeUnRoEV3uZgwhUBz0lw245/m0Rv5+8Q8EEBOhq8M79nCBbjNLyGmjU8
         VkBpznvoAZ900oOWKZaH1v1GP5T/bz8wDYnFOwpYpF+evtvuLwUEQ3Qk+aL3FXESXXMq
         ekwIbdRKX8F9O8fiEJCU4EqlKCEp+2vj32YOLC+zvm5XUnkp0ZkTUImQmdL+Uy8puI87
         KbdPEREfEVkmzRYpoXfxTwhqFbkD0pp15F6s44N4KnR8PE32z5Tj33Kv/L1QB8CkE9iR
         mM2Q==
X-Gm-Message-State: ANoB5pk8eNgTsBm3YMLJY+obO7sInqKCux11c3GumddRcrTRdOY6JFsc
        mizmwgJQ4m0PNDewVIFFoBb5bRSaqGx1wNDk9LlmySBRi7jFXSH46C82ObxldLlt56Iswfs30rv
        /PZDqibsihStJnM1U4NwN2vHdJ6Ca4wRJqOhsz8k3+ZxmVoUtUq2sFaUuZcSil768jTQmUh3u
X-Google-Smtp-Source: AA0mqf7wc2M+N4xbtIHqR++G1EW2qWmKEtwfmOLgBZZur6p2+dteRRP7er3euGTMr2JF+B2ghmfmeEXPT6Ro
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:902:8e85:b0:189:8ec5:93fb with SMTP id
 bg5-20020a1709028e8500b001898ec593fbmr41984489plb.154.1670348165621; Tue, 06
 Dec 2022 09:36:05 -0800 (PST)
Date:   Tue,  6 Dec 2022 17:35:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206173601.549281-1-bgardon@google.com>
Subject: [PATCH 0/7] KVM: x86/MMU: Factor rmap operations out of mmu.c
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ben Gardon <bgardon@google.com>
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

Move the basic operations for manipulating an rmap out of mmu.c, into
their own files.

This is the first step in a series of series to split the Shadow MMU out of
mmu.c. Splitting the shadow MMU out results in about a 50% reduction in line
count of mmu.c, from ~7K to ~3.5K. The rmap operations only represent about
10% of the Shadow MMU but are split out first becase the are relatively
self-contained.

This split may also help facilitate the addition of kUnit tests for rmap
manipulation, especially the fiddly bit flag which diferentiates a direct
pointer from a pte_list_desc.

This effort is complimentary to David Matlack's proposal to refactor
the TDP MMU into an arch-neutral implementation because it further
clarifies the distinction between the Shadow MMU and TDP MMU within x86.

This series contains no functional changes. It's just a direct movement
of code from one file to another.

Whether this rmap code should stay in its own file or get merged with
the rest of the shadow MMU code as it is factored out is open for
debate.

Ben Gardon (7):
  KVM: x86/MMU: Move pte_list operations to rmap.c
  KVM: x86/MMU: Move rmap_iterator to rmap.h
  KVM: x86/MMU: Move gfn_to_rmap() to rmap.c
  KVM: x86/MMU: Move rmap_can_add() and rmap_remove() to rmap.c
  KVM: x86/MMU: Move the rmap walk iterator out of mmu.c
  KVM: x86/MMU: Move rmap zap operations to rmap.c
  KVM: x86/MMU: Move rmap_add() to rmap.c

 arch/x86/kvm/Makefile           |   2 +-
 arch/x86/kvm/debugfs.c          |   1 +
 arch/x86/kvm/mmu/mmu.c          | 438 +-------------------------------
 arch/x86/kvm/mmu/mmu_internal.h |   9 +-
 arch/x86/kvm/mmu/rmap.c         | 368 +++++++++++++++++++++++++++
 arch/x86/kvm/mmu/rmap.h         | 106 ++++++++
 6 files changed, 492 insertions(+), 432 deletions(-)
 create mode 100644 arch/x86/kvm/mmu/rmap.c
 create mode 100644 arch/x86/kvm/mmu/rmap.h

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

