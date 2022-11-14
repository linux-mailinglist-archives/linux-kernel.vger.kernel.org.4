Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B46273F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiKNAyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKNAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:54:09 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83449BC19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:54:05 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id v18-20020a637a12000000b0046ed84b94efso5018477pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgJ8btRwQzuryastD7pygj98/Pc/g+fsDy0Kz0jIAqk=;
        b=Tr+c3k00qEDqo1GZx18j40f8kEvUZz+jO5Mng/3u0QiBlq4ZKKdXQTCj3oZETAHOSc
         VSyTfO9znR9iSpVkzNA9Vy5fG0MLy9RXFqsMpZHhDig1Ni0B+CRw3Vof635AkUSikKkB
         lLM7UUW8+2dgO25SPtWwBU/MwhPyj97bLtgwZmch34Dd7Kd8CGW6B5PLLPcPlQKNLnRo
         dFEHAYh3mc3/BhYmB6Yl9yHR0xfirO41xC2xsKBELDXONXpiUFf5WQg5N+NaDHDtFHjf
         iEMH8B/7LeLmy/pQzk/pvKpPyIS6vRhBi6ulPB2/CslaHGZ9+a27BjTT/Da7AQpSaTHF
         UaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgJ8btRwQzuryastD7pygj98/Pc/g+fsDy0Kz0jIAqk=;
        b=aItEfC7CSzrp5PKNA7wH7mjnzAhXWUnyKy3ANeS9D8YdUPyfg/ti8NTFcOkoHMQmvv
         NBlhAIkogRLwYeOiWXH91zFTZ0JJQQICJsOv3jXkxTi9pbMEITLViWlCvTBKQaUk64lz
         d0fAG3+QsXEY84XPmNkAfxzf/YCdbvs5aOesYj0Qg9Y78ElyPTSUzbHa15NYoKw5xhii
         cIYmp6Ckq3uH1eK8yX0KlWVAERht4q6GRpBiXFfTrL7BJSxhH5my43Y4sbrwUZmh/oqc
         zjGx96G9UtVYBy5cgqrh2X62HVLsiquVcmn1xTYq848iaqQEC1PGih3al5jk5YWSwSLc
         mwUw==
X-Gm-Message-State: ANoB5pn7Wg1ahFhjKpMVRLcC9R1S719EaLdHFRFysRSnqDFwErij9w1o
        Poo6dOmMrVnYZ5eRakQUnz7ehHKZb5kW3g==
X-Google-Smtp-Source: AA0mqf7eJ04CitwH0FY7cTDFezzJTkjtBU2G6b/85+bj91CHnXsqWma4kzCndIH0cqHirJ9Fe1Olerm2YbNo5w==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:903:2797:b0:17f:628d:2a8 with SMTP id
 jw23-20020a170903279700b0017f628d02a8mr11071378plb.34.1668387244945; Sun, 13
 Nov 2022 16:54:04 -0800 (PST)
Date:   Mon, 14 Nov 2022 00:53:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221114005346.1728227-1-zhuyifei@google.com>
Subject: [PATCH] hrtimer: Fix 'set but not used' warning with lockdep_hrtimer_exit
From:   YiFei Zhu <zhuyifei@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thelford Williams <tdwilliamsiv@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a defconfig build with 'unused-but-set-variable' enabled, we get:

  kernel/time/hrtimer.c: In function =E2=80=98__run_hrtimer=E2=80=99:
  kernel/time/hrtimer.c:1648:14: error: variable =E2=80=98expires_in_hardir=
q=E2=80=99
set but not used [-Werror=3Dunused-but-set-variable]
   1648 |         bool expires_in_hardirq;
        |              ^~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Resolve this by evaluating expires_in_hardirq and casting it to void.

Reported-by: Thelford Williams <tdwilliamsiv@gmail.com>
Fixes: 40db173965c0 ("lockdep: Add hrtimer context tracing bits")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 include/linux/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5ec0fa71399e..df74d0df8e1f 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -125,7 +125,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	((void)(__context))
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
--=20
2.38.1.493.g58b659f92b-goog

