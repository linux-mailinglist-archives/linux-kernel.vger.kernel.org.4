Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6B749D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGFNYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGFNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE01FC7;
        Thu,  6 Jul 2023 06:23:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51dff848168so1037594a12.2;
        Thu, 06 Jul 2023 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649838; x=1691241838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc4qD9lCimMDS7+Q62W0sR+F1WbT4ndKWO0bdPK98Q4=;
        b=KRgDtHb9NQWXvl9rwUjjK2ezvvvwgu54gELKHJeo/7F0Hm49R/sMwBHJ3uCk7eZ5Gp
         fRPuKzhfqvXzKlKnsnYj4b5w581neInaOjHVrH9+GYBonlJ7R0bFLnu6XBIJgYRR7yoC
         9o+Shh2XAhSuMXED5erB4cjgQDJ7V/d3EKOxQjDbRmMayZyJM58LHVRqllTL2IH5lBv9
         87+M9I4o7J8dhmNTTjag4+d8J7Rpg4RxbrUO8IsQ9m6QsYY5VPI8p8X7Waor5+HNCzfW
         y3q7qq4EdWlkYC4KpdhTB+G57J1d9XyRFBCB1ZSlBGyXZXTRzyJ9oaPY7x+Y+mtvCLh2
         KZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649838; x=1691241838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc4qD9lCimMDS7+Q62W0sR+F1WbT4ndKWO0bdPK98Q4=;
        b=he8FvstQ9tiT4x/ba4dnKrYfYGANK2NzadOFaFfe/aDw1WlKJtheecSN+OGCZQ7U1c
         IWXINlqe6Y8xcR5s4belJZFsU1FpIHvSGovtxVQaJhAtnET72KE3HuewbkioorcLYU3P
         N3pTICn4VfJ+/wRxS2Enx2kwsZlfoEQX2+t0AzcvoQ5dcBYpK3KqnB1xx9NjNcueEhkB
         eNOZvQ0qDfsZWvgGVQPJc6o4EEJU73Uk4Fh3vZg3Up/Sc31KuBUCZEy1xx0cxMgELC1s
         6sPaqOZy9WORJmbcznVJtP6R1mypz/9megq8vs5Def1VHkdtnXu2wPpuRUFCahLzAX1y
         AxCg==
X-Gm-Message-State: ABy/qLZjnNQ/siMoK0SSHf/A8gJzPinnnTuAaRbk2M5jNsx3w8gPdHPE
        a7+Na9GxyC3O8+6uh0WmNuvOmuYRx3cl2U/M
X-Google-Smtp-Source: APBJJlGCSHaOsqx7aLvcYCVLy0c/hMiwM/tjEdN7KCoMqOu1j0rWZQW17+aXWi01DZUj7CfULo2xcw==
X-Received: by 2002:a17:907:3d5:b0:992:764b:90d3 with SMTP id su21-20020a17090703d500b00992764b90d3mr1261371ejb.70.1688649837787;
        Thu, 06 Jul 2023 06:23:57 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/20] selinux: use consistent type for AV rule specifier
Date:   Thu,  6 Jul 2023 15:23:29 +0200
Message-Id: <20230706132337.15924-14-cgzones@googlemail.com>
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

The specifier for avtab keys is always supplied with a type of u16,
either as a macro to security_compute_sid() or the member specified of
the struct avtab_key.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c    | 2 +-
 security/selinux/ss/avtab.h    | 2 +-
 security/selinux/ss/services.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 9c150fba3fa6..15a5d60fb1a5 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -248,7 +248,7 @@ struct avtab_node *avtab_search_node(struct avtab *h,
 }
 
 struct avtab_node*
-avtab_search_node_next(struct avtab_node *node, int specified)
+avtab_search_node_next(struct avtab_node *node, u16 specified)
 {
 	struct avtab_node *cur;
 
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d6742fd9c560..f265e9da18e2 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -111,7 +111,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key);
 
-struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
+struct avtab_node *avtab_search_node_next(struct avtab_node *node, u16 specified);
 
 #define MAX_AVTAB_HASH_BITS 16
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2e2b17b00298..823b000381a4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1694,7 +1694,7 @@ static void filename_compute_type(struct policydb *policydb,
 static int security_compute_sid(u32 ssid,
 				u32 tsid,
 				u16 orig_tclass,
-				u32 specified,
+				u16 specified,
 				const char *objname,
 				u32 *out_sid,
 				bool kern)
-- 
2.40.1

