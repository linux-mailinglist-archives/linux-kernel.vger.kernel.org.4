Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2F6A46C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjB0QJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB0QJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:09:41 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E7D211FD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:09:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h16so27867358edz.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxey+7sqWvWOo5NrntHk/o4WUHBkJNfXPSn9nqQN0fs=;
        b=HHwJf2xDfskdyehybrfXa3iNb4BleyyCmiQEn9jMnpD8Is4KnVVks3Tr9FTTGJWLpl
         3WteILDty7qTDao8BbnP4UvfmK2Z8nUNXuAva5KkZNSqpnaqpcDCg6pehpWsI+eUWbB0
         pE/TjJbfX2TFM0hxL99aWxjrDz7iUK/mvOJ2/BFI5vJZx2+wR/IXJ8M2HD/XXmdq4G6Q
         TUH6p310rJkGgL5Hvwb9Igs8gvOvb/P68x3NlyRnLQo2oomikSP1h3Ewy0IEsb1nuLoT
         FFWtj7Rq+MYEcManvP35UfTI/67jIB5pjh8w/kgYY8bLEPYEmR37M4E6V862ixqFnizC
         kg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxey+7sqWvWOo5NrntHk/o4WUHBkJNfXPSn9nqQN0fs=;
        b=cgO1CDabMk88z5AewJsKwMiNIGiWK7hjLCbyHQE88jCs8CnopqthlaBOL5EPGiZmLW
         izpwVTqiQaJA1J650IaKznW97rgmeB8uNo6HQMuHACzvbpJ0xLLbvf/fryBeDf9zviLV
         0fRJnmPzAS290IbEc43gsCiI6PmeLpsyzrHgCWf0cyYNugUQW0yq+7RMht3Tka9GbNbs
         WP4zVR1mRPf9QjuPfAW4wke5cYf9u2+02d7Q5newhTzv4BH8hwvZKPu5eQDWvYnlawvQ
         cjpfGL9yezM/2qsjM8cqNUkE/CSfxI8QgZOqsHVP4qlu7WL+2EWmarePOSIKxR4gkQyq
         fprw==
X-Gm-Message-State: AO0yUKXoJC424+M2gWw9S/8tWwBUGkhNaHtRF/FTz4VJRKFugjFASMB0
        eLtedqL1de6RRbHzazXYfRo/tYwJX3jtqw==
X-Google-Smtp-Source: AK7set8BbDdrRKcDXhiOTMf4LmTsESbVm9846ErOakkTn/NIg7nO1gS6df8QCgy228RrijCDnYGovg==
X-Received: by 2002:a17:906:c7c6:b0:8af:305b:76af with SMTP id dc6-20020a170906c7c600b008af305b76afmr35043976ejb.33.1677514178217;
        Mon, 27 Feb 2023 08:09:38 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906655400b008f2b0c6052csm3342899ejn.89.2023.02.27.08.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:09:37 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/apic: Fix atomic update of offset in reserve_eilvt_offset
Date:   Mon, 27 Feb 2023 17:09:17 +0100
Message-Id: <20230227160917.107820-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The detection of atomic update failure in reserve_eilvt_offset is not correct.
The value, returned by atomic_cmpxchg should be compared to the old value
from the location to be updated. If these two are the same, then atomic update
succeeded and "eilvt_offsets[offset]" location is updated to "new" in an
atomic way. Otherwise, the atomic update failed and it should be retried with
the value from "eilvt_offsets[offset]" - exactly what atomic_try_cmpxchg does
in a correct and more optimal way.

Fixes: a68c439b1966c ("apic, x86: Check if EILVT APIC registers are available (AMD only)")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/apic/apic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20d9a604da7c..770557110051 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -422,10 +422,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
 
-	rsvd &= ~APIC_EILVT_MASKED;
+	rsvd = new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
-- 
2.39.2

