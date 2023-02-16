Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62F0698BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBPFSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPFSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:18:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF41BACE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u2-20020a25ab02000000b0090f2c84a6a4so856822ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYTu7nw04Y/eGAN3i9eCzY/Ke38OAVixcrHXlu+jNFw=;
        b=WNV0WuL9vmXLIvOmuVEVNJHnS2Qfi+AtiXnEC8qLvBZk4nQfRysiQv+n6V2TYm/oOI
         8PVrbtoCrNJAR827RYRUq+srgPH7ettT9CkewSYs2c20qjx3DSR6OCNLU8I9VtlWJ1vK
         BTnTnTmkn3I2d2LJu6019qpcNY3Rtyhwbcu+BTERQU4CpKL9XQ+m6KDQOlEen5oxaVLd
         mpn44+vsVlTTH8ejjgOPKl/5T26Yr75D1Q+Pk5P8P+e6MTdUqg4koF2LdV4PYx+3j32Q
         lvmdVkZra/AZy5zB6Ynbz9xE0KdiJ+yp/dRpPvAGFlnQDPvuVze/cOT0f1MBvOftG1xW
         MgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYTu7nw04Y/eGAN3i9eCzY/Ke38OAVixcrHXlu+jNFw=;
        b=Ania1ZLP9q/F4RNkOFXcdEJbZv56ecwm5AGJQ9BhMAx+judzw6GBWo1HF92JV9TOB4
         bjILJPSGNkUO7RbZir+GuL9z6gheQem6474yDRPwhbbaDTvHToXpHlX7eQflngYsMFHo
         XnDDNy2/dZAViLuSu38r5WcJh5Ps4LQY2KXaDOkscenI5vFz8RszXUrGF+cDoLm32rs2
         dvrjjr9M9kU34QdZmqTlH9OtRkQCMoI6GbV90CoSPJV25R/UdX//B5ikj55lEXfRdtWU
         gZgSu81xF/ByoTH9sRWxPFB7FBKiR8BLCTCmbxgIo3OLs4iI+mdoZO6MrJu2uPoXmib2
         Usvg==
X-Gm-Message-State: AO0yUKVXkf08Q0JCIBm+kndP+PICAZpCLDEP/kIwL2fle1gCqMH2c/dP
        0O/EA20CYPlT0fEyvO9HxerCba7I4NY=
X-Google-Smtp-Source: AK7set+6hui8S8GzrNNsQxXJRqNjwGdwQ7uNZMDuv5k3QQ7TT5mar5i4p4eV6/CeDDFvXWED43V4tYaI94g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a05:6902:1024:b0:8fc:686c:cf87 with SMTP id
 x4-20020a056902102400b008fc686ccf87mr15ybt.4.1676524683783; Wed, 15 Feb 2023
 21:18:03 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:19 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-5-surenb@google.com>
Subject: [PATCH v3 04/35] maple_tree: remove extra smp_wmb() from mas_dead_leaves()
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
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>
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

The call to mte_set_dead_node() before the smp_wmb() already calls
smp_wmb() so this is not needed.  This is an optimization for the RCU
mode of the maple tree.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 44d6ce30b28e..3d5ab02f981a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5517,7 +5517,6 @@ unsigned char mas_dead_leaves(struct ma_state *mas, void __rcu **slots,
 			break;
 
 		mte_set_node_dead(entry);
-		smp_wmb(); /* Needed for RCU */
 		node->type = type;
 		rcu_assign_pointer(slots[offset], node);
 	}
-- 
2.39.1

