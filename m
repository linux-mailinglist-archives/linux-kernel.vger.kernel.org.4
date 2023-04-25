Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988F6EE0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjDYLGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjDYLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:06:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415D812CB5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b7b54642cso4131733b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420748; x=1685012748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wyOOQxSifE+UQ7Biie0VeiE7Xg3ne8+bvtiq6zNGpc=;
        b=jipQmnHiGZqHhFj+pjse8A990ppkL1/uxO9HRdscpit7rhuWxH1VtL8WteZPa//UVl
         d+QYWMUc3Pd0xNIJ5KCnsF9R2zsXUbxhe79MilPyoF5EbgQWgrgD5Yx/Z643QyvsML8e
         Y/jlWVM3tUMLV/IXawWDmC1VAS3dP/bzZfDjJDUx7QS7NhTg5FRO+N5DpeKFva0YH+ux
         jJWMrmPke8pBOQm1JHvFPXk9am07Mtp+Z4X0pBvH9tYeY/Ky6BThaNUVjVEk3qJFoxRR
         s2JD+th6vAVyzSwwRovJ2WxkiFVq+PiDC67vi7LzP0ZtSLmtotp3zsqbzMeCtXArnENH
         cbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420748; x=1685012748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wyOOQxSifE+UQ7Biie0VeiE7Xg3ne8+bvtiq6zNGpc=;
        b=AKOyMqkEcgAWfpd5yja7UolAR7ZUTvwMTC/ix/83lgugveVukpQydg38PHfOf4UqO+
         7R1+zmPaHMoS736BEAaNbieixEI3EjJ9zpwmVVlB7ebo6ceN2mSocNKKb+sgwYwd9ICH
         h2nzaG+Uzo420/bmul4ngVhAS2vAL6s9pyoz+2MqPg4tkYX/I/f4AHLClA+rH7l9u4ph
         HueN2Jasot26bY7dW7SoWmfl+A8s6YXfG2+I2xmpbaXM9OuhMG+L2FyVh2Icr1jeik4W
         jmNyxICwlneZoBzWoaFA5fRtRd7WntG5aX4P94Mt+clbLeGSy0eAYgYyUn7Xl+QI0tKF
         y7Hg==
X-Gm-Message-State: AAQBX9fBeRMZi4wfT+/Ft90HLpg4hh5BGxWvDKa0asSvKH8JOfGucWCQ
        D7ueEmvOiyhNNDVG+pj27D6F+w==
X-Google-Smtp-Source: AKy350al2UoM9RccPs0Hhp+BNacNU4gYAWUgaT33yzGBelCRbw3DAB4I5OBYUs9vNRoOZdmxnTocxQ==
X-Received: by 2002:a05:6a00:1887:b0:624:7c9a:c832 with SMTP id x7-20020a056a00188700b006247c9ac832mr22104593pfh.8.1682420747660;
        Tue, 25 Apr 2023 04:05:47 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:47 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 7/9] maple_tree: Delete redundant code in mas_next_node()
Date:   Tue, 25 Apr 2023 19:05:09 +0800
Message-Id: <20230425110511.11680-8-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When offset == node_end is satisfied, go to the parent node, mas->max
will not change. So there is no need to update min on the move.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 83441ef2e1f57..8bfa837b7b752 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4616,7 +4616,8 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	enum maple_type mt;
 	void __rcu **slots;
 
-	if (mas->max >= max)
+	min = mas->max + 1;
+	if (min > max)
 		goto no_entry;
 
 	level = 0;
@@ -4624,10 +4625,6 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 		if (ma_is_root(node))
 			goto no_entry;
 
-		min = mas->max + 1;
-		if (min > max)
-			goto no_entry;
-
 		if (unlikely(mas_ascend(mas)))
 			return 1;
 
-- 
2.20.1

