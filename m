Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13396C020D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCSNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCSN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92337D90
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679232551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ANmcUKdeZ35HVLQbpIeLtv5km0l77GjCF1V3yivxd/c=;
        b=Zh6g9WHeThxALQ2jdZXssqbaAEMk6Gl/8V1fV/IvejRQtN2uBiBupl6NeKUQoDsSVREm0R
        IUiRZXoZxSG+/iXfvwiZ3B/iiClVtKGPYXxpxUsC4PtCAft3Tb63Hkf9Gkz5p9dSFkLEq2
        zNFwlv/JAf/N94NVFAgSBsT1g2RoRmU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-9n_Bd0khPgC-cX3a3cU8yA-1; Sun, 19 Mar 2023 09:29:10 -0400
X-MC-Unique: 9n_Bd0khPgC-cX3a3cU8yA-1
Received: by mail-qv1-f71.google.com with SMTP id z14-20020a0cd78e000000b005adc8684170so4837254qvi.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANmcUKdeZ35HVLQbpIeLtv5km0l77GjCF1V3yivxd/c=;
        b=lY3R0tsPM2oDiMmKKyrfHI4dStTzdkiCmMAE8ax4A9ZNBmBVYrOt7qRqrMUi3vjZyA
         GVMgBspxA2Mo64dRAWnIGzyxb46/WL8imlyvNnb8YhqM7fyP8G4RMez+ax7ftOb9kLUj
         T5F7xSKIeUs82VXvx29Lmkob6zSghVr2h5gUHxGd/Btl2RFPbYfEG2UhPBYPLXr31Ebh
         Mqm2NyXT1yR/luHwxC5x/B2b+dLYe4Xhf+ib9Q8IqhLDc8l36X6pzx/JCld4VV07UpLl
         kIeEWMTNOID7bY4luRKZ9jIkCsiQeBwNIXW9lYs6yh3K33XiaLqcvBOeDyVHT16Kv7Pd
         r3/g==
X-Gm-Message-State: AO0yUKW3zUzelCfOSKKIEwE6A2CR6f47iSYTP4AoMsM1M60T2lOKq86G
        CaMqezLBt6IcCZbXXjS/6IyRlAX/AtSzLr/o33YaOm9ynri38iAK8emCFO1n4Gn0ZykYJOAmvHS
        1yMRtX9PZ++jyCnkKbiho5Clk
X-Received: by 2002:ad4:5b82:0:b0:5c6:92e0:ba3 with SMTP id 2-20020ad45b82000000b005c692e00ba3mr4241347qvp.2.1679232549862;
        Sun, 19 Mar 2023 06:29:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set9gPmwGNLtM0v9nVCNI6C/T0bsibDS00yQE+EVnyhxbao46OynaehouvyMppAXl7cpBQG3Ljw==
X-Received: by 2002:ad4:5b82:0:b0:5c6:92e0:ba3 with SMTP id 2-20020ad45b82000000b005c692e00ba3mr4241321qvp.2.1679232549482;
        Sun, 19 Mar 2023 06:29:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 124-20020a370482000000b0073b929d0371sm5472111qke.4.2023.03.19.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:29:09 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     Liam.Howlett@oracle.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] maple_tree: remove unused maple_tree functions
Date:   Sun, 19 Mar 2023 09:29:03 -0400
Message-Id: <20230319132903.1702426-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
lib/maple_tree.c:331:21: error: unused function
  'mte_set_full' [-Werror,-Wunused-function]
static inline void *mte_set_full(const struct maple_enode *node)
                    ^
lib/maple_tree.c:336:21: error: unused function
  'mte_clear_full' [-Werror,-Wunused-function]
static inline void *mte_clear_full(const struct maple_enode *node)
                    ^
lib/maple_tree.c:341:20: error: unused function
  'mte_has_null' [-Werror,-Wunused-function]
static inline bool mte_has_null(const struct maple_enode *node)
                   ^
These static functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 lib/maple_tree.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 556ca46a9b44..e407f29ef91a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -328,21 +328,6 @@ static inline void *mte_safe_root(const struct maple_enode *node)
 	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
 }
 
-static inline void *mte_set_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
-}
-
-static inline void *mte_clear_full(const struct maple_enode *node)
-{
-	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
-}
-
-static inline bool mte_has_null(const struct maple_enode *node)
-{
-	return (unsigned long)node & MAPLE_ENODE_NULL;
-}
-
 static inline bool ma_is_root(struct maple_node *node)
 {
 	return ((unsigned long)node->parent & MA_ROOT_PARENT);
-- 
2.27.0

