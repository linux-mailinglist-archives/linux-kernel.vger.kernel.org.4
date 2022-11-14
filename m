Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7162882B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiKNSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiKNSR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:17:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB912936F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:16:37 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c1-20020a170902d48100b0018723580343so9492998plg.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtE9LTLM6e/iDSPGZbavzj1dYFHgCb3oR3rJeTcOT+g=;
        b=C+aQg2oYQLkz9ZQE61nnXuMx0navRh+/cnw0YCS2ZX/meNvlvH6Be1MmSOBSShGO85
         gmf+WlWAD7lCRWPz7fRII0HQ5gGlyIm+1y3iyiOKGWI1KBcWsNwCHoZQ3fFOmWreHM/O
         ahW3BEfVmV3/6/y8l5az53O3+CQT0ZfQtHwMZokgXzSutyUL4BUICwssgac2hSP8/njb
         PDCemJQMOteai8s6cpcR/oaQDmVlz2CaI8aai313l0sCk/ITNGZOA9snssz3mWulq35Q
         j8k3KcAKSto81EUZLhZs8UwQAD8wQSHVbBCzzDPKAiXjWhHcLkmVlG8JW680yuGNpVaq
         qI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtE9LTLM6e/iDSPGZbavzj1dYFHgCb3oR3rJeTcOT+g=;
        b=OrpEF2YqCUpfoitUp2Cm8jxiqGusY2X+VpD5kIpNgUYeInzVbL0CisTtkmBQcISmJx
         QcSonRW1A+gk3AjeoRYzS/aNtbEQIRryZeEb5jc74/7bsWcXd2MYPPNcx2529TE9ZOB4
         xKq1HgqTQAgjUAXYvb3m/2MutR0DU3iWlu4fVmAmouHwM9pGtVwQMCj4+XocDWn46uud
         e9IR1sPqvmpRdsGUyidsdord46jCoJHl8d577qKrhrAYSGS2ERCS8xuDcaSfl/XZqbcE
         NlD7hgSSdWUhC528zqdaHrs2zotXUTUk4O42i8f5/VqKx79vmXc//WoZOC4HrOd9IRx1
         BtQg==
X-Gm-Message-State: ANoB5pkj9u1SdG8+M6ZvsRIcQ85iwNMLts3sBml9IvX1c52fceXCMIjG
        hTQ3XmT/WbqzkhTPdk7Xfls7Mpmcvro=
X-Google-Smtp-Source: AA0mqf4n++gjSdGBaCNBiAXP/Auyc745+3Dvu8KBVwRRhKV0T3hBd6KN0Fz1grtXNXxRYL1PRLLKQFnzCCA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1b23:b0:218:725:c820 with SMTP id
 q32-20020a17090a1b2300b002180725c820mr14862954pjq.170.1668449797098; Mon, 14
 Nov 2022 10:16:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 14 Nov 2022 18:16:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114181632.3279119-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/xen: Make number of event channels defines less magical
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>
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

Use BITS_PER_BYTE and sizeof_field() to compute the number of Xen event
channels.  The compat version at least uses sizeof_field(), but the
regular version open codes sizeof_field(), BITS_PER_BYTE, and combines
literals in the process, which makes it far too difficult to understand
relatively straightforward code.

No functional change intended.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.h                    | 8 +++++---
 include/xen/interface/event_channel.h | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 532a535a9e99..c771fbed7058 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -9,6 +9,8 @@
 #ifndef __ARCH_X86_KVM_XEN_H__
 #define __ARCH_X86_KVM_XEN_H__
 
+#include <linux/bits.h>
+
 #ifdef CONFIG_KVM_XEN
 #include <linux/jump_label_ratelimit.h>
 
@@ -198,9 +200,9 @@ struct compat_shared_info {
 	struct compat_arch_shared_info arch;
 };
 
-#define COMPAT_EVTCHN_2L_NR_CHANNELS (8 *				\
-				      sizeof_field(struct compat_shared_info, \
-						   evtchn_pending))
+#define COMPAT_EVTCHN_2L_NR_CHANNELS	\
+	 (sizeof_field(struct compat_shared_info, evtchn_pending) * BITS_PER_BYTE)
+
 struct compat_vcpu_runstate_info {
     int state;
     uint64_t state_entry_time;
diff --git a/include/xen/interface/event_channel.h b/include/xen/interface/event_channel.h
index 5f8da466e8a9..c7b97c206226 100644
--- a/include/xen/interface/event_channel.h
+++ b/include/xen/interface/event_channel.h
@@ -10,6 +10,8 @@
 #ifndef __XEN_PUBLIC_EVENT_CHANNEL_H__
 #define __XEN_PUBLIC_EVENT_CHANNEL_H__
 
+#include <linux/bits.h>
+
 #include <xen/interface/xen.h>
 
 typedef uint32_t evtchn_port_t;
@@ -244,8 +246,8 @@ DEFINE_GUEST_HANDLE_STRUCT(evtchn_op);
 /*
  * 2-level ABI
  */
-
-#define EVTCHN_2L_NR_CHANNELS (sizeof(xen_ulong_t) * sizeof(xen_ulong_t) * 64)
+#define EVTCHN_2L_NR_CHANNELS	\
+	 (sizeof_field(struct shared_info, evtchn_pending) * BITS_PER_BYTE)
 
 /*
  * FIFO ABI

base-commit: d663b8a285986072428a6a145e5994bc275df994
-- 
2.38.1.431.g37b22c650d-goog

