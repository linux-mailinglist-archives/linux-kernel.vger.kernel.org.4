Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0AE652283
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiLTO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiLTO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D0DDF85
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so164850pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn2usd8RhSGSmZWb5B1NWCCF5E+CujnFtBp0hU4Vhaw=;
        b=QAeeyh1BDYIV8cysQl2toWaUGz8d3JI5Fx2R7je5aKyPI8FrS9vaiR/WWyQUfMZGHO
         toNL8WesHyJHxS9B5e+U2mFpDVG4didblkCkoBIA+RIAw+EvyVLAc2gNxEAuws6MyNNZ
         Rek1JwcQmqwB9CveuiscUcQc/7dmK7A7FCE0DTwv1JUICXSZVjsHtRQGFT5L65kpQQTX
         h56Ljtc90jh1ZPUWtZzsumI07vT0462LU6Sh0iOM4l/zqChr0l02cdrH3m5PLzfujitC
         HcAyxPjw7KYBQpGRkyoOJxaCThVEAbZIGLvu21lT3ORsUjc4tAJnQnHRJCw2KKa9V03d
         ag2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn2usd8RhSGSmZWb5B1NWCCF5E+CujnFtBp0hU4Vhaw=;
        b=P+skyVUxW16btpj6EL2ml3bouLpxQKzWddGWotORs0ye0ljOsgfk3CUTwuXKYuOF8F
         YPC9T+MZ8WCoVzxHCh4D1Un0P+IQgyoSFoU3w3cGgCeOXtqSCqEA/Orooqpzg18vyrmH
         lrj5cn1LTx+DWYVShD7Kpna6pS0fSpTDSjlnv0kIKnNw3weFTAzjDle2EgQDuIFRPVo8
         qjd1c1O6h9Ndfizylww2W1y/Kq/3lO49a/rV8AFopTZU0mWmC1OKz+gqPv0v+IjaLa5M
         eo8q7SJvuXHkF1+dR0hs6FGmuZ+W2cURS4A7eRYbLFHcJYX7hF0C0wXUJJRCWXq7wOEK
         HFww==
X-Gm-Message-State: ANoB5pl1sR3qV2f8dgVvZELLh/e/6avL91kqbfQYMIKBbTqMBelOeqR2
        6a7kcX2fNuTq39Btv1CodRY=
X-Google-Smtp-Source: AA0mqf6XV9AK7/ROL6sxQsVqW/vSv3j9dGERWBjFCKqTC/Hkp51i5+bxCYvWKi5cl933ffR6sQsiiw==
X-Received: by 2002:a17:903:26d3:b0:18d:9214:1ae5 with SMTP id jg19-20020a17090326d300b0018d92141ae5mr43056033plb.23.1671546393514;
        Tue, 20 Dec 2022 06:26:33 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:33 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 5/8] maple_tree: remove the redundant code
Date:   Tue, 20 Dec 2022 22:26:03 +0800
Message-Id: <20221220142606.1698836-6-vernon2gm@gmail.com>
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

The macros CONFIG_DEBUG_MAPLE_TREE_VERBOSE no one uses, functions
mas_dup_tree() and mas_dup_store() are not implemented, just
function declaration, so drop it.

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

