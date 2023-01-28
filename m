Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B55367F98C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjA1QYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjA1QYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:24:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF587A83
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:24:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so2439964ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm51asFusMaOnI4dbO4kmiyktN80gT+APvb33Ns9XI=;
        b=Y/+btvKrmgzXEKtyKX7991+a12JhQ7dalLgZnYYVwQvFFHfkh9OK3x3t5ZdVRfa4nk
         SGvuuUEPReexDl5lgCg7OQPPDhPjQc/Nawu+4iDR4/xCYRHMx+JyDhhwLTxpj7yT4d2X
         fARyrgIuCQ96nd0aTfGQ7zDZNuNJAsQNjEnFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdm51asFusMaOnI4dbO4kmiyktN80gT+APvb33Ns9XI=;
        b=3hFMrgxRSbVKZBPctnlbz17KkLLuyTLpsBEIW0rLKL6QjjqOn9AJdgN+pCeh6bJiWX
         CY0kmCdE4dNA+8zXG+mlBfiaR6V72RylCWqpAsNNCJLah+SCdHTJXatIwBLYGqeNGxKF
         Utc4Gwky4Q7itmRdCSrqpEgmvbq1ljbGUbn1xBuSBy+E1uJa4W/N7VUFiQMB3BShiptf
         TymfxyjrPmI0YNa2vOyhiv+OIp0rKfE87lijxykqv0MUisEyYJ0XXhL+3VS1dL3Y489f
         qfRuxqz42/JCptd+TbID6waMdL9I/IfUYOjFszpH/gzIeAGjRVtnoAGM0YMydriPi8vM
         NfHQ==
X-Gm-Message-State: AO0yUKWdilYByLliDmQ9sa1++9n6N1LYfTmOrGj1KQ4U5jUeR9cOSALj
        1kKsQeYG2zvlDysxa/1qY6rSeg==
X-Google-Smtp-Source: AK7set+3+WSurY2InJfAC27gcngmCjroEKMbPIUtbLMwyDnbgQkdHZBKAQR1RWIhIThi4NwuuTBT8Q==
X-Received: by 2002:a17:906:ad87:b0:885:5231:359c with SMTP id la7-20020a170906ad8700b008855231359cmr941135ejb.5.1674923056433;
        Sat, 28 Jan 2023 08:24:16 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id bu21-20020a170906a15500b00877557ae644sm4074279ejb.71.2023.01.28.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 08:24:16 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sat, 28 Jan 2023 16:23:41 +0000
Subject: [PATCH] tracing/probe: trace_probe_primary_from_call(): checked
 list_first_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIAA1M1WMC/x2NQQqDMBAAvyJ77oKJh4R+pfQQ42qWpmnZjaVF/
 Hujx2EYZgMlYVK4dhsIfVj5VRqYSwcxhbIQ8tQYbG+H3liPmbUilSo/LGvOGBPFBw7OOU/zFIyP
 0NoxKOEoocR01M+gleQQb6GZv+fwdt/3P09B60WAAAAA
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674923055; l=1355;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=IgyQXwB2Np3yDjGtNPNxtd/EaaynJb35GlVylgQexoU=;
 b=aVkW+zF9PsQ3O71+nDtJfYkLWvZCYJiNRI0xeZt5QAAdjwu1JqmFlMCjui9upEK7HOFroY9yGBLV
 CBgoW0g1BtQCJNuFS+N10G4El+VuNgRDemGjiXbVVFtS5ul7sTs0
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of trace_probe_primary_from_call() check the return
value to be non NULL. However, the function returns
list_first_entry(&tpe->probes, ...) which can never be NULL.
Additionally, it does not check for the list being possibly empty,
possibly causing a type confusion on empty lists.
Use list_first_entry_or_null() which solves both problems.

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 kernel/trace/trace_probe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 23acfd1c3812..f6b565dced56 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -307,7 +307,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
 {
 	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
 
-	return list_first_entry(&tpe->probes, struct trace_probe, list);
+	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
 }
 
 static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)

---
base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
change-id: 20230128-list-entry-null-check-37778efda18c

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>
