Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A893567C0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjAYXgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjAYXgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:36:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4652915D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a14-20020a5b0ace000000b007bf99065fcbso132735ybr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu3p5HiJtTPZuGN+bqO+yFOC5Hz9ZieUjpaHjc/iiFw=;
        b=O3Dw/3Yf4QCHpXxfNvbShJeQEuFeZuaCO84YhsKbrfT9gihwXHPbAFRN/aHZ1lsYAC
         qgvLA/2wUiu0psYz4A7EZ32N7vcrezUtVg4gluDiovAd73nSCoLCjue3jqIRvyM8XHNi
         SclRHbL02JwJ/8QyQNyO8kpVKn5KS/kWq1y8oT8WTssLAAs6ZeUTA2CZ8CZH/ArlHruv
         /5QEuWLIWZWNh2Nma31HKz5RSg245aOjanktJB6bqUAOqyB+fKcWWKlMYW8vP7U0C0Fl
         poBIPYC0lSSLPSIW0BCqHBXJQ4Xga5iRXWZxkJmdRhnHZTAHGwylJAWWG4x9W7mFvX74
         pJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu3p5HiJtTPZuGN+bqO+yFOC5Hz9ZieUjpaHjc/iiFw=;
        b=qRvlLfTZWhWj/LsFq7+IxAeAhAMnr2ncm5Bql6eeEh3qdn1cxGKfjpEJiaXvaGcsF0
         oGCFWcABXyIb9MsmF8Ke0c2NtsRU8ny6WMd0nFK6lYlE6c0THYTNmsY3N4O8nbWUJvjz
         lQY32vYiyY6HAOP+AhyEvUnqdNiOVTVGvu87tA8kDdSfCTbwfsa6S2bDoeCFMLThHsto
         Xx48YLrosXCbPC/H7aMJq8yb4T1tjORC1S3/vAX+jpRSCnN5Fkc9RUZFutGaFpf4BEeT
         l5SgD5cX96Ay5pSiHl1J+96ZaeQoMHNDabwF250IKTpzhkyG3VQd57Knfgm3Y/f/TULr
         OaXA==
X-Gm-Message-State: AFqh2kqPpc/na2Ujor0RqvbBj1vfpUMq42SBKRun2xbDivldZbIcGEl8
        nSvAad/EA3CZPoWxLacWF4AkK6MdOiM=
X-Google-Smtp-Source: AMrXdXtpp7+Hs4EoYFj7KklscrSLOU6ca9mI+eR4n2eaFqWbrWVWQGu9P5Gq5ijnwlRlBQirW/76s6IejG0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a81:9148:0:b0:4fd:417b:7b8a with SMTP id
 i69-20020a819148000000b004fd417b7b8amr2939691ywg.404.1674689760727; Wed, 25
 Jan 2023 15:36:00 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:35:48 -0800
In-Reply-To: <20230125233554.153109-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125233554.153109-2-surenb@google.com>
Subject: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
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
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
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
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 6683c1b0f460..a531901859d9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 * orig->shared.rb may be modified concurrently, but the clone
 		 * will be reinitialized.
 		 */
-		*new = data_race(*orig);
+		memcpy(new, orig, sizeof(*new));
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		dup_anon_vma_name(orig, new);
 	}
-- 
2.39.1

