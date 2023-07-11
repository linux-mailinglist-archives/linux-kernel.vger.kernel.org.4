Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3C74E5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGKEiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGKEhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:37:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD46E57
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:36:45 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39ca120c103so3731029b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 21:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689050204; x=1691642204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwg2LF4AANWZXAWwCxGinMEpTuqfx93iO2WWEDfZD58=;
        b=FQYPBCJf+VlZ5ovBna1yPEjwhpPcuj+TyxHZ6gvlXmFomTF22kPeeT/g0ze4HZ9wHo
         zqm6W0WC7dErw/M8WMC2QBLnzPkIlnJau1pUamJyDbHRCUYMta2PJDPLuefEj30lNmqQ
         bFMNCmQHoyfEyV999O2zvsnHzuAHebR7iDySxbjdRsstFgtEIbbr2FjSj2EhgG5Yq/8J
         6eqYzrVylv37i/NMhZFrvNEhx58ljDYuU6v/ZPCHAnyBWoKzf5/yGmtW+v1VyCZBFWI1
         A3hQnXSUZR+VmVS5C6CeVBnQ+TKQ1SuUcDn8NMKn75QP4P+7Qq5cV+EdA1Vom2Os1u3g
         Z+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050204; x=1691642204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwg2LF4AANWZXAWwCxGinMEpTuqfx93iO2WWEDfZD58=;
        b=aROgf9+gZxSNpMqN56qw19y+LqOGnH4+ZofyCetLnhsahihZRDPjj7YIxL7zRA//X/
         XqAVArcU89DVzchfkG0Yo5r2AutmQ4yB+UHlAvb7lf7T7mOSOsqUcBunRoQryWJrEBkq
         L60Rn0DhfwTbri6QerGgAAr4OrtgW81pK3LwGLkFNe6oXlmVzkhcJ9AccLLtrjsN2USd
         k95TsjWjbLmV4NdHIu6oVaSZYQe42cZDl6mLDx/z0Tywz56qivtIXbOtfDHCKOFI3SmT
         8UKXFxMK4QfYwlcAK7rPHyJD/0uhMhWficgHXXrGtJabEvqtXvrcu52E7kAxjmFdKN4Q
         1TJQ==
X-Gm-Message-State: ABy/qLYh7noAZuTG/f+J+EgrvsuMVQuWOIaSfesCr6rc++R45O7Lw/eZ
        GQxrEB8260s6rfCed+DUOFHIynBT87q3NGLo+r+NyQ==
X-Google-Smtp-Source: APBJJlF+/Mer4asnYDOi1Z2fZgD4qhRhJV5X1fI+Mt3Z+R6CtLdrmsgjVXdUNNYIMRbvUQc7u4fz1g==
X-Received: by 2002:a05:6358:9995:b0:131:46b:3953 with SMTP id j21-20020a056358999500b00131046b3953mr12700100rwb.13.1689050204573;
        Mon, 10 Jul 2023 21:36:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b9de67285dsm755259plb.156.2023.07.10.21.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:36:44 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     me@jcix.top, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 5/5] docs: fuse: improve FUSE consistency explanation
Date:   Tue, 11 Jul 2023 12:34:05 +0800
Message-Id: <20230711043405.66256-6-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 Documentation/filesystems/fuse-io.rst | 32 +++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fuse-io.rst b/Documentation/filesystems/fuse-io.rst
index 255a368fe534..cdd292dd2e9c 100644
--- a/Documentation/filesystems/fuse-io.rst
+++ b/Documentation/filesystems/fuse-io.rst
@@ -10,6 +10,10 @@ Fuse supports the following I/O modes:
 - cached
   + write-through
   + writeback-cache
+  + writeback-cache-v2
+
+Direct-io Mode
+==============
 
 The direct-io mode can be selected with the FOPEN_DIRECT_IO flag in the
 FUSE_OPEN reply.
@@ -17,6 +21,9 @@ FUSE_OPEN reply.
 In direct-io mode the page cache is completely bypassed for reads and writes.
 No read-ahead takes place. Shared mmap is disabled.
 
+Cached Modes and Cache Coherence
+================================
+
 In cached mode reads may be satisfied from the page cache, and data may be
 read-ahead by the kernel to fill the cache.  The cache is always kept consistent
 after any writes to the file.  All mmap modes are supported.
@@ -24,7 +31,8 @@ after any writes to the file.  All mmap modes are supported.
 The cached mode has two sub modes controlling how writes are handled.  The
 write-through mode is the default and is supported on all kernels.  The
 writeback-cache mode may be selected by the FUSE_WRITEBACK_CACHE flag in the
-FUSE_INIT reply.
+FUSE_INIT reply. In either modes, if the FOPEN_KEEP_CACHE flag is not set in
+the FUSE_OPEN, cached pages of the file will be invalidated immediatedly.
 
 In write-through mode each write is immediately sent to userspace as one or more
 WRITE requests, as well as updating any cached pages (and caching previously
@@ -38,7 +46,27 @@ reclaim on memory pressure) or explicitly (invoked by close(2), fsync(2) and
 when the last ref to the file is being released on munmap(2)).  This mode
 assumes that all changes to the filesystem go through the FUSE kernel module
 (size and atime/ctime/mtime attributes are kept up-to-date by the kernel), so
-it's generally not suitable for network filesystems.  If a partial page is
+it's generally not suitable for network filesystems (you can consider the
+writeback-cache-v2 mode mentioned latter for them).  If a partial page is
 written, then the page needs to be first read from userspace.  This means, that
 even for files opened for O_WRONLY it is possible that READ requests will be
 generated by the kernel.
+
+Writeback-cache-v2 mode (enabled by the FUSE_WRITEBACK_CACHE_V2 flag) retains
+the dirty page management logic of the writeback-cache mode, which provides
+great write performance.  Furthermore, the v2 mode improves cache coherence for
+multiple FUSE mounts scenarios, especially for network filesystems. The kernel
+a/c/mtime and size attributes are allowed to be updated from the filesystem
+either on timeout or when they have been explicitly invalidated. Meanwhile, if
+ever updated by kernel locally, the attributes will not be propagated to the
+filesystem. In other words, the filesystem rather than kernel is considered the
+official source for generating these attributes.
+
+By combining the writeback-cache-v2 mode with the appropriate open flags
+(FOPEN_KEEP_CACHE and FOPEN_INVAL_ATTR for keeping page cache and invalidating
+attributes on FUSE_OPEN respectively), filesystems are able to implement the
+close-to-open (CTO) consistency semantics, which is widely supported by NFS
+client implementations. This allows for maintaining the writeback manner of
+dirty pages while ensuring cache coherence of attributes and file data if the
+operations among different FUSE mounts on a file are properly serialized by
+users using the open-after-close manner.
-- 
2.20.1

