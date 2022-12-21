Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB6652CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiLUGBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiLUGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B00A45B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 82so9795554pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98gM+nMF4eQUYfWo5A+IUJS7ZGlkpZboph9F4DdRYdI=;
        b=OW8qsMkzYqxctImV/NWyLmCYdTie44KkUOfhYEVGtWY9Bt83TvVAexzh3PGdLkNTM2
         RbB6iialWb4wRKiMjrdIO9gj24hmgnl4mGBOHqmaAaOlwGKuZPbfwXXbnnOraJ8qW2LB
         t3ka5CzZTM3bQaHszRPYyvh1qLUw7nILA2NPdXOrGsjfMQKq3wF9Sj3uhOz5ggO5agaZ
         xNCAj8bamRALkJR30UK4dMVAgMP5+RUs8crcTJF2Tzk+0osr4eBl0ExqkyXJ4YttCla3
         mVnIJLkdd3U62oErLjgE6LB+wQoKyJ21I0pESeVPw+mffCztX2w+xeZMnI++SXwN7N2e
         P3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98gM+nMF4eQUYfWo5A+IUJS7ZGlkpZboph9F4DdRYdI=;
        b=s2EFmG6tZ9zevfYp0W1gIHeWrNxXEdhaIYWL5oqcmkvOPl9KgdgXl6wBIC7dJ3OkRs
         ZlS2daZTmzcyUzO53quKdpyvCeWu1Fy6ij0z8pbKYN6D298GGXJd4v9cwyOvCqLufrLA
         zAtIbi1sW80jeL6AlvBPaDWiFqgeQs2LEXXerfEMlKzr00i/HZ2zCwKEUChCCTpK2w/o
         /e44WBc0lHYpDu1Y7G3UfvU27cg1aMSfaBUAv0zWa7A9mOMR0BjoVS37zy58OdU/12N/
         yvoH+6vns5BmlaUx5Gc4VrfuB7ykFMrJWOj0k2iM5FegAPcVmrdGjRO6C2V04n1CCAX4
         BxaA==
X-Gm-Message-State: AFqh2kodlhxAoGs6kDS3kOiB7bHf72wYjvsGePUAspBkoOnneRiXJQNG
        XM0Lc+DaaYAq00haYvRZR14=
X-Google-Smtp-Source: AMrXdXsbG1NWc56PQsRKjtPo5U90MkahU89tGi2vxdMo3dBH3SqM46lw3YlBqRViLrXj4Jp8difS4g==
X-Received: by 2002:a62:8408:0:b0:575:d06d:1bfa with SMTP id k8-20020a628408000000b00575d06d1bfamr1328487pfd.2.1671602491994;
        Tue, 20 Dec 2022 22:01:31 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:31 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 3/7] maple_tree: use mt_node_max() instead of direct operations mt_max[]
Date:   Wed, 21 Dec 2022 14:00:54 +0800
Message-Id: <20221221060058.609003-4-vernon2gm@gmail.com>
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

Use mt_node_max() to get the maximum number of slots for a node,
rather than direct operations mt_max[], makes it better portability.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

