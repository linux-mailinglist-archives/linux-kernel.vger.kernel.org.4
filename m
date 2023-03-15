Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C06BA897
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjCOHD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCOHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:03:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DC5507E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:03:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h12so2227873pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678863820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpjEne9c/P1n+FoVmzWers86k2xzuSbdMk7FyOXv2PE=;
        b=OAZCgCrSIApq/wMfToqOvFw+w05e7Doc09CdtGnAZ0mqEpgqc9uid2e5n6I0OnYyT9
         ji/ZWoFjyPKcY7/Tryduo3EkyXkxZGRaqPn9K1vRTE428IXJ645jmi8fy/eGctizmUsI
         2OM96XR8DgpW4U49bJKOr2G2bFqPx2YLs79ghV3qzKPfu0y6RyE9KvdZrkSjmBfelh33
         46udJXAaieKWiz28NKWCbXBlq/bszTr48/Bnu1pm5jY9oE9wFL/ysK2UVjtBNKszcDRy
         Qx0N8asibaT2bkmmI0/4h/Q3kO6eTDxEYvST23vqHMURUUtD4DoOiCqVpcG8Dfrhz+Ru
         mhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678863820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpjEne9c/P1n+FoVmzWers86k2xzuSbdMk7FyOXv2PE=;
        b=Sb8nutkyT6mT5UomPQlaCU5ybYJIaIYPYkEEEcxttEnRRwPUdGuKUGQ24fgM1lSvdS
         ThlAw49LgMVSVy/5q07hy28pubxlCy21Q87li66CDT8x0WN6dvH/OMM4Sd/eiDmgKgBZ
         hjjUnUzjG1Zp5TUbpy0V8dxr4vwJVWLiEF9JSVVgucgCdnkTVgK177MJteeeVBYwKP3R
         H2sEIw1MlUPF8+LdOf9r0E3ZlINUb8DNFepDO5+MraPRDbhOWH8zE8h2LKBatq7UE7Nw
         xcpFi+T6BOi4XzROdi7eftfgUvUrjOo52voS09WyPaVrs6Yv9HoJ8NbFugNXyT875gw8
         kgAw==
X-Gm-Message-State: AO0yUKUgYGfKmoGNvaY0Etxo6Bep/GP8qdzpYn1zo8bOYRpDUExHIS1n
        YY34dHLtAY9gezibE2M+MSGd/Q==
X-Google-Smtp-Source: AK7set96UMPzJLhEUy2mCh6b7CazuoYGL6GJ771LlC6SyR641dqjNw7Z2Nw7HIi1VRZMtvP8oHMxWg==
X-Received: by 2002:a62:5f46:0:b0:625:55e5:afe4 with SMTP id t67-20020a625f46000000b0062555e5afe4mr4396384pfb.26.1678863820478;
        Wed, 15 Mar 2023 00:03:40 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b005ac8a51d591sm2731495pfa.21.2023.03.15.00.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:03:40 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@kernel.org
Cc:     hannes@cmpxchg.org, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [RFC] memcg, oom: clean up mem_cgroup_oom_synchronize
Date:   Wed, 15 Mar 2023 07:03:02 +0000
Message-Id: <20230315070302.268316-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to
the charge path"), only oom_kill_disable is set, oom killer will
be delayed to page fault path. In the charge patch, even if the
oom_lock in memcg can't be acquired, the oom handing can also be
invoked. In order to keep the behavior consistent with it, remove
the lock check, just leave oom_kill_disable check behind in the
page fault path.

Furthermore, the lock contender won't be scheduled out, this doesn't
fit the sixth description in commit fb2a6fc56be66 ("mm: memcg:
rework and document OOM waiting and wakeup"). So remove the explicit
wakeup for the lock holder.

Fixes: fb2a6fc56be6 ("mm: memcg: rework and document OOM waiting and wakeup")
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..360fa7cf7879 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1999,7 +1999,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	if (locked)
 		mem_cgroup_oom_notify(memcg);
 
-	if (locked && !memcg->oom_kill_disable) {
+	if (!memcg->oom_kill_disable) {
 		mem_cgroup_unmark_under_oom(memcg);
 		finish_wait(&memcg_oom_waitq, &owait.wait);
 		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
@@ -2010,15 +2010,8 @@ bool mem_cgroup_oom_synchronize(bool handle)
 		finish_wait(&memcg_oom_waitq, &owait.wait);
 	}
 
-	if (locked) {
+	if (locked)
 		mem_cgroup_oom_unlock(memcg);
-		/*
-		 * There is no guarantee that an OOM-lock contender
-		 * sees the wakeups triggered by the OOM kill
-		 * uncharges.  Wake any sleepers explicitly.
-		 */
-		memcg_oom_recover(memcg);
-	}
 cleanup:
 	current->memcg_in_oom = NULL;
 	css_put(&memcg->css);
-- 
2.25.1

