Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50912715AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjE3JvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjE3JvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:51:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8585F1;
        Tue, 30 May 2023 02:51:09 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxmPEMx3VkO4QCAA--.5719S3;
        Tue, 30 May 2023 17:51:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWdIJx3VkkmSAAA--.12317S2;
        Tue, 30 May 2023 17:51:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Hans-Peter Nilsson <hp@axis.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 0/5] perf tools: Modify mksyscalltbl
Date:   Tue, 30 May 2023 17:51:00 +0800
Message-Id: <1685440265-7021-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxWdIJx3VkkmSAAA--.12317S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7XrWrtr17Jw4xCF1kGrWfKrg_yoWkKrg_CF
        Z2q3WDG3y5Xr47tFWfGFn8uFZ7tF4jqrn8XrsrWr9xJ34SqrZrXrWYv3y8uF4YqFW8Wry3
        Cr45XryUAFZ8CjkaLaAFLSUrUUUUOb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        X7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AF
        wI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
        14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
        AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07j3txhUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alexander, Leo and Ian for your reviews and suggestions.

v3:
  -- Add a new patch to declare syscalltbl_*[] as const for all archs,
     suggested by Ian.
  -- Add a new patch to use max_nr to define SYSCALLTBL_ARM64_MAX_ID.

v2:
  -- Add a new patch to rename create_table_from_c()
     to create_sc_table(), suggested by Leo.
  -- Simplify the shell script, suggested by Alexander.

Tiezhu Yang (5):
  perf tools: Declare syscalltbl_*[] as const for all archs
  perf arm64: Rename create_table_from_c() to create_sc_table()
  perf arm64: Handle __NR3264_ prefixed syscall number
  perf arm64: Use max_nr to define SYSCALLTBL_ARM64_MAX_ID
  perf LoongArch: Simplify mksyscalltbl

 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  | 17 ++++-----
 .../arch/loongarch/entry/syscalls/mksyscalltbl     | 40 +++++++---------------
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  2 +-
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  2 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  2 +-
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  2 +-
 tools/perf/util/syscalltbl.c                       | 14 ++++----
 7 files changed, 32 insertions(+), 47 deletions(-)

-- 
2.1.0

