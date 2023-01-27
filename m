Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1867EE80
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjA0Tm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjA0Tmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:42:53 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A602B7AE44
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id om10-20020a17090b3a8a00b002299e350deaso4781924pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6D7AVbhEFxAo5EKdbJ2HQfTq9cKDp9C6gMDUsIDn2rU=;
        b=ij3G6594G9QMVIcaC7y7IotZlrRGSd461+VUEA/BMKS/DqdJRnleVk5IzJ5gil69bZ
         nXwMrZpHBfopZhY+dBOM8TntT+xgyMzx0lhn0c4XjFlDdq8hUc51rQLAJayIjAlxU0Vs
         tSDUCQts0+fWuoHVHrLcPeZOnjtBdS6uOzMiFPrkU4AVT++YMj0+eDXitszbX73gjVet
         Uj7on6Z68KT42I30IFAHZ8MnQyKVo+KH97KXkIJWbVMmYdISzeeP/HtVHdR/3Pzjnpiz
         r0YfwFvkG3mRoMMu6hvaQ0O0QqVpO+Mcl7G8itnKrK/kLoHBd5Ey6CcVhBTBp6nBJTd/
         24fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D7AVbhEFxAo5EKdbJ2HQfTq9cKDp9C6gMDUsIDn2rU=;
        b=5nPrbRm9BDFfVpwkFKr5cFjhiDQgUq9n3D4YOhCJTh3mLLYu5Q8UFU4n9C/hQa0Fcv
         R99XWI96OyBysoEVRtRug/NvqAtSS2YT17qcKIu6Zax+mgQkNIzRXnufNyA7SZ6+EkKj
         6CUb0Rfnnsr8mLX1yuw0vJ2evI5Bs/W/uP7qy2WPKIUS2HnQ1DbVkg8dFh+tB+vSOAkA
         E6b5/o162LD/ITIgYxTjp3UUKUh9hhSM0keF1mx265aRQk21g+O3x8FXTUKE/mfylNHL
         a8b25BLSXC2cWULM3x6Ztdr+m0KjG+9arJ4HUnoLCuTNbSWL4TC6pdNywR9jp6y9a9Az
         AX4A==
X-Gm-Message-State: AO0yUKXgDJyHl8MsqKy2+pJFUILsmFRX0zIjGI6aGZkx7OvXYcokLyWz
        siwMAHxBRtY0wzm/ZkPAyJLSU5wopFI=
X-Google-Smtp-Source: AK7set+8nPPCBQ/ToCHxQhHQnspD+CZKcqljSV2Aj5HMLvXZA8Wu8rpp2+AujJr6dncfulY9izqabQa2p3o=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a05:6a00:1990:b0:593:909f:ed45 with SMTP id
 d16-20020a056a00199000b00593909fed45mr72889pfl.0.1674848478930; Fri, 27 Jan
 2023 11:41:18 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:39 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-3-surenb@google.com>
Subject: [PATCH v2 02/33] maple_tree: Detect dead nodes in mas_start()
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
        surenb@google.com, Liam Howlett <Liam.Howlett@oracle.com>
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

From: Liam Howlett <Liam.Howlett@oracle.com>

When initially starting a search, the root node may already be in the
process of being replaced in RCU mode.  Detect and restart the walk if
this is the case.  This is necessary for RCU mode of the maple tree.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e5eeecd14eee..482e17a460cb 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1353,12 +1353,16 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 		mas->max = ULONG_MAX;
 		mas->depth = 0;
 
+retry:
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
 			mas->node = mte_safe_root(root);
 			mas->offset = 0;
+			if (mte_dead_node(mas->node))
+				goto retry;
+
 			return NULL;
 		}
 
-- 
2.39.1

