Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01F71F4E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjFAVhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjFAVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B9E40
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:37:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52c30fa5271so685699a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655439; x=1688247439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfGBHBvKGGFx2dApaWUV0FsGkRnAHULREps6A6RYWJ4=;
        b=AkgOfxeqMJ+Uowmkx4hw7IQZ50qdy2xVCPyodSzFbID79vkX/uuep2hjtkAVQf+ZMY
         2Ois27dY1aNRlYZc7JAHlkdtHKB/6T3f05uoIAoto3JEclpb7k9RtEHCD6+WC8K9AjHR
         0/+O26QCTSXFLaWGDuAgWq5b1oezjD46LgHAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655439; x=1688247439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfGBHBvKGGFx2dApaWUV0FsGkRnAHULREps6A6RYWJ4=;
        b=N7HWJtLG4dL5P1bvft8Bpwy+A9annUOLMGKJWXlILXdsxka3YZxKrHUIzUd4SDECyT
         /R4ThtXT11aVK278FRcwrhr6ts2V1oix9YYk4NCMfq2TEjo1sOwteQtYQmSMiplTLo7O
         UnLmqUTwOyXWR0Oy6Go2eWuPkTqDbd2+OPsXw7GFt3aQa4GbUhHlFE3SJjmSbadf2Yns
         zT2NJwvdYrbv1cZ5ybz7E5vJMzzGnI4LnTs106VHipaR38+zOj79lIOGkmR3A/A5YKLI
         XXT8twiNeYsBlfAAN8C+dEsEF+nX8aSYFPmaoDJVGn2uomKUSxsqGYoQKk3Kzcobd6/n
         w7wQ==
X-Gm-Message-State: AC+VfDzreSiaq2b3vy3VJGX/tQ6BgY+SUBB/CTXBN/1NpQPPRBsWPb4x
        IivrW8+wErqOQV/TnzXfFzrYUA==
X-Google-Smtp-Source: ACHHUZ6c761aOPieAnWSz/n26mxi7TuDnyom5n4cFPpm2ooQ6JFhgncQbyJIHjA9N7SSHuxDQFh8Yw==
X-Received: by 2002:a05:6a20:1583:b0:10f:759d:c5b2 with SMTP id h3-20020a056a20158300b0010f759dc5b2mr8808767pzj.45.1685655438667;
        Thu, 01 Jun 2023 14:37:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/7] kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
Date:   Thu,  1 Jun 2023 14:31:50 -0700
Message-ID: <20230601143109.v9.6.Ia3aeac89bb6751b682237e76e5ba594318e4b1aa@changeid>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
References: <20230601213440.2488667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To save architectures from needing to wrap the call in #ifdefs, add a
stub no-op version of kgdb_nmicallback(), which returns 1 if it didn't
handle anything.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
In v9 this is the only kgdb dependency. I'm assuming it could go
through the arm64 tree? If that's not a good idea, we could always
change the patch ("arm64: kgdb: Roundup cpus using IPI as NMI") not to
depend on it by only calling kgdb_nmicallback() if CONFIG_KGDB is not
defined.

Changes in v9:
- Added missing "inline"

Changes in v8:
- "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8

 include/linux/kgdb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 258cdde8d356..76e891ee9e37 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -365,5 +365,6 @@ extern void kgdb_free_init_mem(void);
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
 static inline void kgdb_free_init_mem(void) { }
+static inline int kgdb_nmicallback(int cpu, void *regs) { return 1; }
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

