Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB75708329
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjERNs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjERNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB1E61
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684417654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y/zMvJoA0jxELE6MkSwxZtfc5VUZ8p2ZHnGCxRaD2+0=;
        b=OYG+X0/HrbM3LRn8iQTJY0jyVy1gWj9zuNG8bVWgD2zTBMrJGWxP4cvp06Dt5bP4rkmxRA
        Ob0OaYibo6tdHQk7cLRqfGxXJcc9Yxp1wPFvrkeStFuDAisWFAXPPTYFEfOviUGdwjVO7h
        fK4Q4lAb8efdiwAYOJpqwtepSaxTC4g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-X9M6VkabOaikvyhZ66Pz6A-1; Thu, 18 May 2023 09:47:33 -0400
X-MC-Unique: X9M6VkabOaikvyhZ66Pz6A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62115d818ecso29908556d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417653; x=1687009653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/zMvJoA0jxELE6MkSwxZtfc5VUZ8p2ZHnGCxRaD2+0=;
        b=cYAqbyvX02/yM7DXIjvNRto1F0c0SKseF0H1FYHl929fzJlYnQv+7J8eHAfVF6HLyX
         d+d6rSHM6aomDae2m8xf6oU/2lVtQ+pBzmqtKK4OZw3yB/4OFSs3RWueKi96lW5BSjLY
         D/q53BRLr22Im5pqSCZ4Behc08SZo13tpc+sb0wEdtkOTyYsKD11A3XDvbtoG/DTZib8
         bvU6QUrihjBSYdOpmiy8D1KTyty/31pVsbRa04oWFp7UHJ/jwlWI8bqJXe0q3YV4C773
         mUBAze0ne6RYcce2wtvU/n9rQwgiIaDMgJhWZCX0qUNXY9Su+J1NUCe3KznFOjzg0UTV
         x/WQ==
X-Gm-Message-State: AC+VfDwfQncidlhbGSjPu/tdbQkfrmRHw8rVxvygxu0wKhfBYKCMlZMH
        WBI86oH6uxh3rIGxobQLYyGFdEhLMJY1P4rycOn4vLKtZcK1UPUforlZ1/8OigCTDN1OaNwDDcb
        pfzYpWyXhgP5HfYNVW1pulpPF
X-Received: by 2002:a05:6214:21e9:b0:5df:47e2:8df5 with SMTP id p9-20020a05621421e900b005df47e28df5mr5299265qvj.31.1684417652950;
        Thu, 18 May 2023 06:47:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NaKD0GJKZBq33VNwx7c38UKOXjG19K19hCC/BkDDOBeGLqN73Np5MduQXiNAKqj5O8kgPww==
X-Received: by 2002:a05:6214:21e9:b0:5df:47e2:8df5 with SMTP id p9-20020a05621421e900b005df47e28df5mr5299219qvj.31.1684417652372;
        Thu, 18 May 2023 06:47:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id dm13-20020ad44e2d000000b006238b37fb05sm521737qvb.119.2023.05.18.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:47:32 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mm/page_owner: set page_owner_* storage-class-specifier to static
Date:   Thu, 18 May 2023 09:47:18 -0400
Message-Id: <20230518134718.926663-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
mm/page_owner.c:739:30: warning: symbol
  'page_owner_stack_operations' was not declared. Should it be static?
mm/page_owner.c:748:5: warning: symbol
  'page_owner_threshold_get' was not declared. Should it be static?
mm/page_owner.c:754:5: warning: symbol
  'page_owner_threshold_set' was not declared. Should it be static?

This variable and functions are only used in their defining file,
so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/page_owner.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28c519fc9372..f37c0b722b51 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -736,7 +736,7 @@ static int page_owner_stack_open(struct inode *inode, struct file *file)
 				sizeof(unsigned long));
 }
 
-const struct file_operations page_owner_stack_operations = {
+static const struct file_operations page_owner_stack_operations = {
 	.open           = page_owner_stack_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
@@ -745,13 +745,13 @@ const struct file_operations page_owner_stack_operations = {
 
 unsigned long page_owner_stack_threshold;
 
-int page_owner_threshold_get(void *data, u64 *val)
+static int page_owner_threshold_get(void *data, u64 *val)
 {
 	*val = page_owner_stack_threshold;
 	return 0;
 }
 
-int page_owner_threshold_set(void *data, u64 val)
+static int page_owner_threshold_set(void *data, u64 val)
 {
 	page_owner_stack_threshold = val;
 	return 0;
-- 
2.27.0

