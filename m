Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08768A37C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBCUTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjBCUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:19:40 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B239D58A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:19:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w3so6853766qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 12:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlO+7yJUL6nZz6lWyKAteQU74Ju3H8abrNP72ihWCAM=;
        b=Kmqgxr98A8rmlt1eG1Qvlry8R2htsdd8gpZ6xlaKDfwShmcldtpeNwAwBl+zru4UHO
         EjSIuyi/1gvQIqauWKxF1u9onlcTqDp2tfx7qNRK4/Y3nKJ9VCvqtvFoKH9iEkIm9TtH
         lMJWMucq5G4qzkWScRZDtPT9ns3GVif+j0OXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlO+7yJUL6nZz6lWyKAteQU74Ju3H8abrNP72ihWCAM=;
        b=CJoWrAK4jHbZO6v+QxIEb5a+74f9kn3CuoNr9v1uOHmn1Xke8/MCSrfpDTp8GPFffs
         6ZK7nORyqjYQQX25/DAV6CJmpaOMQ2VbvSgxE3wZhBfdi0APqJ2dVp2EeDrO2dSY8qy4
         dvZ/3TDPkBCBXkdY4rgEV3GgfcwmlBrzGlc8Z8rNqRKxicteSuVZ/cU2MV5s1244kUje
         Tshuc5rwfrAkynHFyw3Vt2OuZbBhJN3OGifUgmifI2+u7m/EyknqDAEYytclbcufCGD8
         pmJy8n81Skw833sNh6DlQDUinz7gAaJfAgrLnxiitgDjOXEPE5kgWXzRdxNU28xJN5gV
         4q2g==
X-Gm-Message-State: AO0yUKVp0HmNW4M8bmfEAgo1dLwmwWNbO0O0a/sySG6R2rK4N/OVP9Ia
        ivVKWueYUcov9FD8zVNd3ldUiIC2uhhmv4mI
X-Google-Smtp-Source: AK7set9nC+TUlWirAN+jtujA8yCUlYb0urmBCrtJgYrW0olrJKhCm4nX/TVN2h+LCT26hzgcod7jnQ==
X-Received: by 2002:ac8:7e86:0:b0:3b9:a641:aa66 with SMTP id w6-20020ac87e86000000b003b9a641aa66mr21897622qtj.15.1675455577457;
        Fri, 03 Feb 2023 12:19:37 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id g17-20020ae9e111000000b006ce580c2663sm2457424qkm.35.2023.02.03.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 12:19:36 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH RFC] tools/memory-model: Restrict to-r to read-read address dependency
Date:   Fri,  3 Feb 2023 20:19:13 +0000
Message-Id: <20230203201913.2555494-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a code-reading exercise of linux-kernel.cat CAT file, I generated
a graph to show the to-r relations. While likely not problematic for the
model, I found it confusing that a read-write address dependency would
show as a to-r edge on the graph.

This patch therefore restricts the to-r links derived from addr to only
read-read address dependencies, so that read-write address dependencies don't
show as to-r in the graphs. This should also prevent future users of to-r from
deriving incorrect relations. Note that a read-write address dep, obviously,
still ends up in the ppo relation via the to-w relation.

I verified that a read-read address dependency still shows up as a to-r
link in the graph, as it did before.

For reference, the problematic graph was generated with the following
command:
herd7 -conf linux-kernel.cfg \
   -doshow dep -doshow to-r -doshow to-w ./foo.litmus -show all -o OUT/

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/memory-model/linux-kernel.cat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index d70315fddef6..26e6f0968143 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -69,7 +69,7 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
-let to-r = addr | (dep ; [Marked] ; rfi)
+let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
-- 
2.39.1.519.gcb327c4b5f-goog

