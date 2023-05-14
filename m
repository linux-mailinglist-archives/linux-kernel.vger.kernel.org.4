Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB142701E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjENQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:33:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935951FD3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:33:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba712bb7b28so14117919276.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684082024; x=1686674024;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cW39sCOiQuWUDDt62jwZLbPEO+MK1W7Jssj7ZgBQQzA=;
        b=nWZpfeKT1vKKVo/0MbH6ZGjWOcPjpzlEU39owpBlVnzPz/PCiAaymVhSTV1gOgUNV1
         xG7WUhJchN4HE8BcHbS9HFlcfFS6bDN6SKkVvPkiEZrQcIV7o4AkTMNZfLrX2WRbX0+t
         ioPXjZH9AFWtxK1ZjU+YJOYwnrGRTgw1kWItNH4eD3KcgtEuEvxdsVrp2EHcA29Hle5K
         AkuCQmrJ6o/75muTuaBWhvf6Oh+KgU2sdIoIxA3NEjvtkiILkTC+86oT51asLhuKjJof
         MiL7BlVQmBNlxVsFOV9ABR6Woqhp8Hphsn3PWQhyQY4FZ3Ib3TDSYSoCNsJqa6xQPLHj
         lSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684082024; x=1686674024;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cW39sCOiQuWUDDt62jwZLbPEO+MK1W7Jssj7ZgBQQzA=;
        b=MzlTir/+MMfOC5mcdF5Com9jt+SE+qr09a/41pncZ6jHoeb1nwkvO8HYfdchRUt/cq
         gsMs2llFMaMzwpoQVwQSbcIHJtmGeddgsWWarH+CvG/8xVP0+Umjf7KzmuixVJc+dn/f
         51zKG3Kb89AVoslExziS6nIPH2pbzMGajyZC2TJdd6d1fFOzIUiScvTVhkUZLaSRPxlF
         KpfE5WpMpqe1mGFqG4drgloMcETs7htrdn2lw20MFBlcp2XU+eBzR/XM+5I4ZvFtl7/Q
         ZVAvJSdw85JJGsMIdy+O7cNQ3HaUTGljPoU4x7QUFRRfuPBShDrHGbB/iRYpp6LsqYHV
         GbmA==
X-Gm-Message-State: AC+VfDyeXJlFXExhh8qiUZAp97fH4uLZZIMLpk0xEc8JDz1wVuGcSR8h
        +Nii3+A12zbxr4Uws2kqOUZDR7TLpfY=
X-Google-Smtp-Source: ACHHUZ4Vte0svHfW1+s+ohtYvezACgh+0auFBnz6XRVv/3Ufq/3+wM3l0CuZwJRdlFO9Df5CrIDBXt9F28Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a90e:968:96d4:175a])
 (user=surenb job=sendgmr) by 2002:a05:6902:1610:b0:ba7:8628:93e2 with SMTP id
 bw16-20020a056902161000b00ba7862893e2mr2248658ybb.4.1684082023857; Sun, 14
 May 2023 09:33:43 -0700 (PDT)
Date:   Sun, 14 May 2023 09:33:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230514163338.834345-1-surenb@google.com>
Subject: [PATCH 1/1] sched/psi: avoid resetting the min update period when it
 is unnecessary
From:   Suren Baghdasaryan <surenb@google.com>
To:     peterz@infradead.org
Cc:     yang.yang29@zte.com.cn, mingo@redhat.com, axboe@kernel.dk,
        tj@kernel.org, hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Psi_group's poll_min_period is determined by the minimum window size of
psi_trigger when creating new triggers. While destroying a psi_trigger,
there is no need to reset poll_min_period if the psi_trigger being
destroyed did not have the minimum window size, since in this condition
poll_min_period will remain the same as before.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
rebase of https://lore.kernel.org/all/202305121642367753446@zte.com.cn/
over git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core branch

 kernel/sched/psi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index b49af594ad28..81fca77397f6 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1407,11 +1407,16 @@ void psi_trigger_destroy(struct psi_trigger *t)
 			group->rtpoll_nr_triggers[t->state]--;
 			if (!group->rtpoll_nr_triggers[t->state])
 				group->rtpoll_states &= ~(1 << t->state);
-			/* reset min update period for the remaining triggers */
-			list_for_each_entry(tmp, &group->rtpoll_triggers, node)
-				period = min(period, div_u64(tmp->win.size,
-						UPDATES_PER_WINDOW));
-			group->rtpoll_min_period = period;
+			/*
+			 * Reset min update period for the remaining triggers
+			 * iff the destroying trigger had the min window size.
+			 */
+			if (group->rtpoll_min_period == div_u64(t->win.size, UPDATES_PER_WINDOW)) {
+				list_for_each_entry(tmp, &group->rtpoll_triggers, node)
+					period = min(period, div_u64(tmp->win.size,
+							UPDATES_PER_WINDOW));
+				group->rtpoll_min_period = period;
+			}
 			/* Destroy rtpoll_task when the last trigger is destroyed */
 			if (group->rtpoll_states == 0) {
 				group->rtpoll_until = 0;
-- 
2.40.1.606.ga4b1b128d6-goog

