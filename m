Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653235FBA09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJKSCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5E6AA28
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d13so2673826qko.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5QVufruDuQ7ScvfaiWfIaPGCYfw/+yfvS4fqiA1Kf4=;
        b=IWKJwRYmyMN7KkNVstLPGLbs7bfXZUqvRrWV4JbZIMGo69wK5cmGCoVDtJ2JXkqgce
         dazyhm14O2rz+1KotTlCLMbGTyhbiBxLtTrqyfOUvTZsA9C0qbIVMeC9yQ/My2qE/F0+
         UnpQ4hxwWJ22GEgaYWA/IL38C/RTgiYJ0u0ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5QVufruDuQ7ScvfaiWfIaPGCYfw/+yfvS4fqiA1Kf4=;
        b=pJU0PHFbXq8iPliN9heW5GpWeQkR/nHyNb1PBH+3/cZ5nvCeZ6CjU3nfgjWpOLnJOD
         27hYtQvK7wBbV9Qgw1hGuzrcmcG1aW64Bz9lHPlqvZdPjbu4RPUyWTHUu8UlbEVek1xl
         ZJ/HGwo9iVoPY57UlH/Z2M4nBf9TZPTBQzPqpT7eFcpxtllzp6z35v0kFiRO45z3V9+J
         AA9vd96EZYzwszz6rTL8LlyK1suhxQSQFnJUH95KKSodX9KaOcAUm8PDoUxKDKlB3+TG
         z+HJYLw+kmjBnXMd/4nps/lDu7fqsLlK/u4zNf5cCASDLzcuqFvWHMN/OOVZYXZTuxtz
         CIvg==
X-Gm-Message-State: ACrzQf01ScYSuExW+XhprBf4HuWi2Wkxne+EETqOg8MUaDa7+YvaE3Fp
        1MlNEbZjpw5A2u7xCkX+iypdlA==
X-Google-Smtp-Source: AMsMyM4qgvCLc0tiHwizb0QTdjOZzoxM9/wwCOedIAWmeHVl9G6dyHhbydpfUdXIg5JJvZ8GoFV7xw==
X-Received: by 2002:ae9:dd04:0:b0:6e0:ae86:b4 with SMTP id r4-20020ae9dd04000000b006e0ae8600b4mr17598003qkf.146.1665511328618;
        Tue, 11 Oct 2022 11:02:08 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 00/13] rcu: call_rcu() power improvements
Date:   Tue, 11 Oct 2022 18:01:29 +0000
Message-Id: <20221011180142.2742289-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8 version of RCU lazy patches based on rcu/next branch. Very small mostly
cosmetic changes since v7, the one exception being the rxrpc patch.

I will post the tracing patches later along with rcutop as I need to add new
tracepoints that Frederic suggested.

Main recent changes:
1. rcu_barrier() wake up only for lazy bypass list.
2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
3. Take care of some callers using call_rcu_flush() API.
4. Several refactorings suggested by Paul/Frederic.
5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
6. New scripts in cover-letter to check for callbacks doing wake-ups.

I am seeing good performance and power with these patches on real ChromeOS x86
asymmetric hardware.

Earlier cover letter with lots of details is here:
https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/

List of recent changes:
    
    [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
      deferral levels wake much earlier so for those it is not needed. ]
    
    [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
    
    [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
    
    [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
    
    [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
    
    [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
    
    [ Paul/Frederic : Cosmetic changes, split out wakeup of nocb thread. ]
    
    [ Vlad/Joel : More call_rcu -> flush conversions ]

    [ debug code for detecting "wake" in kernel's call_rcu() callbacks. ]

The following 2 scripts can be used to check if any callbacks in the kernel are
doing a wake up (it is best effort and may miss some things, but we found
issues using it)

1. Script to search for call_rcu() references and dump the callback list to a file:
#!/bin/bash

rm func-list
touch func-list

for f in $(find . \( -name "*.c" -o -name "*.h" \) | grep -v rcu); do

	funcs=$(perl -0777 -ne 'while(m/call_rcu\([&]?.+,\s?(.+)\).*;/g){print "$1\n";}' $f)

	if [ "x$funcs" != "x" ]; then
		for func in $funcs; do
			echo "$f $func" >> func-list
			echo "$f $func"
		done
	fi

done

cat func-list | sort | uniq | tee func-list-sorted

2. Script to search "wake" after callback references:

#!/bin/bash

while read fl; do
	file=$(echo $fl | cut -d " " -f1)
	func=$(echo $fl | cut -d " " -f2)

	grep -A 30 $func $file | grep wake > /dev/null

	if [ $? -eq 0 ]; then
		echo "keyword wake found after function reference $func in $file"
		echo "Output:"
		grep -A 30 $func $file 
		echo "==========================================================="
	fi
done < func-list-sorted

Frederic Weisbecker (1):
rcu: Fix missing nocb gp wake on rcu_barrier()

Joel Fernandes (Google) (9):
rcu: Make call_rcu() lazy to save power
rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
rcuscale: Add laziness and kfree tests
percpu-refcount: Use call_rcu_flush() for atomic switch
rcu/sync: Use call_rcu_flush() instead of call_rcu
rcu/rcuscale: Use call_rcu_flush() for async reader test
rcu/rcutorture: Use call_rcu_flush() where needed
rxrpc: Use call_rcu_flush() instead of call_rcu()
rcu/debug: Add wake-up debugging for lazy callbacks

Uladzislau Rezki (2):
scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
workqueue: Make queue_rcu_work() use call_rcu_flush()

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

drivers/scsi/scsi_error.c |   2 +-
include/linux/rcupdate.h  |   7 ++
kernel/rcu/Kconfig        |  15 +++
kernel/rcu/lazy-debug.h   | 154 +++++++++++++++++++++++++++
kernel/rcu/rcu.h          |   8 ++
kernel/rcu/rcuscale.c     |  70 ++++++++++++-
kernel/rcu/rcutorture.c   |  16 +--
kernel/rcu/sync.c         |   2 +-
kernel/rcu/tiny.c         |   2 +-
kernel/rcu/tree.c         | 144 +++++++++++++++++--------
kernel/rcu/tree.h         |  12 ++-
kernel/rcu/tree_exp.h     |   2 +-
kernel/rcu/tree_nocb.h    | 215 +++++++++++++++++++++++++++++++++-----
kernel/workqueue.c        |   2 +-
lib/percpu-refcount.c     |   3 +-
net/rxrpc/conn_object.c   |   2 +-
16 files changed, 559 insertions(+), 97 deletions(-)
create mode 100644 kernel/rcu/lazy-debug.h

--
2.38.0.rc1.362.ged0d419d3c-goog

