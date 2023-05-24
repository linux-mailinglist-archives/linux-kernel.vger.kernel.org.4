Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42170FA82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbjEXPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbjEXPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:36:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605D10FE
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:35:20 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A439C41D51
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942462;
        bh=MmBaaHI8VpALzyIfbDDcm88Bn4QWndtQOfQJ2qpYUhg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=t8Y7bPxuj5p0Dqm3r2khDAY4TO10Uhs6uLwzpMXCJLWnQsXob+3l7PP8RUt5Ln8Z8
         IYTy6zV8cUPJRdr/qzNYV4BJvwnhgGHxcB4EvCyVoOcUHYr8OpvUoB3Ov3aF+kz1+c
         yzAccG7xpyLbsqDe0rQZ7K+VjkmdAzkrJDpjoFRaF7Orbms/EnqvI/lO5IYfaANyBr
         uJxUJ4t5P1PQ9ZxuAoLPGTF/neiF5O1KbwPP39Bm95Jr5tRoHO9y8mCiC+j6xeJTzM
         lJUlC78TEvTx7RNtGRE9gtEGwnzbr2iVr2KOaC9T1a5/vU+L6FxRUqj3pIvYWnXpCC
         lLKe9+OedQP4w==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so120340566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942462; x=1687534462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmBaaHI8VpALzyIfbDDcm88Bn4QWndtQOfQJ2qpYUhg=;
        b=SbveEgz02j5KUplHcO5v3ug9yPksadzV0UVgWUHIjygGET/ldWQU6yCKl0Gg/GSjyN
         vG8ljG6KegcsRmqMYlRVjDMZOcqul7k2NpvXcZxeoiOlMuIRwBFcr7s7uJZcK1+G8Iqr
         rUZ42gCGOGRL0TggtkMODAUtw2ZEKpJB/jkyyIaLw7F99OZmYnF+0WFOxE8uHh4GWLKQ
         rVFAgFNMTDWi+EOgzbU2RG6tNzG/pkBn01wYV1gwCbqw+c1twmHryK/Bk2V3jbRPOy5J
         0kv61yw0lXfits4zm0YB74oiTL1uIf/oS7OcsKhjppbSJACvwYhgrUDossGwYhtcYbQ4
         lHsw==
X-Gm-Message-State: AC+VfDxYI2HiGfLXijNkwoQ7sd9yaaZ/avLDyZ3QjkthgSmLEEgghj2K
        pa3zHKXG3F6pqVq1o5f4B1uchpEH09cgq4GiVfQa67KF+cwNQpCoHdYFO8ArkMpYd/FhEOR6sMD
        viuZULbAUUE4mNwwtJAtI3ZGVYp3MvVmfKMaAxVIQAQ==
X-Received: by 2002:a17:907:2d90:b0:96f:a935:8998 with SMTP id gt16-20020a1709072d9000b0096fa9358998mr15705807ejc.39.1684942462503;
        Wed, 24 May 2023 08:34:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44n45ezB0KardR5KNvgVnID6UZeZRJn1zaN+1xQ4m7BE5LFwiKYKe0ULefNGmTnlmYv5+ifQ==
X-Received: by 2002:a17:907:2d90:b0:96f:a935:8998 with SMTP id gt16-20020a1709072d9000b0096fa9358998mr15705780ejc.39.1684942462292;
        Wed, 24 May 2023 08:34:22 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:21 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] ceph: allow idmapped mounts
Date:   Wed, 24 May 2023 17:33:15 +0200
Message-Id: <20230524153316.476973-14-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3fc48b43cab0..4f6e6d57f3f1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1389,7 +1389,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

