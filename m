Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873915E8DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiIXPWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8771670E4B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664032956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+1snCaUxjImmAZmhoUxFGMZM8+j1Rt0OvqNSuvK1WBc=;
        b=TjLP5r9KZjDbK8xhyuYbwzmUlubRVAswXKsux/kJT3EuIViWIVSIL7NkoBv0pMmSTKc/Ci
        rPaEyb2GrCQmCyP0ILweYAKMW47I7aITivjMuv+5l25dDhBUMVt6Q/PVl58Cb11sPU6Quw
        tWe+WMnL/hB/dWQgsnziFMXyiSaBTA4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-LjpuhHN2NN6l1grCKRecKw-1; Sat, 24 Sep 2022 11:22:35 -0400
X-MC-Unique: LjpuhHN2NN6l1grCKRecKw-1
Received: by mail-wm1-f69.google.com with SMTP id d5-20020a05600c34c500b003b4fb42ccdeso4327474wmq.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+1snCaUxjImmAZmhoUxFGMZM8+j1Rt0OvqNSuvK1WBc=;
        b=Qsm9566VxUqmPo3zwA8dNVPJ4CnQyA7DTTs69Bf9FmDXZvh6bYB8201thLHuB+RH3J
         JYm33robBgfH4VGsOs3hMD0P6FbzC9uUM6i9WIr0D7BiVi2lgsDAdd2JGsxJJzDrbxmj
         ttGwEODS/VyoXPM6XngQqBECQ+UtkRmkh4q5XExHDBR+C5igBP8VgMDeOLEqJ/X3mXQj
         Q/YSgsDuSfbbkOLSxrkse3iSsprajEgtYxYQCzuzLykdviUy6s3y/G73JBTUBOSAJmVJ
         16wG7p71TdXDvczTjbg/OV1Hw8EZeW/Mze90Vw8moCpn4DTgQLifx08Ot622lxWG7eyD
         NUpQ==
X-Gm-Message-State: ACrzQf3lWfNgxdJKAfWNcjATMXbnZZ495NGwmmbmC0oYbPx0K2Is8Nii
        lQPXDa6+1t3UaiRqxg5aN1upgPC2yIs3Xi0yaKpt6df1GHwLOBRUyZH1BUZnpY/C6332yW2zVJi
        70umQIYbd+uTgYcryxkBTjgY=
X-Received: by 2002:a5d:464e:0:b0:228:c179:6b0a with SMTP id j14-20020a5d464e000000b00228c1796b0amr8134531wrs.402.1664032949084;
        Sat, 24 Sep 2022 08:22:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4TaZvijmxZ2nQ7hQk8K9Er9662cfbHWMFdqgZM+aw7znzTA9McjO7K/BHPrwx/RsX90TFDUw==
X-Received: by 2002:a5d:464e:0:b0:228:c179:6b0a with SMTP id j14-20020a5d464e000000b00228c1796b0amr8134522wrs.402.1664032948866;
        Sat, 24 Sep 2022 08:22:28 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v8-20020adfa1c8000000b0022865038308sm10129123wrv.93.2022.09.24.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:22:27 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 0/5] Ensure quiet_vmstat() is called when the idle tick was stopped too
Date:   Sat, 24 Sep 2022 16:22:22 +0100
Message-Id: <20220924152227.819815-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic, Marcelo,

This patch series addresses the following two problems:

    1. A customer provided some evidence which indicates that
       the idle tick was stopped; albeit, CPU-specific vmstat
       counters still remained populated.

       Thus one can only assume quiet_vmstat() was not
       invoked on return to the idle loop. If I understand
       correctly, I suspect this divergence might erroneously
       prevent a reclaim attempt by kswapd. If the number of
       zone specific free pages are below their per-cpu drift
       value then zone_page_state_snapshot() is used to
       compute a more accurate view of the aforementioned
       statistic.  Thus any task blocked on the NUMA node
       specific pfmemalloc_wait queue will be unable to make
       significant progress via direct reclaim unless it is
       killed after being woken up by kswapd
       (see throttle_direct_reclaim())

    2. With a SCHED_FIFO task that busy loops on a given CPU,
       and kworker for that CPU at SCHED_OTHER priority,
       queuing work to sync per-vmstats will either cause that
       work to never execute, or stalld (i.e. stall daemon)
       boosts kworker priority which causes a latency
       violation


