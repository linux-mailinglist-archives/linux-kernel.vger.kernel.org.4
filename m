Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB12B728410
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbjFHPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjFHPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:46:02 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659EF3C04
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:45:13 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E8E3E3F37E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239037;
        bh=i26tUKoxa8xxbhp04Sqa6+bBNOKneC25U0PHv+Eu/CE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WPv6nl9NogD3ad+NwdOu7YCQhOTLDfx7XN5PLUSPrBfb9/P8imf78rDPiAJsW6T9a
         nc1vHjcBhr1G1Ne2qxsnX/nrS1kagJAzCXFO/PvqkYhJdx58pAJuKZqDPsHquOiLmC
         b4oYubcKK8UEvEU8kGvfdSMk73x/RctZcdEwIX62eYJZ8Mw1gHd9zxPewJo1bxBDpE
         whUyulU6LS/iqGn1w6HF8bFzMacintNIWwh4qkw/fq+GkrKIPGnkeCNwCq6uRroJ2S
         GGkwpgcJsfkaoClfKO40cBEoeYbHrIBllr5fj55IjhZZtoGGM9K9XO6DvL/yI6Eh1T
         tx8an1lFcmFhg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50ddef368e4so706680a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239037; x=1688831037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i26tUKoxa8xxbhp04Sqa6+bBNOKneC25U0PHv+Eu/CE=;
        b=HGFIXqwmX+N6eQHOftkNugT4r8+INMYl2hX26yxTM3tSQU9aQT1EEw4mGx2re0FhAW
         GSSjpDulfrmmrVKkgEpVUz7kAjIT3pu+FcAuM4g2LAvia3fdf4FRJixDHMWg9xL1Bqpf
         GTikIQ1+yGtmZwspJ4EIvqjU0LFrPKBEaeZFhHJaf9Tcb4T9isJmYrov8g1e2XSb+UFq
         sObd+xN+xhhLfbPwDtUKwFh0EoAhyc/DMS5EuxzYPrFv4YvGzK2vxves62xA4omDkMPs
         fVMzoCNuI4e7MvD0A3NOUJ2o9HOJ72GMoyLU7LK/h3dxRGH/cwdHagdLZRO3LkPdNNXe
         DJ6Q==
X-Gm-Message-State: AC+VfDyvUj3quJhnftC7Cpco5Ax2BOMTSfqM5kmQV+XtNAkYSaeQivfF
        tt6jmPe00/y608kUnroqFVTFXdIfK4vp6lgxghUjaRKp22JOTezENsRHGR/kst8gz2xoHsKhxMx
        iWdiMWAmJL2CGsxb+yhlpSxi9azSqh/7ZaxsTzec2iEL2Q1klcg==
X-Received: by 2002:aa7:c602:0:b0:514:75ff:6a86 with SMTP id h2-20020aa7c602000000b0051475ff6a86mr7704526edq.29.1686239037404;
        Thu, 08 Jun 2023 08:43:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bqcG2rpS6htSHbxy+8xHn0si639Le+ztjyzfBKMeLcT3Phik1QuVCS8J6V17RxiDv98M7eQ==
X-Received: by 2002:aa7:c602:0:b0:514:75ff:6a86 with SMTP id h2-20020aa7c602000000b0051475ff6a86mr7704509edq.29.1686239037226;
        Thu, 08 Jun 2023 08:43:57 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:56 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/14] ceph: allow idmapped mounts
Date:   Thu,  8 Jun 2023 17:42:55 +0200
Message-Id: <20230608154256.562906-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
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

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 797a6cb3733c..a72adc21f489 100644
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

