Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE49749D65
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGFNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F619A0;
        Thu,  6 Jul 2023 06:23:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e278e344bso994513a12.0;
        Thu, 06 Jul 2023 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649826; x=1691241826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5oF3uYoWt5EFgsUFvcffiR75yMh8VkfJwbZTgy76Mo=;
        b=PT13sW0cBxut5bnUu/G3ezlygIHXia0TGzgjOzSQGtt+nT1SaEv7BRGuIAtl0ZuW87
         pIcsP97UF5QPd4CyAh23J0qtrUA/u9EhuNhmjH+1XWWI8S7+UGMQxNC1ZKu39vvbO4mM
         sOIS8CeLnJzM6/k6EbcdHNVbDRtEgxKbAwzsDEHmnjvAc6raB5DAgBnZs89h+bkXX5or
         q37foOx33BekiZbc5Uq8d9S2j/3XXH5UiEmuNpnQtivxbyHLqcGYWldUqa6GdIjBpKW+
         mnhxd47pSPB033P5lzMi9XZGNvWB6nRXxrPG+D/UBhy63yb7f0tZTkjt6QprXw4NscfI
         32mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649826; x=1691241826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5oF3uYoWt5EFgsUFvcffiR75yMh8VkfJwbZTgy76Mo=;
        b=SRdCIF/eeMX0vdCYJ2a6uVKzK44fbYY13cku7BVlMJ+7H+CQjjp8FSTVKAhqy24yh9
         h4ChD7Tkt0WON8ahL/6N23wnX/Ac2mxjikvieIVfoOpFikREd04OZ+iwcV8QC7KwmPxy
         3zvhLZ9PDt2HWcXNTsdWewB7bHlP5iSjCcwdKxJxDdg282lR/FHigKvWMSxo8dnYDwJ5
         1r4jsfsVoUZtFtrno1lNVwshnZ5Xr/pxIKlQQZ9CmgQWHeQKo9gTGEcEkn+DTjoObZ2w
         NnplkSRUptHYVtNoWgyDHnzk4ey/QmmNg89I5bvJc8LNZVSBCDhIpQk18Mch0847U55m
         pM9A==
X-Gm-Message-State: ABy/qLZHQSDW4xciUmfJK8s4yQUjDWrxjvO0PMBCk/ubp83d9hMu+sba
        HvOTgpcWpu4XSot3VIjQy82jvlx8KnazlVxA
X-Google-Smtp-Source: APBJJlEjqdvMjl5IQn4bKr80V0p4hYsg6s7+0X0q2INdL1/ywnx1RQuZdPedE3qa67qrfRhrXSGVLQ==
X-Received: by 2002:a17:906:943:b0:992:a9ba:b8da with SMTP id j3-20020a170906094300b00992a9bab8damr1326359ejd.70.1688649825646;
        Thu, 06 Jul 2023 06:23:45 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/20] selinux: avoid avtab overflows
Date:   Thu,  6 Jul 2023 15:23:18 +0200
Message-Id: <20230706132337.15924-3-cgzones@googlemail.com>
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

Prevent inserting more than the supported U32_MAX number of entries.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index fbf51986afcf..9c150fba3fa6 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -110,7 +110,7 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h || !h->nslot)
+	if (!h || !h->nslot || h->nel == U32_MAX)
 		return -EINVAL;
 
 	hvalue = avtab_hash(key, h->mask);
@@ -156,7 +156,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h || !h->nslot)
+	if (!h || !h->nslot || h->nel == U32_MAX)
 		return NULL;
 	hvalue = avtab_hash(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
-- 
2.40.1

