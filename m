Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557FB665A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAKLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjAKLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9638A1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63F461BB9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7DCC433EF;
        Wed, 11 Jan 2023 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436657;
        bh=AkE/lv0ihMfPjfXKWuy9LtK/5fpHAGwJNbIk/sxtpZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyH0PdKnpOfo7TCRFHEs08ZqcotuUYyK+WIvRGB/0HjLpnOWomvZh+6GQNsKr7u2p
         Eq60cri1Ed3vS4oFsO9Bw2x2p77bU0GWyc4g8LtCT1Q8SMjRJMHpSXP5xoinl8NS+w
         C+UkiM2qPh69fPryXwecghAsegOu7iIWhWuBzRA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH v2 16/16] kobject: kset_uevent_ops: make uevent() callback take a const *
Date:   Wed, 11 Jan 2023 12:30:18 +0100
Message-Id: <20230111113018.459199-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3307; i=gregkh@linuxfoundation.org; h=from:subject; bh=AkE/lv0ihMfPjfXKWuy9LtK/5fpHAGwJNbIk/sxtpZA=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p6qlZSdpHHrmcBJ6auiRXqc+nP3tQvs417G8PzQwq+C fzXPd8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEit4xLJhktThKvivX6kZh3JRCx2 gDdQPFZQxz+PzNY5+ezc2TFX3zzFfpjHBUSHkpAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uevent() callback in struct kset_uevent_ops does not modify the
kobject passed into it, so make the pointer const to enforce this
restriction.  When doing so, fix up all existing uevent() callbacks to
have the correct signature to preserve the build.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christine Caulfield <ccaulfie@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c     | 4 ++--
 fs/dlm/lockspace.c      | 4 ++--
 fs/gfs2/sys.c           | 6 +++---
 include/linux/kobject.h | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 72ec54a8a4e1..b0cee0f30d8d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2387,9 +2387,9 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 	return NULL;
 }
 
-static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
+static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
-	struct device *dev = kobj_to_dev(kobj);
+	const struct device *dev = kobj_to_dev(kobj);
 	int retval = 0;
 
 	/* add device node properties if present */
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index d0b4e2181a5f..9b6cfc4c30e3 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -215,9 +215,9 @@ static int do_uevent(struct dlm_ls *ls, int in)
 	return ls->ls_uevent_result;
 }
 
-static int dlm_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
+static int dlm_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
-	struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
+	const struct dlm_ls *ls = container_of(kobj, struct dlm_ls, ls_kobj);
 
 	add_uevent_var(env, "LOCKSPACE=%s", ls->ls_name);
 	return 0;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index d87ea98cf535..d8dfabb0bc12 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -767,10 +767,10 @@ void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
 	wait_for_completion(&sdp->sd_kobj_unregister);
 }
 
-static int gfs2_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
+static int gfs2_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
-	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
-	struct super_block *s = sdp->sd_vfs;
+	const struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
+	const struct super_block *s = sdp->sd_vfs;
 
 	add_uevent_var(env, "LOCKTABLE=%s", sdp->sd_table_name);
 	add_uevent_var(env, "LOCKPROTO=%s", sdp->sd_proto_name);
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 58a5b75612e3..bdab370a24f4 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -137,7 +137,7 @@ struct kobj_uevent_env {
 struct kset_uevent_ops {
 	int (* const filter)(const struct kobject *kobj);
 	const char *(* const name)(const struct kobject *kobj);
-	int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
+	int (* const uevent)(const struct kobject *kobj, struct kobj_uevent_env *env);
 };
 
 struct kobj_attribute {
-- 
2.39.0

