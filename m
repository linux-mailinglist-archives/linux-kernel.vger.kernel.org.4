Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B104C652280
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiLTO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiLTO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB318B34
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m4so12428269pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RInimQUAJH6gGKd+DihgXOqmcnGSJ33LRPnqziACYsI=;
        b=XIEcnWkobtVg4DIxwFqH41x2Ge6wQKVtzVCpH+HAHZ9lrboAxazyK/Mo/Z2Uafuz7G
         oVxlJFG/hvLdO+asmcnKKWHeUxTK/DJq6T4n2q3O4Oj+zqjIdhOW7jCqU1aKoSIRefQx
         BQd2+PvqrXPf3e572PEis73X0EPGP7kGZimbNakPpcFYd9MD0yd7og6Zzi1igGaq0zVE
         i4F2JGU9FIC47BjZjAayOoLGOPa+APh4JFIToNjMdRYh4Zuet863l1DTN91GggWW6WYA
         juqMmEYbwbLmRAXIRSmP3eTkFdOe+fRpfR7vynpnlmaNhB7T/ChRAYGrrCGLk2IuR/KX
         VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RInimQUAJH6gGKd+DihgXOqmcnGSJ33LRPnqziACYsI=;
        b=XWETGgy6ZotBWazBZUEJT1josh5Qlqm7Q/XYKDd9x+2K8Dy+Cjacdt70+3PjCMd2GN
         /WQ37hGxYVaS9Sn5ShCw/vVRM00MARi1gNT/nsHgpe2hFMQ9G3D4mP5BbD4WM9O6y7fP
         EmrYAyUX6cIPrDbc+w/IzZL/lAlJplHlow8fKrWfUXqMAka7h0zsm93hasf7wRHQ5ii+
         OG3zhBdHhXRbTlcvk/xFNR4fuqYiWhvwEJXp0wDXIGyPRBPAT5IGc/LjPdQWvmQcmhJN
         1B7/lfyCQfQSXiT1quT6o4/vh7ZejtTqU4LE4rwtwVPBICAPaJBrOuE0QhClw8AB22EF
         5mUA==
X-Gm-Message-State: AFqh2koD2S3DAziGheNANKGdKc7NV5dVFG+3rupfY+/M/8rZ4SxsLmtr
        rQNyd53MBOh+x1Pk+0xj3SE=
X-Google-Smtp-Source: AMrXdXs7gvwBQc0QwQTsi06bOGn3/m/+wQv4kHmB9AFGvp1HZZowDJP4qN/se1I2HhNrMjR6065J9Q==
X-Received: by 2002:a17:903:4281:b0:189:8062:d8e with SMTP id ju1-20020a170903428100b0018980620d8emr14791000plb.7.1671546386139;
        Tue, 20 Dec 2022 06:26:26 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:25 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 3/8] maple_tree: use mt_node_max() instead of direct operations mt_max[]
Date:   Tue, 20 Dec 2022 22:26:01 +0800
Message-Id: <20221220142606.1698836-4-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220142606.1698836-2-vernon2gm@gmail.com>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
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

Use mt_node_max() to get the maximum number of slots for a node,
rather than direct operations mt_max[], makes it better portability.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 34aa93c85d6e..3d45c515ed42 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6723,7 +6723,7 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 
 		if (i < (MAPLE_RANGE64_SLOTS - 1))
 			last = node->pivot[i];
-		else if (!node->slot[i] && max != mt_max[mte_node_type(entry)])
+		else if (!node->slot[i] && max != mt_node_max(entry))
 			break;
 		if (last == 0 && i > 0)
 			break;
@@ -6830,7 +6830,7 @@ void mt_dump(const struct maple_tree *mt)
 	if (!xa_is_node(entry))
 		mt_dump_entry(entry, 0, 0, 0);
 	else if (entry)
-		mt_dump_node(mt, entry, 0, mt_max[mte_node_type(entry)], 0);
+		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0);
 }
 EXPORT_SYMBOL_GPL(mt_dump);
 
-- 
2.34.1

