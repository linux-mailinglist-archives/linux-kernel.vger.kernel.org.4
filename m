Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC22570FA60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjEXPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjEXPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A203E7B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:45 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E29F53F196
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942444;
        bh=VOsvDeo72Li4A+MGz8y/FXCiDvmbWTjb5uUMq09Z+GE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gWZurhxT3fpyDMIpY77JZvx4PwqkyY55Hc00DdcdOYztydiLIGYoifVtCs4mY8MIa
         ZcsHOyJkkF4TImSP8JTVQ3o6LuOPpT0l/y/hlaf2s6QXPAF8bYWqmKwHHGkR9hBBrL
         JR6JDvFZ0j4k16Kq91Cdd1QRvMd8AkU+++VHZYxiz7PphVXcvGAeUk6s5gz7ZKO95E
         MZjGao1DtzPoAPe/70t/3FmgTniZj6iDRtIIa5gkSpOrdewvRvZFvhEcR0sGwe6GXC
         OvbqVUp0s9LIjXIjkFb1hlcl+6PnYJ3DK/lKKIpsqy8ze78clGszML8MEKIdxJeMn3
         TG10RXmVv5ceQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50bf847b267so1341538a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942444; x=1687534444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOsvDeo72Li4A+MGz8y/FXCiDvmbWTjb5uUMq09Z+GE=;
        b=YPvSggpxBidgzZplnj7Edj9esrO7Qg4pctSpQ4aU5FfzcMEaKQAnDGXrP/Bq6LlfeQ
         BkYkBAXM2bV2jRymuVlXV0xOPzdaEv/knGGPPiv4TFHkkvnjTr0epcvvmekml/20Eyoe
         eQSkBIgIFPqjlRQW2XY0vEGU8iQQ+JYZSnJ3aCFd0GBQDp8oq9gcAZHRBoIJ1te3sgTh
         MAOLpWZjxicRS11dM7ShSDmMnk+Sz9gjL66aoMucDl/yNXRy4ITRSwlwfIQKHRniAfbA
         nwGfbVZqLZpIdCGRz0vNACSoMFdy7V2elGIPwt4Pg4jhBbQ2tu4ngNWLQLGToFCBSMy/
         nDbw==
X-Gm-Message-State: AC+VfDwaEvWMgMNOZ+bWkP6b/UY3J79QqBbPZSBuxUuPbPWlVhmxzvTb
        lqBIuCykcDsCyVNX7jtiHR95wDxoqxE9zQnzYisB0Ss/0/Fdb1GSiiHkmNXjX+hSNEVU64rqaXu
        xeiB/ZXtfiVcfLqCVF2DCx9MOT1drJVTlk9wGqgZTXw==
X-Received: by 2002:a17:906:5044:b0:96a:63d4:24c5 with SMTP id e4-20020a170906504400b0096a63d424c5mr16834948ejk.77.1684942444420;
        Wed, 24 May 2023 08:34:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gBpqHitu+lLhIckipr6Iw+ZMNPeoZej+/zA1KHtSCkxGa9OwcqI2J/tv0ifrYtmEPsQMuyg==
X-Received: by 2002:a17:906:5044:b0:96a:63d4:24c5 with SMTP id e4-20020a170906504400b0096a63d424c5mr16834933ejk.77.1684942444258;
        Wed, 24 May 2023 08:34:04 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:03 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] ceph: allow idmapped symlink inode op
Date:   Wed, 24 May 2023 17:33:07 +0200
Message-Id: <20230524153316.476973-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_symlink() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8d3fedb3629b..3996572060da 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -956,6 +956,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = idmap;
 	if (as_ctx.pagelist) {
 		req->r_pagelist = as_ctx.pagelist;
 		as_ctx.pagelist = NULL;
-- 
2.34.1

