Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0174E798
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGKG7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:59:11 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872D1A8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:59:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Wtx0Pj4zBJJhp
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:59:05 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689058744; x=1691650745; bh=BBjOtnxHpYtfKCDDqbXWnN085Od
        kLpLKgYToQFgh/Vo=; b=LjF4tE/ugu45A4gqlYRZ8FW2PVrT0eKQHBSLZSWOVnL
        r6ZH7le8VGBJ0OE6+//8Wt4Q+FDr4YsXBdJWCFdwdHvXIWaFI2GqvDWCvqW8fedx
        vmcZK9MzqePLeh3mfHMbWbMifJHRdY2k/1ISytqlg1TcccFHGKNQWyzXddkuOafc
        uZbVZ9h0kJTEXAfhVQiyltAwY2QfI0lKJeH6Jp9iMhaCyzSecZmEkfQCnFK1hWMs
        3hsFhxSobZbQhy5prTOP+se78wP62XOdxZB8KeqFw+aWdBYj4QY5GM5kSh/nv1tu
        ARhKGucfBW+U9TPgBi0+nHRLegHyRPUHY28q6XAiY/Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tne0YiKvCf7y for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 14:59:04 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Wtw5BsQzBHXkY;
        Tue, 11 Jul 2023 14:59:04 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 14:59:04 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Move assignment outside if condition
In-Reply-To: <20230711065751.80206-1-xujianghui@cdjrlc.com>
References: <20230711065751.80206-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <5e8eabb592aaf355e6a29aea1f71a551@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nouveau_usif.c | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_usif.c 
b/drivers/gpu/drm/nouveau/nouveau_usif.c
index 002d1479ba89..d0b555630a6f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_usif.c
+++ b/drivers/gpu/drm/nouveau/nouveau_usif.c
@@ -57,7 +57,8 @@ usif_object_new(struct drm_file *f, void *data, u32 
size, void *argv, u32 argc,
      struct usif_object *object;
      int ret = -ENOSYS;

-    if ((ret = nvif_unpack(ret, &data, &size, args->v0, 0, 0, true)))
+    ret = nvif_unpack(ret, &data, &size, args->v0, 0, 0, true);
+    if (ret)
          return ret;

      switch (args->v0.oclass) {
@@ -70,7 +71,8 @@ usif_object_new(struct drm_file *f, void *data, u32 
size, void *argv, u32 argc,
              struct nv_device_v0 v0;
          } *args = data;

-        if ((ret = nvif_unpack(ret, &data, &size, args->v0, 0, 0, 
false)))
+        ret = nvif_unpack(ret, &data, &size, args->v0, 0, 0, false);
+        if (ret)
              return ret;

          args->v0.priv = false;
@@ -82,7 +84,8 @@ usif_object_new(struct drm_file *f, void *data, u32 
size, void *argv, u32 argc,
          break;
      }

-    if (!(object = kmalloc(sizeof(*object), GFP_KERNEL)))
+    object = kmalloc(sizeof(*object), GFP_KERNEL);
+    if (!object)
          return -ENOMEM;
      list_add(&object->head, &cli->objects);

@@ -121,7 +124,8 @@ usif_ioctl(struct drm_file *filp, void __user *user, 
u32 argc)
      if (ret = -EFAULT, copy_from_user(argv, user, size))
          goto done;

-    if (!(ret = nvif_unpack(-ENOSYS, &data, &size, argv->v0, 0, 0, 
true))) {
+    ret = nvif_unpack(-ENOSYS, &data, &size, argv->v0, 0, 0, true);
+    if (!ret) {
          /* block access to objects not created via this interface */
          owner = argv->v0.owner;
          if (argv->v0.object == 0ULL &&
