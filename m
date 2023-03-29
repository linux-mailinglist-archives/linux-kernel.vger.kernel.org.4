Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF86CDB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjC2OCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjC2OCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:02:46 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009C4EF8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h14so9321045pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680098533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uvssyWsx3k7MHrKeBtfOfjBMlx3rM4q3Jp1ubBODfw=;
        b=UGojkOsiNFyEp/1S8iu0e/uxzA14n3tjE4YuAtZmv7N2Kw7O8NFrkti471gstOEmNS
         ElyOJ2FLX/tvZU8x7kbqzsDL9qcTsI59T+r0B3Sk4k0uT3egGlKFxURlzTP/VKbKfcyc
         hPgfdW9/sSjoJ9ALXm389I3LpOyBMmJjTLK3tI6walzUsZmbNjD90R5qMsi99ylw7wco
         nT2UbDCY8dOFHNSlham/u8jhxslxJS7C295A05C+5/8IcVKwbGGCs0mBff8n1ZMHKMys
         1nppHy2bw2vL0EoyvRFuwsaPpd42A2Y5YF40QNWjkOpPpJQfxUhVSWBMdYHifzbDf/11
         rTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uvssyWsx3k7MHrKeBtfOfjBMlx3rM4q3Jp1ubBODfw=;
        b=CUT65z4k5J6wQCi/k69sm7GmDGmB+bvSTc1rRNKaTEvl0RAf7SHLJT7FlKDazfm3pJ
         DhHcpWun+QJZwPx40riQ87vLLw32s4XuL4eNgnJZU0luSoNtExL9tGDUqPJJOPKE8xrL
         g91FTOIdu29T7ikQhU5pRcEMSvMQXUM6mGSZODOpdx7U6TVFNHK58NULWn4xLCvq/3Lo
         Qzn2Fr3fXDR5gYgRYIGMHfwO5rFMEmkv6pkr4jOI9cA3Cj0LIucLXbZWyLBF6/aA/A/k
         ARIL08kD/qtC8J0PkFc17L5CcbwIdCCHEqBQf/iZh4wuyXfFOqJX0MvaG10NTwQ43nl4
         qx2Q==
X-Gm-Message-State: AAQBX9c226sZbuX5aCOq6idXI9b3lwDyC7zX01q4DQlwbnbSk9WP9GN6
        BFK9CxOAew4kxlueLw/GVVg93s0Z9/MmvKM0Ywc=
X-Google-Smtp-Source: AKy350Zu7f5eX6mOVbKMD+sOv6QkyLwxP6u50C0/15Nu8mhq7u6EIcFAOwM6F9nrt/UGfUx/Cec5dQ==
X-Received: by 2002:a62:190d:0:b0:628:aa3:82bc with SMTP id 13-20020a62190d000000b006280aa382bcmr15683522pfz.18.1680098533403;
        Wed, 29 Mar 2023 07:02:13 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:13 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 0/5] Introduce daemon failover mechanism to recover from crashing
Date:   Wed, 29 Mar 2023 22:01:50 +0800
Message-Id: <20230329140155.53272-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
1. Make enum cachefiles_object_state to all-uppercase and optimize the implement
   of CACHEFILES_OBJECT_STATE_FUNCS.
2. For struct cachefiles_object:
	1. Make ondemand field inside of "#ifdef CONFIG_CACHEFILES_ONDEMAND".
	2. Rename struct cachefiles_ondemand_info *private to *ondemand.
3. In ondemand_object_worker():
	1. Replace type casting with container_of().
	2. Remove useless "else".
4. In cachefiles_daemon_poll(), replace xa_(un)lock with rcu_read_(un)lock.

[Background]
============
In ondemand read mode, if user daemon closes anonymous fd(e.g. daemon
crashes), subsequent read and inflight requests based on these fd will
return -EIO.
Even if above mentioned case is tolerable for some individual users, but
when it happenens in real cloud service production environment, such IO
errors will be passed to cloud service users and impact its working jobs.
It's terrible for cloud service stability.

[Design]
========
The main idea of daemon failover is reopen the inflight req related object,
thus the newly started daemon could process the req as usual. 
To implement that, we need to support:
	1. Store inflight requests during daemon crash.
	2. Hold the handle of /dev/cachefiles(by container snapshotter/systemd).
BTW, if user chooses not to keep /dev/cachefiles fd, failover is not enabled.
Inflight requests return error and passed it to container.(same behavior as now).

[Flow Path]
===========
This patchset introduce three states for ondemand object:
CLOSE: Object which just be allocated or closed by user daemon.
OPEN: Object which related OPEN request has been processed correctly.
REOPENING: Object which has been closed, and is drived to open by a read
request.

1. Daemon use UDS send/receive fd to keep and pass the fd reference of
   "/dev/cachefiles".
2. User daemon crashes -> restart and recover dev fd's reference.
3. User daemon write "restore" to device.
   2.1 Reset the object's state from CLOSE to REOPENING.
   2.2 Init a work which reinit the object and add it to wq. (daemon can
       get rid of kernel space and handle that open request).
4. The user of upper filesystem won't notice that the daemon ever crashed
   since the inflight IO is restored and handled correctly.

[Test]
======
There is a testcase for above mentioned scenario.
A user process read the file by fscache ondemand reading.
At the same time, we kill the daemon constantly.
The expected result is that the file read by user is consistent with
original, and the user doesn't notice that daemon has ever been killed.

https://github.com/userzj/demand-read-cachefilesd/commits/failover-test

[GitWeb]
========
https://github.com/userzj/linux/tree/fscache-failover-v5

RFC: https://lore.kernel.org/all/20220818135204.49878-1-zhujia.zj@bytedance.com/
V1: https://lore.kernel.org/all/20221011131552.23833-1-zhujia.zj@bytedance.com/
V2: https://lore.kernel.org/all/20221014030745.25748-1-zhujia.zj@bytedance.com/
V3: https://lore.kernel.org/all/20221014080559.42108-1-zhujia.zj@bytedance.com/
V4: https://lore.kernel.org/all/20230111052515.53941-1-zhujia.zj@bytedance.com/

Jia Zhu (5):
  cachefiles: introduce object ondemand state
  cachefiles: extract ondemand info field from cachefiles_object
  cachefiles: resend an open request if the read request's object is
    closed
  cachefiles: narrow the scope of triggering EPOLLIN events in ondemand
    mode
  cachefiles: add restore command to recover inflight ondemand read
    requests

 fs/cachefiles/daemon.c    |  16 +++-
 fs/cachefiles/interface.c |   7 +-
 fs/cachefiles/internal.h  |  59 +++++++++++++-
 fs/cachefiles/ondemand.c  | 166 ++++++++++++++++++++++++++++----------
 4 files changed, 202 insertions(+), 46 deletions(-)

-- 
2.20.1

