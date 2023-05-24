Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C71870FA81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjEXPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbjEXPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:36:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FA10F8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:35:17 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A73E41D5E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942461;
        bh=iDvGWD+26D2Z+S1TMox8zoqslkMySxbj4ujfm+xfm2I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=O2RnG/NqRTB/VKC6XnLngYd8oftmjIqd/4j10bZx2aHZ2ehKpGHKYnvSxUjElydvW
         iF8rf4b0z6Jl4ZBbZGR23FZpU95HW4+EBWipmQ+aEUTQQLoSAQrRx3ZrN1bl3xDaIu
         vuepfkjDUmf5Xlssly9pT+WwTVtbc1c0qrav3HxVTDx4Mak3zlcE3Osk/EYQpVxLnR
         Gq6g1rk4nLk9PYav5AKOQNUhaBVS4l/tmdtLX+x5/zIcOyHa8G18ZnNT0Hk2GwCl55
         bL4e2S4Mwp5gJgPSgOYHIX8SvQL5kW9JueZsdlQnXFOLAASKn/7snk4u/i6o9Gs18+
         dyHUn54TSRS0A==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51392d645d5so1411476a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942457; x=1687534457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDvGWD+26D2Z+S1TMox8zoqslkMySxbj4ujfm+xfm2I=;
        b=EzBccQ7EW7rh7e2rud+FzdR2W6eRSR/Jh1l4/9/vusc0sYcISGHV0Qv+uBpF3aKnlE
         gSKKpLzWQLzSxxVRtDPEIMVl5sTa3Q54xGMyHN+Ym0h67Arsm2yWlDtfRCgWpzqrl/Kx
         T/2pAKi/lNFpXSRxbpiAUQ/XOs2k8fiMBBIscckfXIJAfP7pfbw+KM90lsZmNHVjzBk2
         fXy3qW2kHAISxUil9HoTYZibZMNYEGXUMXdbWGsqb5B9KzxVTRJe6S525uyAgvV9IQ93
         v3E2ZjZy/9EDceiTFA6Hf0uPm+HiaPl4os+S8pzrvTbaQJM7JlZWUoNKZv0huSW3w7OI
         jMUg==
X-Gm-Message-State: AC+VfDzMkLMq1hKGSVYpuktGVXVfolaHpR0bhNxeUJNlz5iw6whQ7V/W
        IuS96fpN7hDsAvqxW05tnq7pco7cwHIDvxp0jjSKntiL/XHeSYSizawVuFriO5PkzSlIWx30iKp
        JSN56iw1DYUbjUQsgqXeSGNOh+bIYdf/B/RAzR7Vbjg==
X-Received: by 2002:a17:906:dac1:b0:966:471c:2565 with SMTP id xi1-20020a170906dac100b00966471c2565mr15855325ejb.48.1684942457338;
        Wed, 24 May 2023 08:34:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DVPnmHEEXyH6/S3ZdnkASC78MliSVSX6eChUtaO68Ytw9hQ0oJ2rkgjtW+JQ8P1CYQhOU4w==
X-Received: by 2002:a17:906:dac1:b0:966:471c:2565 with SMTP id xi1-20020a170906dac100b00966471c2565mr15855304ejb.48.1684942457080;
        Wed, 24 May 2023 08:34:17 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:16 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] ceph/acl: allow idmapped set_acl inode op
Date:   Wed, 24 May 2023 17:33:13 +0200
Message-Id: <20230524153316.476973-12-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 6945a938d396..4291c890e324 100644
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

