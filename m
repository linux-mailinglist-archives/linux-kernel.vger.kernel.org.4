Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2A067444A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjASVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjASVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A8C9F3AE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674162931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=UpC/KpUDpEMYCS5+V9Fr8jl0r/Xo7A/XnUk+plLkz8t+bk1JRgj6RuI42vM5E0zdTw3ATt
        3Qjw3/vNjdCukcjHR0mf7gnoDgAq6wsXOcgzGK++8Fda0ZNm/FGW6FMbfO/2bLInAAsnHw
        OuEmCshJZvfDpyCD1FWhLhx6ueQX4ZQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-kv9d8IbAOKS5z4NiyJvJDQ-1; Thu, 19 Jan 2023 16:15:30 -0500
X-MC-Unique: kv9d8IbAOKS5z4NiyJvJDQ-1
Received: by mail-qt1-f198.google.com with SMTP id o16-20020ac841d0000000b003b689580725so1525796qtm.22
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMg8gNQDfp59Z8c/Laiz+GjWJb2Q7J01BdsOGckaZ2o=;
        b=G0qBtmJI/ixVVsQmV2sv9dj1Ag3x0VY72XQKvaFgMx8hqXrnqifSSb1b30eQc41LPs
         N2VTj18Gcgq6MkA6NS3kiEMVGYX/KMrBeXPRfxDromPuvS0Ojg2JW2/pXFlDjJX6pFV4
         kQgNmnkYZdM/6OWGKzkT+d3DZ0n2CvHqXkqNO50BcZ/n494Z65Y4ob7uoPtZnIXZJLuO
         0u4nPfHkesGbtLPPKwZDzq4WtRWB9uJwkGL4uhsD41beSZsWK1GeFkhcLTmGUIDPectE
         1D5IkozLgorZg+d8TlTHY69pDS8PIP5IG8l3O+/zTuwHSHMvC2fbLbDNM1/DcJ4E17Zz
         5F4Q==
X-Gm-Message-State: AFqh2krCHjiGjn+r22eoLmhNGhRnVw2R+8DljUPY6HopHc6R9MipjFAv
        rpA9TSJiVOMOMPk39VjzX2WHRSQDzKyEJSonUYoo3RGT91yctP5IrEUH5fSPrBGH4U2UZCmMMkT
        pDMvLFzUsEpJ3F47Jhfpgvl9u
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr14633632qto.1.1674162929638;
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvg7Cqm+RqOllnoGepwIah3wOQ0QFEfc8gtV8SZaGb8UPTC0/BLnk7Faj89h/7LOb3Hkn2f0w==
X-Received: by 2002:ac8:45ce:0:b0:3b6:2e75:c9bd with SMTP id e14-20020ac845ce000000b003b62e75c9bdmr14633616qto.1.1674162929441;
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b0039cc944ebdasm19443699qtp.54.2023.01.19.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:15:29 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 16:14:55 -0500
Message-Id: <20230119211455.498968-2-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119211455.498968-1-echanude@redhat.com>
References: <20230119211455.498968-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Larsson <alexl@redhat.com>

Use call_rcu to defer releasing the umount'ed or detached filesystem
when calling namepsace_unlock().

Calling synchronize_rcu_expedited() has a significant cost on RT kernel
that default to rcupdate.rcu_normal_after_boot=1.

For example, on a 6.2-rt1 kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
           0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )

With this change applied:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )

Waiting for the grace period before completing the syscall does not seem
mandatory. The struct mount umount'ed are queued up for release in a
separate list and no longer accessible to following syscalls.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 fs/namespace.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..11d219a6e83c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -44,6 +44,11 @@ static unsigned int m_hash_shift __read_mostly;
 static unsigned int mp_hash_mask __read_mostly;
 static unsigned int mp_hash_shift __read_mostly;
 
+struct mount_delayed_release {
+	struct rcu_head rcu;
+	struct hlist_head release_list;
+};
+
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
@@ -1582,11 +1587,31 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void namespace_unlock(void)
+static void free_mounts(struct hlist_head *mount_list)
 {
-	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
+
+	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
+}
+
+static void delayed_mount_release(struct rcu_head *head)
+{
+	struct mount_delayed_release *drelease =
+		container_of(head, struct mount_delayed_release, rcu);
+
+	free_mounts(&drelease->release_list);
+	kfree(drelease);
+}
+
+static void namespace_unlock(void)
+{
+	struct hlist_head head;
+	struct mount_delayed_release *drelease;
+
 	LIST_HEAD(list);
 
 	hlist_move_list(&unmounted, &head);
@@ -1599,12 +1624,15 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
-
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+	drelease = kmalloc(sizeof(*drelease), GFP_KERNEL);
+	if (unlikely(!drelease)) {
+		synchronize_rcu_expedited();
+		free_mounts(&head);
+		return;
 	}
+
+	hlist_move_list(&head, &drelease->release_list);
+	call_rcu(&drelease->rcu, delayed_mount_release);
 }
 
 static inline void namespace_lock(void)
-- 
2.39.0