As seen previously, the trivial test program (i.e. attached at the end of
this cover letter) executed inside a KVM VM, was used to determine the
somewhat impact under vanilla and with the proposed changes. Firstly, the
mlock(2) and munlock(2) system calls was used solely to modify vmstat item
'NR_MLOCK'. In another scenario, the nanosleep(2) system call was used
several times to suspend execution for a period of time to approximately
compute the number of CPU-cycles in the idle code path. The following is an
average count of CPU-cycles across the aforementioned system calls and the
idle loop, respectively. I believe these results are negligible:

				  Vanilla                 Modified

  Cycles per idle loop            151858                  153258  (+1.0%)
  Cycles per syscall              8461                    8690    (+2.6%)


Any feedback would be appreciated. Thanks.


Changes since v7 [1]
 - Added trivial helpers for modification and testing
   (Andrew Morton)
 - Modified comment since we do now cancel any delayed
   work if the tick is stopped in quiet_vmstat()
 - Moved check to ensure vmstat differentials do not
   remain if the tick is stopped on exiting to user-mode
   into a separate patch
   (Frederic Weisbecker)

Changes since v6 [2]:
 - Clean vmstat_dirty before differential sync loop
 - Cancel pending work if tick stopped
 - Do not queue work to remote CPU if tick stopped

Changes since v5 [3]:

 - Introduced __tick_nohz_user_enter_prepare()
 - Switched to EXPORT_SYMBOL_GPL()

Changes since v4 [4]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [5]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/lkml/20220817191346.287594886@redhat.com/
[2]: https://lore.kernel.org/linux-mm/20220808194820.676246-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220801234258.134609-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/


Aaron Tomlin (4):
  mm/vmstat: Add CPU-specific variable to track a vmstat discrepancy
  mm/vmstat: Use vmstat_dirty to track CPU-specific vmstat discrepancies
  tick/nohz_full: Ensure quiet_vmstat() is called on exit to user-mode
    when the idle tick is stopped
  tick/sched: Ensure quiet_vmstat() is called when the idle tick was
    stopped too

Marcelo Tosatti (1):
  mm/vmstat: Do not queue vmstat_update if tick is stopped

 include/linux/tick.h     |  5 ++-
 kernel/time/tick-sched.c | 18 ++++++++-
 mm/vmstat.c              | 80 +++++++++++++++++++++-------------------
 3 files changed, 62 insertions(+), 41 deletions(-)

-- 
2.37.1

--- test-vmstat-overhead.c ---

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>

typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;
typedef unsigned long long u64;

#ifdef __x86_64__
#define DECLARE_ARGS(val, low, high)    unsigned long low, high
#define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
#define EAX_EDX_ARGS(val, low, high)    "a" (low), "d" (high)
#define EAX_EDX_RET(val, low, high)     "=a" (low), "=d" (high)
#else
#define DECLARE_ARGS(val, low, high)    unsigned long long val
#define EAX_EDX_VAL(val, low, high)     (val)
#define EAX_EDX_ARGS(val, low, high)    "A" (val)
#define EAX_EDX_RET(val, low, high)     "=A" (val)
#endif

static inline unsigned long long __rdtscll(void)
{
        DECLARE_ARGS(val, low, high);

        asm volatile("cpuid; rdtsc" : EAX_EDX_RET(val, low, high));

        return EAX_EDX_VAL(val, low, high);
}

#define rdtscll(val) do { (val) = __rdtscll(); } while (0)

#define NRSYSCALLS 30000
#define NRSLEEPS   100000

void main(int argc, char *argv[])
{
	unsigned long a, b, cycles;
	int i, syscall = 0;
	void *page = malloc(4096);

	if (mlock(page, 4096))
		perror("mlock");
	if (munlock(page, 4096))
		perror("munlock");

	if (argc != 2) {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}

        rdtscll(a);

	if (strncmp("idle", argv[1], 4) == 0)
		syscall = 0;
	else if (strncmp("syscall", argv[1], 7) == 0)
		syscall = 1;
	else {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}
	
	if (syscall == 1) {
        	for (i = 0; i < NRSYSCALLS; i++) {
			if (mlock(page, 4096))
				perror("mlock");
			if (munlock(page, 4096))
				perror("munlock");
		}
	} else {
        	for (i = 0; i < NRSLEEPS; i++)
		 	usleep(10);
	}

        rdtscll(b);

        cycles = b - a;

	if (syscall == 1)
        	printf("cycles per syscall: %d\n", (b-a)/(NRSYSCALLS*2));
	else
		printf("cycles per idle loop: %d\n", (b-a)/NRSLEEPS);
}

