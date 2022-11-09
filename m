Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC09623422
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKIUBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiKIUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:00:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967A2CDE0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:00:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y4so18110870plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGQv9g3ODjs6GFRrqXnKxOhm5DKhXRVSdXb+tdSOpIY=;
        b=PhMz0SvIkOf9OKYoAzT8yt4UbCslu8xu8VzNKI6KPYLw8C3ZXFNdlQq6p/H6By7ahw
         NM5h1Id6g0rIi3I32+qWmFm6hCrK/eQKXLBFH1d48GXXjsVLFmX1WwuNj54NSjAm+9mk
         fL7LHs8KP/1kU6rf3m2hmfaWWgkTvd0zVbulA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGQv9g3ODjs6GFRrqXnKxOhm5DKhXRVSdXb+tdSOpIY=;
        b=jl2B0EcYWpZARKG8FN8yQlhmLGCTnYtEWrZLPw5HkwG3IkEJL9pvO2JmtTF+hhQERO
         /Ddu+erPwgUneu4tDcOCTKYutm9AIhbm19lDoMpaQDsL/EGoOQHTItl11gOXvyPR6UAb
         2DCGneNBOZRKNXkWcTyKbqsvIOv0+UPshP82LfHLhT0d9nNgp1c9wfbNYcbhlWpgXowD
         5Bt87v9dMrEflGcUVTAQMLhSlxpSzPWQ4/Anhp2F/PVUFyhm65Xz6DMFH019bfHcJWrI
         Yk+U6xyuXMqhc2pwhS7SCX7V7X2cLkh0MBCXdWjAqHzN5wpNrav/BUO9KW68DX0CJyxF
         CRDw==
X-Gm-Message-State: ANoB5pkmbE1E7EkmUFYI4Cz3V9IpKvvY4y2n8qAW8PPlsrR1lGLfCD7S
        1OGzr9z2XXJMyZvDI2hcAyx9Pg==
X-Google-Smtp-Source: AA0mqf5yfsEwBN1id8J2OajpNJE4fr04LTDMDVjQu1P6KCrWdOZsFH+T2qUoOXW6OEtOf2HFdktLqA==
X-Received: by 2002:a17:90a:49c9:b0:217:c5f6:4092 with SMTP id l9-20020a17090a49c900b00217c5f64092mr21353250pjm.33.1668024054274;
        Wed, 09 Nov 2022 12:00:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79478000000b0056be1d7d4a3sm8668553pfq.73.2022.11.09.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH next v2 0/6] exit: Put an upper limit on how often we can oops
Date:   Wed,  9 Nov 2022 12:00:43 -0800
Message-Id: <20221109194404.gonna.558-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; h=from:subject:message-id; bh=f6yYT1z0j34/tTr0B+65L7ktUKTQPrMyBqrftF9wr6M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbvE87tT3kRd5r9yYOWLJwPzhKiyHMFu0vH4T8P yoDh5syJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG7wAKCRCJcvTf3G3AJitzEA CncSpVOXlgXdbb/hwP3379EIiZDAVaMRKgUjhCrB5C1AG8xFxO6JBJoQ4+l2O231mX/ddD+z+SYMfX HHZ95D8VX3sAWmOtoadA7shTHqEF0FsiXkKpQl7f6JgcaNkKdJ+q2tS3f9H6r92zj3NC0e+WJLLAEl hZ68EYM1yBHu3NbBwKNCGg2c0yF6si6geFbjeUnYiOy6tW6UYvePIrwcwCn7KlYhqgl4KNv36+jWHc Y778i1cRX76eeiUzpHniT2B2T0Evn913bHmuLUL+FIttpmCIIKod6ACYcJcj/GNRNqzRV07wl0Key/ z2s25RNqy72RUf87fAkxXXF1SUj/Zlyrtv+1amMRLYK+YJZk2xVsnpjJ12EXvXy1aRog1ya0Uu2Xbh JiED6THw9bgM6qjUfC1P3K+hxbbADTaXDKq/YmanOFpM2dQ0x6gPSL9K77ITM4epSlnxzEFYPW38VO aey2ABBPLLf1x6INkY63BahlYSW0lEFsPq/SwtRtk96yvfx7cnX/3s5yJ69e/KOOeqympJ94EqAHMS uiHCzAG5wBKimts9Ev+ASgD5grPm+aNTMzg7YGHLR1H8CtIvP14gAmvYaDBunKlhjowNMBxntTuhq/ yQXowZnvWi80+NGf5Y6I3gintRa/hcEra2VTAWXPBDlREGitdn3tljFvyzMA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This builds on Jann's v1 patch[1]. Changes in v2:
- move sysctl into kernel/exit.c (where it belongs)
- expand Documentation slightly

New stuff in v2:
- expose oops_count to sysfs
- consolidate panic_on_warn usage
- introduce warn_limit
- expose warn_count to sysfs

[1] https://lore.kernel.org/lkml/20221107201317.324457-1-jannh@google.com

Jann Horn (1):
  exit: Put an upper limit on how often we can oops

Kees Cook (5):
  panic: Separate sysctl logic from CONFIG_SMP
  exit: Expose "oops_count" to sysfs
  panic: Consolidate open-coded panic_on_warn checks
  panic: Introduce warn_limit
  panic: Expose "warn_count" to sysfs

 .../ABI/testing/sysfs-kernel-oops_count       |  6 ++
 .../ABI/testing/sysfs-kernel-warn_count       |  6 ++
 Documentation/admin-guide/sysctl/kernel.rst   | 17 ++++++
 MAINTAINERS                                   |  2 +
 include/linux/panic.h                         |  1 +
 kernel/exit.c                                 | 60 +++++++++++++++++++
 kernel/kcsan/report.c                         |  3 +-
 kernel/panic.c                                | 44 +++++++++++++-
 kernel/sched/core.c                           |  3 +-
 lib/ubsan.c                                   |  3 +-
 mm/kasan/report.c                             |  4 +-
 mm/kfence/report.c                            |  3 +-
 12 files changed, 139 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-oops_count
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-warn_count

-- 
2.34.1

