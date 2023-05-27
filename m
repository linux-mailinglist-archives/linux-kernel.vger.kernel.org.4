Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080FA71319E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbjE0Bma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242576AbjE0Bm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B6A1B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d247a023aso1205008b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151736; x=1687743736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Wyvy6HPwlh6VYOHfNA0dxsOkmR5hf4tUOLdIYH19M=;
        b=jVupxr9tkpNoY2DPpNO8ve9RV3dt+XdDWaO2WoRtWo7O726zDUiL2HAAxcH6LHl3N4
         zg+XiJ3Z3hMClz9oQWCKKIy9P9nGkLhMbC/8iyvrxOUDtLp+WDuMwpTv3zKUdQXrfkDP
         KJUkxWt47+5T+11hbTnQ8sD/sndKaFgdvy0fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151736; x=1687743736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8Wyvy6HPwlh6VYOHfNA0dxsOkmR5hf4tUOLdIYH19M=;
        b=YBzJP+Cr2VWjPLnqCqD0ltkAheuT4OlniCcReUL3j6PJukwYr84YxSpRahnikmcWp9
         6nGT1cWu7Set7Ih6mwW9MbDk562V5zmfdJJ4k5ssjF8POq7izCssqFT7h+lBysZ1juK5
         p0mmWqO2qPbM+7lmWQY1gTVCwCpMGfBPp+RKeD4EGJiIEgQejj3nzH4vQilU3uYe194t
         mICWcjaOCHMJPtp7Ag7pEfG/lEFY/QnsORu5OaWx7cX+GCKNv0LPFMvKrPGIMtoVVvPf
         wY2yCn9O4ZbtEGztwixUtGtHONuQoGYsxE9R1ZpnsH9jz4S4HOFLRMCbHRNyJi9wOhwP
         b/vg==
X-Gm-Message-State: AC+VfDxLssnf37IVleVVK3N0Vj6Gr8MG9i2VgW+GUye/MKhVYfokELg0
        JYLHlBcoB82crHlcpIgTB6Bvkw==
X-Google-Smtp-Source: ACHHUZ4GAy/oEImCC0hpOXpTjNUo0Dhy+rQj32IqoVkt1EVytgp7ZHhTjG/XebwId5tT/CXJZBdMDQ==
X-Received: by 2002:a05:6a00:190e:b0:63b:8afe:a4dc with SMTP id y14-20020a056a00190e00b0063b8afea4dcmr5524785pfi.30.1685151736256;
        Fri, 26 May 2023 18:42:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 00/10] watchdog: Cleanup / fixes after buddy series v5 reviews
Date:   Fri, 26 May 2023 18:41:30 -0700
Message-ID: <20230527014153.2793931-1-dianders@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series attempts to finish resolving the feedback received
from Petr Mladek on the v5 series I posted. Andrew has already landed
v5 so I'm posting this as additional patches.

Probably the only thing that wasn't fully as clean as Petr requested
was the Kconfig stuff. I couldn't find a better way to express it
without a more major overhaul. In the very least, I renamed "NON_ARCH"
to "PERF_OR_BUDDY" in the hopes that will make it marginally better.

Nothing in this series is terribly critical and even the bugfixes are
small. However, it does cleanup a few things that were pointed out in
review.


Douglas Anderson (10):
  watchdog/hardlockup: Keep kernel.nmi_watchdog sysctl as 0444 if probe
    fails
  watchdog/hardlockup: HAVE_NMI_WATCHDOG must implement
    watchdog_hardlockup_probe()
  watchdog/hardlockup: Don't use raw_cpu_ptr() in
    watchdog_hardlockup_kick()
  watchdog/hardlockup: In watchdog_hardlockup_check() use cpumask_copy()
  watchdog/hardlockup: remove softlockup comment in touch_nmi_watchdog()
  watchdog/buddy: Cleanup how watchdog_buddy_check_hardlockup() is
    called
  watchdog/buddy: Don't copy the cpumask in watchdog_next_cpu()
  watchdog/buddy: Simplify the dependency for
    HARDLOCKUP_DETECTOR_PREFER_BUDDY
  watchdog/hardlockup: Move SMP barriers from common code to buddy code
  watchdog/hardlockup: Rename HAVE_HARDLOCKUP_DETECTOR_NON_ARCH to
    ..._PERF_OR_BUDDY

 arch/Kconfig            |  3 +-
 arch/sparc/kernel/nmi.c |  5 +++
 include/linux/nmi.h     | 14 ++-------
 kernel/watchdog.c       | 68 ++++++++++++++++++-----------------------
 kernel/watchdog_buddy.c | 28 ++++++++++++++---
 lib/Kconfig.debug       | 14 ++++-----
 6 files changed, 70 insertions(+), 62 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

