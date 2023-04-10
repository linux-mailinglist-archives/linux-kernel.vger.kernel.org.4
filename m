Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7506DC4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDJJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDJJRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:17:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582723C23
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:17:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-632384298b3so2033373b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681118225; x=1683710225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqjHZxrb5JBTsIZioYlzXXMMqB1GQY7z0T9aMHt7oLs=;
        b=GEKMw4T1ntCXmJ9aBzvih0LsSJ8WculpHSz/XgPbV9zZSK4KYVqMx/MZn6g/hEKD7c
         mKBs222LxFznsGXbEa4++UT/hceQwkbBG6HEGPP2OJOma1J34ibNvaHHo+jH8FzHHQ07
         EfZSgI4PP0Ng26bOtclVRLF1h95oxCLUnBw1vC+nAztga+Bao0DFJI7qJgjOK61CFIIz
         YL6akOB8e5uyw84vRXWICSKSjrHm8wTtM7nZb8pbq5/sWE7oT1g/m16zgyQeSKEXjYuc
         53C/YVkS+2Dl2PIH2l02FnSRoSxm8GZEvj3owx998fsX7ct+/iUYmgFYKQtxD1z85XcX
         nOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681118225; x=1683710225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqjHZxrb5JBTsIZioYlzXXMMqB1GQY7z0T9aMHt7oLs=;
        b=nAcNVaxBI7TKAXNiqUluGRDa6SurKxmgVEjrmAb8z9+HXxnxiT9nBkaA3vLZ2uumPV
         e03uCa65CC4BULp/VrR0jNfjmNiybl4kdb7pVernt1NBkvokH+UhXZrwk+ltZ9OQlMq+
         oZor7pzWTN8YJHxuEPIg+rQXVlH7py7maLhYRyMPh8jX7wQPftbSpWLw4WAj9lvNn3k5
         RbYf5HmxYKKht0C0dk2l7fBpPnos8D4QO7vJW8B3HD9fY+70zJq/Iqkon3nRsFSzxsHk
         sgW/GBRXYclJ6olOsX3H3OJ5IPgUgpXRbXJ5Vj8Mq0RosXlxMkyJyTHTkC3AlQq+Q2wv
         eofQ==
X-Gm-Message-State: AAQBX9eHh1Rd0oC86SdXKgnSGMm9OiV7e+1WmDYTfVu+q1qnaDTDCMom
        3dyDWdCPTNuHEGXaVw2TcPWDZg==
X-Google-Smtp-Source: AKy350ahpPB/SV7Hpzi23MhQBt0LJvDWhyGroR6CshO6Y7lk3+eElgv9bNPICoTafETiYUBgNrm0sA==
X-Received: by 2002:a62:3086:0:b0:627:f740:51f9 with SMTP id w128-20020a623086000000b00627f74051f9mr10875653pfw.3.1681118224798;
        Mon, 10 Apr 2023 02:17:04 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78152000000b005d61829db4fsm7314970pfn.168.2023.04.10.02.17.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Apr 2023 02:17:04 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Binderman <dcb314@hotmail.com>
Subject: [PATCH] maple_tree: Use correct variable type in sizeof
Date:   Mon, 10 Apr 2023 17:14:31 +0800
Message-Id: <20230410091431.74961-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code is:
	memset(pivs + tmp, 0, sizeof(unsigned long *) * (max_p - tmp));

The type of variable pointed to by pivs is unsigned long, but the type
used in sizeof is a pointer type. Change it to unsigned long.

Suggested-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 88c44f6d6cee..b06fc5f19b31 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3255,7 +3255,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 		if (tmp < max_p)
 			memset(pivs + tmp, 0,
-			       sizeof(unsigned long *) * (max_p - tmp));
+			       sizeof(unsigned long) * (max_p - tmp));
 
 		if (tmp < mt_slots[mt])
 			memset(slots + tmp, 0, sizeof(void *) * (max_s - tmp));
-- 
2.20.1

