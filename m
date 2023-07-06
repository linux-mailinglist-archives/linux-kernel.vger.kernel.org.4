Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B933749D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGFNYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGFNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DAA1BF9;
        Thu,  6 Jul 2023 06:23:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b708e49059so5879961fa.3;
        Thu, 06 Jul 2023 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649836; x=1691241836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TDtptIkENs/tayg9WHiP7fNFieO7oHOt3lCGHjPhK8=;
        b=ZAoK9O9BsmPWDXZjxjcM8oa0QntCJDAE7guqGhxXlzF+kt3m+4JohijYM3ygC12aGe
         d9mBu5JTrg/vscq5p463NvtcB0ft8ZikB4ziomPVVNbk801szMlGrWwLtuZ6u+McO5JP
         kE8kWqvzVJALFxdkZ99/9VkntGl45qvuhIJqPzfpfWIhpt1fefccAqFJEiwj3hw82fsi
         H1fZHOWCRvrpXjdHtK9vBY6PLxLiLVWeSb9ggwGCjMW9EyJI0BjtZ6YgESVKHNkoHNgb
         ijR1dSBMJGnE6YXGR5xdCrRJxTMzH+lOvRImwMTxr4Gdj681Hszgctt4jbrwzivx1jvh
         3UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649836; x=1691241836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TDtptIkENs/tayg9WHiP7fNFieO7oHOt3lCGHjPhK8=;
        b=GPShHcwlPzhG3cDL4BPUAoj6MI0m95NBgEeE7R00+fsDxUbTmJyjUpTptQyyOUPem7
         /++YAOE0neJ3h6Q05B0OPZBPndegF6+XTJkkq/iCm5NFxuxTI0HB52LpHlBDul17pDjq
         /uk1Pwib/1O65DluUX6UgFoYZlHOACF42msmCiL9P4ngrMEinRImCioY7mIuMaGRImvw
         lNv5t8+TJ8lOMFV/b6RCcHnrbhgHB5WGQA6DWfxxiP9Z0i8EuYUfpBFPJjuMiAWaghyX
         Aw0O54/n6nTURP2a9n8fEazgYa5ZrUjeJU2jqnAKnMpWxy10Z7o6WwPnSHOQN+PcvETU
         ZixA==
X-Gm-Message-State: ABy/qLZGF5p6FuIiQRN8ZEvmvCj5QKETo5WCLiFS+WuIO0B9ICWn1HfE
        vbXICZI0R4EGW1Co+yO5hAtL9g3Sk2eBlFyI
X-Google-Smtp-Source: APBJJlEjdL7dav+DPrOIUskIr01F+mwYAC2kNtNoiqDbJWIOqSB+MCA1xSDIvBElC5hGNMuY1ruE4Q==
X-Received: by 2002:a2e:7a16:0:b0:2b5:7a87:a85a with SMTP id v22-20020a2e7a16000000b002b57a87a85amr1351695ljc.13.1688649835875;
        Thu, 06 Jul 2023 06:23:55 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/20] selinux: selinuxfs: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:28 +0200
Message-Id: <20230706132337.15924-13-cgzones@googlemail.com>
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

Use umode_t as parameter type for sel_make_inode(), which assigns the
value to the member i_mode of struct inode.

Use identical type for loop iterator.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 16036633ddd3..c3ac0468f698 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -97,10 +97,9 @@ static int selinux_fs_info_create(struct super_block *sb)
 static void selinux_fs_info_free(struct super_block *sb)
 {
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
 
 	if (fsi) {
-		for (i = 0; i < fsi->bool_num; i++)
+		for (unsigned int i = 0; i < fsi->bool_num; i++)
 			kfree(fsi->bool_pending_names[i]);
 		kfree(fsi->bool_pending_names);
 		kfree(fsi->bool_pending_values);
@@ -1191,7 +1190,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static struct inode *sel_make_inode(struct super_block *sb, int mode)
+static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *ret = new_inode(sb);
 
-- 
2.40.1

