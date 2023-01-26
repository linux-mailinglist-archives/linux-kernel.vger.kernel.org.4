Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6285C67D56C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjAZTiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjAZTiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:38:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15022023
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:37:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5063c0b909eso31120437b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLjaaxPJUorXnCMktZtzjKFOG8Xxelv9KGA9flqeCpQ=;
        b=fpC9OxtByMrsgeuCLlTqjq7ljheyeUGFByxdovFvi/BEZbaqTBtYfqbw7mV85n35vh
         nsJw1tLg82ZBRg3RV9Utdbg2g8s0Gs6HglMnvLMVN1RCTr4mkBoD2v2oZh4Mjh9w/Usr
         DL7mn5GFR4iC1hBs+0CvTUhQnmsv06W09b6suBaVdlve2NmFj/hGVpWM4xqWu44vFGv+
         cln+RN7Rzpw5J9WfB/zYjO6KEwxRe8QhOmkLvUNBVLba9roo72RSbcTHiolp9Ji6xuqA
         dACq72jx3kgKLuzmXwAspaoItebJfeBLbx4oDjP1Exnk9IXVYclbAW1J4WBLbHjzpPE8
         Y+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLjaaxPJUorXnCMktZtzjKFOG8Xxelv9KGA9flqeCpQ=;
        b=IzHGNDpwq+W0/HRteh1t+xXB/aVSgeBGFk/p1jnkTiZr1e9CVMqTAgHYpJbWsOIQQx
         mIFPj2WTYPvM20MR85jEU2nM0IsFz0Wp6ojA+nThbTzjiz/UpQH1C8nlaiIzk6gMyC5D
         eYfNOpBT5gh9t58y6D1vPFbrGO3Ma+QIsJCxCifgKnSccupvsNctAyW9s+JT+E05yHQU
         E2AMIhelJfW9GoSr2rCZfs1HakP5CSNNsu/3S70a/dChgtJF4aZ5GHyjLwTVVV0rSdT9
         V+NN53czq77aowmtEjFT99MHix8Jcskc3KxJkRwOqbXWXpdrKVGZxbShhYqs45Fk7NbT
         COBQ==
X-Gm-Message-State: AFqh2konMrYlNPYXUSSnqgrVJ2eBYMYMAZtWhsedETiBJGXjPmX7it8z
        /6eZuOCp3RzVmuYvkD/ubu8zmYkgDo0=
X-Google-Smtp-Source: AMrXdXvThl7i+LdwZ0FvFdLYZXBmPQfzv8R5JgH5MisJqIZuH2YNlDhICDf5h1c+oIs087t+N+fAgYzZdrs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:d774:88af:bab3:648d])
 (user=surenb job=sendgmr) by 2002:a0d:da83:0:b0:3c3:8b8e:13ee with SMTP id
 c125-20020a0dda83000000b003c38b8e13eemr4101612ywe.77.1674761878986; Thu, 26
 Jan 2023 11:37:58 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:37:46 -0800
In-Reply-To: <20230126193752.297968-1-surenb@google.com>
Mime-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126193752.297968-2-surenb@google.com>
Subject: [PATCH v4 1/7] kernel/fork: convert vma assignment to a memcpy
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
errors when we add a const modifier to vma->vm_flags.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 441dcec60aae..9260f975b8f4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -472,7 +472,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 * orig->shared.rb may be modified concurrently, but the clone
 		 * will be reinitialized.
 		 */
-		*new = data_race(*orig);
+		data_race(memcpy(new, orig, sizeof(*new)));
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		dup_anon_vma_name(orig, new);
 	}
-- 
2.39.1

