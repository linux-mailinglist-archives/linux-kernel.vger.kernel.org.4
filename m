Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C7726829
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjFGSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjFGSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:08 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF5198B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:11:02 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B15C33F160
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161460;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Nf564hL3HighSIb53MZUbtQlmqRjV+eRENOiOgIVAY7A2mjoGJN93AKLatnzhf5T2
         e0MlSLjS/vzjLVq0qApp3Hx9nw31e1ym3MnX1K9AUx98zi/BA2qInQxDzcWceQMsAX
         wkEp73eDf0cF2fRc8QQMUo50Z+dU41BR2gQxjSsKgzhQNXE/S252bWdce6jsSWhRqu
         qDGzovcY7iOtXu6izU1u+yDXOLzXgX6uMmYMu062MkLwf1sOnc8Hn88nnxFLUD1WWR
         V0DsQCWMZhvCm8TWjWrdJrkthNsDM9Wkq/gWbx16S15yq1JO7RrFsU3Jw2L3xMj6mN
         p8+3AnEW7+yyg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-977c516686aso503056466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161460; x=1688753460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        b=EZKATKUZ5pgFsxemmZzeNznGyRaThgda6Ony28IN2LdnJK5Wgf4ZhD3Uevf7ccInFm
         ODxnLKYa9L3DBE+h9zpEtq8BF7M1tvSmrBjqc/4CbgsFuZpiOGwvEMCOxsnQW94ODOFP
         Hsh38OWXH35hslcamFK0I+DeHco5NO9Zg+luKkVIl3QMV+AVf9eAu+SePtJHlPoKDnug
         Cof3F59X6X0HLC9ESrBAoDn34Vy2BFZIkmuOuUzDc2GkDVjvvB9S3j6WDs4XqmesA5be
         1z2+8+ZOX+1tbFMCjFCDpJZiRUmHJ0WhkC9xNWKj+jITetxCGPx3bLUB6xKszWK+rvuu
         E/Sw==
X-Gm-Message-State: AC+VfDyADx0Yx+0qkF7L0JdQlZ2ZNtkai8IBSTV5cUhYErP3nBfTex/d
        xGy8DJRz0TavGgur1FM3C3yPl1yzlRoNXjstlI9bJHq2+bjVhuq/KkELXkc94Ty60n1o+MXYO5r
        9Pgb3nZBiwI29JqS9twvCDeSKis1S+F1aAECpdIJOoQ==
X-Received: by 2002:a17:907:3e1e:b0:96f:b58e:7e21 with SMTP id hp30-20020a1709073e1e00b0096fb58e7e21mr7447663ejc.52.1686161460430;
        Wed, 07 Jun 2023 11:11:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6E8Zoczui2SA997DiFkrKyZP1txEaL4imA8LjlOgAING0rY1a/TfTWY9iSvaNKd09APPPgiw==
X-Received: by 2002:a17:907:3e1e:b0:96f:b58e:7e21 with SMTP id hp30-20020a1709073e1e00b0096fb58e7e21mr7447637ejc.52.1686161460189;
        Wed, 07 Jun 2023 11:11:00 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:59 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/14] ceph/acl: allow idmapped set_acl inode op
Date:   Wed,  7 Jun 2023 20:09:55 +0200
Message-Id: <20230607180958.645115-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 51ffef848429..d0ca5a0060d8 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -105,7 +105,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
+			ret = posix_acl_update_mode(idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
-- 
2.34.1

