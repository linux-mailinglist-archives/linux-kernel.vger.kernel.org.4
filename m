Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44463C7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiK2TMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiK2TMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:12:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4BA5D68C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:12:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so13887967ybj.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqObWi5Cvsc88WHelIdy7qwaHKJYWrsoFEaKDHU772U=;
        b=V1ncExgWsAZrcSAOMBGBexwkYRm9T477klHi5MssRp2v3SybzMYEzE+OZlY/sASqMk
         UenKs88iO/aYyU0KKVQg6IfblXHXvlHkY8x6W8u0M+Lh7W4efkuRB2hlkOB0djtO6zXm
         qThWGi53E3VAbAEun+emxqtj7rA4SoorRdOSHDSGXj41XAH3h2MoQl4yh3o5fRJJ62Ey
         LtTHR8z7rp7Iaj6fb9q7Q/iIGTzfJUVx+/MeUrh8eOg99wklXRyFAE2yKn9QZZXWaxEG
         GKbgAvUOjSzgfAUD3Nfw7CbXwb4Qvo7UcSe7EJroD6XMvt17AKjeQKGiCQuOWm7FRgSv
         3t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqObWi5Cvsc88WHelIdy7qwaHKJYWrsoFEaKDHU772U=;
        b=iOpKLbz6R7QcZ7mzajZKhqY3vJsrBgHCI3CREajkolSyNQ8J8Bki3gYsrsSfaQtWTg
         zOBtLSQFykcQ15RMo4Qy8+cVbg36UEz39k5lp1nfCW6Jftk5tginuizZSJKmug7tE08o
         4WH6DHRBhKDWFbG6dFAEgoEc8ZuETsoE3lJbhKKeJX0vei/hFKepFVisg/EN4MCdo9Dt
         MtlNrmtv6V0p++gfSTkQZP/TpB8bfzk3FtRd0pixqcDymL27siE4HTl82GJ0D+GhdCX6
         GraVTOB8H2q8tLS/IpJ2IcEzguN6Nfnk0Yi/EKg8qE8t9jlNaKvMW9B6iaincE32vgXu
         xXww==
X-Gm-Message-State: ANoB5pnfNUK4ABhWyVGQRGb7k9c81hr/l4GS+947vuJ51YusHWuyiRY/
        nxMaRwM3lb10zEm2rjARXM9+JctHc/mW
X-Google-Smtp-Source: AA0mqf5f8yOmqoXW5+pzTF8eaWyt6X1hqDAtkAMww+idTeO1DvSjuuEy5Zi8lCM1czyO/mP34PAO16Q1ykND
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a25:bd4f:0:b0:6f7:d47c:edbb with SMTP id
 p15-20020a25bd4f000000b006f7d47cedbbmr8188154ybm.647.1669749160267; Tue, 29
 Nov 2022 11:12:40 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 29 Nov 2022 19:12:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129191237.31447-1-mizhang@google.com>
Subject: [RFC PATCH v4 0/2] Deprecate BUG() in pte_list_remove() in shadow mmu
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>
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

Deprecate BUG() in pte_list_remove() in shadow mmu to avoid crashing a
physical machine. There are several reasons and motivations to do so:

MMU bug is difficult to discover due to various racing conditions and
corner cases and thus it extremely hard to debug. The situation gets much
worse when it triggers the shutdown of a host. Host machine crash might
eliminates everything including the potential clues for debugging.

From cloud computing service perspective, BUG() or BUG_ON() is probably no
longer appropriate as the host reliability is top priority. Crashing the
physical machine is almost never a good option as it eliminates innocent
VMs and cause service outage in a larger scope. Even worse, if attacker can
reliably triggers this code by diverting the control flow or corrupting the
memory, then this becomes vm-of-death attack. This is a huge attack vector
to cloud providers, as the death of one single host machine is not the end
of the story. Without manual interferences, a failed cloud job may be
dispatched to other hosts and continue host crashes until all of them are
dead.

For the above reason, we propose the replacement of BUG() in
pte_list_remove() with KVM_BUG() to crash just the VM itself.

v3 - v4:
 - update code to integrate messages into KVM_BUG() [seanjc].
 - update commit message [seanjc].

v2 -> v3:
 - plumb @kvm all the way to pte_list_remove() [seanjc, pbonzini]
 - https://lore.kernel.org/lkml/20221128002043.1555543-1-mizhang@google.com/

v1 -> v2:
 - compile test the code.
 - fill KVM_BUG() with kvm_get_running_vcpu()->kvm
 - https://lore.kernel.org/all/20221124003505.424617-1-mizhang@google.com/

rfc v1:
 - https://lore.kernel.org/all/20221123231206.274392-1-mizhang@google.com/


Mingwei Zhang (2):
  KVM: x86/mmu: plumb struct kvm all the way to pte_list_remove()
  KVM: x86/mmu: replace BUG() with KVM_BUG() in shadow mmu

 arch/x86/kvm/mmu/mmu.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

