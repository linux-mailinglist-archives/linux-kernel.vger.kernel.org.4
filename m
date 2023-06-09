Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF1A729668
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjFIKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241369AbjFIKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:10:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8E4EF6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:59:17 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 10CB23F574
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303166;
        bh=/3eW+11n/4iCvn/s3430tPb8fe2pR8+LzRYCxQYjku8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=oesWZssZIjW57ZWF92PWBoWu4iY32fpTt65uUzVnDdsTEkcZnEBnQ2VhxKOckiRuM
         LzF8EbIgATwmQaU3uCpXPQGZmJq/H8JuPQTuZ3GSqB94+B87CJP5IsuFbHEOAdRRoM
         5HSwMJRfEXCmHvseQ9HMnIRijIM8tQwXm0yxf9mzXytIjH6U52XCFGTN+r1m+fy0BH
         WsgzpYFwSg8ynd4DAk1xoaD9xzloUwc+Vm3Q40QG0dsqAemgJkN0TklMS+ODVfuFOT
         ZyFi6CZGTDIPgp9ero4qtB/+ahSTmroiGRkJDn3kTCfBI28aaF1ypJR2qsPsxXGFOY
         sZaAW0lFcz95A==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b168e97cdfso12476141fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303164; x=1688895164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3eW+11n/4iCvn/s3430tPb8fe2pR8+LzRYCxQYjku8=;
        b=O6fYaunkRcfqxUofCIOObLRbfhOkiziMZF5ROeQUVTf2+O7x7fDcbGSNDsoi04kFGh
         Hzij35dSSGPMgtxuAgZtV7Xa/diwO41IHeV2+S330hi3RF3HYziyCRNJHimoxEXVT/Il
         mLb97eDgklBZqrcDJ498EnvwMH+bfzkxbw/yNzZ2MsSnjS7Srb/KXr2Q/khJXB8Vk9AY
         ccgYFGXqI2VL76b5cgO4ffoiGwokS7e5jdbDUFukL7wNpjPVkIPrukLQcnznsrB+6pCE
         vnRgmT/uS7U2kf/2935hMc9mxhe5rsFsRXFs7qG1HNcPz3lkC68pw13zpExGdhrIiPr1
         9AkA==
X-Gm-Message-State: AC+VfDxfc31Powjb1aA1htl7SVVDJz/wYK/H4/BfrVcLh6f/5XYC4S9M
        pc7/BGk/t6mV9H48MOAtfOd7WTtGudpUbdc4SsEOx2Ub6kVQs4etke09VhvsmV/nsjO3Jg9PZLy
        t5v0rxq+6rztoiyM2mdyuA4A0q1Pgleiaiq5u18WZsg==
X-Received: by 2002:a2e:8659:0:b0:2b2:3a4:4ebe with SMTP id i25-20020a2e8659000000b002b203a44ebemr802393ljj.48.1686303164552;
        Fri, 09 Jun 2023 02:32:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Xp6K9xKO9YEjHS2qWVmuHEJbD+pzRh3X4TI7BNImhUPEhsy5RO+Z9y84aSm4a3Lt8GGRPiw==
X-Received: by 2002:a2e:8659:0:b0:2b2:3a4:4ebe with SMTP id i25-20020a2e8659000000b002b203a44ebemr802382ljj.48.1686303164306;
        Fri, 09 Jun 2023 02:32:44 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/15] ceph: allow idmapped getattr inode op
Date:   Fri,  9 Jun 2023 11:31:16 +0200
Message-Id: <20230609093125.252186-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fe8adb9d67a6..533349fe542f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2979,7 +2979,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

