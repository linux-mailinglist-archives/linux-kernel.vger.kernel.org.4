Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EED5FE411
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJMVP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJMVOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:14:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C782319375D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s13-20020a170902ea0d00b00183243c7a0fso1995857plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayk7WF1bhRdGwOMvSXaXxnD19B/O1/9Is88g4dKNZ4g=;
        b=RGZk+Vdb53lCuSorY1wAskL95mWskPoDQmOT0OPifoQMxC88+I+sUOzBcNwM2ES118
         iW/lEHriL4Qg+SyNCkAnOE/F6nkNbWpyMPrn2QueInKh5I9bN/usi/JiSlITCWwhzV2w
         F6RhstB4XKOktzSjRK6gkJVtWkzoAHgddgAk7BJQH6HKFMpgykXSfdeLSPliTOAoC2SU
         OhvYMmXuZ77gQ7BXD0oc1vhaLxjItBGg0M0MZ4A4tbio5n4WSVH2CZsZU9ZjKFIddh25
         2ojCOWdDUXvoEAgrXLJgd97RPQuSVYegtFiK5TFLdLpOqU8FtEIs1sigEXVw1rFG6IsE
         rsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ayk7WF1bhRdGwOMvSXaXxnD19B/O1/9Is88g4dKNZ4g=;
        b=DQeOMV/x+/1sxfGBqTBksX0FOfJpwcAeZ5wnw4bxqgmXnIS0lOMl/mSSJW0VIeiuTk
         t+7IDgbmSNhiPmBosQhv7MrpDDKnL8SJQyaVANF9YskdR/M2OSnS5M+JgH5bmJosncO+
         xbkC7C10/ZNwT1MNRsoiHcaKlrarOvOhF/VLRP26lMnvvk+JL2My0ZnZnD8vH4kH50HU
         2JTMqz2/A1WsoeggLtlhyc8W89Ky2GYIp4fSRmbCqEK0BHid+u2+CgVAxbgiuse2bgDF
         7YSEAEAQOCpRZ5DMiNfgsNWwc9hVUhhrTiTSB7f6EYgWbunYy8KLMes3Yxm/Rraw82IS
         iZUQ==
X-Gm-Message-State: ACrzQf1ax95849LkogvHlbE3+6xtKE0HqNrsfroZKDJ9oQH5cU6LN7Gf
        1Nax5lO4ztmaXsdeOh9ss0Qv1sjby0s=
X-Google-Smtp-Source: AMsMyM6tAfauzbLm9EvaoW78suvTos1Ey2Zysy7ZW4jVb6C5cbyn4fHYulzadh7ri04uq/mtbeeyli3ZBZE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9614:0:b0:562:b07b:ad62 with SMTP id
 q20-20020aa79614000000b00562b07bad62mr1641934pfg.79.1665695586079; Thu, 13
 Oct 2022 14:13:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 13 Oct 2022 21:12:34 +0000
In-Reply-To: <20221013211234.1318131-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221013211234.1318131-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013211234.1318131-17-seanjc@google.com>
Subject: [PATCH v2 16/16] KVM: selftests: Mark "guest_saw_irq" as volatile in xen_shinfo_test
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
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

Tag "guest_saw_irq" as "volatile" to ensure that the compiler will never
optimize away lookups.  Relying on the compiler thinking that the flag
is global and thus might change also works, but it's subtle, less robust,
and looks like a bug at first glance, e.g. risks being "fixed" and
breaking the test.

Make the flag "static" as well since convincing the compiler it's global
is no longer necessary.

Alternatively, the flag could be accessed with {READ,WRITE}_ONCE(), but
literally every access would need the wrappers, and eking out performance
isn't exactly top priority for selftests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index caa3f5ab9e10..2a5727188c8d 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -132,7 +132,7 @@ struct {
 	struct kvm_irq_routing_entry entries[2];
 } irq_routes;
 
-bool guest_saw_irq;
+static volatile bool guest_saw_irq;
 
 static void evtchn_handler(struct ex_regs *regs)
 {
-- 
2.38.0.413.g74048e4d9e-goog

