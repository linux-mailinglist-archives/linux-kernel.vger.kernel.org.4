Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580EC72B1C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFKMIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 08:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD22E62
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686485251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z58VfawEkG4AD4FrE9MS4o9GTQRETweAw7Z1P68bgdU=;
        b=PIlc46waZZ9bDMD+5QuvQiFwIkX15xKC1CR+IPt8U0gcy2crQBj13nIXwWlzLTm1wH99wE
        K9azLGQR6C2NYUCYida0l/bVC49k+YPeCXxVECUb/xhHoLNGE7PPAGvcMUTpu3qAbmrg4k
        mhwG9T3k3I/vxdNF7cmjn/GZ4ZRkzGU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-b8trKt-sOHyzgF95caVdHw-1; Sun, 11 Jun 2023 08:07:30 -0400
X-MC-Unique: b8trKt-sOHyzgF95caVdHw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75f7a6e92a4so55300985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 05:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686485250; x=1689077250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z58VfawEkG4AD4FrE9MS4o9GTQRETweAw7Z1P68bgdU=;
        b=BGmnXuIbWdo6JqpummUX5gm9euxVrIu777cuNhQVJfqC4QYYpDxlw71nukm+8AfxiK
         +paGoVjpe2YDQfx47DRwpMryvq+FsAzyW29vstmaZypCghmjly3IYradM5fRR+m2zfi1
         ejxgZRzKu1EXGTIzYomTk8mQs36RVKauwfLPaWANu4lCnUrBtdl+yGgzWoBv3cZQrmPj
         PaOhOT61gAmhVdRwW3PrpjETkbIx67n1T68B7HQd1lzpRO75esaz54D/1SrH97pf5NHc
         ZbjBCMPSgS9nrq4GXEBkgKbUJJKU75LMJughNAQ4NlJzjJDh3lWJkcj68E6lGbXj0CnW
         ZTIg==
X-Gm-Message-State: AC+VfDz5pW/bwcwbK4BK5KZjJMzhdcBh8levtgZTH5zIvgML0XwyNjaW
        +URVBj9cz8ROyIdSMTQsiLk/p3Fxr6OCMRD2jpniUwXhrb85QbpaLAEbRuKFumqgYmGMkcw5XxW
        UqNb7u6GvEid+i0UmHndOmSaO
X-Received: by 2002:a05:620a:8c16:b0:760:6d74:a95c with SMTP id qz22-20020a05620a8c1600b007606d74a95cmr2209843qkn.7.1686485250032;
        Sun, 11 Jun 2023 05:07:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bTsDwNHB0IlcStpaPGm7hD7NA2xjS6QujfNDUCS2WY21LjWZpujWvGqCwrwojYV04SAzHkQ==
X-Received: by 2002:a05:620a:8c16:b0:760:6d74:a95c with SMTP id qz22-20020a05620a8c1600b007606d74a95cmr2209829qkn.7.1686485249829;
        Sun, 11 Jun 2023 05:07:29 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y1-20020a37e301000000b00759495bb52fsm2208898qki.39.2023.06.11.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:07:29 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sysctl: set variable sysctl_mount_point storage-class-specifier to static
Date:   Sun, 11 Jun 2023 08:07:25 -0400
Message-Id: <20230611120725.183182-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
fs/proc/proc_sysctl.c:32:18: warning: symbol
  'sysctl_mount_point' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 2715e6114933..67872cbc0517 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,7 +29,7 @@ static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
 /* Support for permanently empty directories */
-struct ctl_table sysctl_mount_point[] = {
+static struct ctl_table sysctl_mount_point[] = {
 	{.flags = SYSCTL_PERM_EMPTY_DIR }
 };
 
-- 
2.27.0

