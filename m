Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E062E9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiKQXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiKQXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:32 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9092A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so3505232pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQKoNHkwXKQHXK1Rm3137rvxsN3jeB7ychTw9wiMCoA=;
        b=gzgQ67tGphKg9LC8dXQMsOdp6988Jh6y4uQ4wq39wUd2vtbr/8gxP0dLkj/cYJSQfU
         oJVP225UVvh8eZGzkuRft1/5qPdhlpTQCB04Dhk8Pza+YxTN6AkGI7wxVQ888beABqKJ
         7xM3YRAsM7rHhiSI+nNyQa/rVKea7ZVGyyzy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQKoNHkwXKQHXK1Rm3137rvxsN3jeB7ychTw9wiMCoA=;
        b=22sZASIufST71jpdxzXZaM+t2kQQjPUgk9apnfyAyFGAEEWEBydX0je/ZNIgxTWa/y
         /Wal21+Xql0SQcMKZnd2tu4AOhsXSIZ1EFWM99E1TSdPtTJvStT+IK3hEba3eJYqyQlg
         gtL3rYHATVFaEAHX69z65hF9/wRiw4NqefGPwPxlSd+t4Oyw0rue3xXHKFRRL5tL7vH3
         7ALWKNHtBlHD6qD0egUfrSbwqOzOVe6XNsA/ytYclxxGtEHchunxXftqeZiH1KwYLBO3
         CzRv5Zs8FgrlIADELi2ORdaWiRKjzPftLebY5NSPrSGkuJEGueubo1lcOxbY+BOLrZ+9
         CgtQ==
X-Gm-Message-State: ANoB5pm3oh64PKPMDCugMp3aJBy394GfS5A/YlkTBssj4nH2vG0gUf5p
        gMcoBwK/AgiMZVUZhEQZDazElQ==
X-Google-Smtp-Source: AA0mqf4dMrpHROtIgMnip0OIwSGPEYdtdDWFsBd6CpaiKHR5PBA7FaDdD8tvh8Nw0f5yBbrJCuHeXA==
X-Received: by 2002:a63:3d8:0:b0:476:eee6:d394 with SMTP id 207-20020a6303d8000000b00476eee6d394mr4235676pgd.228.1668728610079;
        Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a655bc9000000b004582e25a595sm1614221pgr.41.2022.11.17.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
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
Subject: [PATCH v3 0/6] exit: Put an upper limit on how often we can oops
Date:   Thu, 17 Nov 2022 15:43:20 -0800
Message-Id: <20221117233838.give.484-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; h=from:subject:message-id; bh=Mevv31fJaznFTh44cD9Wkn2q46wN2KwgT2JblND2tEw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdsccuB5/7Dud9dthXxlatod2tm4x+MLt8lSkzhG8 v6L92dWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHAAKCRCJcvTf3G3AJuVdD/ 0eNAawmC+gMqkT2rEKRxW1q1K4WlSNG660mYF+W/EAMANgbt6w31eLw4F1zcWZUz+34y5smj0BBaCU y5rzvHB47A7fuA9hXjcwb8TuxsSnjq3pkDquhBH7Y3KFkj90GGVkL/Mh9gVP+uOLjCYvc48iwOt2eG YHZ/y3jAgGhcr2jxeAYCwOwalTeHyyCeurbdvX7Oq+a45aPDWcVfffZbFVfHn8DxxTVcNQ7N/628uE z2kYsHca4qJwFAzPpArSYyVloSVtbEW5ckjt+Iq6kLO3u+oTgu+PvJpLJ9F8bnjbFIklvAwkomHvfV fixggchvSkevDB43e+wQvPrcKfiNN71mlbGfuMLs2VVFuzNQUGAZXRhHR3lwG9UIaNDuCzzxa1UWr9 3ktCososbPal1YX12fJhSFl8vzBMk7JLQEbTTHcYUAbjWHdpNJodiID252O9pAdmG1E9muAIZGy4qC tcH0IouHdUSPs2DP9Y16vdrEMok25wZU7rIjZ0VxdtGIMrgiqMZmxweeRnhXSgy/HFG+1IXtXgb9Ir Ro+U3RGzEYBu6Wklay2Dr6Gca6606I6a51/zw0fPXanLvL+dGU0ZHeXbx7SaSYZ0n2zPaL+1ET1p19 gLeTIC7R+E3l0BJ0ilq4VBoffYDaepF8i1hdfUaDnHhkEMaoDGmjbuFOnslg==
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

This builds on Jann's v1 patch[1]. Changes in v3:
- fix #if/#ifdef confusion (Bill)
- rename from "reason" or "origin" and add it to the warn output (Marco)

v2: https://lore.kernel.org/lkml/20221109194404.gonna.558-kees@kernel.org/

Thanks,

-Kees

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
 kernel/panic.c                                | 45 +++++++++++++-
 kernel/sched/core.c                           |  3 +-
 lib/ubsan.c                                   |  3 +-
 mm/kasan/report.c                             |  4 +-
 mm/kfence/report.c                            |  3 +-
 12 files changed, 140 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-oops_count
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-warn_count

-- 
2.34.1

