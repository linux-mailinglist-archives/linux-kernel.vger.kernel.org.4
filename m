Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F1749D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGFNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjGFNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21801BC2;
        Thu,  6 Jul 2023 06:23:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e39784a85so357562266b.1;
        Thu, 06 Jul 2023 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649828; x=1691241828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnXJmWO/ufwCaB7TRBuIUbbQK5I3YAKLODq1yY73//8=;
        b=IcCS9i0nCZk49GrJT2BelTw34u61oAJZ+bR8tB8OlF67v5gd4M2YSmnYAsdZF5WplL
         gCMZIdgFH5Tz0XKr+2nL1WD6wv6BTodzyNefdM6WrCNs6E2af4Dl0WcjCCxcSQT5GoyI
         qCm5tCJ4kzC4FhVNatZYaHnDzYTXvz/ldILx39KaBfSxIHr5aBT/HAsG+D6NqcCPASG0
         fgGxIfFEWQfxNl/fwWoxgw2LGrucm4kK+ci3pnbO8Hjlua6LXjLNLVE3TiqiJiefukJ0
         TPncVEYGKjdTVE0gJwUlfhl4wCbDw2xEAUPJmlblWKo7dbg9p7xvZ0YRQCp4lxGyNo8J
         20cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649828; x=1691241828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnXJmWO/ufwCaB7TRBuIUbbQK5I3YAKLODq1yY73//8=;
        b=T9lbrTMo9COjQcUgRcQLkuCa9wgi+VUmmf8nYotfCXpmQ1GUYbXBVT2fZLOAsnrj87
         h1iwXaynghz+jH6gEwsP7jYgdaLbutqo8mGj2uxVyHiPXlcN1KnQQUlQTqrE3P+RFfvl
         WB3lxc46DfHE/i5pzF9ZjxxC3sodzZQl/+cpVnCCLMKHzLSeZ9WSgzEIjjPLzp9MGeZI
         OFWLbu1O7KeQ9E552TmqCKGfvqCcekSrwu3+D+unzHlTRUzU9QCOfSBwv9XIXey12wCi
         yqlqgCbD2tmxDuNnyJ6BD+oNPr910Jxv8TVCwX56TfD7BA37c07khm6qV1YRy0ToYwe7
         MOwA==
X-Gm-Message-State: ABy/qLYd3Bh1t8lXWZxFxxpbFloJXq2h0nbjGqlNd5Alf3yUW0zHR11k
        87UOiPpcFi2DfEt6MxU/rch3XoaOX9p0HV4X
X-Google-Smtp-Source: APBJJlFvtLJ6gGbT1LvRrF/61cYfZHYJbhiqBOjfaXN5eaiEVCDe3cy6kQaS19CJ1VOrS6B0mpr2PQ==
X-Received: by 2002:a17:907:779a:b0:992:1005:928d with SMTP id ky26-20020a170907779a00b009921005928dmr1924201ejc.8.1688649828129;
        Thu, 06 Jul 2023 06:23:48 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/20] selinux: hashtab: use identical iterator type
Date:   Thu,  6 Jul 2023 15:23:20 +0200
Message-Id: <20230706132337.15924-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the identical type u32 for the loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/hashtab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 3fb8f9026e9b..ede3cc1bd204 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -137,7 +137,7 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 		void *args)
 {
 	struct hashtab_node *cur, *tmp, *tail;
-	int i, rc;
+	int rc;
 
 	memset(new, 0, sizeof(*new));
 
@@ -147,7 +147,7 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 
 	new->size = orig->size;
 
-	for (i = 0; i < orig->size; i++) {
+	for (u32 i = 0; i < orig->size; i++) {
 		tail = NULL;
 		for (cur = orig->htable[i]; cur; cur = cur->next) {
 			tmp = kmem_cache_zalloc(hashtab_node_cachep,
@@ -172,7 +172,7 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 	return 0;
 
  error:
-	for (i = 0; i < new->size; i++) {
+	for (u32 i = 0; i < new->size; i++) {
 		for (cur = new->htable[i]; cur; cur = tmp) {
 			tmp = cur->next;
 			destroy(cur->key, cur->datum, args);
-- 
2.40.1

