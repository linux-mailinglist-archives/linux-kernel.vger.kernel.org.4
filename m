Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AF600138
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJPQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJPQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFE399FE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g16so1676756qtu.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EfL9qo+tnXRZw57qLV9hJU65qsx5ZhXUYQ5ALk358E=;
        b=aG1SztSPzsEHQ6UyF3mg/FvXqmLt90142+V/pAZP8gyaChbHqOb0JvRkpyKllPzC/0
         NsUqfEOUrvz4bqGs629mywrOqD8X26L7Hw+QXdt04gLDF11w59mT2iT4qjNcYWTFtL7+
         /c3zl41xxn92HmAB8NjroDUWb5zQIEsMlY3bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EfL9qo+tnXRZw57qLV9hJU65qsx5ZhXUYQ5ALk358E=;
        b=0kTre2zFx7RYN2wLcPKNIvqsBkuYKGBSzaKcUwF7QgF1PATA/x5ZTF6wLR+fM0q8q1
         m0K+YzpJIC4Rm2dJldmyRPBnRXcOLSxPDOL1DEBV3/9rJETDXbj+MyF+T6akzBnKVncT
         +cfeHXflzzh/j9Xx644m3rBkDfygUMtYNiVPQmJe8gSNrFLiyX3fyRjONWUsCn5vhArg
         EPLwmpJxo4gKrsELzRckUzmVj4v/5QrCKzS7ZyGgRReBFp0bGNv8uE6aEuxOP00n+Nhf
         ejWCYgjoPLCnWOgMVciPWr+OUNLDIctbGOmz8QIAzm1sg+LckdTxvvlMuhJ3/2CngwFu
         nX+A==
X-Gm-Message-State: ACrzQf2aKacGc7SN2yN/2DnVX3qcFM+3Y+DQBWZlM3HNLhPmaWoAGXxq
        FX8O8gJU/R92EAYqtd3l2DXI2QVXd7Z+Pg==
X-Google-Smtp-Source: AMsMyM7xHf+OQjSR4doFrCyimeVba7DaDe41B4M4md/HAQyVUobN6EYfV/kWKshzEFsnQIbWDeHByQ==
X-Received: by 2002:a05:622a:1493:b0:39c:e9e4:312 with SMTP id t19-20020a05622a149300b0039ce9e40312mr1389732qtx.49.1665937414900;
        Sun, 16 Oct 2022 09:23:34 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 00/13] rcu: call_rcu() power improvements
Date:   Sun, 16 Oct 2022 16:22:52 +0000
Message-Id: <20221016162305.2489629-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9 version of RCU lazy patches based on rcu/next branch.
 Only change since v8 is this discussion:
 https://lore.kernel.org/rcu/20221011180142.2742289-1-joel@joelfernandes.org/T/#m8eff15110477f3430b3b02561b66f7b0d34a73b0

To facilitate easier merge, I dropped tracing and other patches and just
implemented the new changes. I will post the tracing patches later along with
rcutop as I need to add new tracepoints that Frederic suggested.

Main recent changes:
1. rcu_barrier() wake up only for lazy bypass list.
2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
3. Take care of some callers using call_rcu_flush() API.
4. Several refactorings suggested by Paul/Frederic.
5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.

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
kernel/rcu/rcuscale.c     |  70 +++++++++++-
kernel/rcu/rcutorture.c   |  16 +--
kernel/rcu/sync.c         |   2 +-
kernel/rcu/tiny.c         |   2 +-
kernel/rcu/tree.c         | 149 ++++++++++++++++++--------
kernel/rcu/tree.h         |  12 ++-
kernel/rcu/tree_exp.h     |   2 +-
kernel/rcu/tree_nocb.h    | 217 ++++++++++++++++++++++++++++++++------
kernel/workqueue.c        |   2 +-
lib/percpu-refcount.c     |   3 +-
net/rxrpc/conn_object.c   |   2 +-
16 files changed, 565 insertions(+), 98 deletions(-)
create mode 100644 kernel/rcu/lazy-debug.h

--
2.38.0.413.g74048e4d9e-goog

