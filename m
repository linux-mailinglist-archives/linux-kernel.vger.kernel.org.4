Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06069652CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiLUGCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiLUGBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:53 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31C14D05
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:38 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 7so4710509pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHRqJFCqqiUbAcLl4rJqQJzKFG6tPNSYjirqr984MSA=;
        b=O8AhDZ/k7Q9w4CuljbyvCn754AYl8IRAr+sz1YmGdipQW5IseqgATF+4k0SEDPRQ6f
         wepmg+rOixnKd/oqWfCRB78BNSf7HEMx1C13UfIuxxqc/OCZBFofhsQIEcKhs3kEaZ3P
         W9oj23ziWiUfbblsOtbCOspq01s6mUeR+hMvUJnI4IuHID8HXaZWFYxC5FaYFvktYfCZ
         EbAu+aX680QqWMqq9G/GNwTX+yK4bmYhph2fRkEVjA33PzI35wYhgI1rcoVryEAkW0ij
         WtfRkRjorH5TuDvAX5X44/3yXc6eloM9ig1e/aI8BG67m9AU4vYSVcfxTqDTz1fj5E8b
         1rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHRqJFCqqiUbAcLl4rJqQJzKFG6tPNSYjirqr984MSA=;
        b=tX1bwy1fPf1P0mr6pWZjci0lH5vzkRvnsx5BZPRSC4C7R2cH1+CIgWl2OoqqW8uLts
         W2ZFlBek7qp4NLN1MiyQPJxfdUMPB+kpbdPyrqd1MZyxq5pgCenwAVI3sjHusjOfEkim
         5+hNL4V7JzEVpZ5qGEiTzROuJHL2tpkJ4waRObqOg4dLeW8tuaY6h9ve0EgY3Phxg8Ef
         /RZ8SmcXPdYiEHIA69XQUowCOWCbBJXD9WzkpBjrjYwTBXxf5d3j40ZnPud0jVTVNxU0
         ndLE8U+/I4YgRNJ45ShCeLUQ/7ohdW1fICcnNLDRSwBxbwcoE5qjoN8ykRfY016va9ym
         3i7w==
X-Gm-Message-State: AFqh2kp5WdJ4whpicP5ikXAH/1pAtjZbMo5CSVCQNXohOlbJJbo/p2Dj
        ZlIzraZqjPTu3QgPg8JBndM=
X-Google-Smtp-Source: AMrXdXtSazAK9U1vNS3/o6BIyP1/8lzeUvDoZaO03p3Z3P41jrM61NRwAal+lrvrY4+4kZW17syywg==
X-Received: by 2002:a62:ab16:0:b0:56b:d68d:7136 with SMTP id p22-20020a62ab16000000b0056bd68d7136mr1120872pff.11.1671602497635;
        Tue, 20 Dec 2022 22:01:37 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:37 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 5/7] maple_tree: remove the redundant code
Date:   Wed, 21 Dec 2022 14:00:56 +0800
Message-Id: <20221221060058.609003-6-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221060058.609003-1-vernon2gm@gmail.com>
References: <20221221060058.609003-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros CONFIG_DEBUG_MAPLE_TREE_VERBOSE no one uses, functions
mas_dup_tree() and mas_dup_store() are not implemented, just
function declaration, so drop it.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 include/linux/maple_tree.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 4ee5a969441c..815a27661517 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -12,7 +12,6 @@
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 /* #define CONFIG_MAPLE_RCU_DISABLED */
-/* #define CONFIG_DEBUG_MAPLE_TREE_VERBOSE */
 
 /*
  * Allocated nodes are mutable until they have been inserted into the tree,
@@ -483,9 +482,6 @@ static inline bool mas_is_paused(struct ma_state *mas)
 	return mas->node == MAS_PAUSE;
 }
 
-void mas_dup_tree(struct ma_state *oldmas, struct ma_state *mas);
-void mas_dup_store(struct ma_state *mas, void *entry);
-
 /*
  * This finds an empty area from the highest address to the lowest.
  * AKA "Topdown" version,
-- 
2.34.1

