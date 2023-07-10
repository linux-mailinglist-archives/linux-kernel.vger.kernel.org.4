Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4874DBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGJRHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:06:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A856D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:06:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so58576387b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689008816; x=1691600816;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdxQjPxsxT4ZUIAq6MKuRDh+6t1WoZs4Zh6c3B3tQR8=;
        b=OFuWj9SV3PmArz6QEQllNHpVHH32v6/TFZ9FJ3PKrmZG0wUO3ReJPL3AgALj1B3fpS
         0geMi7k78DsZi1fS9ToHQaXRSW7J++GxEDXoCB45wd1h/kb1Yd8ZdphJDfm/lQK4iJCb
         5eRTVRSyGP63UOIBxBTW38vXyMWnnGbBu1HQ2h/BUfVC+jAoh8J/q6jpILRL1bQBzEpJ
         2gtbHzh6hIfb7dsd1gyMJosn2SVgBjfyMyKG3bKvrABEQ18ia/hsj2LndzGi+NfW7BJR
         xT3qSyH3c5RxtXswODb7ZAgsAubg+ZZt28VcCk8akEjrwbpPXU+YRm5jRbmFc5utaPCV
         jArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008816; x=1691600816;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdxQjPxsxT4ZUIAq6MKuRDh+6t1WoZs4Zh6c3B3tQR8=;
        b=Zx953oHY/VPHWR67IT6+fNe2Z58pTIZFDa9F0In0szAgEBFRiUv1r4HoL/nS+1mAmn
         U+VEB5BWqmwQ8d1JGoR3SqlK08/DfH/W9LzIVFPB4+fCaG8vYnQTWtf0pCo4MQpAwgeH
         Cc+qEyGdPy+747f9b/4YxtLe89Hd3nxAhcOHiHyLdVwRfhnzkq0yPbjAjtKYN/Q3rbqJ
         gkkbBrJj0YJBRwm6O3+ePm6Kz7Th01eEMhFgXRqvGNbX/nG/fWaqVkgcSf7YrYNj2Kf7
         YSa+PJCAExXo+EMufjoeiWt9h7Ghqy72CXbHLbI+1jaNsHWeCV/XK7A18BnxoR5rm/Jz
         DJFQ==
X-Gm-Message-State: ABy/qLbf6D5s21KnfoF4QzBogIQ5cb4ByNYjjHW54HQisJVeXBkqs0ZU
        JBmrc8pRx8fhCqj+yAlR6An4cWSTKBQ=
X-Google-Smtp-Source: APBJJlGIxea52O/BNfe71d4id0JtsnykVInVT971JKTz9K81ig6huDPetrDvciuAkgFFhYgCyXcq8TZjtBc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:54b:0:b0:c4e:27df:1a0f with SMTP id
 r11-20020a5b054b000000b00c4e27df1a0fmr98387ybp.13.1689008816742; Mon, 10 Jul
 2023 10:06:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 10 Jul 2023 10:06:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710170652.473788-1-seanjc@google.com>
Subject: [PATCH] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
From:   Sean Christopherson <seanjc@google.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@inria.fr,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove coccinelle's recommendation to use DEFINE_SIMPLE_ATTRIBUTE()
instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
"significant overhead" incurred by debugfs_create_file() is actually
meaningful, warnings from the script have led to a rash of low-quality
patches that have sowed confusion and consumed maintainer time for little
to no benefit.  There have been no less than four attempts to "fix" KVM,
and a quick search on lore shows that KVM is not alone.

This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.

Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../api/debugfs/debugfs_simple_attr.cocci     | 68 -------------------
 1 file changed, 68 deletions(-)
 delete mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
deleted file mode 100644
index 7c312310547c..000000000000
--- a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
-/// for debugfs files.
-///
-//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
-//# imposes some significant overhead as compared to
-//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
-//
-// Copyright (C): 2016 Nicolai Stange
-// Options: --no-includes
-//
-
-virtual context
-virtual patch
-virtual org
-virtual report
-
-@dsa@
-declarer name DEFINE_SIMPLE_ATTRIBUTE;
-identifier dsa_fops;
-expression dsa_get, dsa_set, dsa_fmt;
-position p;
-@@
-DEFINE_SIMPLE_ATTRIBUTE@p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-@dcf@
-expression name, mode, parent, data;
-identifier dsa.dsa_fops;
-@@
-debugfs_create_file(name, mode, parent, data, &dsa_fops)
-
-
-@context_dsa depends on context && dcf@
-declarer name DEFINE_DEBUGFS_ATTRIBUTE;
-identifier dsa.dsa_fops;
-expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
-@@
-* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-
-@patch_dcf depends on patch expression@
-expression name, mode, parent, data;
-identifier dsa.dsa_fops;
-@@
-- debugfs_create_file(name, mode, parent, data, &dsa_fops)
-+ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
-
-@patch_dsa depends on patch_dcf && patch@
-identifier dsa.dsa_fops;
-expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
-@@
-- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-+ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-
-@script:python depends on org && dcf@
-fops << dsa.dsa_fops;
-p << dsa.p;
-@@
-msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
-coccilib.org.print_todo(p[0], msg)
-
-@script:python depends on report && dcf@
-fops << dsa.dsa_fops;
-p << dsa.p;
-@@
-msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
-coccilib.report.print_report(p[0], msg)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0.255.g8b1d071c50-goog

