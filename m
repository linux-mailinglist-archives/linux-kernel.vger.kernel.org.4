Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDFB6431AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiLETQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiLETO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:14:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49324BE0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:14:59 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k21-20020aa78215000000b00575ab46ca2cso11461411pfi.20
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wvi0LLag+tRLcHXxhrsZPLE4H8FXz1HGs5LlstE0VQ=;
        b=HsHw4CxEsA6kwJG6DXORTKmNUbiPN+oPLu7S5TDQHE7goj0cx6A5zXo30w5OjhZSQh
         PnhnU07tYtcRUfRllhdiUHFcmSzDwZKDcE+Awx43CJ8J0lmEsoHyamoiODaHfJLGLzGu
         F6/or3pArOzYYNMxDV10fZYIGohUS2zT/Izg/bNzlcyprz07GgUORY3dEIaNzlPPsL6b
         VXcF8iWUL9dTXiMX03JhALa72nZrw6W49BGwN5bNwELkhXRZYH8OXqz83nrW1IHDGqtc
         1q4IutyikMzg49YueAABozQ5mqW4VclueRNBB2kxd6kPcprEkGsVkz0dZAROVFHq4cjn
         a5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wvi0LLag+tRLcHXxhrsZPLE4H8FXz1HGs5LlstE0VQ=;
        b=OAs/mFQqV0KdMClUkOsnTG0DQwXY5ekYHGPhw6LolD2rOwA6HRCMriGY2xwazl0lwE
         PrRrZYJl2uR/EdumO2Fy33bj4E+6FZLG+qMqBYt1X93MgiHftuOaLpY46lavsT2AqFpn
         R80ntyvnYB+11F4OIOLG226Y6lGRvY2JOXSu9Swbfx3mxEx2FSsqZOFhlUQFejizYCfr
         zB3lGr0WSjNob1oULZdn4yOPBdwfetbtET2vNPZfWga1wqgmtRpCSP38NxBH37p89VRC
         LbfXQASVOWdXbsnYRZnCbV5Xbh4F/UOq/rRsBp9N8xCAq1WFJlCBIzxbvR+zag4GZOaz
         EXyQ==
X-Gm-Message-State: ANoB5pn1LnKuBS+UkO/jSSzI9JdfNLLH4o77jaa/eLiTaVVeVLlUcLrj
        eBkVv6vFotz+DEi9/gt1S7mvArH5eW8c
X-Google-Smtp-Source: AA0mqf6C5iTYRM05VAUcwx7Aa6iU1R6+SsHsqAuqe9xN9enbpVFTCT9x4cdCA8YEL/shIwzllWeu2R1AdF9M
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90b:f89:b0:219:5b3b:2b9f with SMTP id
 ft9-20020a17090b0f8900b002195b3b2b9fmr3049797pjb.2.1670267698369; Mon, 05 Dec
 2022 11:14:58 -0800 (PST)
Date:   Mon,  5 Dec 2022 11:14:28 -0800
In-Reply-To: <20221205191430.2455108-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221205191430.2455108-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205191430.2455108-12-vipinsh@google.com>
Subject: [Patch v3 11/13] KVM: selftests: Replace hardcoded Linux OS id with HYPERV_LINUX_OS_ID
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Use HYPERV_LINUX_OS_ID macro instead of hardcoded 0x8100 << 48

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index d576bc8ce823..2ee0af0d449e 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -104,7 +104,7 @@ static void guest_main(struct ms_hyperv_tsc_page *tsc_page, vm_paddr_t tsc_page_
 
 	/* Set Guest OS id to enable Hyper-V emulation */
 	GUEST_SYNC(1);
-	wrmsr(HV_X64_MSR_GUEST_OS_ID, (u64)0x8100 << 48);
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
 	GUEST_SYNC(2);
 
 	check_tsc_msr_rdtsc();
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

