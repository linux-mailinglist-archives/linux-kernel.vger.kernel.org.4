Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFBD7204DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjFBOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjFBOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:49:45 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4911B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:49:44 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b076babc3so222265485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685717383; x=1688309383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+W15rfScEnoI/mrJeUesZBBA4dLDwf3J5+pS12uz+M=;
        b=f71g/5ZKbrWUFALhPbxASrYJBsG3XFsCbA942xKD/gEdodHicByXaClP7Rr6EBml+N
         VukIXF1wcSF++tF2km0cj522zvXsGAaNLdsseoSLzqJ+9xjXIidxQSshVwt4qIMtxBlZ
         4VvGAubKeVdo7roPTJ6OqbBE7ebD4EDQvLrCNsGvBmcIct+47wTnnoO0JaMcojxHkqoF
         xOh5/nIgKn3crt21JgGwM8CGeSMJew+ttgO/Xh7eN6uWj14Tn7q4s4TM6DLsWKI5xtb5
         XPn6+ygAbOcM2D2JYOzqstuMukSJXpgCi0eTBAEG0To0+3UeOV42/NmHaMDYBvpyqcTA
         ibAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717383; x=1688309383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+W15rfScEnoI/mrJeUesZBBA4dLDwf3J5+pS12uz+M=;
        b=JdvOuNPmMimehREi+qzthz8/PUGvrdCUtyknkChX2OPdu+YR8K+0NISHNOt2nAuOzj
         u3Vz+Z1P6Po7bc4x+hZpCrYbOubwLYqa/qhmFp8KCSfRV/EdhQaudI0tpJl8Zl3fLgt5
         /nuOYH2eIS96uhFUyN2v4CAx7ovNMvw34N9GmGmXp4WonbazRji17HgjMFch33xVAVYS
         dqZtq86dH3nTf0DXf5KYuBMOiJ7WEixfIP4RdbWwDPYfh4t+x+VL+ClnxNfKnAqHEbdo
         TPGjxGGbEL52AW0PObDja4OIG/U6QiFR3fGvEM6dL2BaWNueR3Fn7JmU+vR4wEvXv+68
         qPig==
X-Gm-Message-State: AC+VfDx1oOBp+zPbOMg+XfiJiCFgApPsp2ZXY59CGzXqM52GSesYtEsJ
        sL8U08njY7wvZAF0HVSNVFCyMA==
X-Google-Smtp-Source: ACHHUZ6plvXNTbNxsVDiSI/KAHjtnUlCwjMjQvNHvIeDH2lCQXLkqTX3wpQA5B/i7Rsmw9Satcy6ug==
X-Received: by 2002:a05:620a:4688:b0:75b:23a1:3660 with SMTP id bq8-20020a05620a468800b0075b23a13660mr14661123qkb.33.1685717383350;
        Fri, 02 Jun 2023 07:49:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a13a600b0075ca93fd90dsm707457qki.45.2023.06.02.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:49:43 -0700 (PDT)
Date:   Fri, 2 Jun 2023 10:49:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/5] mm: compaction: refactor __compaction_suitable()
Message-ID: <20230602144942.GC161817@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-4-hannes@cmpxchg.org>
 <5f3ad5f3-780d-1ff7-5f97-0dc8b5611581@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3ad5f3-780d-1ff7-5f97-0dc8b5611581@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 07:11:35PM +0200, Vlastimil Babka wrote:
> On 5/19/23 14:39, Johannes Weiner wrote:
> > __compaction_suitable() is supposed to check for available migration
> > targets. However, it also checks whether the operation was requested
> > via /proc/sys/vm/compact_memory, and whether the original allocation
> > request can already succeed. These don't apply to all callsites.
> > 
> > Move the checks out to the callers, so that later patches can deal
> > with them one by one. No functional change intended.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Note comment on compaction_suitable() still mentions COMPACT_SUCCESS, that
> is no longer possible, so delete that line?

Good catch, let's remove it.

> Also on closer look, both compaction_suitable() and __compaction_suitable()
> could now simply return bool. The callers use it that way anyway. There
> would just be some extra fiddling internally aroud the tracepoint.

Also a great idea. This will raise conflicts in later changes, so I'll
send a new patch to go on top of the stack.

Andrew, can you please fold this? Thanks!

---
From abaf21e8dc2a3ed2aa181e0c89403807e5cea67d Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 2 Jun 2023 10:13:15 -0400
Subject: [PATCH] mm: compaction: refactor __compaction_suitable() fix

Vlastimil points out the function comment is stale now. Update it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8f61cfa87c49..0503cb59c1cb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2238,7 +2238,6 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
  * compaction_suitable: Is this suitable to run compaction on this zone now?
  * Returns
  *   COMPACT_SKIPPED  - If there are too few free pages for compaction
- *   COMPACT_SUCCESS  - If the allocation would succeed without compaction
  *   COMPACT_CONTINUE - If compaction should run now
  */
 enum compact_result compaction_suitable(struct zone *zone, int order,
-- 
2.40.1

